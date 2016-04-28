From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 3/4] Input: xpad: correctly sort vendor id's
Date: Thu, 28 Apr 2016 22:43:18 +0200
Message-ID: <1461876199-6992-4-git-send-email-rojtberg@gmail.com>
References: <1461876199-6992-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34030 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbcD1Un2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2016 16:43:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so666780wmn.1
        for <linux-input@vger.kernel.org>; Thu, 28 Apr 2016 13:43:27 -0700 (PDT)
In-Reply-To: <1461876199-6992-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Daniel Tobias <dan.g.tob@gmail.com>, Pavel Rojtberg <rojtberg@gmail.com>

From: Daniel Tobias <dan.g.tob@gmail.com>

Signed-off-by: Daniel Tobias <dan.g.tob@gmail.com>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d0104e1..b3819e0 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -314,18 +314,19 @@ static struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
 	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x0e6f),		/* 0x0e6f X-Box One controllers */
+	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
+	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
-	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
-	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
-	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
-	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
-	XPAD_XBOX360_VENDOR(0x24c6),		/* PowerA Controllers */
 	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
 	XPAD_XBOX360_VENDOR(0x1532),		/* Razer Sabertooth */
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech X-Box 360 controllers */
+	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
+	XPAD_XBOX360_VENDOR(0x24c6),		/* PowerA Controllers */
+	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
 	{ }
 };
 
-- 
1.9.1

