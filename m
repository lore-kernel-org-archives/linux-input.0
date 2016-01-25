From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] input: xpad: remove unused function
Date: Mon, 25 Jan 2016 16:30:41 +0100
Message-ID: <1453735884-1958624-1-git-send-email-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62148 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbcAYPby (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2016 10:31:54 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Pavel Rojtberg <rojtberg@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

There are two definitions of xpad_identify_controller(), one is used
when CONFIG_JOYSTICK_XPAD_LEDS is set, but the other one is empty
and never used, and we get a gcc warning about it:

drivers/input/joystick/xpad.c:1210:13: warning: 'xpad_identify_controller' defined but not used [-Wunused-function]

This removes the second definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cae705baa40b ("Input: xpad - re-send LED command on present event")
---
 drivers/input/joystick/xpad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6727954ab74b..e8a84d12b7ff 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1207,7 +1207,6 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 #else
 static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
 static void xpad_led_disconnect(struct usb_xpad *xpad) { }
-static void xpad_identify_controller(struct usb_xpad *xpad) { }
 #endif
 
 static int xpad_start_input(struct usb_xpad *xpad)
-- 
2.7.0

