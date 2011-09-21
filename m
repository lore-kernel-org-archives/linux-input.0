From: Jaikumar Ganesh <jaikumarg@android.com>
Subject: [PATCH] HID: Add input_register callback.
Date: Tue, 20 Sep 2011 17:12:59 -0700
Message-ID: <1316563979-24342-1-git-send-email-jaikumarg@android.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:14887 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab1IUANI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 20:13:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumarg@android.com>

Add input_register callback which gets called after
hid_configure_usage is called for all the reports
and before the input device is registered. This allows
individual drivers to do extra work like input mapping just
before device registration.

Based on discussions with David Herrmann <dh.herrmann@googlemail.com>

Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
---
 drivers/hid/hid-input.c |    7 +++++++
 include/linux/hid.h     |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 6559e2e..1b71bcd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -971,6 +971,9 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 				 * UGCI) cram a lot of unrelated inputs into the
 				 * same interface. */
 				hidinput->report = report;
+				if (hid->driver->input_register &&
+						hid->driver->input_register(hid, hidinput))
+					goto out_cleanup;
 				if (input_register_device(hidinput->input))
 					goto out_cleanup;
 				hidinput = NULL;
@@ -978,6 +981,10 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 		}
 	}
 
+	if (hid->driver->input_register &&
+			hid->driver->input_register(hid, hidinput))
+		goto out_cleanup;
+
 	if (hidinput && input_register_device(hidinput->input))
 		goto out_cleanup;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 42f7e2f..50c0159 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -597,6 +597,8 @@ struct hid_usage_id {
  * @input_mapping: invoked on input registering before mapping an usage
  * @input_mapped: invoked on input registering after mapping an usage
  * @feature_mapping: invoked on feature registering
+ * @input_register: called just before input device is registered after reports
+ * 		    are parsed.
  * @suspend: invoked on suspend (NULL means nop)
  * @resume: invoked on resume if device was not reset (NULL means nop)
  * @reset_resume: invoked on resume if device was reset (NULL means nop)
@@ -643,6 +645,8 @@ struct hid_driver {
 	void (*feature_mapping)(struct hid_device *hdev,
 			struct hid_field *field,
 			struct hid_usage *usage);
+	int (*input_register)(struct hid_device *hdev, struct hid_input
+			*hidinput);
 #ifdef CONFIG_PM
 	int (*suspend)(struct hid_device *hdev, pm_message_t message);
 	int (*resume)(struct hid_device *hdev);
-- 
1.7.3.1

