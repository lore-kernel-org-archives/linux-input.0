Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093044477F6
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128149; cv=none; b=irHqSjWrHp10/Tkv26AG/wj9MgOyoypthQf17xnalszNgj81dgTgX7jAN7SfryqLjIvsqoHOnxFY24ZL0wHDh2gj+p7swWVc3pNZAmg+1QU0bA7si0z61RVtRm+HR9v5ydPiH5/CT3SbKX0U4MrCYaSW765g6oYs+KowskHmsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128149; c=relaxed/simple;
	bh=7oG0qIqfjib0ZFOD/usDGYpM+CgsdyFvb0BJsfbMw6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzgBcG1GXaMTgQ3kObk06lqXjwB9zoXABMzpC8bFefOCCdLxx0y8tSiisb9jrUtjsMyEbrYHmNGBbm7QMkywZBBVWqlaoxeSHWJIwBSH23vFyfdqjNWc8WcP1dSnOvjzDnkQ1pz0I/7b2KMWX0nFr8l1z89W8rP0jgZXOPqmpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JARNk4JU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JARNk4JU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso12695755e9.2
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 05:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789128143; x=1789732943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8c604zC3xfPmb8PWs25Lz5gWSP83B2bpj/RLzXfD17w=;
        b=JARNk4JUberWlvKB26PGHSxKhp5Ww3mzDopMgH5BPq7k37SKS3PHZ6H9WGj3FBMPqL
         gh+qATQNHAY/7KjF4U/OP4jkQtp0A+ogm+lCmN1KaafyfreIKq33pNUEV8CxmizeDnXW
         vnU+lRRUhUrwp2mEvPuyQ0LAcduly2kbqVqoiHcxJieS9q8YCVKQIC3hseoxjA7q3eAs
         Vh63brvwlwqi55YOmeYBQCH5OUuahs3Od73G6Je+D1Z718HW7FP4z2TjsUybsPhuCGzL
         5s84WBZILVR5H1vS3mDQduOESkC7mA8QAQHKAq9dKk4AXadyH3H3Rt8HILYVsFLU4u5L
         FYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789128143; x=1789732943;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8c604zC3xfPmb8PWs25Lz5gWSP83B2bpj/RLzXfD17w=;
        b=c3UYjp4oTeGSxyvgqDlqCRQIwhsEwStXEIXqtyOBnsR1S3xZ57TF77oTVtvJUwYAaa
         nx7Ng7U3XXFSiDI6LHwcm1job01GqcwH6QjpnieEJgkkNCiPIP5iKbttyMrdieE01BtH
         SDeu1FmN8wTIsieo8uBM0rrCVkb7Pue/bnRHgi0AOkADsfks8xU0tZEK21eiONA7AU0m
         u7q2+OJcAfSkZgcmkV/8gPxDOJOjvSoqMOab0vNbfeFcZcQDLGYiScoHRGqAdNf4hbyN
         FeMiU0/RxCch5OHxxgEmti5UdSLMtquUKGXM1ihnAmZpIlZOlQEg/T+I2DoXWph7YKil
         +sew==
X-Forwarded-Encrypted: i=1; AKwUvByaMvCR2Y0SKsbNixOfjH1xtKNKJ5PbX6bE5bxBC50PdgQf9gjKmqEzwn/px771eSlWAl8FMPhkTAx0hA==@vger.kernel.org
X-Gm-Message-State: AFuF++msPOhaVbQ2w2i5joZODXK4nQB/FykULCHonYxkxsd4vKLlANxZ
	dbqqalOQ0ohkDow9S5+HC9lLc2b5AeeMVB2AWMNEgCrSzzzQ5q8K08WR
X-Gm-Gg: AYBFou1OEmhLQ4jaV+pkf0mAGOdzXvKtQwxQ7lBKGB+N7jZILo5Nn+7YNzaTFFWQ7L6
	YSU3IXg2zKbUUYEf9RWOpUpJxY3SzZorxhn/KjVbjbrxmhP6KWq8GB+iZPQyCoyXEF9SrXLU+Ta
	iYtVLQDO4W674+JT1id+n6D52ZConVlJ6zx66KkE7dwAeFS2X1rZwlO2C1sDW+09a1vrCyz1lvY
	Lr+bpMq2SBT8QptJy12SjnMW0IYVFGZqyBRlZLnP9hnlpxh0TORVp/cIVhwrOyNyWrDXwiBfOBw
	ejSNp5itP5w0/tzy5tlyJKnsnQXky61aCv9e+y4ThHVMZXoLsPKEyAfPzZxHos1mIE0xaRwb5E4
	8XijRTus0BopUaMllndTowVqYEljnjK9Pj+wTlDmnznuevXcMxc1TXvEi7yrgUYXKrObhvbwgoB
	Bemcx7+Gdeen5olQyt2IH9CJpucw2q3ZljQSAa4XrKjCSlVjCBG8CL4vNohsB8Uc0a0+KM6Zw4U
	xzuZF6XuBB8QObA0mLUaZYMMF59XGs70yrzx+vna5Dkovo8jy8p+WfL6G3K9awPIg==
X-Received: by 2002:a05:600c:860b:b0:49c:fa21:1c87 with SMTP id 5b1f17b1804b1-49e619d1bddmr38992645e9.28.1789128143018;
        Fri, 11 Sep 2026 05:02:23 -0700 (PDT)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c300e2sm165081935e9.8.2026.09.11.05.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:02:17 -0700 (PDT)
From: "=?UTF-8?q?M=C3=A9ven=20Car?=" <meven29@gmail.com>
X-Google-Original-From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: logitech-headset: add a battery driver for the PRO X 2
Date: Fri, 11 Sep 2026 14:02:08 +0200
Message-ID: <20260911120208.21698-1-meven@kde.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911115346.17133-1-meven@kde.org>
References: <20260911115346.17133-1-meven@kde.org>
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
Signed-off-by: Méven Car <meven@kde.org>
---
Changes since v1: the Signed-off-by line, which v1 was sent without by
mistake. The patch itself is unchanged.

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

