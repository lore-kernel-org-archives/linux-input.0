From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: hid-input: Add eraser usage to hidinput_configure_usage
Date: Thu, 21 Sep 2017 15:37:06 -0700
Message-ID: <20170921223706.3289-1-ping.cheng@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38709 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdIUWhx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 21 Sep 2017 18:37:53 -0400
Received: by mail-pg0-f65.google.com with SMTP id m30so4150530pgn.5
        for <linux-input@vger.kernel.org>; Thu, 21 Sep 2017 15:37:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, toshiki.takeuchi@wacom.com, killertofu@gmail.com, Ping Cheng <ping.cheng@wacom.com>

Some tablets report eraser usage to indicate the eraser tool. But,
hidinput_configure_usage doesn't support it, which led the usage
falls into default as ABS_MISC.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/hid-input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 199f6a01fc62..4d36b08494fd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -797,6 +797,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			map_key_clear(BTN_STYLUS);
 			break;
 
+		case 0x45: /* ERASER */
+			map_key_clear(BTN_TOUCH);
+			break;
+
 		case 0x46: /* TabletPick */
 		case 0x5a: /* SecondaryBarrelSwitch */
 			map_key_clear(BTN_STYLUS2);
-- 
2.13.5

