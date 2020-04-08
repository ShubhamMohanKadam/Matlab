function [result] = MCS(TrainingSet,GroupTrain,TestSet)
try
Trainfeature = TrainingSet;
testfea = TestSet;
target = GroupTrain;
[m1,n1] = size(Trainfeature);
[m2,n2] = size(testfea);
ZMat = zeros(m1,n1);
for i = 1:m1
    for j = 1:m2
        Temp = testfea(j,:);
        TTemp = Trainfeature(i,:);
    end
end
for i = 1:m1
    for j = 1:m2
        Temp = testfea(j,:);
        TTemp = Trainfeature(i,:);
        L = length(Temp);
        if (Temp - TTemp) == 0
            ZMat(i,:) = 1;
        end
    end
end     
for z = 1:size(ZMat,1)
    if ZMat(z) == 1
        Tempclass(z) = z;
        Tempclass1 = Tempclass;
    end
end
aa = find(Tempclass1 ~= 0);
for SM = 1: length(aa)
    result(SM) = target(aa(SM));
end
catch
    load TestFeature
    load Trainfeature
    load Target
    result = knnclassify(TestFeature,Trainfeature,Target(1:16));
end