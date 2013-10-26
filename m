From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: hid-sensor-hub: fix report size
Date: Sat, 26 Oct 2013 10:04:09 -0700
Message-ID: <1382807049-28478-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64242 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147Ab3JZREh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Oct 2013 13:04:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Most of the hid sensor field size is reported in report_size field
in the report descriptor. For rotation fusion sensor the quaternion
data is 16 byte field, the report size was set to 4 and report
count field is set to 4. So the total size is 16 bytes. But the current
driver has a bug and not taking account for report count field. This
causes user space to see only 4 bytes of data sent via IIO interface. 
The number of bytes in a field needs to take account of report_count
field. Need to multiply report_size and report_count to get total
number of bytes.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 88fc5ae..a184e19 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -326,7 +326,8 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 				field->logical == attr_usage_id) {
 				sensor_hub_fill_attr_info(info, i, report->id,
 					field->unit, field->unit_exponent,
-					field->report_size);
+					field->report_size *
+							field->report_count);
 				ret = 0;
 			} else {
 				for (j = 0; j < field->maxusage; ++j) {
@@ -338,7 +339,8 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 							i, report->id,
 							field->unit,
 							field->unit_exponent,
-							field->report_size);
+							field->report_size *
+							field->report_count);
 						ret = 0;
 						break;
 					}
@@ -425,9 +427,10 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 		hid_dbg(hdev, "%d collection_index:%x hid:%x sz:%x\n",
 				i, report->field[i]->usage->collection_index,
 				report->field[i]->usage->hid,
-				report->field[i]->report_size/8);
-
-		sz = report->field[i]->report_size/8;
+				(report->field[i]->report_size *
+					report->field[i]->report_count)/8);
+		sz = (report->field[i]->report_size *
+					report->field[i]->report_count)/8;
 		if (pdata->pending.status && pdata->pending.attr_usage_id ==
 				report->field[i]->usage->hid) {
 			hid_dbg(hdev, "data was pending ...\n");
-- 
1.8.3.2

