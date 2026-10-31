Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468517;
	b=lrN++c0QMLT+TJjnvwVfHmiwaoV2SGwlASXFlq1SjzpUzcfRrX67uBqKfIo4iOYcpxFZ
	 HMV8w2H8G5BF/gN9aDqBMWPlJR42wXavv/JdzFRSYHuhVxZMabC2IUFS2rWAU+CZHOOca
	 vSZrLukj9lNQjtMguSJyph7KQqwdmAqVjr5xdWiBKzFpBo0jXQNtW0jxfdXC2V0zxBFrs
	 Dhv8Hj1UYo4yeaVy4KWdoi9PRAHrPPojPFLoVmc8hrK1vEJgTx2AqUK3/L7ie1PSRH1t9
	 xhAxOl8JYz5s1kzgrxkeydslm/4JhXWQUL7UHpBfD2WqN6cMMzGZ+/ulkNzyG7Fcjog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468517;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P8f5QrepgVNHvUBjcl0MewP6IHoXzYeNXCsZErqnqEE=;
	b=kr3+g2jbLKGOtWPTbKa59xIW+8ss75I3El3jT2cTU/eB3PmeHnTX2yA3FLVjZYT9ZNiM
	 v6XfZybSGT5XDT+aqB0vxnHvnm+uE+Se6yFAuLei4hY2MTjtrY4OkfGoLAI0CMn6o3mYO
	 vLoQje5u+0JKS64ffY+RN+zmkC1mDo++O3gMcgTrrCQZOcFgJ0zLFk6jGvZVyKWp/s/Z5
	 QfBx8V1xizEcSoEdE/4O/K7blmAS7B8DwjksNyKEJ7dgu+gJuSweZDUgNQ7vnGcTnoisM
	 fKw3c8fp1HRu9hxX52+TFgDeHPowK2DnFlAOlzoj7xWZC7TrPJ51j1flEQGg+iM583g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FETXvDdE;
	arc=none smtp.remote-ip=91.218.175.216
Received: from mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61058606A31D
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 17:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61058606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FETXvDdE
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+lsFMOIgazHbT+LtRArpmtmrMgyN1JH8fHo+7Qak7AU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793468514; v=1; x=1794073314;
 b=FETXvDdEHB3gacgpKhuyOX2WkQXxT/DaXMqsU3RaoZ2xgKMdMIlKLbVJ5ft3svZk1bsUuBSc
 pRWSWK5kb5+xkreqdb/d7qBW6m0zuQT4xd94s7cgL7Ihbkuxe8+KvPzqc+RSKlGGtHS+9hEpVQV
 Sog277a9jmvNlZmPvq06HjkQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b178601a99f20257;
	Sat, 31 Oct 2026 17:41:54 +0000
X-Mizu-Trace-ID: b178601a99f20257
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
Subject: [PATCH v12 03/17] HID: asus: add gamepad configuration
Date: Sat, 31 Oct 2026 17:41:16 +0000
Message-ID: <20261031174130.208240-4-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031174130.208240-1-denis.benato@linux.dev>
References: <20261031174130.208240-1-denis.benato@linux.dev>
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
 drivers/hid/hid-asus.c | 255 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 252 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 552d3b25a1d1..5f5393ea92b7 100644
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
@@ -37,6 +38,7 @@
 #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 #include <linux/power_supply.h>
 #include <linux/stddef.h>
+#include <linux/sysfs.h>
 #include <linux/leds.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -78,6 +80,11 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
 #define HID_ALLY_READY_MAX_TRIES 6
 
+#define ASUS_ALLY_XBOX_CONTROLLER_ENABLE 0x01
+#define ASUS_ALLY_XBOX_CONTROLLER_DISABLE 0x00
+
+#define ASUS_ALLY_CAPABILITY_SUPPORTED 0x01
+
 #define HID_INPUT_KEY_DELETE 0x4c
 #define HID_INPUT_KEY_F20 0x6f
 #define HID_INPUT_LCTRL_MODIFIER 0x01
@@ -729,6 +736,224 @@ static int ally_get_endpoint_address(struct hid_device *hdev)
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
+ * uhid.
+ */
+static struct ally_prefs {
+	/* Guards every field below, including across the feature report. */
+	struct mutex lock;
+
+	bool initialized;
+	bool sysfs_live;
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
+ * Return: true if the capability is supported, false otherwise.
+ */
+static bool ally_check_capability(struct hid_device *hdev,
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
+		return false;
+	}
+
+	ret = ally_gamepad_send_receive_packet(hdev, buf, buf_len);
+	if (ret < 0) {
+		hid_err(hdev, "Failed to check capability 0x%02x: %d\n", check_cmd, ret);
+		return false;
+	}
+
+	return buf[1] == HID_ALLY_FEATURE_CODE_PAGE && buf[2] == check_cmd &&
+	       buf[4] == ASUS_ALLY_CAPABILITY_SUPPORTED;
+}
+
+static int ally_detect_capabilities(struct hid_device *hdev)
+{
+	guard(mutex)(&ally_prefs.lock);
+
+	ally_prefs.is_ally_x = (hdev->product == USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X);
+	ally_prefs.xbox_controller_support =
+		ally_check_capability(hdev, CMD_CHECK_XBOX_SUPPORT);
+	ally_prefs.user_cal_support =
+		ally_check_capability(hdev, CMD_CHECK_USER_CAL_SUPPORT);
+	ally_prefs.turbo_support =
+		ally_check_capability(hdev, CMD_CHECK_TURBO_SUPPORT);
+	ally_prefs.resp_curve_support =
+		ally_check_capability(hdev, CMD_CHECK_RESP_CURVE_SUPPORT);
+	ally_prefs.dir_to_btn_support =
+		ally_check_capability(hdev, CMD_CHECK_DIR_TO_BTN_SUPPORT);
+	ally_prefs.gyro_support =
+		ally_check_capability(hdev, CMD_CHECK_GYRO_TO_JOYSTICK);
+	ally_prefs.anti_deadzone_support =
+		ally_check_capability(hdev, CMD_CHECK_ANTI_DEADZONE);
+
+	return 0;
+}
+
+/* Caller holds ally_prefs.lock. The packet is sent on @hdev. */
+static int ally_set_xbox_controller(struct hid_device *hdev, bool enabled)
+{
+	const u8 payload[] = { enabled ?
+				ASUS_ALLY_XBOX_CONTROLLER_ENABLE :
+				ASUS_ALLY_XBOX_CONTROLLER_DISABLE };
+	size_t buf_len;
+	int ret;
+
+	u8 *buf __free(kfree) = ally_alloc_cmd(hdev, CMD_SET_XBOX_CONTROLLER,
+					       payload, sizeof(payload),
+					       &buf_len);
+
+	if (!ally_prefs.xbox_controller_support)
+		return -EOPNOTSUPP;
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
+static int ally_prefs_setup(struct hid_device *hdev)
+{
+	int ret, i;
+
+	ret = ally_detect_capabilities(hdev);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&ally_prefs.lock);
+
+	if (!ally_prefs.initialized) {
+		ally_prefs.gamepad_mode = 0x01;
+		ally_prefs.xbox_controller_enabled = true;
+		ally_prefs.initialized = true;
+	}
+
+	if (ally_prefs.sysfs_live)
+		return 0;
+
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
+	ally_prefs.sysfs_live = true;
+	return 0;
+}
+
+static void ally_sysfs_remove(struct hid_device *hdev)
+{
+	int i;
+
+	if (ally_get_endpoint_address(hdev) != HID_ALLY_INTF_CFG_IN)
+		return;
+
+	scoped_guard(mutex, &ally_prefs.lock) {
+		if (!ally_prefs.sysfs_live)
+			return;
+
+		ally_prefs.sysfs_live = false;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ally_attr_groups); i++)
+		sysfs_remove_group(&hdev->dev.kobj, &ally_attr_groups[i]);
+}
+
 struct ally_x_input_report {
 	__le16 x, y;
 	__le16 rx, ry;
@@ -911,6 +1136,14 @@ static int hid_asus_ally_init(struct hid_device *hdev)
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
 
@@ -1005,6 +1238,12 @@ static struct ally_intf *hid_asus_ally_probe(struct hid_device *hdev)
 			return ERR_PTR(ret);
 		}
 
+		ret = ally_prefs_setup(hdev);
+		if (ret < 0) {
+			hid_err(hdev, "Failed to create Ally cfg: %d\n", ret);
+			return ERR_PTR(ret);
+		}
+
 		hid_asus_ally_init(hdev);
 		break;
 	case HID_ALLY_X_INTF_IN:
@@ -1025,7 +1264,7 @@ static struct ally_intf *hid_asus_ally_probe(struct hid_device *hdev)
 
 static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_intf *intf)
 {
-	int ep;
+	int ep, ret;
 
 	/*
 	 * The extensions failed to probe and the device is operating as a
@@ -1038,6 +1277,12 @@ static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_intf
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
 
@@ -2514,8 +2759,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
 		ally_quiesce(drvdata->ally);
+		ally_sysfs_remove(hdev);
+	}
 
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
@@ -2535,8 +2782,10 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->xgm_led)
 		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
+	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
 		ally_quiesce(drvdata->ally);
+		ally_sysfs_remove(hdev);
+	}
 
 	asus_worker_stop(drvdata->worker);
 	hid_hw_stop(hdev);
-- 
2.47.3

