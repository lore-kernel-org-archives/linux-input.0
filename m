Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703653;
	b=gtDL73m/qjBjQff/SlipbJ8wkx81Imz9rKMZOS187yRC2cevCbfz5yHVBiimMO2wP/Rc
	 6N2wRJulpLIMOYF7Dcst3z1eUBgQn0WSVGnsW/5paK5IlT3xR0Z83v5BRveIOgbSqBjqW
	 RoQYNC7d9yRdxeMlct92VuCDrNKfk0SUTBh+bFKv8iShJAITqM9wF1PcXWnO7qOhjzy2C
	 Mxep4z6AaCFKNeGBSLFanj1qOzKR2hoUiZRnQk0zcOAPZfhcsKRCg8NApWqgHGt/5P5Vj
	 GZ2+GlMt/MC7BSToLAv/R2A3beTfunoZiPV+5w2vFt6WP4SF6qjvP82feZI4WC30EyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703653;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cgo/eFeOUtGkQiQq30zeOwFtMaZ/aEMkuLlwbVhgkKU=;
	b=0cuFUCQPAPIkAHN//syrQ1LORUbPrCUB7Vo477WQE1Zb+3zKHKb3USUYOw+vvQdEWyfW
	 SzKYv85PcjZw8vfm8Eju8NYNWVFvVC/E2DxkeJd17BJ0TTYs5KnvCebkdUSagx8JyiXs+
	 mD0bMsBOYSXCtT5RUwCds2f8FNbrWZ2P79D+I4qD9f6wTRoHI5iTPph7pJGbxcr2hZH+0
	 PKrIdrZaNE4dhU7AHaLAoG0x6/V7DBhAPI8vPeMixTTTsSytvn8oJAIgFRVWJilCMcGLr
	 j5/1O1VYVBg3sP1YodOdP00PfN5Ddcf/PjgRlrtB7yzvgVcyVVYTy+6Gilfs8kvLzyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=schn.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61189606A31F
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 21:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61189606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=schn.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso138320e0c.0
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 14:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792703651; x=1793308451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgo/eFeOUtGkQiQq30zeOwFtMaZ/aEMkuLlwbVhgkKU=;
        b=bOaXQLEHW14s6tERojEvHNpnulRgNAIEOaWbVlqaryCF1bEYX7+TBbEnSA57Vf2GqX
         H87YPWgA9VrU2+k2nqpIpb/46SImImN+g2AjtRV44+ojVdmdt7LaClJBVSlEtV/rjeuz
         RC2hfplBkhIpj49BF9DChsyQcHf1Lwtnzupx8G/Wvq04RWpyxAhiIiij11KLDi/t6uYA
         le66P9FxbF4iWyqyl/LKEstkw5mMsxGeJFJrYcw6KXEs3iNml3Krp/CbxIdke24yfOwe
         INr5JXtc99hM5Ikf36aZs63RUrQoxptRIyR+O7KQ5/vRL0FhtVsr/pv2r3Tkl/ZTo5L4
         6tgQ==
X-Gm-Message-State: AFq9FYKCxH5ifWoRIYF83PQy2Skja3opTQ7t8bqM0w8i2DzdQaO3KL3T
	D/e2hXsEyd0XZ6k6mC9oxB/LoeAFxMXjrBgW1X8yPSVNPp4CEfpNwUHV4t3Y+0jH
X-Gm-Gg: AYBFou1qK/15MSinkRo0l+lJRVOXdp6ihVktuaRVDSoxBUSnTvYhUTfYICXm83eKTvC
	GvS1NXX7duLn07yTstHsV2TJXwEXErSe24sGO6UnIK0G5t7iLce2/h0fEprR3KBS9Y+dQNraiOn
	JCRmA/eVxPICTw0U8Mje/DqHpjaSTPzJ6qQV/v9Eksen2av7xyrquWSFq/qYPFa9gdu/L+gxw8B
	pdEZG898i1J54CXWPDrJ9NdhnEgbJpFHs5aOZYaZj4lYJVmTWZf/l88Cz48sbqMiwGGno4eZh3w
	nseXLV/wSQkoIRVChInfpHGjogRAZYK7l0zm9i3mopmUQxuMxfkMP8JKrAzWUWgjM5gnNrPvuCS
	rZk3gNfUev7DSGa0EmeqjzlbwST/TZWu8OvgC+9Gi/k1KwfulxsubGVQd17GxRm1/OIppr8aavm
	sHM+PrUZmF7bZDLCIEIVetvwxOFxyMjHFq6x2YnWlxm9G5x1qrv63DB5hl+toF8Y+v/cfL5IBjA
	DAqvx/yMjCtrnnCb88bqR+tS/iRs52p+79jhRHRGse09VR+fpOrZJY0TS5pXyVVMDMNbnsWDe5Z
	KMB8Lpo/xw==
X-Received: by 2002:a05:6122:8b0f:b0:5ea:f220:fd6e with SMTP id 71dfb90a1353d-5ec14a7591fmr39451e0c.11.1792703651172;
        Thu, 22 Oct 2026 14:14:11 -0700 (PDT)
Received: from desktop-sofia ([2804:14d:ba4e:8353:8f7f:4b88:a059:f87e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13f2cfe0sm308493e0c.14.2026.10.22.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:14:10 -0700 (PDT)
From: Sofia Schneider <sofia@schn.dev>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sofia Schneider <sofia@schn.dev>
Subject: [PATCH v6] HID: hp: Add support for HyperX headset devices
Date: Thu, 22 Oct 2026 18:13:57 -0300
Message-ID: <20261022211357.223232-1-sofia@schn.dev>
X-Mailer: git-send-email 2.56.0
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

Introduce a HID driver for HyperX Cloud III Wireless headsets,
supporting battery reporting and connection status.

Tested with a HyperX Cloud III Wireless only, for lack of
other testable devices.

Signed-off-by: Sofia Schneider <sofia@schn.dev>
---
v5 -> v6:
- Initialize USB wireless_status to disconnected in hp_probe() so the sysfs attribute is exposed when the headset is off at boot.
- Call power_supply_changed() after registering the battery in hp_headset_battery_work() in case battery events arrived during registration.
- Document that the headset firmware automatically sends unsolicited battery and charging reports upon connection.

v4 -> v5:
- Rebase onto current hid/for-next to resolve merge conflicts in MAINTAINERS, Kconfig, and Makefile.
- Call hid_hw_open() in probe() and hid_hw_close() in remove() to ensure raw events are received.
- Cancel poll_work before stopping hardware in remove().
- Read drvdata->battery under spinlock in hp_headset_battery_work().
- Explicitly include all required headers.
- Minor style fixes.

v3 -> v4:
- Rename driver to hid-hp.

v2 -> v3:
- Unregister power supply on hid_hw_start() failure in probe() to prevent UAF/resource leak.

v1 -> v2:
- Call hid_hw_stop() before cancelling work queues in remove() to prevent UAF.
- Safe unregistration of power supply using the spinlock in remove() to prevent race conditions.
- Cancel battery_work in the hid_hw_start() error path in probe() to prevent UAF.
- Dynamically allocate power supply names to avoid sysfs naming collisions.

v1: https://lore.kernel.org/linux-input/20260622022800.D01D51F000E9@smtp.kernel.org/T/
v2: https://lore.kernel.org/linux-input/20260627204840.2DD671F000E9@smtp.kernel.org/T/
v3: https://lore.kernel.org/linux-input/20260627210206.1061062-1-sofia@schn.dev/T/
v4: https://lore.kernel.org/linux-input/20260804032337.315750-1-sofia@schn.dev/
v5: https://lore.kernel.org/linux-input/20261021183205.13866-1-sofia@schn.dev/

 MAINTAINERS           |   6 +
 drivers/hid/Kconfig   |  11 ++
 drivers/hid/Makefile  |   1 +
 drivers/hid/hid-hp.c  | 407 ++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-ids.h |   1 +
 5 files changed, 426 insertions(+)
 create mode 100644 drivers/hid/hid-hp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c7ccc417cf43..4cd885e61731 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11610,6 +11610,12 @@ F:	include/uapi/linux/hid*
 F:	samples/hid/
 F:	tools/testing/selftests/hid/
 
+HID HP DRIVER
+M:	Sofia Schneider <sofia@schn.dev>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-hp.c
+
 HID HYPERX DRIVER
 M:	Benjamin Blume <benjaminblume@posteo.de>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..6c0f37f23b0f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1252,6 +1252,17 @@ config GREENASIA_FF
 	(like MANTA Warrior MM816 and SpeedLink Strike2 SL-6635) or adapter
 	and want to enable force feedback support for it.
 
+config HID_HP
+	tristate "HP HID devices"
+	depends on USB_HID
+	select POWER_SUPPLY
+	help
+	  Support for HP HID devices, including HyperX headsets.
+
+	  Say Y here if you would like to enable support for HP HID devices.
+	  To compile this driver as a module, choose M here: the module will be called
+	  hid-hp.
+
 config HID_HYPERV_MOUSE
 	tristate "Microsoft Hyper-V mouse driver"
 	depends on HYPERV_VMBUS
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 43a8eb0f389b..10e6542303e9 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_HID_GYRATION)	+= hid-gyration.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-kbd.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtek-mouse.o
 obj-$(CONFIG_HID_HOLTEK)	+= hid-holtekff.o
+obj-$(CONFIG_HID_HP)		+= hid-hp.o
 obj-$(CONFIG_HID_HYPERV_MOUSE)	+= hid-hyperv.o
 obj-$(CONFIG_HID_HYPERX)	+= hid-hyperx.o
 obj-$(CONFIG_HID_ICADE)		+= hid-icade.o
diff --git a/drivers/hid/hid-hp.c b/drivers/hid/hid-hp.c
new file mode 100644
index 000000000000..723e4bbf9f29
--- /dev/null
+++ b/drivers/hid/hid-hp.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  HID driver for HP devices
+ *
+ *  Supports HyperX Cloud III Wireless headsets.
+ *
+ *  Copyright (c) 2026 Sofia Schneider
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
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
+
+struct hp_headset_device {
+	struct hid_device *hdev;
+	struct power_supply *battery;
+	struct power_supply_desc battery_desc;
+
+	/* Protects battery, battery_level, is_charging, and is_connected */
+	spinlock_t lock;
+	u8 battery_level;
+	bool is_charging;
+	bool is_connected;
+
+	struct delayed_work poll_work;
+	struct work_struct battery_work;
+};
+
+static const enum power_supply_property hp_headset_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int hp_headset_battery_get_property(struct power_supply *psy, enum power_supply_property psp,
+					   union power_supply_propval *val)
+{
+	struct hp_headset_device *drvdata = power_supply_get_drvdata(psy);
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
+		while (str_has_prefix(val->strval, HYPERX_PREFIX))
+			val->strval += strlen(HYPERX_PREFIX);
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
+static int hp_headset_send_command(struct hp_headset_device *drvdata, u8 command)
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
+	ret = hid_hw_raw_request(hdev, HYPERX_REPORT_ID, buf, HYPERX_PACKET_SIZE, HID_OUTPUT_REPORT,
+				 HID_REQ_SET_REPORT);
+
+	if (ret < 0)
+		hid_err(hdev, "hw_raw_request failed (command 0x%02x)\n", command);
+
+	kfree(buf);
+	return ret;
+}
+
+static void hp_headset_poll_work(struct work_struct *work)
+{
+	struct hp_headset_device *drvdata =
+		container_of(work, struct hp_headset_device, poll_work.work);
+
+	hp_headset_send_command(drvdata, HYPERX_CMD_GET_CONNECTED);
+	hp_headset_send_command(drvdata, HYPERX_CMD_GET_BATTERY);
+	hp_headset_send_command(drvdata, HYPERX_CMD_GET_CHARGING);
+
+	schedule_delayed_work(&drvdata->poll_work, msecs_to_jiffies(HYPERX_POLL_INTERVAL_MS));
+}
+
+static void hp_headset_set_wireless_status(struct hid_device *hdev, bool connected)
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
+static void hp_headset_battery_work(struct work_struct *work)
+{
+	struct hp_headset_device *drvdata =
+		container_of(work, struct hp_headset_device, battery_work);
+	struct power_supply_config battery_cfg = { .drv_data = drvdata };
+	struct power_supply *ps;
+	unsigned long flags;
+	bool connected;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	connected = drvdata->is_connected;
+	ps = drvdata->battery;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	hp_headset_set_wireless_status(drvdata->hdev, connected);
+
+	if (connected && !ps) {
+		ps = power_supply_register(&drvdata->hdev->dev,
+					   &drvdata->battery_desc,
+					   &battery_cfg);
+		if (IS_ERR(ps)) {
+			hid_err(drvdata->hdev, "power_supply_register failed\n");
+			return;
+		}
+
+		power_supply_powers(ps, &drvdata->hdev->dev);
+
+		spin_lock_irqsave(&drvdata->lock, flags);
+		drvdata->battery = ps;
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+
+		power_supply_changed(ps);
+	} else if (!connected && ps) {
+		spin_lock_irqsave(&drvdata->lock, flags);
+		drvdata->battery = NULL;
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+
+		power_supply_unregister(ps);
+	}
+}
+
+static void
+hp_headset_parse_battery_event(struct hp_headset_device *drvdata, u8 *data)
+{
+	unsigned long flags;
+	u8 state1 = data[2];
+	u8 state2 = data[3];
+	u8 level = data[4];
+
+	/* Battery event is invalid if both states are 0 */
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
+hp_headset_parse_charging_event(struct hp_headset_device *drvdata, u8 *data)
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
+hp_headset_parse_connected_event(struct hp_headset_device *drvdata, u8 *data)
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
+	/*
+	 * When the headset powers on and connects, the firmware automatically
+	 * sends unsolicited battery (0x0D) and charging (0x0C) reports right
+	 * after the connection report, so no explicit poll is needed here.
+	 */
+	if (state_changed)
+		schedule_work(&drvdata->battery_work);
+}
+
+static int hp_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct hp_headset_device *drvdata;
+	struct power_supply *ps;
+	unsigned long flags;
+	int ret;
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	drvdata->hdev = hdev;
+	drvdata->is_connected = false;
+	drvdata->is_charging = false;
+	drvdata->battery_level = 100;
+	spin_lock_init(&drvdata->lock);
+	hid_set_drvdata(hdev, drvdata);
+
+	drvdata->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	drvdata->battery_desc.properties = hp_headset_battery_props;
+	drvdata->battery_desc.num_properties = ARRAY_SIZE(hp_headset_battery_props);
+	drvdata->battery_desc.get_property = hp_headset_battery_get_property;
+	drvdata->battery_desc.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						    "hp_headset_battery_%s",
+						    strlen(hdev->uniq) ?
+						    hdev->uniq : dev_name(&hdev->dev));
+	if (!drvdata->battery_desc.name)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&drvdata->poll_work, hp_headset_poll_work);
+	INIT_WORK(&drvdata->battery_work, hp_headset_battery_work);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	hp_headset_set_wireless_status(hdev, false);
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw_start failed\n");
+		goto err_cleanup_battery;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "hw_open failed\n");
+		goto err_stop_hw;
+	}
+
+	schedule_delayed_work(&drvdata->poll_work, 0);
+
+	return 0;
+
+err_stop_hw:
+	hid_hw_stop(hdev);
+err_cleanup_battery:
+	cancel_work_sync(&drvdata->battery_work);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	ps = drvdata->battery;
+	drvdata->battery = NULL;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	if (ps)
+		power_supply_unregister(ps);
+
+	return ret;
+}
+
+static int hp_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
+{
+	struct hp_headset_device *drvdata = hid_get_drvdata(hdev);
+
+	if (size < 5 || data[0] != HYPERX_REPORT_ID)
+		return 0;
+
+	switch (data[1]) {
+	case HYPERX_CMD_GET_CONNECTED:
+	case HYPERX_RESP_CONNECTED:
+		hp_headset_parse_connected_event(drvdata, data);
+		break;
+
+	case HYPERX_CMD_GET_BATTERY:
+	case HYPERX_RESP_BATTERY:
+		hp_headset_parse_battery_event(drvdata, data);
+		break;
+
+	case HYPERX_CMD_GET_CHARGING:
+	case HYPERX_RESP_CHARGING:
+		hp_headset_parse_charging_event(drvdata, data);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void hp_remove(struct hid_device *hdev)
+{
+	struct hp_headset_device *drvdata = hid_get_drvdata(hdev);
+	struct power_supply *ps;
+	unsigned long flags;
+
+	cancel_delayed_work_sync(&drvdata->poll_work);
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+
+	cancel_work_sync(&drvdata->battery_work);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	ps = drvdata->battery;
+	drvdata->battery = NULL;
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	if (ps)
+		power_supply_unregister(ps);
+}
+
+static const struct hid_device_id hp_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_DEVICE_ID_HP_HYPERX_CLOUD_III_WIRELESS) },
+	{}
+};
+MODULE_DEVICE_TABLE(hid, hp_devices);
+
+static struct hid_driver hp_driver = {
+	.name = "hp",
+	.id_table = hp_devices,
+	.probe = hp_probe,
+	.raw_event = hp_raw_event,
+	.remove = hp_remove,
+};
+module_hid_driver(hp_driver);
+
+MODULE_AUTHOR("Sofia Schneider <sofia@schn.dev>");
+MODULE_DESCRIPTION("HP HID driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa6516d..1f6782b3edc6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -710,6 +710,7 @@
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0941	0x0941
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641	0x0641
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a	0x1f4a
+#define USB_DEVICE_ID_HP_HYPERX_CLOUD_III_WIRELESS              0x05b7
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
-- 
2.56.0

