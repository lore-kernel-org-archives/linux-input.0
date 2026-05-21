Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E54359A8B
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333515; cv=none; b=RLyNj/5qXytANjxs1Ts8rqLOSLj1MuSeanLqkV1Aoq6FQwh7affqdid0YmMg4wbqqhCflGc4n7G6bmq024WOReX4TwTtOD/i1ySw4/sT+gTVmfSRNmN5qO0JD4jAUsVln7AhZx3yB1sbA+7XyQfBfqPerQxvZJnzTVZnzYBfSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333515; c=relaxed/simple;
	bh=HBvSBO0cCQPkWP7XA0Kq7QPnVUClww0Nu2pKEg3ovzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBlqrV818j9DaX9j3eEWLFLVDhKBjmwwGXLoMZBMzR1HV0XY2KatK/JqpkpuHqxFc/LrFmVT8fE7oYXjZGfaZYOJPbMm0f7gDojBWjBXCcvm/cIxfEiR4Ynj/hPwq5Vkb7Cnlo8+R9JOs6PvzVv2RDQL1FGPw49FpOTA6foiZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9cw1wcd; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9cw1wcd"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5148cbdea08so47018531cf.2
        for <linux-input@vger.kernel.org>; Wed, 20 May 2026 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779333511; x=1779938311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ84OHIHfCgj+D30o4E16wAWmdnY02uHCwSANOs1Sqw=;
        b=m9cw1wcdKCvvF5YjYO2hUclZIviS8PeJ4ppI4bL89rmzxMpWAvEqkdDOr8VI4+ZS63
         aTy5KqSRu8QRFRdc/Dg+LUGZ0mR8qlMh8iaLCpXVZsgJKm71xLOzR4Eo+P8EYJ2ke2Fc
         2Nze8MLfsUVn+KECY3cdWavbgd1Tzf/5DuLnlTTuBCo0TwTaGCq8DtDWhmdMisgfAztc
         HzL0GTZLk1RupNWYFGIWNF/8I6q6YCmZeGY5jkJKzTFeAij3XJc0wKNGS8bHjxH9dLI8
         QMxqDKhODWbC8kHA9VTZ+gslN+DMSi/6WhbYZFXuoATeSs9283vPHp1VcjXkBNmWDGFV
         9m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779333511; x=1779938311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJ84OHIHfCgj+D30o4E16wAWmdnY02uHCwSANOs1Sqw=;
        b=gxkq5amDelQrOn5GQY6YhnMJm3CXD3KVJ3SHMcxvYwnIqS4gqgoYRxPM6pH8IFxBpC
         FY+SJbzXXBQ//QseBBv57ZGo+vcABU1NzzeVej3b3IZPlxLDcOrRluOW8pwJRvLiJfFj
         Jphg5450Ta7e+wTJi4UqNNpPHMhX/AhILppr5nMICkeQrqc2+y8b4+inpYdJ5HZStKP7
         d+5yxoqv1t9SSypw2bymbJaEtmuUzR3O3hNBKJt4e/CUDnj4R+LUC13vyJXWjU/iAVgg
         IMIOTlEONKwDk9yvJMfFl1GKVeszkKlt23AL5wOgl+6llvXnH+ZCUFuYZcvxqCHAeJUi
         AHVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9y7u+QxHifhmYqgwrNVMVshYcZen4vzA/dyIPsLDCaL75L7J+UYDM9guTUL/WqlMGp9gyyhseQLwM+Fw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjsq5YtJrViJS6y7iPmd0S+J3a0e3RxSnzXCevM/HWI2ewvcet
	9AM5/P8/VUbaYNbZhGbHa6Qe/ngrB/YpEWnREq2qq62XCZjXpsPMbhwyl1KjwfFI
X-Gm-Gg: Acq92OFVZ+3yIQNh1LrVeayHChJKUpaTwMifz97wkTWi/Bhx2Qb8e/wr2GrrAq+1xNT
	ck67kj42COXeaLDUb7SWgzMy3MEQ1RWYNUW9FqP+hic7BS/aqsBRMDA+JSvPSJe1NdHxd9mZyo3
	+TnpbMuhyyxaPldsDZ1DcB0PT79v8VaqhdNauT4bYIODdOQUV6EiTppoS2t1IfjpYoJwKq86vwx
	LyTZO/qxRSyvmVJlwwG2NmMo+ONfoY7ffYUr77eYqajnSlgz5cf5SyneOoHUO+441kXvxEOPtr1
	gwBsAYh433SkANd3iBw0FluK+/ts09T6PiSMx8PLjYOnNsSkpzJss2oEeivMxgSLBD61ZK56uPQ
	V0GnbiTtJ2pcuA9h8nyeiv1x/8dSd+GYZYSo2fyevHrrkAsakEnVTeNRBGsK4kO+Mq57u1S1i3e
	B66UGxPsC7Tyn+Yf5iYd+kCFMFhBBFXDGF3yQJjGL7SbaTgbzVDfyqrECCRkYkhlY60HU=
X-Received: by 2002:a05:622a:2c4:b0:50d:a301:2fc0 with SMTP id d75a77b69052e-516c549662cmr17543301cf.26.1779333511082;
        Wed, 20 May 2026 20:18:31 -0700 (PDT)
Received: from cachyos-workstation.hsd1.md.comcast.net ([2601:154:c200:4a60:6a87:5bd:7d89:61a9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm196546871cf.15.2026.05.20.20.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 20:18:30 -0700 (PDT)
From: Andrew Maney <andrewmaney05@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Andrew Maney <andrewmaney05@gmail.com>
Subject: [PATCH v3] HID: Expose LattePanda IOTA UPS as a power_supply device
Date: Wed, 20 May 2026 23:17:48 -0400
Message-ID: <20260521031750.498110-1-andrewmaney05@gmail.com>
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

---

Changes in v3:
- Deferred power_supply registration to workqueue to avoid blocking probe
- Fixed kernel panic when instantiated via uhid by checking hid_is_usb()
  before dereferencing USB-specific structures

- Fixed ERR_PTR dereference in raw_event by only assigning ups->psu on
  successful registration

- Fixed data race on ups->charge_limit using spin_lock_irqsave()
- Removed TIME_TO_EMPTY_NOW and TIME_TO_FULL_NOW properties to avoid
spurious shutdowns

- Changed plugged-in but not charging state from FULL to NOT_CHARGING
- Used devm_kasprintf() for a unique sysfs name in order to support
multiple devices

- Added POWER_SUPPLY and HIDRAW dependencies to Kconfig
- Used %pe for more human-readable error messages

Changes in v2:
- Rebased on top of the current tree
- Moved vendor and device IDs to drivers/hid/hid-ids.h
- Added Kconfig entry under HID bus support -> Special HID drivers
- Added build rule to drivers/hid/Makefile

Signed-off-by: Andrew Maney <andrewmaney05@gmail.com>
---
 MAINTAINERS                           |   6 +
 drivers/hid/Kconfig                   |  10 +
 drivers/hid/Makefile                  |   1 +
 drivers/hid/hid-ids.h                 |   3 +
 drivers/hid/hid-lattepanda-iota-ups.c | 409 ++++++++++++++++++++++++++
 5 files changed, 429 insertions(+)
 create mode 100644 drivers/hid/hid-lattepanda-iota-ups.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10e825318..d80721c2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11416,6 +11416,12 @@ F:	include/uapi/linux/hid*
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
index ff2f580b6..21ffc2fd0 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -510,6 +510,16 @@ config HID_KYSONA
 	Say Y here if you have a Kysona M600 mouse
 	and want to be able to read its battery capacity.
 
+config HID_LATTEPANDA_IOTA_UPS
+	tristate "LattePanda IOTA UPS"
+	depends on USB_HID && USB_HIDDEV && X86 && POWER_SUPPLY
+	help
+	Support for the LattePanda IOTA UPS (DFRobot, VID 0x2341 PID 0x8036).
+	Exposes the battery status and capacity via the power_supply interface.
+
+	To compile as a module, choose M here: the module will be
+	called hid-lattepanda-iota-ups.
+
 config HID_UCLOGIC
 	tristate "UC-Logic"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 0597fd6a4..d7ad3fc8f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_HID_KENSINGTON)	+= hid-kensington.o
 obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
 obj-$(CONFIG_HID_KYE)		+= hid-kye.o
 obj-$(CONFIG_HID_KYSONA)	+= hid-kysona.o
+obj-$(CONFIG_HID_LATTEPANDA_IOTA_UPS)	+= hid-lattepanda-iota-ups.o
 obj-$(CONFIG_HID_LCPOWER)	+= hid-lcpower.o
 obj-$(CONFIG_HID_LENOVO)	+= hid-lenovo.o
 obj-$(CONFIG_HID_LENOVO_GO)	+= hid-lenovo-go.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4657d96fb..6ded2c943 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -859,6 +859,9 @@
 #define USB_DEVICE_ID_LD_HYBRID		0x2090
 #define USB_DEVICE_ID_LD_HEATCONTROL	0x20A0
 
+#define USB_VENDOR_ID_LATTEPANDA_IOTA	0x2341
+#define USB_DEVICE_ID_LATTEPANDA_IOTA_UPS	0x8036
+
 #define USB_VENDOR_ID_LENOVO		0x17ef
 #define USB_DEVICE_ID_LENOVO_TPKBD	0x6009
 #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
diff --git a/drivers/hid/hid-lattepanda-iota-ups.c b/drivers/hid/hid-lattepanda-iota-ups.c
new file mode 100644
index 000000000..f5d522695
--- /dev/null
+++ b/drivers/hid/hid-lattepanda-iota-ups.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/power_supply.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/hid.h>
+#include <linux/usb.h>
+#include "hid-ids.h"
+
+#define REPORT_ID_CAPACITY	0x0C
+#define REPORT_ID_STATUS	0x07
+
+#define STATUS_DISCHARGING	BIT(1)
+#define STATUS_PLUGGED_IN	BIT(0)
+#define STATUS_CHARGING		BIT(2)
+
+MODULE_AUTHOR("Andrew Maney");
+MODULE_DESCRIPTION("LattePanda IOTA UPS power supply driver");
+MODULE_LICENSE("GPL");
+
+struct iota_ups {
+	struct power_supply_desc psu_desc;
+	struct power_supply *psu;
+	struct hid_device *hiddev;
+	spinlock_t lock; /* Protects cached HID report values */
+
+	/* Cached values that are updated from HID reports */
+	bool plugged_in;
+	char serial[64];
+	int charge_limit;
+	int psu_status;
+	int capacity;
+
+	/*
+	 * Wait for both status and capacity reports before registering
+	 * with the power_supply core, so initial values are correct and
+	 * not erroneous.
+	 */
+	struct completion got_initial_data;
+	struct work_struct register_work;
+	bool got_capacity;
+	bool data_ready;
+	bool got_status;
+};
+
+static enum power_supply_property iota_ups_properties[] = {
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+
+static const struct hid_device_id iota_ups_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LATTEPANDA_IOTA,
+		USB_DEVICE_ID_LATTEPANDA_IOTA_UPS) },
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
+
+	/* Remaining capacity as a percentage from 0 to 100 */
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = ups->capacity;
+		break;
+
+	/* The UPS is always present if the driver is loaded */
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+
+	/* Whether mains power is connected */
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ups->plugged_in ? 1 : 0;
+		break;
+
+	/*
+	 * The UPS board supplies power to the IOTA and any
+	 * peripherals connected to it, therefore its scope
+	 * is system-wide.
+	 */
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+
+	/* V1.0 only accepts 18650 Li-ion cells */
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+
+	/* 80% or 100%, configured via a DIP switch on the UPS board */
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		val->intval = ups->charge_limit;
+		break;
+
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "DFRobot";
+		break;
+
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = "LattePanda IOTA UPS";
+		break;
+
+	/* Retrieved from the USB descriptor */
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = ups->serial;
+		break;
+
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
+		unsigned long flags;
+
+		/*
+		 * V1.0 supports 80% and 100% charge limits only, which is
+		 * set via a DIP switch on the board. This property allows
+		 * userspace to inform the driver which limit is configured.
+		 */
+		if (val->intval != 80 && val->intval != 100)
+			return -EINVAL;
+
+		spin_lock_irqsave(&ups->lock, flags);
+		ups->charge_limit = val->intval;
+		spin_unlock_irqrestore(&ups->lock, flags);
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
+	/* All of the UPS's reports are at least 2 bytes */
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
+		/*
+		 * The UPS status is determined as follows:
+		 * Battery full:
+		 *	UPS is plugged in
+		 *	Battery is at full capacity
+		 *
+		 * Battery charging:
+		 *	UPS is plugged in
+		 *	Battery is not at full capacity
+		 *
+		 * Battery discharging:
+		 *	UPS is not plugged in
+		 *
+		 * Battery not charging:
+		 *	UPS is plugged in
+		 *	UPS has halted charging for some reason
+		 *
+		 * Unknown:
+		 *	None of the above conditions are met
+		 */
+		if (status & STATUS_CHARGING) {
+			if (ups->capacity >= ups->charge_limit)
+				new_status = POWER_SUPPLY_STATUS_FULL;
+			else
+				new_status = POWER_SUPPLY_STATUS_CHARGING;
+
+		} else if (status & STATUS_DISCHARGING) {
+			new_status = POWER_SUPPLY_STATUS_DISCHARGING;
+
+		} else if (plugged_in) {
+			new_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
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
+
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
+	 * Signal that the UPS is ready to be registered because we have
+	 * received both capacity and status reports.
+	 */
+	if (!ups->data_ready && ups->got_status && ups->got_capacity) {
+		ups->data_ready = true;
+		complete(&ups->got_initial_data);
+	}
+
+	spin_unlock_irqrestore(&ups->lock, flags);
+
+	/*
+	 * Notify the power_supply core outside the spinlock to avoid
+	 * a deadlock; power_supply_changed() may call back into
+	 * get_property() which acquires the same lock.
+	 */
+	if (changed && ups->psu)
+		power_supply_changed(ups->psu);
+
+	return 0;
+}
+
+static void iota_ups_register_work(struct work_struct *work)
+{
+	struct iota_ups *ups = container_of(work, struct iota_ups, register_work);
+	struct power_supply_config psu_config = {};
+	struct power_supply *psu;
+
+	/*
+	 * Wait for both status and capacity reports before registering.
+	 * The device sends reports every ~1 second, so 3 seconds is safe.
+	 * We wait here in order to prevent registration in an unknown
+	 * state, since this could cause emergency shutdowns or other
+	 * undesired effects.
+	 */
+	wait_for_completion_timeout(&ups->got_initial_data,
+				    msecs_to_jiffies(3000));
+
+	/* Configure the UPS's power supply properties */
+	ups->psu_desc.name = devm_kasprintf(&ups->hiddev->dev, GFP_KERNEL,
+					    "lattepanda-iota-ups.%s",
+					    dev_name(&ups->hiddev->dev));
+
+	if (!ups->psu_desc.name) {
+		hid_err(ups->hiddev, "failed to allocate power supply name\n");
+		return;
+	}
+
+	ups->psu_desc.property_is_writeable = iota_ups_property_is_writable;
+	ups->psu_desc.num_properties	    = ARRAY_SIZE(iota_ups_properties);
+	ups->psu_desc.get_property	    = iota_ups_get_property;
+	ups->psu_desc.set_property	    = iota_ups_set_property;
+	ups->psu_desc.properties	    = iota_ups_properties;
+	ups->psu_desc.type		    = POWER_SUPPLY_TYPE_BATTERY;
+	psu_config.drv_data		    = ups;
+
+	/* Register the UPS as a power_supply device */
+	psu = devm_power_supply_register(&ups->hiddev->dev, &ups->psu_desc, &psu_config);
+	if (IS_ERR(psu)) {
+		hid_err(ups->hiddev, "power supply registration failed: %pe\n", psu);
+		return;
+	}
+
+	/*
+	 * Finally, notify the power_supply core so userspace reads the correct
+	 * initial state immediately after registration.
+	 */
+	ups->psu = psu;
+	power_supply_changed(ups->psu);
+	hid_info(ups->hiddev, "LattePanda IOTA UPS registered as a power_supply device\n");
+}
+
+static int iota_ups_probe(struct hid_device *hdev,
+			  const struct hid_device_id *id)
+{
+	struct iota_ups *ups;
+	int ret;
+
+	ups = devm_kzalloc(&hdev->dev, sizeof(*ups), GFP_KERNEL);
+	if (!ups)
+		return -ENOMEM;
+
+	ups->hiddev = hdev;
+	ups->psu_status = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	/* 50% is a safe default if wait_for_completion_timeout() times out. */
+	ups->capacity = 50;
+
+	/*
+	 * Default to 100% to prevent unexpected shutdowns.
+	 * Userspace can update this via charge_control_end_threshold.
+	 */
+	ups->charge_limit = 100;
+
+	init_completion(&ups->got_initial_data);
+	spin_lock_init(&ups->lock);
+	hid_set_drvdata(hdev, ups);
+
+	/*
+	 * Retrieve the UPS's serial number from the USB descriptor. If the device is not
+	 * a USB device, we can use the unique device identifier as the serial number.
+	 */
+	if (hid_is_usb(hdev)) {
+		struct usb_device *udev = to_usb_device(hdev->dev.parent->parent);
+
+		if (udev->serial)
+			strscpy(ups->serial, udev->serial, sizeof(ups->serial));
+		else
+			strscpy(ups->serial, "Unknown", sizeof(ups->serial));
+	} else {
+		if (*hdev->uniq)
+			strscpy(ups->serial, hdev->uniq, sizeof(ups->serial));
+		else
+			strscpy(ups->serial, "Unknown", sizeof(ups->serial));
+	}
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "HID parse failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret) {
+		hid_err(hdev, "HID hw start failed: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "HID hw open failed: %pe\n", ERR_PTR(ret));
+		goto err_stop;
+	}
+
+	/* Probe for the UPS in a worker queue so we don't halt the enumeration thread */
+	INIT_WORK(&ups->register_work, iota_ups_register_work);
+	schedule_work(&ups->register_work);
+	return 0;
+
+err_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void iota_ups_remove(struct hid_device *hdev)
+{
+	struct iota_ups *ups = hid_get_drvdata(hdev);
+
+	cancel_work_sync(&ups->register_work);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static struct hid_driver iota_ups_driver = {
+	.name = "lattepanda-iota-ups",
+	.id_table = iota_ups_devices,
+	.probe = iota_ups_probe,
+	.remove = iota_ups_remove,
+	.raw_event = iota_ups_raw_event,
+};
+module_hid_driver(iota_ups_driver);
-- 
2.54.0

