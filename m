From: Octoploid <cryptooctoploid@gmail.com>
Subject: Re: Logitech M705 thumb button
Date: Tue, 30 Mar 2010 15:02:54 +0200
Message-ID: <319012f1003300602q708563ebo90b30c8d8b15e938@mail.gmail.com>
References: <hoqak4$m6t$1@dough.gmane.org>
	 <20100330065625.GC12764@core.coreip.homeip.net>
	 <319012f1003300033k254715dao7f9a807615df36df@mail.gmail.com>
	 <alpine.LRH.2.00.1003301418000.10181@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:59907 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756279Ab0C3NC5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Mar 2010 09:02:57 -0400
Received: by fxm23 with SMTP id 23so241859fxm.21
        for <linux-input@vger.kernel.org>; Tue, 30 Mar 2010 06:02:55 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.00.1003301418000.10181@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Mar 30, 2010 at 2:28 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 30 Mar 2010, Octoploid wrote:
>
>> >> Just bought a Logitech M705 mouse today and everything is working
>> >> fine except the thumb button. I just don't get any events in =BBx=
ev=AB or
>> >> =BBxinput test=AB when I press that button.
>> >> This mouse comes with the new =BBUnifying USB receiver=AB.
>> >>
>> >> Any hints on how I could get that button working?
>> >>
>> >
>> > Start with locating "evtest" utility and confirming that the keren=
l does
>> > not emit any events for the thumb button.
>>
>> Yes, there are no events emitted for the thumb button when running =BB=
evtest=AB.
>
> Could you please provide output of
>
> =A0 =A0 =A0 =A0cat /sys/kernel/debug/hid/<device>/rdesc
>
> and
>
> =A0 =A0 =A0 =A0cat /sys/kernel/debug/hid/<device>/events
>

Sure:

There are no events logged when I press the thumb button
while running cat /sys/kernel/debug/hid/0003:046D:C52B.0002/events.

(The =BBunifying USB reciever=AB has three sub-devices. The first one i=
s
for keyboards, the second for mouses and the third is not used:
usb 3-1: new full speed USB device using ohci_hcd and address 2
input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/input/input2
generic-usb 0003:046D:C52B.0001: input,hidraw0: USB HID v1.11 Keyboard
[Logitech USB Receiver] on usb-0000:00:12.0-1/input0
input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.1/input/input3
generic-usb 0003:046D:C52B.0002: input,hiddev96,hidraw1: USB HID v1.11
Mouse [Logitech USB Receiver] on usb-0000:00:12.0-1/input1
generic-usb 0003:046D:C52B.0003: hiddev97,hidraw2: USB HID v1.11
Device [Logitech USB Receiver] on usb-0000:00:12.0-1/input2)

The rdesc output for the mouse and the third device follows:


05 01 09 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 10 15 00 25 01 95
10 75 01 81 02 05 01 16 01 f8 26 ff 07 75 0c 95 02 09 30 09 31 81 06
15 81 25 7f 75 08 95 01 09 38 81 06 05 0c 0a 38 02 95 01 81 06 c0 c0
05 0c 09 01 a1 01 85 03 75 10 95 02 15 01 26 8c 02 19 01 2a 8c 02 81
00 c0 05 01 09 80 a1 01 85 04 75 02 95 01 15 01 25 03 09 82 09 81 09
83 81 60 75 06 81 03 c0 06 bc ff 09 88 a1 01 85 08 19 01 29 ff 15 01
26 ff 00 75 08 95 01 81 00 c0

  INPUT(2)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Usage(16)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
        Button.0009
        Button.000a
        Button.000b
        Button.000c
        Button.000d
        Button.000e
        Button.000f
        Button.0010
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(16)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Usage(2)
        GenericDesktop.X
        GenericDesktop.Y
      Logical Minimum(-2047)
      Logical Maximum(2047)
      Report Size(12)
      Report Count(2)
      Report Offset(16)
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
  INPUT(3)[INPUT]
    Field(0)
      Usage(652)
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
      Logical Minimum(1)
      Logical Maximum(652)
      Report Size(16)
      Report Count(2)
      Report Offset(0)
      Flags( Array Absolute )
  INPUT(4)[INPUT]
    Field(0)
      Usage(3)
        GenericDesktop.SystemSleep
        GenericDesktop.SystemPowerDown
        GenericDesktop.SystemWakeUp
      Logical Minimum(1)
      Logical Maximum(3)
      Report Size(2)
      Report Count(1)
      Report Offset(0)
      Flags( Array Absolute NoPreferredState NullState )
  INPUT(8)[INPUT]
    Field(0)
      Usage(255)
        ffbc.0001
        ffbc.0002
        ffbc.0003
        ffbc.0004
        ffbc.0005
        ffbc.0006
        ffbc.0007
        ffbc.0008
        ffbc.0009
        ffbc.000a
        ffbc.000b
        ffbc.000c
        ffbc.000d
        ffbc.000e
        ffbc.000f
        ffbc.0010
        ffbc.0011
        ffbc.0012
        ffbc.0013
        ffbc.0014
        ffbc.0015
        ffbc.0016
        ffbc.0017
        ffbc.0018
        ffbc.0019
        ffbc.001a
        ffbc.001b
        ffbc.001c
        ffbc.001d
        ffbc.001e
        ffbc.001f
        ffbc.0020
        ffbc.0021
        ffbc.0022
        ffbc.0023
        ffbc.0024
        ffbc.0025
        ffbc.0026
        ffbc.0027
        ffbc.0028
        ffbc.0029
        ffbc.002a
        ffbc.002b
        ffbc.002c
        ffbc.002d
        ffbc.002e
        ffbc.002f
        ffbc.0030
        ffbc.0031
        ffbc.0032
        ffbc.0033
        ffbc.0034
        ffbc.0035
        ffbc.0036
        ffbc.0037
        ffbc.0038
        ffbc.0039
        ffbc.003a
        ffbc.003b
        ffbc.003c
        ffbc.003d
        ffbc.003e
        ffbc.003f
        ffbc.0040
        ffbc.0041
        ffbc.0042
        ffbc.0043
        ffbc.0044
        ffbc.0045
        ffbc.0046
        ffbc.0047
        ffbc.0048
        ffbc.0049
        ffbc.004a
        ffbc.004b
        ffbc.004c
        ffbc.004d
        ffbc.004e
        ffbc.004f
        ffbc.0050
        ffbc.0051
        ffbc.0052
        ffbc.0053
        ffbc.0054
        ffbc.0055
        ffbc.0056
        ffbc.0057
        ffbc.0058
        ffbc.0059
        ffbc.005a
        ffbc.005b
        ffbc.005c
        ffbc.005d
        ffbc.005e
        ffbc.005f
        ffbc.0060
        ffbc.0061
        ffbc.0062
        ffbc.0063
        ffbc.0064
        ffbc.0065
        ffbc.0066
        ffbc.0067
        ffbc.0068
        ffbc.0069
        ffbc.006a
        ffbc.006b
        ffbc.006c
        ffbc.006d
        ffbc.006e
        ffbc.006f
        ffbc.0070
        ffbc.0071
        ffbc.0072
        ffbc.0073
        ffbc.0074
        ffbc.0075
        ffbc.0076
        ffbc.0077
        ffbc.0078
        ffbc.0079
        ffbc.007a
        ffbc.007b
        ffbc.007c
        ffbc.007d
        ffbc.007e
        ffbc.007f
        ffbc.0080
        ffbc.0081
        ffbc.0082
        ffbc.0083
        ffbc.0084
        ffbc.0085
        ffbc.0086
        ffbc.0087
        ffbc.0088
        ffbc.0089
        ffbc.008a
        ffbc.008b
        ffbc.008c
        ffbc.008d
        ffbc.008e
        ffbc.008f
        ffbc.0090
        ffbc.0091
        ffbc.0092
        ffbc.0093
        ffbc.0094
        ffbc.0095
        ffbc.0096
        ffbc.0097
        ffbc.0098
        ffbc.0099
        ffbc.009a
        ffbc.009b
        ffbc.009c
        ffbc.009d
        ffbc.009e
        ffbc.009f
        ffbc.00a0
        ffbc.00a1
        ffbc.00a2
        ffbc.00a3
        ffbc.00a4
        ffbc.00a5
        ffbc.00a6
        ffbc.00a7
        ffbc.00a8
        ffbc.00a9
        ffbc.00aa
        ffbc.00ab
        ffbc.00ac
        ffbc.00ad
        ffbc.00ae
        ffbc.00af
        ffbc.00b0
        ffbc.00b1
        ffbc.00b2
        ffbc.00b3
        ffbc.00b4
        ffbc.00b5
        ffbc.00b6
        ffbc.00b7
        ffbc.00b8
        ffbc.00b9
        ffbc.00ba
        ffbc.00bb
        ffbc.00bc
        ffbc.00bd
        ffbc.00be
        ffbc.00bf
        ffbc.00c0
        ffbc.00c1
        ffbc.00c2
        ffbc.00c3
        ffbc.00c4
        ffbc.00c5
        ffbc.00c6
        ffbc.00c7
        ffbc.00c8
        ffbc.00c9
        ffbc.00ca
        ffbc.00cb
        ffbc.00cc
        ffbc.00cd
        ffbc.00ce
        ffbc.00cf
        ffbc.00d0
        ffbc.00d1
        ffbc.00d2
        ffbc.00d3
        ffbc.00d4
        ffbc.00d5
        ffbc.00d6
        ffbc.00d7
        ffbc.00d8
        ffbc.00d9
        ffbc.00da
        ffbc.00db
        ffbc.00dc
        ffbc.00dd
        ffbc.00de
        ffbc.00df
        ffbc.00e0
        ffbc.00e1
        ffbc.00e2
        ffbc.00e3
        ffbc.00e4
        ffbc.00e5
        ffbc.00e6
        ffbc.00e7
        ffbc.00e8
        ffbc.00e9
        ffbc.00ea
        ffbc.00eb
        ffbc.00ec
        ffbc.00ed
        ffbc.00ee
        ffbc.00ef
        ffbc.00f0
        ffbc.00f1
        ffbc.00f2
        ffbc.00f3
        ffbc.00f4
        ffbc.00f5
        ffbc.00f6
        ffbc.00f7
        ffbc.00f8
        ffbc.00f9
        ffbc.00fa
        ffbc.00fb
        ffbc.00fc
        ffbc.00fd
        ffbc.00fe
        ffbc.00ff
      Logical Minimum(1)
      Logical Maximum(255)
      Report Size(8)
      Report Count(1)
      Report Offset(0)
      Flags( Array Absolute )

Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
Button.0003 ---> Key.MiddleBtn
Button.0004 ---> Key.SideBtn
Button.0005 ---> Key.ExtraBtn
Button.0006 ---> Key.ForwardBtn
Button.0007 ---> Key.BackBtn
Button.0008 ---> Key.TaskBtn
Button.0009 ---> Key.?
Button.000a ---> Key.?
Button.000b ---> Key.?
Button.000c ---> Key.?
Button.000d ---> Key.?
Button.000e ---> Key.?
Button.000f ---> Key.?
Button.0010 ---> Key.?
GenericDesktop.X ---> Relative.X
GenericDesktop.Y ---> Relative.Y
GenericDesktop.Wheel ---> Relative.Wheel
Consumer.HorizontalWheel ---> Relative.HWheel
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
Consumer.0030 ---> Sync.Report
Consumer.0031 ---> Sync.Report
Consumer.0032 ---> Sync.Report
Consumer.0033 ---> Sync.Report
Consumer.0034 ---> Key.Sleep
Consumer.0035 ---> Sync.Report
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
Consumer.0041 ---> Sync.Report
Consumer.0042 ---> Sync.Report
Consumer.0043 ---> Sync.Report
Consumer.0044 ---> Sync.Report
Consumer.0045 ---> Key.Radio
Consumer.0046 ---> Sync.Report
Consumer.0047 ---> Sync.Report
Consumer.0048 ---> Sync.Report
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
Consumer.0060 ---> Sync.Report
Consumer.0061 ---> Sync.Report
Consumer.0062 ---> Sync.Report
Consumer.0063 ---> Sync.Report
Consumer.0064 ---> Sync.Report
Consumer.0065 ---> Sync.Report
Consumer.0066 ---> Sync.Report
Consumer.0067 ---> Sync.Report
Consumer.0068 ---> Sync.Report
Consumer.0069 ---> Sync.Report
Consumer.006a ---> Sync.Report
Consumer.006b ---> Sync.Report
Consumer.006c ---> Sync.Report
Consumer.006d ---> Sync.Report
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
Consumer.0082 ---> Sync.Report
Consumer.0083 ---> Key.Last
Consumer.0084 ---> Sync.Report
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
Consumer.00b9 ---> Sync.Report
Consumer.00ba ---> Sync.Report
Consumer.00bb ---> Sync.Report
Consumer.00bc ---> Key.?
Consumer.00bd ---> Sync.Report
Consumer.00be ---> Sync.Report
Consumer.00bf ---> Sync.Report
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
Consumer.00f5 ---> Sync.Report
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
Consumer.0193 ---> Sync.Report
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
Consumer.01ae ---> Sync.Report
Consumer.01af ---> Sync.Report
Consumer.01b0 ---> Sync.Report
Consumer.01b1 ---> Sync.Report
Consumer.01b2 ---> Sync.Report
Consumer.01b3 ---> Sync.Report
Consumer.01b4 ---> Sync.Report
Consumer.01b5 ---> Sync.Report
Consumer.01b6 ---> Key.Media
Consumer.01b7 ---> Key.Sound
Consumer.01b8 ---> Sync.Report
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
Consumer.023d ---> Sync.Report
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
Consumer.0269 ---> Sync.Report
Consumer.026a ---> Sync.Report
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
GenericDesktop.SystemSleep ---> Key.Sleep
GenericDesktop.SystemPowerDown ---> Key.Power
GenericDesktop.SystemWakeUp ---> Key.WakeUp
ffbc.0001 ---> Sync.Report
ffbc.0002 ---> Sync.Report
ffbc.0003 ---> Sync.Report
ffbc.0004 ---> Sync.Report
ffbc.0005 ---> Sync.Report
ffbc.0006 ---> Sync.Report
ffbc.0007 ---> Sync.Report
ffbc.0008 ---> Sync.Report
ffbc.0009 ---> Sync.Report
ffbc.000a ---> Sync.Report
ffbc.000b ---> Sync.Report
ffbc.000c ---> Sync.Report
ffbc.000d ---> Sync.Report
ffbc.000e ---> Sync.Report
ffbc.000f ---> Sync.Report
ffbc.0010 ---> Sync.Report
ffbc.0011 ---> Sync.Report
ffbc.0012 ---> Sync.Report
ffbc.0013 ---> Sync.Report
ffbc.0014 ---> Sync.Report
ffbc.0015 ---> Sync.Report
ffbc.0016 ---> Sync.Report
ffbc.0017 ---> Sync.Report
ffbc.0018 ---> Sync.Report
ffbc.0019 ---> Sync.Report
ffbc.001a ---> Sync.Report
ffbc.001b ---> Sync.Report
ffbc.001c ---> Sync.Report
ffbc.001d ---> Sync.Report
ffbc.001e ---> Sync.Report
ffbc.001f ---> Sync.Report
ffbc.0020 ---> Sync.Report
ffbc.0021 ---> Sync.Report
ffbc.0022 ---> Sync.Report
ffbc.0023 ---> Sync.Report
ffbc.0024 ---> Sync.Report
ffbc.0025 ---> Sync.Report
ffbc.0026 ---> Sync.Report
ffbc.0027 ---> Sync.Report
ffbc.0028 ---> Sync.Report
ffbc.0029 ---> Sync.Report
ffbc.002a ---> Sync.Report
ffbc.002b ---> Sync.Report
ffbc.002c ---> Sync.Report
ffbc.002d ---> Sync.Report
ffbc.002e ---> Sync.Report
ffbc.002f ---> Sync.Report
ffbc.0030 ---> Sync.Report
ffbc.0031 ---> Sync.Report
ffbc.0032 ---> Sync.Report
ffbc.0033 ---> Sync.Report
ffbc.0034 ---> Sync.Report
ffbc.0035 ---> Sync.Report
ffbc.0036 ---> Sync.Report
ffbc.0037 ---> Sync.Report
ffbc.0038 ---> Sync.Report
ffbc.0039 ---> Sync.Report
ffbc.003a ---> Sync.Report
ffbc.003b ---> Sync.Report
ffbc.003c ---> Sync.Report
ffbc.003d ---> Sync.Report
ffbc.003e ---> Sync.Report
ffbc.003f ---> Sync.Report
ffbc.0040 ---> Sync.Report
ffbc.0041 ---> Sync.Report
ffbc.0042 ---> Sync.Report
ffbc.0043 ---> Sync.Report
ffbc.0044 ---> Sync.Report
ffbc.0045 ---> Sync.Report
ffbc.0046 ---> Sync.Report
ffbc.0047 ---> Sync.Report
ffbc.0048 ---> Sync.Report
ffbc.0049 ---> Sync.Report
ffbc.004a ---> Sync.Report
ffbc.004b ---> Sync.Report
ffbc.004c ---> Sync.Report
ffbc.004d ---> Sync.Report
ffbc.004e ---> Sync.Report
ffbc.004f ---> Sync.Report
ffbc.0050 ---> Sync.Report
ffbc.0051 ---> Sync.Report
ffbc.0052 ---> Sync.Report
ffbc.0053 ---> Sync.Report
ffbc.0054 ---> Sync.Report
ffbc.0055 ---> Sync.Report
ffbc.0056 ---> Sync.Report
ffbc.0057 ---> Sync.Report
ffbc.0058 ---> Sync.Report
ffbc.0059 ---> Sync.Report
ffbc.005a ---> Sync.Report
ffbc.005b ---> Sync.Report
ffbc.005c ---> Sync.Report
ffbc.005d ---> Sync.Report
ffbc.005e ---> Sync.Report
ffbc.005f ---> Sync.Report
ffbc.0060 ---> Sync.Report
ffbc.0061 ---> Sync.Report
ffbc.0062 ---> Sync.Report
ffbc.0063 ---> Sync.Report
ffbc.0064 ---> Sync.Report
ffbc.0065 ---> Sync.Report
ffbc.0066 ---> Sync.Report
ffbc.0067 ---> Sync.Report
ffbc.0068 ---> Sync.Report
ffbc.0069 ---> Sync.Report
ffbc.006a ---> Sync.Report
ffbc.006b ---> Sync.Report
ffbc.006c ---> Sync.Report
ffbc.006d ---> Sync.Report
ffbc.006e ---> Sync.Report
ffbc.006f ---> Sync.Report
ffbc.0070 ---> Sync.Report
ffbc.0071 ---> Sync.Report
ffbc.0072 ---> Sync.Report
ffbc.0073 ---> Sync.Report
ffbc.0074 ---> Sync.Report
ffbc.0075 ---> Sync.Report
ffbc.0076 ---> Sync.Report
ffbc.0077 ---> Sync.Report
ffbc.0078 ---> Sync.Report
ffbc.0079 ---> Sync.Report
ffbc.007a ---> Sync.Report
ffbc.007b ---> Sync.Report
ffbc.007c ---> Sync.Report
ffbc.007d ---> Sync.Report
ffbc.007e ---> Sync.Report
ffbc.007f ---> Sync.Report
ffbc.0080 ---> Sync.Report
ffbc.0081 ---> Sync.Report
ffbc.0082 ---> Sync.Report
ffbc.0083 ---> Sync.Report
ffbc.0084 ---> Sync.Report
ffbc.0085 ---> Sync.Report
ffbc.0086 ---> Sync.Report
ffbc.0087 ---> Sync.Report
ffbc.0088 ---> Sync.Report
ffbc.0089 ---> Sync.Report
ffbc.008a ---> Sync.Report
ffbc.008b ---> Sync.Report
ffbc.008c ---> Sync.Report
ffbc.008d ---> Sync.Report
ffbc.008e ---> Sync.Report
ffbc.008f ---> Sync.Report
ffbc.0090 ---> Sync.Report
ffbc.0091 ---> Sync.Report
ffbc.0092 ---> Sync.Report
ffbc.0093 ---> Sync.Report
ffbc.0094 ---> Sync.Report
ffbc.0095 ---> Sync.Report
ffbc.0096 ---> Sync.Report
ffbc.0097 ---> Sync.Report
ffbc.0098 ---> Sync.Report
ffbc.0099 ---> Sync.Report
ffbc.009a ---> Sync.Report
ffbc.009b ---> Sync.Report
ffbc.009c ---> Sync.Report
ffbc.009d ---> Sync.Report
ffbc.009e ---> Sync.Report
ffbc.009f ---> Sync.Report
ffbc.00a0 ---> Sync.Report
ffbc.00a1 ---> Sync.Report
ffbc.00a2 ---> Sync.Report
ffbc.00a3 ---> Sync.Report
ffbc.00a4 ---> Sync.Report
ffbc.00a5 ---> Sync.Report
ffbc.00a6 ---> Sync.Report
ffbc.00a7 ---> Sync.Report
ffbc.00a8 ---> Sync.Report
ffbc.00a9 ---> Sync.Report
ffbc.00aa ---> Sync.Report
ffbc.00ab ---> Sync.Report
ffbc.00ac ---> Sync.Report
ffbc.00ad ---> Sync.Report
ffbc.00ae ---> Sync.Report
ffbc.00af ---> Sync.Report
ffbc.00b0 ---> Sync.Report
ffbc.00b1 ---> Sync.Report
ffbc.00b2 ---> Sync.Report
ffbc.00b3 ---> Sync.Report
ffbc.00b4 ---> Sync.Report
ffbc.00b5 ---> Sync.Report
ffbc.00b6 ---> Sync.Report
ffbc.00b7 ---> Sync.Report
ffbc.00b8 ---> Sync.Report
ffbc.00b9 ---> Sync.Report
ffbc.00ba ---> Sync.Report
ffbc.00bb ---> Sync.Report
ffbc.00bc ---> Sync.Report
ffbc.00bd ---> Sync.Report
ffbc.00be ---> Sync.Report
ffbc.00bf ---> Sync.Report
ffbc.00c0 ---> Sync.Report
ffbc.00c1 ---> Sync.Report
ffbc.00c2 ---> Sync.Report
ffbc.00c3 ---> Sync.Report
ffbc.00c4 ---> Sync.Report
ffbc.00c5 ---> Sync.Report
ffbc.00c6 ---> Sync.Report
ffbc.00c7 ---> Sync.Report
ffbc.00c8 ---> Sync.Report
ffbc.00c9 ---> Sync.Report
ffbc.00ca ---> Sync.Report
ffbc.00cb ---> Sync.Report
ffbc.00cc ---> Sync.Report
ffbc.00cd ---> Sync.Report
ffbc.00ce ---> Sync.Report
ffbc.00cf ---> Sync.Report
ffbc.00d0 ---> Sync.Report
ffbc.00d1 ---> Sync.Report
ffbc.00d2 ---> Sync.Report
ffbc.00d3 ---> Sync.Report
ffbc.00d4 ---> Sync.Report
ffbc.00d5 ---> Sync.Report
ffbc.00d6 ---> Sync.Report
ffbc.00d7 ---> Sync.Report
ffbc.00d8 ---> Sync.Report
ffbc.00d9 ---> Sync.Report
ffbc.00da ---> Sync.Report
ffbc.00db ---> Sync.Report
ffbc.00dc ---> Sync.Report
ffbc.00dd ---> Sync.Report
ffbc.00de ---> Sync.Report
ffbc.00df ---> Sync.Report
ffbc.00e0 ---> Sync.Report
ffbc.00e1 ---> Sync.Report
ffbc.00e2 ---> Sync.Report
ffbc.00e3 ---> Sync.Report
ffbc.00e4 ---> Sync.Report
ffbc.00e5 ---> Sync.Report
ffbc.00e6 ---> Sync.Report
ffbc.00e7 ---> Sync.Report
ffbc.00e8 ---> Sync.Report
ffbc.00e9 ---> Sync.Report
ffbc.00ea ---> Sync.Report
ffbc.00eb ---> Sync.Report
ffbc.00ec ---> Sync.Report
ffbc.00ed ---> Sync.Report
ffbc.00ee ---> Sync.Report
ffbc.00ef ---> Sync.Report
ffbc.00f0 ---> Sync.Report
ffbc.00f1 ---> Sync.Report
ffbc.00f2 ---> Sync.Report
ffbc.00f3 ---> Sync.Report
ffbc.00f4 ---> Sync.Report
ffbc.00f5 ---> Sync.Report
ffbc.00f6 ---> Sync.Report
ffbc.00f7 ---> Sync.Report
ffbc.00f8 ---> Sync.Report
ffbc.00f9 ---> Sync.Report
ffbc.00fa ---> Sync.Report
ffbc.00fb ---> Sync.Report
ffbc.00fc ---> Sync.Report
ffbc.00fd ---> Sync.Report
ffbc.00fe ---> Sync.Report
ffbc.00ff ---> Sync.Report

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

06 00 ff 09 01 a1 01 85 10 75 08 95 06 15 00 26 ff 00 09 01 81 00 09
01 91 00 c0 06 00 ff 09 02 a1 01 85 11 75 08 95 13 15 00 26 ff 00 09
02 81 00 09 02 91 00 c0 06 00 ff 09 04 a1 01 85 20 75 08 95 0e 15 00
26 ff 00 09 41 81 00 09 41 91 00 85 21 95 1f 15 00 26 ff 00 09 42 81
00 09 42 91 00 c0

  INPUT(16)[INPUT]
    Field(0)
      Usage(6)
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(6)
      Report Offset(0)
      Flags( Array Absolute )
  INPUT(17)[INPUT]
    Field(0)
      Usage(19)
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(19)
      Report Offset(0)
      Flags( Array Absolute )
  INPUT(32)[INPUT]
    Field(0)
      Usage(14)
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(14)
      Report Offset(0)
      Flags( Array Absolute )
  INPUT(33)[INPUT]
    Field(0)
      Usage(31)
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(31)
      Report Offset(0)
      Flags( Array Absolute )
  OUTPUT(16)[OUTPUT]
    Field(0)
      Usage(6)
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(6)
      Report Offset(0)
      Flags( Array Absolute )
  OUTPUT(17)[OUTPUT]
    Field(0)
      Usage(19)
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
        ff00.0002
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(19)
      Report Offset(0)
      Flags( Array Absolute )
  OUTPUT(32)[OUTPUT]
    Field(0)
      Usage(14)
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
        ff00.0041
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(14)
      Report Offset(0)
      Flags( Array Absolute )
  OUTPUT(33)[OUTPUT]
    Field(0)
      Usage(31)
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
        ff00.0042
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(31)
      Report Offset(0)
      Flags( Array Absolute )

ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0002 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0041 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
ff00.0042 ---> Sync.Report
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
