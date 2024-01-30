%% this m-file perfrmes small-signal analysis

smib_run
% x is an example for a Lead-Lag PSS parameters.
x = [21.0288132641279,0.267005856628443,0.0936148893555018,0.364845193189570,0.767241197921496];

KG = x(1);
Tw = 10;
T1 = x(2);
T2 = x(3);
T3 = x(4);
T4 = x(5);
Kpss = KG*T1*T3/(T2*T4);

%% Linearize Power System
% f11=linmod('smib_IO');
f11=linmod('smib_PSS');

% dx/dt = A.x + B.u
% y = C.x + D.u

Asys = f11.a ;
Bsys = f11.b ;
Csys = f11.c ;
Dsys = f11.d ;

%% Calculate Eigenvalues
egs = eig(Asys)
Ns = length(egs);

Damp = -real(egs)./sqrt(real(egs).^2+imag(egs).^2)
freq = abs(imag(egs))/(2*pi)

%% calculae Participation Factors
[Vs,D_eig] = eig(Asys);
Ws=inv(Vs);
for i=1:Ns
    for k=1:Ns
        Pfact1(k,i)=abs(Vs(k,i))*abs(Ws(i,k));
    end
end

for i=1:Ns
     Pfact(i,:)=Pfact1(i,:)/sum(Pfact1(i,:));
end

for i=1:Ns
    [s_val s_idx] = sort(Pfact(:,i),'descend');
    mod_idx(i,:) = s_idx(1:4)';
    pf_fact(i,:) = s_val(1:4)';
end
mod_idx;
pf_fact;
