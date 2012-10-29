From: Ingo Ruhnke <grumbel@gmail.com>
Subject: [PATCH] HID: fix incorrect handling of devices with high button
 count
Date: Mon, 29 Oct 2012 14:29:30 +0100
Message-ID: <508e9004.5593cc0a.3323.0a6c@mx.google.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36712 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab2J2ORm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Oct 2012 10:17:42 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1998492bkc.19
        for <linux-input@vger.kernel.org>; Mon, 29 Oct 2012 07:17:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Button names for USB gamepads are currently assigned incorrectly, as
the evdev code assigned to buttons is "BTN_GAMEPAD + code", which on
devices with more then 16 buttons bleeds over into button names
reserved for graphic tablets (BTN_TOOL_PEN, etc.). This causes
problems further down the line as the device are now no longer
detected as joystick. This patch fixes that by assigning buttons
outside the range to BTN_TRIGGER_HAPPY (as is already the case for USB
joysticks).

Furthermore this patch corrects the assignment to BTN_TRIGGER_HAPPY,
as currently the first button over 16 is assigned to
BTN_TRIGGER_HAPPY17 (i.e. BTN_TRIGGER_HAPPY+0x10) not BTN_TRIGGER_HAPPY.

Signed-off-by: Ingo Ruhnke <grumbel@gmail.com>
---
 drivers/hid/hid-input.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d917c0d..10248cf 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -502,9 +502,14 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 				if (code <= 0xf)
 					code += BTN_JOYSTICK;
 				else
-					code += BTN_TRIGGER_HAPPY;
+					code += BTN_TRIGGER_HAPPY - 0x10;
+				break;
+		case HID_GD_GAMEPAD:
+				if (code <= 0xf)
+					code += BTN_GAMEPAD;
+				else
+					code += BTN_TRIGGER_HAPPY - 0x10;
 				break;
-		case HID_GD_GAMEPAD:  code += BTN_GAMEPAD; break;
 		default:
 			switch (field->physical) {
 			case HID_GD_MOUSE:
-- 
1.7.10.4

