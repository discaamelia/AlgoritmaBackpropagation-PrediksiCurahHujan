clc;clear;close all;
 
% load jaringan yang sudah dibuat pada proses pelatihan
load net.mat
 
% Proses membaca data uji dari excel
filename = 'tablee.xlsx';
sheet = 4;
xlRange = 'B3:N14';
 
Data = xlsread(filename, sheet, xlRange);
data_uji = Data(:,1:12)';
target_uji = Data(:,13)';
[m,n] = size(data_uji);
 
% Hasil prediksi
hasil_uji = sim(net_keluaran,data_uji);
nilai_error = hasil_uji-target_uji;
 
max_data = 13261.82031;
min_data = 7056.47998;
hasil_uji = ((hasil_uji-0.1)*(max_data-min_data)/0.8)+min_data;
 
% Performansi hasil prediksi
error_MSE = (1/n)*sum(nilai_error.^2);
 
filename = 'tablee.xlsx';
sheet = 2;
xlRange = 'E12:P12';
 
target_uji_asli = xlsread(filename, sheet, xlRange);
 
figure,
plot(hasil_uji,'bo-')
hold on
plot(target_uji_asli,'ro-')
hold off
grid on
title(strcat(['Grafik Keluaran BPNN & Target dengan nilai MSE = ',...
num2str(error_MSE)]))
xlabel('Pola ke-')
ylabel('Curah Hujan')
legend('Keluaran BPNN','Target','Location','Best')
