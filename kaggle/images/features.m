% load data
load('X.mat');

% Take transpose to facilitate matrix multiplication
X=X';

% Normalize each image by subtracting mean and dividing by variance
for i=1:size(X,2)
X(:,i)=(X(:,i)-mean(X(:,i)))/(std(X(:,i))+.00001);
end

% specify the number of hidden neurons/units
% initialize weight matrix and bias vectors
hidden_size=15*15;
input_size=size(X,1);
W=.001*randn(hidden_size,input_size);
b=zeros(hidden_size,1);
bT=zeros(input_size,1);
% a good initial guess for bias is the mean
for i=1:input_size
    bT(i)=mean(X(i,:));
end

% keep track of error (cost) function
cost=zeros(1,1);

% do gradient descent in batches of 400 images
batch_size=400;

% do many iterations of gradient descent
for k=1:10000
    count=k;
    
    % sample a batch
    index=randsample(size(X,2),batch_size,false);
    xt=X(:,index);
    
    % compute derivatives of error function with respect to
    % the weight matrix and bias vectors
    [xp dW db dbT]=autoenc_drop(xt,W,b,bT);
    
    % compute error
    E=xp-xt;
    cost(count)=.5*sum(E(:).^2)/batch_size;
    cost(count)=cost(count)^.5;
    
    % do one step of gradient descent
    W=W-.001*dW;
    b=b-.001*dbT;
    bT=bT-.001*db;
    
    % every 1000 iterations visualize image reconstruction
    % and  weight filters
    if(round(count/1000)==(count/1000))
        plot_figures(W,X,b,bT,count,cost)
    end
end

% output hidden layer neuron values as new features
Xnew=W*X;
Xnew=Xnew+repmat(b,1,size(X,2));
Xnew=Xnew';

% write new features to a file
csvwrite('new_features.csv',Xnew);
