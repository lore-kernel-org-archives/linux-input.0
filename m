From: =?ISO-8859-1?Q?Nicolas_L=E9veill=E9?= <knos@free.fr>
Subject: [PATCH 1/3] (uu.6cd36bd9ef57) joystick/xpad.c -- Support HORI RAP.EX/MadCatz
 Fightpad
Date: Sun, 22 Nov 2009 09:55:38 +0100
Message-ID: <4B08FC8A.6030404@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:47782 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbZKVI7k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Nov 2009 03:59:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Part one of three patches against latest head of
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

--
     Added two new Xbox 360 devices:
       - HORI Real Arcade Pro.EX
       - Mad Catz SFIV Fightpad

     Signed-off-by: Nicolas L=E9veill=E9 <nicolas@uucidl.com>

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
index 79e3edc..482cb12 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -125,6 +125,7 @@ static const struct xpad_device {
  	{ 0x0738, 0x4540, "Mad Catz Beat Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XB=
OX },
  	{ 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller",
MAP_DPAD_TO_AXES, XTYPE_XBOX },
  	{ 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller",
MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
+	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)",
MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
  	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS,
XTYPE_XBOX },
  	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES,
XTYPE_XBOX },
  	{ 0x0c12, 0x880a, "Pelican Eclipse PL-2023", MAP_DPAD_TO_AXES,
XTYPE_XBOX },
@@ -146,6 +147,7 @@ static const struct xpad_device {
  	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller",
MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
  	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES,
XTYPE_XBOX360 },
  	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS,
XTYPE_XBOX360 },
+	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_DPAD_TO_AXES,
XTYPE_XBOX360 },
  	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_AXES,
XTYPE_XBOX },
  	{ 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN, XTYPE_UNKNO=
WN }
  };
@@ -212,6 +214,7 @@ static struct usb_device_id xpad_table [] =3D {
  	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
  	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
  	XPAD_XBOX360_VENDOR(0x1bad),		/* Rock Band Drums */
+	XPAD_XBOX360_VENDOR(0x0f0d),            /* Hori Controllers */
  	{ }
  };


=2E

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
