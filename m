From: Florian@zmc.proxad.net, Fainelli@zmc.proxad.net
Subject: [PATCH] HID: replace offsets values with their corresponding BTN_* defines
Date: Tue, 14 Dec 2010 11:56:56 +0100
Message-ID: <1292324216-12627-1-git-send-email-ffainelli@freebox.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zmc.proxad.net ([212.27.53.206]:46052 "EHLO zmc.proxad.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754669Ab0LNLAX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Dec 2010 06:00:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Fainelli <ffainelli@freebox.fr>

From: Florian Fainelli <ffainelli@freebox.fr>

Instead of using magic values, use their corresponding BTN_* defines
from linux/input.h.

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
 drivers/hid/hid-input.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d8d372b..f505789 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -319,21 +319,21 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 		switch (field->application) {
 		case HID_GD_MOUSE:
-		case HID_GD_POINTER:  code += 0x110; break;
+		case HID_GD_POINTER:  code += BTN_MOUSE; break;
 		case HID_GD_JOYSTICK:
 				if (code <= 0xf)
 					code += BTN_JOYSTICK;
 				else
 					code += BTN_TRIGGER_HAPPY;
 				break;
-		case HID_GD_GAMEPAD:  code += 0x130; break;
+		case HID_GD_GAMEPAD:  code += BTN_GAMEPAD; break;
 		default:
 			switch (field->physical) {
 			case HID_GD_MOUSE:
-			case HID_GD_POINTER:  code += 0x110; break;
-			case HID_GD_JOYSTICK: code += 0x120; break;
-			case HID_GD_GAMEPAD:  code += 0x130; break;
-			default:              code += 0x100;
+			case HID_GD_POINTER:  code += BTN_MOUSE; break;
+			case HID_GD_JOYSTICK: code += BTN_JOYSTICK; break;
+			case HID_GD_GAMEPAD:  code += BTN_GAMEPAD; break;
+			default:              code += BTN_MISC;
 			}
 		}
 
-- 
1.5.6.5

