From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/3] HID: wacom: Ignore contacts in excess of declared contact count
Date: Tue, 21 Jul 2015 11:07:24 -0700
Message-ID: <1437502045-29927-2-git-send-email-killertofu@gmail.com>
References: <1437502045-29927-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33619 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933274AbbGUSHm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 14:07:42 -0400
Received: by padck2 with SMTP id ck2so123570479pad.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 11:07:41 -0700 (PDT)
In-Reply-To: <1437502045-29927-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The reports sent from some touch devices (e.g. the Cintiq 24HDT) contain
junk data in the contact slots which follow the final "valid" contact.
To avoid forwarding it to usrspace, we store the reported contact count
during the pre-process phase and then only process that many contacts.
If a device sends its contacts across multiple reports (what Microsoft
refers to as "hybrid" mode) then the contact count will be zero for
reports other than the first.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 30 +++++++++++++++++++++++++++++-
 drivers/hid/wacom_wac.h |  4 ++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1d9d5d1..09fe5d6 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1510,6 +1510,10 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 		features->last_slot_field = usage->hid;
 		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
 		break;
+	case HID_DG_CONTACTCOUNT:
+		wacom_wac->hid_data.cc_index = field->index;
+		wacom_wac->hid_data.cc_value_index = usage->usage_index;
+		break;
 	}
 }
 
@@ -1521,6 +1525,10 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 	bool prox = hid_data->tipswitch &&
 		    !wacom_wac->shared->stylus_in_proximity;
 
+	wacom_wac->hid_data.num_received++;
+	if (wacom_wac->hid_data.num_received > wacom_wac->hid_data.num_expected)
+		return;
+
 	if (mt) {
 		int slot;
 
@@ -1573,7 +1581,19 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 static void wacom_wac_finger_pre_report(struct hid_device *hdev,
 		struct hid_report *report)
 {
-	return;
+	struct wacom *wacom = hid_get_drvdata(hdev);
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct hid_data* hid_data = &wacom_wac->hid_data;
+
+	if (hid_data->cc_index >= 0) {
+		struct hid_field *field = report->field[hid_data->cc_index];
+		int value = field->value[hid_data->cc_value_index];
+		if (value)
+			hid_data->num_expected = value;
+	}
+	else {
+		hid_data->num_expected = wacom_wac->features.touch_max;
+	}
 }
 
 static void wacom_wac_finger_report(struct hid_device *hdev,
@@ -1584,10 +1604,18 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
 	struct input_dev *input = wacom_wac->touch_input;
 	unsigned touch_max = wacom_wac->features.touch_max;
 
+	/* If more packets of data are expected, give us a chance to
+	 * process them rather than immediately syncing a partial
+	 * update.
+	 */
+	if (wacom_wac->hid_data.num_received < wacom_wac->hid_data.num_expected)
+		return;
+
 	if (touch_max > 1)
 		input_mt_sync_frame(input);
 
 	input_sync(input);
+	wacom_wac->hid_data.num_received = 0;
 
 	/* keep touch state for pen event */
 	wacom_wac->shared->touch_down = wacom_wac_finger_count_touches(wacom_wac);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 2978c30..c245a66 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -193,6 +193,10 @@ struct hid_data {
 	int width;
 	int height;
 	int id;
+	int cc_index;
+	int cc_value_index;
+	int num_expected;
+	int num_received;
 };
 
 struct wacom_wac {
-- 
2.4.6

