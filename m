From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/3] HID: wacom: Perform all event processing as part of report processing
Date: Tue, 21 Jul 2015 11:07:23 -0700
Message-ID: <1437502045-29927-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33490 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933274AbbGUSHk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 14:07:40 -0400
Received: by pdbnt7 with SMTP id nt7so53514078pdb.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 11:07:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

In some cases, we need access to information before it becomes available
to the 'event' handler. In particular, for some devices we cannot properly
process the finger data without first knowing the "contact count" at the
very end of the report (e.g. the Cintiq 24HDT touch screen, when forced
through the GENERIC codepath).

Since the HID subsystem doesn't provide a way to take action before 'event'
is called, we take a cue from hid-multitouch.c and add a pre-process step
within the 'report' handler that performs the same function.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c |  1 -
 drivers/hid/wacom_wac.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2a22163..d932349 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1690,7 +1690,6 @@ static struct hid_driver wacom_driver = {
 	.id_table =	wacom_ids,
 	.probe =	wacom_probe,
 	.remove =	wacom_remove,
-	.event =	wacom_wac_event,
 	.report =	wacom_wac_report,
 #ifdef CONFIG_PM
 	.resume =	wacom_resume,
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f5a0d3c..1d9d5d1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1437,6 +1437,12 @@ static int wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 	return 0;
 }
 
+static void wacom_wac_pen_pre_report(struct hid_device *hdev,
+		struct hid_report *report)
+{
+	return;
+}
+
 static void wacom_wac_pen_report(struct hid_device *hdev,
 		struct hid_report *report)
 {
@@ -1564,6 +1570,12 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
 	return 0;
 }
 
+static void wacom_wac_finger_pre_report(struct hid_device *hdev,
+		struct hid_report *report)
+{
+	return;
+}
+
 static void wacom_wac_finger_report(struct hid_device *hdev,
 		struct hid_report *report)
 {
@@ -1615,6 +1627,25 @@ int wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 	return 0;
 }
 
+static void wacom_report_events(struct hid_device *hdev, struct hid_report *report)
+{
+	int r;
+
+	for (r = 0; r < report->maxfield; r++) {
+		struct hid_field *field;
+		unsigned count, n;
+
+		field = report->field[r];
+		count = field->report_count;
+
+		if (!(HID_MAIN_ITEM_VARIABLE & field->flags))
+			continue;
+
+		for (n = 0; n < count; n++)
+			wacom_wac_event(hdev, field, &field->usage[n], field->value[n]);
+	}
+}
+
 void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
@@ -1625,6 +1656,14 @@ void wacom_wac_report(struct hid_device *hdev, struct hid_report *report)
 		return;
 
 	if (WACOM_PEN_FIELD(field))
+		wacom_wac_pen_pre_report(hdev, report);
+
+	if (WACOM_FINGER_FIELD(field))
+		wacom_wac_finger_pre_report(hdev, report);
+
+	wacom_report_events(hdev, report);
+
+	if (WACOM_PEN_FIELD(field))
 		return wacom_wac_pen_report(hdev, report);
 
 	if (WACOM_FINGER_FIELD(field))
-- 
2.4.6

