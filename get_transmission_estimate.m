function transmission = get_transmission_estimate(image, airlight, omega)
[a, b, ~] = size(image);
airlight_mask = repmat(reshape(airlight, [1, 1, 3]), a, b);
transmission =1-omega * min((image./ airlight_mask),[],3);
end