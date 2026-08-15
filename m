Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68438B127;
	Sat, 15 Aug 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.247.164.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837119; cv=none; b=j5PQZzDGPRz+IP9xRNQayzXFkPa/vbIfVgg/c3+GeLFsrqAa6EuP2fajgtg5nuvH2+SowF3zzdxmcU5D5gtuNfhn/tU9WdMmEAO8dJdC8k7gEXHytPTuDVSeJBe/+tDjAZD7ZlA35uD0ilm9GCKSu1mS82tP9REKPLBxUtbf8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837119; c=relaxed/simple;
	bh=mqZ6Y7HxihyXupTcuJhdwEK2aFvFz+bql6kQJO5ccQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8IKPAG1RTTOjDLOZVwlEf1t12s3z0Vv6EI0rKHn3jBAKepclm42qXXfmiY1ADt6hzXhChWr7d1W8KBZGu18fCshU3VstiY9PPesh0GT/7gpoKi0G6HDjQd50UO/Ea06dPwP8Q4K3c3yEFl83YxtvccybPzkRhB/fniShiC5K+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=BkXmDJK3; arc=none smtp.client-ip=84.247.164.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="BkXmDJK3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 475B21320D7F;
	Sun, 16 Aug 2026 01:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1786836780; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fq+ib6CJDXgw+geS7VV0JiNTSI03qytpAhfX/qpeYoA=;
	b=BkXmDJK3BV6wlK0E45nQ51w30xOdv/Xmp3o/0aAhllyzKW4oPj0298hbcUnzX2b+ErrlE2
	QE9UyyaPea3O9Pa9I5jF5F6CZiCX8V+K+EskVes9kvI2b0xcQ2LBEZaWCeiQxpKA+A9hu0
	N8HRm6fCEzn49e867EQEiVvp9Mrn/CD1BjoU9x2MUy/q3H3JznZvB/pc7Qt2iu8kfZCA9I
	PgYS1VwVGmoLDJ6X4pBAnbB9sU6djqayMkMSRX1kpFVad7sZg3nEnh61fO16PDadXfQvAE
	ZojOm56Dmv014PrAYoVtQL1p+TPcEypcJOEIuSKrp13LAQN2hWx8oiabIGg0WA==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Lode Willems <me@lodewillems.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo <leo@managarm.org>
Subject: [PATCH v5] HID: pulsar: add driver for Pulsar gaming mice
Date: Sun, 16 Aug 2026 01:32:40 +0200
Message-ID: <20260815233240.95981-1-nikolas@koesling.info>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add a HID driver for Pulsar wireless gaming mice (X2 V2, X2H, X2A,
Xlite V3). The driver exposes battery level, voltage, and charging
status through the power supply framework. It supports wired, 1kHz,
and 4kHz wireless dongle connections.

The driver also supports Kysona M600 ATK, VXE R1 SE+ and
VXE Dragonfly R1 Pro, which use the same protocol for reading
battery status and availability.

The protocol used by this driver is based on findings from
python-pulsar-mouse-tool by Andrew Rabert (MIT License):
https://github.com/andrewrabert/python-pulsar-mouse-tool

ATK vendor and device IDs were provided by Leo <leo@managarm.org>.
VXE and Kysona vendor and device IDS are from hid-kysona.c by
        Lode Willems <me@lodewillems.com>

Tested-by: Leo <leo@managarm.org>
Signed-off-by: Nikolas Koesling <nikolas@koesling.info>
---
Changes in v2:
- Add support for Kysona M600, ATK VXE R1 SE+, and VXE Dragonfly R1 Pro
- Add device type enum to distinguish vendors and generate proper
  battery names per vendor/model
- Add mutual exclusion with HID_KYSONA in Kconfig
- Add ATK and VXE vendor/device IDs to hid-ids.h
- Refactor model name generation: extract model_pulsar() and add
  model_atk() for vendor-specific battery naming
- Fall back to hdev->name for battery model when device info read
  fails on non-Pulsar devices (downgrade error to debug log)
- Remove POWER_SUPPLY_PROP_MANUFACTURER property
- Pass device type via driver_data in hid_device_id table

Changes in v3:
- Increase size of battery model name to hid device name size

Changes in v4:
- Call hid_hw_stop after cancel_work_sync
- Resolve use after free (mutex)

Changes in v5:
- Add bus number to battery name
- Fix battery cache during first 60s uptime
---
 MAINTAINERS              |   6 +
 drivers/hid/Kconfig      |  15 +
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-ids.h    |  11 +
 drivers/hid/hid-pulsar.c | 763 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 796 insertions(+)
 create mode 100644 drivers/hid/hid-pulsar.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..2e51a79366af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11552,6 +11552,12 @@ L:	linux-input@vger.kernel.org
 S:	Supported
 F:	drivers/hid/hid-playstation.c
 
+HID PULSAR DRIVER
+M:	Nikolas Koesling <nikolas@koesling.info>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-pulsar.c
+
 HID SENSOR HUB DRIVERS
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Jonathan Cameron <jic23@kernel.org>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f9bcaeb66385..17c3a0d0c94b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -504,12 +504,15 @@ config HID_KYE
 config HID_KYSONA
 	tristate "Kysona devices"
 	depends on USB_HID
+	depends on !HID_PULSAR
 	help
 	Support for Kysona mice.
 
 	Say Y here if you have a Kysona M600 mouse
 	and want to be able to read its battery capacity.
 
+	Note: The Kysona M600 is also supported by HID_PULSAR.
+
 config HID_UCLOGIC
 	tristate "UC-Logic"
 	depends on USB_HID
@@ -1312,6 +1315,18 @@ config HID_UNIVERSAL_PIDFF
 
 	  Supports Moza Racing, Cammus, VRS, FFBeast and more.
 
+config HID_PULSAR
+	tristate "Pulsar gaming mouse support"
+	depends on USB_HID
+	select POWER_SUPPLY
+	help
+	  Support for Pulsar gaming mice (X2 V2, X2H, X2A, Xlite V3)
+	  connected via 1kHz/4kHz USB dongle or wired.
+	  Provides battery level, voltage, and charging status
+	  monitoring via the power supply framework.
+
+	  Additional supported devices: Kysona M600, ATK VXE R1 SE+
+
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
 	depends on USB_HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 23e6e3dd0c56..fbc6cc8fc589 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -115,6 +115,7 @@ hid-picolcd-$(CONFIG_DEBUG_FS)		+= hid-picolcd_debugfs.o
 obj-$(CONFIG_HID_PLANTRONICS)	+= hid-plantronics.o
 obj-$(CONFIG_HID_PLAYSTATION)	+= hid-playstation.o
 obj-$(CONFIG_HID_PRIMAX)	+= hid-primax.o
+obj-$(CONFIG_HID_PULSAR)	+= hid-pulsar.o
 obj-$(CONFIG_HID_PXRC)		+= hid-pxrc.o
 obj-$(CONFIG_HID_RAKK)		+= hid-rakk.o
 obj-$(CONFIG_HID_RAPOO) += hid-rapoo.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1059922baaac..7a73fda02a0f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -251,6 +251,12 @@
 #define USB_VENDOR_ID_ATMEL_V_USB	0x16c0
 #define USB_DEVICE_ID_ATMEL_V_USB	0x05df
 
+#define USB_VENDOR_ID_ATK	0x373B
+#define USB_DEVICE_ID_ATK_VXE_R1_SE_WIRED	0xF58F
+
+#define USB_VENDOR_ID_ATK_ALT		0x3554
+#define USB_DEVICE_ID_ATK_VXE_R1_SE_DONGLE	0x1085
+
 #define USB_VENDOR_ID_AUREAL		0x0755
 #define USB_DEVICE_ID_AUREAL_W01RN	0x2626
 
@@ -1206,6 +1212,11 @@
 #define USB_VENDOR_ID_PRODIGE		0x05af
 #define USB_DEVICE_ID_PRODIGE_CORDLESS	0x3062
 
+#define USB_VENDOR_ID_PULSAR	0x3554
+#define USB_DEVICE_ID_PULSAR_WIRED	0xf507
+#define USB_DEVICE_ID_PULSAR_1KHZ	0xf508
+#define USB_DEVICE_ID_PULSAR_4KHZ	0xf509
+
 #define I2C_VENDOR_ID_QTEC              0x6243
 
 #define USB_VENDOR_ID_QUANTA		0x0408
diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
new file mode 100644
index 000000000000..b90284a00776
--- /dev/null
+++ b/drivers/hid/hid-pulsar.c
@@ -0,0 +1,763 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for pulsar mice
+ *
+ * Supported pulsar devices:
+ *	- Pulsar
+ *		- X2 V2
+ *		- X2H
+ *		- X2A
+ *		- Xlite V3
+ *	- Kysona
+ *		-M600
+ *	- ATK
+ *		- VXE R1 SE+
+ *	- VXE
+ *		- Dragonfly R1 Pro
+ *
+ * Copyright (c) 2026 Nikolas Koesling
+ */
+
+#include <linux/hid.h>
+#include <linux/usb.h>
+#include <linux/power_supply.h>
+#include "hid-ids.h"
+
+/* ----- driver settings ----- */
+#define CMD_TIMEOUT_MSEC 100
+#define MAX_BATTERY_AGE_NS 60000000000ULL	/* 60s */
+#define MAX_UNAVAIL_AGE_NS 5000000000ULL	/* 5s */
+#define INIT_RETRIES 1
+#define INIT_DELAY_MSEC 1000
+
+/* ----- constants ----- */
+#define USB_INTERFACE 1
+#define USB_PAYLOAD_LEN 17
+#define CMD_HID_REPORT_ID 0x08
+#define CHECKSUM_MAGIC 0x55
+#define DEV_INFO_LEN 4
+#define CON_1K 0x00
+#define CON_4K 0x01
+#define CON_WIRED 0x02
+
+/* ----- device commands ----- */
+enum pulsar_cmd {
+	CMD_NONE = 0,
+	CMD_INFO = 0x01,
+	CMD_STATUS = 0x03,
+	CMD_POWER = 0x04,
+	CMD_EVENT = 0x0a,	/* recv only */
+};
+
+#define EVENT_PWR 0x40		/* power status change */
+#define EVENT_PWR_CHK 0xf9
+
+/* ----- device types ----- */
+enum dev_type {
+	TYPE_UNKNOWN,
+	TYPE_PULSAR,
+	TYPE_KYSONA,
+	TYPE_ATK,
+	TYPE_VXE,
+};
+
+/* ----- structs ----- */
+struct pulsar_battery {
+	struct power_supply *ps;
+	struct power_supply_desc desc;
+	char name[48];
+	char model[MAX(32, sizeof((struct hid_device){}).name)];
+	u8 level;		/* percent */
+	u16 voltage;		/* millivolts */
+	bool conn;
+	bool available;
+	bool refresh;		/* cache invalid, read regardless of age */
+	u64 last_read;
+	u64 last_status;
+};
+
+struct pulsar_data {
+	struct hid_device *hdev;
+
+	enum dev_type type;
+
+	spinlock_t raw_event_lock;	/* protects response_buf, pending_event */
+	struct mutex lock_cmd;		/* serializes device command execution */
+	struct rw_semaphore lock_bat;	/* protects battery state */
+
+	struct completion response_ready;
+	u8 response_buf[USB_PAYLOAD_LEN];
+	u8 pending_event;
+	struct work_struct power_uevent_work;
+	struct delayed_work init_work;
+	unsigned int init_retries;
+	atomic_t device_verified;
+	atomic_t stopping;
+
+	struct pulsar_battery battery;
+};
+
+static u8 calc_checksum(const u8 *data, size_t len)
+{
+	u8 sum = 0;
+
+	for (size_t i = 0; i < len - 1; i++)
+		sum += data[i];
+
+	return (u8)CHECKSUM_MAGIC - sum;
+}
+
+static int send_cmd(struct hid_device *hdev, const u8 *buf, size_t len)
+{
+	int ret;
+	u8 *dmabuf;
+
+	hid_dbg(hdev, "send command: %*ph\n", (int)len, buf);
+
+	dmabuf = kmemdup(buf, len, GFP_KERNEL);
+	if (!dmabuf)
+		return -ENOMEM;
+
+	/* device listens only to control transfers */
+	ret = hid_hw_raw_request(hdev, dmabuf[0], dmabuf, len,
+				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(dmabuf);
+
+	if (ret < 0)
+		return ret;
+	if (ret != len)
+		return -EIO;
+
+	return 0;
+}
+
+static int exec_cmd(struct pulsar_data *drvdata, const u8 *payload,
+		    u8 *response, unsigned int timeout_msec)
+{
+	struct hid_device *hdev = drvdata->hdev;
+	unsigned long flags;
+	int ret;
+	unsigned long timeout;
+	u8 checksum;
+
+	if (atomic_read(&drvdata->stopping))
+		return -ENODEV;
+
+	mutex_lock(&drvdata->lock_cmd);
+
+	if (atomic_read(&drvdata->stopping)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	spin_lock_irqsave(&drvdata->raw_event_lock, flags);
+	reinit_completion(&drvdata->response_ready);
+	drvdata->pending_event = payload[1];
+	spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
+
+	ret = send_cmd(hdev, payload, USB_PAYLOAD_LEN);
+
+	if (ret < 0) {
+		spin_lock_irqsave(&drvdata->raw_event_lock, flags);
+		drvdata->pending_event = CMD_NONE;
+		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
+		hid_err(hdev, "failed to send command 0x%02x: %d\n",
+			payload[1], ret);
+		goto out;
+	}
+
+	timeout = wait_for_completion_timeout(&drvdata->response_ready,
+					      msecs_to_jiffies(timeout_msec));
+
+	if (timeout == 0) {
+		spin_lock_irqsave(&drvdata->raw_event_lock, flags);
+		drvdata->pending_event = CMD_NONE;
+		spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	spin_lock_irqsave(&drvdata->raw_event_lock, flags);
+	memcpy(response, drvdata->response_buf, USB_PAYLOAD_LEN);
+	spin_unlock_irqrestore(&drvdata->raw_event_lock, flags);
+
+	/* validate checksum */
+	checksum = calc_checksum(response, USB_PAYLOAD_LEN);
+
+	if (response[USB_PAYLOAD_LEN - 1] != checksum) {
+		hid_err(hdev,
+			"invalid checksum in response: 0x%02x (expected 0x%02x)\n",
+			response[USB_PAYLOAD_LEN - 1], checksum);
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = 0;
+out:
+	mutex_unlock(&drvdata->lock_cmd);
+	return ret;
+}
+
+static inline void finalize_payload(u8 *payload, u8 cmd)
+{
+	payload[0] = CMD_HID_REPORT_ID;
+	payload[1] = cmd;
+	payload[USB_PAYLOAD_LEN - 1] = calc_checksum(payload, USB_PAYLOAD_LEN);
+}
+
+static int read_status(struct pulsar_data *drvdata)
+{
+	int ret;
+	u8 payload[USB_PAYLOAD_LEN] = { 0 };
+	u8 response[USB_PAYLOAD_LEN];
+
+	finalize_payload(payload, CMD_STATUS);
+
+	ret = exec_cmd(drvdata, payload, response, CMD_TIMEOUT_MSEC);
+	if (ret < 0)
+		return ret;
+	if (response[6] > 0x01)
+		return -EIO;
+
+	return (int)response[6];	/* 1: available, 0: not available */
+}
+
+static int read_device_info(struct pulsar_data *drvdata, u8 *data)
+{
+	int ret;
+	u8 payload[USB_PAYLOAD_LEN] = { 0 };
+	u8 response[USB_PAYLOAD_LEN];
+
+	payload[5] = DEV_INFO_LEN * 2;
+	get_random_bytes(payload + 6, DEV_INFO_LEN);
+	finalize_payload(payload, CMD_INFO);
+
+	ret = exec_cmd(drvdata, payload, response, CMD_TIMEOUT_MSEC);
+	if (ret < 0)
+		return ret;
+
+	if (data)
+		memcpy(data, response + 6 + DEV_INFO_LEN, DEV_INFO_LEN);
+
+	response[8 + DEV_INFO_LEN] = 0;
+	response[9 + DEV_INFO_LEN] = 0;
+
+	/*
+	 * Verify challenge-response. Response layout from offset 6:
+	 *   [0..3] encoded response   [4..7] device info (ID + conn type)
+	 *
+	 * resp[i] = challenge[i] * (i+1) + challenge[(i+1) % 4] + device_id[i]
+	 *
+	 * bytes 6..7 are zeroed for verification.
+	 */
+	for (int i = 0; i < DEV_INFO_LEN; i++) {
+		u8 expect = response[6 + DEV_INFO_LEN + i];
+		u8 actual = response[6 + i] - (i + 1) * payload[6 + i] -
+		    payload[6 + (i + 1) % DEV_INFO_LEN];
+
+		if (expect != actual) {
+			hid_warn(drvdata->hdev,
+				 "device info[%d] mismatch: %02x != %02x\n",
+				 i, expect, actual);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int read_power(struct pulsar_data *drvdata)
+{
+	u64 now;
+	bool need_status, need_power;
+	int ret = 0;
+	u8 payload[USB_PAYLOAD_LEN] = { 0 };
+	u8 response[USB_PAYLOAD_LEN];
+	struct pulsar_battery *battery = &drvdata->battery;
+
+	now = ktime_get_ns();
+
+	down_write(&drvdata->lock_bat);
+
+	need_status = battery->refresh ||
+	    (now - battery->last_status >= MAX_UNAVAIL_AGE_NS);
+	need_power = battery->available &&
+	    (battery->refresh ||
+	     now - battery->last_read >= MAX_BATTERY_AGE_NS);
+
+	if (!need_status && !need_power)
+		goto unlock;
+
+	if (need_status) {
+		ret = read_status(drvdata);
+		if (ret < 0) {
+			hid_err(drvdata->hdev,
+				"%s: failed to read status: %d\n",
+				__func__, ret);
+			goto unlock;
+		}
+
+		battery->last_status = now;
+
+		if (!ret) {
+			battery->available = false;
+			battery->refresh = false;
+			goto unlock;
+		}
+
+		/* device just became available, force power read */
+		if (!battery->available)
+			need_power = true;
+	}
+
+	if (!need_power)
+		goto unlock;
+
+	finalize_payload(payload, CMD_POWER);
+
+	ret = exec_cmd(drvdata, payload, response, CMD_TIMEOUT_MSEC);
+	if (ret < 0) {
+		hid_err(drvdata->hdev, "%s: failed to read power: %d\n",
+			__func__, ret);
+		goto unlock;
+	}
+
+	if (response[6] > 100 || response[7] > 0x01) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	battery->available = true;
+	battery->level = response[6];
+	battery->conn = response[7] == 1;
+	battery->voltage = (response[8] << 8) | response[9];
+	battery->last_read = now;
+	battery->refresh = false;
+
+	hid_dbg(drvdata->hdev, "%s: level=%d, conn=%d, voltage=%d\n",
+		__func__, battery->level, battery->conn, battery->voltage);
+
+unlock:
+	up_write(&drvdata->lock_bat);
+	return ret;
+}
+
+static int battery_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct pulsar_data *drvdata;
+	int ret;
+
+	drvdata = power_supply_get_drvdata(psy);
+
+	ret = read_power(drvdata);
+	if (ret)
+		return ret;
+
+	down_read(&drvdata->lock_bat);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!drvdata->battery.available)
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (drvdata->battery.conn && drvdata->battery.level < 100)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (drvdata->battery.conn && drvdata->battery.level >= 100)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = drvdata->battery.level;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = drvdata->battery.voltage * 1000;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = drvdata->battery.available;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = drvdata->battery.model;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	up_read(&drvdata->lock_bat);
+	return ret;
+}
+
+static void power_uevent_work_handler(struct work_struct *work)
+{
+	struct pulsar_data *drvdata;
+	int ret;
+
+	drvdata = container_of(work, struct pulsar_data, power_uevent_work);
+
+	if (atomic_read(&drvdata->stopping))
+		return;
+
+	down_write(&drvdata->lock_bat);
+	drvdata->battery.refresh = true;
+	up_write(&drvdata->lock_bat);
+
+	ret = read_power(drvdata);
+	if (ret < 0) {
+		hid_err(drvdata->hdev, "%s: failed to read power: %d\n",
+			__func__, ret);
+		return;
+	}
+
+	power_supply_changed(drvdata->battery.ps);
+}
+
+static int pulsar_raw_event(struct hid_device *hdev,
+			    struct hid_report *report, u8 *data, int size)
+{
+	struct pulsar_data *drvdata;
+
+	drvdata = hid_get_drvdata(hdev);
+	if (!drvdata)
+		return 0;
+
+	hid_dbg(hdev, "received raw event: %*ph\n", size, data);
+
+	if (size != USB_PAYLOAD_LEN || data[0] != CMD_HID_REPORT_ID)
+		return 0;
+
+	if (data[1] != CMD_EVENT) {
+		spin_lock(&drvdata->raw_event_lock);
+		if (drvdata->pending_event != data[1]) {
+			spin_unlock(&drvdata->raw_event_lock);
+			return 0;
+		}
+		memcpy(drvdata->response_buf, data, size);
+		drvdata->pending_event = CMD_NONE;
+		complete(&drvdata->response_ready);
+		spin_unlock(&drvdata->raw_event_lock);
+		return 1;
+	}
+
+	if (!atomic_read(&drvdata->device_verified))
+		return 0;
+
+	if (data[6] == EVENT_PWR && data[USB_PAYLOAD_LEN - 1] == EVENT_PWR_CHK) {
+		schedule_work(&drvdata->power_uevent_work);
+		hid_dbg(hdev, "received power event\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_property pulsar_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS, POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW, POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_MODEL_NAME, POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_PRESENT
+};
+
+static void init_power_supply_desc(struct pulsar_data *drvdata)
+{
+	drvdata->battery.desc.name = drvdata->battery.name;
+	drvdata->battery.desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	drvdata->battery.desc.properties = pulsar_battery_props;
+	drvdata->battery.desc.num_properties = ARRAY_SIZE(pulsar_battery_props);
+	drvdata->battery.desc.get_property = battery_get_property;
+}
+
+static void model_pulsar(u8 *device_id, struct pulsar_data *drvdata)
+{
+	u16 model_id;
+	const char *con_type = "unknown";
+
+	model_id = device_id[0] << 8 | device_id[1];
+
+	switch (device_id[2]) {
+	case CON_1K:
+		con_type = "1kHz";
+		break;
+	case CON_4K:
+		con_type = "4kHz";
+		break;
+	case CON_WIRED:
+		con_type = "wired";
+		break;
+	}
+
+	switch (model_id) {
+	case 0x060a:
+	case 0x060b:
+	case 0x0612:
+	case 0x0613:
+	case 0x0614:
+	case 0x0615:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "Pulsar X2 V2 (%s)", con_type);
+		break;
+	case 0x060c:
+	case 0x060d:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "Pulsar X2H (%s)", con_type);
+		break;
+	case 0x0607:
+	case 0x060e:
+	case 0x060f:
+	case 0x0610:
+	case 0x0611:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "Pulsar Xlite V3 (%s)", con_type);
+		break;
+	case 0x0608:
+	case 0x0609:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "Pulsar X2A (%s)", con_type);
+		break;
+	default:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "Pulsar unknown (%s)", con_type);
+	}
+}
+
+static void model_atk(u8 *device_id, struct pulsar_data *drvdata)
+{
+	u16 model_id;
+	const char *con_type = "unknown";
+
+	model_id = device_id[0] << 8 | device_id[1];
+
+	switch (device_id[2]) {
+	case CON_1K:
+		con_type = "1kHz";
+		break;
+	case CON_4K:
+		con_type = "4kHz";
+		break;
+	case CON_WIRED:
+		con_type = "wired";
+		break;
+	}
+
+	switch (model_id) {
+	case 0x0220:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "ATK VXE R1 SE+ (%s)", con_type);
+		break;
+	default:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "Unknown ATK (%s)", con_type);
+	}
+}
+
+static void pulsar_init_work(struct work_struct *work)
+{
+	struct pulsar_data *drvdata;
+	struct hid_device *hdev;
+	struct power_supply_config psy_cfg;
+	int ret;
+	u8 data[DEV_INFO_LEN];
+
+	drvdata = container_of(work, struct pulsar_data, init_work.work);
+	hdev = drvdata->hdev;
+
+	ret = read_device_info(drvdata, data);
+	if (ret == -ETIMEDOUT) {
+		if (drvdata->init_retries--) {
+			hid_dbg(hdev,
+				"device info read timed out, retrying (%u left)\n",
+				drvdata->init_retries);
+			schedule_delayed_work(&drvdata->init_work,
+					      msecs_to_jiffies
+					      (INIT_DELAY_MSEC));
+			return;
+		}
+		hid_err(hdev, "device info read timed out, giving up\n");
+		return;
+	}
+	if (ret < 0) {
+		if (drvdata->type == TYPE_PULSAR) {
+			hid_err(hdev, "failed to read device info: %d\n", ret);
+			return;
+		}
+		hid_dbg(hdev, "failed to read device info: %d\n", ret);
+		snprintf(drvdata->battery.model,
+			 sizeof(drvdata->battery.model), "%s", hdev->name);
+		goto register_battery;
+	}
+
+	hid_dbg(hdev, "device info: %*ph (%d)\n", DEV_INFO_LEN, data, ret);
+
+	switch (drvdata->type) {
+	case TYPE_PULSAR:
+		model_pulsar(data, drvdata);
+		break;
+	case TYPE_ATK:
+		model_atk(data, drvdata);
+		break;
+	default:
+		snprintf(drvdata->battery.model, sizeof(drvdata->battery.model),
+			 "%s", hdev->name);
+	}
+
+register_battery:
+	init_power_supply_desc(drvdata);
+
+	psy_cfg = (struct power_supply_config) {.drv_data = drvdata };
+	drvdata->battery.ps =
+	    devm_power_supply_register(&hdev->dev, &drvdata->battery.desc,
+				       &psy_cfg);
+	if (IS_ERR(drvdata->battery.ps)) {
+		hid_err(hdev, "failed to register battery: %ld\n",
+			PTR_ERR(drvdata->battery.ps));
+		drvdata->battery.ps = NULL;
+		return;
+	}
+
+	atomic_set(&drvdata->device_verified, 1);
+	hid_info(hdev, "device verified, battery registered\n");
+}
+
+static int pulsar_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	int ret;
+	struct usb_interface *intf;
+	struct usb_device *usbdev;
+	struct pulsar_data *drvdata;
+	struct hid_report *report_in;
+	struct hid_report *report_out;
+
+	if (!hid_is_usb(hdev))
+		return -ENODEV;
+
+	ret = hid_parse(hdev);
+	if (ret < 0) {
+		hid_err(hdev, "hid_parse failed: %d\n", ret);
+		return ret;
+	}
+
+	intf = to_usb_interface(hdev->dev.parent);
+	report_in =
+	    hdev->report_enum[HID_INPUT_REPORT].report_id_hash[CMD_HID_REPORT_ID];
+	report_out =
+	    hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[CMD_HID_REPORT_ID];
+
+	if (!report_in || !report_out ||
+	    hid_report_len(report_in) != USB_PAYLOAD_LEN ||
+	    hid_report_len(report_out) != USB_PAYLOAD_LEN ||
+	    intf->cur_altsetting->desc.bInterfaceNumber != USB_INTERFACE)
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->hdev = hdev;
+	drvdata->type = id->driver_data;
+
+	mutex_init(&drvdata->lock_cmd);
+	init_rwsem(&drvdata->lock_bat);
+
+	usbdev = interface_to_usbdev(intf);
+
+	spin_lock_init(&drvdata->raw_event_lock);
+	hid_set_drvdata(hdev, drvdata);
+	init_completion(&drvdata->response_ready);
+	INIT_WORK(&drvdata->power_uevent_work, power_uevent_work_handler);
+	INIT_DELAYED_WORK(&drvdata->init_work, pulsar_init_work);
+	drvdata->init_retries = INIT_RETRIES;
+	drvdata->battery.refresh = true;
+
+	snprintf(drvdata->battery.name, sizeof(drvdata->battery.name),
+		 "pulsar_%s_battery", dev_name(&usbdev->dev));
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret < 0) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret < 0) {
+		hid_err(hdev, "hw open failed\n");
+		goto err_open;
+	}
+
+	schedule_delayed_work(&drvdata->init_work, 0);
+
+	return 0;
+
+err_open:
+	hid_hw_stop(hdev);
+	cancel_work_sync(&drvdata->power_uevent_work);
+	return ret;
+}
+
+static void pulsar_remove(struct hid_device *hdev)
+{
+	struct pulsar_data *drvdata;
+
+	drvdata = hid_get_drvdata(hdev);
+	if (!drvdata) {
+		hid_hw_stop(hdev);
+		return;
+	}
+
+	atomic_set(&drvdata->stopping, 1);
+
+	/*
+	 * Drain init_work before the device is torn down.
+	 * It cannot requeue itself because exec_cmd() fails with -ENODEV.
+	 */
+	cancel_delayed_work_sync(&drvdata->init_work);
+
+	/* wait for active device i/o (exec_cmd) */
+	mutex_lock(&drvdata->lock_cmd);
+	hid_hw_close(hdev);
+	mutex_unlock(&drvdata->lock_cmd);
+
+	hid_hw_stop(hdev);
+	cancel_work_sync(&drvdata->power_uevent_work);
+}
+
+static const struct hid_device_id pulsar_table[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PULSAR, USB_DEVICE_ID_PULSAR_WIRED),
+	  .driver_data = TYPE_PULSAR },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PULSAR, USB_DEVICE_ID_PULSAR_1KHZ),
+	  .driver_data = TYPE_PULSAR },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PULSAR, USB_DEVICE_ID_PULSAR_4KHZ),
+	  .driver_data = TYPE_PULSAR },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600_DONGLE),
+	  .driver_data = TYPE_KYSONA },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600_WIRED),
+	  .driver_data = TYPE_KYSONA },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATK, USB_DEVICE_ID_ATK_VXE_R1_SE_DONGLE),
+	  .driver_data = TYPE_ATK },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ATK_ALT, USB_DEVICE_ID_ATK_VXE_R1_SE_WIRED),
+	  .driver_data = TYPE_ATK },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_DONGLE),
+	  .driver_data = TYPE_VXE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_WIRED),
+	  .driver_data = TYPE_VXE },
+	{ }
+};
+
+static struct hid_driver pulsar_driver = {
+	.name = "pulsar",
+	.id_table = pulsar_table,
+	.probe = pulsar_probe,
+	.remove = pulsar_remove,
+	.raw_event = pulsar_raw_event,
+};
+
+module_hid_driver(pulsar_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("HID driver for pulsar mice");
+MODULE_AUTHOR("Nikolas Koesling");
+MODULE_DEVICE_TABLE(hid, pulsar_table);

base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
-- 
2.55.0

