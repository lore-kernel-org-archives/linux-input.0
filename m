From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 26/26] Input: synaptics-rmi4: Change the rmi device's name to be less generic
Date: Thu, 5 Nov 2015 15:43:20 -0800
Message-ID: <1446767000-31398-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

Currently, the rmi device has the name sensorXX. Sensor is very generic
and in cases when there is little context it is hard to tell what the
device is (ie in /sys/devices or /proc/interrupts). This patch changes
the name to rmiXX which at least indicates that it is an rmi device.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
Linus Walleij suggested that we use the TM number as the device name.
But, we need to set the device name when we add the device before we
read the TM number. Changing the name to rmiXX is a compromise since
it's not as unique as the TM, but not as generic as sensor.

 drivers/input/rmi4/rmi_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index a04468d..998b4e1 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -66,7 +66,7 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 	rmi_dev->xport = xport;
 	rmi_dev->number = atomic_inc_return(&transport_device_count) - 1;
 
-	dev_set_name(&rmi_dev->dev, "sensor%02d", rmi_dev->number);
+	dev_set_name(&rmi_dev->dev, "rmi%02d", rmi_dev->number);
 
 	rmi_dev->dev.bus = &rmi_bus_type;
 	rmi_dev->dev.type = &rmi_device_type;
-- 
2.1.4
