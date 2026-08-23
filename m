Received: from mta1.migadu.com (out-95.mta1.migadu.com [95.215.58.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF137F74C
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787511549; cv=none; b=pbKZzHwJJ73P8XVHShRoxS2usREoEE53408lZunwx0iAsc/HjylaZ+mw6GthYnflQ5l/H5055/yco4MuDgp2HrOTkdisgMf28MCnt2KPhCGK8iiq7j3qh+hql84+g8+RTZs/afG9+kMb/QGqjyFhjl1fipFe63criLs6zCga7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787511549; c=relaxed/simple;
	bh=3nBbX12Q9ZFlNRJKjl7qKt/Su5nmqZ/qfJYtA68UjIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8Zsj1w+kQGRSzLFmEVLj1lQ7xeZ1NXAhXtJenesU6C8wp7yDDOrvgMK1HQm3OUmAUkY13bQk/0zmYpj1EaimxX5sUNpYzcwZH65Zm068Evq2tBp7uTKhiuyCvVSDilYe9CH+fcz0So3NX1/3MJ9Z1pd2ZztPv/P1abYbrODJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TezbCHFq; arc=none smtp.client-ip=95.215.58.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TezbCHFq"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3nBbX12Q9ZFlNRJKjl7qKt/Su5nmqZ/qfJYtA68UjIQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787511545; v=1; x=1788116345;
 b=TezbCHFqYVFvS6+j0215CxaYc3dUROKfSr4o7dSRb5ZVx5PsKIMwWq3OZsEnBvfTZkCdZ4hM
 KoJR1bkKZtcx113D7Rr0lKkJ78LzVuDvDnbTm6uwiBcpvdoTNy7Vrw9pM8ZkdkUcweb0BV09Sny
 kbQBbIA4G78zrgI4XuRcwHPo=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 8d39743296643352;
	Sun, 23 Aug 2026 18:59:05 +0000
X-Mizu-Trace-ID: 8d39743296643352
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v3 03/12] HID: asus: add gamepad configuration
Date: Sun, 23 Aug 2026 18:58:40 +0000
Message-ID: <20260823185849.2478673-4-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260823185849.2478673-1-denis.benato@linux.dev>
References: <20260823185849.2478673-1-denis.benato@linux.dev>
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

# Conflicts:
#	drivers/hid/hid-asus.c
---
 drivers/hid/hid-asus.c | 348 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 338 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 048bc902323a..04f41294edf6 100644
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
 
@@ -176,6 +178,36 @@ struct asus_touchpad_info {
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
 struct ally_handheld {
 	/* All read/write to IN interfaces must lock */
 	struct mutex intf_mutex;
@@ -197,6 +229,8 @@ struct ally_handheld {
 	unsigned long cad_last_event_time;
 
 	struct delayed_work resume_work;
+
+	struct ally_config *config;
 };
 
 struct asus_drvdata {
@@ -610,6 +644,253 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
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
+		return -ENODEV;
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
+ * devm-managed on the same device as the sysfs attributes, which are
+ * removed before the memory is released.
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
+		return -ENODEV;
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
+		return -ENODEV;
+
+	ret = ally_set_xbox_controller(hdev, ally, cfg, enabled);
+	if (ret < 0)
+		return ret;
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
+	int ret, sysfs_i;
+
+	cfg = devm_kzalloc(&hdev->dev, sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&cfg->config_mutex);
+
+	ret = ally_detect_capabilities(hdev, ally, cfg);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to detect Ally capabilities: %d\n", ret);
+		goto ally_config_create_err;
+	}
+
+	for (sysfs_i = 0; sysfs_i < ARRAY_SIZE(ally_attr_groups); sysfs_i++) {
+		ret = devm_device_add_group(&hdev->dev, &ally_attr_groups[sysfs_i]);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create sysfs group '%s': %d\n",
+				ally_attr_groups[sysfs_i].name ?: "", ret);
+			goto ally_config_create_sysfs_err;
+		}
+	}
+
+	cfg->gamepad_mode = 0x01;
+	cfg->left_deadzone = 10;
+	cfg->left_outer_threshold = 90;
+	cfg->right_deadzone = 10;
+	cfg->right_outer_threshold = 90;
+
+	/* So far the only hardware this is supported is the Ally 1 */
+	if (cfg->xbox_controller_support) {
+		ret = ally_set_xbox_controller(hdev, ally, cfg, true);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to set default Xbox controller mode: %d\n",
+				ret);
+	}
+
+	cfg->initialized = true;
+
+	return cfg;
+ally_config_create_sysfs_err:
+ally_config_create_err:
+	devm_kfree(&hdev->dev, cfg);
+	return ERR_PTR(ret);
+}
+
+/**
+ * ally_config_remove() - Clean up configuration resources
+ * @hdev: HID device
+ * @ally: Non-NULL Ally device data
+ */
+static void ally_config_remove(struct hid_device *hdev, struct ally_handheld *ally)
+{
+	struct ally_config *cfg = ally->config;
+
+	if (!cfg || !cfg->initialized)
+		return;
+}
+
 /**
  * ally_gamepad_check_ready() - Wait for the gamepad MCU to report ready
  * @ally: ally handheld structure
@@ -870,16 +1151,7 @@ static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *all
 static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
 {
 	int ret;
-
-	/*
-	 * This function assumes the asus-specific initialization
-	 * to have been performed already at this point.
-	 */
-	ret = ally_gamepad_check_ready(ally, hdev);
-	if (ret < 0) {
-		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
-		return ret;
-	}
+	struct ally_config *cfg;
 
 	/* Failure at this point is non-critical */
 	ret = ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
@@ -887,6 +1159,24 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 	if (ret < 0)
 		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
 
+	cfg = ally_get_config(ally);
+	if (!cfg)
+		return 0;
+
+	/*
+	 * The MCU may have just been reset: restore the cached Xbox
+	 * controller mode, or the hardware would silently revert to its
+	 * default while the sysfs state still reports the user choice.
+	 */
+	guard(mutex)(&cfg->config_mutex);
+
+	if (cfg->xbox_controller_enabled) {
+		ret = ally_set_xbox_controller(hdev, ally, cfg, true);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to restore Xbox controller mode: %d\n",
+				 ret);
+	}
+
 	return 0;
 }
 
@@ -964,6 +1254,7 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 	unsigned long flags;
 	int ret, ep = ally_get_endpoint_address(hdev);
 	struct usb_device *udev;
+	struct ally_config *ally_cfg;
 	struct hid_input *hidinput;
 
 	if (ep < 0)
@@ -1000,13 +1291,34 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 	 */
 	switch (ep) {
 	case HID_ALLY_INTF_CFG_IN:
+		/*
+		 * This function assumes the asus-specific initialization
+		 * to have been performed already at this point.
+		 */
+		ret = ally_gamepad_check_ready(&ally_drvdata, hdev);
+		if (ret < 0) {
+			hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
+			ally_put_udev_if_orphaned();
+			return ERR_PTR(ret);
+		}
+
+		ally_cfg = ally_config_create(hdev, &ally_drvdata);
+		if (IS_ERR(ally_cfg)) {
+			hid_err(hdev, "Failed to create Ally cfg: %ld\n",
+				PTR_ERR(ally_cfg));
+			ally_put_udev_if_orphaned();
+			return ERR_PTR(PTR_ERR(ally_cfg));
+		}
+
 		ret = hid_asus_ally_init(hdev, &ally_drvdata);
 		if (ret < 0) {
+			ally_config_remove(hdev, &ally_drvdata);
 			ally_put_udev_if_orphaned();
 			return ERR_PTR(ret);
 		}
 
 		spin_lock_irqsave(&ally_data_lock, flags);
+		ally_drvdata.config = ally_cfg;
 		ally_drvdata.cfg_hdev = hdev;
 		spin_unlock_irqrestore(&ally_data_lock, flags);
 		break;
@@ -1071,6 +1383,12 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 		ally->keyboard_input = NULL;
 		ally->keyboard_hdev = NULL;
 	}
+
+	if (ally->cfg_hdev == hdev) {
+		ally_config_remove(hdev, ally);
+		ally->cfg_hdev = NULL;
+		ally->config = NULL;
+	}
 	spin_unlock_irqrestore(&ally_data_lock, flags);
 
 	/*
@@ -1096,6 +1414,16 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_handh
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
-- 
2.47.3

