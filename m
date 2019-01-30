From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: intel-ish-hid: Use VID/PID from ISH
Date: Wed, 30 Jan 2019 13:32:17 -0800
Message-ID: <20190130213217.8060-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

The Intel ISH HID can now have other devices attached to it, not just
sensors. Hence ISH HID transport is no longer just used for sensors.
Currently the vendor and product id is hardcoded for sensors, but they
can be obtained from ISH firmware for the real device. The driver already
extract them and store as part of device_info structure in client_data.
So use vendor id/product id obtained from the ISH firmware.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index e918d78e541c..bc4c536f3c0d 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -206,8 +206,8 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 	hid->bus = BUS_INTEL_ISHTP;
 	hid->dev.parent = &client_data->cl_device->dev;
 	hid->version = le16_to_cpu(ISH_HID_VERSION);
-	hid->vendor = le16_to_cpu(ISH_HID_VENDOR);
-	hid->product = le16_to_cpu(ISH_HID_PRODUCT);
+	hid->vendor = le16_to_cpu(client_data->hid_devices[cur_hid_dev].vid);
+	hid->product = le16_to_cpu(client_data->hid_devices[cur_hid_dev].pid);
 	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "hid-ishtp",
 		hid->vendor, hid->product);
 
-- 
2.17.2
