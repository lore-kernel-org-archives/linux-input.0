From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] input: cros_ec_keyb: Add non-matrix buttons and switches
Date: Fri, 20 Jan 2017 11:14:15 +0100
Message-ID: <20170120101415.26028-2-enric.balletbo@collabora.com>
References: <20170120101415.26028-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120101415.26028-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

On some newer boards using mkbp we're hooking up non-matrix buttons and
switches to the EC but NOT to the main application processor.

Let's add kernel support to handle this.  Rather than creating a whole
new input driver, we'll continue to use cros_ec_keyb and just report the
new keys.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 447 ++++++++++++++++++++++++++++++----
 1 file changed, 402 insertions(+), 45 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 25943e9..ad74ebc 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -34,6 +34,8 @@
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
 
+#include <asm/unaligned.h>
+
 /*
  * @rows: Number of rows in the keypad
  * @cols: Number of columns in the keypad
@@ -43,8 +45,9 @@
  * @valid_keys: bitmap of existing keys for each matrix column
  * @old_kb_state: bitmap of keys pressed last scan
  * @dev: Device pointer
- * @idev: Input device
  * @ec: Top level ChromeOS device to use to talk to EC
+ * @idev: The input device for the matrix keys.
+ * @bs_idev: The input device for non-matrix buttons and switches (or NULL).
  * @notifier: interrupt event notifier for transport devices
  */
 struct cros_ec_keyb {
@@ -57,12 +60,59 @@ struct cros_ec_keyb {
 	uint8_t *old_kb_state;
 
 	struct device *dev;
-	struct input_dev *idev;
 	struct cros_ec_device *ec;
+
+	struct input_dev *idev;
+	struct input_dev *bs_idev;
 	struct notifier_block notifier;
 };
 
 
+/**
+ * cros_ec_bs_map - Struct mapping Linux keycodes to EC button/switch bitmap
+ * #defines
+ *
+ * @ev_type: The type of the input event to generate (e.g., EV_KEY).
+ * @code: A linux keycode
+ * @bit: A #define like EC_MKBP_POWER_BUTTON or EC_MKBP_LID_OPEN
+ * @inverted: If the #define and EV_SW have opposite meanings, this is true.
+ *            Only applicable to switches.
+ */
+struct cros_ec_bs_map {
+	unsigned int ev_type;
+	unsigned int code;
+	u8 bit;
+	bool inverted;
+};
+
+/* cros_ec_keyb_bs - Map EC button/switch #defines into kernel ones */
+static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
+	/* Buttons */
+	{
+		.ev_type	= EV_KEY,
+		.code		= KEY_POWER,
+		.bit		= EC_MKBP_POWER_BUTTON,
+	},
+	{
+		.ev_type	= EV_KEY,
+		.code		= KEY_VOLUMEUP,
+		.bit		= EC_MKBP_VOL_UP,
+	},
+	{
+		.ev_type	= EV_KEY,
+		.code		= KEY_VOLUMEDOWN,
+		.bit		= EC_MKBP_VOL_DOWN,
+	},
+
+	/* Switches */
+	{
+		.ev_type	= EV_SW,
+		.code		= SW_LID,
+		.bit		= EC_MKBP_LID_OPEN,
+		.inverted	= true,
+	},
+};
+
 /*
  * Returns true when there is at least one combination of pressed keys that
  * results in ghosting.
@@ -149,20 +199,33 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 	input_sync(ckdev->idev);
 }
 
-static int cros_ec_keyb_open(struct input_dev *dev)
+/**
+ * cros_ec_keyb_report_bs - Report non-matrixed buttons or switches
+ *
+ * This takes a bitmap of buttons or switches from the EC and reports events,
+ * syncing at the end.
+ *
+ * @ckdev: The keyboard device.
+ * @ev_type: The input event type (e.g., EV_KEY).
+ * @mask: A bitmap of buttons from the EC.
+ */
+static void cros_ec_keyb_report_bs(struct cros_ec_keyb *ckdev,
+				   unsigned int ev_type, u32 mask)
+
 {
-	struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
+	struct input_dev *idev = ckdev->bs_idev;
+	int i;
 
-	return blocking_notifier_chain_register(&ckdev->ec->event_notifier,
-						&ckdev->notifier);
-}
+	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
+		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
 
-static void cros_ec_keyb_close(struct input_dev *dev)
-{
-	struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
+		if (map->ev_type != ev_type)
+			continue;
 
-	blocking_notifier_chain_unregister(&ckdev->ec->event_notifier,
-					   &ckdev->notifier);
+		input_event(idev, ev_type, map->code,
+			    !!(mask & BIT(map->bit)) ^ map->inverted);
+	}
+	input_sync(idev);
 }
 
 static int cros_ec_keyb_work(struct notifier_block *nb,
@@ -170,22 +233,54 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
 {
 	struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
 						  notifier);
+	u32 val;
+	unsigned int ev_type;
+
+	switch (ckdev->ec->event_data.event_type) {
+	case EC_MKBP_EVENT_KEY_MATRIX:
+		/*
+		 * If EC is not the wake source, discard key state changes
+		 * during suspend.
+		 */
+		if (queued_during_suspend)
+			return NOTIFY_OK;
+
+		if (ckdev->ec->event_size != ckdev->cols) {
+			dev_err(ckdev->dev,
+				"Discarded incomplete key matrix event.\n");
+			return NOTIFY_OK;
+		}
+		cros_ec_keyb_process(ckdev,
+				     ckdev->ec->event_data.data.key_matrix,
+				     ckdev->ec->event_size);
+		break;
+
+	case EC_MKBP_EVENT_BUTTON:
+	case EC_MKBP_EVENT_SWITCH:
+		/*
+		 * If EC is not the wake source, discard key state
+		 * changes during suspend. Switches will be re-checked in
+		 * cros_ec_keyb_resume() to be sure nothing is lost.
+		 */
+		if (queued_during_suspend)
+			return NOTIFY_OK;
+
+		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
+			val = get_unaligned_le32(
+					&ckdev->ec->event_data.data.buttons);
+			ev_type = EV_KEY;
+		} else {
+			val = get_unaligned_le32(
+					&ckdev->ec->event_data.data.switches);
+			ev_type = EV_SW;
+		}
+		cros_ec_keyb_report_bs(ckdev, ev_type, val);
+		break;
 
-	if (ckdev->ec->event_data.event_type != EC_MKBP_EVENT_KEY_MATRIX)
+	default:
 		return NOTIFY_DONE;
-	/*
-	 * If EC is not the wake source, discard key state changes during
-	 * suspend.
-	 */
-	if (queued_during_suspend)
-		return NOTIFY_OK;
-	if (ckdev->ec->event_size != ckdev->cols) {
-		dev_err(ckdev->dev,
-			"Discarded incomplete key matrix event.\n");
-		return NOTIFY_OK;
 	}
-	cros_ec_keyb_process(ckdev, ckdev->ec->event_data.data.key_matrix,
-			     ckdev->ec->event_size);
+
 	return NOTIFY_OK;
 }
 
@@ -213,22 +308,228 @@ static void cros_ec_keyb_compute_valid_keys(struct cros_ec_keyb *ckdev)
 	}
 }
 
-static int cros_ec_keyb_probe(struct platform_device *pdev)
+/**
+ * cros_ec_keyb_info - Wrap the EC command EC_CMD_MKBP_INFO
+ *
+ * This wraps the EC_CMD_MKBP_INFO, abstracting out all of the marshalling and
+ * unmarshalling and different version nonsense into something simple.
+ *
+ * @ec_dev: The EC device
+ * @info_type: Either EC_MKBP_INFO_SUPPORTED or EC_MKBP_INFO_CURRENT.
+ * @event_type: Either EC_MKBP_EVENT_BUTTON or EC_MKBP_EVENT_SWITCH.  Actually
+ *              in some cases this could be EC_MKBP_EVENT_KEY_MATRIX or
+ *              EC_MKBP_EVENT_HOST_EVENT too but we don't use in this driver.
+ * @result: Where we'll store the result; a union
+ * @result_size: The size of the result.  Expected to be the size of one of
+ *               the elements in the union.
+ *
+ * Returns 0 if no error or -error upon error.
+ */
+static int cros_ec_keyb_info(struct cros_ec_device *ec_dev,
+			     enum ec_mkbp_info_type info_type,
+			     enum ec_mkbp_event event_type,
+			     union ec_response_get_next_data *result,
+			     size_t result_size)
 {
-	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
-	struct device *dev = &pdev->dev;
-	struct cros_ec_keyb *ckdev;
+	struct ec_params_mkbp_info *params;
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max_t(size_t, result_size,
+					   sizeof(*params)), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->command = EC_CMD_MKBP_INFO;
+	msg->version = 1;
+	msg->outsize = sizeof(*params);
+	msg->insize = result_size;
+	params = (struct ec_params_mkbp_info *)msg->data;
+	params->info_type = info_type;
+	params->event_type = event_type;
+
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
+	if (ret < 0) {
+		dev_warn(ec_dev->dev, "Transfer error %d/%d: %d\n",
+			 (int)info_type, (int)event_type, ret);
+	} else if (msg->result == EC_RES_INVALID_VERSION) {
+		/* With older ECs we just return 0 for everything */
+		memset(result, 0, result_size);
+		ret = 0;
+	} else if (msg->result != EC_RES_SUCCESS) {
+		dev_warn(ec_dev->dev, "Error getting info %d/%d: %d\n",
+			 (int)info_type, (int)event_type, msg->result);
+		ret = -EPROTO;
+	} else if (ret != result_size) {
+		dev_warn(ec_dev->dev, "Wrong size %d/%d: %d != %zu\n",
+			 (int)info_type, (int)event_type,
+			 ret, result_size);
+		ret = -EPROTO;
+	} else {
+		memcpy(result, msg->data, result_size);
+		ret = 0;
+	}
+
+	kfree(msg);
+
+	return ret;
+}
+
+/**
+ * cros_ec_keyb_query_switches - Query the state of switches and report
+ *
+ * This will ask the EC about the current state of switches and report to the
+ * kernel.  Note that we don't query for buttons because they are more
+ * transitory and we'll get an update on the next release / press.
+ *
+ * @ckdev: The keyboard device
+ *
+ * Returns 0 if no error or -error upon error.
+ */
+static int cros_ec_keyb_query_switches(struct cros_ec_keyb *ckdev)
+{
+	struct cros_ec_device *ec_dev = ckdev->ec;
+	union ec_response_get_next_data event_data = {};
+	int ret;
+
+	ret = cros_ec_keyb_info(ec_dev, EC_MKBP_INFO_CURRENT,
+				EC_MKBP_EVENT_SWITCH, &event_data,
+				sizeof(event_data.switches));
+	if (ret)
+		return ret;
+
+	cros_ec_keyb_report_bs(ckdev, EV_SW,
+			       get_unaligned_le32(&event_data.switches));
+
+	return 0;
+}
+
+/**
+ * cros_ec_keyb_resume - Resume the keyboard
+ *
+ * We use the resume notification as a chance to query the EC for switches.
+ *
+ * @dev: The keyboard device
+ *
+ * Returns 0 if no error or -error upon error.
+ */
+static __maybe_unused int cros_ec_keyb_resume(struct device *dev)
+{
+	struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
+
+	if (ckdev->bs_idev)
+		return cros_ec_keyb_query_switches(ckdev);
+
+	return 0;
+}
+
+/**
+ * cros_ec_keyb_register_bs - Register non-matrix buttons/switches
+ *
+ * Handles all the bits of the keyboard driver related to non-matrix buttons
+ * and switches, including asking the EC about which are present and telling
+ * the kernel to expect them.
+ *
+ * If this device has no support for buttons and switches we'll return no error
+ * but the ckdev->bs_idev will remain NULL when this function exits.
+ *
+ * @ckdev: The keyboard device
+ *
+ * Returns 0 if no error or -error upon error.
+ */
+static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
+{
+	struct cros_ec_device *ec_dev = ckdev->ec;
+	struct device *dev = ckdev->dev;
 	struct input_dev *idev;
-	struct device_node *np;
-	int err;
+	union ec_response_get_next_data event_data = {};
+	const char *phys;
+	u32 buttons;
+	u32 switches;
+	int ret;
+	int i;
+
+	ret = cros_ec_keyb_info(ec_dev, EC_MKBP_INFO_SUPPORTED,
+				EC_MKBP_EVENT_BUTTON, &event_data,
+				sizeof(event_data.buttons));
+	if (ret)
+		return ret;
+	buttons = get_unaligned_le32(&event_data.buttons);
+
+	ret = cros_ec_keyb_info(ec_dev, EC_MKBP_INFO_SUPPORTED,
+				EC_MKBP_EVENT_SWITCH, &event_data,
+				sizeof(event_data.switches));
+	if (ret)
+		return ret;
+	switches = get_unaligned_le32(&event_data.switches);
+
+	if (!buttons && !switches)
+		return 0;
 
-	np = pdev->dev.of_node;
-	if (!np)
-		return -ENODEV;
+	/*
+	 * We call the non-matrix buttons/switches 'input1', if present.
+	 * Allocate phys before input dev, to ensure correct tear-down
+	 * ordering.
+	 */
+	phys = devm_kasprintf(dev, GFP_KERNEL, "%s/input1", ec_dev->phys_name);
+	if (!phys)
+		return -ENOMEM;
 
-	ckdev = devm_kzalloc(dev, sizeof(*ckdev), GFP_KERNEL);
-	if (!ckdev)
+	idev = devm_input_allocate_device(dev);
+	if (!idev)
 		return -ENOMEM;
+
+	idev->name = "cros_ec_buttons";
+	idev->phys = phys;
+	__set_bit(EV_REP, idev->evbit);
+
+	idev->id.bustype = BUS_VIRTUAL;
+	idev->id.version = 1;
+	idev->id.product = 0;
+	idev->dev.parent = dev;
+
+	input_set_drvdata(idev, ckdev);
+	ckdev->bs_idev = idev;
+
+	for (i = 0; i < ARRAY_SIZE(cros_ec_keyb_bs); i++) {
+		const struct cros_ec_bs_map *map = &cros_ec_keyb_bs[i];
+
+		if (buttons & BIT(map->bit))
+			input_set_capability(idev, map->ev_type, map->code);
+	}
+
+	ret = cros_ec_keyb_query_switches(ckdev);
+	if (ret) {
+		dev_err(dev, "cannot query switches\n");
+		return ret;
+	}
+
+	ret = input_register_device(ckdev->bs_idev);
+	if (ret) {
+		dev_err(dev, "cannot register input device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * cros_ec_keyb_register_bs - Register matrix keys
+ *
+ * Handles all the bits of the keyboard driver related to matrix keys.
+ *
+ * @ckdev: The keyboard device
+ *
+ * Returns 0 if no error or -error upon error.
+ */
+static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
+{
+	struct cros_ec_device *ec_dev = ckdev->ec;
+	struct device *dev = ckdev->dev;
+	struct input_dev *idev;
+	const char *phys;
+	int err;
+
 	err = matrix_keypad_parse_of_params(dev, &ckdev->rows, &ckdev->cols);
 	if (err)
 		return err;
@@ -241,27 +542,28 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	if (!ckdev->old_kb_state)
 		return -ENOMEM;
 
+	/*
+	 * We call the keyboard matrix 'input0'. Allocate phys before input
+	 * dev, to ensure correct tear-down ordering.
+	 */
+	phys = devm_kasprintf(dev, GFP_KERNEL, "%s/input0", ec_dev->phys_name);
+	if (!phys)
+		return -ENOMEM;
+
 	idev = devm_input_allocate_device(dev);
 	if (!idev)
 		return -ENOMEM;
 
-	ckdev->ec = ec;
-	ckdev->notifier.notifier_call = cros_ec_keyb_work;
-	ckdev->dev = dev;
-	dev_set_drvdata(dev, ckdev);
-
 	idev->name = CROS_EC_DEV_NAME;
-	idev->phys = ec->phys_name;
+	idev->phys = phys;
 	__set_bit(EV_REP, idev->evbit);
 
 	idev->id.bustype = BUS_VIRTUAL;
 	idev->id.version = 1;
 	idev->id.product = 0;
 	idev->dev.parent = dev;
-	idev->open = cros_ec_keyb_open;
-	idev->close = cros_ec_keyb_close;
 
-	ckdev->ghost_filter = of_property_read_bool(np,
+	ckdev->ghost_filter = of_property_read_bool(dev->of_node,
 					"google,needs-ghost-filter");
 
 	err = matrix_keypad_build_keymap(NULL, NULL, ckdev->rows, ckdev->cols,
@@ -287,6 +589,57 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int cros_ec_keyb_probe(struct platform_device *pdev)
+{
+	struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct cros_ec_keyb *ckdev;
+	int err;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	ckdev = devm_kzalloc(dev, sizeof(*ckdev), GFP_KERNEL);
+	if (!ckdev)
+		return -ENOMEM;
+
+	ckdev->ec = ec;
+	ckdev->dev = dev;
+	dev_set_drvdata(dev, ckdev);
+
+	err = cros_ec_keyb_register_matrix(ckdev);
+	if (err) {
+		dev_err(dev, "cannot register matrix inputs: %d\n", err);
+		return err;
+	}
+
+	err = cros_ec_keyb_register_bs(ckdev);
+	if (err) {
+		dev_err(dev, "cannot register non-matrix inputs: %d\n", err);
+		return err;
+	}
+
+	ckdev->notifier.notifier_call = cros_ec_keyb_work;
+	err = blocking_notifier_chain_register(&ckdev->ec->event_notifier,
+					       &ckdev->notifier);
+	if (err) {
+		dev_err(dev, "cannot register notifier: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int cros_ec_keyb_remove(struct platform_device *pdev)
+{
+	struct cros_ec_keyb *ckdev = dev_get_drvdata(&pdev->dev);
+
+	blocking_notifier_chain_unregister(&ckdev->ec->event_notifier,
+					   &ckdev->notifier);
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id cros_ec_keyb_of_match[] = {
 	{ .compatible = "google,cros-ec-keyb" },
@@ -295,11 +648,15 @@ static const struct of_device_id cros_ec_keyb_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
 #endif
 
+static const SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
+
 static struct platform_driver cros_ec_keyb_driver = {
 	.probe = cros_ec_keyb_probe,
+	.remove = cros_ec_keyb_remove,
 	.driver = {
 		.name = "cros-ec-keyb",
 		.of_match_table = of_match_ptr(cros_ec_keyb_of_match),
+		.pm = &cros_ec_keyb_pm_ops,
 	},
 };
 
-- 
2.9.3
