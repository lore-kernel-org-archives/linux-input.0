From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/9] HID: intel-ish-hid: Store ishtp_cl_device instance in device
Date: Sun,  3 Mar 2019 08:46:50 -0800
Message-ID: <20190303164654.29400-6-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Store ishtp_cl_device pointer in device struct private data. In this
way we can get ishtp_cl_device * from device struct pointer.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 95a97534fcda..2ca65864192f 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -466,6 +466,7 @@ static struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
 	}
 
 	ishtp_device_ready = true;
+	dev_set_drvdata(&device->dev, device);
 
 	return device;
 }
-- 
2.17.2
