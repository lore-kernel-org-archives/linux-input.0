From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v4 13/14] HID: hid-multitouch: fix Win 8 protocol
Date: Wed, 14 Nov 2012 16:59:25 +0100
Message-ID: <1352908766-4492-14-git-send-email-benjamin.tissoires@gmail.com>
References: <1352908766-4492-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352908766-4492-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Win 8 protocol specify the fact that each valid touch must be reported
within a frame until it is released.
We can therefore use the always_valid quirk and dismiss reports when we see
duplicate contacts ID.

We recognize Win8 certified devices from their vendor feature 0xff0000c5
where Microsoft put a signed blob in the report to check if the device
passed the certification.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5f26b2f..efae60c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -295,6 +295,18 @@ static void mt_feature_mapping(struct hid_device *hdev,
 			td->maxcontacts = td->mtclass.maxcontacts;
 
 		break;
+	case 0xff0000c5:
+		if (field->report_count == 256 && field->report_size == 8) {
+			/* Win 8 devices need special quirks */
+			__s32 *quirks = &td->mtclass.quirks;
+			*quirks |= MT_QUIRK_ALWAYS_VALID;
+			*quirks |= MT_QUIRK_IGNORE_DUPLICATES;
+			*quirks |= MT_QUIRK_HOVERING;
+			*quirks &= ~MT_QUIRK_NOT_SEEN_MEANS_UP;
+			*quirks &= ~MT_QUIRK_VALID_IS_INRANGE;
+			*quirks &= ~MT_QUIRK_VALID_IS_CONFIDENCE;
+		}
+		break;
 	}
 }
 
-- 
1.8.0
