From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/7] HID: provide a helper for validating hid reports
Date: Wed,  4 Sep 2013 09:37:19 -0700
Message-ID: <1378312645-27736-2-git-send-email-keescook@chromium.org>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:40349 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964853Ab3IDQhp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 12:37:45 -0400
In-Reply-To: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Kees Cook <keescook@chromium.org>, stable@kernel.org

Many drivers need to validate the characteristics of their HID report
during initialization to avoid misusing the reports. This adds a common
helper to perform validation of the report exisitng, the field existing,
and the expected number of values within the field.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org

---
v2:
 - suggestions from Benjamin Tissoires:
  - check id too, just to be double-safe.
  - updated to check a specific field, moving the for loop to callers.
---
 drivers/hid/hid-core.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h    |    4 ++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 21e3b9d..dc23284 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -759,6 +759,64 @@ int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size)
 }
 EXPORT_SYMBOL_GPL(hid_parse_report);
 
+static const char * const hid_report_names[] = {
+	"HID_INPUT_REPORT",
+	"HID_OUTPUT_REPORT",
+	"HID_FEATURE_REPORT",
+};
+/**
+ * hid_validate_values - validate existing device report's value indexes
+ *
+ * @device: hid device
+ * @type: which report type to examine
+ * @id: which report ID to examine (0 for first)
+ * @field_index: which report field to examine
+ * @report_counts: expected number of values
+ *
+ * Validate the number of values in a given field of a given report, after
+ * parsing.
+ */
+struct hid_report *hid_validate_values(struct hid_device *hid,
+				       unsigned int type, unsigned int id,
+				       unsigned int field_index,
+				       unsigned int report_counts)
+{
+	struct hid_report *report;
+
+	if (type > HID_FEATURE_REPORT) {
+		hid_err(hid, "invalid HID report type %u\n", type);
+		return NULL;
+	}
+
+	if (id >= HID_MAX_IDS) {
+		hid_err(hid, "invalid HID report id %u\n", id);
+		return NULL;
+	}
+
+	/*
+	 * Explicitly not using hid_get_report() here since it depends on
+	 * ->numbered being checked, which may not always be the case when
+	 * drivers go to access report values.
+	 */
+	report = hid->report_enum[type].report_id_hash[id];
+	if (!report) {
+		hid_err(hid, "missing %s %u\n", hid_report_names[type], id);
+		return NULL;
+	}
+	if (report->maxfield <= field_index) {
+		hid_err(hid, "not enough fields in %s %u\n",
+			hid_report_names[type], id);
+		return NULL;
+	}
+	if (report->field[field_index]->report_count < report_counts) {
+		hid_err(hid, "not enough values in %s %u field %u\n",
+			hid_report_names[type], id, field_index);
+		return NULL;
+	}
+	return report;
+}
+EXPORT_SYMBOL_GPL(hid_validate_values);
+
 /**
  * hid_open_report - open a driver-specific device report
  *
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ff545cc..6e18550 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -749,6 +749,10 @@ void hid_output_report(struct hid_report *report, __u8 *data);
 struct hid_device *hid_allocate_device(void);
 struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id);
 int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
+struct hid_report *hid_validate_values(struct hid_device *hid,
+				       unsigned int type, unsigned int id,
+				       unsigned int field_index,
+				       unsigned int report_counts);
 int hid_open_report(struct hid_device *device);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
-- 
1.7.9.5

