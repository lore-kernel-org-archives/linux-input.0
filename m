Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BA34D38B
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119252; cv=none; b=bkiYnUgECeunvSRUekFuf40r+cU/bLc6uZ+RiYgCbm+LF/QfAx1J4GHcm2+1pIcAtoJx4Yqka1gqmWpMQUmvKZmLV4RK5D/SeTd1MKE6Pt2O0hjgauO64kJ6PqVrd7Ii7U+8Di0GrEsuu35zLAL8LASER2mGumTcYt5ooDHpASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119252; c=relaxed/simple;
	bh=KeJ/EJHhSk6X9Q2hxBdbmL/NDB6r2q7PXwuFYpoCQiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZ8S4KZghLIU2G4w+/MbSG/RTYHg/o1ztrl9Y2DbF7AlURxRzTbr/HvYR6z66BQqMbz30D0kmIMo4pdhL74dAU3WtU5iEup0SM1aLtZKCJLyjgdAjgaqOnI2QZAFdxqG4PwPsuoUDZQrv3tt0k5bKx0xM4CAyJXWBAC3L1AiCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5Yn3e2l; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5Yn3e2l"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd60d155070so1320220a12.2
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 19:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119250; x=1792724050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJVOuZOfR9gcFEOr2lUTXjdyeLSJ6zq+TNFHWC5jl94=;
        b=a5Yn3e2lG2pe6BBhowyJ48giap43IaXjFRgiMkHjRTTkQf7AFhOZOxepPYOb3d+89l
         NPIRVt5hGaG6APHGklYNje/1MJSPyPZKgO0eUeW9bVJYKAayUeqZtrP+Q9OsOu4f3wro
         riNwJ0I8aikpsh/+nJ+bmrQgh3Q5NAKEz1w+SgZ3D8EM/wF2hk03bQlAQ1en/3UwLJA6
         eZXjXRuB8+Chrsb2842y4gisrYgMqVCOLirE6Fn5Q0oPG3UaYiTLZR2c5WHjJZmJyyuy
         rGhChbkTHVK9hRlOfKqwPCmA/fT6azLf89RLJ2ljG655AnOFDCvKhrm61vLw9QvD+Hq6
         7iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119250; x=1792724050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJVOuZOfR9gcFEOr2lUTXjdyeLSJ6zq+TNFHWC5jl94=;
        b=F9SfZhJ7bYL+YfhaDeebSCRIQ5HWHs6HHYZyq9FlDeNlMKnKDyz1QhgUpw9Z5MJF2F
         Bf6EVA0IJhZPv5yy1AUCo8LLDG74S3xv59rftLWxpcE56vS7Q2098QFBsZ0c8/XjA6HN
         M19aPZXHpQC1wkYuLtvs3XwrgXeVwv6oPRPAv7uq7mErKQvMYt6DoNsVTz5dovhIvt0q
         hAnor8lGR/ehWskOW6xy8V1iqdQrdfbDg3ou14+Pe8rSFloj2ZmkjCzh54SjmUi96dfV
         lbt7+Scor6kKKQK7YOOLIVoeZPJKRxWdFi3Kgxfxr1Tdaa0rsuVYP1pIA7PThBD13NF1
         dPUw==
X-Gm-Message-State: AFq9FYKiqOJX02IS+6z/D9kz29SutO8V0dePhMDOAQ0uZmIX/4EQBi0I
	5M2f/oRBwqokPd8WSB1CvPAFMctJl/S6kr0+vQhDEJ44S/qeMEjSBPA8
X-Gm-Gg: AYBFou1HWKHxzeB9K8nvpVpqFP3/ireLbQF+0qBgumTFO3DOERV9DFjTJlMiGtni7Ss
	6aBKAh0JTFKllowRKAumsYcQWdNEA3hQKxwF7GJIHOLWm5Xcj+JLFQqkUGtW/hKeKXqQ1O9uogi
	E2bAF3xJs1xuU45isKkfbzBa6UHjRKOTNbpAF527hghSntfyAD7BZ6uaXCuheINE0Vi24JcB6eT
	QkI2OkYm/Y5oaY2S18hXPEaQ61qyad2EY1WUmuF7ao+RIuaDqaJDFAJudInTSYs8mqZOzEKXgQU
	abwrbIYoH2xVFuKLU2ry5tjEbJyPI6gyLE3gbsjbnLwxppGAQzfGx6ivTTMQOJt2elSRFo9mNYB
	wf/dsU+kIBLS+w1auuPQbbRS+g9Pu7s5zd/PMT58dn1VK6GdibwOS927zpdAeF0rG3ZmKVmHl5u
	LN/JoPo3ealQSdR8jw6mAD5iS3/M01AUEV35/aSUACdMNWx4wlPSeYXSerha9DhTvfrDfxH2KzQ
	joE8wWfGZcZ0xFCkCO7EQBssyPVzxDPVOLbrLHMomeKAYkiKXrqcXR5y06mBE/mDYpPs4D7IEz/
	QsRMQqAhmwFtP+WK1+an/MHaXSS6RzybrQ8=
X-Received: by 2002:a17:90b:518f:b0:3ab:1481:69e5 with SMTP id 98e67ed59e1d1-3ab3a912263mr17428944a91.11.1792119249467;
        Thu, 15 Oct 2026 19:54:09 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([139.180.93.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm783433a91.0.2026.10.15.19.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:54:08 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: santroller: add driver for Santroller controllers
Date: Fri, 16 Oct 2026 15:54:03 +1300
Message-ID: <20261016025403.779635-1-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
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

The controller type is exposed as a read-only "subtype" attribute on
the HID device, documented in
Documentation/ABI/testing/sysfs-driver-hid-santroller. Games that
integrate with specific instruments can use it to tell them apart
without needing access to the hidraw node.

The configuration interface, and devices running firmware without the
features report, are started the same way hid-generic would start
them.

Assisted-by: LLM
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
Tested with 7.2.3, built as a module out of tree, over both USB and
Bluetooth: inputs with evtest, the input device named after each
profile on USB, rumble, the player, RGB and euphoria LEDs through
/sys/class/leds, and the subtype attribute. The configuration
interface still works as a plain HID device.

 .../ABI/testing/sysfs-driver-hid-santroller   |  45 ++
 MAINTAINERS                                   |   7 +
 drivers/hid/Kconfig                           |  12 +
 drivers/hid/Makefile                          |   1 +
 drivers/hid/hid-ids.h                         |   4 +
 drivers/hid/hid-santroller.c                  | 624 ++++++++++++++++++
 6 files changed, 693 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-santroller
 create mode 100644 drivers/hid/hid-santroller.c

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-santroller b/Documentation/ABI/testing/sysfs-driver-hid-santroller
new file mode 100644
index 000000000000..78b87d850ad1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-santroller
@@ -0,0 +1,45 @@
+What:		/sys/bus/hid/drivers/santroller/<dev>/subtype
+Date:		October 2026
+KernelVersion:	7.5
+Contact:	Sanjay Govind <sanjay.govind9@gmail.com>
+Description:	(RO) The kind of controller the Santroller firmware is
+		emulating on this interface, as the decimal value the device
+		reports in its features report:
+
+		==  ==================================
+		1   Gamepad
+		2   Dance pad
+		3   Guitar Hero guitar
+		4   Rock Band guitar
+		5   Guitar Hero drum kit
+		6   Rock Band drum kit
+		7   Guitar Hero Live guitar
+		8   DJ Hero turntable
+		9   Rock Band stage kit
+		10  Disney Infinity base
+		11  Skylanders portal
+		12  Lego Dimensions toy pad
+		13  Project Diva controller
+		14  Guitar Freaks guitar
+		15  Wheel
+		16  Rock Band Pro keyboard
+		17  Rock Band Pro guitar (Mustang)
+		18  Rock Band Pro guitar (Squier)
+		20  Fight stick
+		21  Flight stick
+		22  Pop'n Music controller
+		23  DJMAX controller
+		24  Taiko drum
+		25  Power Gig drum kit
+		26  Power Gig guitar
+		27  Rock Revolution guitar
+		29  beatmania controller
+		30  DrumMania drum kit
+		31  KeyboardMania keyboard
+		==  ==================================
+
+		Values not listed here may be added by newer firmware and
+		should be treated as an unknown controller.
+
+		Only present on interfaces that respond to the features
+		report.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..cf9ffffb825b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11640,6 +11640,13 @@ L:	linux-input@vger.kernel.org
 S:	Supported
 F:	drivers/hid/hid-playstation.c
 
+HID SANTROLLER DRIVER
+M:	Sanjay Govind <sanjay.govind9@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-hid-santroller
+F:	drivers/hid/hid-santroller.c
+
 HID SENSOR HUB DRIVERS
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Jonathan Cameron <jic23@kernel.org>
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index aa7fa11a0197..29b7b1615158 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1132,6 +1132,18 @@ config HID_SAMSUNG
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
index 48a863b245ee..5a554bd8c41d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_HID_ROCCAT)	+= hid-roccat.o hid-roccat-common.o \
 obj-$(CONFIG_HID_RMI)		+= hid-rmi.o
 obj-$(CONFIG_HID_SAITEK)	+= hid-saitek.o
 obj-$(CONFIG_HID_SAMSUNG)	+= hid-samsung.o
+obj-$(CONFIG_HID_SANTROLLER)	+= hid-santroller.o
 obj-$(CONFIG_HID_SEMITEK)	+= hid-semitek.o
 obj-$(CONFIG_HID_SIGMAMICRO)	+= hid-sigmamicro.o
 obj-$(CONFIG_HID_SMARTJOYPLUS)	+= hid-sjoy.o
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 341bf587863b..7863a4b9700a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1199,6 +1199,10 @@
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
index 000000000000..00adeb741a88
--- /dev/null
+++ b/drivers/hid/hid-santroller.c
@@ -0,0 +1,624 @@
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
+	u8 subtype;
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
+ */
+static void santroller_player_led_set(struct led_classdev *led,
+				      enum led_brightness value)
+{
+	struct hid_device *hdev = to_hid_device(led->dev->parent);
+	struct santroller *sc = hid_get_drvdata(hdev);
+	u8 player = SANTROLLER_PLAYER_LED_OFF;
+	int i;
+
+	for (i = 0; i < SANTROLLER_NUM_PLAYER_LEDS; i++) {
+		if (sc->player_leds[i].brightness) {
+			player = i;
+			break;
+		}
+	}
+
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->player = player;
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
+		sc->subtype = data[1];
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
+	int i, ret = -ETIMEDOUT;
+
+	if (!buf)
+		return -ENOMEM;
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
+		if (wait_for_completion_timeout(&sc->features_done,
+						SANTROLLER_FEATURES_TIMEOUT))
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
+static ssize_t subtype_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct santroller *sc = hid_get_drvdata(to_hid_device(dev));
+
+	return sysfs_emit(buf, "%u\n", sc->subtype);
+}
+static DEVICE_ATTR_RO(subtype);
+
+static struct attribute *santroller_attrs[] = {
+	&dev_attr_subtype.attr,
+	NULL
+};
+
+/* Interfaces left to the generic HID handling have no subtype */
+static umode_t santroller_attr_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+
+	return hid_get_drvdata(to_hid_device(dev)) ? attr->mode : 0;
+}
+
+static const struct attribute_group santroller_group = {
+	.attrs = santroller_attrs,
+	.is_visible = santroller_attr_is_visible,
+};
+__ATTRIBUTE_GROUPS(santroller);
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
+	ret = santroller_get_features(sc);
+	if (ret) {
+		hid_err(hdev, "failed to get device features: %d\n", ret);
+		goto err_close;
+	}
+
+	hid_device_io_stop(hdev);
+
+	scoped_guard(spinlock_irqsave, &sc->lock)
+		sc->output_enabled = true;
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
+	.driver.dev_groups = santroller_groups,
+};
+module_hid_driver(santroller_driver);
+
+MODULE_AUTHOR("Sanjay Govind <sanjay.govind9@gmail.com>");
+MODULE_DESCRIPTION("HID driver for Santroller game controllers");
+MODULE_LICENSE("GPL");

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0

