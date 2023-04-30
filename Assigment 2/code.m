%% initial
% array filled with zeros size of 10000
size_array=10000;
array = zeros(1, size_array);
% create 5000 random index
random_Indices = randperm(size_array, 5000);
array(random_Indices)=1;

%% g array of size 10 times the size of array
g = 10 * zeros(1, size_array);

for i = 1:length(array)
    if(array(i)==1)
       g(10*(i-1)+1:10*i)=1;
    else
       g(10*(i-1)+1:10*i)=-1;
    end
end

%% SNR
% range of SNR
snr_range = -10:1:20;
% create signals_noise array
signals_noise = zeros(length(g), length(snr_range));
% add noise
for i = 1:length(snr_range)
    signals_noise(:,i) = awgn(g, snr_range(i), 'measured');
end


%% The receive filters
% The receive filter ?(?) is a matched filter with unit energy 
filter_1 = ones(10, 1);  


% The receive filter ?(?) is not existent (i.e. ?(?) = ?(?))
filter_2 = zeros(10, 1); 
filter_2(1) = 10; 


% The receive filter ?(?) has the following impulse response
filter_3 = zeros(10, 1);
% slope of the line
slope = (sqrt(3) - 0) / (10 - 0);
for x = 1:10
    filter_3(x ) = slope * x; % store value in specific index in filter 3
end

% applay each filter to noice signal
signals_filters = zeros(length(g), length(snr_range), 3);
for i = 1:length(snr_range)
    
    % Convolve with filter 1
    signals_filters(:,i,1) = conv(signals_noise(:,i), filter_1, 'same');

    % Convolve with filter 2
    signals_filters(:,i,2) = conv(signals_noise(:,i), filter_2, 'same');

    % Convolve with filter 3 
    signals_filters(:,i,3) = conv(signals_noise(:,i), filter_3, 'same');
end

figure(1)
t1 = 1:(size_array*10);
plot(t1,  signals_filters(:,i,1))
title('h(t)= unit energy')
xlabel('time (ms)')
ylabel('recieve filter output')
figure(2)
plot(t1,  signals_filters(:,i,2))
title('h(t)= not existent')
xlabel('time (ms)')
ylabel('recieve filter output')
figure(3)
plot(t1,  signals_filters(:,i,3))
title('h(t)= triangle shape')
xlabel('time (ms)')
ylabel('recieve filter output')
%% sampling
% Sample the signals after applaying 3 filters
samples= zeros(length(array), length(snr_range), 3);
for i = 1:length(snr_range)
    for z = 1:3
        signal_filters = signals_filters(:,i,z);
        samples(:,i,z) = signal_filters(5:10:end);
    end
end
% Decode 
Signals_output = zeros(length(g)/10, length(snr_range), 3);
Signals_output(samples >= 0) = 1;
Signals_output(samples < 0) = 0;

%% Calculate the theoretical and simulated BERs
bits_num = length(g)/10;
% Calculate theoretical BER
BER_theoretical_1 = zeros(1,length(snr_range));
BER_theoretical_2 = zeros(1,length(snr_range));
BER_theoretical_3 = zeros(1,length(snr_range));
for i = 1:length(snr_range)
     BER_theoretical_1(i)= erfc(sqrt(10^(snr_range(i)/10))^0.5);
     BER_theoretical_2(i)=BER_theoretical_1(i);
    BER_theoretical_3(i)= erfc((3^0.5/2) *sqrt(10^(snr_range(i)/10))^0.5);
end
% Calculate simulated BER
BER_simulated = zeros(length(snr_range), 3);
for i = 1:length(snr_range)
    for j = 1:3
        error = sum(xor(Signals_output(:,i,j)', array));
        BER_simulated(i,j) = error/bits_num;
    end
end

% % Plot the theoretical and simulated BERs vs SNR
figure

semilogy(snr_range, BER_theoretical_1, 'y-o')
hold on
semilogy(snr_range, BER_theoretical_2, 'b-o')
hold on
semilogy(snr_range, BER_theoretical_3, 'c-o')
hold on
semilogy(snr_range, BER_simulated(:,1), 'r-o')
hold on
semilogy(snr_range, BER_simulated(:,2), 'g-o')
hold on
semilogy(snr_range, BER_simulated(:,3), 'm-o')
hold off
xlabel('SNR (dB)')
ylabel('Bit Error Rate (BER)')
legend('theoretical 1','theoretical 2','theoretical 3', 'Simulated (filter 1)', 'Simulated (filter 2)', 'Simulated (filter 3)')


