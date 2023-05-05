%% constants
num_bits = 10;
num_of_samples = 10;


%% generate random bits
random_Indices = randperm(num_bits, num_bits/2);
array= ones(num_bits,1);
array(random_Indices)=-1;

array(1)=-1;
array(2)=-1;
array(3)=1;
array(4)=1;
array(5)=-1;
array(6)=-1;
array(7)=-1;
array(8)=-1;
array(9)=1;
array(10)=1;
% range of SNR
snr_range = -10:1:20;
%% receive with matched filter
filter_matched = ones(1,num_of_samples);
energy=1;

for i = 1:length(snr_range)
   snr = 10 ^(snr_range(i)/10);
   signal_with_noise_1=noise(num_bits,num_of_samples,array,energy/(2.0*snr));
   [filtered_samples_1,filtered_bits_1]=applay_filter(num_bits,num_of_samples,signal_with_noise_1,filter_matched);
end
% ploting
out_1 = reshape(filtered_bits_1, [], 1);
figure(1)
t1 = 1:(length(out_1));
plot(t1,  out_1)
title('output from matched filter')
xlabel('time (ms)')
ylabel('recieve filter output (bit value)')

%% receive with no filter
filter_no_filter = zeros(1,num_of_samples);
filter_no_filter(num_of_samples/2)=10;
for i = 1:length(snr_range)
   snr = 10 ^(snr_range(i)/10);
   signal_with_noise_2=noise(num_bits,num_of_samples,array,energy/(2.0*snr));
   [filtered_samples_2,filtered_bits_2]=applay_filter(num_bits,num_of_samples,signal_with_noise_2,filter_no_filter);
end
% ploting
out_2 = reshape(filtered_bits_2, [], 1);
figure(2)
t2 = 1:(length(out_2));
plot(t2,  out_2)
title('output from no filter')
xlabel('time (ms)')
ylabel('recieve filter output (bit value)')

% receive with tringle
t3 = 0:1: 10 - 1;
filter_tringle =(1.732 / 10) * t3;
for i = 1:length(snr_range)
   snr = 10 ^(snr_range(i)/10);
   signal_with_noise_3=noise(num_bits,num_of_samples,array,energy/(2.0*snr));
   [filtered_samples_3,filtered_bits_3]=applay_filter(num_bits,num_of_samples,signal_with_noise_3,filter_tringle);
end
% ploting
out_3 = reshape(filtered_bits_3, [], 1);
figure(3)
t3 = 1:(length(out_3));
plot(t3,  out_3)
title('output from tringle filter')
xlabel('time (ms)')
ylabel('recieve filter output (bit value)')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_bits_2 = 100000;
random_Indices_2 = randperm(num_bits_2, 1);
array_2= ones(num_bits_2,1);
array_2(random_Indices_2)=-1;
BER_experimental_1=zeros(length(snr_range),1);
BER_theortical_1 =zeros(length(snr_range),1);
BER_experimental_2=zeros(length(snr_range),1);
BER_theortical_2 =zeros(length(snr_range),1);
BER_experimental_3=zeros(length(snr_range),1);
BER_theortical_3 =zeros(length(snr_range),1);
for i = 1:length(snr_range)
    snr = 10 ^(snr_range(i)/10);
    signal_with_noise=noise(num_bits_2,num_of_samples,array_2,energy/(2.0*snr));
    [filtered_samples_1,filtered_bits_1]=applay_filter(num_bits_2,num_of_samples,signal_with_noise,filter_matched);
    [filtered_samples_2,filtered_bits_2]=applay_filter(num_bits_2,num_of_samples,signal_with_noise,filter_no_filter);
    [signal_with_noise_3,filtered_bits_3]=applay_filter(num_bits_2,num_of_samples,signal_with_noise,filter_tringle);
    BER_experimental_1(i)=simulated_BER(array_2,filtered_samples_1);
    BER_experimental_2(i)=simulated_BER(array_2,filtered_samples_2);
    BER_experimental_3(i)=simulated_BER(array_2,signal_with_noise_3);
    BER_theortical_1(i)=0.5*erfc(sqrt(snr));
    BER_theortical_2(i)=0.5*erfc(sqrt(snr));
    BER_theortical_3(i)=0.5*erfc((sqrt(3)/(2)*sqrt(snr)));
end

figure(4)

semilogy(snr_range, BER_theortical_1, 'b-')
hold on
semilogy(snr_range, BER_experimental_1, 'm--')
% xlabel('SNR (dB)')
% ylabel('Bit Error Rate (BER)')
% legend('theoretical 1', 'Simulated (filter 1)')
% figure(5)

hold on
semilogy(snr_range, BER_theortical_2, 'r:')
hold on
semilogy(snr_range, BER_experimental_2,'g--')
% xlabel('SNR (dB)')
% ylabel('Bit Error Rate (BER)')
% legend('theoretical 2', 'Simulated (filter 2)')

% figure(6)
hold on
semilogy(snr_range, BER_theortical_3, 'c--')
hold on
semilogy(snr_range, BER_experimental_3,'y--')
hold off
ylim([10^-4 0.5])
xlabel('SNR (dB)')
ylabel('Bit Error Rate (BER)')
legend('theoretical 1','Simulated (filter 1)','theoretical 2',  'Simulated (filter 2)','theoretical 3','Simulated (filter 3)')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% utilts 
%% add noise to signal
%it is expanding generated_bits so each sample change to train of pulses to discretization the pulse
%then adding gussian noise for expanded array.
function [signal_with_noise] = noise(num_of_bits,num_of_samples,indx,sigma)
   X = normrnd(0, sqrt(sigma), [1,num_of_bits*num_of_samples]);
   signal_with_noise = ones(length(indx), num_of_samples);
   
   for i= 1:(length(indx))
        signal_with_noise(i, :) =signal_with_noise(i, :)* indx(i); 
        signal_with_noise(i, :) = signal_with_noise(i, :)+X((num_of_samples)*(i-1)+1:(num_of_samples)*(i));
   end
end
%% applay Filter
% it calculates convolution for received_filter and each sample
function [result_sampled,result] = applay_filter(num_bits,num_of_samples,signal_with_noise,filter)
    result_sampled = zeros(num_bits,1);
    signal_with_noise_reshape=reshape(signal_with_noise.',1,[]);
    result = conv(signal_with_noise_reshape, filter);
    for i=0:(num_bits-1)
        result_sampled(i+1) = result((num_of_samples - 1) + num_of_samples * i+1);
    end
end
%% calcute simulated BER
% it calculates convolution for received_filter and each sample
function [BER_value] = simulated_BER(true_values,result)

  %  result_reshape=reshape(result.',1,[]);
    received_samples = ones(size(true_values));
    received_samples = received_samples + (-2 * (result < 0));
    error_probability = sum(received_samples ~= true_values);
    BER_value = error_probability / size(true_values, 1);
end

% ?Q5:
% BER is decreasing function of ?/??
% because by increasing ?/?? we increase the transmitted energy related to noise energy. The transmitted signal was not 
% significantly impacted by noise. but if noise energy close to transmitted energy then noise easily destroy the signal

% Q6:
% matched filter has the lowest BER 
% because of multipling high values in signal by high values in filter than in thrsholding step then you can easly detect it is high value,
% the same thing to low values
% but other filter doesn't multply signal values with suitable values 
