Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0398395240
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260962; cv=none; b=hNMcuILDPAI8KVS9UChsiBdFaSeH9rbos5XQZKfu+mNgSRU3c/83iFdHjJfNa8USMOokF4GWtIcUoHs8xTn6tM04b+XbT9khEthFjLax6TGYMlqNM4O4Elm/eR0P5Gufer9QZUVuoUyc5GcfAbxHHvyu/50xi1EDTo7cfEqLP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260962; c=relaxed/simple;
	bh=1ZNQRmQHpUl5X0D74uK5AXv4KnTs+B4b/6CKbL0yQVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6pfeaCaOxOeCTxwgSYXWzbyMfn3koI20YVENIs1aCdWttYUdHUepDZ40iP1zcESufa5v69lHaLr9EipspfX53M0dAnRMqLH/8F90yRlojkMCTtCprYkgp6+2waMttggkKxwdj/Z0I0EWwZT6i+hP5IJvgBuE1pxddx12G/b2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZAyQjPOo; arc=none smtp.client-ip=91.218.175.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZAyQjPOo"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1ZNQRmQHpUl5X0D74uK5AXv4KnTs+B4b/6CKbL0yQVY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792260957; v=1; x=1792865757;
 b=ZAyQjPOopnzwFsew45eFEdNPjvyk4QIeXHTrpBT3XHCGIajpeVFntPIE0yRG+dVg/3aWPT/U
 ReL402SmPPvyFfjsmSclt9ySWbMfcFzr/cUUMEPs906oqQn81dl3GffUZ6zPZEJGTrJ6UF0wrzy
 U2p19bpmiOv5TIsvlmKrwFoQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 620d2b9bb03c1d4d;
	Sat, 17 Oct 2026 18:15:57 +0000
X-Mizu-Trace-ID: 620d2b9bb03c1d4d
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Jonathan LoBue <jlobue10@gmail.com>
Subject: [PATCH v10 02/11] HID: asus: add gamepad configuration
Date: Sat, 17 Oct 2026 18:15:11 +0000
Message-ID: <20261017181520.70206-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017181520.70206-1-denis.benato@linux.dev>
References: <20261017181520.70206-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the base configuration structures for the gamepad configuration,
detect capabilities and initialize the device in a known state.

Assisted-by: opencode:glm-5.2
Assisted-by: Claude:claude-fable-5
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 418 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 417 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 55f52fb7bb41..1e8f16f158c4 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -22,6 +22,7 @@
 
 #include <linux/acpi.h>
 #include <linux/cleanup.h>
+#include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/hid.h>
 #include <linux/jiffies.h>
@@ -34,6 +35,7 @@
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
 #include <linux/stddef.h>
+#include <linux/sysfs.h>
 #include <linux/leds.h>
 #include <linux/unaligned.h>
 
@@ -183,6 +185,45 @@ struct asus_touchpad_info {
 	int report_size;
 };
 
+struct ally_config {
+	/* Must be locked if the data is being changed */
+	struct mutex config_mutex;
+	bool initialized;
+
+	/* Device capabilities flags */
+	bool is_ally_x;
+	bool xbox_controller_support;
+	bool user_cal_support;
+	bool turbo_support;
+	bool resp_curve_support;
+	bool dir_to_btn_support;
+	bool gyro_support;
+	bool anti_deadzone_support;
+
+	/* Current settings */
+	bool xbox_controller_enabled;
+	u8 gamepad_mode;
+	u8 left_deadzone;
+	u8 left_outer_threshold;
+	u8 right_deadzone;
+	u8 right_outer_threshold;
+	u8 left_anti_deadzone;
+	u8 right_anti_deadzone;
+	u8 left_trigger_min;
+	u8 left_trigger_max;
+	u8 right_trigger_min;
+	u8 right_trigger_max;
+};
+
+/*
+ * The Ally configuration is allocated when the controller first appears and
+ * is released only on module removal: the embedded controller can disappear
+ * and re-enumerate at any time (it powers off during suspend when powersave
+ * is enabled), and on re-probe the driver must re-apply the recorded
+ * configuration instead of factory defaults.
+ */
+static struct ally_config *ally_config;
+
 struct ally_handheld {
 	/* All read/write to IN interfaces must lock */
 	struct mutex intf_mutex;
@@ -215,6 +256,8 @@ struct ally_handheld {
 	unsigned long cad_last_event_time;
 
 	struct delayed_work resume_work;
+
+	struct ally_config *config;
 };
 
 struct asus_drvdata {
@@ -660,6 +703,276 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
 	return hidbuf;
 }
 
+/**
+ * ally_check_capability() - Check if a specific capability is supported
+ * @hdev: HID device
+ * @ally: ally handheld structure
+ * @check_cmd: capability command code to query
+ *
+ * Return: true if the capability is supported, false otherwise
+ */
+static bool ally_check_capability(struct hid_device *hdev, struct ally_handheld *ally,
+				  enum ally_command_codes check_cmd)
+{
+	u8 payload[] = { 0x00 };
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(check_cmd, payload, sizeof(payload));
+	if (!buf) {
+		hid_err(hdev, "Failed to allocate buffer for capability check.\n");
+		return false;
+	}
+
+	ret = ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to check capability 0x%02x: %d\n", check_cmd, ret);
+		return false;
+	}
+
+	return buf[1] == HID_ALLY_FEATURE_CODE_PAGE && buf[2] == check_cmd &&
+	       buf[4] == 0x01;
+}
+
+static int ally_detect_capabilities(struct hid_device *hdev, struct ally_handheld *ally,
+				    struct ally_config *cfg)
+{
+	if (!hdev || !cfg || !ally)
+		return -EINVAL;
+
+	scoped_guard(mutex, &cfg->config_mutex) {
+		cfg->is_ally_x = (hdev->product == USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X);
+
+		cfg->xbox_controller_support =
+			ally_check_capability(hdev, ally, CMD_CHECK_XBOX_SUPPORT);
+		cfg->user_cal_support =
+			ally_check_capability(hdev, ally, CMD_CHECK_USER_CAL_SUPPORT);
+		cfg->turbo_support =
+			ally_check_capability(hdev, ally, CMD_CHECK_TURBO_SUPPORT);
+		cfg->resp_curve_support =
+			ally_check_capability(hdev, ally, CMD_CHECK_RESP_CURVE_SUPPORT);
+		cfg->dir_to_btn_support =
+			ally_check_capability(hdev, ally, CMD_CHECK_DIR_TO_BTN_SUPPORT);
+		cfg->gyro_support =
+			ally_check_capability(hdev, ally, CMD_CHECK_GYRO_TO_JOYSTICK);
+		cfg->anti_deadzone_support =
+			ally_check_capability(hdev, ally, CMD_CHECK_ANTI_DEADZONE);
+	}
+
+	return 0;
+}
+
+static int ally_set_xbox_controller(struct hid_device *hdev,
+				    struct ally_handheld *ally,
+				    struct ally_config *cfg, bool enabled)
+{
+	u8 payload[] = { enabled ? 0x01 : 0x00 };
+	int ret;
+
+	if (!cfg || !cfg->xbox_controller_support)
+		return -EOPNOTSUPP;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(CMD_SET_XBOX_CONTROLLER, payload, sizeof(payload));
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set Xbox controller mode: %d\n", ret);
+		return ret;
+	}
+
+	cfg->xbox_controller_enabled = enabled;
+	return 0;
+}
+
+/**
+ * ally_get_config() - Get the configuration of the Ally device
+ * @ally: ally handheld structure
+ *
+ * Fetch the configuration published by hid_asus_ally_probe() under
+ * ally_data_lock: the pointer is also cleared by hid_asus_ally_remove(),
+ * so reading it without the lock would race with interface removal.
+ *
+ * The returned configuration outlives the sysfs callbacks using it: it is
+ * allocated once on the ally probe path and released only on module
+ * removal, when every sysfs attribute referencing it is gone.
+ *
+ * Return: the ally config, or NULL if no configuration is published
+ */
+static struct ally_config *ally_get_config(struct ally_handheld *ally)
+{
+	struct ally_config *cfg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ally_data_lock, flags);
+	cfg = ally->config;
+	spin_unlock_irqrestore(&ally_data_lock, flags);
+
+	return cfg;
+}
+
+static ssize_t xbox_controller_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->xbox_controller_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%d\n", cfg->xbox_controller_enabled ? 1 : 0);
+}
+
+static ssize_t xbox_controller_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct ally_handheld *ally = drvdata->rog_ally;
+	struct ally_config *cfg;
+	bool enabled;
+	int ret;
+
+	if (!ally)
+		return -ENODEV;
+
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&cfg->config_mutex);
+
+	if (!cfg->xbox_controller_support)
+		return -EOPNOTSUPP;
+
+	ret = ally_set_xbox_controller(hdev, ally, cfg, enabled);
+	if (ret < 0)
+		return ret;
+
+	sysfs_notify(&dev->kobj, NULL, "xbox_controller");
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(xbox_controller);
+
+static struct attribute *ally_config_attrs[] = {
+	&dev_attr_xbox_controller.attr,
+	NULL
+};
+
+static const struct attribute_group ally_attr_groups[] = {
+	{
+		.attrs = ally_config_attrs,
+	},
+};
+
+/**
+ * ally_config_create() - Initialize configuration and create sysfs entries
+ * @hdev: HID device
+ * @ally: non-NULL ally device data with uninitialized config pointer
+ *
+ * Return: valid pointer on success, error pointer on failure
+ */
+static struct ally_config *ally_config_create(struct hid_device *hdev, struct ally_handheld *ally)
+{
+	struct ally_config *cfg;
+	unsigned long flags;
+	int ret, sysfs_i;
+
+	/*
+	 * Allocate the configuration only once and keep it until module
+	 * removal: the controller can disappear and re-enumerate while
+	 * suspended, and the recorded settings must survive that to be
+	 * re-applied when the controller comes back.
+	 */
+	if (!ally_config) {
+		ally_config = kzalloc_obj(*ally_config, GFP_KERNEL);
+		if (!ally_config)
+			return ERR_PTR(-ENOMEM);
+
+		mutex_init(&ally_config->config_mutex);
+	}
+
+	cfg = ally_config;
+
+	ret = ally_detect_capabilities(hdev, ally, cfg);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to detect Ally capabilities: %d\n", ret);
+		goto ally_config_create_err;
+	}
+
+	if (!cfg->initialized) {
+		cfg->gamepad_mode = 0x01;
+		cfg->xbox_controller_enabled = true;
+		cfg->left_deadzone = 10;
+		cfg->left_outer_threshold = 90;
+		cfg->right_deadzone = 10;
+		cfg->right_outer_threshold = 90;
+	}
+
+	spin_lock_irqsave(&ally_data_lock, flags);
+	ally->config = cfg;
+	spin_unlock_irqrestore(&ally_data_lock, flags);
+
+	for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
+		ret = sysfs_create_group(&hdev->dev.kobj,
+					 &ally_attr_groups[sysfs_i]);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
+				ally_attr_groups[sysfs_i].name ?: "", ret);
+			goto ally_config_create_sysfs_err;
+		}
+	}
+
+	cfg->initialized = true;
+
+	return cfg;
+ally_config_create_sysfs_err:
+	spin_lock_irqsave(&ally_data_lock, flags);
+	ally->config = NULL;
+	spin_unlock_irqrestore(&ally_data_lock, flags);
+
+	/* The sysfs groups are not devm-managed: undo the created ones. */
+	while (sysfs_i-- > 0)
+		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[sysfs_i]);
+
+ally_config_create_err:
+	return ERR_PTR(ret);
+}
+
+/**
+ * ally_config_remove() - Clean up configuration resources
+ * @hdev: HID device
+ * @cfg: ally config to clean up, may be NULL
+ */
+static void ally_config_remove(struct hid_device *hdev, struct ally_config *cfg)
+{
+	int i;
+
+	if (!cfg || !cfg->initialized)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
+		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+}
+
 /**
  * ally_gamepad_check_ready() - Wait for the gamepad MCU to report ready
  * @ally: ally handheld structure
@@ -921,6 +1234,7 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
 
 static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
 {
+	struct ally_config *cfg;
 	int ret;
 
 	/* Failure at this point is non-critical */
@@ -929,6 +1243,21 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 	if (ret < 0)
 		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
 
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return 0;
+
+	/* The MCU may have just been reset: restore the cached state. */
+	guard(mutex)(&cfg->config_mutex);
+
+	if (cfg->xbox_controller_support) {
+		ret = ally_set_xbox_controller(hdev, ally, cfg,
+					       cfg->xbox_controller_enabled);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to apply Xbox controller mode: %d\n",
+				 ret);
+	}
+
 	return 0;
 }
 
@@ -1004,11 +1333,16 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 	unsigned long flags;
 	int ret, ep = ally_get_endpoint_address(hdev);
 	struct usb_device *udev;
+	struct asus_drvdata *drvdata;
+	struct ally_config *ally_cfg;
 	struct hid_input *hidinput;
 
 	if (ep < 0)
 		return ERR_PTR(ep);
 
+	if (!hid_is_usb(hdev))
+		return ERR_PTR(-ENODEV);
+
 	/*
 	 * The ROG Ally controller is integrated into a handheld PC, so at
 	 * most one device can exist and the shared global state relies on
@@ -1020,6 +1354,7 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 	 * power when powersave is enabled) is still accepted.
 	 */
 	udev = interface_to_usbdev(to_usb_interface(hdev->dev.parent));
+	drvdata = hid_get_drvdata(hdev);
 
 	spin_lock_irqsave(&ally_data_lock, flags);
 	if (ally_drvdata.udev && ally_drvdata.udev != udev) {
@@ -1083,8 +1418,40 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 			return ERR_PTR(ret);
 		}
 
+		/*
+		 * Publish the shared state before the configuration creates
+		 * its attributes: their callbacks fetch drvdata->rog_ally
+		 * first, and the files must work from the moment they exist.
+		 * Cleared again on the failure paths below.
+		 */
+		drvdata->rog_ally = &ally_drvdata;
+
+		ally_cfg = ally_config_create(hdev, &ally_drvdata);
+		if (IS_ERR(ally_cfg)) {
+			hid_err(hdev, "Failed to create Ally cfg: %ld\n",
+				PTR_ERR(ally_cfg));
+			drvdata->rog_ally = NULL;
+			ally_probe_release_role(ep);
+			ally_put_udev_if_orphaned();
+			return ERR_PTR(PTR_ERR(ally_cfg));
+		}
+
 		ret = hid_asus_ally_init(hdev, &ally_drvdata);
 		if (ret < 0) {
+			/*
+			 * Roll the configuration back like
+			 * hid_asus_ally_remove() does: unpublish it under
+			 * the lock first, so no sysfs callback can find it
+			 * while ally_config_remove() removes the groups that
+			 * were created.
+			 */
+			spin_lock_irqsave(&ally_data_lock, flags);
+			ally_drvdata.config = NULL;
+			spin_unlock_irqrestore(&ally_data_lock, flags);
+
+			ally_config_remove(hdev, ally_cfg);
+
+			drvdata->rog_ally = NULL;
 			ally_probe_release_role(ep);
 			ally_put_udev_if_orphaned();
 			return ERR_PTR(ret);
@@ -1131,7 +1498,9 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *ally)
 {
 	struct input_dev *x_input = NULL;
+	struct ally_config *cfg = NULL;
 	unsigned long flags;
+	bool owns_cfg;
 
 	if (!ally)
 		return;
@@ -1161,8 +1530,25 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 		ally->keyboard_input = NULL;
 		ally->keyboard_hdev = NULL;
 	}
+
+	owns_cfg = ally->cfg_hdev == hdev;
+	if (owns_cfg) {
+		cfg = ally->config;
+		ally->cfg_hdev = NULL;
+		ally->config = NULL;
+	}
+
 	spin_unlock_irqrestore(&ally_data_lock, flags);
 
+	/*
+	 * The config teardown removes sysfs groups and takes sleeping locks:
+	 * it must not run under ally_data_lock. The config pointer has been
+	 * unpublished above, so no new sysfs callback can find it while the
+	 * groups are being removed.
+	 */
+	if (owns_cfg)
+		ally_config_remove(hdev, cfg);
+
 	if (x_input)
 		input_unregister_device(x_input);
 
@@ -1189,6 +1575,16 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_handh
 	if (ep != HID_ALLY_INTF_CFG_IN)
 		return 0;
 
+	/*
+	 * This function assumes the asus-specific initialization
+	 * to have been performed already at this point.
+	 */
+	ret = ally_gamepad_check_ready(ally, hdev);
+	if (ret < 0) {
+		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
+		return ret;
+	}
+
 	ret = hid_asus_ally_init(hdev, ally);
 	if (ret < 0)
 		return ret;
@@ -2877,7 +3273,27 @@ static struct hid_driver asus_driver = {
 	.event			= asus_event,
 	.raw_event		= asus_raw_event
 };
-module_hid_driver(asus_driver);
+static int __init asus_init(void)
+{
+	return hid_register_driver(&asus_driver);
+}
+
+/*
+ * The Ally configuration is not tied to any device lifetime: interface
+ * removal keeps it so that it can be re-applied on re-probe. Release it
+ * only when the module itself is removed, once no sysfs attribute can
+ * reach it anymore.
+ */
+static void __exit asus_exit(void)
+{
+	hid_unregister_driver(&asus_driver);
+
+	kfree(ally_config);
+	ally_config = NULL;
+}
+
+module_init(asus_init);
+module_exit(asus_exit);
 
 MODULE_IMPORT_NS("ASUS_WMI");
 MODULE_LICENSE("GPL");
-- 
2.47.3

