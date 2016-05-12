From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] HID: input: rework HID_QUIRK_MULTI_INPUT
Date: Thu, 12 May 2016 16:12:42 +0200
Message-ID: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42379 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbcELOMr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 10:12:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The purpose of HID_QUIRK_MULTI_INPUT is to have an input device per
report id. This is useful when the HID device presents several HID
collections of different device types.

The current implementation of hid-input creates one input node per id per
type (input or output). This is problematic for the LEDs of a keyboard as
they are often set through an output report. The current code creates
one input node with all the keyboard keys, and one other with only the
LEDs.

To solve this, we use a two-passes way:
- first, we initialize all input nodes and associate one per report id
- then, we register all the input nodes

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 95 ++++++++++++++++++++++++++++---------------------
 include/linux/hid.h     |  1 +
 2 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bcfaf32..bb2ec45 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1458,6 +1458,31 @@ static void hidinput_cleanup_hidinput(struct hid_device *hid,
 	kfree(hidinput);
 }
 
+static struct hid_input *hidinput_match(struct hid_report *report)
+{
+	struct hid_device *hid = report->device;
+	struct hid_input *hidinput;
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		if (hidinput->report &&
+		    hidinput->report->id == report->id)
+			return hidinput;
+	}
+
+	return NULL;
+}
+
+static inline void hidinput_configure_usages(struct hid_input *hidinput,
+					     struct hid_report *report)
+{
+	int i, j;
+
+	for (i = 0; i < report->maxfield; i++)
+		for (j = 0; j < report->field[i]->maxusage; j++)
+			hidinput_configure_usage(hidinput, report->field[i],
+						 report->field[i]->usage + j);
+}
+
 /*
  * Register the input device; print a message.
  * Configure the input layer interface
@@ -1468,8 +1493,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 {
 	struct hid_driver *drv = hid->driver;
 	struct hid_report *report;
-	struct hid_input *hidinput = NULL;
-	int i, j, k;
+	struct hid_input *next, *hidinput = NULL;
+	int i, k;
 
 	INIT_LIST_HEAD(&hid->inputs);
 	INIT_WORK(&hid->led_work, hidinput_led_worker);
@@ -1499,43 +1524,40 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 			if (!report->maxfield)
 				continue;
 
+			/*
+			 * Find the previous hidinput report attached
+			 * to this report id.
+			 */
+			if (hid->quirks & HID_QUIRK_MULTI_INPUT)
+				hidinput = hidinput_match(report);
+
 			if (!hidinput) {
 				hidinput = hidinput_allocate(hid);
 				if (!hidinput)
 					goto out_unwind;
 			}
 
-			for (i = 0; i < report->maxfield; i++)
-				for (j = 0; j < report->field[i]->maxusage; j++)
-					hidinput_configure_usage(hidinput, report->field[i],
-								 report->field[i]->usage + j);
-
-			if ((hid->quirks & HID_QUIRK_NO_EMPTY_INPUT) &&
-			    !hidinput_has_been_populated(hidinput))
-				continue;
+			hidinput_configure_usages(hidinput, report);
 
-			if (hid->quirks & HID_QUIRK_MULTI_INPUT) {
-				/* This will leave hidinput NULL, so that it
-				 * allocates another one if we have more inputs on
-				 * the same interface. Some devices (e.g. Happ's
-				 * UGCI) cram a lot of unrelated inputs into the
-				 * same interface. */
+			if (hid->quirks & HID_QUIRK_MULTI_INPUT)
 				hidinput->report = report;
-				if (drv->input_configured &&
-				    drv->input_configured(hid, hidinput))
-					goto out_cleanup;
-				if (input_register_device(hidinput->input))
-					goto out_cleanup;
-				hidinput = NULL;
-			}
 		}
 	}
 
-	if (hidinput && (hid->quirks & HID_QUIRK_NO_EMPTY_INPUT) &&
-	    !hidinput_has_been_populated(hidinput)) {
-		/* no need to register an input device not populated */
-		hidinput_cleanup_hidinput(hid, hidinput);
-		hidinput = NULL;
+	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
+		if ((hid->quirks & HID_QUIRK_NO_EMPTY_INPUT) &&
+		    !hidinput_has_been_populated(hidinput)) {
+			/* no need to register an input device not populated */
+			hidinput_cleanup_hidinput(hid, hidinput);
+			continue;
+		}
+
+		if (drv->input_configured &&
+		    drv->input_configured(hid, hidinput))
+			goto out_unwind;
+		if (input_register_device(hidinput->input))
+			goto out_unwind;
+		hidinput->registered = true;
 	}
 
 	if (list_empty(&hid->inputs)) {
@@ -1543,20 +1565,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 		goto out_unwind;
 	}
 
-	if (hidinput) {
-		if (drv->input_configured &&
-		    drv->input_configured(hid, hidinput))
-			goto out_cleanup;
-		if (input_register_device(hidinput->input))
-			goto out_cleanup;
-	}
-
 	return 0;
 
-out_cleanup:
-	list_del(&hidinput->list);
-	input_free_device(hidinput->input);
-	kfree(hidinput);
 out_unwind:
 	/* unwind the ones we already registered */
 	hidinput_disconnect(hid);
@@ -1573,7 +1583,10 @@ void hidinput_disconnect(struct hid_device *hid)
 
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		list_del(&hidinput->list);
-		input_unregister_device(hidinput->input);
+		if (hidinput->registered)
+			input_unregister_device(hidinput->input);
+		else
+			input_free_device(hidinput->input);
 		kfree(hidinput);
 	}
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75b66ec..8a5d697 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -479,6 +479,7 @@ struct hid_input {
 	struct list_head list;
 	struct hid_report *report;
 	struct input_dev *input;
+	bool registered;
 };
 
 enum hid_type {
-- 
2.5.0

