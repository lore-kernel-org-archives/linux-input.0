Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D11EB1AA
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151297; cv=none; b=Nbkq6xEIedCkp+tbNItyAF4/W5fdoCp7T2zpmXvGqhmTlFHVylaEmUJP31aJG5DHI7rpzvAFvJcO9uB7NgceRKAgnZImION6pKYu9r8edQeBS8A5qL6nW4HVBInJE1CFGPFOQA2Wn9lzS0JJhQ+pnk0oPU67sUMgYMYG7kvnr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151297; c=relaxed/simple;
	bh=7s2v1L3YRcjp/ae/TSfsYX3PRA8D6WHVz+qMnu3MaPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rkr5L9xX1ALSDvDGU0NLegHRNjyD9PdiF9/wUqR+zzVvxPHWe17tqrGNzsQL7Ll5Qfj4kqCo9IjjMI/rXRxK6iXpoU/Wfo4NKcFnHYGVY8BKmBHCYkLU3H9kQIRKNUfAqP6iIIRjtTTls+940IzQiyldRcgKNdXjA1vQitIFw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwuDDjsf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwuDDjsf"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dfb76b304so163680f8f.2
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792151293; x=1792756093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxbFmJ7T5XQiKAbL3fTXhEkum5GModY9My/YOWkJa3I=;
        b=VwuDDjsfdWktHwjRGTUwP7Jf0wbNp26lO5HTbbYMNLHqqyq2GBowEkUFvH9r1HGXus
         uLBOW73D1YMahkjRqPe4j0gAHxlM77ezsrEXdNz+cKbxv6ZHan8mabe81dL4mFKaRb0b
         5E1PPxw4YUlfd4apa45oCRdVXEV5XSWswPE7pQ4G1x7mu7z0MdmlSQHYDAEl9pX/SxRb
         nKLuKbcbrO5Sn4JKA2e2YOYg60ootp38x258CleyJ5qafLOGLeXunMWjdzEV9DJ88k72
         NX0bst9NbbqwWBOsmMLkV6uyTyt4WWBCjxU0hPBXbbOhuNayC46dinGS/a4si8Ta8Dp6
         OK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151293; x=1792756093;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xxbFmJ7T5XQiKAbL3fTXhEkum5GModY9My/YOWkJa3I=;
        b=F3GAIAsrB+ta8r1VY1XOW/iZ4jKvwCuyH7H1KR5JwpU5PK5sRYC/2vjBFshSZNUs17
         d9WqfU9vXv9qOSQTYuF/Bmk6kT14jtyA+L+zlqqTn/5hZeBBDeMePHZ6eliFFhpYVQee
         /AJwRCRcFIcU46KeNqeyH1iHyNv3CvB6MYMgeNnLH6Fe3l1ZX6ySgJ4PoHOd/Wwg4H0n
         +BoyYKtzkjTpIBlMHzyO5UsZB50a42+Q/yxdqX8oLTfBz+dvfRhh7Z6mrWoyMTVkBsEU
         wcLDlcpuRlRPvJw42RzgjRZkq9smHqhza00CJmY9ZH04sgGu8kG873ar3XO482fLFVEH
         akjA==
X-Forwarded-Encrypted: i=1; AKwUvBxwfA016Xo02EFJ3hvYt1+F+l6KJYBV8EEspeN+pwDcn7mEUY8adlHt/xZakArTDbJEVcPvTPgoQzopzw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKI7o/grp/zGkBj2w1qCcTtCI1u7bmNduHSAWum4dJpXNeAyl0Z
	RnG5VmZV0gvgbElD3SxYG7Q/qlDwkI3Hy9pYTlG5usQD4FnstOkPfurT
X-Gm-Gg: AYBFou18GKLYiUv9LpoW18Z3tBp/aCK4VU3igoIRCT9DWmfgLhKiBTz73o8JXDTjXCB
	+4oDhhUUe/F5PgNh5bMFCom24Vo8XlAhRTJX34IaFiAbDu4mZP0mHpCETN/k0UwRNHcQfgsLf7+
	fqa1CKNZPC7SQAFWrQ5cPZ5ly/nDmQZMcO0cdXpNPPGqjwefrlpoQSHZ/YFHbzvj/NP6Lc5XbCh
	Etndv3g4yyXfZ62MjfqVN1VxJ7xaygjTS+9RRMnZZqfPQnlgPIB+Wtq66e0+kH1jQIAvUKGNKb+
	VZlwbuQlyvlkaC47bDCc389D6PB6XnIRZXXz2s7YFdC5VFKrUq2cwihRswSlM1GgDRpXJxjT/qu
	aG4oBDKuSGDLCHCCbXFUOT856lLDdfRJyn/1dYojxgQVM9ni5YeCTGr/B4OJbCt9s7DeZvZD4EG
	hXWLpnwmiLgeeqA4QBr4EnRqPDZlB8RDeOQP9CrNQSXF9+JQQVHgWYyaqM/mIuF2U05zCLzuJuz
	5ANC/Q2DfRmqKajwHvMgn6g7Pva72fmceta1Z0uloTj50Hb4mWkt5JO9l2lgg3RyQ==
X-Received: by 2002:a05:6000:440e:b0:487:13f:f612 with SMTP id ffacd0b85a97d-48dbacdbd23mr31274873f8f.37.1792151293311;
        Fri, 16 Oct 2026 04:48:13 -0700 (PDT)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5033a2sm4721482f8f.45.2026.10.16.04.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:48:12 -0700 (PDT)
From: "=?UTF-8?q?M=C3=A9ven=20Car?=" <meven29@gmail.com>
X-Google-Original-From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] HID: logitech-headset: add a battery driver for the PRO X 2
Date: Fri, 16 Oct 2026 13:47:57 +0200
Message-ID: <20261016114757.1099300-1-meven@kde.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The PRO X 2 LIGHTSPEED receiver does not speak HID++, so
hid-logitech-hidpp cannot read its battery. Its report descriptor has a
consumer collection for the media keys and two vendor collections, and
no report 0x10 or 0x11.

The battery answers on usage page 0xffa0. A single 64 byte frame on
report 0x51 asks for it, with no handshake, and the reply gives the
level and whether the headset is charging. The driver asks every 120
seconds. It also reads the power frames that the headset sends on its
own. A switch-off frame marks the headset absent at once, and a
switch-on frame moves the next request to one second later, so the level
appears without waiting for the poll.

hid-generic sets HID_QUIRK_INPUT_PER_APP, so this receiver had one input
device per application collection, among them the Consumer Control node
for the media keys. A driver does not inherit that quirk, so probe sets
it and the input devices stay as they were.

The power supply is registered with POWER_SUPPLY_SCOPE_DEVICE. The
headset is present from a reply until the next switch-off frame, and
capacity returns -ENODATA while it is absent, so a headset that is off
when the driver binds reports no level.

The G522 LIGHTSPEED uses the same vendor protocol with a different frame
layout. That device is left out until someone can test it.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Méven Car <meven@kde.org>
---
Changes in v4:
- Make HID_LOGITECH_HEADSET a hidden option, selected by
  HID_LOGITECH_DJ in the same way as HID_LOGITECH_HIDPP, as suggested by
  Jiri Kosina.

Changes in v3:
- Request the battery level one second after a power-on frame, so the
  level appears without waiting for the 120 second poll.
- Report the headset as absent until the first battery reply, and return
  -ENODATA for capacity while it is absent.
- Queue the poll on system_dfl_wq instead of the system_wq.

v3: https://lore.kernel.org/linux-input/20261011124110.62621-1-meven@kde.org/

 drivers/hid/Kconfig                |  13 ++
 drivers/hid/Makefile               |   1 +
 drivers/hid/hid-ids.h              |   1 +
 drivers/hid/hid-logitech-headset.c | 319 +++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 drivers/hid/hid-logitech-headset.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 48934c4f3..8d3d7df85 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -663,6 +663,7 @@ config HID_LOGITECH_DJ
 	depends on HIDRAW
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
+	select HID_LOGITECH_HEADSET
 	help
 	Say Y if you want support for Logitech receivers and devices.
 	Logitech receivers are capable of pairing multiple Logitech compliant
@@ -670,6 +671,18 @@ config HID_LOGITECH_DJ
 	generic USB_HID driver and all incoming events will be multiplexed
 	into a single mouse and a single keyboard device.
 
+config HID_LOGITECH_HEADSET
+	tristate
+	depends on USB_HID
+	select POWER_SUPPLY
+	help
+	Support for the battery of Logitech wireless gaming headsets that
+	report it over a vendor collection instead of HID++. This is a hidden
+	option.
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
index 000000000..07261688a
--- /dev/null
+++ b/drivers/hid/hid-logitech-headset.c
@@ -0,0 +1,319 @@
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
+/*
+ * A power frame carries zero here when the headset was switched off, and
+ * non-zero when it came on.
+ */
+#define LOGI_HEADSET_POWER_STATE	6
+
+#define LOGI_HEADSET_POLL_INTERVAL	(120 * HZ)
+
+/* Wait between a power-on event and the request, so the radio link settles. */
+#define LOGI_HEADSET_WAKE_DELAY		HZ
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
+	bool present;		/* capacity and charging hold a reading from the headset */
+	bool wake_queued;	/* a power-on event moved the next request forward */
+	bool removing;		/* power events no longer queue a request */
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
+		if (headset->present)
+			val->intval = headset->capacity;
+		else
+			ret = -ENODATA;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		if (!headset->present)
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
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&headset->lock, flags);
+	headset->wake_queued = false;
+	spin_unlock_irqrestore(&headset->lock, flags);
+
+	ret = logi_headset_ask(headset);
+	if (ret < 0)
+		hid_dbg(headset->hdev, "battery request failed: %d\n", ret);
+
+	queue_delayed_work(system_dfl_wq, &headset->poll, LOGI_HEADSET_POLL_INTERVAL);
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
+			changed = true;
+		}
+		break;
+	case LOGI_HEADSET_KIND_POWER:
+		if (data[LOGI_HEADSET_POWER_STATE] == 0x00) {
+			if (headset->present) {
+				headset->present = false;
+				changed = true;
+			}
+		} else if (!headset->wake_queued && !headset->removing) {
+			/*
+			 * The headset came on. Only the first such event moves the
+			 * request forward, so a burst of them cannot keep pushing it
+			 * back.
+			 */
+			headset->wake_queued = true;
+			mod_delayed_work(system_dfl_wq, &headset->poll,
+					 LOGI_HEADSET_WAKE_DELAY);
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
+	queue_delayed_work(system_dfl_wq, &headset->poll, HZ);
+
+	return 0;
+}
+
+static void logi_headset_remove(struct hid_device *hdev)
+{
+	struct logi_headset *headset = hid_get_drvdata(hdev);
+	unsigned long flags;
+
+	/* A power event arriving after this point does not queue the poll again. */
+	spin_lock_irqsave(&headset->lock, flags);
+	headset->removing = true;
+	spin_unlock_irqrestore(&headset->lock, flags);
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
2.56.0

