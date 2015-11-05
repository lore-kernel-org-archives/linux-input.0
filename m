From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 06/26] Input: synaptics-rmi4 - add a reset callback
Date: Thu, 5 Nov 2015 15:38:18 -0800
Message-ID: <1446766698-30487-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

When a device is physically reset, the transport layer may need to reset
its state too and also do extra work to make the device accessible on the
bus.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_bus.h    | 1 +
 drivers/input/rmi4/rmi_driver.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index d4cfc85..41d6c3d 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -197,6 +197,7 @@ struct rmi_transport_ops {
 
 	int (*enable_device) (struct rmi_transport_dev *xport);
 	void (*disable_device) (struct rmi_transport_dev *xport);
+	int (*reset)(struct rmi_transport_dev *xport, u16 reset_addr);
 };
 
 /**
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 264bc62..81e7c55 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -611,6 +611,14 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 		const struct rmi_device_platform_data *pdata =
 				rmi_get_platform_data(rmi_dev);
 
+		if (rmi_dev->xport->ops->reset) {
+			if (rmi_dev->xport->ops->reset(rmi_dev->xport,
+						       cmd_addr))
+				return error;
+
+			return RMI_SCAN_DONE;
+		}
+
 		error = rmi_write_block(rmi_dev, cmd_addr, &cmd_buf, 1);
 		if (error) {
 			dev_err(&rmi_dev->dev,
-- 
2.1.4
