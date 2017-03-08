From: Matjaz Hegedic <matjaz.hegedic@gmail.com>
Subject: [PATCH v2 2/3] HID: asus: ignore declared dummy usages
Date: Thu,  9 Mar 2017 00:31:14 +0100
Message-ID: <1489015875-3558-2-git-send-email-matjaz.hegedic@gmail.com>
References: <1489015875-3558-1-git-send-email-matjaz.hegedic@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35373 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbdCHXjE (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Mar 2017 18:39:04 -0500
Received: by mail-wr0-f193.google.com with SMTP id u108so5985209wrb.2
        for <linux-input@vger.kernel.org>; Wed, 08 Mar 2017 15:38:17 -0800 (PST)
In-Reply-To: <1489015875-3558-1-git-send-email-matjaz.hegedic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, Matjaz Hegedic <matjaz.hegedic@gmail.com>

Keyboards handled by hid-asus declare special key functions
using a vendor-specific page, however, alongside legitimate
key functions, dummy usages with seemingly arbitrary values
are also declared and can lead to keyboards being detected
as pointer devices by some software (such as X.org).

In addition, for the I2C keyboard volume controls are
separately declared in a Consumer Usage page, with the same
dummy usage problem.

The fix in 1989dada7ce0 ("HID: input: ignore System Control
application usages if not System Controls") does not mitigate
the problem described above, therefore dummy usages need to
be ignored in the driver itself.

This fix properly ignores dummy usages and introduces a quirk
for custom handling of the Consumer Usages on the I2C keyboard.

Signed-off-by: Matjaz Hegedic <matjaz.hegedic@gmail.com>
---
 drivers/hid/hid-asus.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 20fe97f..e0de54b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -63,9 +63,11 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_NO_INIT_REPORTS		BIT(1)
 #define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
 #define QUIRK_IS_MULTITOUCH		BIT(3)
+#define QUIRK_NO_CONSUMER_USAGES	BIT(4)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
-						 QUIRK_NO_INIT_REPORTS)
+						 QUIRK_NO_INIT_REPORTS | \
+						 QUIRK_NO_CONSUMER_USAGES)
 #define I2C_TOUCHPAD_QUIRKS			(QUIRK_NO_INIT_REPORTS | \
 						 QUIRK_SKIP_INPUT_MAPPING | \
 						 QUIRK_IS_MULTITOUCH)
@@ -242,11 +244,28 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0x5c: asus_map_key_clear(KEY_PROG3);		break;
 
 		default:
-			return 0;
+			/* ASUS lazily declares 256 usages, ignore the rest,
+			 * as some make the keyboard appear as a pointer device. */
+			return -1;
 		}
 		return 1;
 	}
 
+	if (drvdata->quirks & QUIRK_NO_CONSUMER_USAGES &&
+		(usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
+		switch (usage->hid & HID_USAGE) {
+		case 0xe2: /* Mute */
+		case 0xe9: /* Volume up */
+		case 0xea: /* Volume down */
+			return 0;
+		default:
+			/* Ignore dummy Consumer usages which make the
+			 * keyboard incorrectly appear as a pointer device.
+			 */
+			return -1;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.7.4

