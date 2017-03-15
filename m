From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2] HID: wacom: generic: Wacom mouse is only provided for opaque tablets
Date: Tue, 14 Mar 2017 17:08:16 -0700
Message-ID: <1489536496-29253-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35388 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdCOAJ4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 20:09:56 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so207353pge.2
        for <linux-input@vger.kernel.org>; Tue, 14 Mar 2017 17:09:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

Commit f85c9dc ("Support tool ID and additional tool types") introduced mouse
and lens cursor tools to generic codepath, which covers both display (direct)
and opaque tablets (indirect devices). However, mouse and lens cursor tools are
only provided for opaque tablets. This patch ignores mouse and lens cursor tools
if the device is a display tablet.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
v2: updated commit comments as requested by Jiri.
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

