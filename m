From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] mfd: cros_ec: Add MKBP event support
Date: Fri,  1 Jul 2016 11:07:55 +0200
Message-ID: <1467364076-20172-2-git-send-email-enric.balletbo@collabora.com>
References: <1467364076-20172-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467364076-20172-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Vic Yang <victoryang@google.com>, Lee Jones <lee.jones@linaro.org>, Olof Johansson <olof@lixom.net>, Gwendal Grignou <gwendal@chromium.org>, Brian Norris <briannorris@chromium.org>, Randall Spangler <rspangler@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Benson Leung <bleung@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Vic Yang <victoryang@google.com>

Newer revisions of the ChromeOS EC add more events besides the keyboard
ones. So handle interrupts in the MFD driver and let consumers register
for notifications for the events they might care.

To keep backward compatibility, if the EC doesn't support MKBP event, we
fall back to the old MKBP key matrix host command.

Signed-off-by: Vic Yang <victoryang@google.com>
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Randall Spangler <rspangler@chromium.org>
Cc: Vincent Palatin <vpalatin@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
---
 drivers/mfd/cros_ec.c                   | 58 +++++++++++++++++++--
 drivers/platform/chrome/cros_ec_proto.c | 92 +++++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             | 18 +++++++
 include/linux/mfd/cros_ec_commands.h    | 34 ++++++++++++
 4 files changed, 199 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 0eee635..abd8342 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
+#include <asm/unaligned.h>
 
 #define CROS_EC_DEV_EC_INDEX 0
 #define CROS_EC_DEV_PD_INDEX 1
@@ -49,11 +50,28 @@ static const struct mfd_cell ec_pd_cell = {
 	.pdata_size = sizeof(pd_p),
 };
 
+static irqreturn_t ec_irq_thread(int irq, void *data)
+{
+	struct cros_ec_device *ec_dev = data;
+	int ret;
+
+	if (device_may_wakeup(ec_dev->dev))
+		pm_wakeup_event(ec_dev->dev, 0);
+
+	ret = cros_ec_get_next_event(ec_dev);
+	if (ret > 0)
+		blocking_notifier_call_chain(&ec_dev->event_notifier,
+					     0, ec_dev);
+	return IRQ_HANDLED;
+}
+
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
 	int err = 0;
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
+
 	ec_dev->max_request = sizeof(struct ec_params_hello);
 	ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
 	ec_dev->max_passthru = 0;
@@ -70,13 +88,24 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	cros_ec_query_all(ec_dev);
 
+	if (ec_dev->irq) {
+		err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   "chromeos-ec", ec_dev);
+		if (err) {
+			dev_err(dev, "Failed to request IRQ %d: %d",
+				ec_dev->irq, err);
+			return err;
+		}
+	}
+
 	err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell, 1,
 			      NULL, ec_dev->irq, NULL);
 	if (err) {
 		dev_err(dev,
 			"Failed to register Embedded Controller subdevice %d\n",
 			err);
-		return err;
+		goto fail_mfd;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -94,7 +123,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 			dev_err(dev,
 				"Failed to register Power Delivery subdevice %d\n",
 				err);
-			return err;
+			goto fail_mfd;
 		}
 	}
 
@@ -103,13 +132,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			mfd_remove_devices(dev);
 			dev_err(dev, "Failed to register sub-devices\n");
-			return err;
+			goto fail_mfd;
 		}
 	}
 
 	dev_info(dev, "Chrome EC device registered\n");
 
 	return 0;
+
+fail_mfd:
+	if (ec_dev->irq)
+		free_irq(ec_dev->irq, ec_dev);
+	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
 
@@ -136,13 +170,31 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 }
 EXPORT_SYMBOL(cros_ec_suspend);
 
+static void cros_ec_drain_events(struct cros_ec_device *ec_dev)
+{
+	while (cros_ec_get_next_event(ec_dev) > 0)
+		blocking_notifier_call_chain(&ec_dev->event_notifier,
+					     1, ec_dev);
+}
+
 int cros_ec_resume(struct cros_ec_device *ec_dev)
 {
 	enable_irq(ec_dev->irq);
 
+	/*
+	 * In some cases, we need to distinguish between events that occur
+	 * during suspend if the EC is not a wake source. For example,
+	 * keypresses during suspend should be discarded if it does not wake
+	 * the system.
+	 *
+	 * If the EC is not a wake source, drain the event queue and mark them
+	 * as "queued during suspend".
+	 */
 	if (ec_dev->wake_enabled) {
 		disable_irq_wake(ec_dev->irq);
 		ec_dev->wake_enabled = 0;
+	} else {
+		cros_ec_drain_events(ec_dev);
 	}
 
 	return 0;
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index ecc544c..222ba97 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <asm/unaligned.h>
 
 #define EC_COMMAND_RETRIES	50
 
@@ -234,11 +235,44 @@ static int cros_ec_host_command_proto_query_v2(struct cros_ec_device *ec_dev)
 	return ret;
 }
 
+static int cros_ec_get_host_command_version_mask(struct cros_ec_device *ec_dev,
+	u16 cmd, u32 *mask)
+{
+	struct ec_params_get_cmd_versions *pver;
+	struct ec_response_get_cmd_versions *rver;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kmalloc(sizeof(*msg) + max(sizeof(*rver), sizeof(*pver)),
+		      GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = 0;
+	msg->command = EC_CMD_GET_CMD_VERSIONS;
+	msg->insize = sizeof(*rver);
+	msg->outsize = sizeof(*pver);
+
+	pver = (struct ec_params_get_cmd_versions *)msg->data;
+	pver->cmd = cmd;
+
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
+	if (ret > 0) {
+		rver = (struct ec_response_get_cmd_versions *)msg->data;
+		*mask = rver->version_mask;
+	}
+
+	kfree(msg);
+
+	return ret;
+}
+
 int cros_ec_query_all(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
 	struct cros_ec_command *proto_msg;
 	struct ec_response_get_protocol_info *proto_info;
+	u32 ver_mask = 0;
 	int ret;
 
 	proto_msg = kzalloc(sizeof(*proto_msg) + sizeof(*proto_info),
@@ -328,6 +362,15 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		goto exit;
 	}
 
+	/* Probe if MKBP event is supported */
+	ret = cros_ec_get_host_command_version_mask(ec_dev,
+						    EC_CMD_GET_NEXT_EVENT,
+						    &ver_mask);
+	if (ret < 0 || ver_mask == 0)
+		ec_dev->mkbp_event_supported = 0;
+	else
+		ec_dev->mkbp_event_supported = 1;
+
 exit:
 	kfree(proto_msg);
 	return ret;
@@ -395,3 +438,52 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 	return ret;
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
+
+static int get_next_event(struct cros_ec_device *ec_dev)
+{
+	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
+	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
+	int ret;
+
+	msg->version = 0;
+	msg->command = EC_CMD_GET_NEXT_EVENT;
+	msg->insize = sizeof(ec_dev->event_data);
+	msg->outsize = 0;
+
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
+	if (ret > 0) {
+		ec_dev->event_size = ret - 1;
+		memcpy(&ec_dev->event_data, msg->data,
+		       sizeof(ec_dev->event_data));
+	}
+
+	return ret;
+}
+
+static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
+{
+	u8 buffer[sizeof(struct cros_ec_command) +
+		  sizeof(ec_dev->event_data.data)];
+	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
+
+	msg->version = 0;
+	msg->command = EC_CMD_MKBP_STATE;
+	msg->insize = sizeof(ec_dev->event_data.data);
+	msg->outsize = 0;
+
+	ec_dev->event_size = cros_ec_cmd_xfer(ec_dev, msg);
+	ec_dev->event_data.event_type = EC_MKBP_EVENT_KEY_MATRIX;
+	memcpy(&ec_dev->event_data.data, msg->data,
+	       sizeof(ec_dev->event_data.data));
+
+	return ec_dev->event_size;
+}
+
+int cros_ec_get_next_event(struct cros_ec_device *ec_dev)
+{
+	if (ec_dev->mkbp_event_supported)
+		return get_next_event(ec_dev);
+	else
+		return get_keyboard_state_event(ec_dev);
+}
+EXPORT_SYMBOL(cros_ec_get_next_event);
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 7671704..d6539c1 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -112,6 +112,10 @@ struct cros_ec_command {
  *     should check msg.result for the EC's result code.
  * @pkt_xfer: send packet to EC and get response
  * @lock: one transaction at a time
+ * @mkbp_event_supported: true if this EC supports the MKBP event protocol.
+ * @event_notifier: interrupt event notifier for transport devices.
+ * @event_data: raw payload transferred with the MKBP event.
+ * @event_size: size in bytes of the event data.
  */
 struct cros_ec_device {
 
@@ -140,6 +144,11 @@ struct cros_ec_device {
 	int (*pkt_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
 	struct mutex lock;
+	bool mkbp_event_supported;
+	struct blocking_notifier_head event_notifier;
+
+	struct ec_response_get_next_event event_data;
+	int event_size;
 };
 
 /* struct cros_ec_platform - ChromeOS EC platform information
@@ -272,6 +281,15 @@ int cros_ec_register(struct cros_ec_device *ec_dev);
  */
 int cros_ec_query_all(struct cros_ec_device *ec_dev);
 
+/**
+ * cros_ec_get_next_event -  Fetch next event from the ChromeOS EC
+ *
+ * @ec_dev: Device to fetch event from
+ *
+ * Returns: 0 on success, Linux error number on failure
+ */
+int cros_ec_get_next_event(struct cros_ec_device *ec_dev);
+
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
 extern struct attribute_group cros_ec_lightbar_attr_group;
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 7e7a8d4..76728ff 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1793,6 +1793,40 @@ struct ec_result_keyscan_seq_ctrl {
 	};
 } __packed;
 
+/*
+ * Command for retrieving the next pending MKBP event from the EC device
+ *
+ * The device replies with UNAVAILABLE if there aren't any pending events.
+ */
+#define EC_CMD_GET_NEXT_EVENT 0x67
+
+enum ec_mkbp_event {
+	/* Keyboard matrix changed. The event data is the new matrix state. */
+	EC_MKBP_EVENT_KEY_MATRIX = 0,
+
+	/* New host event. The event data is 4 bytes of host event flags. */
+	EC_MKBP_EVENT_HOST_EVENT = 1,
+
+	/* New Sensor FIFO data. The event data is fifo_info structure. */
+	EC_MKBP_EVENT_SENSOR_FIFO = 2,
+
+	/* Number of MKBP events */
+	EC_MKBP_EVENT_COUNT,
+};
+
+union ec_response_get_next_data {
+	uint8_t   key_matrix[13];
+
+	/* Unaligned */
+	uint32_t  host_event;
+} __packed;
+
+struct ec_response_get_next_event {
+	uint8_t event_type;
+	/* Followed by event data if any */
+	union ec_response_get_next_data data;
+} __packed;
+
 /*****************************************************************************/
 /* Temperature sensor commands */
 
-- 
2.1.0
