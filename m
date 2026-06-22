Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3B243964
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782094707; cv=none; b=VS1X2/oR5Ktdjb5aB8mFts2mIXRb56/NMGOXd31FBAJSgFi30wtm50U9uDJTVRBAqzqkAx5ryxCw/dGM3pWs2Ik0xER2pvJK4+r6T9Ch/n+wtBMBk8t8QUg5SkhePaXn6KYzS/k0mxc026e6zCXj06341Dv9SC+ST67xDzumMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782094707; c=relaxed/simple;
	bh=2aIc81e7zgVCSGwg9BcYlkBhCHjD3SPNGgi5dsXX11w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CvTL/EgFQ+ct/yDZPeS0cx/xgeqVrOldHDv0bAV+JwjWQIV2QFRriHWasqQJMAed4OwFvy6NfBNZu8DHBnhTm/zmfBhtjGPpwki1i3O23of3TfL4W4aYIqNwsf8tTGJeUomWofUnRRGRkEpIsq2FmQCDZA2UquURFxMDiBnLg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schn.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schn.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a1fe8f578so12812481cf.2
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 19:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782094704; x=1782699504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNikyZm6mxu5CT1Yr4F1TS6t1pCrRSo57G6mvGwXs9Q=;
        b=iavg65+av/vcXqMKYV7X4nOHd7U66xjUOu27PVAK5e4Fwq/FbKU3wNet2lZdkLCb9l
         JNcLct986H7y3dbsQMg2tesqqg0gJtY2/CSgUO2KYytxhMHyIFVWvZSKuMtmovE0l/J4
         NGY34pBym7o0gfW4NgFzCQ7hnBEV/mszXzlNDq0WS4IwsUSkivt0JGt8u2ixTdIA6ejq
         48ULKnLMwEp/ylFKpPfbHh1pOBhh4db+/qyZMxvesruznqngW8yz88rZWcNsA3Q9Kb31
         oDxtNGzWppZA+whpv3tN3KV8Ug7n/hLNo/knc2Dc7/ONttEXYYKL8a1Rv4EveGPvnYvt
         0pPA==
X-Gm-Message-State: AOJu0YyBJpqTyPQrWAx3+JXsnIMiAxzTBF8TFngqmjBm+SzlaItb5/df
	bq/JcN92pCBpH+6Yf7eeTGEtIhW4x34lTqUnPvwr36rj0wKF0RcRX4pwXyaxuPprlZc=
X-Gm-Gg: AfdE7ck/V5g+KFgo91fwsYZYADnYE1EjBZJ7xpy3erzXrvTNT2uDnlioibjc/8l0NLY
	ccHE//baIVoxXi0gYnAQizlkWcO+lv8euXwP4uD/n3Dj92ppuPWEacq5WW1bf5Q2kZUBZN+t4lc
	BzsdRQOVSfWnOaKY8gyfHPEauh0IQcZt/FzWXTUUwVTEq5gLSz5kwTQlT518ee54tRWwD5NE7ax
	JA4IxXIKZoKk9Y7iV6kNtWJ1EtASfHmNlB8ebMmS0HzEa30pnJBAftKtaR6c7V66ZDS6iOa8xup
	66ag4NY0VDJBE+YoCAIG+AKuQEHizIMgQcNen76wNUqRMl+syeZCL2fZwRZt4V/RpQ49It3N2NW
	blXu0khkjZGgHysoai5FtP0WvVXXPlF8C5P8XyMRNE5hJ+f8j0yIrbLLDrMEAA6gGBWrpgbgImy
	NpAJnhZCjA/qLTFb5ZsohNWs963kSR0NlxikEmDAE5fHU=
X-Received: by 2002:a05:622a:13c8:b0:517:9003:e1a with SMTP id d75a77b69052e-519f02c07f1mr154163221cf.21.1782094703667;
        Sun, 21 Jun 2026 19:18:23 -0700 (PDT)
Received: from desktop-sofia ([2804:14d:ba4e:8353:8f7f:4b88:a059:f87e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f6fa32esm80863286d6.14.2026.06.21.19.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 19:18:22 -0700 (PDT)
From: Sofia Schneider <sofia@schn.dev>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sofia Schneider <sofia@schn.dev>
Subject: [PATCH] HID: hyperx-headset: Add support for HyperX headset devices
Date: Sun, 21 Jun 2026 23:17:24 -0300
Message-ID: <20260622021744.145340-1-sofia@schn.dev>
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
 MAINTAINERS                      |   6 +
 drivers/hid/Kconfig              |  11 +
 drivers/hid/Makefile             |   1 +
 drivers/hid/hid-hyperx-headset.c | 374 +++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h            |   1 +
 5 files changed, 393 insertions(+)
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
index 000000000000..18dc3e4f7e85
--- /dev/null
+++ b/drivers/hid/hid-hyperx-headset.c
@@ -0,0 +1,374 @@
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
+static const struct power_supply_desc hyperx_headset_battery_desc = {
+	.name = "hyperx_headset_battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = hyperx_headset_battery_props,
+	.num_properties = ARRAY_SIZE(hyperx_headset_battery_props),
+	.get_property = hyperx_headset_battery_get_property,
+};
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
+					   &hyperx_headset_battery_desc,
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
+
+	if (drvdata) {
+		cancel_delayed_work_sync(&drvdata->poll_work);
+		cancel_work_sync(&drvdata->battery_work);
+
+		if (drvdata->battery) {
+			power_supply_unregister(drvdata->battery);
+			drvdata->battery = NULL;
+		}
+	}
+
+	hid_hw_stop(hdev);
+}
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

