From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: elantech touchpad problem (long)
Date: Mon, 07 Nov 2011 13:48:14 +0800
Message-ID: <87fwi0fppd.fsf@emc.com.tw>
References: <6476830.8pz05UnHgs@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:24880 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab1KGFuk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2011 00:50:40 -0500
In-Reply-To: <6476830.8pz05UnHgs@ax5200p>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>

Hi Marc,

On Sat, 05 Nov 2011 22:57:38 +0100, Marc Dietrich <marvin24@gmx.de> wrote:
> Hi,
> 
> my small arm netbook contains a elantech touchpad. It is connected via a 
> keyboard controller which communicates over a i2c bus with the host cpu. The 
> keyboard controller/host cpu communication is handled by a special driver (see 
> drivers/staging/nvec_ps2.c). Up to commmit 28f49616 (Input: elantech - add v3 
> hardware support) the touchpad was recognized as a Logitech mouse and it 
> worked fine this way.
> 
> Since commit 28f49616, the touchpad is detected as an elantech device (I 
> checked the hw and it is really one). The detected HW version is 2 and the 
> firmware version 0x150500). Unfortunately, the device still streams 3 byte 
> packets which are of course not handled by the elantech driver.
> 
I thought we never shipped 0x150500, but obviously I was wrong.

In current version of Elantech driver, the hw_version detection is done
in elantech_set_properties(), and it's done this way:

	int ver = (etd->fw_version & 0x0f0000) >> 16;

	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
		etd->hw_version = 1;
	else if (etd->fw_version < 0x150600)
		etd->hw_version = 2;
	else if (ver == 5)
		etd->hw_version = 3;
	else if (ver == 6)
		etd->hw_version = 4;
	else
		return -1;

This "ver" integer really means the version of the IC body, and the
magic number 0x150600 is from an old version of our internal driver
maintained by Tom Lin <tom_lin@emc.com.tw> (also CCed). Your touchpad
seems to be a v3 hardware, but due to the fw_version(0x150500) less then
the magic number, it's treated as a v2 by driver.

For now, could you please try the below patch? I think I will have to do
some history homework and ask our senior firmware guys to come up with
a correct patch.

Thanks,
jj

---
>From 660a96f7a6d7591054b0ef13aa02c41084b1d7f0 Mon Sep 17 00:00:00 2001
From: JJ Ding <jj_ding@emc.com.tw>
Date: Mon, 7 Nov 2011 12:57:50 +0800
Subject: [PATCH] Input: elantech: adjust hw_version detection logic

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
---
 drivers/input/mouse/elantech.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 09b93b1..fa64c3e 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1214,7 +1214,7 @@ static int elantech_set_properties(struct elantech_data *etd)
 
 	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
 		etd->hw_version = 1;
-	else if (etd->fw_version < 0x150600)
+	else if (etd->fw_version < 0x150000)
 		etd->hw_version = 2;
 	else if (ver == 5)
 		etd->hw_version = 3;
-- 
1.7.8.rc0.32.g87bf9

> From what I understood so far, the touchpad needs to be switched to something 
> called "absolute mode". This is done by programming some tp registers. I 
> checked these registers and found that register 21 is still 0, while it should 
> be 0x60 (reg 10 and 11 are ok).
> 
> So here is a register dump:
> 
> 0x07 => 0x00
> 0x10 => 0x54
> 0x11 => 0x88
> 0x20 => 0x00
> 0x21 => 0x00  // should be 60 ?
> 0x22 => 0x00
> 0x23 => 0x00
> 0x24 => 0x00
> 0x25 => 0x00
> 0x26 => 0x00
> 
> Tried "echo -n 0x60 > reg_21" didn't helped (just manipulates other 
> registers?).
> 
> So here is the xorg output:
> 
> [    16.598] (II) LoadModule: "synaptics"
> [    16.600] (II) Loading /usr/lib/xorg/modules/input/synaptics_drv.so
> [    16.600] (II) Module synaptics: vendor="X.Org Foundation"
> [    16.600]    compiled for 1.10.4, module version = 1.4.1
> [    16.601]    Module class: X.Org XInput Driver
> [    16.601]    ABI class: X.Org XInput driver, version 12.3
> [    16.601] (II) Using input driver 'synaptics' for 'ETPS/2 Elantech 
> Touchpad'
> [    16.601] (II) Loading /usr/lib/xorg/modules/input/synaptics_drv.so
> [    16.601] (**) ETPS/2 Elantech Touchpad: always reports core events
> [    16.601] (**) Option "Device" "/dev/input/event6"
> [    16.800] (--) ETPS/2 Elantech Touchpad: x-axis range 0 - 1344
> [    16.800] (--) ETPS/2 Elantech Touchpad: y-axis range 0 - 448
> [    16.800] (--) ETPS/2 Elantech Touchpad: pressure range 0 - 255
> [    16.800] (--) ETPS/2 Elantech Touchpad: finger width range 0 - 15
> [    16.800] (--) ETPS/2 Elantech Touchpad: buttons: left right double triple
> [    16.949] (--) ETPS/2 Elantech Touchpad: touchpad found
> [    16.949] (**) ETPS/2 Elantech Touchpad: always reports core events
> [    17.049] (**) Option "config_info" 
> "udev:/sys/devices/serio0/input/input6/event6"
> [    17.049] (II) XINPUT: Adding extended input device "ETPS/2 Elantech 
> Touchpad" (type: TOUCHPAD)
> [    17.050] (**) ETPS/2 Elantech Touchpad: (accel) MinSpeed is now constant 
> deceleration 2.5
> [    17.050] (**) ETPS/2 Elantech Touchpad: MaxSpeed is now 1.75
> [    17.050] (**) ETPS/2 Elantech Touchpad: AccelFactor is now 0.141
> [    17.050] (**) ETPS/2 Elantech Touchpad: (accel) keeping acceleration 
> scheme 1
> [    17.050] (**) ETPS/2 Elantech Touchpad: (accel) acceleration profile 1
> [    17.051] (**) ETPS/2 Elantech Touchpad: (accel) acceleration factor: 2.000
> [    17.051] (**) ETPS/2 Elantech Touchpad: (accel) acceleration threshold: 4
> [    17.292] (--) ETPS/2 Elantech Touchpad: touchpad found
> [    17.293] (II) config/udev: Adding input device ETPS/2 Elantech Touchpad 
> (/dev/input/mouse0)
> 
> ... and here is traffic dump (sorry a bit long):
> 
> [    5.887554] psmouse serio0: Sending ps2 cmd f2
> [    5.928870] nvec_ps2: got response fa 00
> [    5.928883] psmouse serio0: Sending ps2 cmd f6
> [    5.938252] nvec_ps2: got response fa
> [    5.938267] psmouse serio0: Sending ps2 cmd f3
> [    5.948270] nvec_ps2: got response fa
> [    5.948283] psmouse serio0: Sending ps2 cmd 0a
> [    5.957831] nvec_ps2: got response fa
> [    5.957844] psmouse serio0: Sending ps2 cmd e8
> [    5.970079] nvec_ps2: got response fa
> [    5.970175] psmouse serio0: Sending ps2 cmd 00
> [    5.979733] nvec_ps2: got response fa
> [    5.990101] psmouse serio0: Sending ps2 cmd f3
> [    5.999384] nvec_ps2: got response fa
> [    5.999396] psmouse serio0: Sending ps2 cmd 14
> [    6.008871] nvec_ps2: got response fa
> [    6.008883] psmouse serio0: Sending ps2 cmd f3
> [    6.018769] nvec_ps2: got response fa
> [    6.018781] psmouse serio0: Sending ps2 cmd 3c
> [    6.028603] nvec_ps2: got response fa
> [    6.030088] psmouse serio0: Sending ps2 cmd f3
> [    6.038575] nvec_ps2: got response fa
> [    6.038586] psmouse serio0: Sending ps2 cmd 28
> [    6.048213] nvec_ps2: got response fa
> [    6.048226] psmouse serio0: Sending ps2 cmd f3
> [    6.057895] nvec_ps2: got response fa
> [    6.057906] psmouse serio0: Sending ps2 cmd 14
> [    6.067674] nvec_ps2: got response fa
> [    6.067687] psmouse serio0: Sending ps2 cmd f3
> [    6.077354] nvec_ps2: got response fa
> [    6.077366] psmouse serio0: Sending ps2 cmd 14
> [    6.086930] nvec_ps2: got response fa
> [    6.086942] psmouse serio0: Sending ps2 cmd f3
> [    6.097024] nvec_ps2: got response fa
> [    6.100154] psmouse serio0: Sending ps2 cmd 3c
> [    6.113333] nvec_ps2: got response fa
> [    6.113349] psmouse serio0: Sending ps2 cmd f3
> [    6.119508] nvec_ps2: got response fa
> [    6.119520] psmouse serio0: Sending ps2 cmd 28
> [    6.131131] nvec_ps2: got response fa
> [    6.131143] psmouse serio0: Sending ps2 cmd f3
> [    6.138858] nvec_ps2: got response fa
> [    6.138870] psmouse serio0: Sending ps2 cmd 14
> [    6.148702] nvec_ps2: got response fa
> [    6.148714] psmouse serio0: Sending ps2 cmd f3
> [    6.158898] nvec_ps2: got response fa
> [    6.158910] psmouse serio0: Sending ps2 cmd 14
> [    6.168193] nvec_ps2: got response fa
> [    6.168205] psmouse serio0: Sending ps2 cmd f2
> [    6.183092] nvec_ps2: got response fa 00
> [    6.183104] psmouse serio0: Sending ps2 cmd e8
> [    6.192177] nvec_ps2: got response fa
> [    6.200109] psmouse serio0: Sending ps2 cmd 00
> [    6.207287] nvec_ps2: got response fa
> [    6.207300] psmouse serio0: Sending ps2 cmd e8
> [    6.217568] nvec_ps2: got response fa
> [    6.217580] psmouse serio0: Sending ps2 cmd 00
> [    6.226747] nvec_ps2: got response fa
> [    6.226760] psmouse serio0: Sending ps2 cmd e8
> [    6.236774] nvec_ps2: got response fa
> [    6.237062] psmouse serio0: Sending ps2 cmd 00
> [    6.246454] nvec_ps2: got response fa
> [    6.246466] psmouse serio0: Sending ps2 cmd e8
> [    6.256148] nvec_ps2: got response fa
> [    6.256161] psmouse serio0: Sending ps2 cmd 00
> [    6.265893] nvec_ps2: got response fa
> [    6.265907] psmouse serio0: Sending ps2 cmd e9
> [    6.281059] nvec_ps2: got response fa 00 00 14
> [    6.281071] psmouse serio0: Sending ps2 cmd f6
> [    6.290198] nvec_ps2: got response fa
> [    6.291736] psmouse serio0: Sending ps2 cmd e8
> [    6.304879] nvec_ps2: got response fa
> [    6.305723] psmouse serio0: Sending ps2 cmd 00
> [    6.314646] nvec_ps2: got response fa
> [    6.314969] psmouse serio0: Sending ps2 cmd e6
> [    6.324389] nvec_ps2: got response fa
> [    6.324444] psmouse serio0: Sending ps2 cmd e6
> [    6.334351] nvec_ps2: got response fa
> [    6.334363] psmouse serio0: Sending ps2 cmd e6
> [    6.343863] nvec_ps2: got response fa
> [    6.343875] psmouse serio0: Sending ps2 cmd e9
> [    6.358959] nvec_ps2: got response fa 3c 03 00
> [    6.358972] psmouse serio0: Sending ps2 cmd f6
> [    6.367935] nvec_ps2: got response fa
> [    6.367948] psmouse serio0: Sending ps2 cmd f5
> [    6.377930] nvec_ps2: got response fa
> [    6.377943] psmouse serio0: Sending ps2 cmd e6
> [    6.387570] nvec_ps2: got response fa
> [    6.387582] psmouse serio0: Sending ps2 cmd e6
> [    6.397423] nvec_ps2: got response fa
> [    6.397435] psmouse serio0: Sending ps2 cmd e6
> [    6.407058] nvec_ps2: got response fa
> [    6.407070] psmouse serio0: Sending ps2 cmd e9
> [    6.420677] nvec_ps2: got response fa 3c 03 00
> [    6.420812] psmouse serio0: Sending ps2 cmd e6
> [    6.428976] nvec_ps2: got response fa
> [    6.428989] psmouse serio0: Sending ps2 cmd e8
> [    6.438950] nvec_ps2: got response fa
> [    6.438962] psmouse serio0: Sending ps2 cmd 00
> [    6.448514] nvec_ps2: got response fa
> [    6.456744] psmouse serio0: Sending ps2 cmd e8
> [    6.465721] nvec_ps2: got response fa
> [    6.465734] psmouse serio0: Sending ps2 cmd 00
> [    6.475475] nvec_ps2: got response fa
> [    6.475486] psmouse serio0: Sending ps2 cmd e8
> [    6.485327] nvec_ps2: got response fa
> [    6.485338] psmouse serio0: Sending ps2 cmd 00
> [    6.495187] nvec_ps2: got response fa
> [    6.495199] psmouse serio0: Sending ps2 cmd e8
> [    6.504898] nvec_ps2: got response fa
> [    6.504911] psmouse serio0: Sending ps2 cmd 01
> [    6.515155] nvec_ps2: got response fa
> [    6.515166] psmouse serio0: Sending ps2 cmd e9
> [    6.530131] nvec_ps2: got response fa 15 05 00
> [    6.530142] elantech: Elantech version query result 0x15, 0x05, 0x00.
> [    6.530162] psmouse serio0: Sending ps2 cmd e6
> [    6.539482] nvec_ps2: got response fa
> [    6.539494] psmouse serio0: Sending ps2 cmd e8
> [    6.549442] nvec_ps2: got response fa
> [    6.549454] psmouse serio0: Sending ps2 cmd 00
> [    6.559917] nvec_ps2: got response fa
> [    6.559929] psmouse serio0: Sending ps2 cmd e8
> [    6.569310] nvec_ps2: got response fa
> [    6.569321] psmouse serio0: Sending ps2 cmd 00
> [    6.578560] nvec_ps2: got response fa
> [    6.578575] psmouse serio0: Sending ps2 cmd e8
> [    6.588320] nvec_ps2: got response fa
> [    6.588482] psmouse serio0: Sending ps2 cmd 00
> [    6.598152] nvec_ps2: got response fa
> [    6.599215] psmouse serio0: Sending ps2 cmd e8
> [    6.612103] nvec_ps2: got response fa
> [    6.612125] psmouse serio0: Sending ps2 cmd 01
> [    6.622191] nvec_ps2: got response fa
> [    6.622203] psmouse serio0: Sending ps2 cmd e9
> [    6.634470] nvec_ps2: got response fa 15 05 00
> [    6.634482] elantech: assuming hardware version 2 (with firmware version 
> 0x150500)
> [    6.634496] psmouse serio0: Sending ps2 cmd e6
> [    6.644172] nvec_ps2: got response fa
> [    6.644184] psmouse serio0: Sending ps2 cmd e8
> [    6.653619] nvec_ps2: got response fa
> [    6.653631] psmouse serio0: Sending ps2 cmd 00
> [    6.663864] nvec_ps2: got response fa
> [    6.663876] psmouse serio0: Sending ps2 cmd e8
> [    6.674343] nvec_ps2: got response fa
> [    6.675328] psmouse serio0: Sending ps2 cmd 00
> [    6.684437] nvec_ps2: got response fa
> [    6.684450] psmouse serio0: Sending ps2 cmd e8
> [    6.692962] nvec_ps2: got response fa
> [    6.692974] psmouse serio0: Sending ps2 cmd 00
> [    6.702492] nvec_ps2: got response fa
> [    6.702504] psmouse serio0: Sending ps2 cmd e8
> [    6.712488] nvec_ps2: got response fa
> [    6.713122] psmouse serio0: Sending ps2 cmd 02
> [    6.722199] nvec_ps2: got response fa
> [    6.722211] psmouse serio0: Sending ps2 cmd e9
> [    6.739803] nvec_ps2: got response fa 69 17 09
> [    6.739814] elantech: Synaptics capabilities query result 0x69, 0x17, 0x09.
> [    6.739828] psmouse serio0: Sending ps2 cmd f8
> [    6.749168] nvec_ps2: got response fa
> [    6.749180] psmouse serio0: Sending ps2 cmd 11
> [    6.758987] nvec_ps2: got response fa
> [    6.759000] psmouse serio0: Sending ps2 cmd f8
> [    6.769015] nvec_ps2: got response fa
> [    6.769028] psmouse serio0: Sending ps2 cmd 10
> [    6.778532] nvec_ps2: got response fa
> [    6.779000] psmouse serio0: Sending ps2 cmd f8
> [    6.790669] nvec_ps2: got response fa
> [    6.790682] psmouse serio0: Sending ps2 cmd 54
> [    6.800648] nvec_ps2: got response fa
> [    6.804250] psmouse serio0: Sending ps2 cmd e6
> [    6.813012] nvec_ps2: got response fa
> [    6.813025] psmouse serio0: Sending ps2 cmd f8
> [    6.822806] nvec_ps2: got response fa
> [    6.822824] psmouse serio0: Sending ps2 cmd 11
> [    6.840090] nvec_ps2: got response fa
> [    6.841091] psmouse serio0: Sending ps2 cmd f8
> [    6.849371] nvec_ps2: got response fa
> [    6.850834] psmouse serio0: Sending ps2 cmd 11
> [    6.862394] nvec_ps2: got response fa
> [    6.862408] psmouse serio0: Sending ps2 cmd f8
> [    6.871858] nvec_ps2: got response fa
> [    6.871870] psmouse serio0: Sending ps2 cmd 88
> [    6.881467] nvec_ps2: got response fa
> [    6.881478] psmouse serio0: Sending ps2 cmd e6
> [    6.891346] nvec_ps2: got response fa
> [    6.891359] psmouse serio0: Sending ps2 cmd f8
> [    6.901264] nvec_ps2: got response fa
> [    6.901278] psmouse serio0: Sending ps2 cmd 11
> [    6.910984] nvec_ps2: got response fa
> [    6.911082] psmouse serio0: Sending ps2 cmd f8
> [    6.921680] nvec_ps2: got response fa
> [    6.921692] psmouse serio0: Sending ps2 cmd 21
> [    6.930327] nvec_ps2: got response fa
> [    6.930340] psmouse serio0: Sending ps2 cmd f8
> [    6.940142] nvec_ps2: got response fa
> [    6.940184] psmouse serio0: Sending ps2 cmd 60
> [    6.949914] nvec_ps2: got response fa
> [    6.949926] psmouse serio0: Sending ps2 cmd e6
> [    6.959720] nvec_ps2: got response fc
> [    7.140108] elantech: retrying ps2 command 0xe6 (2).
> [    7.650070] psmouse serio0: Sending ps2 cmd e6
> [    7.660088] nvec_ps2: got response fa
> [    7.660100] psmouse serio0: Sending ps2 cmd f8
> [    7.669533] nvec_ps2: got response fe
> [    7.669542] elantech: retrying ps2 command 0xf8 (2).
> [    8.170058] psmouse serio0: Sending ps2 cmd f8
> [    8.180588] nvec_ps2: got response fc
> [    8.370050] elantech: retrying ps2 command 0xf8 (1).
> [    8.880062] psmouse serio0: Sending ps2 cmd f8
> [    8.888444] nvec_ps2: got response fa
> [    8.888454] psmouse serio0: Sending ps2 cmd 10
> [    8.898301] nvec_ps2: got response fa
> [    8.898312] psmouse serio0: Sending ps2 cmd f8
> [    8.908129] nvec_ps2: got response fa
> [    8.908143] psmouse serio0: Sending ps2 cmd 10
> [    8.918150] nvec_ps2: got response fa
> [    8.918230] psmouse serio0: Sending ps2 cmd e9
> [    8.930670] nvec_ps2: got response fa 54 02 64
> [    8.930685] psmouse serio0: Sending ps2 cmd e6
> [    8.939816] nvec_ps2: got response fa
> [    8.939824] psmouse serio0: Sending ps2 cmd e8
> [    8.949201] nvec_ps2: got response fa
> [    8.949209] psmouse serio0: Sending ps2 cmd 00
> [    8.959326] nvec_ps2: got response fa
> [    8.959334] psmouse serio0: Sending ps2 cmd e8
> [    8.969008] nvec_ps2: got response fa
> [    8.969016] psmouse serio0: Sending ps2 cmd 00
> [    8.978357] nvec_ps2: got response fa
> [    8.978365] psmouse serio0: Sending ps2 cmd e8
> [    8.988536] nvec_ps2: got response fa
> [    8.988544] psmouse serio0: Sending ps2 cmd 00
> [    8.998182] nvec_ps2: got response fa
> [    8.998190] psmouse serio0: Sending ps2 cmd e8
> [    9.008213] nvec_ps2: got response fa
> [    9.008221] psmouse serio0: Sending ps2 cmd 00
> [    9.017767] nvec_ps2: got response fa
> [    9.017775] psmouse serio0: Sending ps2 cmd e9
> [    9.035410] nvec_ps2: got response fa 14 6e 7a
> [    9.035470] psmouse serio0: Sending ps2 cmd f3
> [    9.044827] nvec_ps2: got response fa
> [    9.044835] psmouse serio0: Sending ps2 cmd 64
> [    9.054645] nvec_ps2: got response fa
> [    9.054655] psmouse serio0: Sending ps2 cmd e8
> [    9.064290] nvec_ps2: got response fa
> [    9.064298] psmouse serio0: Sending ps2 cmd 03
> [    9.074112] nvec_ps2: got response fa
> [    9.074123] psmouse serio0: Sending ps2 cmd e6
> [    9.083828] nvec_ps2: got response fa
> [    9.084064] input: ETPS/2 Elantech Touchpad as /devices/serio0/input/input6
> [    9.084510] psmouse serio0: Sending ps2 cmd f4
> [    9.093769] nvec_ps2: got response fa
> [   12.239652] psmouse serio0: Sending ps2 cmd f5
> [   12.248772] nvec_ps2: got response fa
> [   12.248797] psmouse serio0: Sending ps2 cmd f4
> [   12.258601] nvec_ps2: got response fa
> 
> .. now some finger move from right to left:
> 
> [ 2226.798147] nvec_ps2: got event 18 ff 00
> [ 2226.810750] elantech: PS/2 packet [ 0x18 , 0xff , 0x00 , 0x18 , 0xff , 0x01 
> ]
> [ 2226.810812] nvec_ps2: got event 18 ff 01
> [ 2226.824962] nvec_ps2: got event 18 fe 00
> [ 2226.836464] elantech: PS/2 packet [ 0x18 , 0xfe , 0x00 , 0x18 , 0xfb , 0x01 
> ]
> [ 2226.836500] nvec_ps2: got event 18 fb 01
> [ 2226.849539] nvec_ps2: got event 18 f8 01
> [ 2226.863195] elantech: PS/2 packet [ 0x18 , 0xf8 , 0x01 , 0x18 , 0xf4 , 0x02 
> ]
> [ 2226.863230] nvec_ps2: got event 18 f4 02
> [ 2226.874269] nvec_ps2: got event 18 ef 01
> [ 2226.886808] elantech: PS/2 packet [ 0x18 , 0xef , 0x01 , 0x18 , 0xef , 0x02 
> ]
> [ 2226.886919] nvec_ps2: got event 18 ef 02
> [ 2226.899225] nvec_ps2: got event 18 ef 02
> [ 2226.913083] elantech: PS/2 packet [ 0x18 , 0xef , 0x02 , 0x18 , 0xf0 , 0x02 
> ]
> [ 2226.913194] nvec_ps2: got event 18 f0 02
> [ 2226.924667] nvec_ps2: got event 18 ee 02
> [ 2226.937733] elantech: PS/2 packet [ 0x18 , 0xee , 0x02 , 0x18 , 0xf1 , 0x00 
> ]
> [ 2226.937843] nvec_ps2: got event 18 f1 00
> [ 2226.951434] nvec_ps2: got event 18 ee 01
> [ 2226.962277] elantech: PS/2 packet [ 0x18 , 0xee , 0x01 , 0x18 , 0xf1 , 0x00 
> ]
> [ 2226.962388] nvec_ps2: got event 18 f1 00
> [ 2226.974781] nvec_ps2: got event 18 f0 00
> [ 2226.987177] elantech: PS/2 packet [ 0x18 , 0xf0 , 0x00 , 0x18 , 0xf7 , 0x01 
> ]
> [ 2226.987286] nvec_ps2: got event 18 f7 01
> [ 2227.000963] nvec_ps2: got event 18 fb 00
> [ 2227.012722] elantech: PS/2 packet [ 0x18 , 0xfb , 0x00 , 0x18 , 0xfe , 0x00 
> ]
> [ 2227.012832] nvec_ps2: got event 18 fe 00
> [ 2227.025664] nvec_ps2: got event 18 ff 00
> [ 2227.039411] elantech: PS/2 packet [ 0x18 , 0xff , 0x00 , 0x18 , 0xff , 0x00 
> ]
> [ 2227.039520] nvec_ps2: got event 18 ff 00
> 
> So AFAIK, this looks like mouse streaming proto. I disabled packet validity 
> checking to get this dump.
> 
> And finally, this is a special kernel version (chromeos kernel v2.6.38 with 
> elantech patches backported). I can test mainline also if required. Anything 
> more I can do to get it going?
> 
> Thanks
> 
> Marc
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
