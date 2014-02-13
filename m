From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 03/11] Input: synaptics-rmi4 - do not update configuration in rmi_f01_probe()
Date: Wed, 12 Feb 2014 21:27:49 -0800
Message-ID: <1392269277-16391-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Do not write configuration data in probe(), we have config() for that.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f01.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 897d8ac..976aba3 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -303,12 +303,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 		if (pdata->power_management.doze_interval) {
 			data->device_control.doze_interval =
 				pdata->power_management.doze_interval;
-			error = rmi_write(rmi_dev, data->doze_interval_addr,
-					data->device_control.doze_interval);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 doze interval register.\n");
-				return error;
-			}
 		} else {
 			error = rmi_read(rmi_dev, data->doze_interval_addr,
 					&data->device_control.doze_interval);
@@ -324,12 +318,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 		if (pdata->power_management.wakeup_threshold) {
 			data->device_control.wakeup_threshold =
 				pdata->power_management.wakeup_threshold;
-			error = rmi_write(rmi_dev, data->wakeup_threshold_addr,
-					data->device_control.wakeup_threshold);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 wakeup threshold register.\n");
-				return error;
-			}
 		} else {
 			error = rmi_read(rmi_dev, data->wakeup_threshold_addr,
 					&data->device_control.wakeup_threshold);
@@ -347,12 +335,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 		if (pdata->power_management.doze_holdoff) {
 			data->device_control.doze_holdoff =
 				pdata->power_management.doze_holdoff;
-			error = rmi_write(rmi_dev, data->doze_holdoff_addr,
-					data->device_control.doze_holdoff);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 doze holdoff register.\n");
-				return error;
-			}
 		} else {
 			error = rmi_read(rmi_dev, data->doze_holdoff_addr,
 					&data->device_control.doze_holdoff);
-- 
1.8.5.3
