From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 2/2] Input: xpad - sanitize xpad_led_disconnect()
Date: Thu,  2 Dec 2010 00:04:34 +0900
Message-ID: <1291215874-5625-2-git-send-email-namhyung@gmail.com>
References: <1291215874-5625-1-git-send-email-namhyung@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51097 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0LAPEy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 10:04:54 -0500
In-Reply-To: <1291215874-5625-1-git-send-email-namhyung@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kratochvil <honza@jikos.cz>

IMHO kfree() here looks very confusing. xpad_led->name is an array
of char inside struct xpad_led and is not a dynamic memory itself.
But kfree() works well because it is a first member of the struct
so it points start address of the struct and frees the struct.

Change it to xpad_led for the correctness & readability and make
xpad->led NULL for the safety.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
Cc: Jan Kratochvil <honza@jikos.cz>
---
 drivers/input/joystick/xpad.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f885902..1ca49e8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -728,7 +728,8 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 
 	if (xpad_led) {
 		led_classdev_unregister(&xpad_led->led_cdev);
-		kfree(xpad_led->name);
+		kfree(xpad_led);
+		xpad->led = NULL;
 	}
 }
 #else
-- 
1.7.0.4

