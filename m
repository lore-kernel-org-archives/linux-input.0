From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [patch] xpad: add BigBen Interactive XBOX 360 Controller
Date: Mon, 05 Oct 2009 12:12:03 +0300
Message-ID: <4AC9B863.6000100@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:54193 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932318AbZJEJMq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Oct 2009 05:12:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux input list <linux-input@vger.kernel.org>, Thomas Gruber <kerneldev@tuxpower.org>

From: Thomas Gruber <kerneldev@tuxpower.org>

Add BigBen Interactive XBOX 360 Controller (146b:0601) to xpad driver.

Signed-off-by: Thomas Gruber <kerneldev@tuxpower.org>
Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>

---
 drivers/input/joystick/xpad.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2388cf5..79e3edc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -143,6 +143,7 @@ static const struct xpad_device {
 	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_AXES, XTYPE_XBOX },
@@ -209,6 +210,7 @@ static struct usb_device_id xpad_table [] = {
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
+	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Rock Band Drums */
 	{ }
 };


-- 
Anssi Hannula

