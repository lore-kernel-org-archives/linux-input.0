Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670943;
	b=SBjwbUL32xv6TXei/LP7bhV4c2PLuCP770T6AwaVE+MZUmBIl4iAKYPGpyGBKj3loSjo
	 nEUh2ud6MjPDbV5LNJ4+WPiQlXsMdfrZn9VxU2iQjMQzbeXwnRwbgBCkucjCArn96cMei
	 EsHUVfapq814Qe1BG1OjpKBW+klGRbfNSKN1liTveLwZ6acQIBHtv+81t2gPbCAnzNBEY
	 uWBIC5MWi3JQiFL7925oL5wpHz/lXEkJrTVXgYMNTe/Qf+VFh3AXt93E5UjzkiFjCTZs5
	 j7g4EPpg1JhSCmmIGGqokyr7+RmdivsKEflYevfzQcBBVWEwqC3AHYnWgro+ieXQrSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qGDumbZ6QNJHe0qnRFO/h4j9er9Rsffo3+e4MuXt5PY=;
	b=h6UctH79nP6n4h+/8LXGhu5Ier2YQsoXb61IKs63qQpqSkjsLj7JEsiuHBImskFG+l4l
	 c9HpigZ4/36kG/+LAbwdtEgxYbJfcLnKJoBZl5Y3EMawm/OEvCQr2zXFtzxXYqgdzAutq
	 J1wSpllPhld03/yJDodzsUScc4HS+RM4tvjCDRLsod9s+8dho31ZB14Go4B5v6icJRYrg
	 ZgPDPR1V7xiQXidJ/JpF697xJ/psZqJ1mV8boAsg8Hj9hCvnYdEJfegAUssQLb71ZT/ty
	 3eABSiLf8/8l1abSqLbDz6gToDWfG1MxZ4Y3yzM8FqDL8ME7cUnwY43HZWaWjsfiAMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAtHDulJ;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D8606A326
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 01:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9D8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAtHDulJ
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso1579016a12.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 17:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793670941; x=1794275741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGDumbZ6QNJHe0qnRFO/h4j9er9Rsffo3+e4MuXt5PY=;
        b=aAtHDulJAd24yaDyPCZ1dlHh6zxava+NXVhUqPoXdKVimu5EzEg4L3ddFVf3UdBjaP
         zJdJ0VypB+oX0pEdEeeAGz0TZYf3/D33H2htNsMM5dTXd9pYr2xc88Bmq5Z/ozn1p1Bp
         8OmEwNF8PRV6of3QC5VclywSD9s4oEDOL0zwHuR/LJeZM8Uoug9rGf3Rs56PCe7g46Lv
         hUmxOCiXNLRxt4qPI8GZIfPIMnAIZDx2zgq6TsL8lWMnl46dUHmVYchmXE+2Pfp39u64
         /my+l0DI2+KbxzOta4fL80HVYSGiS+YC1fqi1KUdiTzE6nYjGNqCDlGGqWWxHuedkiiE
         eALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793670941; x=1794275741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGDumbZ6QNJHe0qnRFO/h4j9er9Rsffo3+e4MuXt5PY=;
        b=OG0Gpay0Kud8LmQODdSYNQwOgxQy7dzGHpBRdhUunMfgcLyAl9+cliaUE1pA92tuAb
         hPvOcI//Xfw7taLFM2+5qc9784ZUV7WWWLop6/GCOGyRmTwRPAr3+FEPYI5G6X5XOxfy
         OjjBSh4epaH8mtc1qR0MJ7nrQPjN5gX1GHba5y/d36QQcb6ucLOgC7J8KX5k0fKYyKWx
         bTrO5DIhmZY7KM5yAOR0G7rr036mn4VpnfcqVPECDK7+2+Ai6g9dY3bzMjbP1Lme52ob
         QuA1RpZgGnbhtSR4qmhcbJoIlk9f9fbNT7VpKOInrYlt5P7NUckAHro+D0Xm/SEV4CZr
         JMaw==
X-Gm-Message-State: APuU4Z/IifMlQRkf+5H2qUSO8EmTZRG5twhF5fqOgSdHBWQfryg2U+X+
	UA+OQAHm3qgZM7Z677qOxLLmcSFMsEdS2r/vKNhYeBhL/k/Y/dadD4sXI6KJKB0A2RI=
X-Gm-Gg: AYBFou2+P3BU7JcIMPNLLDDH7ux+kuF1QseBGtbSTP4qYhkFSRCFmpQEWjhEoBw+970
	GL2otISLyHkQSc/wcy41EZelmweS/O82RR8Zk68kgEhZPscFTCqhoMiZ1CTZ6DP7KuIbq8XDr49
	kro23kxwbMvXs0Aifa1ATOtt3VGgnwhF2iG5HgrFHI7yWB1f4n+ZAHb6KpCJfqyx98rwKrxnOQi
	kWFbnD68pSYnHFkLDokOXFNODEPS3OVTRaEP1gsjwi81yHNlyQrg+3oMgMLYxwwhlnsl6kuba3p
	qge83pW4JoWmzF3Cf9Lfo7BJmkESIZCpb/HUWnWEpUL16gnfQGqhGybmAGbA0nCf3g0t587RK0e
	feiy+WR4GT8+YR7LMc9QesRBCAyB85rVbJ0GJYq7wXkCrJPfHXMrWIJfdtuaHFZYaUxihDhZeY6
	cjNbw59mX3nj2eYlJHjqlx1ZO5kYov/YqNKvl0I2lMCTZcwanz95UjHtngYVZ/9drp/+DFZUs8+
	d4qi3sMi9yaTGEpZH9T1P+7pbPYWa/HO4a+m/uTfCncKxLPc+K+7nGz5rF6HSEzs2ozU/zFZwhv
	AWEHGWB50ByisuUoUoR4Mzc9mtvgDZ/TwqcHlGNnrZ4Nx1eA3eMVxB5JmnLlRL/hzcMWN3xZBKl
	y3uxuVnIjb0Xm3SgOBdb7Q0C5SiqjFHOAFpuLGPJu3sQTbqiYtEhA9rWqgtZzXNxJ
X-Received: by 2002:a17:90b:58cb:b0:3ac:a6a5:5743 with SMTP id 98e67ed59e1d1-3ae898168f4mr9219145a91.32.1793670940925;
        Mon, 02 Nov 2026 17:55:40 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([203.94.55.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5844acsm1570730a91.4.2026.11.02.17.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:55:40 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	Sanjay Govind <sanjay.govind9@gmail.com>
Subject: [PATCH v2] HID: santroller: add driver for Santroller controllers
Date: Tue,  3 Nov 2026 14:53:35 +1300
Message-ID: <20261103015335.974344-1-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016025403.779635-1-sanjay.govind9@gmail.com>
References: <20261016025403.779635-1-sanjay.govind9@gmail.com>
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

Santroller is an open source firmware for DIY and modded game
controllers and instruments: https://github.com/Santroller/Santroller

Santroller devices work like hubs: a user can connect several
instruments and controllers to one device, and on USB each active
profile appears as its own HID gamepad interface. On current firmware,
each of these interfaces answers a vendor features report (usage
0xff00:0x2882) with the emulated controller type and a set of
capability bits.

Inputs are left to the generic HID input layer, as the report
descriptor already describes the buttons, axes and d-pad. Since users
name each profile, and on USB the firmware puts that name in the
interface string, the driver uses it to name the input device, so each
connected instrument or controller can be told apart.

The driver also handles the outputs the device reports supporting:
rumble, player LEDs, an RGB indicator LED and the euphoria LED of DJ
Hero turntables.

The configuration interface and devices whose report descriptor lacks
the features report are left to hid-generic. Devices that advertise the
report but fail to answer it are still connected as plain gamepads.

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
 MAINTAINERS                  |   6 +
 drivers/hid/Kconfig          |  12 +
 drivers/hid/Makefile         |   1 +
 drivers/hid/hid-ids.h        |   4 +
 drivers/hid/hid-santroller.c | 611 +++++++++++++++++++++++++++++++++++
 5 files changed, 634 insertions(+)
 create mode 100644 drivers/hid/hid-santroller.c

Changes since v1:
- Serialize concurrent player LED updates under the driver lock.
- Move output enabling into a helper to keep probe error handling
  consistently goto-based.
- Use a longer feature-report timeout over Bluetooth and still bind as a
  plain gamepad when a device advertises but does not answer the report.
- Drop the subtype sysfs attribute and its ABI documentation; SDL can
  identify the controller from USB descriptors already exposed through
  sysfs.
- Rebase onto the current hid/for-next.

AI assistance was used to review the v1 thread, prepare the rebase, and
remove the subtype sysfs interface.

Testing:
- git diff --check
- Built hid-santroller.ko against the running 7.2.11-arch1-1 kernel.
- Bound both Santroller HID interfaces to the driver; verified live input
  events, tested the player LED and RGB indicator and restored their
  original states, and verified rumble with fftest.

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a69da715c58..028c8f7f40fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11703,6 +11703,12 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-pulsar.c
 
+HID SANTROLLER DRIVER
+M:	Sanjay Govind <sanjay.govind9@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/hid-santroller.c
+
 HID SENSOR HUB DRIVERS
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Jonathan Cameron <jic23@kernel.org>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c435..2fab7003ce18 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1138,6 +1138,18 @@ config HID_SAMSUNG
 	help
 	Support for Samsung InfraRed remote control or keyboards.
 
+config HID_SANTROLLER
+	tristate "Santroller game controller support"
+	depends on LEDS_CLASS_MULTICOLOR
+	select INPUT_FF_MEMLESS
+	help
+	  Support for game controllers and instruments running the Santroller
+	  firmware, including rumble, player LEDs, the RGB indicator LED and
+	  the DJ Hero turntable euphoria LED.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-santroller.
+
 config HID_SEMITEK
 	tristate "Semitek USB keyboards"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 43a8eb0f389b..afe88185289b 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
 obj-$(CONFIG_HID_RMI)		+= hid-rmi.o
 obj-$(CONFIG_HID_SAITEK)	+= hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
+obj-$(CONFIG_HID_SANTROLLER)	+= hid-santroller.o
 obj-$(CONFIG_HID_SEMITEK)	+= hid-semitek.o
 obj-$(CONFIG_HID_SIGMAMICRO)	+= hid-sigmamicro.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 91319aa6516d..ed3940cd36cd 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1216,6 +1216,10 @@
 #define USB_VENDOR_ID_PHILIPS		0x0471
 #define USB_DEVICE_ID_PHILIPS_IEEE802154_DONGLE 0x0617
 
+#define USB_VENDOR_ID_PID_CODES		0x1209
+#define USB_DEVICE_ID_SANTROLLER	0x2882
+#define USB_DEVICE_ID_SANTROLLER_V2	0x2883
+
 #define USB_VENDOR_ID_PI_ENGINEERING	0x05f3
 #define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL	0xff
 
diff --git a/drivers/hid/hid-santroller.c b/drivers/hid/hid-santroller.c
new file mode 100644
index 000000000000..a2048e4ea321
--- /dev/null
+++ b/drivers/hid/hid-santroller.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for Santroller game controllers
+ *
+ * Santroller is an open source firmware for DIY and modded game
+ * controllers and instruments: https://github.com/Santroller/Santroller
+ *
+ * Copyright (c) 2026 Sanjay Govind <sanjay.govind9@gmail.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/hid.h>
+#include <linux/idr.h>
+#include <linux/input.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+#include <dt-bindings/leds/common.h>
+
+#include "hid-ids.h"
+
+#define SANTROLLER_REPORT_ID_OUTPUT	0x01
+#define SANTROLLER_REPORT_ID_FEATURES	0x10
+
+/* Only devices exposing this usage support the features report */
+#define SANTROLLER_FEATURES_USAGE	(HID_UP_MSVENDOR | 0x2882)
+
+#define SANTROLLER_OUTPUT_REPORT_SIZE	11
+#define SANTROLLER_FEATURES_REPORT_SIZE	3
+
+#define SANTROLLER_FEATURES_RETRIES	8
+#define SANTROLLER_FEATURES_TIMEOUT	msecs_to_jiffies(100)
+/* Over Bluetooth, the host may still be enabling notifications for the reply */
+#define SANTROLLER_FEATURES_TIMEOUT_BT	msecs_to_jiffies(250)
+
+#define SANTROLLER_CMD_RUMBLE		0x5a
+#define SANTROLLER_CMD_PLAYER_LED	0x5c
+#define SANTROLLER_CMD_RGB_LED		0x5d
+
+#define SANTROLLER_PLAYER_LED_OFF	0xff
+#define SANTROLLER_NUM_PLAYER_LEDS	4
+
+/* Capability bits from the features report */
+#define SANTROLLER_CAP_PLAYER_LEDS	BIT(0)
+#define SANTROLLER_CAP_RGB_LED		BIT(1)
+#define SANTROLLER_CAP_RUMBLE		BIT(3)
+#define SANTROLLER_CAP_EUPHORIA_LED	BIT(6)
+
+static DEFINE_IDA(santroller_player_ids);
+
+struct santroller {
+	struct hid_device *hdev;
+	struct input_dev *input;
+
+	struct completion features_done;
+	const char *name;
+	u8 caps;
+
+	int player_id;
+	struct led_classdev player_leds[SANTROLLER_NUM_PLAYER_LEDS];
+	struct led_classdev_mc rgb_led;
+	struct mc_subled rgb_subleds[3];
+	struct led_classdev euphoria_led;
+
+	spinlock_t lock;		/* protects the output state below */
+	struct work_struct output_work;
+	bool output_enabled;
+	bool rumble_dirty;
+	bool player_dirty;
+	bool rgb_dirty;
+	u8 rumble[2];
+	u8 player;
+	u8 rgb[3];
+	u8 *output_buf;
+};
+
+static int santroller_send_report(struct hid_device *hdev, u8 *buf, size_t len)
+{
+	int ret;
+
+	ret = hid_hw_output_report(hdev, buf, len);
+	if (ret == -ENOSYS)
+		ret = hid_hw_raw_request(hdev, buf[0], buf, len,
+					 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+
+	return ret;
+}
+
+/* Must be called with sc->lock held */
+static void santroller_schedule_output(struct santroller *sc)
+{
+	if (sc->output_enabled)
+		schedule_work(&sc->output_work);
+}
+
+/*
+ * The firmware handles a single command per output report, so build the
+ * next pending one into buf. Returns false if nothing is pending.
+ */
+static bool santroller_next_command(struct santroller *sc, u8 *buf)
+{
+	guard(spinlock_irqsave)(&sc->lock);
+
+	memset(buf, 0, SANTROLLER_OUTPUT_REPORT_SIZE);
+	buf[0] = SANTROLLER_REPORT_ID_OUTPUT;
+
+	if (sc->rumble_dirty) {
+		sc->rumble_dirty = false;
+		buf[1] = SANTROLLER_CMD_RUMBLE;
+		buf[2] = sc->rumble[0];
+		buf[3] = sc->rumble[1];
+		return true;
+	}
+
+	if (sc->player_dirty) {
+		sc->player_dirty = false;
+		buf[1] = SANTROLLER_CMD_PLAYER_LED;
+		buf[2] = sc->player;
+		return true;
+	}
+
+	if (sc->rgb_dirty) {
+		sc->rgb_dirty = false;
+		buf[1] = SANTROLLER_CMD_RGB_LED;
+		memcpy(&buf[2], sc->rgb, sizeof(sc->rgb));
+		return true;
+	}
+
+	return false;
+}
+
+static void santroller_output_work(struct work_struct *work)
+{
+	struct santroller *sc = container_of(work, struct santroller, output_work);
+	int ret;
+
+	while (santroller_next_command(sc, sc->output_buf)) {
+		ret = santroller_send_report(sc->hdev, sc->output_buf,
+					     SANTROLLER_OUTPUT_REPORT_SIZE);
+		if (ret < 0)
+			hid_warn_ratelimited(sc->hdev,
+					     "failed to send output report: %d\n", ret);
+	}
+}
+
+static int santroller_play_effect(struct input_dev *input, void *data,
+				  struct ff_effect *effect)
+{
+	struct hid_device *hdev = input_get_drvdata(input);
+	struct santroller *sc = hid_get_drvdata(hdev);
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->rumble[0] = effect->u.rumble.strong_magnitude >> 8;
+	sc->rumble[1] = effect->u.rumble.weak_magnitude >> 8;
+	sc->rumble_dirty = true;
+	santroller_schedule_output(sc);
+
+	return 0;
+}
+
+/*
+ * The firmware shows a single player number, so the lowest lit player LED
+ * wins. Turning all of them off turns the indicator off.
+ *
+ * Different player LEDs can be set concurrently, so look at all of them
+ * under the lock, where the last caller is sure to see every update.
+ */
+static void santroller_player_led_set(struct led_classdev *led,
+				      enum led_brightness value)
+{
+	struct hid_device *hdev = to_hid_device(led->dev->parent);
+	struct santroller *sc = hid_get_drvdata(hdev);
+	int i;
+
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->player = SANTROLLER_PLAYER_LED_OFF;
+	for (i = 0; i < SANTROLLER_NUM_PLAYER_LEDS; i++) {
+		if (sc->player_leds[i].brightness) {
+			sc->player = i;
+			break;
+		}
+	}
+	sc->player_dirty = true;
+	santroller_schedule_output(sc);
+}
+
+static void santroller_rgb_led_set(struct led_classdev *led,
+				   enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(led);
+	struct santroller *sc = container_of(mc, struct santroller, rgb_led);
+	int i;
+
+	led_mc_calc_color_components(mc, brightness);
+
+	guard(spinlock_irqsave)(&sc->lock);
+
+	for (i = 0; i < ARRAY_SIZE(sc->rgb); i++)
+		sc->rgb[i] = mc->subled_info[i].brightness;
+	sc->rgb_dirty = true;
+	santroller_schedule_output(sc);
+}
+
+static int santroller_register_player_leds(struct santroller *sc)
+{
+	static const char * const functions[] = {
+		LED_FUNCTION_PLAYER1, LED_FUNCTION_PLAYER2,
+		LED_FUNCTION_PLAYER3, LED_FUNCTION_PLAYER4,
+	};
+	struct hid_device *hdev = sc->hdev;
+	struct led_classdev *led;
+	u8 player = sc->player_id % SANTROLLER_NUM_PLAYER_LEDS;
+	int i, ret;
+
+	for (i = 0; i < SANTROLLER_NUM_PLAYER_LEDS; i++) {
+		led = &sc->player_leds[i];
+		led->name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "%s::%s",
+					   dev_name(&sc->input->dev), functions[i]);
+		if (!led->name)
+			return -ENOMEM;
+
+		led->brightness = i == player;
+		led->max_brightness = 1;
+		led->brightness_set = santroller_player_led_set;
+
+		ret = devm_led_classdev_register(&hdev->dev, led);
+		if (ret)
+			return ret;
+	}
+
+	/* Show the assigned player number until userspace says otherwise */
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->player = player;
+	sc->player_dirty = true;
+	santroller_schedule_output(sc);
+
+	return 0;
+}
+
+/* The firmware takes the euphoria LED as a rumble command with equal values */
+static void santroller_euphoria_led_set(struct led_classdev *led,
+					enum led_brightness brightness)
+{
+	struct santroller *sc = container_of(led, struct santroller, euphoria_led);
+
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->rumble[0] = brightness;
+	sc->rumble[1] = brightness;
+	sc->rumble_dirty = true;
+	santroller_schedule_output(sc);
+}
+
+static int santroller_register_euphoria_led(struct santroller *sc)
+{
+	struct hid_device *hdev = sc->hdev;
+	struct led_classdev *led = &sc->euphoria_led;
+
+	led->name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "%s::%s",
+				   dev_name(&sc->input->dev),
+				   LED_FUNCTION_INDICATOR);
+	if (!led->name)
+		return -ENOMEM;
+
+	led->max_brightness = 255;
+	led->brightness_set = santroller_euphoria_led_set;
+
+	return devm_led_classdev_register(&hdev->dev, led);
+}
+
+static int santroller_register_rgb_led(struct santroller *sc)
+{
+	struct hid_device *hdev = sc->hdev;
+	struct led_classdev *led = &sc->rgb_led.led_cdev;
+
+	sc->rgb_subleds[0].color_index = LED_COLOR_ID_RED;
+	sc->rgb_subleds[1].color_index = LED_COLOR_ID_GREEN;
+	sc->rgb_subleds[2].color_index = LED_COLOR_ID_BLUE;
+	sc->rgb_led.subled_info = sc->rgb_subleds;
+	sc->rgb_led.num_colors = ARRAY_SIZE(sc->rgb_subleds);
+
+	led->name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "%s:rgb:indicator",
+				   dev_name(&sc->input->dev));
+	if (!led->name)
+		return -ENOMEM;
+
+	led->brightness = 255;
+	led->max_brightness = 255;
+	led->brightness_set = santroller_rgb_led_set;
+
+	return devm_led_classdev_multicolor_register(&hdev->dev, &sc->rgb_led);
+}
+
+/* Name the gamepad input device and add rumble before it is registered */
+static int santroller_input_configured(struct hid_device *hdev,
+				       struct hid_input *hi)
+{
+	struct santroller *sc = hid_get_drvdata(hdev);
+	struct input_dev *input = hi->input;
+	int ret;
+
+	if (!sc || sc->input)
+		return 0;
+
+	if (hi->application != HID_GD_GAMEPAD &&
+	    hi->application != HID_GD_JOYSTICK)
+		return 0;
+
+	if (sc->name)
+		input->name = sc->name;
+
+	if (sc->caps & SANTROLLER_CAP_RUMBLE) {
+		input_set_capability(input, EV_FF, FF_RUMBLE);
+		ret = input_ff_create_memless(input, NULL, santroller_play_effect);
+		if (ret)
+			return ret;
+	}
+
+	sc->input = input;
+	return 0;
+}
+
+static int santroller_raw_event(struct hid_device *hdev,
+				struct hid_report *report, u8 *data, int size)
+{
+	struct santroller *sc = hid_get_drvdata(hdev);
+
+	if (sc && data[0] == SANTROLLER_REPORT_ID_FEATURES &&
+	    size >= SANTROLLER_FEATURES_REPORT_SIZE &&
+	    !completion_done(&sc->features_done)) {
+		sc->caps = data[2];
+		complete(&sc->features_done);
+	}
+
+	return 0;
+}
+
+/* The device answers the features command with an input report */
+static int santroller_get_features(struct santroller *sc)
+{
+	u8 *buf __free(kfree) = kzalloc(2, GFP_KERNEL);
+	unsigned long timeout = SANTROLLER_FEATURES_TIMEOUT;
+	int i, ret = -ETIMEDOUT;
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (sc->hdev->bus == BUS_BLUETOOTH)
+		timeout = SANTROLLER_FEATURES_TIMEOUT_BT;
+
+	for (i = 0; i < SANTROLLER_FEATURES_RETRIES; i++) {
+		reinit_completion(&sc->features_done);
+
+		buf[0] = SANTROLLER_REPORT_ID_FEATURES;
+		buf[1] = 0;
+		ret = santroller_send_report(sc->hdev, buf, 2);
+		if (ret < 0)
+			continue;
+
+		if (wait_for_completion_timeout(&sc->features_done, timeout))
+			return 0;
+
+		ret = -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static bool santroller_has_features_report(struct hid_device *hdev)
+{
+	struct hid_report *report;
+
+	report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[SANTROLLER_REPORT_ID_FEATURES];
+	if (!report || !report->maxfield || !report->field[0]->maxusage)
+		return false;
+
+	return report->field[0]->usage[0].hid == SANTROLLER_FEATURES_USAGE;
+}
+
+/*
+ * Each profile on a USB device gets its own interface, named after the
+ * profile through the interface string.
+ */
+static const char *santroller_profile_name(struct hid_device *hdev)
+{
+	struct usb_interface *intf;
+	const char *name;
+
+	if (!hid_is_usb(hdev))
+		return NULL;
+
+	intf = to_usb_interface(hdev->dev.parent);
+	name = READ_ONCE(intf->cur_altsetting->string);
+	if (!name || !*name)
+		return NULL;
+
+	return devm_kstrdup(&hdev->dev, name, GFP_KERNEL);
+}
+
+static void santroller_start_output(struct santroller *sc)
+{
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->output_enabled = true;
+}
+
+static void santroller_stop_output(struct santroller *sc)
+{
+	scoped_guard(spinlock_irqsave, &sc->lock)
+		sc->output_enabled = false;
+
+	cancel_work_sync(&sc->output_work);
+}
+
+static int santroller_probe(struct hid_device *hdev,
+			    const struct hid_device_id *id)
+{
+	struct santroller *sc;
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	/*
+	 * Older firmware and the configuration interface don't support the
+	 * features report, leave those to the generic HID handling.
+	 */
+	if (!santroller_has_features_report(hdev))
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	sc = devm_kzalloc(&hdev->dev, sizeof(*sc), GFP_KERNEL);
+	if (!sc)
+		return -ENOMEM;
+
+	sc->output_buf = devm_kzalloc(&hdev->dev, SANTROLLER_OUTPUT_REPORT_SIZE,
+				      GFP_KERNEL);
+	if (!sc->output_buf)
+		return -ENOMEM;
+
+	sc->hdev = hdev;
+	sc->name = santroller_profile_name(hdev);
+	init_completion(&sc->features_done);
+	spin_lock_init(&sc->lock);
+	INIT_WORK(&sc->output_work, santroller_output_work);
+
+	ret = ida_alloc(&santroller_player_ids, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	sc->player_id = ret;
+
+	hid_set_drvdata(hdev, sc);
+
+	/*
+	 * Start without connecting hid-input or hidraw, so the features
+	 * report can tell santroller_input_configured() what the device is.
+	 */
+	ret = hid_hw_start(hdev, 0);
+	if (ret) {
+		hid_err(hdev, "failed to start HID device: %d\n", ret);
+		goto err_free_id;
+	}
+
+	ret = hid_hw_open(hdev);
+	if (ret) {
+		hid_err(hdev, "failed to open HID device: %d\n", ret);
+		goto err_stop;
+	}
+
+	hid_device_io_start(hdev);
+
+	/*
+	 * Older firmware never answers over Bluetooth, so without the
+	 * features, still bind as a plain gamepad.
+	 */
+	ret = santroller_get_features(sc);
+	if (ret == -ENOMEM)
+		goto err_close;
+	if (ret) {
+		hid_warn(hdev, "failed to get device features: %d\n", ret);
+		/* Ignore a late reply, the caps are settled from here on */
+		complete(&sc->features_done);
+	}
+
+	hid_device_io_stop(hdev);
+
+	santroller_start_output(sc);
+
+	ret = hid_connect(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "failed to connect HID device: %d\n", ret);
+		goto err_stop_output;
+	}
+
+	/* hid-input may have unwound after santroller_input_configured() */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		sc->input = NULL;
+
+	/* The LEDs are named after the gamepad input device */
+	if (!sc->input)
+		goto out;
+
+	if (sc->caps & SANTROLLER_CAP_PLAYER_LEDS) {
+		ret = santroller_register_player_leds(sc);
+		if (ret) {
+			hid_err(hdev, "failed to register player LEDs: %d\n", ret);
+			goto err_stop_output;
+		}
+	}
+
+	if (sc->caps & SANTROLLER_CAP_RGB_LED) {
+		ret = santroller_register_rgb_led(sc);
+		if (ret) {
+			hid_err(hdev, "failed to register RGB LED: %d\n", ret);
+			goto err_stop_output;
+		}
+	}
+
+	if (sc->caps & SANTROLLER_CAP_EUPHORIA_LED) {
+		ret = santroller_register_euphoria_led(sc);
+		if (ret) {
+			hid_err(hdev, "failed to register euphoria LED: %d\n", ret);
+			goto err_stop_output;
+		}
+	}
+
+out:
+	/* hid-input and hidraw open the device themselves from here on */
+	hid_hw_close(hdev);
+	return 0;
+
+err_stop_output:
+	santroller_stop_output(sc);
+err_close:
+	hid_hw_close(hdev);
+err_stop:
+	hid_hw_stop(hdev);
+err_free_id:
+	ida_free(&santroller_player_ids, sc->player_id);
+	return ret;
+}
+
+static void santroller_remove(struct hid_device *hdev)
+{
+	struct santroller *sc = hid_get_drvdata(hdev);
+
+	if (!sc) {
+		hid_hw_stop(hdev);
+		return;
+	}
+
+	santroller_stop_output(sc);
+	hid_hw_stop(hdev);
+	ida_free(&santroller_player_ids, sc->player_id);
+}
+
+static int santroller_resume(struct hid_device *hdev)
+{
+	struct santroller *sc = hid_get_drvdata(hdev);
+
+	if (!sc)
+		return 0;
+
+	/* The device may have lost its LED state, so send it again */
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->player_dirty = sc->caps & SANTROLLER_CAP_PLAYER_LEDS;
+	sc->rgb_dirty = sc->caps & SANTROLLER_CAP_RGB_LED;
+	sc->rumble_dirty = sc->caps & SANTROLLER_CAP_EUPHORIA_LED;
+	santroller_schedule_output(sc);
+
+	return 0;
+}
+
+static const struct hid_device_id santroller_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PID_CODES, USB_DEVICE_ID_SANTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PID_CODES, USB_DEVICE_ID_SANTROLLER_V2) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_PID_CODES, USB_DEVICE_ID_SANTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_PID_CODES, USB_DEVICE_ID_SANTROLLER_V2) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, santroller_devices);
+
+static struct hid_driver santroller_driver = {
+	.name = "santroller",
+	.id_table = santroller_devices,
+	.probe = santroller_probe,
+	.remove = santroller_remove,
+	.raw_event = santroller_raw_event,
+	.input_configured = santroller_input_configured,
+	.resume = pm_ptr(santroller_resume),
+	.reset_resume = pm_ptr(santroller_resume),
+};
+module_hid_driver(santroller_driver);
+
+MODULE_AUTHOR("Sanjay Govind <sanjay.govind9@gmail.com>");
+MODULE_DESCRIPTION("HID driver for Santroller game controllers");
+MODULE_LICENSE("GPL");
-- 
2.56.0
