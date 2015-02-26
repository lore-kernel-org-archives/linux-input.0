From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: hid-sensor-hub: Fix sparse warning
Date: Thu, 26 Feb 2015 11:04:44 -0800
Message-ID: <1424977484-31296-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43225 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368AbbBZTHj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 14:07:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, fengguang.wu@intel.com
Cc: kbuild-all@01.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Address issue reported by kbuild test robot <fengguang.wu@intel.com>

sparse warnings: (new ones prefixed by >>)

>> drivers/hid/hid-sensor-hub.c:223:39: sparse: incorrect type in argument 3 (different base types)
   drivers/hid/hid-sensor-hub.c:223:39:    expected signed int [signed] [usertype] [explicitly-signed] <noident>
   drivers/hid/hid-sensor-hub.c:223:39:    got restricted __le32 [usertype] <noident>
>> drivers/hid/hid-sensor-hub.c:231:31: sparse: incorrect type in argument 3 (different base types)
   drivers/hid/hid-sensor-hub.c:231:31:    expected signed int [signed] [usertype] [explicitly-signed] <noident>
   drivers/hid/hid-sensor-hub.c:231:31:    got restricted __le32 [usertype] <noident>

vim +223 drivers/hid/hid-sensor-hub.c

   217          }
   218
   219          remaining_bytes = do_div(buffer_size, sizeof(__s32));
   220          if (buffer_size) {
   221                  for (i = 0; i < buffer_size; ++i) {
   222                          hid_set_field(report->field[field_index], i,
 > 223                                        cpu_to_le32(*buf32));
   224                          ++buf32;
   225                  }
   226          }
   227          if (remaining_bytes) {
   228                  value = 0;
   229                  memcpy(&value, (u8 *)buf32, remaining_bytes);
   230                  hid_set_field(report->field[field_index], i,
 > 231                                cpu_to_le32(value));
   232          }
   233          hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
   234          hid_hw_wait(hsdev->hdev);

Since I can't change the type of hid_set_field argument 3, using __force __s32 to remove
this warning.

---

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 5eb338d..75f7ca1 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -222,7 +222,7 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	if (buffer_size) {
 		for (i = 0; i < buffer_size; ++i) {
 			hid_set_field(report->field[field_index], i,
-				      cpu_to_le32(*buf32));
+				      (__force __s32)cpu_to_le32(*buf32));
 			++buf32;
 		}
 	}
@@ -230,7 +230,7 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 		value = 0;
 		memcpy(&value, (u8 *)buf32, remaining_bytes);
 		hid_set_field(report->field[field_index], i,
-			      cpu_to_le32(value));
+			      (__force __s32)cpu_to_le32(value));
 	}
 	hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
 	hid_hw_wait(hsdev->hdev);
-- 
1.9.1

