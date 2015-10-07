From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Tie cached HID_DG_CONTACTCOUNT indices to report ID
Date: Wed,  7 Oct 2015 16:54:21 -0700
Message-ID: <1444262062-19247-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33210 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbbJGXyv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 19:54:51 -0400
Received: by pacex6 with SMTP id ex6so35244028pac.0
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2015 16:54:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, expiredpopsicle@gmail.com, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The cached indicies 'cc_index' and 'cc_value_index' introduced in 1b5d514
are only valid for a single report ID. If a touchscreen has multiple
reports with a HID_DG_CONTACTCOUNT usage, its possible that the values
will not be correct for the report we're handling, resulting in an
incorrect value for 'num_expected'. This has been observed with the Cintiq
Companion 2.

To address this, we store the ID of the report those indicies are valid
for in a new  'cc_report' variable. Before using them to get the expected
contact count, we first check if the ID of the report we're processing
matches 'cc_report'. If it doesn't, we update the indicies to point to
the HID_DG_CONTACTCOUNT usage of the current report (if it has one).

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Jiri,

Could you please queue this patch and the next for 4.3? They fix issues
with the implementation of my "Ignore contacts in excess of declared
contact count" patch which was pulled in as part of the 4.3 merge window.

Thanks :)

 drivers/hid/wacom_wac.c | 26 ++++++++++++++++++++++++++
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c40a6d1..4140b1d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1628,6 +1628,7 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
 		break;
 	case HID_DG_CONTACTCOUNT:
+		wacom_wac->hid_data.cc_report = field->report->id;
 		wacom_wac->hid_data.cc_index = field->index;
 		wacom_wac->hid_data.cc_value_index = usage->usage_index;
 		break;
@@ -1715,6 +1716,31 @@ static void wacom_wac_finger_pre_report(struct hid_device *hdev,
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct hid_data* hid_data = &wacom_wac->hid_data;
 
+	if (hid_data->cc_report != 0 &&
+	    hid_data->cc_report != report->id) {
+		int i;
+
+		hid_data->cc_report = report->id;
+		hid_data->cc_index = -1;
+		hid_data->cc_value_index = -1;
+
+		for (i = 0; i < report->maxfield; i++) {
+			struct hid_field *field = report->field[i];
+			int j;
+
+			for (j = 0; j < field->maxusage; j++) {
+				if (field->usage[j].hid == HID_DG_CONTACTCOUNT) {
+					hid_data->cc_index = i;
+					hid_data->cc_value_index = j;
+
+					/* break */
+					i = report->maxfield;
+					j = field->maxusage;
+				}
+			}
+		}
+	}
+
 	if (hid_data->cc_index >= 0) {
 		struct hid_field *field = report->field[hid_data->cc_index];
 		int value = field->value[hid_data->cc_value_index];
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 1e270d4..809c03e 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -198,6 +198,7 @@ struct hid_data {
 	int width;
 	int height;
 	int id;
+	int cc_report;
 	int cc_index;
 	int cc_value_index;
 	int num_expected;
-- 
2.6.1

