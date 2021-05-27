%制作的一组落月图片，生成结果位置查看末尾代码

close all;
clc;
for x_pix = 434:920
    y_pix = -0.000338 * x_pix^2 + 1.254 * x_pix - 479.4;
    y_pix = round(y_pix);
    src_img = imread('moon.jpg');
    dst_img = imread('mountains.jpg');

    % imwrite(uint8(src_img),'C:\source_image.jpg');
    % imwrite(uint8(dst_img),'C:\destination_image.jpg');

    %%%%figure(1); imshow(uint8(src_img));
    %%%%figure(2); imshow(uint8(dst_img));

    img_width = 95;
    img_height = 90;
    if (x_pix>900)
        src_st_y = 55 - x_pix + 900;
    else
        src_st_y = 55;
    end
    src_st_x = 165; 
    dst_st_x = x_pix; dst_st_y = y_pix;

    % extracted_src_img = zeros(img_width,img_height,3);
    % extracted_dst_img = zeros(img_width,img_height,3);

    extracted_src_img = src_img(src_st_y:src_st_y+img_height,src_st_x:src_st_x+img_width,:);
    extracted_dst_img = dst_img(dst_st_y:dst_st_y+img_height,dst_st_x:dst_st_x+img_width,:);

    [rws,cls] = size(extracted_src_img(:,:,1));

    dst_img_temp = dst_img;
    dst_img_temp(dst_st_y:dst_st_y+img_height,dst_st_x:dst_st_x+img_width,:) = extracted_src_img;
    %%%%figure(3); imshow(uint8(dst_img_temp));
    % imwrite(uint8(dst_img_temp),'C:\simple_cut_and_paste_result.bmp');

    padding_factor = 10;
    padded_src_img = pad_image(extracted_src_img,padding_factor);
    padded_dst_img = pad_image(extracted_dst_img,padding_factor);

    %%%%figure(4); imshow(uint8(padded_dst_img));
    %%%%figure(5); imshow(uint8(padded_src_img));

    temp_result = zeros(rws,cls,3);
    temp_result(:,:,1) = find_result_channel(padded_src_img(:,:,1),padded_dst_img(:,:,1),padding_factor);
    temp_result(:,:,2) = find_result_channel(padded_src_img(:,:,2),padded_dst_img(:,:,2),padding_factor);
    temp_result(:,:,3) = find_result_channel(padded_src_img(:,:,3),padded_dst_img(:,:,3),padding_factor);
    %%%%figure(6); imshow(uint8(temp_result));

    dst_img(dst_st_y:dst_st_y+img_height,dst_st_x:dst_st_x+img_width,:) = temp_result;
    figure(7); imshow(uint8(dst_img));
    name = x_pix - 434;
    %imwrite(uint8(dst_img),'strcat('pic_',num2str(i),'.bmp')')
    imwrite(uint8(dst_img),strcat('.\result3\',num2str(name),'.bmp'));
end 