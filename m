From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 1/2] also allow joysticks with buttons only
Date: Sun, 04 Apr 2010 01:13:53 +0200
Message-ID: <1270336433.4282.3.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:42836 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab0DCXJB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Apr 2010 19:09:01 -0400
Received: by fxm23 with SMTP id 23so2155981fxm.21
        for <linux-input@vger.kernel.org>; Sat, 03 Apr 2010 16:08:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dominic Cerquetti <binary1230@yahoo.com>, Jan Kratochvil <honza@jikos.cz>

dance pads don't have an axis, so allow this kind of
controller (joystick)


Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/joydev.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index c52bec4..423e0e6 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -929,6 +929,24 @@ static const struct input_device_id joydev_ids[] = {
 		.evbit = { BIT_MASK(EV_ABS) },
 		.absbit = { BIT_MASK(ABS_THROTTLE) },
 	},
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = {[BIT_WORD(BTN_JOYSTICK)] = BIT_MASK(BTN_JOYSTICK) },
+	},
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(BTN_GAMEPAD)] = BIT_MASK(BTN_GAMEPAD) },
+	},
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+		.keybit = { [BIT_WORD(BTN_TRIGGER_HAPPY)] = BIT_MASK(BTN_TRIGGER_HAPPY) },
+	},
 	{ }	/* Terminating entry */
 };
 
-- 
1.5.6.5



