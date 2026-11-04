Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756453;
	b=H+kUZ8ZrLHOTjz8vF+zkq3YYOTjsk2Cy1bvWQlNNqxjQnfAos14Yi3cPEycWT2mxUFZw
	 0OHYKV85yhWiOdwd3jgB54BfEDkxDsTZdnZO4hdjmswHPsi1jnNhdTCYtUoF8n+cDKkGJ
	 U83YGV+ELWDxLzzp9x4lZidGaHSih6mxIN2zlcRJ+vXt1adA2ZDmuMx9j719maz+qI1b0
	 Iu0Bz6V5dfVCTdavEs1y88+uT7HaJQP6KgWH4lRaeoe7PhCISLbvH+CjMMR2JZNxtAih3
	 uZs0LAAA6TzE+vQf40hIujkBdU7HmmGgZdTGL3BToZ9IUT15GiA7EbLTguog3CNv6Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756453;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/oDEBQobTAkoISRHOH1df/wI2pQ+Hp8/NwQi9C6/tD4=;
	b=IjJRq1LAjH6IXzJz8WKvVkOtamJo1WF5KrpzoXBOz1VXZp8t9hJwp7jjzFPoSsp7Vz7A
	 HUNimcDrpmxy+2v8gb3DgFxAAb3YFnRgQkvbAuUky7S7pwKHXOPygreWmya6Bh1cHh8VC
	 CbpTCQ85pl8P+Wnkzn1nwzHIwlk2zRSpkXoS+UwKITgZPlmBJgjUN+cZ2suLJOTBrzzlu
	 IemJwMcstNAM7cmH3XF/U3We+lgm1qaeAPzFSg7iNao9cZaivAPpJ7op3pcU25P/5RFAR
	 oe3YsQ456lrvPTUe6VklJ1xId0lUx/4biFW08mXSQEQ8If/CYcyHWse/ZEuqRxR82sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g91Xygau;
	arc=none smtp.remote-ip=91.218.175.205
Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403A606A31B
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E403A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=g91Xygau
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1ULaphOyEdmvDW/JCOz8UrbH3C4DwbdlGpdfuKKRgqs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756451; v=1; x=1794361251;
 b=g91XygauTMVI1qYYbQutyiBx20Z7f1fqtFhZFRpQeemnSNiwPyit/CM6KQwjwIa1JUCUDWJ/
 1Fd5LBoXL9zQjjWATHe3Z9NpQqrYOIFEUNbnVw/6eeTUNoTzL2jc2hzJtMqj7JCFcNDEpZnBjPP
 zD6WIA6o8mw8d0C5axqQ1Yws=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4e7571f75edbc355;
	Wed, 04 Nov 2026 01:40:19 +0000
X-Mizu-Trace-ID: 4e7571f75edbc355
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v13 03/18] HID: asus: add gamepad configuration
Date: Wed,  4 Nov 2026 01:39:20 +0000
Message-ID: <20261104013935.512713-4-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104013935.512713-1-denis.benato@linux.dev>
References: <20261104013935.512713-1-denis.benato@linux.dev>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the base configuration structures for the gamepad configuration,
detect capabilities and initialize the device in a known state.

The configuration interface exposes xbox_controller. Reading it
reports whether the handheld is presenting an Xbox gamepad, and
writing it switches that mode.

hid_asus_ally_reset_resume() now waits for the gamepad MCU to report
ready and returns that error. A reset resume can fail with -ENODEV
where it previously always succeeded.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Luke Jones <luke@ljones.dev>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
---
 drivers/hid/hid-asus.c | 312 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 311 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 2a3e8c399f0a..8277d7108bb9 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/jiffies.h>
+#include <linux/kstrtox.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -36,6 +37,7 @@
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
 #include <linux/stddef.h>
+#include <linux/sysfs.h>
 #include <linux/leds.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -77,6 +79,11 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define HID_ALLY_READY_MAX_TRIES 6
 
+#define ASUS_ALLY_XBOX_CONTROLLER_ENABLE 0x01
+#define ASUS_ALLY_XBOX_CONTROLLER_DISABLE 0x00
+
+#define ASUS_ALLY_CAPABILITY_SUPPORTED 0x01
+
 #define HID_INPUT_KEY_DELETE 0x4c
 #define HID_INPUT_KEY_F20 0x6f
 #define HID_INPUT_LCTRL_MODIFIER 0x01
@@ -203,6 +210,13 @@ struct ally_intf {
 	u8 cad_state;
 	unsigned long cad_last_event_time;
 	struct delayed_work resume_work;
+	/*
+	 * Sysfs groups hang off this interface's hdev. Numbers live in
+	 * ally_prefs so a re-probe can restore them; ownership of the
+	 * attributes is per device.
+	 */
+	bool sysfs_live;
+	bool cal_sysfs_live;
 };
 
 struct asus_drvdata {
@@ -762,6 +776,281 @@ static int ally_get_endpoint_address(struct hid_device *hdev)
 	return ep->desc.bEndpointAddress;
 }
 
+/*
+ * Settings that must survive the controller powering off and coming back.
+ * No device or input pointers live here: every transfer uses the interface
+ * that is bound right now.
+ *
+ * One set for the machine is by design. The Ally controller is
+ * part of the PC, so two ROG Ally HID devices are not bound at
+ * once. The only way to see a second one is to emulate it with
+ * uhid, but that would get rejected by the driver meaning that
+ * this struct can be used on a per-machine basis.
+ */
+static struct ally_prefs {
+	/* Guards every field below, including across the feature report. */
+	struct mutex lock;
+
+	bool initialized;
+
+	bool is_ally_x;
+	bool xbox_controller_support;
+	bool user_cal_support;
+	bool turbo_support;
+	bool resp_curve_support;
+	bool dir_to_btn_support;
+	bool gyro_support;
+	bool anti_deadzone_support;
+
+	bool xbox_controller_enabled;
+	u8 gamepad_mode;
+} ally_prefs = {
+	.lock = __MUTEX_INITIALIZER(ally_prefs.lock),
+};
+
+/**
+ * ally_check_capability() - Check if a specific capability is supported
+ * @hdev: HID device to query
+ * @check_cmd: capability command code
+ *
+ * Return: 1 if the capability is supported, 0 if not, negative on error.
+ */
+static int ally_check_capability(struct hid_device *hdev,
+				  enum ally_command_codes check_cmd)
+{
+	const u8 payload[] = {};
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, check_cmd, payload,
+					       sizeof(payload), &buf_len);
+
+	if (!buf) {
+		hid_err(hdev, "Failed to allocate buffer for capability check.\n");
+		return -ENOMEM;
+	}
+
+	if (buf_len < 5) {
+		hid_err(hdev, "Capability check response too short.\n");
+		return -EINVAL;
+	}
+
+	ret = ally_gamepad_send_receive_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to check capability 0x%02x: %d\n", check_cmd, ret);
+		return ret;
+	}
+
+	return buf[1] == HID_ALLY_FEATURE_CODE_PAGE && buf[2] == check_cmd &&
+	       buf[4] == ASUS_ALLY_CAPABILITY_SUPPORTED;
+}
+
+static int ally_detect_capabilities(struct hid_device *hdev)
+{
+	int ret;
+
+	guard(mutex)(&ally_prefs.lock);
+
+	ally_prefs.is_ally_x = (hdev->product == USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X);
+
+	ret = ally_check_capability(hdev, CMD_CHECK_XBOX_SUPPORT);
+	if (ret < 0)
+		goto ally_detect_capabilities_err;
+	ally_prefs.xbox_controller_support = ret;
+
+
+	ret = ally_check_capability(hdev, CMD_CHECK_USER_CAL_SUPPORT);
+	if (ret < 0)
+		goto ally_detect_capabilities_err;
+	ally_prefs.user_cal_support = ret;
+
+	ret = ally_check_capability(hdev, CMD_CHECK_TURBO_SUPPORT);
+	if (ret < 0)
+		goto ally_detect_capabilities_err;
+	ally_prefs.turbo_support = ret;
+
+	ret = ally_check_capability(hdev, CMD_CHECK_RESP_CURVE_SUPPORT);
+	if (ret < 0)
+		goto ally_detect_capabilities_err;
+	ally_prefs.resp_curve_support = ret;
+
+	ret = ally_check_capability(hdev, CMD_CHECK_DIR_TO_BTN_SUPPORT);
+	if (ret < 0)
+		goto ally_detect_capabilities_err;
+	ally_prefs.dir_to_btn_support = ret;
+
+	ret = ally_check_capability(hdev, CMD_CHECK_GYRO_TO_JOYSTICK);
+	if (ret < 0)
+		goto ally_detect_capabilities_err;
+	ally_prefs.gyro_support = ret;
+
+	ret = ally_check_capability(hdev, CMD_CHECK_ANTI_DEADZONE);
+	if (ret < 0)
+		goto ally_detect_capabilities_err;
+	ally_prefs.anti_deadzone_support = ret;
+
+	return 0;
+ally_detect_capabilities_err:
+	hid_err(hdev, "Failed to detect capabilities: %d\n", ret);
+	return ret;
+}
+
+/**
+ * ally_set_xbox_controller() - Enable or disable Xbox controller mode
+ * @hdev: HID device on which the command packet is sent
+ * @enabled: true to enable Xbox controller mode, false to disable it
+ *
+ * Builds a %CMD_SET_XBOX_CONTROLLER packet and sends it to the device. On
+ * success, the new state is stored in ally_prefs.xbox_controller_enabled.
+ *
+ * Context: Caller must hold ally_prefs.lock.
+ *
+ * Return: 0 on success, -%EOPNOTSUPP if Xbox controller mode is not
+ * supported, -%ENOMEM if the command buffer allocation fails, or a negative
+ * errno from ally_gamepad_send_packet() if sending the packet fails.
+ */
+static int ally_set_xbox_controller(struct hid_device *hdev, bool enabled)
+{
+	const u8 payload[] = { enabled ?
+				ASUS_ALLY_XBOX_CONTROLLER_ENABLE :
+				ASUS_ALLY_XBOX_CONTROLLER_DISABLE };
+	size_t buf_len;
+	int ret;
+
+	if (!ally_prefs.xbox_controller_support)
+		return -EOPNOTSUPP;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_XBOX_CONTROLLER,
+					       payload, sizeof(payload),
+					       &buf_len);
+
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ally_gamepad_send_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to set Xbox controller mode: %d\n", ret);
+		return ret;
+	}
+
+	ally_prefs.xbox_controller_enabled = enabled;
+	return 0;
+}
+
+static ssize_t xbox_controller_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.xbox_controller_support)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%d\n", ally_prefs.xbox_controller_enabled ? 1 : 0);
+}
+
+static ssize_t xbox_controller_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	bool enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.xbox_controller_support)
+		return -EOPNOTSUPP;
+
+	ret = ally_set_xbox_controller(hdev, enabled);
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
+static int ally_prefs_setup(struct hid_device *hdev, struct ally_intf *intf)
+{
+	int ret, i;
+
+	ret = ally_detect_capabilities(hdev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.initialized) {
+			ally_prefs.gamepad_mode = 0x01;
+			ally_prefs.xbox_controller_enabled = true;
+			ally_prefs.initialized = true;
+		}
+
+		if (intf->sysfs_live)
+			return 0;
+	}
+
+	/*
+	 * Create and remove sysfs groups without ally_prefs.lock. Attribute
+	 * methods take that lock while holding a kernfs active reference;
+	 * removing a group drains those references, so locking here would
+	 * invert the order and deadlock.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++) {
+		ret = sysfs_create_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+		if (ret) {
+			hid_err(hdev, "Failed to create Ally sysfs group '%s': %d\n",
+				ally_attr_groups[i].name ?: "", ret);
+			while (i--)
+				sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+			return ret;
+		}
+	}
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		intf->sysfs_live = true;
+	}
+
+	return 0;
+}
+
+static void ally_sysfs_remove(struct hid_device *hdev, struct ally_intf *intf)
+{
+	int i;
+
+	if (!intf)
+		return;
+
+	if (ally_get_endpoint_address(hdev) != HID_ALLY_INTF_CFG_IN)
+		return;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!intf->sysfs_live)
+			return;
+
+		intf->sysfs_live = false;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
+		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+}
+
 struct ally_x_input_report {
 	__le16 x, y;
 	__le16 rx, ry;
@@ -944,6 +1233,14 @@ static int hid_asus_ally_init(struct hid_device *hdev)
 	if (ret < 0)
 		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
 
+	guard(mutex)(&ally_prefs.lock);
+
+	if (ally_prefs.initialized && ally_prefs.xbox_controller_support) {
+		ret = ally_set_xbox_controller(hdev, ally_prefs.xbox_controller_enabled);
+		if (ret < 0)
+			hid_warn(hdev, "Failed to apply Xbox controller mode: %d\n", ret);
+	}
+
 	return 0;
 }
 
@@ -1038,6 +1335,12 @@ static struct ally_intf *hid_asus_ally_probe(struct hid_device *hdev)
 			return ERR_PTR(ret);
 		}
 
+		ret = ally_prefs_setup(hdev, intf);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create Ally cfg: %d\n", ret);
+			return ERR_PTR(ret);
+		}
+
 		hid_asus_ally_init(hdev);
 		break;
 	case HID_ALLY_X_INTF_IN:
@@ -1058,7 +1361,7 @@ static struct ally_intf *hid_asus_ally_probe(struct hid_device *hdev)
 
 static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_intf *intf)
 {
-	int ep;
+	int ep, ret;
 
 	/*
 	 * The extensions failed to probe and the device is operating as a
@@ -1071,6 +1374,12 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_intf
 	if (ep != HID_ALLY_INTF_CFG_IN)
 		return 0;
 
+	ret = ally_gamepad_check_ready(hdev);
+	if (ret < 0) {
+		hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
+		return ret;
+	}
+
 	return hid_asus_ally_init(hdev);
 }
 
@@ -1091,6 +1400,7 @@ static struct ally_intf *hid_asus_ally_terminate(struct asus_drvdata *drvdata)
 
 	ally_quiesce(ally);
 	ally_unregister_gamepad(ally);
+	ally_sysfs_remove(drvdata->hdev, ally);
 
 	return ally;
 }
-- 
2.47.3

