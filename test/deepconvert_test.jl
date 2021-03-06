@mkdeepconvert(convfloat, float)
@test convfloat( :(1//4) ) == 0.25
@test convfloat( :(1//4 + 0) ) == 0.25
@test convfloat("2^63") == 9.223372036854776e18

@mkdeepconvert(conv128a, int128)
resa = conv128a(:( 1//4 ))
@test  resa == 0
@test typeof(resa) == Int128

@mkdeepconvert1(conv128b, int128)
resb = conv128b(:( 1//4 ))
@test resb == 1 // 4
@test typeof(resb) == Rational{Int128}

@test conv128a( :( 2^64 )) == int128(2)^64
@test conv128b( :( 2^64 )) == int128(2)^64

@test conv128a( :( 2^64 + 2^17 )) == int128(2)^64 + 2^17

@test conv128a(1) == 1
@test typeof(conv128a(1)) == Int128
@test conv128a("1") == 1
@test typeof(conv128a("1")) == Int128
@test conv128a(1) == 1
@test typeof(conv128a(1)) == Int128
@test conv128a("2^63") == int128(2)^63
aa = BigInt[BigInt(2)^64,BigInt(2)^63]
@test aa == bi"[2^64,2^63]"

@test bi"(10^53 - 1) // 9"  == (BigInt(10)^53-1)//9

@test bf"1e-50+1" == BigFloat("1e-50") + BigFloat(1)

@bigint function gg(x)
              2^64 * x
        end
y = gg(1.0)
@test typeof(y) == BigFloat
@test y > 0

@test typeof( @bigint 111111111111111111111111111) == BigInt
@test typeof( @bigint(111111111111111111111111111 + 8)) == BigInt
@test typeof(1111111111111111111111111 // 3) == Rational{Int128}
@test typeof(@bigint(1111111111111111111111111 // 3)) == Rational{BigInt}

@test typeof(@int128( 23432432 // 3)) == Rational{Int128}

@test (BigFloat(1) * BigFloat(10)^-10 -  @bigfloat 1/10^10) == 0

a = parse("1+1")
@test deepbigfloat(a) == BigFloat(2)
@test deepbigfloat("1+1") == BigFloat(2)
