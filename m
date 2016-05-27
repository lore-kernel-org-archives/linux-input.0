From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 6/7] Input: xpad: move reporting xbox one home button to common function
Date: Fri, 27 May 2016 02:12:54 +0200
Message-ID: <1464307975-25890-7-git-send-email-rojtberg@gmail.com>
References: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35905 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbcE0ANQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 20:13:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so9970568wmg.3
        for <linux-input@vger.kernel.org>; Thu, 26 May 2016 17:13:15 -0700 (PDT)
In-Reply-To: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Daniel Tobias <dan.g.tob@gmail.com>, Pavel Rojtberg <rojtberg@gmail.com>

From: Daniel Tobias <dan.g.tob@gmail.com>

xbox one was the only device that has a *_process_buttons routine.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 52 +++++++++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ba3ac27..4ecbbbf 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -604,14 +604,28 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 }
 
 /*
- *	xpadone_process_buttons
+ *	xpadone_process_packet
  *
- *	Process a button update packet from an Xbox one controller.
+ *	Completes a request by converting the data into events for the
+ *	input subsystem. This version is for the Xbox One controller.
+ *
+ *	The report format was gleaned from
+ *	https://github.com/kylelemons/xbox/blob/master/xbox.go
  */
-static void xpadone_process_buttons(struct usb_xpad *xpad,
-				struct input_dev *dev,
-				unsigned char *data)
+static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
+	struct input_dev *dev = xpad->dev;
+
+	/* the xbox button has its own special report */
+	if (data[0] == 0X07) {
+		input_report_key(dev, BTN_MODE, data[4] & 0x01);
+		input_sync(dev);
+		return;
+	}
+	/* check invalid packet */
+	else if (data[0] != 0X20)
+		return;
+
 	/* menu/view buttons */
 	input_report_key(dev, BTN_START,  data[4] & 0x04);
 	input_report_key(dev, BTN_SELECT, data[4] & 0x08);
@@ -674,34 +688,6 @@ static void xpadone_process_buttons(struct usb_xpad *xpad,
 	input_sync(dev);
 }
 
-/*
- *	xpadone_process_packet
- *
- *	Completes a request by converting the data into events for the
- *	input subsystem. This version is for the Xbox One controller.
- *
- *	The report format was gleaned from
- *	https://github.com/kylelemons/xbox/blob/master/xbox.go
- */
-
-static void xpadone_process_packet(struct usb_xpad *xpad,
-				u16 cmd, unsigned char *data)
-{
-	struct input_dev *dev = xpad->dev;
-
-	switch (data[0]) {
-	case 0x20:
-		xpadone_process_buttons(xpad, dev, data);
-		break;
-
-	case 0x07:
-		/* the xbox button has its own special report */
-		input_report_key(dev, BTN_MODE, data[4] & 0x01);
-		input_sync(dev);
-		break;
-	}
-}
-
 static void xpad_irq_in(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
-- 
2.7.4

