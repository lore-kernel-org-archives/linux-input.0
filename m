From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 1/4] Input: xpad - prevent spurious input from wired Xbox 360 controllers
Date: Thu, 28 Apr 2016 22:43:16 +0200
Message-ID: <1461876199-6992-2-git-send-email-rojtberg@gmail.com>
References: <1461876199-6992-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33995 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbcD1Un0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2016 16:43:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so666594wmn.1
        for <linux-input@vger.kernel.org>; Thu, 28 Apr 2016 13:43:26 -0700 (PDT)
In-Reply-To: <1461876199-6992-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Cameron Gutman <aicommander@gmail.com>, Pavel Rojtberg <rojtberg@gmail.com>

From: Cameron Gutman <aicommander@gmail.com>

After initially connecting a wired Xbox 360 controller or sending it
a command to change LEDs, a status/response packet is interpreted as
controller input. This causes the state of buttons represented in
byte 2 of the controller data packet to be incorrect until the next
valid input packet. Wireless Xbox 360 controllers are not affected.

Writing a new value to the LED device while holding the Start button
and running jstest is sufficient to reproduce this bug. An event will
come through with the Start button released.

Xboxdrv also won't attempt to read controller input from a packet
where byte 0 is non-zero. It also checks that byte 1 is 0x14, but
that value differs between wired and wireless controllers and this
code is shared by both. I think just checking byte 0 is enough to
eliminate unwanted packets.

The following are some examples of 3-byte status packets I saw:
01 03 02
02 03 00
03 03 03
08 03 00

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 1142a93..0259d6d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -457,6 +457,10 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
 				   u16 cmd, unsigned char *data)
 {
+	/* valid pad data */
+	if (data[0] != 0x00)
+		return;
+
 	/* digital pad */
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		/* dpad as buttons (left, right, up, down) */
-- 
1.9.1

