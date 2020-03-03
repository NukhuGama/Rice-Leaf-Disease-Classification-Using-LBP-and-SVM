%figure out the pad value to pad to white
if isinteger(YourImage)
   pad = intmax(class(YourImage));
else
   pad = 1;   %white for floating point is 1.0
end
%figure out which dimension is longer and rescale that to be the 256
%and pad the shorter one to 256
[r, c, ~] = size(YourImage)
if r > c
  newImage = imresize(YourImage, 256 / r);
  NewImage(:, end+1 : 256, :) = pad;
elseif c > r
  newImage = imresize(YourImage, 256 / c);
  NewImage(end+1 : 256, :, :) = pad;
else
  newImage = imresize(YourImage, [256, 256]);
end