From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 12/14] HID: sensor-hub: validate feature report details
Date: Wed, 28 Aug 2013 22:31:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308282222190.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58000 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab3H1Ubt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 16:31:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, srinivas pandruvada <srinivas.pandruvada@intel.com>

From: Kees Cook <keescook@chromium.org>

A HID device could send a malicious feature report that would cause the
sensor-hub HID driver to read past the end of heap allocation, leaking
kernel memory contents to the caller.

CVE-2013-2898

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@kernel.org
---
 drivers/hid/hid-sensor-hub.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index ca749810..aa34755 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -221,7 +221,8 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
-	if (!report || (field_index >=  report->maxfield)) {
+	if (!report || (field_index >=  report->maxfield) ||
+	    report->field[field_index]->report_count < 1) {
 		ret = -EINVAL;
 		goto done_proc;
 	}
-- 
Jiri Kosina
SUSE Labs
