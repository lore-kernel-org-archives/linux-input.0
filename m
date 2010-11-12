From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] Input: xpad - fix a memory leak
Date: Fri, 12 Nov 2010 10:49:40 +0800
Message-ID: <1289530180.20782.3.camel@mola>
References: <1289530116.20782.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38322 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0KLCpg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 21:45:36 -0500
In-Reply-To: <1289530116.20782.2.camel@mola>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marko Friedemann <mfr@bmx-chemnitz.de>, Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org

In xpad_led_disconnect(), what we really want is to kfree(xpad_led).
In xpad_disconnect(), add a missing kfree(xpad->bdata) to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/joystick/xpad.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 39c0265..26b2f2b 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -732,7 +732,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 
 	if (xpad_led) {
 		led_classdev_unregister(&xpad_led->led_cdev);
-		kfree(xpad_led->name);
+		kfree(xpad_led);
 	}
 }
 #else
@@ -989,6 +989,7 @@ static void xpad_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 	if (xpad) {
+		kfree(xpad->bdata);
 		xpad_led_disconnect(xpad);
 		input_unregister_device(xpad->dev);
 		xpad_deinit_output(xpad);
-- 
1.7.2



