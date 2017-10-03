From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: hid-input: Add eraser usage to hidinput_configure_usage
Date: Tue,  3 Oct 2017 15:05:41 -0700
Message-ID: <20171003220541.3333-1-ping.cheng@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37940 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdJCWG3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Oct 2017 18:06:29 -0400
Received: by mail-pg0-f66.google.com with SMTP id y192so11234042pgd.5
        for <linux-input@vger.kernel.org>; Tue, 03 Oct 2017 15:06:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, toshiki.takeuchi@wacom.com, killertofu@gmail.com, Ping Cheng <ping.cheng@wacom.com>

Some tablets report eraser usage to indicate the eraser tool tip
is touching the surface. But, hidinput_configure_usage didn't
support the usage, which led it falls into default as ABS_MISC.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/hid-input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 199f6a01fc62..04d01b57d94c 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -797,6 +797,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			map_key_clear(BTN_STYLUS);
 			break;
 
+		case 0x45: /* ERASER */
+			/*
+			 * This event is reported when eraser tip touches the surface.
+			 * Actual eraser (BTN_TOOL_RUBBER) is set by Invert usage when
+			 * tool gets in proximity.
+			 */
+			map_key_clear(BTN_TOUCH);
+			break;
+
 		case 0x46: /* TabletPick */
 		case 0x5a: /* SecondaryBarrelSwitch */
 			map_key_clear(BTN_STYLUS2);
-- 
2.13.6

