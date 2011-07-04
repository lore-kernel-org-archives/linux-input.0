From: Ari Savolainen <ari.m.savolainen@gmail.com>
Subject: [PATCH] HID: fix horizontal wheel for ms comfort mouse 4500
Date: Mon, 4 Jul 2011 11:59:25 +0300
Message-ID: <CAEbykaXLRazgQhXuZtkhHUw8+eCPNWQ68jsRMZ2E=F6FbmjbUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39993 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab1GDI70 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 04:59:26 -0400
Received: by yxi11 with SMTP id 11so1523127yxi.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 01:59:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Microsoft comfort mouse 4500 has a report descriptor that contains
usage Consumer.HorizontalWheel three times under three different
input reports (the report descriptor from debugfs is copied
below).

The first of the usages gets mapping REL_WHEEL, but the other two
get REL_DIAL and REL_MISC due this loop in function
hidinput_configure_usage (in hid-input.c soon after label
'mapped'):

	while (usage->code <= max && test_and_set_bit(usage->code, bit))
		usage->code = find_next_zero_bit(bit, max + 1, usage->code);

REL_MISC gets eventually reported when the horizontal wheel is used.

The purpose of the loop is not clear and deserves, perhaps, an
explanatory comment. Most of the code works around the loop by
using map_xxx_clear macros anyway.

The patch below introduces another such macro (map_rel_clear) and
changes the wheel mapping to use it.

It would have been possible to add another quirk in
hid-microsoft.c but the proposed patch seems to be more in line to
what is currently done in similar cases. It would be possible to
replace rdesc by a fragment that wholly describes the mouse (see
report INPUT(16) below) or, equivalently to the proposed patch, to
check if the hid_usage.code bit is already set in (currently
undefined) hid_driver.input_mapped and return -1 if that is the
case.

---
 drivers/hid/hid-input.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 6559e2e..f82ca82 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -65,6 +65,8 @@ static const struct {

 #define map_abs_clear(c)	hid_map_usage_clear(hidinput, usage, &bit, \
 		&max, EV_ABS, (c))
+#define map_rel_clear(c)	hid_map_usage_clear(hidinput, usage, &bit, \
+		&max, EV_REL, (c))
 #define map_key_clear(c)	hid_map_usage_clear(hidinput, usage, &bit, \
 		&max, EV_KEY, (c))

@@ -610,7 +612,7 @@ static void hidinput_configure_usage(struct
hid_input *hidinput, struct hid_fiel
 		case 0x22f: map_key_clear(KEY_ZOOMRESET);	break;
 		case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 		case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
-		case 0x238: map_rel(REL_HWHEEL);		break;
+		case 0x238: map_rel_clear(REL_HWHEEL);		break;
 		case 0x23d: map_key_clear(KEY_EDIT);		break;
 		case 0x25f: map_key_clear(KEY_CANCEL);		break;
 		case 0x269: map_key_clear(KEY_INSERT);		break;
-- 
1.7.4.1


Report descriptor for the mouse:

05 0c 09 01 a1 01 05 01 09 02 a1 02 85 13 05 0c 0a 38 02 95 01 75 08
15 81 25 7f 81 06 c0 85 20 06 00 ff 15 00 26 ff 00 75 08 95 12 0a 0a
fa b1 02 85 2e 06 00 ff 15 00 26 ff 00 75 08 95 07 0a 0a fa b1 02 85
2f 06 00 ff 15 00 26 ff 00 75 08 95 07 0a 0a fa 81 02 85 18 06 00 ff
15 00 26 ff 00 75 08 95 01 0a 0a fa b1 02 85 16 05 0c 19 00 2a ff 03
95 01 75 10 15 00 26 ff 03 81 00 06 00 ff 1a 01 fd 2a ff fd 15 01 26
ff 00 75 08 81 00 81 01 85 17 0a 06 ff 15 00 25 01 35 01 45 10 95 01
75 02 b1 02 0a 0f ff 45 10 95 01 75 02 b1 02 0a 04 ff 35 00 45 00 95
01 75 01 b1 02 75 03 b1 01 85 1c 06 00 ff 0a 25 ff 15 00 25 04 75 08
95 01 81 02 0a 26 ff 75 10 15 00 27 ff ff 81 02 c0 05 01 09 02 a1 01
05 01 09 02 a1 02 85 10 09 01 a1 00 05 09 19 01 29 05 95 05 75 01 25
00 25 01 81 02 75 03 95 01 81 01 05 01 09 30 09 31 95 02 75 10 16 01
80 26 ff 7f 81 06 a1 02 85 12 09 48 95 01 75 02 15 00 25 01 35 01 45
10 b1 02 85 10 09 38 35 00 45 00 15 81 25 7f 75 08 81 06 c0 a1 02 85
12 09 48 75 02 15 00 25 01 35 01 45 10 b1 02 35 00 45 00 75 04 b1 01
85 10 05 0c 15 81 25 7f 75 08 0a 38 02 81 06 c0 c0 c0 c0

  INPUT(19)[INPUT]
    Field(0)
      Logical(GenericDesktop.Mouse)
      Usage(1)
        Consumer.HorizontalWheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Relative )
  INPUT(47)[INPUT]
    Field(0)
      Usage(7)
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  INPUT(22)[INPUT]
    Field(0)
      Usage(1024)
        Consumer.0000
        Consumer.0001
        Consumer.0002
        Consumer.0003
        Consumer.0004
        Consumer.0005
        Consumer.0006
        Consumer.0007
        Consumer.0008
        Consumer.0009
        Consumer.000a
        Consumer.000b
        Consumer.000c
        Consumer.000d
        Consumer.000e
        Consumer.000f
        Consumer.0010
        Consumer.0011
        Consumer.0012
        Consumer.0013
        Consumer.0014
        Consumer.0015
        Consumer.0016
        Consumer.0017
        Consumer.0018
        Consumer.0019
        Consumer.001a
        Consumer.001b
        Consumer.001c
        Consumer.001d
        Consumer.001e
        Consumer.001f
        Consumer.0020
        Consumer.0021
        Consumer.0022
        Consumer.0023
        Consumer.0024
        Consumer.0025
        Consumer.0026
        Consumer.0027
        Consumer.0028
        Consumer.0029
        Consumer.002a
        Consumer.002b
        Consumer.002c
        Consumer.002d
        Consumer.002e
        Consumer.002f
        Consumer.0030
        Consumer.0031
        Consumer.0032
        Consumer.0033
        Consumer.0034
        Consumer.0035
        Consumer.0036
        Consumer.0037
        Consumer.0038
        Consumer.0039
        Consumer.003a
        Consumer.003b
        Consumer.003c
        Consumer.003d
        Consumer.003e
        Consumer.003f
        Consumer.0040
        Consumer.0041
        Consumer.0042
        Consumer.0043
        Consumer.0044
        Consumer.0045
        Consumer.0046
        Consumer.0047
        Consumer.0048
        Consumer.0049
        Consumer.004a
        Consumer.004b
        Consumer.004c
        Consumer.004d
        Consumer.004e
        Consumer.004f
        Consumer.0050
        Consumer.0051
        Consumer.0052
        Consumer.0053
        Consumer.0054
        Consumer.0055
        Consumer.0056
        Consumer.0057
        Consumer.0058
        Consumer.0059
        Consumer.005a
        Consumer.005b
        Consumer.005c
        Consumer.005d
        Consumer.005e
        Consumer.005f
        Consumer.0060
        Consumer.0061
        Consumer.0062
        Consumer.0063
        Consumer.0064
        Consumer.0065
        Consumer.0066
        Consumer.0067
        Consumer.0068
        Consumer.0069
        Consumer.006a
        Consumer.006b
        Consumer.006c
        Consumer.006d
        Consumer.006e
        Consumer.006f
        Consumer.0070
        Consumer.0071
        Consumer.0072
        Consumer.0073
        Consumer.0074
        Consumer.0075
        Consumer.0076
        Consumer.0077
        Consumer.0078
        Consumer.0079
        Consumer.007a
        Consumer.007b
        Consumer.007c
        Consumer.007d
        Consumer.007e
        Consumer.007f
        Consumer.0080
        Consumer.0081
        Consumer.0082
        Consumer.0083
        Consumer.0084
        Consumer.0085
        Consumer.0086
        Consumer.0087
        Consumer.0088
        Consumer.0089
        Consumer.008a
        Consumer.008b
        Consumer.008c
        Consumer.008d
        Consumer.008e
        Consumer.008f
        Consumer.0090
        Consumer.0091
        Consumer.0092
        Consumer.0093
        Consumer.0094
        Consumer.0095
        Consumer.0096
        Consumer.0097
        Consumer.0098
        Consumer.0099
        Consumer.009a
        Consumer.009b
        Consumer.009c
        Consumer.009d
        Consumer.009e
        Consumer.009f
        Consumer.00a0
        Consumer.00a1
        Consumer.00a2
        Consumer.00a3
        Consumer.00a4
        Consumer.00a5
        Consumer.00a6
        Consumer.00a7
        Consumer.00a8
        Consumer.00a9
        Consumer.00aa
        Consumer.00ab
        Consumer.00ac
        Consumer.00ad
        Consumer.00ae
        Consumer.00af
        Consumer.00b0
        Consumer.00b1
        Consumer.00b2
        Consumer.00b3
        Consumer.00b4
        Consumer.00b5
        Consumer.00b6
        Consumer.00b7
        Consumer.00b8
        Consumer.00b9
        Consumer.00ba
        Consumer.00bb
        Consumer.00bc
        Consumer.00bd
        Consumer.00be
        Consumer.00bf
        Consumer.00c0
        Consumer.00c1
        Consumer.00c2
        Consumer.00c3
        Consumer.00c4
        Consumer.00c5
        Consumer.00c6
        Consumer.00c7
        Consumer.00c8
        Consumer.00c9
        Consumer.00ca
        Consumer.00cb
        Consumer.00cc
        Consumer.00cd
        Consumer.00ce
        Consumer.00cf
        Consumer.00d0
        Consumer.00d1
        Consumer.00d2
        Consumer.00d3
        Consumer.00d4
        Consumer.00d5
        Consumer.00d6
        Consumer.00d7
        Consumer.00d8
        Consumer.00d9
        Consumer.00da
        Consumer.00db
        Consumer.00dc
        Consumer.00dd
        Consumer.00de
        Consumer.00df
        Consumer.00e0
        Consumer.00e1
        Consumer.00e2
        Consumer.00e3
        Consumer.00e4
        Consumer.00e5
        Consumer.00e6
        Consumer.00e7
        Consumer.00e8
        Consumer.00e9
        Consumer.00ea
        Consumer.00eb
        Consumer.00ec
        Consumer.00ed
        Consumer.00ee
        Consumer.00ef
        Consumer.00f0
        Consumer.00f1
        Consumer.00f2
        Consumer.00f3
        Consumer.00f4
        Consumer.00f5
        Consumer.00f6
        Consumer.00f7
        Consumer.00f8
        Consumer.00f9
        Consumer.00fa
        Consumer.00fb
        Consumer.00fc
        Consumer.00fd
        Consumer.00fe
        Consumer.00ff
        Consumer.0100
        Consumer.0101
        Consumer.0102
        Consumer.0103
        Consumer.0104
        Consumer.0105
        Consumer.0106
        Consumer.0107
        Consumer.0108
        Consumer.0109
        Consumer.010a
        Consumer.010b
        Consumer.010c
        Consumer.010d
        Consumer.010e
        Consumer.010f
        Consumer.0110
        Consumer.0111
        Consumer.0112
        Consumer.0113
        Consumer.0114
        Consumer.0115
        Consumer.0116
        Consumer.0117
        Consumer.0118
        Consumer.0119
        Consumer.011a
        Consumer.011b
        Consumer.011c
        Consumer.011d
        Consumer.011e
        Consumer.011f
        Consumer.0120
        Consumer.0121
        Consumer.0122
        Consumer.0123
        Consumer.0124
        Consumer.0125
        Consumer.0126
        Consumer.0127
        Consumer.0128
        Consumer.0129
        Consumer.012a
        Consumer.012b
        Consumer.012c
        Consumer.012d
        Consumer.012e
        Consumer.012f
        Consumer.0130
        Consumer.0131
        Consumer.0132
        Consumer.0133
        Consumer.0134
        Consumer.0135
        Consumer.0136
        Consumer.0137
        Consumer.0138
        Consumer.0139
        Consumer.013a
        Consumer.013b
        Consumer.013c
        Consumer.013d
        Consumer.013e
        Consumer.013f
        Consumer.0140
        Consumer.0141
        Consumer.0142
        Consumer.0143
        Consumer.0144
        Consumer.0145
        Consumer.0146
        Consumer.0147
        Consumer.0148
        Consumer.0149
        Consumer.014a
        Consumer.014b
        Consumer.014c
        Consumer.014d
        Consumer.014e
        Consumer.014f
        Consumer.0150
        Consumer.0151
        Consumer.0152
        Consumer.0153
        Consumer.0154
        Consumer.0155
        Consumer.0156
        Consumer.0157
        Consumer.0158
        Consumer.0159
        Consumer.015a
        Consumer.015b
        Consumer.015c
        Consumer.015d
        Consumer.015e
        Consumer.015f
        Consumer.0160
        Consumer.0161
        Consumer.0162
        Consumer.0163
        Consumer.0164
        Consumer.0165
        Consumer.0166
        Consumer.0167
        Consumer.0168
        Consumer.0169
        Consumer.016a
        Consumer.016b
        Consumer.016c
        Consumer.016d
        Consumer.016e
        Consumer.016f
        Consumer.0170
        Consumer.0171
        Consumer.0172
        Consumer.0173
        Consumer.0174
        Consumer.0175
        Consumer.0176
        Consumer.0177
        Consumer.0178
        Consumer.0179
        Consumer.017a
        Consumer.017b
        Consumer.017c
        Consumer.017d
        Consumer.017e
        Consumer.017f
        Consumer.0180
        Consumer.0181
        Consumer.0182
        Consumer.0183
        Consumer.0184
        Consumer.0185
        Consumer.0186
        Consumer.0187
        Consumer.0188
        Consumer.0189
        Consumer.018a
        Consumer.018b
        Consumer.018c
        Consumer.018d
        Consumer.018e
        Consumer.018f
        Consumer.0190
        Consumer.0191
        Consumer.0192
        Consumer.0193
        Consumer.0194
        Consumer.0195
        Consumer.0196
        Consumer.0197
        Consumer.0198
        Consumer.0199
        Consumer.019a
        Consumer.019b
        Consumer.019c
        Consumer.019d
        Consumer.019e
        Consumer.019f
        Consumer.01a0
        Consumer.01a1
        Consumer.01a2
        Consumer.01a3
        Consumer.01a4
        Consumer.01a5
        Consumer.01a6
        Consumer.01a7
        Consumer.01a8
        Consumer.01a9
        Consumer.01aa
        Consumer.01ab
        Consumer.01ac
        Consumer.01ad
        Consumer.01ae
        Consumer.01af
        Consumer.01b0
        Consumer.01b1
        Consumer.01b2
        Consumer.01b3
        Consumer.01b4
        Consumer.01b5
        Consumer.01b6
        Consumer.01b7
        Consumer.01b8
        Consumer.01b9
        Consumer.01ba
        Consumer.01bb
        Consumer.01bc
        Consumer.01bd
        Consumer.01be
        Consumer.01bf
        Consumer.01c0
        Consumer.01c1
        Consumer.01c2
        Consumer.01c3
        Consumer.01c4
        Consumer.01c5
        Consumer.01c6
        Consumer.01c7
        Consumer.01c8
        Consumer.01c9
        Consumer.01ca
        Consumer.01cb
        Consumer.01cc
        Consumer.01cd
        Consumer.01ce
        Consumer.01cf
        Consumer.01d0
        Consumer.01d1
        Consumer.01d2
        Consumer.01d3
        Consumer.01d4
        Consumer.01d5
        Consumer.01d6
        Consumer.01d7
        Consumer.01d8
        Consumer.01d9
        Consumer.01da
        Consumer.01db
        Consumer.01dc
        Consumer.01dd
        Consumer.01de
        Consumer.01df
        Consumer.01e0
        Consumer.01e1
        Consumer.01e2
        Consumer.01e3
        Consumer.01e4
        Consumer.01e5
        Consumer.01e6
        Consumer.01e7
        Consumer.01e8
        Consumer.01e9
        Consumer.01ea
        Consumer.01eb
        Consumer.01ec
        Consumer.01ed
        Consumer.01ee
        Consumer.01ef
        Consumer.01f0
        Consumer.01f1
        Consumer.01f2
        Consumer.01f3
        Consumer.01f4
        Consumer.01f5
        Consumer.01f6
        Consumer.01f7
        Consumer.01f8
        Consumer.01f9
        Consumer.01fa
        Consumer.01fb
        Consumer.01fc
        Consumer.01fd
        Consumer.01fe
        Consumer.01ff
        Consumer.0200
        Consumer.0201
        Consumer.0202
        Consumer.0203
        Consumer.0204
        Consumer.0205
        Consumer.0206
        Consumer.0207
        Consumer.0208
        Consumer.0209
        Consumer.020a
        Consumer.020b
        Consumer.020c
        Consumer.020d
        Consumer.020e
        Consumer.020f
        Consumer.0210
        Consumer.0211
        Consumer.0212
        Consumer.0213
        Consumer.0214
        Consumer.0215
        Consumer.0216
        Consumer.0217
        Consumer.0218
        Consumer.0219
        Consumer.021a
        Consumer.021b
        Consumer.021c
        Consumer.021d
        Consumer.021e
        Consumer.021f
        Consumer.0220
        Consumer.0221
        Consumer.0222
        Consumer.0223
        Consumer.0224
        Consumer.0225
        Consumer.0226
        Consumer.0227
        Consumer.0228
        Consumer.0229
        Consumer.022a
        Consumer.022b
        Consumer.022c
        Consumer.022d
        Consumer.022e
        Consumer.022f
        Consumer.0230
        Consumer.0231
        Consumer.0232
        Consumer.0233
        Consumer.0234
        Consumer.0235
        Consumer.0236
        Consumer.0237
        Consumer.HorizontalWheel
        Consumer.0239
        Consumer.023a
        Consumer.023b
        Consumer.023c
        Consumer.023d
        Consumer.023e
        Consumer.023f
        Consumer.0240
        Consumer.0241
        Consumer.0242
        Consumer.0243
        Consumer.0244
        Consumer.0245
        Consumer.0246
        Consumer.0247
        Consumer.0248
        Consumer.0249
        Consumer.024a
        Consumer.024b
        Consumer.024c
        Consumer.024d
        Consumer.024e
        Consumer.024f
        Consumer.0250
        Consumer.0251
        Consumer.0252
        Consumer.0253
        Consumer.0254
        Consumer.0255
        Consumer.0256
        Consumer.0257
        Consumer.0258
        Consumer.0259
        Consumer.025a
        Consumer.025b
        Consumer.025c
        Consumer.025d
        Consumer.025e
        Consumer.025f
        Consumer.0260
        Consumer.0261
        Consumer.0262
        Consumer.0263
        Consumer.0264
        Consumer.0265
        Consumer.0266
        Consumer.0267
        Consumer.0268
        Consumer.0269
        Consumer.026a
        Consumer.026b
        Consumer.026c
        Consumer.026d
        Consumer.026e
        Consumer.026f
        Consumer.0270
        Consumer.0271
        Consumer.0272
        Consumer.0273
        Consumer.0274
        Consumer.0275
        Consumer.0276
        Consumer.0277
        Consumer.0278
        Consumer.0279
        Consumer.027a
        Consumer.027b
        Consumer.027c
        Consumer.027d
        Consumer.027e
        Consumer.027f
        Consumer.0280
        Consumer.0281
        Consumer.0282
        Consumer.0283
        Consumer.0284
        Consumer.0285
        Consumer.0286
        Consumer.0287
        Consumer.0288
        Consumer.0289
        Consumer.028a
        Consumer.028b
        Consumer.028c
        Consumer.028d
        Consumer.028e
        Consumer.028f
        Consumer.0290
        Consumer.0291
        Consumer.0292
        Consumer.0293
        Consumer.0294
        Consumer.0295
        Consumer.0296
        Consumer.0297
        Consumer.0298
        Consumer.0299
        Consumer.029a
        Consumer.029b
        Consumer.029c
        Consumer.029d
        Consumer.029e
        Consumer.029f
        Consumer.02a0
        Consumer.02a1
        Consumer.02a2
        Consumer.02a3
        Consumer.02a4
        Consumer.02a5
        Consumer.02a6
        Consumer.02a7
        Consumer.02a8
        Consumer.02a9
        Consumer.02aa
        Consumer.02ab
        Consumer.02ac
        Consumer.02ad
        Consumer.02ae
        Consumer.02af
        Consumer.02b0
        Consumer.02b1
        Consumer.02b2
        Consumer.02b3
        Consumer.02b4
        Consumer.02b5
        Consumer.02b6
        Consumer.02b7
        Consumer.02b8
        Consumer.02b9
        Consumer.02ba
        Consumer.02bb
        Consumer.02bc
        Consumer.02bd
        Consumer.02be
        Consumer.02bf
        Consumer.02c0
        Consumer.02c1
        Consumer.02c2
        Consumer.02c3
        Consumer.02c4
        Consumer.02c5
        Consumer.02c6
        Consumer.02c7
        Consumer.02c8
        Consumer.02c9
        Consumer.02ca
        Consumer.02cb
        Consumer.02cc
        Consumer.02cd
        Consumer.02ce
        Consumer.02cf
        Consumer.02d0
        Consumer.02d1
        Consumer.02d2
        Consumer.02d3
        Consumer.02d4
        Consumer.02d5
        Consumer.02d6
        Consumer.02d7
        Consumer.02d8
        Consumer.02d9
        Consumer.02da
        Consumer.02db
        Consumer.02dc
        Consumer.02dd
        Consumer.02de
        Consumer.02df
        Consumer.02e0
        Consumer.02e1
        Consumer.02e2
        Consumer.02e3
        Consumer.02e4
        Consumer.02e5
        Consumer.02e6
        Consumer.02e7
        Consumer.02e8
        Consumer.02e9
        Consumer.02ea
        Consumer.02eb
        Consumer.02ec
        Consumer.02ed
        Consumer.02ee
        Consumer.02ef
        Consumer.02f0
        Consumer.02f1
        Consumer.02f2
        Consumer.02f3
        Consumer.02f4
        Consumer.02f5
        Consumer.02f6
        Consumer.02f7
        Consumer.02f8
        Consumer.02f9
        Consumer.02fa
        Consumer.02fb
        Consumer.02fc
        Consumer.02fd
        Consumer.02fe
        Consumer.02ff
        Consumer.0300
        Consumer.0301
        Consumer.0302
        Consumer.0303
        Consumer.0304
        Consumer.0305
        Consumer.0306
        Consumer.0307
        Consumer.0308
        Consumer.0309
        Consumer.030a
        Consumer.030b
        Consumer.030c
        Consumer.030d
        Consumer.030e
        Consumer.030f
        Consumer.0310
        Consumer.0311
        Consumer.0312
        Consumer.0313
        Consumer.0314
        Consumer.0315
        Consumer.0316
        Consumer.0317
        Consumer.0318
        Consumer.0319
        Consumer.031a
        Consumer.031b
        Consumer.031c
        Consumer.031d
        Consumer.031e
        Consumer.031f
        Consumer.0320
        Consumer.0321
        Consumer.0322
        Consumer.0323
        Consumer.0324
        Consumer.0325
        Consumer.0326
        Consumer.0327
        Consumer.0328
        Consumer.0329
        Consumer.032a
        Consumer.032b
        Consumer.032c
        Consumer.032d
        Consumer.032e
        Consumer.032f
        Consumer.0330
        Consumer.0331
        Consumer.0332
        Consumer.0333
        Consumer.0334
        Consumer.0335
        Consumer.0336
        Consumer.0337
        Consumer.0338
        Consumer.0339
        Consumer.033a
        Consumer.033b
        Consumer.033c
        Consumer.033d
        Consumer.033e
        Consumer.033f
        Consumer.0340
        Consumer.0341
        Consumer.0342
        Consumer.0343
        Consumer.0344
        Consumer.0345
        Consumer.0346
        Consumer.0347
        Consumer.0348
        Consumer.0349
        Consumer.034a
        Consumer.034b
        Consumer.034c
        Consumer.034d
        Consumer.034e
        Consumer.034f
        Consumer.0350
        Consumer.0351
        Consumer.0352
        Consumer.0353
        Consumer.0354
        Consumer.0355
        Consumer.0356
        Consumer.0357
        Consumer.0358
        Consumer.0359
        Consumer.035a
        Consumer.035b
        Consumer.035c
        Consumer.035d
        Consumer.035e
        Consumer.035f
        Consumer.0360
        Consumer.0361
        Consumer.0362
        Consumer.0363
        Consumer.0364
        Consumer.0365
        Consumer.0366
        Consumer.0367
        Consumer.0368
        Consumer.0369
        Consumer.036a
        Consumer.036b
        Consumer.036c
        Consumer.036d
        Consumer.036e
        Consumer.036f
        Consumer.0370
        Consumer.0371
        Consumer.0372
        Consumer.0373
        Consumer.0374
        Consumer.0375
        Consumer.0376
        Consumer.0377
        Consumer.0378
        Consumer.0379
        Consumer.037a
        Consumer.037b
        Consumer.037c
        Consumer.037d
        Consumer.037e
        Consumer.037f
        Consumer.0380
        Consumer.0381
        Consumer.0382
        Consumer.0383
        Consumer.0384
        Consumer.0385
        Consumer.0386
        Consumer.0387
        Consumer.0388
        Consumer.0389
        Consumer.038a
        Consumer.038b
        Consumer.038c
        Consumer.038d
        Consumer.038e
        Consumer.038f
        Consumer.0390
        Consumer.0391
        Consumer.0392
        Consumer.0393
        Consumer.0394
        Consumer.0395
        Consumer.0396
        Consumer.0397
        Consumer.0398
        Consumer.0399
        Consumer.039a
        Consumer.039b
        Consumer.039c
        Consumer.039d
        Consumer.039e
        Consumer.039f
        Consumer.03a0
        Consumer.03a1
        Consumer.03a2
        Consumer.03a3
        Consumer.03a4
        Consumer.03a5
        Consumer.03a6
        Consumer.03a7
        Consumer.03a8
        Consumer.03a9
        Consumer.03aa
        Consumer.03ab
        Consumer.03ac
        Consumer.03ad
        Consumer.03ae
        Consumer.03af
        Consumer.03b0
        Consumer.03b1
        Consumer.03b2
        Consumer.03b3
        Consumer.03b4
        Consumer.03b5
        Consumer.03b6
        Consumer.03b7
        Consumer.03b8
        Consumer.03b9
        Consumer.03ba
        Consumer.03bb
        Consumer.03bc
        Consumer.03bd
        Consumer.03be
        Consumer.03bf
        Consumer.03c0
        Consumer.03c1
        Consumer.03c2
        Consumer.03c3
        Consumer.03c4
        Consumer.03c5
        Consumer.03c6
        Consumer.03c7
        Consumer.03c8
        Consumer.03c9
        Consumer.03ca
        Consumer.03cb
        Consumer.03cc
        Consumer.03cd
        Consumer.03ce
        Consumer.03cf
        Consumer.03d0
        Consumer.03d1
        Consumer.03d2
        Consumer.03d3
        Consumer.03d4
        Consumer.03d5
        Consumer.03d6
        Consumer.03d7
        Consumer.03d8
        Consumer.03d9
        Consumer.03da
        Consumer.03db
        Consumer.03dc
        Consumer.03dd
        Consumer.03de
        Consumer.03df
        Consumer.03e0
        Consumer.03e1
        Consumer.03e2
        Consumer.03e3
        Consumer.03e4
        Consumer.03e5
        Consumer.03e6
        Consumer.03e7
        Consumer.03e8
        Consumer.03e9
        Consumer.03ea
        Consumer.03eb
        Consumer.03ec
        Consumer.03ed
        Consumer.03ee
        Consumer.03ef
        Consumer.03f0
        Consumer.03f1
        Consumer.03f2
        Consumer.03f3
        Consumer.03f4
        Consumer.03f5
        Consumer.03f6
        Consumer.03f7
        Consumer.03f8
        Consumer.03f9
        Consumer.03fa
        Consumer.03fb
        Consumer.03fc
        Consumer.03fd
        Consumer.03fe
        Consumer.03ff
      Logical Minimum(0)
      Logical Maximum(1023)
      Report Size(16)
      Report Count(1)
      Report Offset(0)
      Flags( Array Absolute )
    Field(1)
      Usage(255)
        ff00.fd01
        ff00.fd02
        ff00.fd03
        ff00.fd04
        ff00.fd05
        ff00.fd06
        ff00.fd07
        ff00.fd08
        ff00.fd09
        ff00.fd0a
        ff00.fd0b
        ff00.fd0c
        ff00.fd0d
        ff00.fd0e
        ff00.fd0f
        ff00.fd10
        ff00.fd11
        ff00.fd12
        ff00.fd13
        ff00.fd14
        ff00.fd15
        ff00.fd16
        ff00.fd17
        ff00.fd18
        ff00.fd19
        ff00.fd1a
        ff00.fd1b
        ff00.fd1c
        ff00.fd1d
        ff00.fd1e
        ff00.fd1f
        ff00.fd20
        ff00.fd21
        ff00.fd22
        ff00.fd23
        ff00.fd24
        ff00.fd25
        ff00.fd26
        ff00.fd27
        ff00.fd28
        ff00.fd29
        ff00.fd2a
        ff00.fd2b
        ff00.fd2c
        ff00.fd2d
        ff00.fd2e
        ff00.fd2f
        ff00.fd30
        ff00.fd31
        ff00.fd32
        ff00.fd33
        ff00.fd34
        ff00.fd35
        ff00.fd36
        ff00.fd37
        ff00.fd38
        ff00.fd39
        ff00.fd3a
        ff00.fd3b
        ff00.fd3c
        ff00.fd3d
        ff00.fd3e
        ff00.fd3f
        ff00.fd40
        ff00.fd41
        ff00.fd42
        ff00.fd43
        ff00.fd44
        ff00.fd45
        ff00.fd46
        ff00.fd47
        ff00.fd48
        ff00.fd49
        ff00.fd4a
        ff00.fd4b
        ff00.fd4c
        ff00.fd4d
        ff00.fd4e
        ff00.fd4f
        ff00.fd50
        ff00.fd51
        ff00.fd52
        ff00.fd53
        ff00.fd54
        ff00.fd55
        ff00.fd56
        ff00.fd57
        ff00.fd58
        ff00.fd59
        ff00.fd5a
        ff00.fd5b
        ff00.fd5c
        ff00.fd5d
        ff00.fd5e
        ff00.fd5f
        ff00.fd60
        ff00.fd61
        ff00.fd62
        ff00.fd63
        ff00.fd64
        ff00.fd65
        ff00.fd66
        ff00.fd67
        ff00.fd68
        ff00.fd69
        ff00.fd6a
        ff00.fd6b
        ff00.fd6c
        ff00.fd6d
        ff00.fd6e
        ff00.fd6f
        ff00.fd70
        ff00.fd71
        ff00.fd72
        ff00.fd73
        ff00.fd74
        ff00.fd75
        ff00.fd76
        ff00.fd77
        ff00.fd78
        ff00.fd79
        ff00.fd7a
        ff00.fd7b
        ff00.fd7c
        ff00.fd7d
        ff00.fd7e
        ff00.fd7f
        ff00.fd80
        ff00.fd81
        ff00.fd82
        ff00.fd83
        ff00.fd84
        ff00.fd85
        ff00.fd86
        ff00.fd87
        ff00.fd88
        ff00.fd89
        ff00.fd8a
        ff00.fd8b
        ff00.fd8c
        ff00.fd8d
        ff00.fd8e
        ff00.fd8f
        ff00.fd90
        ff00.fd91
        ff00.fd92
        ff00.fd93
        ff00.fd94
        ff00.fd95
        ff00.fd96
        ff00.fd97
        ff00.fd98
        ff00.fd99
        ff00.fd9a
        ff00.fd9b
        ff00.fd9c
        ff00.fd9d
        ff00.fd9e
        ff00.fd9f
        ff00.fda0
        ff00.fda1
        ff00.fda2
        ff00.fda3
        ff00.fda4
        ff00.fda5
        ff00.fda6
        ff00.fda7
        ff00.fda8
        ff00.fda9
        ff00.fdaa
        ff00.fdab
        ff00.fdac
        ff00.fdad
        ff00.fdae
        ff00.fdaf
        ff00.fdb0
        ff00.fdb1
        ff00.fdb2
        ff00.fdb3
        ff00.fdb4
        ff00.fdb5
        ff00.fdb6
        ff00.fdb7
        ff00.fdb8
        ff00.fdb9
        ff00.fdba
        ff00.fdbb
        ff00.fdbc
        ff00.fdbd
        ff00.fdbe
        ff00.fdbf
        ff00.fdc0
        ff00.fdc1
        ff00.fdc2
        ff00.fdc3
        ff00.fdc4
        ff00.fdc5
        ff00.fdc6
        ff00.fdc7
        ff00.fdc8
        ff00.fdc9
        ff00.fdca
        ff00.fdcb
        ff00.fdcc
        ff00.fdcd
        ff00.fdce
        ff00.fdcf
        ff00.fdd0
        ff00.fdd1
        ff00.fdd2
        ff00.fdd3
        ff00.fdd4
        ff00.fdd5
        ff00.fdd6
        ff00.fdd7
        ff00.fdd8
        ff00.fdd9
        ff00.fdda
        ff00.fddb
        ff00.fddc
        ff00.fddd
        ff00.fdde
        ff00.fddf
        ff00.fde0
        ff00.fde1
        ff00.fde2
        ff00.fde3
        ff00.fde4
        ff00.fde5
        ff00.fde6
        ff00.fde7
        ff00.fde8
        ff00.fde9
        ff00.fdea
        ff00.fdeb
        ff00.fdec
        ff00.fded
        ff00.fdee
        ff00.fdef
        ff00.fdf0
        ff00.fdf1
        ff00.fdf2
        ff00.fdf3
        ff00.fdf4
        ff00.fdf5
        ff00.fdf6
        ff00.fdf7
        ff00.fdf8
        ff00.fdf9
        ff00.fdfa
        ff00.fdfb
        ff00.fdfc
        ff00.fdfd
        ff00.fdfe
        ff00.fdff
      Logical Minimum(1)
      Logical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(16)
      Flags( Array Absolute )
  INPUT(28)[INPUT]
    Field(0)
      Usage(1)
        ff00.ff25
      Logical Minimum(0)
      Logical Maximum(4)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
  INPUT(16)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Logical(GenericDesktop.Mouse)
      Usage(5)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(5)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Logical(GenericDesktop.Mouse)
      Usage(2)
        GenericDesktop.X
        GenericDesktop.Y
      Logical Minimum(-32767)
      Logical Maximum(32767)
      Report Size(16)
      Report Count(2)
      Report Offset(8)
      Flags( Variable Relative )
    Field(2)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.Wheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(1)
      Report Offset(40)
      Flags( Variable Relative )
    Field(3)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        Consumer.HorizontalWheel
      Logical Minimum(-127)
      Logical Maximum(127)
      Report Size(8)
      Report Count(1)
      Report Offset(48)
      Flags( Variable Relative )
  FEATURE(32)[FEATURE]
    Field(0)
      Usage(18)
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(18)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(46)[FEATURE]
    Field(0)
      Usage(7)
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
        ff00.fa0a
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(7)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(24)[FEATURE]
    Field(0)
      Usage(1)
        ff00.fa0a
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
  FEATURE(23)[FEATURE]
    Field(0)
      Usage(1)
        ff00.ff06
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(1)
      Physical Maximum(16)
      Report Size(2)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Usage(1)
        ff00.ff0f
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(1)
      Physical Maximum(16)
      Report Size(2)
      Report Count(1)
      Report Offset(2)
      Flags( Variable Absolute )
    Field(2)
      Usage(1)
        ff00.ff04
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(1)
      Report Offset(4)
      Flags( Variable Absolute )
  FEATURE(18)[FEATURE]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.0048
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(1)
      Physical Maximum(16)
      Report Size(2)
      Report Count(1)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Usage(1)
        GenericDesktop.0048
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(1)
      Physical Maximum(16)
      Report Size(2)
      Report Count(1)
      Report Offset(2)
      Flags( Variable Absolute )

Consumer.HorizontalWheel ---> Relative.HWheel
ff00.fa0a ---> Sync.Report
ff00.fa0a ---> Sync.Report
ff00.fa0a ---> Sync.Report
ff00.fa0a ---> Sync.Report
ff00.fa0a ---> Sync.Report
ff00.fa0a ---> Sync.Report
ff00.fa0a ---> Sync.Report
Consumer.0000 ---> Sync.Report
Consumer.0001 ---> Sync.Report
Consumer.0002 ---> Sync.Report
Consumer.0003 ---> Sync.Report
Consumer.0004 ---> Sync.Report
Consumer.0005 ---> Sync.Report
Consumer.0006 ---> Sync.Report
Consumer.0007 ---> Sync.Report
Consumer.0008 ---> Sync.Report
Consumer.0009 ---> Sync.Report
Consumer.000a ---> Sync.Report
Consumer.000b ---> Sync.Report
Consumer.000c ---> Sync.Report
Consumer.000d ---> Sync.Report
Consumer.000e ---> Sync.Report
Consumer.000f ---> Sync.Report
Consumer.0010 ---> Sync.Report
Consumer.0011 ---> Sync.Report
Consumer.0012 ---> Sync.Report
Consumer.0013 ---> Sync.Report
Consumer.0014 ---> Sync.Report
Consumer.0015 ---> Sync.Report
Consumer.0016 ---> Sync.Report
Consumer.0017 ---> Sync.Report
Consumer.0018 ---> Sync.Report
Consumer.0019 ---> Sync.Report
Consumer.001a ---> Sync.Report
Consumer.001b ---> Sync.Report
Consumer.001c ---> Sync.Report
Consumer.001d ---> Sync.Report
Consumer.001e ---> Sync.Report
Consumer.001f ---> Sync.Report
Consumer.0020 ---> Sync.Report
Consumer.0021 ---> Sync.Report
Consumer.0022 ---> Sync.Report
Consumer.0023 ---> Sync.Report
Consumer.0024 ---> Sync.Report
Consumer.0025 ---> Sync.Report
Consumer.0026 ---> Sync.Report
Consumer.0027 ---> Sync.Report
Consumer.0028 ---> Sync.Report
Consumer.0029 ---> Sync.Report
Consumer.002a ---> Sync.Report
Consumer.002b ---> Sync.Report
Consumer.002c ---> Sync.Report
Consumer.002d ---> Sync.Report
Consumer.002e ---> Sync.Report
Consumer.002f ---> Sync.Report
Consumer.0030 ---> Key.Power
Consumer.0031 ---> Key.Restart
Consumer.0032 ---> Key.Sleep
Consumer.0033 ---> Sync.Report
Consumer.0034 ---> Key.Sleep
Consumer.0035 ---> Key.KbdIlluminationToggle
Consumer.0036 ---> Key.Btn0
Consumer.0037 ---> Sync.Report
Consumer.0038 ---> Sync.Report
Consumer.0039 ---> Sync.Report
Consumer.003a ---> Sync.Report
Consumer.003b ---> Sync.Report
Consumer.003c ---> Sync.Report
Consumer.003d ---> Sync.Report
Consumer.003e ---> Sync.Report
Consumer.003f ---> Sync.Report
Consumer.0040 ---> Key.Menu
Consumer.0041 ---> Key.Select
Consumer.0042 ---> Key.Up
Consumer.0043 ---> Key.Down
Consumer.0044 ---> Key.Left
Consumer.0045 ---> Key.Right
Consumer.0046 ---> Key.Esc
Consumer.0047 ---> Key.KPPlus
Consumer.0048 ---> Key.KPMinus
Consumer.0049 ---> Sync.Report
Consumer.004a ---> Sync.Report
Consumer.004b ---> Sync.Report
Consumer.004c ---> Sync.Report
Consumer.004d ---> Sync.Report
Consumer.004e ---> Sync.Report
Consumer.004f ---> Sync.Report
Consumer.0050 ---> Sync.Report
Consumer.0051 ---> Sync.Report
Consumer.0052 ---> Sync.Report
Consumer.0053 ---> Sync.Report
Consumer.0054 ---> Sync.Report
Consumer.0055 ---> Sync.Report
Consumer.0056 ---> Sync.Report
Consumer.0057 ---> Sync.Report
Consumer.0058 ---> Sync.Report
Consumer.0059 ---> Sync.Report
Consumer.005a ---> Sync.Report
Consumer.005b ---> Sync.Report
Consumer.005c ---> Sync.Report
Consumer.005d ---> Sync.Report
Consumer.005e ---> Sync.Report
Consumer.005f ---> Sync.Report
Consumer.0060 ---> Key.Info
Consumer.0061 ---> Key.Subtitle
Consumer.0062 ---> Sync.Report
Consumer.0063 ---> Key.VCR
Consumer.0064 ---> Sync.Report
Consumer.0065 ---> Key.Camera
Consumer.0066 ---> Sync.Report
Consumer.0067 ---> Sync.Report
Consumer.0068 ---> Sync.Report
Consumer.0069 ---> Key.Red
Consumer.006a ---> Key.Green
Consumer.006b ---> Key.Blue
Consumer.006c ---> Key.Yellow
Consumer.006d ---> Key.Zoom
Consumer.006e ---> Sync.Report
Consumer.006f ---> Sync.Report
Consumer.0070 ---> Sync.Report
Consumer.0071 ---> Sync.Report
Consumer.0072 ---> Sync.Report
Consumer.0073 ---> Sync.Report
Consumer.0074 ---> Sync.Report
Consumer.0075 ---> Sync.Report
Consumer.0076 ---> Sync.Report
Consumer.0077 ---> Sync.Report
Consumer.0078 ---> Sync.Report
Consumer.0079 ---> Sync.Report
Consumer.007a ---> Sync.Report
Consumer.007b ---> Sync.Report
Consumer.007c ---> Sync.Report
Consumer.007d ---> Sync.Report
Consumer.007e ---> Sync.Report
Consumer.007f ---> Sync.Report
Consumer.0080 ---> Sync.Report
Consumer.0081 ---> Sync.Report
Consumer.0082 ---> Key.?
Consumer.0083 ---> Key.Last
Consumer.0084 ---> Key.Enter
Consumer.0085 ---> Sync.Report
Consumer.0086 ---> Sync.Report
Consumer.0087 ---> Sync.Report
Consumer.0088 ---> Key.PC
Consumer.0089 ---> Key.TV
Consumer.008a ---> Key.WWW
Consumer.008b ---> Key.DVD
Consumer.008c ---> Key.Phone
Consumer.008d ---> Key.Program
Consumer.008e ---> Key.?
Consumer.008f ---> Key.?
Consumer.0090 ---> Key.Memo
Consumer.0091 ---> Key.CD
Consumer.0092 ---> Key.VCR
Consumer.0093 ---> Key.Tuner
Consumer.0094 ---> Key.Exit
Consumer.0095 ---> Key.Help
Consumer.0096 ---> Key.Tape
Consumer.0097 ---> Key.TV2
Consumer.0098 ---> Key.Sat
Consumer.0099 ---> Sync.Report
Consumer.009a ---> Key.PVR
Consumer.009b ---> Sync.Report
Consumer.009c ---> Key.ChannelUp
Consumer.009d ---> Key.ChannelDown
Consumer.009e ---> Sync.Report
Consumer.009f ---> Sync.Report
Consumer.00a0 ---> Key.VCR2
Consumer.00a1 ---> Sync.Report
Consumer.00a2 ---> Sync.Report
Consumer.00a3 ---> Sync.Report
Consumer.00a4 ---> Sync.Report
Consumer.00a5 ---> Sync.Report
Consumer.00a6 ---> Sync.Report
Consumer.00a7 ---> Sync.Report
Consumer.00a8 ---> Sync.Report
Consumer.00a9 ---> Sync.Report
Consumer.00aa ---> Sync.Report
Consumer.00ab ---> Sync.Report
Consumer.00ac ---> Sync.Report
Consumer.00ad ---> Sync.Report
Consumer.00ae ---> Sync.Report
Consumer.00af ---> Sync.Report
Consumer.00b0 ---> Key.Play
Consumer.00b1 ---> Key.Pause
Consumer.00b2 ---> Key.Record
Consumer.00b3 ---> Key.FastForward
Consumer.00b4 ---> Key.Rewind
Consumer.00b5 ---> Key.NextSong
Consumer.00b6 ---> Key.PreviousSong
Consumer.00b7 ---> Key.StopCD
Consumer.00b8 ---> Key.EjectCD
Consumer.00b9 ---> Key.Shuffle
Consumer.00ba ---> Sync.Report
Consumer.00bb ---> Sync.Report
Consumer.00bc ---> Key.?
Consumer.00bd ---> Sync.Report
Consumer.00be ---> Sync.Report
Consumer.00bf ---> Key.Slow
Consumer.00c0 ---> Sync.Report
Consumer.00c1 ---> Sync.Report
Consumer.00c2 ---> Sync.Report
Consumer.00c3 ---> Sync.Report
Consumer.00c4 ---> Sync.Report
Consumer.00c5 ---> Sync.Report
Consumer.00c6 ---> Sync.Report
Consumer.00c7 ---> Sync.Report
Consumer.00c8 ---> Sync.Report
Consumer.00c9 ---> Sync.Report
Consumer.00ca ---> Sync.Report
Consumer.00cb ---> Sync.Report
Consumer.00cc ---> Sync.Report
Consumer.00cd ---> Key.PlayPause
Consumer.00ce ---> Sync.Report
Consumer.00cf ---> Sync.Report
Consumer.00d0 ---> Sync.Report
Consumer.00d1 ---> Sync.Report
Consumer.00d2 ---> Sync.Report
Consumer.00d3 ---> Sync.Report
Consumer.00d4 ---> Sync.Report
Consumer.00d5 ---> Sync.Report
Consumer.00d6 ---> Sync.Report
Consumer.00d7 ---> Sync.Report
Consumer.00d8 ---> Sync.Report
Consumer.00d9 ---> Sync.Report
Consumer.00da ---> Sync.Report
Consumer.00db ---> Sync.Report
Consumer.00dc ---> Sync.Report
Consumer.00dd ---> Sync.Report
Consumer.00de ---> Sync.Report
Consumer.00df ---> Sync.Report
Consumer.00e0 ---> Absolute.Volume
Consumer.00e1 ---> Sync.Report
Consumer.00e2 ---> Key.Mute
Consumer.00e3 ---> Sync.Report
Consumer.00e4 ---> Sync.Report
Consumer.00e5 ---> Key.BassBoost
Consumer.00e6 ---> Sync.Report
Consumer.00e7 ---> Sync.Report
Consumer.00e8 ---> Sync.Report
Consumer.00e9 ---> Key.VolumeUp
Consumer.00ea ---> Key.VolumeDown
Consumer.00eb ---> Sync.Report
Consumer.00ec ---> Sync.Report
Consumer.00ed ---> Sync.Report
Consumer.00ee ---> Sync.Report
Consumer.00ef ---> Sync.Report
Consumer.00f0 ---> Sync.Report
Consumer.00f1 ---> Sync.Report
Consumer.00f2 ---> Sync.Report
Consumer.00f3 ---> Sync.Report
Consumer.00f4 ---> Sync.Report
Consumer.00f5 ---> Key.Slow
Consumer.00f6 ---> Sync.Report
Consumer.00f7 ---> Sync.Report
Consumer.00f8 ---> Sync.Report
Consumer.00f9 ---> Sync.Report
Consumer.00fa ---> Sync.Report
Consumer.00fb ---> Sync.Report
Consumer.00fc ---> Sync.Report
Consumer.00fd ---> Sync.Report
Consumer.00fe ---> Sync.Report
Consumer.00ff ---> Sync.Report
Consumer.0100 ---> Sync.Report
Consumer.0101 ---> Sync.Report
Consumer.0102 ---> Sync.Report
Consumer.0103 ---> Sync.Report
Consumer.0104 ---> Sync.Report
Consumer.0105 ---> Sync.Report
Consumer.0106 ---> Sync.Report
Consumer.0107 ---> Sync.Report
Consumer.0108 ---> Sync.Report
Consumer.0109 ---> Sync.Report
Consumer.010a ---> Sync.Report
Consumer.010b ---> Sync.Report
Consumer.010c ---> Sync.Report
Consumer.010d ---> Sync.Report
Consumer.010e ---> Sync.Report
Consumer.010f ---> Sync.Report
Consumer.0110 ---> Sync.Report
Consumer.0111 ---> Sync.Report
Consumer.0112 ---> Sync.Report
Consumer.0113 ---> Sync.Report
Consumer.0114 ---> Sync.Report
Consumer.0115 ---> Sync.Report
Consumer.0116 ---> Sync.Report
Consumer.0117 ---> Sync.Report
Consumer.0118 ---> Sync.Report
Consumer.0119 ---> Sync.Report
Consumer.011a ---> Sync.Report
Consumer.011b ---> Sync.Report
Consumer.011c ---> Sync.Report
Consumer.011d ---> Sync.Report
Consumer.011e ---> Sync.Report
Consumer.011f ---> Sync.Report
Consumer.0120 ---> Sync.Report
Consumer.0121 ---> Sync.Report
Consumer.0122 ---> Sync.Report
Consumer.0123 ---> Sync.Report
Consumer.0124 ---> Sync.Report
Consumer.0125 ---> Sync.Report
Consumer.0126 ---> Sync.Report
Consumer.0127 ---> Sync.Report
Consumer.0128 ---> Sync.Report
Consumer.0129 ---> Sync.Report
Consumer.012a ---> Sync.Report
Consumer.012b ---> Sync.Report
Consumer.012c ---> Sync.Report
Consumer.012d ---> Sync.Report
Consumer.012e ---> Sync.Report
Consumer.012f ---> Sync.Report
Consumer.0130 ---> Sync.Report
Consumer.0131 ---> Sync.Report
Consumer.0132 ---> Sync.Report
Consumer.0133 ---> Sync.Report
Consumer.0134 ---> Sync.Report
Consumer.0135 ---> Sync.Report
Consumer.0136 ---> Sync.Report
Consumer.0137 ---> Sync.Report
Consumer.0138 ---> Sync.Report
Consumer.0139 ---> Sync.Report
Consumer.013a ---> Sync.Report
Consumer.013b ---> Sync.Report
Consumer.013c ---> Sync.Report
Consumer.013d ---> Sync.Report
Consumer.013e ---> Sync.Report
Consumer.013f ---> Sync.Report
Consumer.0140 ---> Sync.Report
Consumer.0141 ---> Sync.Report
Consumer.0142 ---> Sync.Report
Consumer.0143 ---> Sync.Report
Consumer.0144 ---> Sync.Report
Consumer.0145 ---> Sync.Report
Consumer.0146 ---> Sync.Report
Consumer.0147 ---> Sync.Report
Consumer.0148 ---> Sync.Report
Consumer.0149 ---> Sync.Report
Consumer.014a ---> Sync.Report
Consumer.014b ---> Sync.Report
Consumer.014c ---> Sync.Report
Consumer.014d ---> Sync.Report
Consumer.014e ---> Sync.Report
Consumer.014f ---> Sync.Report
Consumer.0150 ---> Sync.Report
Consumer.0151 ---> Sync.Report
Consumer.0152 ---> Sync.Report
Consumer.0153 ---> Sync.Report
Consumer.0154 ---> Sync.Report
Consumer.0155 ---> Sync.Report
Consumer.0156 ---> Sync.Report
Consumer.0157 ---> Sync.Report
Consumer.0158 ---> Sync.Report
Consumer.0159 ---> Sync.Report
Consumer.015a ---> Sync.Report
Consumer.015b ---> Sync.Report
Consumer.015c ---> Sync.Report
Consumer.015d ---> Sync.Report
Consumer.015e ---> Sync.Report
Consumer.015f ---> Sync.Report
Consumer.0160 ---> Sync.Report
Consumer.0161 ---> Sync.Report
Consumer.0162 ---> Sync.Report
Consumer.0163 ---> Sync.Report
Consumer.0164 ---> Sync.Report
Consumer.0165 ---> Sync.Report
Consumer.0166 ---> Sync.Report
Consumer.0167 ---> Sync.Report
Consumer.0168 ---> Sync.Report
Consumer.0169 ---> Sync.Report
Consumer.016a ---> Sync.Report
Consumer.016b ---> Sync.Report
Consumer.016c ---> Sync.Report
Consumer.016d ---> Sync.Report
Consumer.016e ---> Sync.Report
Consumer.016f ---> Sync.Report
Consumer.0170 ---> Sync.Report
Consumer.0171 ---> Sync.Report
Consumer.0172 ---> Sync.Report
Consumer.0173 ---> Sync.Report
Consumer.0174 ---> Sync.Report
Consumer.0175 ---> Sync.Report
Consumer.0176 ---> Sync.Report
Consumer.0177 ---> Sync.Report
Consumer.0178 ---> Sync.Report
Consumer.0179 ---> Sync.Report
Consumer.017a ---> Sync.Report
Consumer.017b ---> Sync.Report
Consumer.017c ---> Sync.Report
Consumer.017d ---> Sync.Report
Consumer.017e ---> Sync.Report
Consumer.017f ---> Sync.Report
Consumer.0180 ---> Sync.Report
Consumer.0181 ---> Sync.Report
Consumer.0182 ---> Key.Bookmarks
Consumer.0183 ---> Key.Config
Consumer.0184 ---> Key.?
Consumer.0185 ---> Key.?
Consumer.0186 ---> Key.?
Consumer.0187 ---> Key.?
Consumer.0188 ---> Key.?
Consumer.0189 ---> Key.?
Consumer.018a ---> Key.Mail
Consumer.018b ---> Key.?
Consumer.018c ---> Key.?
Consumer.018d ---> Key.?
Consumer.018e ---> Key.Calendar
Consumer.018f ---> Sync.Report
Consumer.0190 ---> Sync.Report
Consumer.0191 ---> Key.Finance
Consumer.0192 ---> Key.Calc
Consumer.0193 ---> Key.Player
Consumer.0194 ---> Key.File
Consumer.0195 ---> Sync.Report
Consumer.0196 ---> Key.WWW
Consumer.0197 ---> Sync.Report
Consumer.0198 ---> Sync.Report
Consumer.0199 ---> Key.Chat
Consumer.019a ---> Sync.Report
Consumer.019b ---> Sync.Report
Consumer.019c ---> Key.Logoff
Consumer.019d ---> Sync.Report
Consumer.019e ---> Key.Coffee
Consumer.019f ---> Sync.Report
Consumer.01a0 ---> Sync.Report
Consumer.01a1 ---> Sync.Report
Consumer.01a2 ---> Sync.Report
Consumer.01a3 ---> Sync.Report
Consumer.01a4 ---> Sync.Report
Consumer.01a5 ---> Sync.Report
Consumer.01a6 ---> Key.Help
Consumer.01a7 ---> Key.Documents
Consumer.01a8 ---> Sync.Report
Consumer.01a9 ---> Sync.Report
Consumer.01aa ---> Sync.Report
Consumer.01ab ---> Key.SpellCheck
Consumer.01ac ---> Sync.Report
Consumer.01ad ---> Sync.Report
Consumer.01ae ---> Key.Keyboard
Consumer.01af ---> Sync.Report
Consumer.01b0 ---> Sync.Report
Consumer.01b1 ---> Sync.Report
Consumer.01b2 ---> Sync.Report
Consumer.01b3 ---> Sync.Report
Consumer.01b4 ---> Sync.Report
Consumer.01b5 ---> Sync.Report
Consumer.01b6 ---> Key.?
Consumer.01b7 ---> Key.Audio
Consumer.01b8 ---> Key.Video
Consumer.01b9 ---> Sync.Report
Consumer.01ba ---> Sync.Report
Consumer.01bb ---> Sync.Report
Consumer.01bc ---> Key.?
Consumer.01bd ---> Key.Info
Consumer.01be ---> Sync.Report
Consumer.01bf ---> Sync.Report
Consumer.01c0 ---> Sync.Report
Consumer.01c1 ---> Sync.Report
Consumer.01c2 ---> Sync.Report
Consumer.01c3 ---> Sync.Report
Consumer.01c4 ---> Sync.Report
Consumer.01c5 ---> Sync.Report
Consumer.01c6 ---> Sync.Report
Consumer.01c7 ---> Sync.Report
Consumer.01c8 ---> Sync.Report
Consumer.01c9 ---> Sync.Report
Consumer.01ca ---> Sync.Report
Consumer.01cb ---> Sync.Report
Consumer.01cc ---> Sync.Report
Consumer.01cd ---> Sync.Report
Consumer.01ce ---> Sync.Report
Consumer.01cf ---> Sync.Report
Consumer.01d0 ---> Sync.Report
Consumer.01d1 ---> Sync.Report
Consumer.01d2 ---> Sync.Report
Consumer.01d3 ---> Sync.Report
Consumer.01d4 ---> Sync.Report
Consumer.01d5 ---> Sync.Report
Consumer.01d6 ---> Sync.Report
Consumer.01d7 ---> Sync.Report
Consumer.01d8 ---> Sync.Report
Consumer.01d9 ---> Sync.Report
Consumer.01da ---> Sync.Report
Consumer.01db ---> Sync.Report
Consumer.01dc ---> Sync.Report
Consumer.01dd ---> Sync.Report
Consumer.01de ---> Sync.Report
Consumer.01df ---> Sync.Report
Consumer.01e0 ---> Sync.Report
Consumer.01e1 ---> Sync.Report
Consumer.01e2 ---> Sync.Report
Consumer.01e3 ---> Sync.Report
Consumer.01e4 ---> Sync.Report
Consumer.01e5 ---> Sync.Report
Consumer.01e6 ---> Sync.Report
Consumer.01e7 ---> Sync.Report
Consumer.01e8 ---> Sync.Report
Consumer.01e9 ---> Sync.Report
Consumer.01ea ---> Sync.Report
Consumer.01eb ---> Sync.Report
Consumer.01ec ---> Sync.Report
Consumer.01ed ---> Sync.Report
Consumer.01ee ---> Sync.Report
Consumer.01ef ---> Sync.Report
Consumer.01f0 ---> Sync.Report
Consumer.01f1 ---> Sync.Report
Consumer.01f2 ---> Sync.Report
Consumer.01f3 ---> Sync.Report
Consumer.01f4 ---> Sync.Report
Consumer.01f5 ---> Sync.Report
Consumer.01f6 ---> Sync.Report
Consumer.01f7 ---> Sync.Report
Consumer.01f8 ---> Sync.Report
Consumer.01f9 ---> Sync.Report
Consumer.01fa ---> Sync.Report
Consumer.01fb ---> Sync.Report
Consumer.01fc ---> Sync.Report
Consumer.01fd ---> Sync.Report
Consumer.01fe ---> Sync.Report
Consumer.01ff ---> Sync.Report
Consumer.0200 ---> Sync.Report
Consumer.0201 ---> Key.New
Consumer.0202 ---> Key.Open
Consumer.0203 ---> Key.Close
Consumer.0204 ---> Key.Exit
Consumer.0205 ---> Sync.Report
Consumer.0206 ---> Sync.Report
Consumer.0207 ---> Key.Save
Consumer.0208 ---> Key.Print
Consumer.0209 ---> Key.Props
Consumer.020a ---> Sync.Report
Consumer.020b ---> Sync.Report
Consumer.020c ---> Sync.Report
Consumer.020d ---> Sync.Report
Consumer.020e ---> Sync.Report
Consumer.020f ---> Sync.Report
Consumer.0210 ---> Sync.Report
Consumer.0211 ---> Sync.Report
Consumer.0212 ---> Sync.Report
Consumer.0213 ---> Sync.Report
Consumer.0214 ---> Sync.Report
Consumer.0215 ---> Sync.Report
Consumer.0216 ---> Sync.Report
Consumer.0217 ---> Sync.Report
Consumer.0218 ---> Sync.Report
Consumer.0219 ---> Sync.Report
Consumer.021a ---> Key.Undo
Consumer.021b ---> Key.Copy
Consumer.021c ---> Key.Cut
Consumer.021d ---> Key.Paste
Consumer.021e ---> Sync.Report
Consumer.021f ---> Key.Find
Consumer.0220 ---> Sync.Report
Consumer.0221 ---> Key.Search
Consumer.0222 ---> Key.Goto
Consumer.0223 ---> Key.HomePage
Consumer.0224 ---> Key.Back
Consumer.0225 ---> Key.Forward
Consumer.0226 ---> Key.Stop
Consumer.0227 ---> Key.Refresh
Consumer.0228 ---> Sync.Report
Consumer.0229 ---> Sync.Report
Consumer.022a ---> Key.Bookmarks
Consumer.022b ---> Sync.Report
Consumer.022c ---> Sync.Report
Consumer.022d ---> Key.?
Consumer.022e ---> Key.?
Consumer.022f ---> Key.?
Consumer.0230 ---> Sync.Report
Consumer.0231 ---> Sync.Report
Consumer.0232 ---> Sync.Report
Consumer.0233 ---> Key.ScrollUp
Consumer.0234 ---> Key.ScrollDown
Consumer.0235 ---> Sync.Report
Consumer.0236 ---> Sync.Report
Consumer.0237 ---> Sync.Report
Consumer.HorizontalWheel ---> Relative.Dial
Consumer.0239 ---> Sync.Report
Consumer.023a ---> Sync.Report
Consumer.023b ---> Sync.Report
Consumer.023c ---> Sync.Report
Consumer.023d ---> Key.Edit
Consumer.023e ---> Sync.Report
Consumer.023f ---> Sync.Report
Consumer.0240 ---> Sync.Report
Consumer.0241 ---> Sync.Report
Consumer.0242 ---> Sync.Report
Consumer.0243 ---> Sync.Report
Consumer.0244 ---> Sync.Report
Consumer.0245 ---> Sync.Report
Consumer.0246 ---> Sync.Report
Consumer.0247 ---> Sync.Report
Consumer.0248 ---> Sync.Report
Consumer.0249 ---> Sync.Report
Consumer.024a ---> Sync.Report
Consumer.024b ---> Sync.Report
Consumer.024c ---> Sync.Report
Consumer.024d ---> Sync.Report
Consumer.024e ---> Sync.Report
Consumer.024f ---> Sync.Report
Consumer.0250 ---> Sync.Report
Consumer.0251 ---> Sync.Report
Consumer.0252 ---> Sync.Report
Consumer.0253 ---> Sync.Report
Consumer.0254 ---> Sync.Report
Consumer.0255 ---> Sync.Report
Consumer.0256 ---> Sync.Report
Consumer.0257 ---> Sync.Report
Consumer.0258 ---> Sync.Report
Consumer.0259 ---> Sync.Report
Consumer.025a ---> Sync.Report
Consumer.025b ---> Sync.Report
Consumer.025c ---> Sync.Report
Consumer.025d ---> Sync.Report
Consumer.025e ---> Sync.Report
Consumer.025f ---> Key.Cancel
Consumer.0260 ---> Sync.Report
Consumer.0261 ---> Sync.Report
Consumer.0262 ---> Sync.Report
Consumer.0263 ---> Sync.Report
Consumer.0264 ---> Sync.Report
Consumer.0265 ---> Sync.Report
Consumer.0266 ---> Sync.Report
Consumer.0267 ---> Sync.Report
Consumer.0268 ---> Sync.Report
Consumer.0269 ---> Key.Insert
Consumer.026a ---> Key.Delete
Consumer.026b ---> Sync.Report
Consumer.026c ---> Sync.Report
Consumer.026d ---> Sync.Report
Consumer.026e ---> Sync.Report
Consumer.026f ---> Sync.Report
Consumer.0270 ---> Sync.Report
Consumer.0271 ---> Sync.Report
Consumer.0272 ---> Sync.Report
Consumer.0273 ---> Sync.Report
Consumer.0274 ---> Sync.Report
Consumer.0275 ---> Sync.Report
Consumer.0276 ---> Sync.Report
Consumer.0277 ---> Sync.Report
Consumer.0278 ---> Sync.Report
Consumer.0279 ---> Key.Redo
Consumer.027a ---> Sync.Report
Consumer.027b ---> Sync.Report
Consumer.027c ---> Sync.Report
Consumer.027d ---> Sync.Report
Consumer.027e ---> Sync.Report
Consumer.027f ---> Sync.Report
Consumer.0280 ---> Sync.Report
Consumer.0281 ---> Sync.Report
Consumer.0282 ---> Sync.Report
Consumer.0283 ---> Sync.Report
Consumer.0284 ---> Sync.Report
Consumer.0285 ---> Sync.Report
Consumer.0286 ---> Sync.Report
Consumer.0287 ---> Sync.Report
Consumer.0288 ---> Sync.Report
Consumer.0289 ---> Key.Reply
Consumer.028a ---> Sync.Report
Consumer.028b ---> Key.ForwardMail
Consumer.028c ---> Key.Send
Consumer.028d ---> Sync.Report
Consumer.028e ---> Sync.Report
Consumer.028f ---> Sync.Report
Consumer.0290 ---> Sync.Report
Consumer.0291 ---> Sync.Report
Consumer.0292 ---> Sync.Report
Consumer.0293 ---> Sync.Report
Consumer.0294 ---> Sync.Report
Consumer.0295 ---> Sync.Report
Consumer.0296 ---> Sync.Report
Consumer.0297 ---> Sync.Report
Consumer.0298 ---> Sync.Report
Consumer.0299 ---> Sync.Report
Consumer.029a ---> Sync.Report
Consumer.029b ---> Sync.Report
Consumer.029c ---> Sync.Report
Consumer.029d ---> Sync.Report
Consumer.029e ---> Sync.Report
Consumer.029f ---> Sync.Report
Consumer.02a0 ---> Sync.Report
Consumer.02a1 ---> Sync.Report
Consumer.02a2 ---> Sync.Report
Consumer.02a3 ---> Sync.Report
Consumer.02a4 ---> Sync.Report
Consumer.02a5 ---> Sync.Report
Consumer.02a6 ---> Sync.Report
Consumer.02a7 ---> Sync.Report
Consumer.02a8 ---> Sync.Report
Consumer.02a9 ---> Sync.Report
Consumer.02aa ---> Sync.Report
Consumer.02ab ---> Sync.Report
Consumer.02ac ---> Sync.Report
Consumer.02ad ---> Sync.Report
Consumer.02ae ---> Sync.Report
Consumer.02af ---> Sync.Report
Consumer.02b0 ---> Sync.Report
Consumer.02b1 ---> Sync.Report
Consumer.02b2 ---> Sync.Report
Consumer.02b3 ---> Sync.Report
Consumer.02b4 ---> Sync.Report
Consumer.02b5 ---> Sync.Report
Consumer.02b6 ---> Sync.Report
Consumer.02b7 ---> Sync.Report
Consumer.02b8 ---> Sync.Report
Consumer.02b9 ---> Sync.Report
Consumer.02ba ---> Sync.Report
Consumer.02bb ---> Sync.Report
Consumer.02bc ---> Sync.Report
Consumer.02bd ---> Sync.Report
Consumer.02be ---> Sync.Report
Consumer.02bf ---> Sync.Report
Consumer.02c0 ---> Sync.Report
Consumer.02c1 ---> Sync.Report
Consumer.02c2 ---> Sync.Report
Consumer.02c3 ---> Sync.Report
Consumer.02c4 ---> Sync.Report
Consumer.02c5 ---> Sync.Report
Consumer.02c6 ---> Sync.Report
Consumer.02c7 ---> Sync.Report
Consumer.02c8 ---> Sync.Report
Consumer.02c9 ---> Sync.Report
Consumer.02ca ---> Sync.Report
Consumer.02cb ---> Sync.Report
Consumer.02cc ---> Sync.Report
Consumer.02cd ---> Sync.Report
Consumer.02ce ---> Sync.Report
Consumer.02cf ---> Sync.Report
Consumer.02d0 ---> Sync.Report
Consumer.02d1 ---> Sync.Report
Consumer.02d2 ---> Sync.Report
Consumer.02d3 ---> Sync.Report
Consumer.02d4 ---> Sync.Report
Consumer.02d5 ---> Sync.Report
Consumer.02d6 ---> Sync.Report
Consumer.02d7 ---> Sync.Report
Consumer.02d8 ---> Sync.Report
Consumer.02d9 ---> Sync.Report
Consumer.02da ---> Sync.Report
Consumer.02db ---> Sync.Report
Consumer.02dc ---> Sync.Report
Consumer.02dd ---> Sync.Report
Consumer.02de ---> Sync.Report
Consumer.02df ---> Sync.Report
Consumer.02e0 ---> Sync.Report
Consumer.02e1 ---> Sync.Report
Consumer.02e2 ---> Sync.Report
Consumer.02e3 ---> Sync.Report
Consumer.02e4 ---> Sync.Report
Consumer.02e5 ---> Sync.Report
Consumer.02e6 ---> Sync.Report
Consumer.02e7 ---> Sync.Report
Consumer.02e8 ---> Sync.Report
Consumer.02e9 ---> Sync.Report
Consumer.02ea ---> Sync.Report
Consumer.02eb ---> Sync.Report
Consumer.02ec ---> Sync.Report
Consumer.02ed ---> Sync.Report
Consumer.02ee ---> Sync.Report
Consumer.02ef ---> Sync.Report
Consumer.02f0 ---> Sync.Report
Consumer.02f1 ---> Sync.Report
Consumer.02f2 ---> Sync.Report
Consumer.02f3 ---> Sync.Report
Consumer.02f4 ---> Sync.Report
Consumer.02f5 ---> Sync.Report
Consumer.02f6 ---> Sync.Report
Consumer.02f7 ---> Sync.Report
Consumer.02f8 ---> Sync.Report
Consumer.02f9 ---> Sync.Report
Consumer.02fa ---> Sync.Report
Consumer.02fb ---> Sync.Report
Consumer.02fc ---> Sync.Report
Consumer.02fd ---> Sync.Report
Consumer.02fe ---> Sync.Report
Consumer.02ff ---> Sync.Report
Consumer.0300 ---> Sync.Report
Consumer.0301 ---> Sync.Report
Consumer.0302 ---> Sync.Report
Consumer.0303 ---> Sync.Report
Consumer.0304 ---> Sync.Report
Consumer.0305 ---> Sync.Report
Consumer.0306 ---> Sync.Report
Consumer.0307 ---> Sync.Report
Consumer.0308 ---> Sync.Report
Consumer.0309 ---> Sync.Report
Consumer.030a ---> Sync.Report
Consumer.030b ---> Sync.Report
Consumer.030c ---> Sync.Report
Consumer.030d ---> Sync.Report
Consumer.030e ---> Sync.Report
Consumer.030f ---> Sync.Report
Consumer.0310 ---> Sync.Report
Consumer.0311 ---> Sync.Report
Consumer.0312 ---> Sync.Report
Consumer.0313 ---> Sync.Report
Consumer.0314 ---> Sync.Report
Consumer.0315 ---> Sync.Report
Consumer.0316 ---> Sync.Report
Consumer.0317 ---> Sync.Report
Consumer.0318 ---> Sync.Report
Consumer.0319 ---> Sync.Report
Consumer.031a ---> Sync.Report
Consumer.031b ---> Sync.Report
Consumer.031c ---> Sync.Report
Consumer.031d ---> Sync.Report
Consumer.031e ---> Sync.Report
Consumer.031f ---> Sync.Report
Consumer.0320 ---> Sync.Report
Consumer.0321 ---> Sync.Report
Consumer.0322 ---> Sync.Report
Consumer.0323 ---> Sync.Report
Consumer.0324 ---> Sync.Report
Consumer.0325 ---> Sync.Report
Consumer.0326 ---> Sync.Report
Consumer.0327 ---> Sync.Report
Consumer.0328 ---> Sync.Report
Consumer.0329 ---> Sync.Report
Consumer.032a ---> Sync.Report
Consumer.032b ---> Sync.Report
Consumer.032c ---> Sync.Report
Consumer.032d ---> Sync.Report
Consumer.032e ---> Sync.Report
Consumer.032f ---> Sync.Report
Consumer.0330 ---> Sync.Report
Consumer.0331 ---> Sync.Report
Consumer.0332 ---> Sync.Report
Consumer.0333 ---> Sync.Report
Consumer.0334 ---> Sync.Report
Consumer.0335 ---> Sync.Report
Consumer.0336 ---> Sync.Report
Consumer.0337 ---> Sync.Report
Consumer.0338 ---> Sync.Report
Consumer.0339 ---> Sync.Report
Consumer.033a ---> Sync.Report
Consumer.033b ---> Sync.Report
Consumer.033c ---> Sync.Report
Consumer.033d ---> Sync.Report
Consumer.033e ---> Sync.Report
Consumer.033f ---> Sync.Report
Consumer.0340 ---> Sync.Report
Consumer.0341 ---> Sync.Report
Consumer.0342 ---> Sync.Report
Consumer.0343 ---> Sync.Report
Consumer.0344 ---> Sync.Report
Consumer.0345 ---> Sync.Report
Consumer.0346 ---> Sync.Report
Consumer.0347 ---> Sync.Report
Consumer.0348 ---> Sync.Report
Consumer.0349 ---> Sync.Report
Consumer.034a ---> Sync.Report
Consumer.034b ---> Sync.Report
Consumer.034c ---> Sync.Report
Consumer.034d ---> Sync.Report
Consumer.034e ---> Sync.Report
Consumer.034f ---> Sync.Report
Consumer.0350 ---> Sync.Report
Consumer.0351 ---> Sync.Report
Consumer.0352 ---> Sync.Report
Consumer.0353 ---> Sync.Report
Consumer.0354 ---> Sync.Report
Consumer.0355 ---> Sync.Report
Consumer.0356 ---> Sync.Report
Consumer.0357 ---> Sync.Report
Consumer.0358 ---> Sync.Report
Consumer.0359 ---> Sync.Report
Consumer.035a ---> Sync.Report
Consumer.035b ---> Sync.Report
Consumer.035c ---> Sync.Report
Consumer.035d ---> Sync.Report
Consumer.035e ---> Sync.Report
Consumer.035f ---> Sync.Report
Consumer.0360 ---> Sync.Report
Consumer.0361 ---> Sync.Report
Consumer.0362 ---> Sync.Report
Consumer.0363 ---> Sync.Report
Consumer.0364 ---> Sync.Report
Consumer.0365 ---> Sync.Report
Consumer.0366 ---> Sync.Report
Consumer.0367 ---> Sync.Report
Consumer.0368 ---> Sync.Report
Consumer.0369 ---> Sync.Report
Consumer.036a ---> Sync.Report
Consumer.036b ---> Sync.Report
Consumer.036c ---> Sync.Report
Consumer.036d ---> Sync.Report
Consumer.036e ---> Sync.Report
Consumer.036f ---> Sync.Report
Consumer.0370 ---> Sync.Report
Consumer.0371 ---> Sync.Report
Consumer.0372 ---> Sync.Report
Consumer.0373 ---> Sync.Report
Consumer.0374 ---> Sync.Report
Consumer.0375 ---> Sync.Report
Consumer.0376 ---> Sync.Report
Consumer.0377 ---> Sync.Report
Consumer.0378 ---> Sync.Report
Consumer.0379 ---> Sync.Report
Consumer.037a ---> Sync.Report
Consumer.037b ---> Sync.Report
Consumer.037c ---> Sync.Report
Consumer.037d ---> Sync.Report
Consumer.037e ---> Sync.Report
Consumer.037f ---> Sync.Report
Consumer.0380 ---> Sync.Report
Consumer.0381 ---> Sync.Report
Consumer.0382 ---> Sync.Report
Consumer.0383 ---> Sync.Report
Consumer.0384 ---> Sync.Report
Consumer.0385 ---> Sync.Report
Consumer.0386 ---> Sync.Report
Consumer.0387 ---> Sync.Report
Consumer.0388 ---> Sync.Report
Consumer.0389 ---> Sync.Report
Consumer.038a ---> Sync.Report
Consumer.038b ---> Sync.Report
Consumer.038c ---> Sync.Report
Consumer.038d ---> Sync.Report
Consumer.038e ---> Sync.Report
Consumer.038f ---> Sync.Report
Consumer.0390 ---> Sync.Report
Consumer.0391 ---> Sync.Report
Consumer.0392 ---> Sync.Report
Consumer.0393 ---> Sync.Report
Consumer.0394 ---> Sync.Report
Consumer.0395 ---> Sync.Report
Consumer.0396 ---> Sync.Report
Consumer.0397 ---> Sync.Report
Consumer.0398 ---> Sync.Report
Consumer.0399 ---> Sync.Report
Consumer.039a ---> Sync.Report
Consumer.039b ---> Sync.Report
Consumer.039c ---> Sync.Report
Consumer.039d ---> Sync.Report
Consumer.039e ---> Sync.Report
Consumer.039f ---> Sync.Report
Consumer.03a0 ---> Sync.Report
Consumer.03a1 ---> Sync.Report
Consumer.03a2 ---> Sync.Report
Consumer.03a3 ---> Sync.Report
Consumer.03a4 ---> Sync.Report
Consumer.03a5 ---> Sync.Report
Consumer.03a6 ---> Sync.Report
Consumer.03a7 ---> Sync.Report
Consumer.03a8 ---> Sync.Report
Consumer.03a9 ---> Sync.Report
Consumer.03aa ---> Sync.Report
Consumer.03ab ---> Sync.Report
Consumer.03ac ---> Sync.Report
Consumer.03ad ---> Sync.Report
Consumer.03ae ---> Sync.Report
Consumer.03af ---> Sync.Report
Consumer.03b0 ---> Sync.Report
Consumer.03b1 ---> Sync.Report
Consumer.03b2 ---> Sync.Report
Consumer.03b3 ---> Sync.Report
Consumer.03b4 ---> Sync.Report
Consumer.03b5 ---> Sync.Report
Consumer.03b6 ---> Sync.Report
Consumer.03b7 ---> Sync.Report
Consumer.03b8 ---> Sync.Report
Consumer.03b9 ---> Sync.Report
Consumer.03ba ---> Sync.Report
Consumer.03bb ---> Sync.Report
Consumer.03bc ---> Sync.Report
Consumer.03bd ---> Sync.Report
Consumer.03be ---> Sync.Report
Consumer.03bf ---> Sync.Report
Consumer.03c0 ---> Sync.Report
Consumer.03c1 ---> Sync.Report
Consumer.03c2 ---> Sync.Report
Consumer.03c3 ---> Sync.Report
Consumer.03c4 ---> Sync.Report
Consumer.03c5 ---> Sync.Report
Consumer.03c6 ---> Sync.Report
Consumer.03c7 ---> Sync.Report
Consumer.03c8 ---> Sync.Report
Consumer.03c9 ---> Sync.Report
Consumer.03ca ---> Sync.Report
Consumer.03cb ---> Sync.Report
Consumer.03cc ---> Sync.Report
Consumer.03cd ---> Sync.Report
Consumer.03ce ---> Sync.Report
Consumer.03cf ---> Sync.Report
Consumer.03d0 ---> Sync.Report
Consumer.03d1 ---> Sync.Report
Consumer.03d2 ---> Sync.Report
Consumer.03d3 ---> Sync.Report
Consumer.03d4 ---> Sync.Report
Consumer.03d5 ---> Sync.Report
Consumer.03d6 ---> Sync.Report
Consumer.03d7 ---> Sync.Report
Consumer.03d8 ---> Sync.Report
Consumer.03d9 ---> Sync.Report
Consumer.03da ---> Sync.Report
Consumer.03db ---> Sync.Report
Consumer.03dc ---> Sync.Report
Consumer.03dd ---> Sync.Report
Consumer.03de ---> Sync.Report
Consumer.03df ---> Sync.Report
Consumer.03e0 ---> Sync.Report
Consumer.03e1 ---> Sync.Report
Consumer.03e2 ---> Sync.Report
Consumer.03e3 ---> Sync.Report
Consumer.03e4 ---> Sync.Report
Consumer.03e5 ---> Sync.Report
Consumer.03e6 ---> Sync.Report
Consumer.03e7 ---> Sync.Report
Consumer.03e8 ---> Sync.Report
Consumer.03e9 ---> Sync.Report
Consumer.03ea ---> Sync.Report
Consumer.03eb ---> Sync.Report
Consumer.03ec ---> Sync.Report
Consumer.03ed ---> Sync.Report
Consumer.03ee ---> Sync.Report
Consumer.03ef ---> Sync.Report
Consumer.03f0 ---> Sync.Report
Consumer.03f1 ---> Sync.Report
Consumer.03f2 ---> Sync.Report
Consumer.03f3 ---> Sync.Report
Consumer.03f4 ---> Sync.Report
Consumer.03f5 ---> Sync.Report
Consumer.03f6 ---> Sync.Report
Consumer.03f7 ---> Sync.Report
Consumer.03f8 ---> Sync.Report
Consumer.03f9 ---> Sync.Report
Consumer.03fa ---> Sync.Report
Consumer.03fb ---> Sync.Report
Consumer.03fc ---> Sync.Report
Consumer.03fd ---> Sync.Report
Consumer.03fe ---> Sync.Report
Consumer.03ff ---> Sync.Report
ff00.fd01 ---> Sync.Report
ff00.fd02 ---> Sync.Report
ff00.fd03 ---> Sync.Report
ff00.fd04 ---> Sync.Report
ff00.fd05 ---> Sync.Report
ff00.fd06 ---> Sync.Report
ff00.fd07 ---> Sync.Report
ff00.fd08 ---> Sync.Report
ff00.fd09 ---> Sync.Report
ff00.fd0a ---> Sync.Report
ff00.fd0b ---> Sync.Report
ff00.fd0c ---> Sync.Report
ff00.fd0d ---> Sync.Report
ff00.fd0e ---> Sync.Report
ff00.fd0f ---> Sync.Report
ff00.fd10 ---> Sync.Report
ff00.fd11 ---> Sync.Report
ff00.fd12 ---> Sync.Report
ff00.fd13 ---> Sync.Report
ff00.fd14 ---> Sync.Report
ff00.fd15 ---> Sync.Report
ff00.fd16 ---> Sync.Report
ff00.fd17 ---> Sync.Report
ff00.fd18 ---> Sync.Report
ff00.fd19 ---> Sync.Report
ff00.fd1a ---> Sync.Report
ff00.fd1b ---> Sync.Report
ff00.fd1c ---> Sync.Report
ff00.fd1d ---> Sync.Report
ff00.fd1e ---> Sync.Report
ff00.fd1f ---> Sync.Report
ff00.fd20 ---> Sync.Report
ff00.fd21 ---> Sync.Report
ff00.fd22 ---> Sync.Report
ff00.fd23 ---> Sync.Report
ff00.fd24 ---> Sync.Report
ff00.fd25 ---> Sync.Report
ff00.fd26 ---> Sync.Report
ff00.fd27 ---> Sync.Report
ff00.fd28 ---> Sync.Report
ff00.fd29 ---> Sync.Report
ff00.fd2a ---> Sync.Report
ff00.fd2b ---> Sync.Report
ff00.fd2c ---> Sync.Report
ff00.fd2d ---> Sync.Report
ff00.fd2e ---> Sync.Report
ff00.fd2f ---> Sync.Report
ff00.fd30 ---> Sync.Report
ff00.fd31 ---> Sync.Report
ff00.fd32 ---> Sync.Report
ff00.fd33 ---> Sync.Report
ff00.fd34 ---> Sync.Report
ff00.fd35 ---> Sync.Report
ff00.fd36 ---> Sync.Report
ff00.fd37 ---> Sync.Report
ff00.fd38 ---> Sync.Report
ff00.fd39 ---> Sync.Report
ff00.fd3a ---> Sync.Report
ff00.fd3b ---> Sync.Report
ff00.fd3c ---> Sync.Report
ff00.fd3d ---> Sync.Report
ff00.fd3e ---> Sync.Report
ff00.fd3f ---> Sync.Report
ff00.fd40 ---> Sync.Report
ff00.fd41 ---> Sync.Report
ff00.fd42 ---> Sync.Report
ff00.fd43 ---> Sync.Report
ff00.fd44 ---> Sync.Report
ff00.fd45 ---> Sync.Report
ff00.fd46 ---> Sync.Report
ff00.fd47 ---> Sync.Report
ff00.fd48 ---> Sync.Report
ff00.fd49 ---> Sync.Report
ff00.fd4a ---> Sync.Report
ff00.fd4b ---> Sync.Report
ff00.fd4c ---> Sync.Report
ff00.fd4d ---> Sync.Report
ff00.fd4e ---> Sync.Report
ff00.fd4f ---> Sync.Report
ff00.fd50 ---> Sync.Report
ff00.fd51 ---> Sync.Report
ff00.fd52 ---> Sync.Report
ff00.fd53 ---> Sync.Report
ff00.fd54 ---> Sync.Report
ff00.fd55 ---> Sync.Report
ff00.fd56 ---> Sync.Report
ff00.fd57 ---> Sync.Report
ff00.fd58 ---> Sync.Report
ff00.fd59 ---> Sync.Report
ff00.fd5a ---> Sync.Report
ff00.fd5b ---> Sync.Report
ff00.fd5c ---> Sync.Report
ff00.fd5d ---> Sync.Report
ff00.fd5e ---> Sync.Report
ff00.fd5f ---> Sync.Report
ff00.fd60 ---> Sync.Report
ff00.fd61 ---> Sync.Report
ff00.fd62 ---> Sync.Report
ff00.fd63 ---> Sync.Report
ff00.fd64 ---> Sync.Report
ff00.fd65 ---> Sync.Report
ff00.fd66 ---> Sync.Report
ff00.fd67 ---> Sync.Report
ff00.fd68 ---> Sync.Report
ff00.fd69 ---> Sync.Report
ff00.fd6a ---> Sync.Report
ff00.fd6b ---> Sync.Report
ff00.fd6c ---> Sync.Report
ff00.fd6d ---> Sync.Report
ff00.fd6e ---> Sync.Report
ff00.fd6f ---> Sync.Report
ff00.fd70 ---> Sync.Report
ff00.fd71 ---> Sync.Report
ff00.fd72 ---> Sync.Report
ff00.fd73 ---> Sync.Report
ff00.fd74 ---> Sync.Report
ff00.fd75 ---> Sync.Report
ff00.fd76 ---> Sync.Report
ff00.fd77 ---> Sync.Report
ff00.fd78 ---> Sync.Report
ff00.fd79 ---> Sync.Report
ff00.fd7a ---> Sync.Report
ff00.fd7b ---> Sync.Report
ff00.fd7c ---> Sync.Report
ff00.fd7d ---> Sync.Report
ff00.fd7e ---> Sync.Report
ff00.fd7f ---> Sync.Report
ff00.fd80 ---> Sync.Report
ff00.fd81 ---> Sync.Report
ff00.fd82 ---> Sync.Report
ff00.fd83 ---> Sync.Report
ff00.fd84 ---> Sync.Report
ff00.fd85 ---> Sync.Report
ff00.fd86 ---> Sync.Report
ff00.fd87 ---> Sync.Report
ff00.fd88 ---> Sync.Report
ff00.fd89 ---> Sync.Report
ff00.fd8a ---> Sync.Report
ff00.fd8b ---> Sync.Report
ff00.fd8c ---> Sync.Report
ff00.fd8d ---> Sync.Report
ff00.fd8e ---> Sync.Report
ff00.fd8f ---> Sync.Report
ff00.fd90 ---> Sync.Report
ff00.fd91 ---> Sync.Report
ff00.fd92 ---> Sync.Report
ff00.fd93 ---> Sync.Report
ff00.fd94 ---> Sync.Report
ff00.fd95 ---> Sync.Report
ff00.fd96 ---> Sync.Report
ff00.fd97 ---> Sync.Report
ff00.fd98 ---> Sync.Report
ff00.fd99 ---> Sync.Report
ff00.fd9a ---> Sync.Report
ff00.fd9b ---> Sync.Report
ff00.fd9c ---> Sync.Report
ff00.fd9d ---> Sync.Report
ff00.fd9e ---> Sync.Report
ff00.fd9f ---> Sync.Report
ff00.fda0 ---> Sync.Report
ff00.fda1 ---> Sync.Report
ff00.fda2 ---> Sync.Report
ff00.fda3 ---> Sync.Report
ff00.fda4 ---> Sync.Report
ff00.fda5 ---> Sync.Report
ff00.fda6 ---> Sync.Report
ff00.fda7 ---> Sync.Report
ff00.fda8 ---> Sync.Report
ff00.fda9 ---> Sync.Report
ff00.fdaa ---> Sync.Report
ff00.fdab ---> Sync.Report
ff00.fdac ---> Sync.Report
ff00.fdad ---> Sync.Report
ff00.fdae ---> Sync.Report
ff00.fdaf ---> Sync.Report
ff00.fdb0 ---> Sync.Report
ff00.fdb1 ---> Sync.Report
ff00.fdb2 ---> Sync.Report
ff00.fdb3 ---> Sync.Report
ff00.fdb4 ---> Sync.Report
ff00.fdb5 ---> Sync.Report
ff00.fdb6 ---> Sync.Report
ff00.fdb7 ---> Sync.Report
ff00.fdb8 ---> Sync.Report
ff00.fdb9 ---> Sync.Report
ff00.fdba ---> Sync.Report
ff00.fdbb ---> Sync.Report
ff00.fdbc ---> Sync.Report
ff00.fdbd ---> Sync.Report
ff00.fdbe ---> Sync.Report
ff00.fdbf ---> Sync.Report
ff00.fdc0 ---> Sync.Report
ff00.fdc1 ---> Sync.Report
ff00.fdc2 ---> Sync.Report
ff00.fdc3 ---> Sync.Report
ff00.fdc4 ---> Sync.Report
ff00.fdc5 ---> Sync.Report
ff00.fdc6 ---> Sync.Report
ff00.fdc7 ---> Sync.Report
ff00.fdc8 ---> Sync.Report
ff00.fdc9 ---> Sync.Report
ff00.fdca ---> Sync.Report
ff00.fdcb ---> Sync.Report
ff00.fdcc ---> Sync.Report
ff00.fdcd ---> Sync.Report
ff00.fdce ---> Sync.Report
ff00.fdcf ---> Sync.Report
ff00.fdd0 ---> Sync.Report
ff00.fdd1 ---> Sync.Report
ff00.fdd2 ---> Sync.Report
ff00.fdd3 ---> Sync.Report
ff00.fdd4 ---> Sync.Report
ff00.fdd5 ---> Sync.Report
ff00.fdd6 ---> Sync.Report
ff00.fdd7 ---> Sync.Report
ff00.fdd8 ---> Sync.Report
ff00.fdd9 ---> Sync.Report
ff00.fdda ---> Sync.Report
ff00.fddb ---> Sync.Report
ff00.fddc ---> Sync.Report
ff00.fddd ---> Sync.Report
ff00.fdde ---> Sync.Report
ff00.fddf ---> Sync.Report
ff00.fde0 ---> Sync.Report
ff00.fde1 ---> Sync.Report
ff00.fde2 ---> Sync.Report
ff00.fde3 ---> Sync.Report
ff00.fde4 ---> Sync.Report
ff00.fde5 ---> Sync.Report
ff00.fde6 ---> Sync.Report
ff00.fde7 ---> Sync.Report
ff00.fde8 ---> Sync.Report
ff00.fde9 ---> Sync.Report
ff00.fdea ---> Sync.Report
ff00.fdeb ---> Sync.Report
ff00.fdec ---> Sync.Report
ff00.fded ---> Sync.Report
ff00.fdee ---> Sync.Report
ff00.fdef ---> Sync.Report
ff00.fdf0 ---> Sync.Report
ff00.fdf1 ---> Sync.Report
ff00.fdf2 ---> Sync.Report
ff00.fdf3 ---> Sync.Report
ff00.fdf4 ---> Sync.Report
ff00.fdf5 ---> Sync.Report
ff00.fdf6 ---> Sync.Report
ff00.fdf7 ---> Sync.Report
ff00.fdf8 ---> Sync.Report
ff00.fdf9 ---> Sync.Report
ff00.fdfa ---> Sync.Report
ff00.fdfb ---> Sync.Report
ff00.fdfc ---> Sync.Report
ff00.fdfd ---> Sync.Report
ff00.fdfe ---> Sync.Report
ff00.fdff ---> Sync.Report
ff00.ff25 ---> Sync.Report
Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
Button.0003 ---> Key.MiddleBtn
Button.0004 ---> Key.SideBtn
Button.0005 ---> Key.ExtraBtn
GenericDesktop.X ---> Relative.X
GenericDesktop.Y ---> Relative.Y
GenericDesktop.Wheel ---> Relative.Wheel
Consumer.HorizontalWheel ---> Relative.Misc
