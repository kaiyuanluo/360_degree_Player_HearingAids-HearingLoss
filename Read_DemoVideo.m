[Sample, FS] = audioread('Demo_DONE1_1.wav');
info = audioinfo('Demo_DONE1_1.wav');

% Extract and write each column from 17 to 41
for i = 17:41
    columnData = Sample(:, i);
    filename = sprintf('demo%d.wav', i);  % Generate filename
    audiowrite(filename, columnData, FS);
end
