From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [RESEND PATCH v3 1/6] mfd: cros_ec: Add MKBP event support
Date: Wed,  2 Mar 2016 09:23:27 +0100
Message-ID: <1456907012-19268-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1456907012-19268-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34542 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbcCBIY0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 03:24:26 -0500
In-Reply-To: <1456907012-19268-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: Vic Yang <victoryang@google.com>

Newer revisions of the ChromeOS EC add more events besides the keyboard
ones. So handle interrupts in the MFD driver and let consumers register
for notifications for the events they might care.

To keep backward compatibility, if the EC doesn't support MKBP event, we
fall back to the old MKBP key matrix host command.

Signed-off-by: Vic Yang <victoryang@chromium.org>
[bleung: fixup some context changes going from v3.14 to v3.18]
Signed-off-by: Benson Leung <bleung@chromium.org>
[tomeu: adapted to changes in mainline (in power-supply and platform/chrome)]
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Randall Spangler <rspangler@chromium.org>
Cc: Vincent Palatin <vpalatin@chromium.org>
---

Changes in v3:
- Remove duplicated prototype of cros_ec_get_host_event.

Changes in v2:
- Allocate enough for the structs in cros_ec_get_host_command_version_mask,
  not their pointers.
- Allocate msg in the stack in get_next_event and
  get_keyboard_state_event, as suggested by Gwendal.

 drivers/input/keyboard/cros_ec_keyb.c   | 135 ++++++++------------------------
 drivers/mfd/cros_ec.c                   |  57 +++++++++++++-
 drivers/platform/chrome/cros_ec_proto.c |  92 ++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |  34 ++++++++
 include/linux/mfd/cros_ec_commands.h    |  34 ++++++++
 5 files changed, 245 insertions(+), 107 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index b01966dc7eb3..b891503143dc 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -27,6 +27,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/input/matrix_keypad.h>
@@ -44,6 +45,7 @@
  * @dev: Device pointer
  * @idev: Input device
  * @ec: Top level ChromeOS device to use to talk to EC
+ * @notifier: interrupt event notifier for transport devices
  */
 struct cros_ec_keyb {
 	unsigned int rows;
@@ -57,6 +59,7 @@ struct cros_ec_keyb {
 	struct device *dev;
 	struct input_dev *idev;
 	struct cros_ec_device *ec;
+	struct notifier_block notifier;
 };
 
 
@@ -146,67 +149,44 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 	input_sync(ckdev->idev);
 }
 
-static int cros_ec_keyb_get_state(struct cros_ec_keyb *ckdev, uint8_t *kb_state)
-{
-	int ret = 0;
-	struct cros_ec_command *msg;
-
-	msg = kmalloc(sizeof(*msg) + ckdev->cols, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = 0;
-	msg->command = EC_CMD_MKBP_STATE;
-	msg->insize = ckdev->cols;
-	msg->outsize = 0;
-
-	ret = cros_ec_cmd_xfer(ckdev->ec, msg);
-	if (ret < 0) {
-		dev_err(ckdev->dev, "Error transferring EC message %d\n", ret);
-		goto exit;
-	}
-
-	memcpy(kb_state, msg->data, ckdev->cols);
-exit:
-	kfree(msg);
-	return ret;
-}
-
-static irqreturn_t cros_ec_keyb_irq(int irq, void *data)
+static int cros_ec_keyb_open(struct input_dev *dev)
 {
-	struct cros_ec_keyb *ckdev = data;
-	struct cros_ec_device *ec = ckdev->ec;
-	int ret;
-	uint8_t kb_state[ckdev->cols];
-
-	if (device_may_wakeup(ec->dev))
-		pm_wakeup_event(ec->dev, 0);
-
-	ret = cros_ec_keyb_get_state(ckdev, kb_state);
-	if (ret >= 0)
-		cros_ec_keyb_process(ckdev, kb_state, ret);
-	else
-		dev_err(ec->dev, "failed to get keyboard state: %d\n", ret);
+	struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
 
-	return IRQ_HANDLED;
+	return blocking_notifier_chain_register(&ckdev->ec->event_notifier,
+						&ckdev->notifier);
 }
 
-static int cros_ec_keyb_open(struct input_dev *dev)
+static void cros_ec_keyb_close(struct input_dev *dev)
 {
 	struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
-	struct cros_ec_device *ec = ckdev->ec;
 
-	return request_threaded_irq(ec->irq, NULL, cros_ec_keyb_irq,
-					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					"cros_ec_keyb", ckdev);
+	blocking_notifier_chain_unregister(&ckdev->ec->event_notifier,
+					   &ckdev->notifier);
 }
 
-static void cros_ec_keyb_close(struct input_dev *dev)
+static int cros_ec_keyb_work(struct notifier_block *nb,
+			     unsigned long queued_during_suspend, void *_notify)
 {
-	struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
-	struct cros_ec_device *ec = ckdev->ec;
+	struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
+						  notifier);
 
-	free_irq(ec->irq, ckdev);
+	if (ckdev->ec->event_data.event_type != EC_MKBP_EVENT_KEY_MATRIX)
+		return NOTIFY_DONE;
+	/*
+	 * If EC is not the wake source, discard key state changes during
+	 * suspend.
+	 */
+	if (queued_during_suspend)
+		return NOTIFY_OK;
+	if (ckdev->ec->event_size != ckdev->cols) {
+		dev_err(ckdev->dev,
+			"Discarded incomplete key matrix event.\n");
+		return NOTIFY_OK;
+	}
+	cros_ec_keyb_process(ckdev, ckdev->ec->event_data.data.key_matrix,
+			     ckdev->ec->event_size);
+	return NOTIFY_OK;
 }
 
 /*
@@ -266,12 +246,8 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	if (!idev)
 		return -ENOMEM;
 
-	if (!ec->irq) {
-		dev_err(dev, "no EC IRQ specified\n");
-		return -EINVAL;
-	}
-
 	ckdev->ec = ec;
+	ckdev->notifier.notifier_call = cros_ec_keyb_work;
 	ckdev->dev = dev;
 	dev_set_drvdata(&pdev->dev, ckdev);
 
@@ -312,54 +288,6 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-/* Clear any keys in the buffer */
-static void cros_ec_keyb_clear_keyboard(struct cros_ec_keyb *ckdev)
-{
-	uint8_t old_state[ckdev->cols];
-	uint8_t new_state[ckdev->cols];
-	unsigned long duration;
-	int i, ret;
-
-	/*
-	 * Keep reading until we see that the scan state does not change.
-	 * That indicates that we are done.
-	 *
-	 * Assume that the EC keyscan buffer is at most 32 deep.
-	 */
-	duration = jiffies;
-	ret = cros_ec_keyb_get_state(ckdev, new_state);
-	for (i = 1; !ret && i < 32; i++) {
-		memcpy(old_state, new_state, sizeof(old_state));
-		ret = cros_ec_keyb_get_state(ckdev, new_state);
-		if (0 == memcmp(old_state, new_state, sizeof(old_state)))
-			break;
-	}
-	duration = jiffies - duration;
-	dev_info(ckdev->dev, "Discarded %d keyscan(s) in %dus\n", i,
-		jiffies_to_usecs(duration));
-}
-
-static int cros_ec_keyb_resume(struct device *dev)
-{
-	struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
-
-	/*
-	 * When the EC is not a wake source, then it could not have caused the
-	 * resume, so we clear the EC's key scan buffer. If the EC was a
-	 * wake source (e.g. the lid is open and the user might press a key to
-	 * wake) then the key scan buffer should be preserved.
-	 */
-	if (!ckdev->ec->was_wake_device)
-		cros_ec_keyb_clear_keyboard(ckdev);
-
-	return 0;
-}
-
-#endif
-
-static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
-
 #ifdef CONFIG_OF
 static const struct of_device_id cros_ec_keyb_of_match[] = {
 	{ .compatible = "google,cros-ec-keyb" },
@@ -373,7 +301,6 @@ static struct platform_driver cros_ec_keyb_driver = {
 	.driver = {
 		.name = "cros-ec-keyb",
 		.of_match_table = of_match_ptr(cros_ec_keyb_of_match),
-		.pm	= &cros_ec_keyb_pm_ops,
 	},
 };
 
diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 0eee63542038..fbe78b819fdd 100644
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
+			dev_err(dev, "request irq %d: error %d\n",
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
 
@@ -136,13 +170,30 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
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
+	 * In some case, we need to distinguish events that occur during
+	 * suspend if the EC is not a wake source. For example, keypresses
+	 * during suspend should be discarded if it does not wake the system.
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
index 990308ca384f..00beacbf7645 100644
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
+	msg->insize = sizeof(rver);
+	msg->outsize = sizeof(pver);
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
@@ -380,3 +423,52 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 	return ret;
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
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
index 494682ce4bf3..1f88418a36cf 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -72,6 +72,24 @@ struct cros_ec_command {
 	uint8_t data[0];
 };
 
+/*
+ * event_data is used by keyboard or event notifier:
+ * event_data format:
+ * If MKBP protocol is supported:
+ * 0           1
+ * +-----------+--------------------------------
+ * | type      | payload
+ * +-----------+--------------------------------
+ * |HOST_EVENT | EVENT (32 bit)
+ * |KEY_MATRIX | Keyboard keys pressed.
+ * |SENSOR_FIFO| Sensors FIFO information.
+ *
+ * Otherwise:
+ * 0           1
+ * +-----------+--------------------------------
+ * |Unused     | Keyboard keys pressed.
+ */
+
 /**
  * struct cros_ec_device - Information about a ChromeOS EC device
  *
@@ -107,6 +125,9 @@ struct cros_ec_command {
  *     should check msg.result for the EC's result code.
  * @pkt_xfer: send packet to EC and get response
  * @lock: one transaction at a time
+ * @event_notifier: interrupt event notifier for transport devices.
+ * @event_data: raw payload transferred with the MKBP event.
+ * @event_size: size in bytes of the event data.
  */
 struct cros_ec_device {
 
@@ -135,6 +156,11 @@ struct cros_ec_device {
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
@@ -252,6 +278,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev);
  */
 int cros_ec_query_all(struct cros_ec_device *ec_dev);
 
+/**
+ * cros_ec_get_next_event -  Fetch next event from the ChromeOS EC
+ *
+ * @ec_dev: Device to fetch event from
+ * @return 0 if ok, -ve on error
+ */
+int cros_ec_get_next_event(struct cros_ec_device *ec_dev);
+
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
 extern struct attribute_group cros_ec_lightbar_attr_group;
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 13b630c10d4c..d86526f0bd8e 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1762,6 +1762,40 @@ struct ec_result_keyscan_seq_ctrl {
 	};
 } __packed;
 
+/*
+ * Get the next pending MKBP event.
+ *
+ * Returns EC_RES_UNAVAILABLE if there is no event pending.
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
2.5.0

