From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 06/11] Input: synaptics-rmi4 - remove device_status form f01_data
Date: Wed, 12 Feb 2014 21:27:52 -0800
Message-ID: <1392269277-16391-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

We do not need to persist it - we read it when signalled.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f01.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 6f90a6c..1e49ab4 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -126,8 +126,6 @@ struct f01_data {
 
 	struct f01_device_control device_control;
 
-	u8 device_status;
-
 	u16 interrupt_enable_addr;
 	u16 doze_interval_addr;
 	u16 wakeup_threshold_addr;
@@ -212,6 +210,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
 	struct f01_data *data = fn->data;
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
+	u8 device_status;
 
 	/*
 	 * Set the configured bit and (optionally) other important stuff
@@ -346,16 +345,16 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 	}
 
 	error = rmi_read_block(rmi_dev, fn->fd.data_base_addr,
-		&data->device_status, sizeof(data->device_status));
+		&device_status, sizeof(device_status));
 	if (error < 0) {
 		dev_err(&fn->dev, "Failed to read device status.\n");
 		return error;
 	}
 
-	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
+	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
 		dev_err(&fn->dev,
 			"Device was reset during configuration process, status: %#02x!\n",
-			RMI_F01_STATUS_CODE(data->device_status));
+			RMI_F01_STATUS_CODE(device_status));
 		return -EINVAL;
 	}
 
@@ -497,18 +496,18 @@ static int rmi_f01_attention(struct rmi_function *fn,
 			     unsigned long *irq_bits)
 {
 	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct f01_data *data = fn->data;
 	int retval;
+	u8 device_status;
 
 	retval = rmi_read_block(rmi_dev, fn->fd.data_base_addr,
-		&data->device_status, sizeof(data->device_status));
+		&device_status, sizeof(device_status));
 	if (retval < 0) {
 		dev_err(&fn->dev, "Failed to read device status, code: %d.\n",
 			retval);
 		return retval;
 	}
 
-	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
+	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
 		dev_warn(&fn->dev, "Device reset detected.\n");
 		retval = rmi_dev->driver->reset_handler(rmi_dev);
 		if (retval < 0)
-- 
1.8.5.3
