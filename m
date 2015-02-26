From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: hid-sensor-hub: fix attribute read for logical usage id
Date: Wed, 25 Feb 2015 18:56:27 -0800
Message-ID: <1424919387-19136-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33822 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbbBZC5x (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 21:57:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

For defining enumeration values like report or power status events,
the enumeration usage ids are enclosed in a logical collection.
In this case we need to match logical usage id for pending read
on this usage id. For example, in the below field, when
read is requested for 0319, the report will contain one of the
status usages like 850, 851 etc. In this case the raw event will
not match 0319. So when logical collection matches, then
wake up the pending thread.

      Physical(Sensor.OtherCustom)
      Logical(Sensor.0319)
      Application(Sensor.Sensor)
      Usage(6)
        Sensor.0850
        Sensor.0851
        Sensor.0852
        Sensor.0853
        Sensor.0854
        Sensor.0855
      Logical Minimum(1)
      Logical Maximum(5)
      Report Size(8)
      Report Count(1)
      Report Offset(24)
      Flags( Array Absolute )

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 36d4cb4..5eb338d 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -497,8 +497,10 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 			ptr += sz;
 			continue;
 		}
-		if (hsdev->pending.status && hsdev->pending.attr_usage_id ==
-				report->field[i]->usage->hid) {
+		if (hsdev->pending.status && (hsdev->pending.attr_usage_id ==
+					      report->field[i]->usage->hid ||
+					      hsdev->pending.attr_usage_id ==
+					      report->field[i]->logical)) {
 			hid_dbg(hdev, "data was pending ...\n");
 			hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
 			if (hsdev->pending.raw_data)
-- 
1.9.1

