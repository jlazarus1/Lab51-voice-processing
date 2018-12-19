%% Q5 PART A
N = 120;
n = 1:N;
L = 40;

x = dirac(mod(n,10));
x(x > 0)=1;
IRR = [1 -0.8];

x_1 = x(1:L);
x_2 = x(L+1 :2*L);
x_3 = x(2*L+1 : N);

x_filtered   = filter(1,IRR,x);
x_1_filtered = filter(1,IRR,x_1);
x_2_filtered = filter(1,IRR,x_2);
x_3_filtered = filter(1,IRR,x_3);

x_uni_filtered = [x_1_filtered x_2_filtered x_3_filtered];

figure(1);
subplot(2,1,1);
plot(x_filtered);
title("x filtered")
xlabel("k")
ylabel("x")

subplot(2,1,2);
plot(x_uni_filtered);
title("x uni filtered")
xlabel("k")
ylabel("x_{concatenated}")

%% PART B

[x_filtered_b  , z1] = filter(1,IRR,x, 0);
[x_1_filtered_b, z2] = filter(1,IRR,x_1);
[x_2_filtered_b, z3] = filter(1,IRR,x_2,z2);
[x_3_filtered_b, z4] = filter(1,IRR,x_3,z3);

x_uni_filtered_b = [x_1_filtered_b x_2_filtered_b x_3_filtered_b];

figure(2);
subplot(2,1,1);
plot(x_filtered_b);
title("x filtered ")
xlabel("k")
ylabel("x")


subplot(2,1,2);
plot(x_uni_filtered_b);
title("x uni filtered with fix")
xlabel("k")
ylabel("x_{concatenated}")

%% Question 6
n = 1:120;
x=((n/10) == round(n/10));
figure; stem(x)


