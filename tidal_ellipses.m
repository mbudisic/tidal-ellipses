function h = tidal_ellipses( X, Y, U, V, scale, normalize, varargin )
% TIDAL_ELLIPSES Visualize complex-valued velocity field oscillating at
% angular frequency omega using tidal ellipses.

separate=false; %% if true, create separate object for each ellipse

in_third = @(M)permute(M(:),[3,2,1]);
X = in_third(X);
Y = in_third(Y);
U = in_third(U);
V = in_third(V);

Npts = numel(X);

M = [real(U), -imag(U); real(V), -imag(V)];

ts = 2*pi*linspace(0,0.9,10);
pts = [ [0:0.5:1; zeros(1,3)], [cos(ts); sin(ts)] ];
pts = repmat(pts, [1,1,size(M,3)]);

if normalize
    operate = @(mm,offset,inp)scale*mm*inp./norm(mm,2) + offset;
else
    operate = @(mm,offset,inp)scale*mm*inp + offset;
end
for k = 1:Npts
    
    pts(:,:,k) = operate( M(:,:,k),[X(k); Y(k)],  pts(:,:,k) );
    
end

xpts = squeeze( pts(1,:,:) );
ypts = squeeze( pts(2,:,:) );

if separate
    h = plot( xpts , ypts , varargin{:}  );
else
    xpts(end+1,:) = nan;
    ypts(end+1,:) = nan;
    
    h = plot( xpts(:) , ypts(:) , varargin{:}  );
end
