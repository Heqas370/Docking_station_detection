clear all;
clc;

  filename = "patterns_noise.mat"
  Data = []
  I = load(filename);
  for i=1:35
    for j=1:3
        for h=1:360
            if (I.Data(i).msgStructs{j,1}.Ranges(h) == inf)
                Data(i,h) = 99;
            else
                val = I.Data(i).msgStructs{j,1}.Ranges(h);
                Data(i,h) = val;
            end
            end
       end
    end
save patternData.mat Data
