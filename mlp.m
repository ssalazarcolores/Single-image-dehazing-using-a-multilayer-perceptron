function [transmission_f] = mlp(trans_input,delta)
win_size=16;
[a1, b1]=size(trans_input);
trans_input2 = (padarray(trans_input,[win_size win_size],'replicate','post')-0.5)*0.2;
transmission_f=double(ones(size(trans_input2))-0.5)*0.2;

[a, b]=size(trans_input2);

a=a-win_size-delta+2;
b=b-win_size-delta+2;

cnt=0;
i=1;
while(i<=a)
    j=1;
    while(j<=b)
        j=j+delta;
        cnt=cnt+1;
    end
    i=i+delta;
end

vector_test=zeros(win_size^2,cnt);

cnt=0;
i=1;
while(i<=a)
    j=1;
    while(j<=b)
        cnt=cnt+1;
        vector_test(:,cnt)=reshape(trans_input2(i:i+win_size-1,j:j+win_size-1)',win_size^2,1);
        j=j+delta;
    end
    i=i+delta;
end

struct_red =load('neural_network.mat');
neural_net = struct_red.net;

vector_result=sim(neural_net,vector_test);


cnt=0;
i=1;
while(i<=a)
    j=1;
    while(j<=b)
        cnt=cnt+1;
            transmission_f(i:i+win_size-1,j:j+win_size-1) = min(reshape(vector_result(:,cnt),win_size,win_size)', transmission_f(i:i+win_size-1,j:j+win_size-1));
        j=j+delta;
    end
    i=i+delta;
end

transmission_f= ((transmission_f/.20)+0.5);
transmission_f =transmission_f(1:a1,1:b1);

end