From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] HID: debug: add labels for some new buttons
Date: Tue, 17 Dec 2013 12:52:48 +0100
Message-ID: <1387281168-13856-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:45389 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab3LQLxF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Dec 2013 06:53:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Jiri Kosina <jkosina@suse.cz>

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

I also noticed that BTN_GEAR_DOWN is named "WheelBtn", should this be fixed?

Thanks,
   Antonio

 drivers/hid/hid-debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8453214..53b771d 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -768,6 +768,8 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_ALTERASE] = "AlternateErase",	[KEY_CANCEL] = "Cancel",
 	[KEY_BRIGHTNESSDOWN] = "BrightnessDown", [KEY_BRIGHTNESSUP] = "BrightnessUp",
 	[KEY_MEDIA] = "Media",			[KEY_UNKNOWN] = "Unknown",
+	[BTN_DPAD_UP] = "BtnDPadUp",		[BTN_DPAD_DOWN] = "BtnDPadDown",
+	[BTN_DPAD_LEFT] = "BtnDPadLeft",	[BTN_DPAD_RIGHT] = "BtnDPadRight",
 	[BTN_0] = "Btn0",			[BTN_1] = "Btn1",
 	[BTN_2] = "Btn2",			[BTN_3] = "Btn3",
 	[BTN_4] = "Btn4",			[BTN_5] = "Btn5",
@@ -797,7 +799,8 @@ static const char *keys[KEY_MAX + 1] = {
 	[BTN_TOOL_MOUSE] = "ToolMouse",		[BTN_TOOL_LENS] = "ToolLens",
 	[BTN_TOUCH] = "Touch",			[BTN_STYLUS] = "Stylus",
 	[BTN_STYLUS2] = "Stylus2",		[BTN_TOOL_DOUBLETAP] = "ToolDoubleTap",
-	[BTN_TOOL_TRIPLETAP] = "ToolTripleTap", [BTN_GEAR_DOWN] = "WheelBtn",
+	[BTN_TOOL_TRIPLETAP] = "ToolTripleTap",	[BTN_TOOL_QUADTAP] = "ToolQuadrupleTap",
+	[BTN_GEAR_DOWN] = "WheelBtn",
 	[BTN_GEAR_UP] = "Gear up",		[KEY_OK] = "Ok",
 	[KEY_SELECT] = "Select",		[KEY_GOTO] = "Goto",
 	[KEY_CLEAR] = "Clear",			[KEY_POWER2] = "Power2",
-- 
1.8.5.1

