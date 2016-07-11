From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Stop mapping touch usages after processing HID_DG_CONTACTCOUNT
Date: Mon, 11 Jul 2016 10:59:50 -0700
Message-ID: <20160711175950.17121-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36242 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcGKR76 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 13:59:58 -0400
Received: by mail-pa0-f68.google.com with SMTP id ib6so13165730pad.3
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2016 10:59:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

If a touchscreen contains both multitouch and single-touch reports in its
descriptor in that order, the driver may overwrite information it saved
about the format of the multitouch report. This can cause the report
processing code to get tripped up and send an incorrect event stream to
userspace.

In particular, this can cause last_slot_field to be overwritten with the
result that the driver prematurely assumes it has finished processing a
slot and sending the ABS_MT_SLOT event at the wrong point in time,
associating events for the current contact with the following contact
instead.

To prevent this from occuring, we stop mapping usages after having seen
HID_DG_CONTACTCOUNT. This usage is only present in multitouch reports,
so the format of any following single-touch reports will have no effect.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index fcf2264..e499cdb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1560,6 +1560,11 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 	struct input_dev *input = wacom_wac->touch_input;
 	unsigned touch_max = wacom_wac->features.touch_max;
 
+	/* stop processing after the first multitouch report */
+	if (wacom_wac->hid_data.cc_report &&
+	    wacom_wac->hid_data.cc_report != field->report->id)
+		return;
+
 	switch (usage->hid) {
 	case HID_GD_X:
 		features->last_slot_field = usage->hid;
-- 
2.9.0

