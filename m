From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: generic: Wacom mouse is only provided for opaque tablets
Date: Tue,  7 Feb 2017 15:24:11 -0800
Message-ID: <1486509851-2977-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33501 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754666AbdBGXYU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Feb 2017 18:24:20 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so13307106pgd.0
        for <linux-input@vger.kernel.org>; Tue, 07 Feb 2017 15:24:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

So, don't add mouse and lens cursor tools.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d51daf5..b51aa27 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1952,8 +1952,10 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 		input_set_capability(input, EV_KEY, BTN_TOOL_BRUSH);
 		input_set_capability(input, EV_KEY, BTN_TOOL_PENCIL);
 		input_set_capability(input, EV_KEY, BTN_TOOL_AIRBRUSH);
-		input_set_capability(input, EV_KEY, BTN_TOOL_MOUSE);
-		input_set_capability(input, EV_KEY, BTN_TOOL_LENS);
+		if (!(features->device_type & WACOM_DEVICETYPE_DIRECT)) {
+			input_set_capability(input, EV_KEY, BTN_TOOL_MOUSE);
+			input_set_capability(input, EV_KEY, BTN_TOOL_LENS);
+		}
 		break;
 	case WACOM_HID_WD_FINGERWHEEL:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
-- 
2.7.4

