From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] IIO: call sensor hub open close function
Date: Tue, 10 Sep 2013 13:03:51 -0700
Message-ID: <1378843432-5113-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1378843432-5113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61911 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab3IJUEG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Sep 2013 16:04:06 -0400
In-Reply-To: <1378843432-5113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jc23@cam.ac.uk, jkosina@suse.cz, holler@ahsoftware.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Call hid_sensor_hub_device_open when user space opens device and call
hid_sensor_hub_device_close when device is closed. This helps in
saving power.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 87419c4..b6e77e0 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -34,6 +34,12 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
 	int state_val;
 
+	if (state) {
+		if (sensor_hub_device_open(st->hsdev))
+			return -EIO;
+	} else
+		sensor_hub_device_close(st->hsdev);
+
 	state_val = state ? 1 : 0;
 	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
 		++state_val;
-- 
1.8.3.1

