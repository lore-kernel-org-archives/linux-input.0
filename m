From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: [patch 5/7] xpad: enable force feedback on xbox 360 controllers only
Date: Mon, 17 Mar 2008 21:22:55 +0200
Message-ID: <20080317192846.133577829@gmail.com>
References: <20080317192250.208635026@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:34617 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942AbYCQT3F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Mar 2008 15:29:05 -0400
Content-Disposition: inline; filename=xpad-fix-false-ev_ff-bit.diff
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>

Commit 4994cd8dadcf9d484ab3ec19f3c7c7a4e5353c1c introduced a
regression which causes xpad to report force feedback cababilities
for non-360 controllers too, even while there is no actual support
for those.

Fix that by adding a check for XTYPE_XBOX360 to xpad_init_ff().

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 drivers/input/joystick/xpad.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c
===================================================================
--- linux-2.6.25-rc3-mm1-xpad.orig/drivers/input/joystick/xpad.c	2008-03-05 03:21:12.000000000 +0200
+++ linux-2.6.25-rc3-mm1-xpad/drivers/input/joystick/xpad.c	2008-03-05 03:28:49.000000000 +0200
@@ -497,6 +497,9 @@ static int xpad_play_effect(struct input
 
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
+	if (xpad->xtype != XTYPE_XBOX360)
+		return 0;
+
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
 
 	return input_ff_create_memless(xpad->dev, NULL, xpad_play_effect);

--
Anssi Hannula
