From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: xpad - use LED API when identifying wireless
 controllers
Date: Wed, 16 Dec 2015 14:44:08 -0800
Message-ID: <20151216224408.GA14261@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35931 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbbLPWoL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 17:44:11 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, Clement Calmels <clement.calmels@free.fr>, linux-kernel@vger.kernel.org

When lighting up the segment identifying wireless controller, Instead of
sending command directly to the controller, let's do it via LED API (usinf
led_set_brightness) so that LED object state is in sync with controller
state and we'll light up the correct segment on resume as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

I do not have the hardware so please try this out.

 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 36328b3..00a766b 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1118,7 +1118,7 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
  */
 static void xpad_identify_controller(struct usb_xpad *xpad)
 {
-	xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
+	led_set_brightness(&xpad->led->led_cdev, (xpad->pad_nr % 4) + 2);
 }
 
 static void xpad_led_set(struct led_classdev *led_cdev,
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
