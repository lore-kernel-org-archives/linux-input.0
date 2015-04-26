From: clement.calmels@free.fr
Subject: [PATCH] Input: Fix led setting on wireless xbox 360 controller
Date: Sun, 26 Apr 2015 14:33:27 +0200
Message-ID: <1430051607-1426-1-git-send-email-clement.calmels@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Clement Calmels <clement.calmels@free.fr>
List-Id: linux-input@vger.kernel.org

From: Clement Calmels <clement.calmels@free.fr>

When a wireless xbox 360 controller connects, its leds keep blinking
instead of indicating the contoller number.

This patch fix this issue. Tested with two wireless xbox360
controllers and the USB wireless gaming receiver:
Bus 002 Device 004: ID 045e:0719 Microsoft Corp. Xbox 360 Wireless Adapter

Signed-off-by: Clement Calmels <clement.calmels@free.fr>
---
 drivers/input/joystick/xpad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 61c7611..6e211b0 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1209,7 +1209,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 					 usb_sndintpipe(udev,
 							ep_irq_in->bEndpointAddress),
 					 xpad->bdata, XPAD_PKT_LEN,
-					 xpad_bulk_out, xpad, 0);
+					 xpad_bulk_out, xpad,
+					 ep_irq_in->bInterval);
 		}
 
 		/*
-- 
2.1.4
