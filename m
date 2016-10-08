From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH] Input: psmouse - cleanup Focaltech code
Date: Sat,  8 Oct 2016 13:38:56 +0300
Message-ID: <1475923136-6046-1-git-send-email-hanipouspilot@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:32982 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756513AbcJHKjK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 8 Oct 2016 06:39:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>, Dmitry Tunin <hanipouspilot@gmail.com>

psmouse->name "Focaltech Touchpad" is an overkill. In xinput it is too long as
"FocaltechPS/2 Focaltech Focaltech Touchpad"

In focaltech_report_state() pointer to psmouse->dev is already stored as *dev

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
---
 drivers/input/mouse/focaltech.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index c8c6a8c..49a56f655 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -43,7 +43,7 @@ int focaltech_detect(struct psmouse *psmouse, bool set_properties)
 
 	if (set_properties) {
 		psmouse->vendor = "FocalTech";
-		psmouse->name = "FocalTech Touchpad";
+		psmouse->name = "Touchpad";
 	}
 
 	return 0;
@@ -146,8 +146,8 @@ static void focaltech_report_state(struct psmouse *psmouse)
 	}
 	input_mt_report_pointer_emulation(dev, true);
 
-	input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
-	input_sync(psmouse->dev);
+	input_report_key(dev, BTN_LEFT, state->pressed);
+	input_sync(dev);
 }
 
 static void focaltech_process_touch_packet(struct psmouse *psmouse,
-- 
2.7.4

