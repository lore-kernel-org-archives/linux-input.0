From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - fix wireless 360 controller breaking after
 suspend
Date: Sat, 23 Jul 2016 01:27:41 -0700
Message-ID: <0635c1d0-7572-bac9-99cc-7a0db54c9013@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33284 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcGWI1o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jul 2016 04:27:44 -0400
Received: by mail-pa0-f66.google.com with SMTP id q2so8188457pap.0
        for <linux-input@vger.kernel.org>; Sat, 23 Jul 2016 01:27:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

Suspending and resuming the system can sometimes cause the out
URB to get hung after a reset_resume. This causes LED setting
and force feedback to break on resume. To avoid this, just drop
the reset_resume callback so the USB core rebinds xpad to the
wireless pads on resume if a reset happened.

A nice side effect of this change is the LED ring on wireless
controllers is now set correctly on system resume.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/joystick/xpad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a529a45..843054a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1626,7 +1626,6 @@ static struct usb_driver xpad_driver = {
 	.disconnect	= xpad_disconnect,
 	.suspend	= xpad_suspend,
 	.resume		= xpad_resume,
-	.reset_resume	= xpad_resume,
 	.id_table	= xpad_table,
 };
 
-- 
2.7.4
