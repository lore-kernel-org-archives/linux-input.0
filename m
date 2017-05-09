From: Benjamin Valentin <benpicco@googlemail.com>
Subject: [PATCHv2] Input: xpad - sync supported devices with 360Controller
Date: Tue, 9 May 2017 02:52:50 +0200
Message-ID: <20170509025250.28e71f86@nashorn>
References: <20170504231544.335e8f42@nashorn>
        <20170504231714.16ea40d2@nashorn>
        <5f9b48e9-053c-2118-2026-5dcbc7705100@gmail.com>
        <20170505195021.27121915@nashorn>
        <20170506191024.01eefa59@nashorn>
        <842f5c93-9788-2bb9-1ced-bb88ce60d231@gmail.com>
        <20170507215315.GC39686@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36452 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdEIAwz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 May 2017 20:52:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so18940417wmu.3
        for <linux-input@vger.kernel.org>; Mon, 08 May 2017 17:52:54 -0700 (PDT)
In-Reply-To: <20170507215315.GC39686@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cameron Gutman <aicommander@gmail.com>
Cc: linux-input@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>, "Pierre-Loup A. Griffais" <eduke32@plagman.net>, Daniel Tobias <dan.g.tob@gmail.com>

360Controller [0] is an OpenSource driver for Xbox/Xbox360/XboxOne controllers on macOS.

It contains a couple device IDs unknown to the Linux driver, so I wrote a small Python script [1]
to extract them and feed them into my previous script [2] to compare them with the IDs known to
Linux.

For most devices, this information is not really needed as xpad is able to automatically detect the
type of an unknown Xbox Controller at run-time. I've therefore stripped all the generic/vague entries.

I've excluded the Logitech G920, it's handled by a HID driver already.
I've also excluded the Scene It! Big Button IR, it's handled by an out-of-tree driver. [3]

[0] https://github.com/360Controller/360Controller
[1] http://codepad.org/v9GyLKMq
[2] http://codepad.org/qh7jclpD
[3] https://github.com/micolous/xbox360bb

Signed-off-by: Benjamin Valentin <benpicco@googlemail.com>
---
I've removed the vaguely named controllers as well as devices where a second google search wouldn't
turn up convincingly plausible information.

 drivers/input/joystick/xpad.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index def96cd2479b..fa6c9a5758fe 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -131,8 +131,10 @@ static const struct xpad_device {
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
+	{ 0x045e, 0x0288, "Microsoft Xbox Controller S v2", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
+	{ 0x045e, 0x028f, "Microsoft X-Box 360 pad v2", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
@@ -145,6 +147,7 @@ static const struct xpad_device {
 	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
 	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
+	{ 0x046d, 0xcaa3, "Logitech DriveFx Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x056e, 0x2004, "Elecom JC-U3613M", 0, XTYPE_XBOX360 },
 	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", 0, XTYPE_XBOX },
 	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
@@ -158,14 +161,19 @@ static const struct xpad_device {
 	{ 0x0738, 0x4718, "Mad Catz Street Fighter IV FightStick SE", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4726, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4728, "Mad Catz Street Fighter IV FightPad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x0738, 0x4736, "Mad Catz MicroCon Gamepad", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0x4740, "Mad Catz Beat Pad", 0, XTYPE_XBOX360 },
+	{ 0x0738, 0x4758, "Mad Catz Arcade Game Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0x4a01, "Mad Catz FightStick TE 2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x0738, 0x9871, "Mad Catz Portable Drum", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xb726, "Mad Catz Xbox controller - MW2", 0, XTYPE_XBOX360 },
+	{ 0x0738, 0xb738, "Mad Catz MVC2TE Stick 2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0xbeef, "Mad Catz JOYTECH NEO SE Advanced GamePad", XTYPE_XBOX360 },
 	{ 0x0738, 0xcb02, "Saitek Cyborg Rumble Pad - PC/Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xcb03, "Saitek P3200 Rumble Pad - PC/Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x0738, 0xcb29, "Saitek Aviator Stick AV8R02", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xf738, "Super SFIV FightStick TE S", 0, XTYPE_XBOX360 },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", DANCEPAD_MAP_CONFIG, XTYPE_XBOX },
@@ -181,30 +189,52 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0105, "HSM3 Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0113, "Afterglow AX.1 Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x011f, "Rock Candy Gamepad Wired Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0131, "PDP EA Sports Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0133, "Xbox 360 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0139, "Afterglow Prismatic Wired Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x013a, "PDP XboxOne Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0146, "Rock Candy Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0147, "PDP Marvel XboxOne Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x015c, "PDP XboxOne ArcadeStick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0161, "PDP XboxOne Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0162, "PDP XboxOne Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0163, "PDP XboxOne Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0164, "PDP Battlefield One", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0165, "PDP Titanfall 2", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0201, "Pelican PL-3601 'TSZ' Wired Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0346, "RockCandy Gamepad for XboxOne 2016", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0413, "Afterglow AX.1 Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0501, "PDP Xbox360 Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0xf900, "PDP Afterglow AX.1", 0, XTYPE_XBOX360 },
 	{ 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", 0, XTYPE_XBOX },
 	{ 0x0e8f, 0x3008, "Generic xbox control (dealextreme)", 0, XTYPE_XBOX },
 	{ 0x0f0d, 0x000a, "Hori Co. DOA4 FightStick", 0, XTYPE_XBOX360 },
+	{ 0x0f0d, 0x000c, "Hori PadEX Turbo", 0, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x000d, "Hori Fighting Stick EX2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x0f0d, 0x001b, "Hori Real Arcade Pro VX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x0f0d, 0x0063, "Hori Real Arcade Pro Hayabusa (USA) XboxOne", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0067, "HORIPAD ONE", 0, XTYPE_XBOXONE },
+	{ 0x0f0d, 0x0078, "Hori Real Arcade Pro V Kai XboxOne", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
 	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", 0, XTYPE_XBOX },
 	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", 0, XTYPE_XBOX },
+	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
+	{ 0x12ab, 0x0303, "Mortal Kombat Klassic FightStick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", 0, XTYPE_XBOX360 },
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
@@ -215,22 +245,42 @@ static const struct xpad_device {
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0x0130, "Ion Drum Rocker", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf016, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf018, "Mad Catz Street Fighter IV SE Fighting Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf019, "Mad Catz Brawlstick for Xbox 360", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf021, "Mad Cats Ghost Recon FS GamePad", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf023, "MLG Pro Circuit Controller (Xbox)", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf025, "Mad Catz Call Of Duty", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf027, "Mad Catz FPS Pro", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf028, "Street Fighter IV FightPad", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf02e, "Mad Catz Fightpad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf038, "Street Fighter IV FightStick TE", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf039, "Mad Catz MvC2 TE", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf03a, "Mad Catz SFxT Fightstick Pro", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf03d, "Street Fighter IV Arcade Stick TE - Chun Li", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf03e, "Mad Catz MLG FightStick TE", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf03f, "Mad Catz FightStick SoulCaliber", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf042, "Mad Catz FightStick TES+", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf080, "Mad Catz FightStick TE2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf501, "HoriPad EX2 Turbo", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf502, "Hori Real Arcade Pro.VX SA", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf503, "Hori Fighting Stick VX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf504, "Hori Real Arcade Pro. EX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf505, "Hori Fighting Stick EX2B", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf506, "HORI Real Arcade Pro.EX Premium VLX", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf900, "Harmonix Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf901, "Gamestop Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf903, "Tron Xbox 360 controller", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf904, "PDP VersusPad", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf906, "MortalKombat FightStick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xfa01, "MadCatz GamePad", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5300, "PowerA MINI PROEX Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5303, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0x530a, "Xbox360 ProEXController", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x531a, "PowerA Pro Ex", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5397, "FUS1ON Tournament Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x541a, "PowerA Xbox One Mini Wired Controller", 0, XTYPE_XBOXONE },
@@ -238,12 +288,18 @@ static const struct xpad_device {
 	{ 0x24c6, 0x543a, "PowerA Xbox One wired controller", 0, XTYPE_XBOXONE },
 	{ 0x24c6, 0x5500, "Hori XBOX 360 EX 2 with Turbo", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5501, "Hori Real Arcade Pro VX-SA", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0x5502, "Hori Fighting Stick VX Alt", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5503, "Hori Fighting Edge", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5506, "Hori SOULCALIBUR V Stick", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x550d, "Hori GEM Xbox controller", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0x550e, "Hori Real Arcade Pro V Kai 360", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x24c6, 0x551a, "PowerA FUSION Pro Controller", 0, XTYPE_XBOXONE },
+	{ 0x24c6, 0x561a, "PowerA FUSION Controller", 0, XTYPE_XBOXONE },
+	{ 0x24c6, 0x5b00, "ThrustMaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5b02, "Thrustmaster, Inc. GPX Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5b03, "Thrustmaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0xfafe, "RockCandy Gamepad For Xbox360", 0, XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
 };
@@ -338,6 +394,7 @@ static struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0e6f),		/* 0x0e6f X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
+	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
-- 
2.11.0

