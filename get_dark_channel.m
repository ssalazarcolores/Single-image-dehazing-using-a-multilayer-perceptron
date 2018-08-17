function dc = get_dark_channel(image, patch_size)

[m, n, ~] = size(image);

pad_size = floor(patch_size/2);

padded_image = padarray(image, [pad_size pad_size], Inf);
dc = zeros(m, n); 
for j = 1 : m
    for i = 1 : n
        patch = padded_image(j : j + (patch_size-1), i : i + (patch_size-1), :);
        dc(j,i) = min(patch(:));
     end
end

end