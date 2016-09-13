From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: wacom: do not detect Pad devices as joysticks
Date: Tue, 13 Sep 2016 11:52:38 +0200
Message-ID: <1473760358-31999-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1473760358-31999-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757445AbcIMJwq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 05:52:46 -0400
In-Reply-To: <1473760358-31999-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Well, joydev consider our Pad devices as joysticks and associate a
/dev/input/jsX node for them.

The problem is that it consider the ABS_X value as 0, and sends some
spurious joystick events saying the X axis is full left (Y too, but full
up). Given that we are basically screwed, add one more BTN which tells
joydev to ignore the Pad device and doesn't interfere with the rest of
the udev rules and the processing.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8fd115f..498f4a8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2920,6 +2920,9 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	/* kept for making udev and libwacom accepting the pad */
 	__set_bit(BTN_STYLUS, input_dev->keybit);
 
+	/* added to be ignored by joydev */
+	__set_bit(BTN_TOOL_PEN, input_dev->keybit);
+
 	wacom_setup_numbered_buttons(input_dev, features->numbered_buttons);
 
 	switch (features->type) {
-- 
2.7.4

