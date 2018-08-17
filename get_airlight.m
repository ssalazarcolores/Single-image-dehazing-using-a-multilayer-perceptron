function airlight = get_airlight(imagen)
strel1=strel('square',16);
mc=min(imagen,[],3);
canal_oscuro =imerode(mc,strel1);%it is a morphological equivalent way to calculate the dark channel (faster in matlab)
[m, n, ~] = size(imagen);
n_pixels = m * n;
n_pixels_to_search = floor(n_pixels * 0.01);
vec_dark = reshape(canal_oscuro, n_pixels, 1);
vec_im = reshape(imagen, n_pixels, 3);
[~, index] = sort(vec_dark, 'descend');
accumulator = zeros(1, 3);

for k = 1 : n_pixels_to_search
    accumulator = accumulator + vec_im(index(k),:);
end

airlight = accumulator / n_pixels_to_search;

end