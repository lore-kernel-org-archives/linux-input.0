Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC802EEE7E
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782592805; cv=none; b=gCqNog6rAlA+Gf+A45pLN5RpuQ9UYE3tiz7znsWHRBuT7h0+5p6TeG8kclQgCK6toaTwwznKsSirPYYIHLReOyOp/7vsuxVcQxubS/w4E9+tiMSKEyM3Hcf+UO7bo2sG5YAjivsh1MkX0T8K6v5ci0fmLFaYLFyyWa6CXGgnaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782592805; c=relaxed/simple;
	bh=/t64SayViEScwzrbih7SaYVlOnIwxlilLzShIj4XmuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iNPYngUSrRROcWN/xgeYchyYz+vVZZ84BswdJ8kMfC8qk6DK1inoQo/4rWKQvybRHFAuiMmDjtBQr6n6Stf7A3dJy7fny84R8mssl1MlUNs7ILEvIQiB5geFaSN1oCTtB3/eLaOpSV+E02gPwtT62ivqjeqdVDkUm6PTl+8am7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schn.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schn.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1397e093f90so2729683c88.1
        for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 13:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782592803; x=1783197603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YprefoEM53U34KTOw5zxGLxF7rIxI/qYa+tJiCFJhgE=;
        b=Tc1ACycpS2vmbvzIITtazVlyrikSNCJer0GuGL16gaIQdFyqPwnWDp6grdKQBEwazv
         Wp0tieLZGQzir8/gHnjO/UkbpnVatk7b44701j61+y8eTczvNr/48f7EaExEaZvN4Y+s
         tWvqEYWXTqpPWZlyQ30jjZmK6we9oIizsJi+P50NMZxllgqOzk6nYd1mR764ZmFKhk6m
         qG89KokQ10+qrgeVF9s7aWbpCtl3di8qWZ1XoXjwgdiCoi7Ilo7fO8BemTvYwpxB8xg/
         ec8rarBoYPwhVOq2YQd1IohWuiDFEmsUJubOrz32H4ehHfF7t0Xk2YLSn9aX7wS5J2pj
         uIvw==
X-Gm-Message-State: AOJu0Yx2vl0lhz4Q7SFkzNtJHG/gA64PD860BtMVNrx+Z68Eu1UTbp5w
	shdo/fELi5RLNolruF4BN+KBXPaD5eymOjP2r20nHE5oWBzYqSDlySXp
X-Gm-Gg: AfdE7ckhezvh2Kihha+PT+N6SZy7Z2NOdWQI38+8TtMZIp4P314Chn8lXQFmN2pbYhq
	owKGc/lmVPIPBw1KvHnyzoqv907jsVWSTMKrcCi5oaD+LzTTALfTfXZBAUMxZ4UIeVcbleS2OvV
	AA7YlM0kTP04B8XWXv98CEJ/xK9761BlnqREX6fzHbgO7w3gvZJajUYELJUwlHvVGjy0O1lhZOQ
	08eEkQ2oTdVpt4yag4zClxPZjryq4lc1dtC5Dz1NjqcqZZ+eyuN/Nlk2qhwwnGAObcDDV3dK/OI
	YvtCeLBOJO8LsjSCA3s9PFuAciB33cCl265uzyNKZ0qvUK1Du2p2bvyW1OxuagNELdnKU0E0hNA
	ykAaIMEewIDkESWhQHr6cbtQ9kszw1hrOfZAidSfwX5heRLMLcktqP3ivebfVzBLRM1wRrCiG3B
	nyl99Zc21MM6spxpfgdBjGuhB31o7X7pSJvYd4GqQJZ9RVpcEd1QTW4A==
X-Received: by 2002:a05:7022:f9e:b0:136:c24a:7213 with SMTP id a92af1059eb24-139dba1b98cmr9653617c88.11.1782592802571;
        Sat, 27 Jun 2026 13:40:02 -0700 (PDT)
Received: from desktop-sofia ([2804:14d:ba4e:8353:8f7f:4b88:a059:f87e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e4c33af7sm16756827c88.5.2026.06.27.13.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 13:40:01 -0700 (PDT)
From: Sofia Schneider <sofia@schn.dev>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sofia Schneider <sofia@schn.dev>
Subject: [PATCH v2] HID: hyperx-headset: Add support for HyperX headset devices
Date: Sat, 27 Jun 2026 17:39:46 -0300
Message-ID: <20260627203948.1053589-1-sofia@schn.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a HID driver for HyperX Cloud III Wireless headsets,
supporting battery reporting and connection status.

Tested with a HyperX Cloud III Wireless only, for lack of
other testable devices.

Signed-off-by: Sofia Schneider <sofia@schn.dev>
---
v2:
- Call hid_hw_stop() before cancelling work queues in remove() to prevent UAF.
- Safe unregistration of power supply using the spinlock in remove() to prevent race conditions.
- Cancel battery_work in the hid_hw_start() error path in probe() to prevent UAF.
- Dynamically allocate power supply names to avoid sysfs naming collisions.

v1: https://lore.kernel.org/linux-input/20260622022800.D01D51F000E9@smtp.kernel.org/T/#t

 MAINTAINERS                      |   6 +
 drivers/hid/Kconfig              |  11 +
 drivers/hid/Makefile             |   1 +
 drivers/hid/hid-hyperx-headset.c | 387 +++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h            |   1 +
 5 files changed, 406 insertions(+)
 create mode 100644 drivers/hid/hid-hyperx-headset.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d8252026bbd4..fa49655255f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11419,6 +11419,12 @@ F:	include/uapi/linux/hid*
 F:	samples/hid/
 F:	tools/testing/selftests/hid/
 
+HID HYPERX HEADSET DRIVER
+M:	Sofia Schneider <sofia@schn.dev>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-hyperx-headset.c
+
 HID LOGITECH DRIVERS
 R:	Filipe Laíns <lains@riseup.net>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f9bcaeb66385..e9f5f1f982c9 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1215,6 +1215,17 @@ config HID_HYPERV_MOUSE
 	help
 	Select this option to enable the Hyper-V mouse driver.
 
+config HID_HYPERX_HEADSET
+	tristate "HyperX headset devices"
+	depends on USB_HID
+	select POWER_SUPPLY
+	help
+	Support for HyperX headset devices.
+
+	Say Y here if you would like to enable support for HyperX headset devices.
+	To compile this driver as a module, choose M here: the module will be called
+	hid-hyperx-headset.
+
 config HID_SMARTJOYPLUS
 	tristate "SmartJoy PLUS PS2/USB adapter support"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 23e6e3dd0c56..9f3fd2c21837 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
+obj-$(CONFIG_HID_HYPERX_HEADSET)	+= hid-hyperx-headset.o
 obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
 obj-$(CONFIG_HID_ITE)		+= hid-ite.o
 obj-$(CONFIG_HID_JABRA)		+= hid-jabra.o
diff --git a/drivers/hid/hid-hyperx-headset.c b/drivers/hid/hid-hyperx-headset.c
new file mode 100644
index 000000000000..b77931d4dfb0
--- /dev/null
+++ b/drivers/hid/hid-hyperx-headset.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  HID driver for HyperX headsets
+ *
+ *  Supports HyperX Cloud III Wireless headsets.
+ *
+ *  Copyright (c) 2026 Sofia Schneider
+ */
+
+#include <linux/usb.h>
+#include <linux/hid.h>
+
+#include "hid-ids.h"
+
+#define HYPERX_POLL_INTERVAL_MS (2 * 60 * 1000)
+
+#define HYPERX_REPORT_ID 0x66
+#define HYPERX_PACKET_SIZE 62
+
+#define HYPERX_CMD_GET_CONNECTED 0x82
+#define HYPERX_CMD_GET_BATTERY 0x89
+#define HYPERX_CMD_GET_CHARGING 0x8A
+
+#define HYPERX_RESP_CONNECTED 0x0B
+#define HYPERX_RESP_CHARGING 0x0C
+#define HYPERX_RESP_BATTERY 0x0D
+
+#define HYPERX_PREFIX "HP, Inc "
+#define HYPERX_PREFIX_LEN strlen(HYPERX_PREFIX)
+
+struct hyperx_headset_device {
+	struct hid_device *hdev;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+
+	spinlock_t lock;
+	u8 battery_level;
+	bool is_charging;
+	bool is_connected;
+
+	struct delayed_work poll_work;
+	struct work_struct battery_work;
+};
+
+static const enum power_supply_property hyperx_headset_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int hyperx_headset_battery_get_property(struct power_supply *psy,
+					       enum power_supply_property psp,
+					       union power_supply_propval *val)
+{
+	struct hyperx_headset_device *drvdata = power_supply_get_drvdata(psy);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = drvdata->is_connected ? 1 : 0;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = drvdata->battery_level;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!drvdata->is_connected)
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (drvdata->is_charging)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (drvdata->battery_level == 100)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = drvdata->hdev->name;
+		while (!strncmp(val->strval, HYPERX_PREFIX, HYPERX_PREFIX_LEN))
+			val->strval += HYPERX_PREFIX_LEN;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "HyperX";
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	return ret;
+}
+
+
+
+static int hyperx_headset_send_command(struct hyperx_headset_device *drvdata,
+				       u8 command)
+{
+	struct hid_device *hdev = drvdata->hdev;
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(HYPERX_PACKET_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = HYPERX_REPORT_ID;
+	buf[1] = command;
+
+	ret = hid_hw_raw_request(hdev, HYPERX_REPORT_ID, buf,
+				 HYPERX_PACKET_SIZE, HID_OUTPUT_REPORT,
+				 HID_REQ_SET_REPORT);
+
+	if (ret < 0)
+		hid_err(hdev, "hw_raw_request failed (command 0x%02x)\n",
+			command);
+
+	kfree(buf);
+	return ret;
+}
+
+static void hyperx_headset_poll_work(struct work_struct *work)
+{
+	struct hyperx_headset_device *drvdata = container_of(
+		work, struct hyperx_headset_device, poll_work.work);
+
+	hyperx_headset_send_command(drvdata, HYPERX_CMD_GET_CONNECTED);
+	hyperx_headset_send_command(drvdata, HYPERX_CMD_GET_BATTERY);
+	hyperx_headset_send_command(drvdata, HYPERX_CMD_GET_CHARGING);
+
+	schedule_delayed_work(&drvdata->poll_work,
+			      msecs_to_jiffies(HYPERX_POLL_INTERVAL_MS));
+}
+
+static void hyperx_headset_set_wireless_status(struct hid_device *hdev,
+					       bool connected)
+{
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	usb_set_wireless_status(intf, connected ?
+					      USB_WIRELESS_STATUS_CONNECTED :
+					      USB_WIRELESS_STATUS_DISCONNECTED);
+}
+
+static void hyperx_headset_battery_work(struct work_struct *work)
+{
+	struct hyperx_headset_device *drvdata =
+		container_of(work, struct hyperx_headset_device, battery_work);
+	struct power_supply_config battery_cfg = { .drv_data = drvdata };
+	unsigned long flags;
+	bool connected;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	connected = drvdata->is_connected;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	hyperx_headset_set_wireless_status(drvdata->hdev, connected);
+
+	if (connected && !drvdata->battery) {
+		struct power_supply *ps;
+
+		ps = power_supply_register(&drvdata->hdev->dev,
+					   &drvdata->battery_desc,
+					   &battery_cfg);
+		if (IS_ERR(ps)) {
+			hid_err(drvdata->hdev,
+				"power_supply_register failed\n");
+			return;
+		}
+
+		power_supply_powers(ps, &drvdata->hdev->dev);
+
+		spin_lock_irqsave(&drvdata->lock, flags);
+		drvdata->battery = ps;
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+	} else if (!connected && drvdata->battery) {
+		struct power_supply *ps;
+
+		spin_lock_irqsave(&drvdata->lock, flags);
+		ps = drvdata->battery;
+		drvdata->battery = NULL;
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+
+		power_supply_unregister(ps);
+	}
+}
+
+static void
+hyperx_headset_parse_battery_event(struct hyperx_headset_device *drvdata,
+				   u8 *data)
+{
+	unsigned long flags;
+	u8 state1 = data[2];
+	u8 state2 = data[3];
+	u8 level = data[4];
+
+	// Battery event is invalid if both states are 0
+	if (state1 == 0 && state2 == 0)
+		return;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+
+	if (drvdata->battery_level != level) {
+		drvdata->battery_level = level;
+
+		if (drvdata->battery)
+			power_supply_changed(drvdata->battery);
+	}
+
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+}
+
+static void
+hyperx_headset_parse_charging_event(struct hyperx_headset_device *drvdata,
+				    u8 *data)
+{
+	unsigned long flags;
+	bool charging = (data[2] == 1);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+
+	if (drvdata->is_charging != charging) {
+		drvdata->is_charging = charging;
+
+		if (drvdata->battery)
+			power_supply_changed(drvdata->battery);
+	}
+
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+}
+
+static void
+hyperx_headset_parse_connected_event(struct hyperx_headset_device *drvdata,
+				     u8 *data)
+{
+	unsigned long flags;
+	bool state_changed = false;
+	bool connected = (data[2] == 1);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+
+	if (drvdata->is_connected != connected) {
+		drvdata->is_connected = connected;
+		state_changed = true;
+	}
+
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	if (state_changed)
+		schedule_work(&drvdata->battery_work);
+}
+
+static int hyperx_headset_probe(struct hid_device *hdev,
+				const struct hid_device_id *id)
+{
+	int ret;
+	struct hyperx_headset_device *drvdata;
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (drvdata == NULL)
+		return -ENOMEM;
+	drvdata->hdev = hdev;
+	drvdata->is_connected = false;
+	drvdata->is_charging = false;
+	drvdata->battery_level = 100;
+	spin_lock_init(&drvdata->lock);
+	hid_set_drvdata(hdev, drvdata);
+
+	drvdata->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	drvdata->battery_desc.properties = hyperx_headset_battery_props;
+	drvdata->battery_desc.num_properties = ARRAY_SIZE(hyperx_headset_battery_props);
+	drvdata->battery_desc.get_property = hyperx_headset_battery_get_property;
+	drvdata->battery_desc.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						    "hyperx_headset_battery_%s",
+						    strlen(hdev->uniq) ?
+						    hdev->uniq : dev_name(&hdev->dev));
+	if (!drvdata->battery_desc.name)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&drvdata->poll_work, hyperx_headset_poll_work);
+	INIT_WORK(&drvdata->battery_work, hyperx_headset_battery_work);
+
+	ret = hid_parse(hdev);
+	if (ret != 0) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret != 0) {
+		hid_err(hdev, "hw_start failed\n");
+		cancel_work_sync(&drvdata->battery_work);
+		return ret;
+	}
+
+	schedule_delayed_work(&drvdata->poll_work, 0);
+
+	return 0;
+}
+
+static int hyperx_headset_raw_event(struct hid_device *hdev,
+				    struct hid_report *report, u8 *data,
+				    int size)
+{
+	struct hyperx_headset_device *drvdata = hid_get_drvdata(hdev);
+
+	if (size < 5 || data[0] != HYPERX_REPORT_ID)
+		return 0;
+
+	switch (data[1]) {
+	case HYPERX_CMD_GET_CONNECTED:
+	case HYPERX_RESP_CONNECTED:
+		hyperx_headset_parse_connected_event(drvdata, data);
+		break;
+
+	case HYPERX_CMD_GET_BATTERY:
+	case HYPERX_RESP_BATTERY:
+		hyperx_headset_parse_battery_event(drvdata, data);
+		break;
+
+	case HYPERX_CMD_GET_CHARGING:
+	case HYPERX_RESP_CHARGING:
+		hyperx_headset_parse_charging_event(drvdata, data);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void hyperx_headset_remove(struct hid_device *hdev)
+{
+	struct hyperx_headset_device *drvdata = hid_get_drvdata(hdev);
+	struct power_supply *ps = NULL;
+	unsigned long flags;
+
+	hid_hw_stop(hdev);
+
+	if (drvdata) {
+		cancel_delayed_work_sync(&drvdata->poll_work);
+		cancel_work_sync(&drvdata->battery_work);
+
+		spin_lock_irqsave(&drvdata->lock, flags);
+		ps = drvdata->battery;
+		drvdata->battery = NULL;
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+
+		if (ps)
+			power_supply_unregister(ps);
+	}
+}
+
+
+static const struct hid_device_id hyperx_headset_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP,
+			 USB_DEVICE_ID_HP_HYPERX_CLOUD_III_WIRELESS) },
+	{}
+};
+MODULE_DEVICE_TABLE(hid, hyperx_headset_devices);
+
+static struct hid_driver hyperx_headset_driver = {
+	.name = "hyperx-headset",
+	.id_table = hyperx_headset_devices,
+	.probe = hyperx_headset_probe,
+	.raw_event = hyperx_headset_raw_event,
+	.remove = hyperx_headset_remove,
+};
+module_hid_driver(hyperx_headset_driver);
+
+MODULE_AUTHOR("Sofia Schneider <sofia@schn.dev>");
+MODULE_DESCRIPTION("HID driver for HyperX headsets");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..aa2c3a71315b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -696,6 +696,7 @@
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0941	0x0941
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641	0x0641
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a	0x1f4a
+#define USB_DEVICE_ID_HP_HYPERX_CLOUD_III_WIRELESS 0x05b7
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
-- 
2.54.0

