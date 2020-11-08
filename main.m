clear all
close all
col_num = 224;
raw_num = 224;

path = 'C:/Users/ηρ_2/Desktop/mnist_net/mnist_test_images/testing/5/';
filelist = dir(path);

image = double(imread([path filelist(round(rand*numel(filelist))).name]));

image = image/255;
image = (image - 0.1307) / 0.3081;

sep_conv_1 = separable_conv2d(image, 1, 1, 32);
sep_conv_1(1,1,1)
relu_1 = relu_us(sep_conv_1);
maxpooling_1 = maxpool(relu_1,[2,2]);

sep_conv_2 = separable_conv2d(maxpooling_1, 2, 32, 64);
relu_2 = relu_us(sep_conv_2);
maxpooling_2 = maxpool(relu_2,[2,2]);

sep_conv_3 = separable_conv2d(maxpooling_2, 3, 64, 128);
relu_3 = relu_us(sep_conv_3);
maxpooling_3 = maxpool(relu_3,[2,2]);

sep_conv_4 = separable_conv2d(maxpooling_3, 4, 128, 256);
relu_4 = relu_us(sep_conv_4);
maxpooling_4 = maxpool(relu_4,[2,2]);

flaten1 = flatten(maxpooling_4);
fc_1 = fc(flaten1, 1, 256, 100);
relu_5 = relu_us(fc_1);
fc_2 = fc(relu_5, 2, 100, 10);
res = soft_max(fc_2);
res



