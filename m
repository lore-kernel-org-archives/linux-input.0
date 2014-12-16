From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH v2 3/3] HID: logitech-hidpp: separate HID++ from WTP processing
Date: Tue, 16 Dec 2014 16:55:23 +0100
Message-ID: <1418745323-17133-3-git-send-email-peter@lekensteyn.nl>
References: <CAN+gG=EL0kYim=_uaS4yj7c_XC8rKa1eELxpVXaOuvnWgT_eQw@mail.gmail.com>
 <1418745323-17133-1-git-send-email-peter@lekensteyn.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418745323-17133-1-git-send-email-peter@lekensteyn.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Previously wtp_raw_event would be called through
hidpp_raw_hidpp_event (for the touchpad report) and hidpp_raw_event
(for the mouse report).

This patch removes one calling surface, making a clearer distinction
between "generic HID++ processing" (matching internal reports) and
device-specific event processing.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 v1: patch 2/3 HID: logitech-{dj,hidpp}: check report length
 v2: splitted original report length check patch. Restructured code.
---
 drivers/hid/hid-logitech-hidpp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2f1b0ac..3dcd59c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -942,7 +942,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 
 	/*
 	 * If the mutex is locked then we have a pending answer from a
-	 * previoulsly sent command
+	 * previously sent command.
 	 */
 	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
 		/*
@@ -973,9 +973,6 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		return 1;
 	}
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
-		return wtp_raw_event(hidpp->hid_dev, data, size);
-
 	return 0;
 }
 
@@ -983,7 +980,9 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 		u8 *data, int size)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	int r = 0;
 
+	/* Generic HID++ processing. */
 	switch (data[0]) {
 	case REPORT_ID_HIDPP_LONG:
 		if (size != HIDPP_REPORT_LONG_LENGTH) {
@@ -991,16 +990,23 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 				size);
 			return 1;
 		}
-		return hidpp_raw_hidpp_event(hidpp, data, size);
+		r = hidpp_raw_hidpp_event(hidpp, data, size);
+		break;
 	case REPORT_ID_HIDPP_SHORT:
 		if (size != HIDPP_REPORT_SHORT_LENGTH) {
 			hid_err(hdev, "received hid++ report of bad size (%d)",
 				size);
 			return 1;
 		}
-		return hidpp_raw_hidpp_event(hidpp, data, size);
+		r = hidpp_raw_hidpp_event(hidpp, data, size);
+		break;
 	}
 
+	/* If no report is available for further processing, skip calling
+	 * raw_event of subclasses. */
+	if (r != 0)
+		return r;
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
 
-- 
2.1.3
