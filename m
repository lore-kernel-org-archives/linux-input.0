Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8D3624C3
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687849; cv=none; b=tWj/PU6yo3cveYHybS1vrKwPPI+vI2G22HcCujLhFeI2J96lXoQybiCTR8l4jDwPIj5OUCquTlSsDdDpK7MV27yuaE8vsZgqD3P59xHFaTiHkQ9mxVMc0VFPj+hyDjsL3tqGrZvQyY44tQK9OcmKkiFVWsMYIu5LMdoiDpMDX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687849; c=relaxed/simple;
	bh=DMwPN3HNM6kfnzLBtDb4muG7mdOQoLQzzcbPx1WmHak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dd6aLRwBJl6ioKiUZpCmH/QRA5v7nIw93B6alDgptXznTA/g1+MUIJKnJ3LpBIEcSGgXnaTU8VJLf89nJcDbVKbmfVeAQWnH26ep8V2W/vYdsmI8ewY/uUd7IalCVCnvEHo2fliAOAe+VPopHLxvzhN2RmuChMUMFs8Cl1XQ9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve69/SN6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve69/SN6"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8be236ce888so55115706d6.3
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778687846; x=1779292646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+N3WEXRQ4+atINl60qg7BEi4CsrKsvuVXcErxgsSP5A=;
        b=Ve69/SN6IcCAHyTWDkv8/k/STYmNaYkiOsEz5OzojIGF4suO4Q9F7rPG2zxEZLzsOn
         s2V+I3yGmgZIZ/4mgDkY6MEqsuTII0hS3/OrBafOiL9ObLY6hyWmywoe86az/22RZegv
         ezPUMjbv4Tjw4gNvr67p45NahQm8Hz8OUgVZuhviypP4w5AVjJACE/OYRoJmS1BcjXMJ
         dVAPMK+YtzR2GTsKbeyWx1Z23qGiTN+LW0OnrVNrl01G3bHXhvv/2Rj4nKGvPCyBlEoz
         sa9NG3gru0j7Nq3Fq2ftwL4MHxDxb2ikOgbvM/McquSF4BsfwpA+V5tUNL7OmpM46Iuy
         9ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778687846; x=1779292646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N3WEXRQ4+atINl60qg7BEi4CsrKsvuVXcErxgsSP5A=;
        b=ZXob3hUqk6FmfzrQOwEezVT30vyncQ4J6mKiK7roCttd7CjvBhZJwgfggsO4pHwfby
         dv4MS5kKCBaF5v7dIkmhlup34t5I7mj5OjPayr0Trh8a6+yHHsz+FxI5ULrENgn+6Jpb
         IzxJt9eWNb9TZIt2iXqdLUj3Y4p5bV6aealWos73s5yCyBZfrmj8dvXbp1eJ+uLPukmF
         zoJn+GzhDy5K+P/Qes/4mNdzQPCbLFmCluz2YJ8IFs/sAIQtxC7++44T+Ix+OWxSOHcL
         +RhvLNnEz0hHa3XccMXNnd45G2q6AERFsPeBgKH48g8+tGPaMT0hlXUL5OIZ4JftBDhE
         7Rgw==
X-Forwarded-Encrypted: i=1; AFNElJ//WolTQqADPAGbcq0QxqALajwqfp9zVcR4LNRseZ+uW6fJOyyH4qBPYh7fdpyTWEv1hjT/aL0lY3Pe/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsf5j+KK+iiQFBPR0uVrvKROCuHnJhPtSHzmmIk7EuPA+Tj41
	Fkh+T2pZ6mNl7qQPx2nHao0gjab/SnhsBcLZkcUcDMmo9gyke5gmXexd8YzdIKYv
X-Gm-Gg: Acq92OG3Dezis0u1Ae94RtwnrSi7u2IBZExv6tQ2533JZpypBP1Yc5CIqoLh7RAUsws
	zJq8i3Vseac06Ifwabhj5o6+hHIetVewPo2TfthxmpQR1rbqKLZJVqRKmwh/IQU1KzWZ4uJBQvN
	uR+Zcrby1/VM41y1b8/858fpbS9x7wnOssGidgtDXsg6PMo6g65fqzMx4DlIFCQvfJpKFoFNzp8
	orv4fjLPff5pv8oR9MEgAx5uqmYgdfcqn/dUNy4NpjMyom4ADQ4nxkHdfKGnaS6ACH4++kyKD9p
	yya4NMwZ1/hoZ+ya6QCXFjYnpzjSbpn5+VI5mlNcclxTzZVgTekEEeeX69NgcMbE9s29+AU+Lxp
	W2E2S++5J4A8muuxuxFX/MNLxaGKP5b5Qvxi4BPudsPv3lz5NQlkffky+KKzukTXLnadaYe2/mU
	pkTS1z7m0XfE4bcG+mcRIIFAwch6KCr70HDm50iGzSHgGzMTe8nZ7Nh+ueJECp77429pFrRPe/X
	lCDv+lUzn8gJg==
X-Received: by 2002:a05:6214:4291:b0:8b5:6654:7556 with SMTP id 6a1803df08f44-8c7bc05c18dmr65580966d6.42.1778687845749;
        Wed, 13 May 2026 08:57:25 -0700 (PDT)
Received: from cachyos-laptop.carrollcc.edu (fw.carrollcc.edu. [167.102.159.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3b0c7600sm157454596d6.1.2026.05.13.08.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:57:25 -0700 (PDT)
From: Andrew Maney <andrewmaney05@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Andrew Maney <andrewmaney05@gmail.com>
Subject: [PATCH] HID: Expose LattePanda IOTA UPS as a power_supply device
Date: Wed, 13 May 2026 11:57:22 -0400
Message-ID: <20260513155723.230707-1-andrewmaney05@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver exposes the DFRobot LattePanda IOTA UPS board as a standard
power_supply device, allowing desktop environments and power management
tools such as UPower and systemd-logind to display battery status,
remaining capacity, and charging status without any special
configuration. It also enables automatic suspend or shutdown on low
battery and power profile configuration via any tool that supports the
standard power_supply interface.

The UPS presents itself as an Arduino Leonardo HID device running custom
firmware (VID 0x2341, PID 0x8036). It reports status and capacity via
HID reports 0x07 and 0x0C respectively.

The charge limit (80% or 100%) is configured via a physical DIP switch
on the UPS board and cannot be detected automatically. Userspace can
inform the driver of the configured limit via
charge_control_end_threshold.

Known issue: the driver occasionally reports 0% capacity briefly on
initial load before the first valid HID report is received. I am
investigating the cause.

Signed-off-by: Andrew Maney <andrewmaney05@gmail.com>

---

Changes in v2:
- Rebased on top of the current tree
- Moved vendor and device IDs to drivers/hid/hid-ids.h
- Added Kconfig entry under HID bus support -> Special HID drivers
- Added build rule to drivers/hid/Makefile
---
 MAINTAINERS                           |   6 +
 drivers/hid/Kconfig                   |  10 +
 drivers/hid/Makefile                  |   1 +
 drivers/hid/hid-ids.h                 |   3 +
 drivers/hid/hid-lattepanda-iota-ups.c | 354 ++++++++++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 drivers/hid/hid-lattepanda-iota-ups.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a..fd2947a80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11410,6 +11410,12 @@ F:	include/uapi/linux/hid*
 F:	samples/hid/
 F:	tools/testing/selftests/hid/
 
+HID LATTEPANDA IOTA UPS DRIVER
+M:	Andrew Maney <andrewmaney05@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-lattepanda-iota-ups.c
+
 HID LOGITECH DRIVERS
 R:	Filipe Laíns <lains@riseup.net>
 L:	linux-input@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index ff2f580b6..3c1efef3d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -105,6 +105,16 @@ config HID_HAPTIC
 
 menu "Special HID drivers"
 
+config HID_LATTEPANDA_IOTA_UPS
+	tristate "LattePanda IOTA UPS"
+	depends on USB_HID && X86
+	help
+	Support for the LattePanda IOTA UPS (DFRobot, VID 0x2341 PID 0x8036).
+	Exposes the battery status and capacity via the power_supply interface.
+
+	To compile as a module, choose M here: the module will be
+	called hid-lattepanda-iota-ups.
+
 config HID_A4TECH
 	tristate "A4TECH mice"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 0597fd6a4..7ba44223c 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -24,6 +24,7 @@ hid-logitech-$(CONFIG_LOGIWHEELS_FF)	+= hid-lg4ff.o
 hid-wiimote-y		:= hid-wiimote-core.o hid-wiimote-modules.o
 hid-wiimote-$(CONFIG_DEBUG_FS)	+= hid-wiimote-debug.o
 
+obj-$(CONFIG_HID_LATTEPANDA_IOTA_UPS)	+= hid-lattepanda-iota-ups.o
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
 obj-$(CONFIG_HID_ACCUTOUCH)	+= hid-accutouch.o
 obj-$(CONFIG_HID_ALPS)		+= hid-alps.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf637423..3b69b072c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -25,6 +25,9 @@
 #define USB_VENDOR_ID_8BITDO		0x2dc8
 #define USB_DEVICE_ID_8BITDO_PRO_3	0x6009
 
+#define USB_VENDOR_ID_LATTEPANDA_IOTA	0x2341
+#define USB_DEVICE_ID_LATTEPANDA_IOTA_UPS	0x8036
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff --git a/drivers/hid/hid-lattepanda-iota-ups.c b/drivers/hid/hid-lattepanda-iota-ups.c
new file mode 100644
index 000000000..cb0c2a6f3
--- /dev/null
+++ b/drivers/hid/hid-lattepanda-iota-ups.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/completion.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/spinlock.h>
+#include <linux/usb.h>
+#include "hid-ids.h"
+
+#define REPORT_ID_STATUS	0x07
+#define REPORT_ID_CAPACITY	0x0C
+
+#define STATUS_PLUGGED_IN	BIT(0)
+#define STATUS_DISCHARGING	BIT(1)
+#define STATUS_CHARGING		BIT(2)
+
+MODULE_AUTHOR("Andrew Maney");
+MODULE_DESCRIPTION("LattePanda IOTA UPS power supply driver");
+MODULE_LICENSE("GPL");
+
+struct iota_ups {
+	struct hid_device		*hiddev;
+	struct power_supply		*psu;
+	struct power_supply_desc	 psu_desc;
+	spinlock_t			 lock; /* Protects all cached HID report values */
+
+	/* Cached values updated from HID reports */
+	char	serial[64];
+	bool	plugged_in;
+	int	psu_status;
+	int	capacity;
+	int	charge_limit;
+
+	/*
+	 * Wait for both status and capacity reports before registering
+	 * with the power_supply core, so initial values are correct.
+	 */
+	struct completion	got_initial_data;
+	bool			data_ready;
+	bool			got_status;
+	bool			got_capacity;
+};
+
+static enum power_supply_property iota_ups_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
+static const struct hid_device_id iota_ups_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LATTEPANDA_IOTA,
+			USB_DEVICE_ID_LATTEPANDA_IOTA_UPS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, iota_ups_devices);
+
+static int iota_ups_get_property(struct power_supply *supply,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val)
+{
+	struct iota_ups *ups = power_supply_get_drvdata(supply);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ups->lock, flags);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = ups->psu_status;
+		break;
+	/* Remaining capacity as a percentage, 0-100 */
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = ups->capacity;
+		break;
+	/* Always present if the driver is loaded */
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	/* Whether mains power is connected */
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ups->plugged_in ? 1 : 0;
+		break;
+	/* System-level UPS, not a laptop battery */
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+	/* V1.0 only accepts 18650 Li-ion cells */
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	/* 80% or 100%, configured via DIP switch on the board */
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		val->intval = ups->charge_limit;
+		break;
+	/* V1.0 does not report capacity level via HID */
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
+	/* V1.0 does not report time remaining */
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
+		val->intval = 0;
+		break;
+	/* V1.0 does not report health; assume good */
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	/* 3.7V in microvolts, typical Li-ion resting voltage */
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = 3700000;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "DFRobot";
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "LattePanda IOTA UPS";
+		break;
+	/* Retrieved from the USB descriptor */
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = ups->serial;
+		break;
+	default:
+		spin_unlock_irqrestore(&ups->lock, flags);
+		return -EINVAL;
+	}
+
+	spin_unlock_irqrestore(&ups->lock, flags);
+	return 0;
+}
+
+static int iota_ups_set_property(struct power_supply *supply,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	struct iota_ups *ups = power_supply_get_drvdata(supply);
+
+	if (psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD) {
+		/*
+		 * V1.0 supports 80% and 100% charge limits only, set via
+		 * DIP switch on the board. This property allows userspace
+		 * to inform the driver which limit is configured.
+		 */
+		if (val->intval != 80 && val->intval != 100)
+			return -EINVAL;
+		ups->charge_limit = val->intval;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int iota_ups_property_is_writable(struct power_supply *supply,
+					 enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD;
+}
+
+static int iota_ups_raw_event(struct hid_device *hdev,
+			      struct hid_report *report,
+			      u8 *data, int size)
+{
+	struct iota_ups *ups = hid_get_drvdata(hdev);
+	unsigned long flags;
+	bool changed = false;
+
+	/* All UPS reports are at least 2 bytes */
+	if (size < 2)
+		return 0;
+
+	spin_lock_irqsave(&ups->lock, flags);
+
+	switch (data[0]) {
+	case REPORT_ID_STATUS: {
+		u8 status = data[1];
+		int new_status;
+		bool plugged_in = !!(status & STATUS_PLUGGED_IN);
+
+		if (status & STATUS_CHARGING) {
+			if (ups->capacity >= ups->charge_limit)
+				new_status = POWER_SUPPLY_STATUS_FULL;
+			else
+				new_status = POWER_SUPPLY_STATUS_CHARGING;
+		} else if (status & STATUS_DISCHARGING) {
+			new_status = POWER_SUPPLY_STATUS_DISCHARGING;
+		} else if (plugged_in) {
+			new_status = POWER_SUPPLY_STATUS_FULL;
+		} else {
+			new_status = POWER_SUPPLY_STATUS_UNKNOWN;
+		}
+
+		if (new_status != ups->psu_status ||
+		    plugged_in != ups->plugged_in) {
+			ups->plugged_in = plugged_in;
+			ups->psu_status = new_status;
+			changed = true;
+		}
+
+		ups->got_status = true;
+		break;
+	}
+	case REPORT_ID_CAPACITY: {
+		int new_cap = clamp((int)data[1], 0, 100);
+
+		if (new_cap != ups->capacity) {
+			ups->capacity = new_cap;
+			changed = true;
+		}
+
+		ups->got_capacity = true;
+		break;
+	}
+	}
+
+	/*
+	 * Signal ready only once both status and capacity have been
+	 * received, so the power_supply is registered with valid data.
+	 */
+	if (!ups->data_ready && ups->got_status && ups->got_capacity) {
+		ups->data_ready = true;
+		complete(&ups->got_initial_data);
+	}
+
+	spin_unlock_irqrestore(&ups->lock, flags);
+
+	/*
+	 * Notify the power_supply core outside the spinlock. This
+	 * triggers UPower's PropertiesChanged signal with the new values.
+	 */
+	if (changed && ups->psu)
+		power_supply_changed(ups->psu);
+
+	return 0;
+}
+
+static int iota_ups_probe(struct hid_device *hdev,
+			  const struct hid_device_id *id)
+{
+	struct power_supply_config psu_config = {};
+	struct usb_device *udev;
+	struct iota_ups *ups;
+	int ret;
+
+	ups = devm_kzalloc(&hdev->dev, sizeof(*ups), GFP_KERNEL);
+	if (!ups)
+		return -ENOMEM;
+
+	ups->hiddev		= hdev;
+	ups->psu_status		= POWER_SUPPLY_STATUS_UNKNOWN;
+	ups->capacity		= 50;
+	/*
+	 * Default to 100% — the DIP switch may be set to 80% but there
+	 * is no way to detect this automatically from HID reports.
+	 * Userspace can update this via charge_control_end_threshold.
+	 */
+	ups->charge_limit	= 100;
+	ups->data_ready		= false;
+	ups->got_status		= false;
+	ups->got_capacity	= false;
+
+	init_completion(&ups->got_initial_data);
+	spin_lock_init(&ups->lock);
+	hid_set_drvdata(hdev, ups);
+
+	/* Retrieve serial number from the USB descriptor */
+	udev = to_usb_device(hdev->dev.parent->parent);
+	if (udev->serial)
+		strscpy(ups->serial, udev->serial, sizeof(ups->serial));
+	else
+		strscpy(ups->serial, "Unknown", sizeof(ups->serial));
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "HID parse failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret) {
+		hid_err(hdev, "HID hw start failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "HID hw open failed: %d\n", ret);
+		goto err_stop;
+	}
+
+	/*
+	 * Wait for both status and capacity reports before registering.
+	 * The device sends reports every ~1 second; 3 seconds is safe.
+	 */
+	wait_for_completion_timeout(&ups->got_initial_data,
+				    msecs_to_jiffies(3000));
+
+	ups->psu_desc.name			= "lattepanda-iota-ups";
+	ups->psu_desc.type			= POWER_SUPPLY_TYPE_BATTERY;
+	ups->psu_desc.properties		= iota_ups_properties;
+	ups->psu_desc.num_properties		= ARRAY_SIZE(iota_ups_properties);
+	ups->psu_desc.get_property		= iota_ups_get_property;
+	ups->psu_desc.set_property		= iota_ups_set_property;
+	ups->psu_desc.property_is_writeable	= iota_ups_property_is_writable;
+	psu_config.drv_data = ups;
+
+	ups->psu = devm_power_supply_register(&hdev->dev,
+					      &ups->psu_desc,
+					      &psu_config);
+	if (IS_ERR(ups->psu)) {
+		ret = PTR_ERR(ups->psu);
+		hid_err(hdev, "power_supply register failed: %d\n", ret);
+		goto err_close;
+	}
+
+	/*
+	 * Force an immediate notification so UPower reads the correct
+	 * initial state right after registration.
+	 */
+	power_supply_changed(ups->psu);
+
+	hid_info(hdev, "LattePanda IOTA UPS registered as power supply\n");
+	return 0;
+
+err_close:
+	hid_hw_close(hdev);
+err_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void iota_ups_remove(struct hid_device *hdev)
+{
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static struct hid_driver iota_ups_driver = {
+	.name		= "lattepanda-iota-ups",
+	.id_table	= iota_ups_devices,
+	.probe		= iota_ups_probe,
+	.remove		= iota_ups_remove,
+	.raw_event	= iota_ups_raw_event,
+};
+module_hid_driver(iota_ups_driver);
-- 
2.54.0

