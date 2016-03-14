From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH RESEND] Input: xpad - prevent spurious input from wired Xbox
 360 controllers
Date: Mon, 14 Mar 2016 09:51:51 -0700
Message-ID: <56E6EC27.8060508@gmail.com>
References: <56B02F0B.40804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34083 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcCNQwH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 12:52:07 -0400
Received: by mail-ig0-f194.google.com with SMTP id av4so5772731igc.1
        for <linux-input@vger.kernel.org>; Mon, 14 Mar 2016 09:52:07 -0700 (PDT)
In-Reply-To: <56B02F0B.40804@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, rojtberg@gmail.com, pgriffais@valvesoftware.com

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
---
 drivers/input/joystick/xpad.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6727954..8b8ed9f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -455,6 +455,10 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
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
2.5.0

