function rba()

  % Base functions examples:
  %   - (exp(1))^(-((beta*r)^2));
  %   - r^3;
  %   - sqrt(1 + (beta*r).^2);

  
  clear;
  clc;
  dataset = importdata('dataset0.mat');
  
  % Test
  xv = dataset.xv; 
  yv = dataset.yv;
  nv = dataset.Nv; % elements
  fv = dataset.fv; % altitude

  % Input
  xt = dataset.xt; 
  yt = dataset.yt;
  nt = dataset.Nt; % elements
  ft = dataset.ft; % altitude

  xmin = 0;
  xmax = 3;
  ymin = -3;
  ymax = 1;
  
  beta = 1.5;
 
  matrix = zeros(nt,2);
  for i = 1:nt
    matrix(i,1) = xt(i);
    matrix(i,2) = yt(i);
  end
  
  phi = zeros(nt,nt);
  
  for i = 1:nt
      for j = 1:nt
          vector = matrix(i,:) - matrix(j,:);
          norm_ = norm(vector);
          phi(i,j) = (exp(-((beta*norm_)^2)));
      end
  end
  
  a = inv(phi) * ft;

  x = xmin:0.075:xmax;
  y = ymin:0.1:ymax;
  [X,Y] = meshgrid(x,y);
  
  Z = zeros(size(X, 1), size(Y, 1));
  for i = 1:size(X,1)
    for j = 1:size(Y,1)
      Z(i, j) = 0;
      for m = 1:nt
        norm_ = norm([X(i, j), Y(i, j)] - matrix(m,:));
        Z(i, j) = Z(i, j) + a(m) * (exp(1))^(-((beta(1)*norm_)^2));
      end
    end
  end

  figure
  mesh(X, Y, Z);
  
  err = zeros(nv, 1);
  mean_err = 0;
  for i = 1:nv
      test = 0;
      for m = 1:nt
        vector = [xv(i), yv(i)] - matrix(m,:);
        norm_ = norm(vector);
        test = test + a(m) * (exp(-((beta(1)*norm_)^2)));
      end
      err(i) = norm(fv(i) - test);
      mean_err = mean_err + err(i);
  end
  
  max_err = max(err(:))
  mean_err = 1/nv * mean_err
 
end
