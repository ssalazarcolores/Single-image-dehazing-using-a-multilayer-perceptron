function [recovered_image ] = dehaze( image, omega, delta )


if ~exist('omega', 'var')
    omega = 0.7;
end
if ~exist('delta', 'var')
    delta = 8;
end

airlight = get_airlight(image);
initial_trans = get_transmission_estimate(image, airlight, omega);
final_trans =  mlp(initial_trans,delta);

recovered_image = recover_image(image, final_trans, airlight);

% Apply a contrast stretching  to Luminance
srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');
tmp_image = applycform(recovered_image, srgb2lab);
max_luminosity = 100;
L = tmp_image(:,:,1)/max_luminosity;
recovered_image = tmp_image;
recovered_image(:,:,1) = imadjust(L)*max_luminosity;
recovered_image = applycform(recovered_image, lab2srgb);


figure(1)
subplot(2,2,1)
imagesc(image);
title('Input image')
axis off
subplot(2,2,2)
imagesc(recovered_image);
title('Recovered image')
axis off
subplot(2,2,3)
imagesc(ind2rgb(uint8(initial_trans*255), jet(256)));
title('Initial transmission')
axis off
subplot(2,2,4)
imagesc(ind2rgb(uint8(final_trans*255), jet(256)));
title('MLP estimated transmission')
axis off

end

