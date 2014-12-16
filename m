From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH v2 2/3] HID: logitech-hidpp: check WTP report length
Date: Tue, 16 Dec 2014 16:55:22 +0100
Message-ID: <1418745323-17133-2-git-send-email-peter@lekensteyn.nl>
References: <CAN+gG=EL0kYim=_uaS4yj7c_XC8rKa1eELxpVXaOuvnWgT_eQw@mail.gmail.com>
 <1418745323-17133-1-git-send-email-peter@lekensteyn.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:59917 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbaLPPzi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2014 10:55:38 -0500
In-Reply-To: <1418745323-17133-1-git-send-email-peter@lekensteyn.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Malicious USB devices can send bogus reports smaller than the expected
buffer size. Ensure that the length for WTP reports is valid to avoid
reading out of bounds.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 v1: patch 2/3 HID: logitech-{dj,hidpp}: check report length
 v2: splitted original report length check patch
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b32f751..2f1b0ac 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -805,6 +805,11 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 
 	switch (data[0]) {
 	case 0x02:
+		if (size < 2) {
+			hid_err(hdev, "Received HID report of bad size (%d)",
+				size);
+			return 1;
+		}
 		if (hidpp->quirks & HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS) {
 			input_event(wd->input, EV_KEY, BTN_LEFT,
 					!!(data[1] & 0x01));
@@ -818,6 +823,7 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 			return wtp_mouse_raw_xy_event(hidpp, &data[7]);
 		}
 	case REPORT_ID_HIDPP_LONG:
+		/* size is already checked in hidpp_raw_event. */
 		if ((report->fap.feature_index != wd->mt_feature_index) ||
 		    (report->fap.funcindex_clientid != EVENT_TOUCHPAD_RAW_XY))
 			return 1;
-- 
2.1.3

