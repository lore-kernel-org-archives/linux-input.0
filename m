From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] HID: asus: Add missing Fn key maps on ASUS E200H
Date: Mon, 27 Mar 2017 10:41:04 +0200
Message-ID: <20170327084104.18105-1-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54045 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbdC0Il2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 04:41:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The mapping of a few Fn combo keys seems missing since they are vendor
specific usage page (0xff31).  Add the mapping manually for sleep
(Fn-F1), rfkill (Fn-F2), brightness down (Fn-F5), brightness up
(Fn-F6), display toggle (Fn-F7), and touchpad toggle (Fn-F9).
For the display toggle and the touchpad toggle, KEY_SCREENLOCK and
KEY_F21 are assigned as convention.

The monitor switch (Fn-F8), and audio volume down / up /mute (Fn-F10,
F11, F12) work as is without the extra mapping, thus left as is.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/hid/hid-asus.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 70b12f89a193..fe4ddaf339e7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -199,6 +199,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	return 0;
 }
 
+#define map_key(c)	hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
+
 static int asus_input_mapping(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit,
@@ -213,7 +215,25 @@ static int asus_input_mapping(struct hid_device *hdev,
 		return -1;
 	}
 
-	return 0;
+	/*
+	 * Map some missing Fn-combo keys on ASUS E200H
+	 */
+
+	if ((usage->hid & HID_USAGE_PAGE) != 0xff310000)
+		return 0;
+
+	switch (usage->hid & HID_USAGE) {
+	case 0x006c: map_key(KEY_SLEEP);		break; /* Fn+F1 */
+	case 0x0088: map_key(KEY_RFKILL);		break; /* Fn+F2 */
+	case 0x0010: map_key(KEY_BRIGHTNESSDOWN);	break; /* Fn+F5 */
+	case 0x0020: map_key(KEY_BRIGHTNESSUP);		break; /* Fn+F6 */
+	case 0x0035: map_key(KEY_SCREENLOCK);		break; /* Fn+F7 */
+	case 0x006b: map_key(KEY_F21);			break; /* Fn+F9 */
+	default:
+		return 0;
+	}
+
+	return 1;
 }
 
 static int asus_start_multitouch(struct hid_device *hdev)
-- 
2.11.1

