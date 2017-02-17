From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 4/3] Input: ps2smbus - force PS/2 disable before SMBus gets resumed
Date: Fri, 17 Feb 2017 12:46:33 +0100
Message-ID: <20170217114633.14749-1-benjamin.tissoires@redhat.com>
References: <20170216175100.1668-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933799AbdBQLqj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Feb 2017 06:46:39 -0500
In-Reply-To: <20170216175100.1668-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On some cases, the touchpad can be reset during resume. We need to
send the PS/2 command PSMOUSE_CMD_DISABLE before attempting to contact
the touchpad over SMBus. Given that the .connect() callback is called
in a separate thread in kseriod, we need to wait for it in the main
thread before leaving the resume of the platform device.

>From what I can see, the I2C client is then blocked until the platform
device gets resumed, even if the I2C client is not a child of the platform
device.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Dmitry,

this morning the touchpad was dead after the resume. So we need to
actually be sure the PS/2 state is disabled before attempting to
use the SMBus connection.

I am not 100% sure the I2C client will be waiting for the platform
device to be resumed given that I can't find a way to mark the I2C
as a child of the other one. However, it seems that the ordering
is correct nevertheless.

Cheers,
Benjamin


new in v2

 drivers/input/misc/ps2_smbus.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/input/misc/ps2_smbus.c b/drivers/input/misc/ps2_smbus.c
index b58c113..0b03224 100644
--- a/drivers/input/misc/ps2_smbus.c
+++ b/drivers/input/misc/ps2_smbus.c
@@ -49,6 +49,7 @@ struct ps2smbus_work {
 
 struct ps2smbus_serio {
 	struct ps2dev ps2dev;
+	bool suspended;
 };
 
 static struct serio_device_id ps2smbus_serio_ids[] = {
@@ -121,8 +122,26 @@ static int ps2smbus_connect(struct serio *serio, struct serio_driver *drv)
 	return error;
 }
 
+static void ps2smbus_cleanup(struct serio *serio)
+{
+	struct ps2smbus_serio *ps2smbus = serio_get_drvdata(serio);
+
+	ps2smbus->suspended = true;
+}
+
 static int ps2smbus_reconnect(struct serio *serio)
 {
+	struct ps2smbus_serio *ps2smbus = serio_get_drvdata(serio);
+	int error;
+
+	error = ps2_command(&ps2smbus->ps2dev, NULL, PSMOUSE_CMD_DISABLE);
+	if (error)
+		dev_warn(&serio->dev, "Failed to deactivate PS/2 mouse on %s\n",
+			 serio->phys);
+
+	ps2smbus->suspended = false;
+	wake_up_interruptible(&ps2smbus_serio_wait);
+
 	return 0;
 }
 
@@ -144,6 +163,7 @@ static struct serio_driver ps2smbus_serio_drv = {
 	.id_table	= ps2smbus_serio_ids,
 	.interrupt	= ps2smbus_interrupt,
 	.connect	= ps2smbus_connect,
+	.cleanup	= ps2smbus_cleanup,
 	.reconnect	= ps2smbus_reconnect,
 	.disconnect	= ps2smbus_disconnect,
 	.manual_bind	= true,
@@ -328,6 +348,27 @@ static int ps2smbus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused ps2smbus_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ps2smbus *ps2smbus = platform_get_drvdata(pdev);
+	struct serio *serio = ps2smbus->serio;
+	struct ps2smbus_serio *ps2smbus_serio = serio_get_drvdata(serio);
+	int error;
+
+	error = wait_event_interruptible_timeout(ps2smbus_serio_wait,
+				ps2smbus_serio->suspended == false,
+				msecs_to_jiffies(1000));
+	if (error <= 10)
+		dev_warn(&serio->dev,
+			 "error while waiting for the PS/2 node to be ready: %d\n",
+			 error);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ps2smbus_pm_ops, NULL, ps2smbus_resume);
+
 static const struct platform_device_id ps2smbus_id_table[] = {
 	{ .name = "rmi4", .driver_data = PS2SMBUS_SYNAPTICS_RMI4 },
 	{ }
@@ -337,6 +378,7 @@ MODULE_DEVICE_TABLE(platform, ps2smbus_id_table);
 static struct platform_driver ps2smbus_drv = {
 	.driver		= {
 		.name	= "ps2smbus",
+		.pm	= &ps2smbus_pm_ops,
 	},
 	.probe		= ps2smbus_probe,
 	.remove		= ps2smbus_remove,
-- 
2.9.3

