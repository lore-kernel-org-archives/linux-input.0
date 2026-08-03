Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3E435ED7
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784564; cv=none; b=Lo7OybQpge0WqXFrTbLI9gjKegBf5jyNcf++tvhZdlg3x91IiY8t7tP08XMU3rFDfQrEvYicEKQN10ALrZbk9QQ1755f5qhrr5xeofCJ8b+MOCDm3zfwxEz3xEpkdZ8g0ev5GQQCq88QakipcMipIYmY+nJxrzQvx3THRs/hZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784564; c=relaxed/simple;
	bh=THWVog3unA0NvwTDcfIG0DuOMYJeFfNiywgNl+mtlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBLfDkJAzR5TcspEj0ETlI8U7w0j8QMmmolDHomfljNvPSuHBP5yE2P5fYaS7vflA3+KYDeajbmWc10wPJkxrE+qpgiMb04M0V/OShUNteasGHJIcMnxK6X1okPQ8Dnd6Q87dR/aKH4wBJANKGfxrghNfIIM6Y0CrT02UHqYtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXzuB/ui; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXzuB/ui"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c149c5722so2183631cf.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784558; x=1786389358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNWKXcGaEITFt6tzp0oyfjfRvSew6Eexkq+ZL5uqIW4=;
        b=kXzuB/uim3OyoWC/OOxApjicZH0xAoJ9ZUvSMsufcQldbCBr3KHp3XYzKl9oXHkyvi
         gGBbZAD9fomhidn6yUncS5DaiBMvvc+U5VK4Uh0cAJ1uh+8HK++QyOpWbcm8CifMP3Ce
         41TSkCuAUrDrb8ysiEPYPQVV0KvjPe+sn7ZzUqi7tjv0u+1BI7dzG45Lo0F7aRHNDVm5
         Bq4kd0F3H+HuGl+15pdXX60WVJcrNNU51fUBHmCibP0NXYf1cH15GJGfnXni+RFuozER
         hMhzMC2nAG7M/nrTFDLDC/vdEWtIsmu+EC5qmRFCrgwxF76KT619WJKt1Y16N11Vsw+w
         PgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784558; x=1786389358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iNWKXcGaEITFt6tzp0oyfjfRvSew6Eexkq+ZL5uqIW4=;
        b=RYUfNTD0XtLuQybTgc22fEEmyWtbCVlfxRnlBu2fRAYuOZ8zCErx+EL5SrcfwKyWlO
         if9xUIxQClouNSlV/T65vcRFnyHqFZHWhPl4QM21J7UrzD9ptpGmUyCJrc7jZ/XJK3Wp
         gwPSDSoK3nWUhgeo4X7Rzr1FDn1bCTpAPFO84i7ElySUT2DSEvy3JIYrnJpJTQyuo1mk
         NvIeswVXBso4Ldu7pdsMuIofpIesCgyLPJZwgXzbGadcwUi4wNf9adeNtPN5KuA2SY4L
         zZlhe5Il53HnycJx335pgegHXANb7rkMiG+eO/PkWD5zAcPRKKiXGzzLkPTSn4imnVr7
         3nLA==
X-Gm-Message-State: AOJu0Yz+y9nymdobmvZXcziWosywT2ueBenumpPT1eteX/LKiadl/zKa
	A8u75gBymEKfxOgHx8yiPIiI6nl8D4Bib/25dRy+/iLUX0QjLmUYI/3A
X-Gm-Gg: AR+sD11PGMn7gdjs3QWHk9PUDgNvB9JIVAwPm3dxl1Vrx+X+bCDToQ7vutyCB0FZ1Cl
	R6U2NpY2JAEfHIxayEYdF2n1TDW6Aoc2sx+ynyICeSn3IdQll6h3Yj85P4qo/b85xMnke7Ef66K
	/Q07AeUhfTq9Pj6+z4dFQIST/Q/+ZdeTFuayCSglWnXbc90qy0LAHp5Qrdpd+K1nvvFA7Se9lBn
	bQfRW5DNHKb+Ywvecn00+5RSXmPs3DufLXT4l7q7nutrsw7uikffWkk6qPvrgI2q/VehrtpQp0l
	IkM3INrtunGComVyM3GUi1xp6g7S052Yc7nMAWxAUpLbNh+qutenBoNtfEVo8xnOcD6/s7Rldir
	E7YTbX8aIrlJm8KFm7hqPblOC+Dq4kXh9q8+v2yr4z9QgUynSIJQVC1eXhByE4I2eWq3EO21mbK
	lKRqj4lp7lEJAqFWg+Y3hmRXU5LQBeeL8V0Gp9TkRWbSymKGCZLgnuFIaO1I6a8KMrIyzHCjfao
	q9Mn1eoAuk8CNymjXM=
X-Received: by 2002:a05:622a:2992:b0:517:5f04:f23f with SMTP id d75a77b69052e-52cd3468470mr14407751cf.4.1785784558036;
        Mon, 03 Aug 2026 12:15:58 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:15:57 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 2/8] HID: steelseries: Split Arctis headset driver into separate module
Date: Mon,  3 Aug 2026 15:15:47 -0400
Message-ID: <20260803191553.66368-3-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803191553.66368-1-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all Arctis headset code (battery monitoring, wireless status,
power supply registration, raw event handling) from hid-steelseries.c
into the new hid-steelseries-arctis.c driver module.

hid-steelseries.c keeps the SRWS1 racing wheel and the MSI RGB LED
devices, while hid-steelseries-arctis.c handles the Arctis 1 (Xbox) and
Arctis 9 wireless headsets with their own device table, probe, remove,
and raw_event implementations.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/Makefile                 |   2 +-
 drivers/hid/hid-steelseries-arctis.c | 426 +++++++++++++++++++++++++++
 drivers/hid/hid-steelseries.c        | 366 +----------------------
 3 files changed, 428 insertions(+), 366 deletions(-)
 create mode 100644 drivers/hid/hid-steelseries-arctis.c

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 23e6e3dd0c56..4a172bd27b11 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -134,7 +134,7 @@ obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
 obj-$(CONFIG_HID_SONY)		+= hid-sony.o
 obj-$(CONFIG_HID_SPEEDLINK)	+= hid-speedlink.o
 obj-$(CONFIG_HID_STEAM)		+= hid-steam.o
-obj-$(CONFIG_HID_STEELSERIES)	+= hid-steelseries.o
+obj-$(CONFIG_HID_STEELSERIES)	+= hid-steelseries.o hid-steelseries-arctis.o
 obj-$(CONFIG_HID_SUNPLUS)	+= hid-sunplus.o
 obj-$(CONFIG_HID_GREENASIA)	+= hid-gaff.o
 obj-$(CONFIG_HID_THRUSTMASTER)	+= hid-tmff.o hid-thrustmaster.o
diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
new file mode 100644
index 000000000000..6cae2e00bd8b
--- /dev/null
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  HID driver for Steelseries arctis headsets
+ *
+ *  Copyright (c) 2023 Bastien Nocera
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/spinlock.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#include "hid-ids.h"
+
+#define STEELSERIES_ARCTIS_1_X		BIT(0)
+#define STEELSERIES_ARCTIS_9		BIT(1)
+
+struct steelseries_device {
+	struct hid_device *hdev;
+	unsigned long quirks;
+
+	struct delayed_work battery_work;
+	spinlock_t lock;
+	bool removed;
+
+	struct power_supply_desc battery_desc;
+	struct power_supply *battery;
+	uint8_t battery_capacity;
+	bool headset_connected;
+	bool battery_charging;
+	bool battery_registered;
+};
+
+#define STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS	3000
+
+#define ARCTIS_1_BATTERY_RESPONSE_LEN		8
+#define ARCTIS_9_BATTERY_RESPONSE_LEN		64
+static const char arctis_1_battery_request[] = { 0x06, 0x12 };
+static const char arctis_9_battery_request[] = { 0x00, 0x20 };
+
+static int steelseries_headset_request_battery(struct hid_device *hdev,
+	const char *request, size_t len)
+{
+	u8 *write_buf;
+	int ret;
+
+	/* Request battery information */
+	write_buf = kmemdup(request, len, GFP_KERNEL);
+	if (!write_buf)
+		return -ENOMEM;
+
+	hid_dbg(hdev, "Sending battery request report");
+	ret = hid_hw_raw_request(hdev, request[0], write_buf, len,
+				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+	if (ret < (int)len) {
+		hid_err(hdev, "hid_hw_raw_request() failed with %d\n", ret);
+		ret = -ENODATA;
+	}
+
+	kfree(write_buf);
+	return ret;
+}
+
+static void steelseries_headset_fetch_battery(struct hid_device *hdev)
+{
+	int ret = 0;
+
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X)
+		ret = steelseries_headset_request_battery(hdev,
+			arctis_1_battery_request, sizeof(arctis_1_battery_request));
+	else if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
+		ret = steelseries_headset_request_battery(hdev,
+			arctis_9_battery_request, sizeof(arctis_9_battery_request));
+
+	if (ret < 0)
+		hid_dbg(hdev,
+			"Battery query failed (err: %d)\n", ret);
+}
+
+static int battery_capacity_to_level(int capacity)
+{
+	if (capacity >= 50)
+		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+	if (capacity >= 20)
+		return POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+	return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+}
+
+static void steelseries_headset_battery_timer_tick(struct work_struct *work)
+{
+	struct steelseries_device *sd = container_of(work,
+		struct steelseries_device, battery_work.work);
+	struct hid_device *hdev = sd->hdev;
+
+	steelseries_headset_fetch_battery(hdev);
+}
+
+#define STEELSERIES_PREFIX "SteelSeries "
+#define STEELSERIES_PREFIX_LEN strlen(STEELSERIES_PREFIX)
+
+static int steelseries_headset_battery_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct steelseries_device *sd = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = sd->hdev->name;
+		while (!strncmp(val->strval, STEELSERIES_PREFIX, STEELSERIES_PREFIX_LEN))
+			val->strval += STEELSERIES_PREFIX_LEN;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "SteelSeries";
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (sd->headset_connected) {
+			val->intval = sd->battery_charging ?
+				POWER_SUPPLY_STATUS_CHARGING :
+				POWER_SUPPLY_STATUS_DISCHARGING;
+		} else
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = sd->battery_capacity;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		val->intval = battery_capacity_to_level(sd->battery_capacity);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static void
+steelseries_headset_set_wireless_status(struct hid_device *hdev,
+					bool connected)
+{
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	usb_set_wireless_status(intf, connected ?
+				USB_WIRELESS_STATUS_CONNECTED :
+				USB_WIRELESS_STATUS_DISCONNECTED);
+}
+
+static enum power_supply_property steelseries_headset_battery_props[] = {
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+};
+
+static int steelseries_headset_battery_register(struct steelseries_device *sd)
+{
+	static atomic_t battery_no = ATOMIC_INIT(0);
+	struct power_supply_config battery_cfg = { .drv_data = sd, };
+	unsigned long n;
+	int ret;
+
+	sd->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	sd->battery_desc.properties = steelseries_headset_battery_props;
+	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_headset_battery_props);
+	sd->battery_desc.get_property = steelseries_headset_battery_get_property;
+	sd->battery_desc.use_for_apm = 0;
+	n = atomic_inc_return(&battery_no) - 1;
+	sd->battery_desc.name = devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
+							"steelseries_headset_battery_%ld", n);
+	if (!sd->battery_desc.name)
+		return -ENOMEM;
+
+	/* avoid the warning of 0% battery while waiting for the first info */
+	steelseries_headset_set_wireless_status(sd->hdev, false);
+	sd->battery_capacity = 100;
+	sd->battery_charging = false;
+
+	sd->battery = devm_power_supply_register(&sd->hdev->dev,
+			&sd->battery_desc, &battery_cfg);
+	if (IS_ERR(sd->battery)) {
+		ret = PTR_ERR(sd->battery);
+		hid_err(sd->hdev,
+				"%s:power_supply_register failed with error %d\n",
+				__func__, ret);
+		return ret;
+	}
+	power_supply_powers(sd->battery, &sd->hdev->dev);
+
+	INIT_DELAYED_WORK(&sd->battery_work, steelseries_headset_battery_timer_tick);
+	/* Pairs with smp_load_acquire() in raw_event and remove paths */
+	smp_store_release(&sd->battery_registered, true);
+	steelseries_headset_fetch_battery(sd->hdev);
+
+	if (sd->quirks & STEELSERIES_ARCTIS_9) {
+		/* The first fetch_battery request can remain unanswered in some cases */
+		schedule_delayed_work(&sd->battery_work,
+				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
+	}
+
+	return 0;
+}
+
+static bool steelseries_is_vendor_usage_page(struct hid_device *hdev, uint8_t usage_page)
+{
+	if (hdev->rsize < 3)
+		return false;
+
+	return hdev->rdesc[0] == 0x06 &&
+		hdev->rdesc[1] == usage_page &&
+		hdev->rdesc[2] == 0xff;
+}
+
+static int steelseries_arctis_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct steelseries_device *sd;
+	int ret;
+
+	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
+	if (!sd)
+		return -ENOMEM;
+	hid_set_drvdata(hdev, sd);
+	sd->hdev = hdev;
+	sd->quirks = id->driver_data;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	if (sd->quirks & STEELSERIES_ARCTIS_9 &&
+			!steelseries_is_vendor_usage_page(hdev, 0xc0))
+		return -ENODEV;
+
+	spin_lock_init(&sd->lock);
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_open(hdev);
+	if (ret)
+		goto err_stop;
+
+	if (steelseries_headset_battery_register(sd) < 0)
+		hid_err(sd->hdev,
+			"Failed to register battery for headset\n");
+
+	return 0;
+
+err_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void steelseries_arctis_remove(struct hid_device *hdev)
+{
+	struct steelseries_device *sd;
+	unsigned long flags;
+
+	sd = hid_get_drvdata(hdev);
+	if (!sd)
+		return;
+
+	spin_lock_irqsave(&sd->lock, flags);
+	sd->removed = true;
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	/* Pairs with smp_store_release() in steelseries_headset_battery_register() */
+	if (smp_load_acquire(&sd->battery_registered))
+		cancel_delayed_work_sync(&sd->battery_work);
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static uint8_t steelseries_headset_map_capacity(uint8_t capacity, uint8_t min_in, uint8_t max_in)
+{
+	if (capacity >= max_in)
+		return 100;
+	if (capacity <= min_in)
+		return 0;
+	return (capacity - min_in) * 100 / (max_in - min_in);
+}
+
+static int steelseries_arctis_raw_event(struct hid_device *hdev,
+					struct hid_report *report, u8 *read_buf,
+					int size)
+{
+	struct steelseries_device *sd = hid_get_drvdata(hdev);
+	int capacity;
+	bool connected;
+	bool charging;
+	unsigned long flags;
+
+	/* Pairs with smp_store_release() in steelseries_headset_battery_register() */
+	if (!sd || !smp_load_acquire(&sd->battery_registered))
+		return 0;
+
+	capacity = sd->battery_capacity;
+	connected = sd->headset_connected;
+	charging = sd->battery_charging;
+
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
+		hid_dbg(sd->hdev,
+			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
+		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
+			memcmp(read_buf, arctis_1_battery_request, sizeof(arctis_1_battery_request))) {
+			if (!delayed_work_pending(&sd->battery_work))
+				goto request_battery;
+			return 0;
+		}
+		if (read_buf[2] == 0x01) {
+			connected = false;
+			capacity = 100;
+		} else {
+			connected = true;
+			capacity = read_buf[3];
+		}
+	}
+
+	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9) {
+		hid_dbg(sd->hdev,
+			"Parsing raw event for Arctis 9 headset (%*ph)\n", size, read_buf);
+		if (size < ARCTIS_9_BATTERY_RESPONSE_LEN) {
+			if (!delayed_work_pending(&sd->battery_work))
+				goto request_battery;
+			return 0;
+		}
+
+		if (read_buf[0] == 0xaa && read_buf[1] == 0x01) {
+			connected = true;
+			charging = read_buf[4] == 0x01;
+
+			/*
+			 * Found no official documentation about min and max.
+			 * Values defined by testing.
+			 */
+			capacity = steelseries_headset_map_capacity(read_buf[3], 0x68, 0x9d);
+		} else {
+			/*
+			 * Device is off and sends the last known status read_buf[1] == 0x03 or
+			 * there is no known status of the device read_buf[0] == 0x55
+			 */
+			connected = false;
+			charging = false;
+		}
+	}
+
+	if (connected != sd->headset_connected) {
+		hid_dbg(sd->hdev,
+			"Connected status changed from %sconnected to %sconnected\n",
+			sd->headset_connected ? "" : "not ",
+			connected ? "" : "not ");
+		sd->headset_connected = connected;
+		steelseries_headset_set_wireless_status(hdev, connected);
+	}
+
+	if (capacity != sd->battery_capacity) {
+		hid_dbg(sd->hdev,
+			"Battery capacity changed from %d%% to %d%%\n",
+			sd->battery_capacity, capacity);
+		sd->battery_capacity = capacity;
+		power_supply_changed(sd->battery);
+	}
+
+	if (charging != sd->battery_charging) {
+		hid_dbg(sd->hdev,
+			"Battery charging status changed from %scharging to %scharging\n",
+			sd->battery_charging ? "" : "not ",
+			charging ? "" : "not ");
+		sd->battery_charging = charging;
+		power_supply_changed(sd->battery);
+	}
+
+request_battery:
+	spin_lock_irqsave(&sd->lock, flags);
+	if (!sd->removed)
+		schedule_delayed_work(&sd->battery_work,
+				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
+	spin_unlock_irqrestore(&sd->lock, flags);
+
+	return 0;
+}
+
+static const struct hid_device_id steelseries_arctis_devices[] = {
+	{ /* SteelSeries Arctis 1 Wireless for XBox */
+		HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
+		.driver_data = STEELSERIES_ARCTIS_1_X },
+
+	{ /* SteelSeries Arctis 9 Wireless for XBox */
+		HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
+		.driver_data = STEELSERIES_ARCTIS_9 },
+
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, steelseries_arctis_devices);
+
+static struct hid_driver steelseries_arctis_driver = {
+	.name = "hid-steelseries-arctis",
+	.id_table = steelseries_arctis_devices,
+	.probe = steelseries_arctis_probe,
+	.remove = steelseries_arctis_remove,
+	.raw_event = steelseries_arctis_raw_event,
+};
+
+module_hid_driver(steelseries_arctis_driver);
+MODULE_DESCRIPTION("HID driver for Steelseries arctis headsets");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Christian Mayer <git@mayer-bgk.de>");
+MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 54efa70d128d..7292da0313e1 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -3,7 +3,6 @@
  *  HID driver for Steelseries devices
  *
  *  Copyright (c) 2013 Simon Wood
- *  Copyright (c) 2023 Bastien Nocera
  */
 
 /*
@@ -21,9 +20,7 @@
 #include "hid-ids.h"
 
 #define STEELSERIES_SRWS1		BIT(0)
-#define STEELSERIES_ARCTIS_1_X		BIT(1)
-#define STEELSERIES_ARCTIS_9		BIT(2)
-#define STEELSERIES_MSI_RGB		BIT(3)
+#define STEELSERIES_MSI_RGB		BIT(1)
 
 #define STEELSERIES_MSI_RGB_WVALUE 0x0300 /* Feature report, ID 0 */
 #define STEELSERIES_MSI_RGB_REPORT_LEN 524
@@ -39,17 +36,6 @@ struct steelseries_device {
 	struct hid_device *hdev;
 	unsigned long quirks;
 
-	struct delayed_work battery_work;
-	spinlock_t lock;
-	bool removed;
-
-	struct power_supply_desc battery_desc;
-	struct power_supply *battery;
-	uint8_t battery_capacity;
-	bool headset_connected;
-	bool battery_charging;
-	bool battery_registered;
-
 #if STEELSERIES_HAS_LEDS_MULTICOLOR
 	struct led_classdev_mc mc_cdev;
 	struct mc_subled subled_info[3];
@@ -362,199 +348,6 @@ static int steelseries_srws1_probe(struct hid_device *hdev,
 }
 #endif
 
-#define STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS	3000
-
-#define ARCTIS_1_BATTERY_RESPONSE_LEN		8
-#define ARCTIS_9_BATTERY_RESPONSE_LEN		64
-static const char arctis_1_battery_request[] = { 0x06, 0x12 };
-static const char arctis_9_battery_request[] = { 0x00, 0x20 };
-
-static int steelseries_headset_request_battery(struct hid_device *hdev,
-	const char *request, size_t len)
-{
-	u8 *write_buf;
-	int ret;
-
-	/* Request battery information */
-	write_buf = kmemdup(request, len, GFP_KERNEL);
-	if (!write_buf)
-		return -ENOMEM;
-
-	hid_dbg(hdev, "Sending battery request report");
-	ret = hid_hw_raw_request(hdev, request[0], write_buf, len,
-				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
-	if (ret < (int)len) {
-		hid_err(hdev, "hid_hw_raw_request() failed with %d\n", ret);
-		ret = -ENODATA;
-	}
-
-	kfree(write_buf);
-	return ret;
-}
-
-static void steelseries_headset_fetch_battery(struct hid_device *hdev)
-{
-	int ret = 0;
-
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X)
-		ret = steelseries_headset_request_battery(hdev,
-			arctis_1_battery_request, sizeof(arctis_1_battery_request));
-	else if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9)
-		ret = steelseries_headset_request_battery(hdev,
-			arctis_9_battery_request, sizeof(arctis_9_battery_request));
-
-	if (ret < 0)
-		hid_dbg(hdev,
-			"Battery query failed (err: %d)\n", ret);
-}
-
-static int battery_capacity_to_level(int capacity)
-{
-	if (capacity >= 50)
-		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
-	if (capacity >= 20)
-		return POWER_SUPPLY_CAPACITY_LEVEL_LOW;
-	return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
-}
-
-static void steelseries_headset_battery_timer_tick(struct work_struct *work)
-{
-	struct steelseries_device *sd = container_of(work,
-		struct steelseries_device, battery_work.work);
-	struct hid_device *hdev = sd->hdev;
-
-	steelseries_headset_fetch_battery(hdev);
-}
-
-#define STEELSERIES_PREFIX "SteelSeries "
-#define STEELSERIES_PREFIX_LEN strlen(STEELSERIES_PREFIX)
-
-static int steelseries_headset_battery_get_property(struct power_supply *psy,
-				enum power_supply_property psp,
-				union power_supply_propval *val)
-{
-	struct steelseries_device *sd = power_supply_get_drvdata(psy);
-	int ret = 0;
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_MODEL_NAME:
-		val->strval = sd->hdev->name;
-		while (!strncmp(val->strval, STEELSERIES_PREFIX, STEELSERIES_PREFIX_LEN))
-			val->strval += STEELSERIES_PREFIX_LEN;
-		break;
-	case POWER_SUPPLY_PROP_MANUFACTURER:
-		val->strval = "SteelSeries";
-		break;
-	case POWER_SUPPLY_PROP_PRESENT:
-		val->intval = 1;
-		break;
-	case POWER_SUPPLY_PROP_STATUS:
-		if (sd->headset_connected) {
-			val->intval = sd->battery_charging ?
-				POWER_SUPPLY_STATUS_CHARGING :
-				POWER_SUPPLY_STATUS_DISCHARGING;
-		} else
-			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
-		break;
-	case POWER_SUPPLY_PROP_SCOPE:
-		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = sd->battery_capacity;
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
-		val->intval = battery_capacity_to_level(sd->battery_capacity);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-	return ret;
-}
-
-static void
-steelseries_headset_set_wireless_status(struct hid_device *hdev,
-					bool connected)
-{
-	struct usb_interface *intf;
-
-	if (!hid_is_usb(hdev))
-		return;
-
-	intf = to_usb_interface(hdev->dev.parent);
-	usb_set_wireless_status(intf, connected ?
-				USB_WIRELESS_STATUS_CONNECTED :
-				USB_WIRELESS_STATUS_DISCONNECTED);
-}
-
-static enum power_supply_property steelseries_headset_battery_props[] = {
-	POWER_SUPPLY_PROP_MODEL_NAME,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_SCOPE,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-};
-
-static int steelseries_headset_battery_register(struct steelseries_device *sd)
-{
-	static atomic_t battery_no = ATOMIC_INIT(0);
-	struct power_supply_config battery_cfg = { .drv_data = sd, };
-	unsigned long n;
-	int ret;
-
-	sd->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
-	sd->battery_desc.properties = steelseries_headset_battery_props;
-	sd->battery_desc.num_properties = ARRAY_SIZE(steelseries_headset_battery_props);
-	sd->battery_desc.get_property = steelseries_headset_battery_get_property;
-	sd->battery_desc.use_for_apm = 0;
-	n = atomic_inc_return(&battery_no) - 1;
-	sd->battery_desc.name = devm_kasprintf(&sd->hdev->dev, GFP_KERNEL,
-						    "steelseries_headset_battery_%ld", n);
-	if (!sd->battery_desc.name)
-		return -ENOMEM;
-
-	/* avoid the warning of 0% battery while waiting for the first info */
-	steelseries_headset_set_wireless_status(sd->hdev, false);
-	sd->battery_capacity = 100;
-	sd->battery_charging = false;
-
-	sd->battery = devm_power_supply_register(&sd->hdev->dev,
-			&sd->battery_desc, &battery_cfg);
-	if (IS_ERR(sd->battery)) {
-		ret = PTR_ERR(sd->battery);
-		hid_err(sd->hdev,
-				"%s:power_supply_register failed with error %d\n",
-				__func__, ret);
-		return ret;
-	}
-	power_supply_powers(sd->battery, &sd->hdev->dev);
-
-	INIT_DELAYED_WORK(&sd->battery_work, steelseries_headset_battery_timer_tick);
-	/* Pairs with smp_load_acquire() in raw_event and remove paths */
-	smp_store_release(&sd->battery_registered, true);
-	steelseries_headset_fetch_battery(sd->hdev);
-
-	if (sd->quirks & STEELSERIES_ARCTIS_9) {
-		/* The first fetch_battery request can remain unanswered in some cases */
-		schedule_delayed_work(&sd->battery_work,
-				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
-	}
-
-	return 0;
-}
-
-static bool steelseries_is_vendor_usage_page(struct hid_device *hdev, uint8_t usage_page)
-{
-	if (hdev->rsize < 3)
-		return false;
-
-	return hdev->rdesc[0] == 0x06 &&
-		hdev->rdesc[1] == usage_page &&
-		hdev->rdesc[2] == 0xff;
-}
-
 static const struct dmi_system_id steelseries_msi_rgb_dmi_table[] = {
 	{
 		.matches = {
@@ -804,12 +597,6 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 	if (ret)
 		return ret;
 
-	if (sd->quirks & STEELSERIES_ARCTIS_9 &&
-			!steelseries_is_vendor_usage_page(hdev, 0xc0))
-		return -ENODEV;
-
-	spin_lock_init(&sd->lock);
-
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
 		return ret;
@@ -826,14 +613,8 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 				 ret);
 			sd->quirks &= ~STEELSERIES_MSI_RGB;
 		}
-		return 0;
 	}
 
-	if ((sd->quirks & (STEELSERIES_ARCTIS_1_X | STEELSERIES_ARCTIS_9)) &&
-	    steelseries_headset_battery_register(sd) < 0)
-		hid_err(sd->hdev,
-			"Failed to register battery for headset\n");
-
 	return 0;
 
 err_stop:
@@ -843,9 +624,6 @@ static int steelseries_probe(struct hid_device *hdev, const struct hid_device_id
 
 static void steelseries_remove(struct hid_device *hdev)
 {
-	struct steelseries_device *sd;
-	unsigned long flags;
-
 	if (hdev->product == USB_DEVICE_ID_STEELSERIES_SRWS1) {
 #if IS_BUILTIN(CONFIG_LEDS_CLASS) || \
     (IS_MODULE(CONFIG_LEDS_CLASS) && IS_MODULE(CONFIG_HID_STEELSERIES))
@@ -854,18 +632,6 @@ static void steelseries_remove(struct hid_device *hdev)
 		return;
 	}
 
-	sd = hid_get_drvdata(hdev);
-	if (!sd)
-		return;
-
-	spin_lock_irqsave(&sd->lock, flags);
-	sd->removed = true;
-	spin_unlock_irqrestore(&sd->lock, flags);
-
-	/* Pairs with smp_store_release() in steelseries_headset_battery_register() */
-	if (smp_load_acquire(&sd->battery_registered))
-		cancel_delayed_work_sync(&sd->battery_work);
-
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
@@ -886,137 +652,10 @@ static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
 	return rdesc;
 }
 
-static uint8_t steelseries_headset_map_capacity(uint8_t capacity, uint8_t min_in, uint8_t max_in)
-{
-	if (capacity >= max_in)
-		return 100;
-	if (capacity <= min_in)
-		return 0;
-	return (capacity - min_in) * 100 / (max_in - min_in);
-}
-
-static bool steelseries_is_headset(struct hid_device *hdev)
-{
-	return hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X ||
-	       hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9;
-}
-
-static int steelseries_headset_raw_event(struct hid_device *hdev,
-					struct hid_report *report, u8 *read_buf,
-					int size)
-{
-	struct steelseries_device *sd;
-	int capacity;
-	bool connected;
-	bool charging;
-	unsigned long flags;
-
-	if (!steelseries_is_headset(hdev))
-		return 0;
-
-	sd = hid_get_drvdata(hdev);
-	/* Pairs with smp_store_release() in steelseries_headset_battery_register() */
-	if (!sd || !smp_load_acquire(&sd->battery_registered))
-		return 0;
-
-	capacity = sd->battery_capacity;
-	connected = sd->headset_connected;
-	charging = sd->battery_charging;
-
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X) {
-		hid_dbg(sd->hdev,
-			"Parsing raw event for Arctis 1 headset (%*ph)\n", size, read_buf);
-		if (size < ARCTIS_1_BATTERY_RESPONSE_LEN ||
-		    memcmp(read_buf, arctis_1_battery_request, sizeof(arctis_1_battery_request))) {
-			if (!delayed_work_pending(&sd->battery_work))
-				goto request_battery;
-			return 0;
-		}
-		if (read_buf[2] == 0x01) {
-			connected = false;
-			capacity = 100;
-		} else {
-			connected = true;
-			capacity = read_buf[3];
-		}
-	}
-
-	if (hdev->product == USB_DEVICE_ID_STEELSERIES_ARCTIS_9) {
-		hid_dbg(sd->hdev,
-			"Parsing raw event for Arctis 9 headset (%*ph)\n", size, read_buf);
-		if (size < ARCTIS_9_BATTERY_RESPONSE_LEN) {
-			if (!delayed_work_pending(&sd->battery_work))
-				goto request_battery;
-			return 0;
-		}
-
-		if (read_buf[0] == 0xaa && read_buf[1] == 0x01) {
-			connected = true;
-			charging = read_buf[4] == 0x01;
-
-			/*
-			 * Found no official documentation about min and max.
-			 * Values defined by testing.
-			 */
-			capacity = steelseries_headset_map_capacity(read_buf[3], 0x68, 0x9d);
-		} else {
-			/*
-			 * Device is off and sends the last known status read_buf[1] == 0x03 or
-			 * there is no known status of the device read_buf[0] == 0x55
-			 */
-			connected = false;
-			charging = false;
-		}
-	}
-
-	if (connected != sd->headset_connected) {
-		hid_dbg(sd->hdev,
-			"Connected status changed from %sconnected to %sconnected\n",
-			sd->headset_connected ? "" : "not ",
-			connected ? "" : "not ");
-		sd->headset_connected = connected;
-		steelseries_headset_set_wireless_status(hdev, connected);
-	}
-
-	if (capacity != sd->battery_capacity) {
-		hid_dbg(sd->hdev,
-			"Battery capacity changed from %d%% to %d%%\n",
-			sd->battery_capacity, capacity);
-		sd->battery_capacity = capacity;
-		power_supply_changed(sd->battery);
-	}
-
-	if (charging != sd->battery_charging) {
-		hid_dbg(sd->hdev,
-			"Battery charging status changed from %scharging to %scharging\n",
-			sd->battery_charging ? "" : "not ",
-			charging ? "" : "not ");
-		sd->battery_charging = charging;
-		power_supply_changed(sd->battery);
-	}
-
-request_battery:
-	spin_lock_irqsave(&sd->lock, flags);
-	if (!sd->removed)
-		schedule_delayed_work(&sd->battery_work,
-				msecs_to_jiffies(STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS));
-	spin_unlock_irqrestore(&sd->lock, flags);
-
-	return 0;
-}
-
 static const struct hid_device_id steelseries_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1),
 	  .driver_data = STEELSERIES_SRWS1 },
 
-	{ /* SteelSeries Arctis 1 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
-	  .driver_data = STEELSERIES_ARCTIS_1_X },
-
-	{ /* SteelSeries Arctis 9 Wireless for XBox */
-	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
-	  .driver_data = STEELSERIES_ARCTIS_9 },
-
 #if STEELSERIES_HAS_LEDS_MULTICOLOR
 	{ /* MSI Raider A18 KLC */
 	  HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_MSI_KLC),
@@ -1037,12 +676,9 @@ static struct hid_driver steelseries_driver = {
 	.probe = steelseries_probe,
 	.remove = steelseries_remove,
 	.report_fixup = steelseries_srws1_report_fixup,
-	.raw_event = steelseries_headset_raw_event,
 };
 
 module_hid_driver(steelseries_driver);
 MODULE_DESCRIPTION("HID driver for Steelseries devices");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");
 MODULE_AUTHOR("Simon Wood <simon@mungewell.org>");
-MODULE_AUTHOR("Christian Mayer <git@mayer-bgk.de>");
-- 
2.55.0

