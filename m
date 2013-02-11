From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH 2/3] HID: sensor-hub: get rid of unused
 sensor_hub_grabbed_usages[] table
Date: Mon, 11 Feb 2013 15:53:31 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91E00EB72@ORSMSX108.amr.corp.intel.com>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com>
 <1360578679-7029-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21702 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569Ab3BKPxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 10:53:55 -0500
In-Reply-To: <1360578679-7029-2-git-send-email-mika.westerberg@linux.intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This was added to load sensor hub driver on USB plug in without explicit modprobe. 
But with last few changes to remove vendor and product id, we need to do modprobe this driver.
So removal is OK.

Thanks,
Srinivas


-----Original Message-----
From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com] 
Sent: Monday, February 11, 2013 2:31 AM
To: linux-kernel@vger.kernel.org
Cc: Jiri Kosina; Benjamin Tissoires; linux-input@vger.kernel.org; Pandruvada, Srinivas; Mika Westerberg
Subject: [PATCH 2/3] HID: sensor-hub: get rid of unused sensor_hub_grabbed_usages[] table

This table is not used anywhere in the driver so kill it.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c index c06e933..2643bce9 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -608,11 +608,6 @@ static const struct hid_device_id sensor_hub_devices[] = {  };  MODULE_DEVICE_TABLE(hid, sensor_hub_devices);
 
-static const struct hid_usage_id sensor_hub_grabbed_usages[] = {
-	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
-	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
-};
-
 static struct hid_driver sensor_hub_driver = {
 	.name = "hid-sensor-hub",
 	.id_table = sensor_hub_devices,
--
1.7.10.4

