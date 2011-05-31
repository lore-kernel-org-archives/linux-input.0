From: Magnus =?ISO-8859-1?Q?H=F6rlin?= <magnus@alefors.se>
Subject: [PATCH] xpad: Add support for two more dance pads and one more
 guitar
Date: Tue, 31 May 2011 08:36:39 +0200
Message-ID: <1306823799.8840.8.camel@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-g57y4BoSYqyUAUWT8dt+"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49496 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab1EaGgn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2011 02:36:43 -0400
Received: by eyx24 with SMTP id 24so1548039eyx.19
        for <linux-input@vger.kernel.org>; Mon, 30 May 2011 23:36:42 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: chf.fritz@googlemail.com


--=-g57y4BoSYqyUAUWT8dt+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi.
Please find attached a patch that adds support for some xbox 360 stuff I
bought for my kids.
/Magnus Hörlin


--=-g57y4BoSYqyUAUWT8dt+
Content-Disposition: attachment; filename="xpad.c.diff"
Content-Type: text/x-patch; name="xpad.c.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- linux-2.6.orig/drivers/input/joystick/xpad.c	2011-05-30 17:32:49.548000317 +0200
+++ linux-2.6/drivers/input/joystick/xpad.c	2011-05-20 14:17:00.458068908 +0200
@@ -154,10 +154,13 @@
 	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", 0, XTYPE_XBOX },
 	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", 0, XTYPE_XBOX },
 	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0105, "HSM3 Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", 0, XTYPE_XBOX360 },
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x000d, "Hori Fighting Stick EX2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
@@ -236,9 +239,10 @@
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
+	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
-	XPAD_XBOX360_VENDOR(0x1bad),		/* Rock Band Drums */
+	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
 	XPAD_XBOX360_VENDOR(0x0f0d),            /* Hori Controllers */
 	{ }
 };

--=-g57y4BoSYqyUAUWT8dt+--

