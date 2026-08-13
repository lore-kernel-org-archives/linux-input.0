Received: from mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5F47427F
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632466; cv=none; b=A0TMtG3XGQaX/uT+qS+xwpLaJW+ddOuWt+fRo4UG2zKO6D26n/fsDSohux9ncx/JBMWo0ERoqbxQdXNnqoeTvdWuGmL7Kb6+x4Bow2Z/FpdUz3m0YUHGapCEQ541jc9XvVCb0dJ3vMh91ZOsjRYIr3J1+drojefRxgLgOvsef6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632466; c=relaxed/simple;
	bh=awhJtpkKlZfEMrvCBCl5WRHEjJzQnlAy/b+rMclRfig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1YdqljDbMn52Fs0whSkOakDx1yuiWEfu0bhmfj/BoaXH6434GYC5ImlfEwvMw3ZpW70gz+FJ90IAGJI+ggMKj38I7smmgalhq9LZXZaWPXoSU1LS9emRXFRV/2wRfjaPkSirM6UlJ+t3rkmgnfjwAuYNad9ttI89F/h/0JNMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lxp2hmUW; arc=none smtp.client-ip=95.215.58.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lxp2hmUW"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=awhJtpkKlZfEMrvCBCl5WRHEjJzQnlAy/b+rMclRfig=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786632461; v=1; x=1787237261;
 b=Lxp2hmUWfqLmW58LjQZdzOvm+1eIDrUW/iy+E9e0cwwN3uNBZMH1SMHZ+EwBDm12f8h/aopX
 SevvTsugJK4j+6IK9SU+byrFDrgkzDGlVR32ErNIJ81P4bFC4mv/AGqIDXp2gfI+vVwJMLZaPFi
 M43BW4YwPuEA+lzkpgxOCYas=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id bdaeb494b6ea7868;
	Thu, 13 Aug 2026 14:47:41 +0000
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
Subject: [PATCH 03/12] HID: asus: add gamepad configuration
Date: Thu, 13 Aug 2026 14:47:27 +0000
Message-ID: <20260813144736.2477941-4-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813144736.2477941-1-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the base configuration structures for the gamepad configuration,
detect capabilities and initialize the device in a known state.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 299 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 289 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index f4b2c4a616b7..6a15380488ef 100644
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
 
 #include "hid-ids.h"
@@ -175,6 +177,36 @@ struct asus_touchpad_info {
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
@@ -190,6 +222,8 @@ struct ally_handheld {
 	unsigned long cad_last_event_time;
 
 	struct delayed_work resume_work;
+
+	struct ally_config *config;
 };
 
 struct asus_drvdata {
@@ -556,6 +590,219 @@ static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
 	return hidbuf;
 }
 
+/**
+ * ally_check_capability - Check if a specific capability is supported
+ * @hdev: HID device
+ * @ally: ally handheld structure
+ * @check_cmd: Capability command code to query
+ *
+ * Returns true if capability is supported, false otherwise
+ */
+static bool ally_check_capability(struct hid_device *hdev, struct ally_handheld *ally,
+				  enum ally_command_codes check_cmd)
+{
+	u8 payload[] = { 0x00 };
+	bool result = false;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(check_cmd, payload, sizeof(payload));
+	if (!buf) {
+		hid_err(hdev, "Failed to allocate buffer for capability check.\n");
+		goto ally_check_capability_err;
+	}
+
+	ret = ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to check capability 0x%02x: %d\n", check_cmd, ret);
+		goto ally_check_capability_err;
+	}
+
+	if (buf[1] == HID_ALLY_FEATURE_CODE_PAGE && buf[2] == check_cmd)
+		result = (buf[4] == 0x01);
+
+ally_check_capability_err:
+	return result;
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
+	ret = ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set Xbox controller mode: %d\n", ret);
+		return ret;
+	}
+
+	cfg->xbox_controller_enabled = enabled;
+	return 0;
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
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	cfg = ally->config;
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
+	if (!ally || !ally->config)
+		return -ENODEV;
+
+	cfg = ally->config;
+	if (!cfg->xbox_controller_support)
+		return -ENODEV;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	ret = ally_set_xbox_controller(hdev, cfg, enabled);
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
+ * @ally: Non-NULL ally device data with uninitialized config pointer
+ *
+ * Returns valid pointer on success, error pointer on failure.
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
+				ally_attr_groups[sysfs_i].name, ret);
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
+		ret = ally_set_xbox_controller(hdev, cfg, true);
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
+	ally->config = NULL;
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
 /*
  * This should be called before any remapping attempts,
  * and on driver init/resume, after the asus handshake
@@ -607,6 +854,9 @@ static int ally_get_endpoint_address(struct hid_device *hdev)
 	return ep->desc.bEndpointAddress;
 }
 
+/* Matches the 15-byte payload of the 16-byte 0x0B wire report:
+ * buttons[0..1] are button bitmaps, buttons[2] is the hatswitch.
+ */
 struct ally_x_input_report {
 	uint16_t x, y;
 	uint16_t rx, ry;
@@ -763,16 +1013,6 @@ static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *all
 {
 	int ret;
 
-	/*
-	 * This function assumes the asus-specific initialization
-	 * to have been performed already at this point.
-	 */
-	ret = ally_gamepad_check_ready(ally, hdev);
-	if (ret < 0) {
-		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
-		return ret;
-	}
-
 	/* Failure at this point is non-critical */
 	ret = ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
 				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
@@ -829,6 +1069,7 @@ static bool hid_asus_ally_raw_event(struct hid_device *hdev, struct ally_handhel
 static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 {
 	int ret = 0, ep = ally_get_endpoint_address(hdev);
+	struct ally_config *ally_cfg;
 	struct hid_input *hidinput;
 
 	if (ep < 0)
@@ -838,8 +1079,30 @@ static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
 		switch (ep) {
 		case HID_ALLY_INTF_CFG_IN:
 			ally_drvdata.cfg_hdev = hdev;
+
+			/*
+			 * This function assumes the asus-specific initialization
+			 * to have been performed already at this point.
+			 */
+			ret = ally_gamepad_check_ready(&ally_drvdata, hdev);
+			if (ret < 0) {
+				hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
+				return ERR_PTR(ret);
+			}
+
+			ally_cfg = ally_config_create(hdev, &ally_drvdata);
+			if (IS_ERR(ally_cfg)) {
+				hid_err(hdev, "Failed to create Ally cfg: %ld\n",
+					PTR_ERR(ally_cfg));
+				ally_drvdata.cfg_hdev = NULL;
+				return ERR_PTR(PTR_ERR(ally_cfg));
+			}
+			ally_drvdata.config = ally_cfg;
+
 			ret = hid_asus_ally_init(hdev, &ally_drvdata);
 			if (ret < 0) {
+				ally_config_remove(hdev, &ally_drvdata);
+				ally_drvdata.config = NULL;
 				ally_drvdata.cfg_hdev = NULL;
 				return ERR_PTR(ret);
 			}
@@ -899,6 +1162,12 @@ static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *
 			ally->keyboard_input = NULL;
 			ally->keyboard_hdev = NULL;
 		}
+
+		if (ally->cfg_hdev == hdev) {
+			ally_config_remove(hdev, ally);
+			ally->cfg_hdev = NULL;
+			ally->config = NULL;
+		}
 	}
 }
 
@@ -913,6 +1182,16 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_handh
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

