ChipRate = 64e3;
SPS = 5;

prn0 = GoldCodeGen(2);
prn1 = GoldCodeGen(3);

message = 'abc123';

bits = SpriteFECEncoder(message);

baseband = SpriteModulator(bits,prn0,prn1,SPS);

length(baseband)/320e3

write_complex_binary(baseband, 'HILTestData.dat');