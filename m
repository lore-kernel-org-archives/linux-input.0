Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794711319;
	b=TjD0He4XKhQoSihnVPbx7WGoruEw9yYTfhMWHWKj01qA/az2FJO1/ZjjJRb2RvDC+pyw
	 CI5rYKo1H76E1/4XzPSbedx5AP7lZOLznEQKjpcq/9KUXeKGoN3r1FAVqoJhiAWbPTWFe
	 XEfCO3kV9MCcfm7h0G8oxth676kdU8rkk2vZlxRa9QFt8EjSySu7Y8ClCyBWMECiJs5Vv
	 kjsaO5n9SUxt8Cg+0xBtdf1DG3tv/Q9MnOdbAJ5lfXxWv5vhzedklfbQSlLl99usfD8U6
	 z1Dp+968Fv1E7VNjyo+RviicE3C7bOaazaGXju5/0zsBb1wmYnNW3T71o2TURnPuE5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794711319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7jp4+cZdLPqcq5hufpy3ZFznxqx3brwx71qzObj3B7A=;
	b=5cJDHY7PO/gllDqfUVAbaINADLKxRJ9MyaNGCthm2ULmcSTD1outncfhS4QcGJtlR74d
	 wEvHJnAq2nG/jeEGyRq1dPJWS8lH5ds+3rTFNMX/uGBt+dbDyFnHe2hGqte/AOE9dg0WJ
	 PkqiDq9xe1qm7oLRjgQwl8Em3phSjmHrXfz/P/c4kgldNXrmq0PxDVZbw/U2wzwBTp2Ng
	 k7qQlj/CZoO6+TgPogEOTxGJmjD0ypRqw+IKVy0VB++P0fmxNl60sQm0cQ0p5yeRWBkzk
	 wBrDQd5ZAJk5NUOV5iJ8bNHp5l0vv16kOcvcgJmiPZm0erTm5V0XrLuw6eb4cjkxJQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=foLPq6V7;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE08606A329
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 02:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE08606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=foLPq6V7
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3791619605cso4664733eec.0
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 18:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794711317; x=1795316117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jp4+cZdLPqcq5hufpy3ZFznxqx3brwx71qzObj3B7A=;
        b=foLPq6V7WLst9X1s0VGRw0YFXNwxmR+sy7T9LEIf5Wz2fs2ZCxfrfl9TLZViUVFkwQ
         LY+/J4CpuNw0anEiKHRh3EsoLkQo5+QjTbODUR8oZkStxls3OiwENzabZtdu3cpFWnqo
         SkBHHxe3U8sC0PzajEyOCh2zSGIriC6XsgiTsx97fgxwhjiDxdcM0UfgIDO4Q6GvR+hd
         x+u9Bgkojg+oqft2zyAteCWdEImqs+LR5OswBjlCcwo8Kkpf5ADIa8fuX0s2SA1J7t6Z
         Kt9bgZ0ErdSVkYiNh3JgNABbt5jTtu+THkWrHN/AOD2OV5BG08uZbqRfbkoHkVA7Tdn+
         3u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794711317; x=1795316117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jp4+cZdLPqcq5hufpy3ZFznxqx3brwx71qzObj3B7A=;
        b=YdGGtaXwhLLKMuDr+zcrrD2KYTOlv+UQ2EQo3q7EqSZdecP8zLJWiROsmQEAUMtw9V
         CqQ2PDWkftAFtxYor61kAsP9Ks3z0bKgHuGFczp+BvBUk2GG2OUvtKBmc/9vKhteAh0m
         JEhOwuN12+Yq8ZVBYe0200avgxf66V+1Bm0aOStD9ArkZr1mQAIhvRZnFUqgnGVujj9Y
         5zCsev8jmx3567T94kS+CGA3ctcttUyo9jHUjWPNYAHI/wHqqvLl9lmZqig1GEtCNXbX
         RKp59tcpcphWr4WJVSEFlDoIrunV8zQFDUqeWbQRkZ96hBIgbH/Q0BxLnj5u8u9t82Bl
         rG7g==
X-Forwarded-Encrypted: i=1; AL+hErH96/iTk1g1BSL5ic3fgVvOD4+9G95heOcJ1e90S5xVmJCHBXXkDzxTgDitxFnnsowgIlbSsK5Lr7j0YQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+yXGZ4lEw8H9r12jMTpikeY97XcMeMT5lOLcgVzVQQ/RREXj+Z
	ucYSMdvAwIpHPrn2ZExvxfIAFuz9jD4YSQdD+RnHbOIuBDhTBJa7FXhkNCDM3tlfB40=
X-Gm-Gg: AYBFou2Vi/ixApUiUwHBy6LbKQSyQZZVqcT4a5evWkHLRUB+b9MKbuuRvfnKPzrwauo
	m7mmJ94FNRxogfrPrbF3EoaABtdeaJQUPysDqXYVChmsqMY5qDwq9kyrZSkEcQ4diKnSa38Zl2r
	9V8YGoL8TF6RjNjsAYnhK3ApdFmtwpmziuURMC+8OOdDl4f/7ER2p3G7XJiBYd/xpYdnY0+tlK7
	d+p2FNPc/DY4eBvPWFjA4YUFqfh6Ymp1hs07w674PuT/4ApPm+hksgZOjIQ/kkl4+mq5birbSzH
	n9zXb2AYYu1bIWHp27XPAnYi3pNBOI5azyKb6gliBSBWQ7YhBfUeV5q6BHEZE9Oi4XuF/l5DrMT
	gfEq0kRmKpd+FPhFeFB4Nnh+yQdoFkh1jD3pn194L1VRZIcZUvyVAw7Y5TGs/CAyMGBomy8fu0J
	t00sqlbpLUvKjSb0nYJ3wSGkYprjUR7NivraBtwoNHJEDX4sQdEeizFGb8X1mLs3+5bmiHxgK5h
	4aNbsanmMQnXodT5sX12X0hJB8piSU6I7z/NL9jYlvCvtSPsrvJGowE/jVEdDNihjE4wMHje/Gs
	JLdEzPFBJlGO5jvfEhLLTfkKDD2B9g6qdUk4WWychn22HDW6Yhw+rZcuP+rp90mdl5flvhA8bUl
	0XPv6usiX2d74RJFVD63uWUN6nfoQ7tf1RgzO5LhdLPzFmfcJrL35ZOo2tInELtbdjg==
X-Received: by 2002:a05:693c:2808:b0:36d:f004:ae6e with SMTP id 5a478bee46e88-3796721cff0mr6374028eec.34.1794711316817;
        Sat, 14 Nov 2026 18:55:16 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([14.137.24.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955e0d966sm21428769eec.15.2026.11.14.18.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:55:16 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sanjay Govind <sanjay.govind9@gmail.com>
Subject: [PATCH v4] HID: santroller: add driver for Santroller controllers
Date: Sun, 15 Nov 2026 15:53:50 +1300
Message-ID: <20261115025348.614261-3-sanjay.govind9@gmail.com>
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

Santroller is an open source firmware for DIY and modded game
controllers and instruments: https://github.com/Santroller/Santroller

Santroller devices work like hubs: a user can connect several
instruments and controllers to one device, and on USB each active
profile appears as its own HID gamepad interface. On current firmware,
each of these interfaces answers a vendor features report (usage
0xff00:0x2882) with the emulated controller type and a set of
capability bits.

Santroller uses the pid.codes vendor ID 0x1209 and product IDs 0x2882
and 0x2883 for its v1 and v2 devices, respectively, over USB and
Bluetooth.

Inputs are left to the generic HID input layer, as the report
descriptor already describes the buttons, axes and d-pad. Since users
name each profile, and on USB the firmware puts that name in the
interface string, the driver uses it to name the input device, so each
connected instrument or controller can be told apart.

The driver also handles the outputs the device reports supporting:
rumble, player LEDs, an RGB indicator LED and the euphoria LED of DJ
Hero turntables.

The configuration interface and devices whose report descriptor lacks
a matching input/output features report pair are left to hid-generic.
Devices that advertise the pair but fail to answer are still connected
as plain gamepads.

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
Tool assistance:
Copilot in VS Code assisted with the output retry change. The player LED
and Kconfig fixes and this changelog were written with the help of
Claude Opus 5.5.

Changes since v3:
- Retry failed output reports up to three times, 20 ms apart, refreshing
  the command from current state under the driver lock before each
  retry, so a transient send failure no longer loses a rumble stop or
  LED update. Stop on -ENODEV, -ESHUTDOWN or disabled output.
- Track lit player LEDs in a driver-owned mask updated from the value
  passed to brightness_set, instead of reading led_classdev.brightness,
  which the LED core does not update when a software blink is stopped
  during its on phase (Sashiko).
- Make HID_SANTROLLER depend on USB_HID || !USB_HID, so USB profile
  naming is not silently compiled out with HID_SANTROLLER=y and
  USB_HID=m (Sashiko).
- Initialise the RGB LED colour intensities to full, so writing only
  brightness lights it white instead of sending 0,0,0 until
  multi_intensity is written (Sashiko).

Changes since v2:
- Track feature-report responses under the driver lock, accept only the
  first reply while discovery is pending, and ignore late replies once
  discovery has finished.
- Require matching input and output features reports; validate the input
  report ID/type before accepting capabilities.
- Serialize RGB component calculation and state copying. Initialize the
  RGB LED at brightness zero, matching its zero-valued color components.
- Preserve pending rumble work across resume and skip LED restoration if
  no registered input device exists. Validate the saved input against the
  registered hid-input list after hid_connect() before using it.
- Initialize player LED state before registering LEDs so an early
  userspace update is not overwritten.
- Do not expose force feedback when the euphoria LED capability is
  present, because turntables use the rumble command for that LED.
- Guard USB profile naming with IS_REACHABLE(CONFIG_USB_HID), keeping
  Bluetooth-only builds free of an unresolved USB HID reference.
- Use heap-backed storage for the feature query because USB transports
  may DMA the buffer. Distinguish local allocation failure from transport
  errors, stop retrying when the device is gone, and return zero on a
  successful query. Add a short wait after transient send errors to avoid
  exhausting retries immediately.

Testing:
- v4: built and linked hid-santroller.ko with W=1 against
  7.2.11-arch1-1, no warnings. The output retry was exercised with
  fault injection of -EIO into the output worker in a userspace harness
  using the driver's worker functions, under ASan and UBSan. The LED
  blink case was found by reading drivers/leds/led-core.c.
- v4 hardware testing with a USB drumtroller (1209:2883) against
  7.2.11-arch1-1: the driver binds to each gamepad interface and
  registers force feedback and four player LEDs. FF_RUMBLE effects
  uploaded through evdev rumble the device on each interface with no
  output report errors. The player indicator follows the lowest lit
  player LED, falls back when it is turned off, and turns off when all
  are off. Stopping a timer-triggered blink during its on phase now
  turns the indicator off. The RGB and euphoria LEDs, including the
  RGB intensity default, were not tested, as this device does not
  report them.
- Built hid-santroller.o with W=1 and linked hid-santroller.ko with W=1
  using the built multicolor LED symbol exports required for modpost.
- Checkpatch reported no errors; its one warning is for the existing
  -ENOSYS check.
- A prior draft was rebound on hardware and input was verified; that test
  was not repeated after the cumulative changes in this revision. Earlier
  v2 LED and rumble tests were also not repeated.

Previous versions:
v3: https://lore.kernel.org/linux-input/20261107234444.960207-2-sanjay.govind9@gmail.com/
v2: https://lore.kernel.org/linux-input/20261103015335.974344-1-sanjay.govind9@gmail.com/
v1: https://lore.kernel.org/linux-input/20261016025403.779635-1-sanjay.govind9@gmail.com/
---
 MAINTAINERS                  |   6 +
 drivers/hid/Kconfig          |  13 +
 drivers/hid/Makefile         |   1 +
 drivers/hid/hid-ids.h        |   4 +
 drivers/hid/hid-santroller.c | 717 +++++++++++++++++++++++++++++++++++
 5 files changed, 741 insertions(+)
 create mode 100644 drivers/hid/hid-santroller.c

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
index 2481bc01c435..85e9a8db06cc 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1138,6 +1138,19 @@ config HID_SAMSUNG
 	help
 	Support for Samsung InfraRed remote control or keyboards.
 
+config HID_SANTROLLER
+	tristate "Santroller game controller support"
+	depends on USB_HID || !USB_HID
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
index 000000000000..cdbe569a4f60
--- /dev/null
+++ b/drivers/hid/hid-santroller.c
@@ -0,0 +1,717 @@
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
+#include <linux/delay.h>
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
+#define SANTROLLER_OUTPUT_ATTEMPTS	3
+#define SANTROLLER_OUTPUT_RETRY_DELAY	20
+#define SANTROLLER_FEATURES_REPORT_SIZE	3
+
+#define SANTROLLER_FEATURES_RETRIES	8
+#define SANTROLLER_FEATURES_TIMEOUT	msecs_to_jiffies(100)
+#define SANTROLLER_FEATURES_RETRY_DELAY	msecs_to_jiffies(20)
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
+	bool features_pending;
+	bool features_received;
+	const char *name;
+	u8 caps;
+
+	int player_id;
+	struct led_classdev player_leds[SANTROLLER_NUM_PLAYER_LEDS];
+	struct led_classdev_mc rgb_led;
+	struct mc_subled rgb_subleds[3];
+	struct led_classdev euphoria_led;
+
+	spinlock_t lock;		/* protects feature and output state */
+	struct work_struct output_work;
+	bool output_enabled;
+	bool rumble_dirty;
+	bool player_dirty;
+	bool rgb_dirty;
+	u8 rumble[2];
+	u8 player_mask;
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
+ * next pending one into buf, or refresh command for a retry. Returns false
+ * if output is disabled or nothing is pending.
+ */
+static bool santroller_next_command(struct santroller *sc, u8 *buf, u8 command)
+{
+	guard(spinlock_irqsave)(&sc->lock);
+
+	if (!sc->output_enabled)
+		return false;
+
+	if (!command) {
+		if (sc->rumble_dirty)
+			command = SANTROLLER_CMD_RUMBLE;
+		else if (sc->player_dirty)
+			command = SANTROLLER_CMD_PLAYER_LED;
+		else if (sc->rgb_dirty)
+			command = SANTROLLER_CMD_RGB_LED;
+		else
+			return false;
+	}
+
+	memset(buf, 0, SANTROLLER_OUTPUT_REPORT_SIZE);
+	buf[0] = SANTROLLER_REPORT_ID_OUTPUT;
+	buf[1] = command;
+
+	switch (command) {
+	case SANTROLLER_CMD_RUMBLE:
+		sc->rumble_dirty = false;
+		buf[2] = sc->rumble[0];
+		buf[3] = sc->rumble[1];
+		break;
+	case SANTROLLER_CMD_PLAYER_LED:
+		sc->player_dirty = false;
+		buf[2] = sc->player;
+		break;
+	case SANTROLLER_CMD_RGB_LED:
+		sc->rgb_dirty = false;
+		memcpy(&buf[2], sc->rgb, sizeof(sc->rgb));
+		break;
+	}
+
+	return true;
+}
+
+static void santroller_output_work(struct work_struct *work)
+{
+	struct santroller *sc = container_of(work, struct santroller, output_work);
+	int i, ret;
+
+	while (santroller_next_command(sc, sc->output_buf, 0)) {
+		for (i = 0; i < SANTROLLER_OUTPUT_ATTEMPTS; i++) {
+			ret = santroller_send_report(sc->hdev, sc->output_buf,
+						     SANTROLLER_OUTPUT_REPORT_SIZE);
+			if (ret >= 0)
+				break;
+
+			hid_warn_ratelimited(sc->hdev,
+					     "failed to send output report: %d\n", ret);
+			if (ret == -ENODEV || ret == -ESHUTDOWN)
+				return;
+			if (i == SANTROLLER_OUTPUT_ATTEMPTS - 1)
+				break;
+
+			msleep(SANTROLLER_OUTPUT_RETRY_DELAY);
+			if (!santroller_next_command(sc, sc->output_buf,
+						     sc->output_buf[1]))
+				return;
+		}
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
+ * Track the lit LEDs from the value passed in rather than led->brightness,
+ * which the LED core does not update on every path (e.g. when stopping a
+ * software blink). Different player LEDs can be set concurrently, so the
+ * mask is only touched under the lock.
+ */
+static void santroller_player_led_set(struct led_classdev *led,
+				      enum led_brightness value)
+{
+	struct hid_device *hdev = to_hid_device(led->dev->parent);
+	struct santroller *sc = hid_get_drvdata(hdev);
+	unsigned int idx = led - sc->player_leds;
+
+	guard(spinlock_irqsave)(&sc->lock);
+
+	if (value)
+		sc->player_mask |= BIT(idx);
+	else
+		sc->player_mask &= ~BIT(idx);
+
+	sc->player = sc->player_mask ? __ffs(sc->player_mask) :
+				       SANTROLLER_PLAYER_LED_OFF;
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
+	guard(spinlock_irqsave)(&sc->lock);
+
+	led_mc_calc_color_components(mc, brightness);
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
+	}
+
+	/* Initialize the state before exposing any LED to userspace */
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		sc->player_mask = BIT(player);
+		sc->player = player;
+		sc->player_dirty = true;
+		santroller_schedule_output(sc);
+	}
+
+	for (i = 0; i < SANTROLLER_NUM_PLAYER_LEDS; i++) {
+		led = &sc->player_leds[i];
+		ret = devm_led_classdev_register(&hdev->dev, led);
+		if (ret)
+			return ret;
+	}
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
+	int i;
+
+	sc->rgb_subleds[0].color_index = LED_COLOR_ID_RED;
+	sc->rgb_subleds[1].color_index = LED_COLOR_ID_GREEN;
+	sc->rgb_subleds[2].color_index = LED_COLOR_ID_BLUE;
+	/* Default to white, so writing only brightness lights the LED. */
+	for (i = 0; i < ARRAY_SIZE(sc->rgb_subleds); i++)
+		sc->rgb_subleds[i].intensity = 255;
+	sc->rgb_led.subled_info = sc->rgb_subleds;
+	sc->rgb_led.num_colors = ARRAY_SIZE(sc->rgb_subleds);
+
+	led->name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "%s:rgb:indicator",
+				   dev_name(&sc->input->dev));
+	if (!led->name)
+		return -ENOMEM;
+
+	led->brightness = 0;
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
+	/*
+	 * On turntables, equal rumble values control the euphoria LED instead.
+	 * Do not expose both interfaces for the shared output command.
+	 */
+	if ((sc->caps & SANTROLLER_CAP_RUMBLE) &&
+	    !(sc->caps & SANTROLLER_CAP_EUPHORIA_LED)) {
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
+	if (!sc || report->type != HID_INPUT_REPORT ||
+	    report->id != SANTROLLER_REPORT_ID_FEATURES ||
+	    size < SANTROLLER_FEATURES_REPORT_SIZE ||
+	    data[0] != SANTROLLER_REPORT_ID_FEATURES)
+		return 0;
+
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		if (sc->features_pending && !sc->features_received) {
+			sc->caps = data[2];
+			sc->features_received = true;
+			complete(&sc->features_done);
+		}
+	}
+
+	return 0;
+}
+
+/* The device answers the features command with an input report */
+static int santroller_get_features(struct santroller *sc)
+{
+	u8 *buf __free(kfree) = kmalloc(2, GFP_KERNEL);
+	unsigned long timeout = SANTROLLER_FEATURES_TIMEOUT;
+	bool received;
+	int i, ret = -ETIMEDOUT;
+
+	if (!buf)
+		return -ENOMEM;
+
+	if (sc->hdev->bus == BUS_BLUETOOTH)
+		timeout = SANTROLLER_FEATURES_TIMEOUT_BT;
+
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		sc->features_pending = true;
+		sc->features_received = false;
+		reinit_completion(&sc->features_done);
+	}
+
+	for (i = 0; i < SANTROLLER_FEATURES_RETRIES; i++) {
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			received = sc->features_received;
+			if (!received)
+				reinit_completion(&sc->features_done);
+		}
+
+		if (received) {
+			ret = 0;
+			break;
+		}
+
+		buf[0] = SANTROLLER_REPORT_ID_FEATURES;
+		buf[1] = 0;
+		ret = santroller_send_report(sc->hdev, buf, 2);
+		if (ret < 0) {
+			if (ret == -ENOMEM)
+				ret = -ETIMEDOUT;
+			if (ret == -ENODEV || ret == -ESHUTDOWN)
+				break;
+			wait_for_completion_timeout(&sc->features_done,
+						    SANTROLLER_FEATURES_RETRY_DELAY);
+			continue;
+		}
+
+		if (wait_for_completion_timeout(&sc->features_done, timeout)) {
+			ret = 0;
+			break;
+		}
+
+		ret = -ETIMEDOUT;
+	}
+
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		if (sc->features_received)
+			ret = 0;
+		sc->features_pending = false;
+	}
+
+	return ret;
+}
+
+static bool santroller_has_features_report(struct hid_device *hdev)
+{
+	struct hid_report *report;
+
+	report = hdev->report_enum[HID_OUTPUT_REPORT]
+			.report_id_hash[SANTROLLER_REPORT_ID_FEATURES];
+	if (!report || !report->maxfield || !report->field[0]->maxusage)
+		return false;
+	if (report->field[0]->usage[0].hid != SANTROLLER_FEATURES_USAGE)
+		return false;
+
+	report = hdev->report_enum[HID_INPUT_REPORT]
+			.report_id_hash[SANTROLLER_REPORT_ID_FEATURES];
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
+#if IS_REACHABLE(CONFIG_USB_HID)
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
+#else
+	return NULL;
+#endif
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
+	struct hid_input *hi;
+	bool input_registered = false;
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
+	if (ret == -ENOMEM || ret == -ENODEV || ret == -ESHUTDOWN) {
+		hid_device_io_stop(hdev);
+		goto err_close;
+	}
+	if (ret)
+		hid_warn(hdev, "failed to get device features: %d\n", ret);
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
+	/*
+	 * input_configured() runs before hid-input discards unpopulated
+	 * devices, so verify the saved pointer is still registered.
+	 */
+	if (sc->input && (hdev->claimed & HID_CLAIMED_INPUT)) {
+		list_for_each_entry(hi, &hdev->inputs, list) {
+			if (hi->input == sc->input && hi->registered) {
+				input_registered = true;
+				break;
+			}
+		}
+	}
+	if (!input_registered)
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
+	if (!sc || !sc->input)
+		return 0;
+
+	/* The device may have lost its LED state, so send it again */
+	guard(spinlock_irqsave)(&sc->lock);
+
+	sc->player_dirty = sc->caps & SANTROLLER_CAP_PLAYER_LEDS;
+	sc->rgb_dirty = sc->caps & SANTROLLER_CAP_RGB_LED;
+	sc->rumble_dirty |= !!(sc->caps & SANTROLLER_CAP_EUPHORIA_LED);
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

