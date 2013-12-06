From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] HID: hid-sensor-hub: Fix kernel warning and failure
Date: Thu,  5 Dec 2013 16:34:25 -0800
Message-ID: <1386290065-31813-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1386290065-31813-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46271 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753720Ab3LFAfs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Dec 2013 19:35:48 -0500
In-Reply-To: <1386290065-31813-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Fix kernel warning and failure to register sensor hub devices with MFD.
Now many devices has in-built sensor hubs. So by default this HID hub,
is properly parsed and register individual sensors as platform device
using MFD framework. But if a second sensor hub is attached via USB,
which has same sensors, it will result in kernel warning and failure
to register MFD cell as the platform device sysfs file name will be
same as created by in-built sensor hubs. This patch sets MFD cell id
to PLATFORM_DEVID_AUTO. In this way there will never
be duplicate sysfs file names.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index a184e19..8af2d90 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -573,6 +573,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 					goto err_free_names;
 			}
 			sd->hid_sensor_hub_client_devs[
+				sd->hid_sensor_client_cnt].id = PLATFORM_DEVID_AUTO;
+			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].name = name;
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].platform_data =
-- 
1.8.1.2

