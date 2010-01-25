From: Michael Poole <mdpoole@troilus.org>
Subject: [RFC PATCH 1/3] Export hid_register_report().
Date: Mon, 25 Jan 2010 00:04:35 -0500
Message-ID: <411caeb60f5b808d0524636a03fc99e6216e67c6.1264395708.git.mdpoole@troilus.org>
References: <1264395877-2582-1-git-send-email-mdpoole@troilus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39142 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750893Ab0AYFEs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2010 00:04:48 -0500
Received: by qw-out-2122.google.com with SMTP id 3so53988qwe.33
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2010 21:04:48 -0800 (PST)
In-Reply-To: <1264395877-2582-1-git-send-email-mdpoole@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Poole <mdpoole@troilus.org>

The Apple Magic Mouse (and probably other devices) publish reports that
are not called out in their HID report descriptors -- they only send them
when enabled through other writes to the device.  This allows a driver to
handle these unlisted reports.

Signed-off-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-core.c |    3 ++-
 include/linux/hid.h    |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index eabe5f8..e39055b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL_GPL(hid_debug);
  * Register a new report for a device.
  */
 
-static struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id)
+struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id)
 {
 	struct hid_report_enum *report_enum = device->report_enum + type;
 	struct hid_report *report;
@@ -75,6 +75,7 @@ static struct hid_report *hid_register_report(struct hid_device *device, unsigne
 
 	return report;
 }
+EXPORT_SYMBOL_GPL(hid_register_report);
 
 /*
  * Register a new field for this report.
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8709365..c411983 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -690,6 +690,7 @@ int hid_input_report(struct hid_device *, int type, u8 *, int, int);
 int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
 void hid_output_report(struct hid_report *report, __u8 *data);
 struct hid_device *hid_allocate_device(void);
+struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id);
 int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
-- 
1.6.5.6

