% difining the signal
x = -6:0.01:6;
t = -fix(length(x)/2):1:fix(length(x)/2);


% req3 a: quantized signal when midrise algorithm used
encoded_signal = UniformQuantizer(x, 3, 6, 0);
quantized_signal = UniformDequantizer(encoded_signal, 3, 6, 0);

figure(1);
subplot(1,1,1);
plot(t,x,'--',t,quantized_signal)
title('mid rise');
xlabel 'domain';
ylabel 'signal';
legend({'signal','quantized signal'},'Location','southeast')
grid on


% req3 b: quantized signal when midtread algorithm used
encoded_signal = UniformQuantizer(x, 3, 6, 1);
quantized_signal = UniformDequantizer(encoded_signal, 3, 6, 1);

figure(2);
subplot(1,1,1);
plot(t,x,'--',t,quantized_signal)
title('mid thread');
xlabel 'domain';
ylabel 'signal';
legend({'signal','quantized signal'},'Location','southeast')
grid on


% req4: generate a uniform rendom signal 
random_signal = random('Uniform',-5, 5,1, 10000);

% calculate SNR for the uniform random signal using midrise and n_bits [2:8]

% SNR_exp_arr = zeros(7);
% SNR_th_arr = zeros(7);
SNR_exp_arr = [];
SNR_th_arr = [];
for i=2:8 % n_bits from 2:8
    encoded_signal = UniformQuantizer(random_signal, i, 5, 0);
    quantized_signal = UniformDequantizer(encoded_signal, i, 5, 0);
    [SNR_exp, SNR_th] = SNR(random_signal, quantized_signal, i, 0, max(abs(random_signal)));
    % SNR_exp_arr(i-1) = SNR_exp;
    % SNR_th_arr(i-1) = SNR_th;
    SNR_exp_arr = [SNR_exp_arr SNR_exp];
    SNR_th_arr = [SNR_th_arr SNR_th];
end
figure(3);
subplot(1,1,1);
n = 2:1:8;
plot(n,mag2db(SNR_exp_arr),n,mag2db(SNR_th_arr),'--')
title('SNR uniform signal');
xlabel 'number of bits';
ylabel 'SNR';
legend({'expremintal','theoritical'},'Location','southeast')
grid on


% req5: generate a non uniform rendom signal and test uniform quantizer
size = [1 1000];
exp_signal = exprnd(1,size); 
sin = (randi([0,1],size)*2)-1;
rand_sig = exp_signal.*sin;
max_rand = max(abs(rand_sig));
% SNR_exp_arr = zeros(7);
% SNR_th_arr = zeros(7);
SNR_exp_arr = [];
SNR_th_arr = [];
for i=2:8 
    encoded_signal = UniformQuantizer(rand_sig, i, max_rand, 0);
    quantized_signal = UniformDequantizer(encoded_signal, i, max_rand, 0);
    [SNR_exp, SNR_th] = SNR(rand_sig, quantized_signal, i, 0, max_rand);
    % SNR_exp_arr(i-1) = SNR_exp;
    % SNR_th_arr(i-1) = SNR_th;
    SNR_exp_arr = [SNR_exp_arr SNR_exp];
    SNR_th_arr = [SNR_th_arr SNR_th];
end
figure(4);
subplot(1,1,1);
n = 2:1:8;
plot(n,mag2db(SNR_exp_arr),n,mag2db(SNR_th_arr),'--')
title('SNR non uniform signal');
xlabel 'number of bits';
ylabel 'SNR';
legend({'expremintal','theoritical'},'Location','southeast')
grid on


% req6: generate a non uniform rendom signal and test uniform quantizer
% with different u
size = [1 1000];
exp_signal = exprnd(1,size); 
sin = (randi([0,1],size)*2)-1;
rand_sig = exp_signal.*sin;
u = [0 5 100 200];
figure(5);
subplot(1,1,1);
n = 2:1:8;
colors = ['r','m','k','b'];
index = 1;
hold on
for ele = u
    % SNR_exp_arr = zeros(7);
    % SNR_th_arr = zeros(7);
    SNR_exp_arr = [];
    SNR_th_arr = [];
    y = compressor_block(rand_sig, ele, sin);
    for i=2:8
        encoded_signal = UniformQuantizer(y, i, max(abs(y)), 0);
        quantized_signal = UniformDequantizer(encoded_signal, i, max(abs(y)), 0);
        expanded = expansion_block(quantized_signal, ele, sin);
        if(ele > 0) % we normalized the function in compressor
            expanded = expanded*max(abs(rand_sig));
        end
        [SNR_exp, SNR_th] = SNR(rand_sig, expanded, i, ele, max(abs(rand_sig)));
        % SNR_exp_arr(i-1) = SNR_exp;
        % SNR_th_arr(i-1) = SNR_th;
        SNR_exp_arr = [SNR_exp_arr SNR_exp];
        SNR_th_arr = [SNR_th_arr SNR_th];
    end
    plot(n,mag2db(SNR_exp_arr),colors(index),n,mag2db(SNR_th_arr),strcat(colors(index),'--'));
    index = index +1;
end
title('non uniform quantizer');
xlabel 'number of bits';
ylabel 'SNR';
legend({'u=0 th','u=0 exp','u=5 th','u=5 exp','u=100 th','u=100 exp','u=200 th','u=200 exp'},'Location','southeast')
grid on
hold off


function q_ind = UniformQuantizer(in_val, n_bits, xmax, m)
    delta=(2*xmax)/(2^n_bits);
    xmin = m*(delta/2)-xmax;

    % change values less than xmin to meet xmin in case of mid-tread
    internal_val = xmin .* ones(1,length(in_val));
    cond = (in_val >= xmin); 
    internal_val(cond) = in_val(cond);

    % get the level of each point in the signal
    q_ind = min(floor((internal_val - xmin)/delta)+1 , (2^n_bits));
end

function deq_val = UniformDequantizer(in_val, n_bits, xmax, m)
    delta=(2*xmax)/(2^n_bits);
    x_min = xmax - ((1 - m) * 0.5*delta);
    deq_val = (in_val - (1 - m)) * delta - x_min;
end


function [SNR_exp, SNR_th] = SNR(signal, quantized, n_bits, u, xmax)
    quantization_error = signal - quantized;
    input_power = mean(signal.^2);
    SNR_exp = input_power / mean(quantization_error.^2);
    if(u > 0)
        SNR_th = (3 * (2^n_bits)^2) / (log(1 + u)^2);
    else 
        SNR_th = (3 * (2^n_bits)^2 * input_power) / xmax^2;
    end
end


function compressed = compressor_block(x, u, sin)
    compressed = x;
    if(u>0)
        compressed = sin .* (log(1+u*abs(x/max(x)))/log(1+u));
    end
end


function expanded = expansion_block(x, u, sin)
    expanded = x;
    if(u>0)    
        % inverse of compressed function
        expanded= sin .*(((1+u).^abs(x)-1)/u);
    end
end


