Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DA43CEF5
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127647; cv=none; b=kalOuXTEdi2niuACg8ZdhU5djwv+qy6WMZJChnbqWb5SrOKOmdpCxyHYVLNUV1l3tW7DvhH2/2F6RtcFviUTa2h+sZUegmLotuaHxqWlA6vnqXcRhd91fqAPMgTLdwRHQeV2EeGKvcBhP+q7sjusDfJP7XS+wleOfIqteaPYATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127647; c=relaxed/simple;
	bh=vDJR9sNOqfRhEKahCegiI+lvWKun0kne/wwmAMdfyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkPZwyxILY2E21BhH/wKyXXf/SxrjdDc12e+O31JekuyRvriKCxpf3HHDvcEcZj7cAoUGQGSNhcZG1J+9zLwiokWcFz90brI70MYPfR9jHEfBa17QpuKvbESGjY/jbAzFM0rHX4HldZcZV0YSOVAdPWVb49RuryAbSaNPROEvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyZPReMq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyZPReMq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so490937f8f.0
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 04:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789127642; x=1789732442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2o5qthLe+8HmsEAOcxjOB9COGNKyrsAHc1dT/HCfm7w=;
        b=HyZPReMqBloZqI0J9b6cDHTOEyvVqFsK3oEqT7NSM3G+LtuOtw3VSVZdwumRxwHC7h
         i7t0CEpyWrPEBlRhZnrtUR1Zn4wDjYFlQ+u4OHCkAfN5VrMPa5SYHb8DvY/dGjmO8WHW
         xS4Rbd2/fF4i7qjYuW3+zwlZWCj6WFGNLCuLEnD47tl47DxfcAL2D7lX3VAAiNVoEQyr
         RcxtDY2J85u9KwKh95CYbI68qDlE0mHNNBLXzTFu3XLEFqJ7kh846ZDIRGrVEUG8WFHP
         bMHZiq6C3mKDDeFi+B8J4MCztwTa9SemNwIKaokCtW4lxz6uli+lv8CBSXPAB1+k/dEB
         cKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789127642; x=1789732442;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2o5qthLe+8HmsEAOcxjOB9COGNKyrsAHc1dT/HCfm7w=;
        b=eGnc6wJldUTmOzEWuWCZAnzUZ/4GBBVvzm3X2RUiHssThhBqc+tBn78ogVQWuG0dri
         QKGlMvdu5VK/IMw2UXeQPAbhwutB948JQnjWSZnV6rnhFjcw3zcB66eZ63TvFaU8Zp5P
         W0AX8XP1t0O6ejFP+oFSdMK4X5UWFDBGcsJ3S44/ckFNeGh1sFuNb9bq1K3Z1lOCO3m2
         tEwsVQWpgQtA9VUFJYkHYxjHv+VfwPdn7+tgwVp4O4FNxe9BLT5Qc5NWJtUURDl8JyRI
         KCibVu3MTGL1XBfEHeJTXcbofUhMsoZL3qAnmM2wW79uKQrsdgtMMo1atOxwni88E6Fw
         2xCw==
X-Forwarded-Encrypted: i=1; AKwUvByOEVs/Z/DKYvy8lLIpYbNCasgL2anmj7zpYq5Eut5cyolgiAu5+GHHzM5QD0GFjGa0xFGu0xbhxTapgA==@vger.kernel.org
X-Gm-Message-State: AFuF++kNq5IWY0pT4eaMSzlDLDXaWF9NK54sJjRzGy2cAzR+PojVnR4k
	0NU/D0JdfuO/YVbo6qbHb9R6u2+8VWXFPX++l9L9pda/KbxZRYyp175cWCeymQ==
X-Gm-Gg: AYBFou0cOh2cXsKkvlMFbby3aEYkshUSfY8OCMW/WnIp8xywfHLY8PD3Ar8G1IBTC60
	jfjXBRg0ZFt4+4E9ifAOMGtFGJwZMqzXyfQB1XTMmEEDfDto3iYaxNWufEVOD4h7WjIl+837GH4
	QNH9SBUdi7JQcxyogq3h9Bsjw6qskyZq7EMnGFwSAIFBIOaJgCzU9H9wWH0EWk/BzzQ9DHa2iUx
	OkQeQrFF9moeejRWd4OMl81oNBArG9N6QPpU9EXaSZOOnnEd2HR+katVILUD6YWpXzjDXRpzh+w
	4UzCdXMi5ZCojI1tJv4scmUN63t4IJH36WgPiJJZHB2q6mMydy8Ejyh1/fYWX27LQZ4pfNptURo
	ElZDg28qA6U50YAXWY3fkdU3pM65980EyLCmkWDMvXSxVVmJjUTK1crWo1SUGEDr8BkgTaozd+s
	vEG+iBa0LXffPJKGDxp/B6EV2cY+V74Rkdp+T0+dwT1eKLAqjaR8Pl8QxdqNxBwN+J4qYuQMx7e
	mZPvdBe/DK2fNiuz5gMG+kZtplXSubjCrxnJImbGhXtpTu3+QeNja6PaIWABa2InA==
X-Received: by 2002:adf:fc82:0:b0:485:ac52:e07f with SMTP id ffacd0b85a97d-486eb31f8d8mr6678157f8f.18.1789127642389;
        Fri, 11 Sep 2026 04:54:02 -0700 (PDT)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e81asm5633463f8f.7.2026.09.11.04.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:54:01 -0700 (PDT)
From: "=?UTF-8?q?M=C3=A9ven=20Car?=" <meven29@gmail.com>
X-Google-Original-From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: logitech-headset: add a battery driver for the PRO X 2
Date: Fri, 11 Sep 2026 13:53:45 +0200
Message-ID: <20260911115346.17133-1-meven@kde.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PRO X 2 LIGHTSPEED receiver does not speak HID++, so hid-logitech-hidpp
cannot read its battery. Its report descriptor has a consumer collection for
the media keys and two vendor collections, and no report 0x10 or 0x11.

The battery answers on usage page 0xffa0. A single 64 byte frame on report
0x51 asks for it, with no handshake, and the reply gives the level and
whether the headset is charging. The driver asks every 120 seconds, and it
also reads the power frames that the headset sends on its own, so a headset
that was switched off is reported before the next poll.

hid-generic sets HID_QUIRK_INPUT_PER_APP, so this receiver had one input
device per application collection, among them the Consumer Control node for
the media keys. A driver does not inherit that quirk, so probe sets it and
the input devices stay as they were.

The power supply is registered with POWER_SUPPLY_SCOPE_DEVICE, and capacity
returns -ENODATA until the first reply arrives.

The G522 LIGHTSPEED uses the same vendor protocol with a different frame
layout. That device is left out until someone can test it.

Assisted-by: Claude:claude-opus-5
---
Tested on a PRO X 2 LIGHTSPEED (046d:0af7) with 7.2.4, built as a module out
of tree. The driver binds on replug without unbinding hid-generic by hand,
and one power supply appears for the single HID interface of the receiver.
present, status and capacity read 1, Discharging and 50, against the same
frame read through hidraw: 510b000310000600040a3232.

With HID_QUIRK_INPUT_PER_APP the receiver keeps the three input devices it
had under hid-generic, among them "Logitech PRO X 2 LIGHTSPEED Consumer
Control". Without the quirk the three became one and that node was gone.

UPower exports the supply as an audio-device peripheral, which is what the
KDE battery applet lists.

Not tested: the G522 LIGHTSPEED, which is why it is absent from the id
table, and the hid_hw_raw_request fallback in logi_headset_ask, because this
receiver has an interrupt out endpoint and always takes the
hid_hw_output_report path.

The one checkpatch warning that is left is the ENOSYS one, and it matches
how hid-input.c and hidraw.c test the return of hid_hw_output_report before
they fall back to hid_hw_raw_request.

Per Documentation/process/generated-content.rst: this patch was written with
Claude Code, model claude-opus-5. The protocol was read from HeadsetControl
and confirmed with a python script that sent the frame over hidraw on the
real device. The model wrote the driver, the Kconfig and Makefile entries
and this changelog from that, and the result was built and tested on the
hardware described above.

Based on v7.2.3, so it may need a rebase onto hid.git.

 drivers/hid/Kconfig                |  11 ++
 drivers/hid/Makefile               |   1 +
 drivers/hid/hid-ids.h              |   1 +
 drivers/hid/hid-logitech-headset.c | 292 +++++++++++++++++++++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 drivers/hid/hid-logitech-headset.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 48934c4f3..5c845b1b8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -670,6 +670,17 @@ config HID_LOGITECH_DJ
 	generic USB_HID driver and all incoming events will be multiplexed
 	into a single mouse and a single keyboard device.
 
+config HID_LOGITECH_HEADSET
+	tristate "Logitech wireless headset battery"
+	depends on USB_HID
+	select POWER_SUPPLY
+	help
+	Support for the battery of Logitech wireless gaming headsets that
+	report it over a vendor collection instead of HID++.
+
+	Supported devices:
+	- PRO X 2 LIGHTSPEED
+
 config HID_LOGITECH_HIDPP
 	tristate "Logitech HID++ devices support"
 	depends on HID_LOGITECH
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 23e6e3dd0..b8576a5ac 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_HID_LETSKETCH)	+= hid-letsketch.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
 obj-$(CONFIG_HID_LOGITECH)	+= hid-lg-g15.o
 obj-$(CONFIG_HID_LOGITECH_DJ)	+= hid-logitech-dj.o
+obj-$(CONFIG_HID_LOGITECH_HEADSET)	+= hid-logitech-headset.o
 obj-$(CONFIG_HID_LOGITECH_HIDPP)	+= hid-logitech-hidpp.o
 obj-$(CONFIG_HID_MACALLY)	+= hid-macally.o
 obj-$(CONFIG_HID_MAGICMOUSE)	+= hid-magicmouse.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922ba..0efe30b2f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -910,6 +910,7 @@
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_Z_10_SPK	0x0a07
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
+#define USB_DEVICE_ID_LOGITECH_PRO_X_2_LIGHTSPEED	0x0af7
 #define USB_DEVICE_ID_LOGITECH_T651	0xb00c
 #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD	0xb309
 #define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD	0xbb00
diff --git a/drivers/hid/hid-logitech-headset.c b/drivers/hid/hid-logitech-headset.c
new file mode 100644
index 000000000..9081ddf5f
--- /dev/null
+++ b/drivers/hid/hid-logitech-headset.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for the battery of Logitech wireless gaming headsets that report
+ * it over a vendor collection instead of HID++.
+ *
+ * Copyright (c) 2026 Méven Car <meven@kde.org>
+ */
+
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include "hid-ids.h"
+
+/*
+ * The receiver carries a consumer collection for the media keys and two vendor
+ * collections. The battery answers on usage page 0xffa0, which exchanges fixed
+ * size frames on report 0x51. One request is enough, there is no handshake.
+ */
+#define LOGI_HEADSET_REPORT_ID		0x51
+#define LOGI_HEADSET_FRAME_SIZE		64
+
+/* Every frame names its kind in the second byte. */
+#define LOGI_HEADSET_KIND_ACK		0x03
+#define LOGI_HEADSET_KIND_POWER		0x05
+#define LOGI_HEADSET_KIND_BATTERY	0x0b
+
+/* Offsets into a battery frame, which carries a tag of its own. */
+#define LOGI_HEADSET_BATTERY_TAG	8
+#define LOGI_HEADSET_BATTERY_TAG_VALUE	0x04
+#define LOGI_HEADSET_BATTERY_LEVEL	10
+#define LOGI_HEADSET_BATTERY_STATE	12
+#define LOGI_HEADSET_STATE_CHARGING	0x02
+
+/* A power frame carries zero here once the headset has been switched off. */
+#define LOGI_HEADSET_POWER_STATE	6
+
+#define LOGI_HEADSET_POLL_INTERVAL	(120 * HZ)
+
+static const u8 logi_headset_battery_request[] = {
+	LOGI_HEADSET_REPORT_ID, 0x08, 0x00, 0x03, 0x1a, 0x00, 0x03, 0x00, 0x04, 0x0a
+};
+
+struct logi_headset {
+	struct hid_device *hdev;
+	struct power_supply *battery;
+	struct power_supply_desc desc;
+	struct delayed_work poll;
+	spinlock_t lock;	/* guards the values below */
+	int capacity;
+	bool charging;
+	bool present;
+	bool seen;		/* an answer has arrived at least once */
+};
+
+static enum power_supply_property logi_headset_properties[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int logi_headset_get_property(struct power_supply *psy,
+				     enum power_supply_property prop,
+				     union power_supply_propval *val)
+{
+	struct logi_headset *headset = power_supply_get_drvdata(psy);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&headset->lock, flags);
+	switch (prop) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = headset->present;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!headset->present)
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (headset->charging)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		if (headset->seen)
+			val->intval = headset->capacity;
+		else
+			ret = -ENODATA;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		if (!headset->seen)
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+		else if (headset->capacity <= 10)
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		else if (headset->capacity <= 25)
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		else if (headset->capacity >= 95)
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+		else
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		/* A peripheral, not the battery of the machine itself. */
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = headset->hdev->name;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Logitech";
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	spin_unlock_irqrestore(&headset->lock, flags);
+
+	return ret;
+}
+
+static int logi_headset_ask(struct logi_headset *headset)
+{
+	u8 *frame;
+	int ret;
+
+	frame = kzalloc(LOGI_HEADSET_FRAME_SIZE, GFP_KERNEL);
+	if (!frame)
+		return -ENOMEM;
+
+	memcpy(frame, logi_headset_battery_request,
+	       sizeof(logi_headset_battery_request));
+
+	/* Same fallback as hidraw, for a device without an interrupt out endpoint. */
+	ret = hid_hw_output_report(headset->hdev, frame, LOGI_HEADSET_FRAME_SIZE);
+	if (ret == -ENOSYS)
+		ret = hid_hw_raw_request(headset->hdev, frame[0], frame,
+					 LOGI_HEADSET_FRAME_SIZE,
+					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+	kfree(frame);
+
+	return ret;
+}
+
+static void logi_headset_poll(struct work_struct *work)
+{
+	struct logi_headset *headset = container_of(to_delayed_work(work),
+						    struct logi_headset, poll);
+	int ret;
+
+	ret = logi_headset_ask(headset);
+	if (ret < 0)
+		hid_dbg(headset->hdev, "battery request failed: %d\n", ret);
+
+	schedule_delayed_work(&headset->poll, LOGI_HEADSET_POLL_INTERVAL);
+}
+
+static int logi_headset_raw_event(struct hid_device *hdev,
+				  struct hid_report *report, u8 *data, int size)
+{
+	struct logi_headset *headset = hid_get_drvdata(hdev);
+	unsigned long flags;
+	bool changed = false;
+
+	if (size <= LOGI_HEADSET_BATTERY_STATE ||
+	    data[0] != LOGI_HEADSET_REPORT_ID)
+		return 0;
+
+	spin_lock_irqsave(&headset->lock, flags);
+	switch (data[1]) {
+	case LOGI_HEADSET_KIND_BATTERY:
+		if (data[LOGI_HEADSET_BATTERY_TAG] == LOGI_HEADSET_BATTERY_TAG_VALUE &&
+		    data[LOGI_HEADSET_BATTERY_LEVEL] <= 100) {
+			headset->capacity = data[LOGI_HEADSET_BATTERY_LEVEL];
+			headset->charging = data[LOGI_HEADSET_BATTERY_STATE] ==
+					    LOGI_HEADSET_STATE_CHARGING;
+			headset->present = true;
+			headset->seen = true;
+			changed = true;
+		}
+		break;
+	case LOGI_HEADSET_KIND_POWER:
+		if (data[LOGI_HEADSET_POWER_STATE] == 0x00 && headset->present) {
+			headset->present = false;
+			changed = true;
+		}
+		break;
+	case LOGI_HEADSET_KIND_ACK:
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(&headset->lock, flags);
+
+	if (changed)
+		power_supply_changed(headset->battery);
+
+	/* Let the frame reach hidraw as well, userspace tools read it too. */
+	return 0;
+}
+
+static int logi_headset_probe(struct hid_device *hdev,
+			      const struct hid_device_id *id)
+{
+	struct power_supply_config cfg = {};
+	struct logi_headset *headset;
+	const char *name;
+	int ret;
+
+	headset = devm_kzalloc(&hdev->dev, sizeof(*headset), GFP_KERNEL);
+	if (!headset)
+		return -ENOMEM;
+
+	headset->hdev = hdev;
+	headset->present = true;
+	spin_lock_init(&headset->lock);
+	INIT_DELAYED_WORK(&headset->poll, logi_headset_poll);
+	hid_set_drvdata(hdev, headset);
+
+	/* As hid-generic did, so that the media keys keep their own input device. */
+	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+			      "logitech-headset-%d-battery", hdev->id);
+	if (!name)
+		return -ENOMEM;
+
+	headset->desc.name = name;
+	headset->desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	headset->desc.properties = logi_headset_properties;
+	headset->desc.num_properties = ARRAY_SIZE(logi_headset_properties);
+	headset->desc.get_property = logi_headset_get_property;
+	cfg.drv_data = headset;
+
+	headset->battery = devm_power_supply_register(&hdev->dev, &headset->desc,
+						      &cfg);
+	if (IS_ERR(headset->battery))
+		return dev_err_probe(&hdev->dev, PTR_ERR(headset->battery),
+				     "cannot register the battery\n");
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		return ret;
+
+	/* Input reports only arrive while the transport is open. */
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_hw_stop(hdev);
+		return ret;
+	}
+
+	schedule_delayed_work(&headset->poll, HZ);
+
+	return 0;
+}
+
+static void logi_headset_remove(struct hid_device *hdev)
+{
+	struct logi_headset *headset = hid_get_drvdata(hdev);
+
+	cancel_delayed_work_sync(&headset->poll);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id logi_headset_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_PRO_X_2_LIGHTSPEED) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, logi_headset_devices);
+
+static struct hid_driver logi_headset_driver = {
+	.name = "logitech-headset",
+	.id_table = logi_headset_devices,
+	.probe = logi_headset_probe,
+	.remove = logi_headset_remove,
+	.raw_event = logi_headset_raw_event,
+};
+module_hid_driver(logi_headset_driver);
+
+MODULE_AUTHOR("Méven Car <meven@kde.org>");
+MODULE_DESCRIPTION("Battery for Logitech wireless headsets without HID++");
+MODULE_LICENSE("GPL");
-- 
2.55.0

