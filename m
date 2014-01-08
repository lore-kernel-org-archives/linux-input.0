From: =?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?= <gcembed@gmail.com>
Subject: Information about Atmel MXT224
Date: Wed, 08 Jan 2014 08:57:37 +0100
Message-ID: <52CD04F1.8090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:47827 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbaAHH56 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 02:57:58 -0500
Received: by mail-ee0-f53.google.com with SMTP id b57so487479eek.40
        for <linux-input@vger.kernel.org>; Tue, 07 Jan 2014 23:57:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>

Hello,
I have tried atmel_mxt_ts driver (original driver from kernel 3.6.0 and=
=20
driver from linux-next/master branch copied to kernel 3.6.0) on i.MX27=20
board. The capacitive glass used is a "GE Touch"=20
SMT-F-057G007-B011-4:3-NP. It has 16 pads in X and 14 pads in Y. It is=20
correctly detected (with one warning/error).
The power supply of VDD and AVDD is 2.8V. AVDD will be raised later to =
3.3V.
When I push on glass, nothing occurs in evetst nor on /CHG pin of MXT22=
4.

Does someone has some informations or the protocol guide, please ?
Thanks a lot for your help.
Ga=C3=ABtan Carlier.

Below some code and logs.


Here is my initialization :
8---------------------------------------------------------
/* TSP */
static struct mxt_platform_data mxt_platform_data =3D {
	.x_line			=3D 18,
	.y_line			=3D 11,
	.x_size			=3D 480,
	.y_size			=3D 640,
	.blen			=3D 0x1,
	.threshold		=3D 0x28,
	.voltage		=3D 2800000,		/* 2.8V */
	.orient			=3D MXT_DIAGONAL_COUNTER,
	.irqflags		=3D IRQF_TRIGGER_FALLING,
};

static struct i2c_board_info imx27gc_i2c0_devices[] =3D {
	{
		I2C_BOARD_INFO("atmel_mxt_ts", 0x4b),
		.platform_data =3D &mxt_platform_data,
		/* irq number is run-time assigned */
	},
	/* more devices can be added using expansion connectors */
};

static void __init dvip01_init(void)
{
	dvip01_i2c0_devices[0].irq =3D gpio_to_irq(MXT_KEY);
}
8---------------------------------------------------------


Here is log of start-up:
8---------------------------------------------------------
atmel_mxt_ts 0-004b: Type 37 Start 106 Size 130 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type 44 Start 236 Size   1 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type  5 Start 237 Size   9 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type  6 Start 246 Size   6 Instances  1 ReportIDs=20
  1 :   1
atmel_mxt_ts 0-004b: Type 38 Start 252 Size   8 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type  7 Start 260 Size   3 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type  8 Start 263 Size  10 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type  9 Start 273 Size  35 Instances  1 ReportIDs=20
  2 :  11
atmel_mxt_ts 0-004b: Type 18 Start 308 Size   2 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type 19 Start 310 Size   6 Instances  1 ReportIDs=20
12 :  12
atmel_mxt_ts 0-004b: Type 25 Start 316 Size   6 Instances  1 ReportIDs=20
13 :  13
atmel_mxt_ts 0-004b: Type 42 Start 322 Size   8 Instances  1 ReportIDs=20
14 :  14
atmel_mxt_ts 0-004b: Type 46 Start 330 Size   9 Instances  1 ReportIDs=20
15 :  15
atmel_mxt_ts 0-004b: Type 47 Start 339 Size  10 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: Type 48 Start 349 Size  54 Instances  1 ReportIDs=20
16 :  16
atmel_mxt_ts 0-004b: Type 55 Start 403 Size   4 Instances  1 ReportIDs=20
  0 :   0
atmel_mxt_ts 0-004b: No cfg data defined, skipping reg init
atmel_mxt_ts 0-004b: Invalid object type
atmel_mxt_ts 0-004b: Family ID: 129 Variant ID: 1 Major.Minor.Build: 2.=
0.AB
atmel_mxt_ts 0-004b: Matrix X Size: 16 Matrix Y Size: 14 Object Num: 16
input: Atmel maXTouch Touchscreen as=20
/devices/platform/imx-i2c.0/i2c-0/0-004b/input/input0
8---------------------------------------------------------

Here is evtest information :
8---------------------------------------------------------
Input driver version is 1.0.1evdev: (EVIOCGBIT): Suspicious buffer size=
=20
511, limiting output to 64 bytes. See http://userweb.kernel.org/~dtorl

Input device ID: bus 0x18 vendor 0x0 product 0x0 version 0x0
Input device name: "Atmel maXTouch Touchscreen"
Supported events:
   Event type 0 (Sync)
   Event type 1 (Key)
     Event code 330 (Touch)
   Event type 3 (Absolute)
     Event code 0 (X)
       Value      0
       Min        0
       Max      479
     Event code 1 (Y)
       Value      0
       Min        0
       Max      639
     Event code 24 (Pressure)
       Value      0
       Min        0
       Max      255
     Event code 47 (?)
       Value      0
       Min        0
       Max        9
     Event code 48 (?)
       Value      0
       Min        0
       Max      255
     Event code 53 (?)
       Value      0
       Min        0
       Max      479
     Event code 54 (?)
       Value      0
       Min        0
       Max      639
     Event code 57 (?)
       Value      0
       Min        0
       Max    65535
     Event code 58 (?)
       Value      0
       Min        0
       Max      255
Testing ... (interrupt to exit)
8---------------------------------------------------------

Here is /proc/interrupts:
8---------------------------------------------------------
128:          0  gpio-mxc  atmel_mxt_ts
8---------------------------------------------------------

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
