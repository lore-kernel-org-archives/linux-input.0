From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: multitouch: Release all touch slots on reset_resume
Date: Fri, 11 Mar 2016 14:19:49 -0800
Message-ID: <20160311221949.GA14029@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35677 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcCKWTw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 17:19:52 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Benson Leung <bleung@chromium.org>

When resetting a device (especially after power loss) it is unlikely
that the firmware will keep the contact tracking data for the previous
touches and will be able to reconcile it with the new contacts, so
let's release all slots on reset resume as start anew.

Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/hid-multitouch.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6adb788..e24e33c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1148,8 +1148,30 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 
 #ifdef CONFIG_PM
+static void mt_release_contacts(struct hid_device *hid)
+{
+	struct hid_input *hidinput;
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		struct input_dev *input_dev = hidinput->input;
+		struct input_mt *mt = input_dev->mt;
+		int i;
+
+		if (mt) {
+			for (i = 0; i < mt->num_slots; i++) {
+				input_mt_slot(input_dev, i);
+				input_mt_report_slot_state(input_dev,
+							   MT_TOOL_FINGER,
+							   false);
+			}
+			input_sync(input_dev);
+		}
+	}
+}
+
 static int mt_reset_resume(struct hid_device *hdev)
 {
+	mt_release_contacts(hdev);
 	mt_set_maxcontacts(hdev);
 	mt_set_input_mode(hdev);
 	return 0;
-- 
2.7.0.rc3.207.g0ac5344


-- 
Dmitry
