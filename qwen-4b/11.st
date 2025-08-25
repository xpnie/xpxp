% Implementing the Sign Function
%
%  INPUTS:
%  - x          : Real Number
%
%  OUTPUTS:
%  - y          : Complex Number
%
%  RETURN VALUES:
%  - r           : The real part of the complex number y.
%  - i           : The imaginary part of the complex number y.
%

VAR_INPUT = {
    "x" : REAL(0.5))
};

VAR_INPUT = VAR_INPUT["x"];

END_VAR = REAL(1.0));

function sign(x)
{
    real_part := x;
    imag_part := 0;
    y := real_part + i * imag_part;
    return y;
}
sign(x);