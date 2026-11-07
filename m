Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095145;
	b=3wTDwmSMP2N3AH3Keu8+Tck2YQURcEEXDEhKpRYHgdnetzCq3SbTy2C73CnNm2ujby3+
	 USqo87LFugAJ8RBv1hfYptlQfs4ufo6Qqllf32qofmeQIkaif0DbTkT4YxoIu3s8Adm1S
	 pDWAvt6T0+A3wNLvt6zQP0jAyzYdiX0BUgmUNlPplhCnTsIzb8ua3VWiOd8YJCM5a7VdT
	 4zz+b/RFExiRZPtNavBBJnICqdhp55O3mf80dxigBw5CG6IxxdEROHx+c0PkGWLgyJAam
	 5ppGtj8xy4f4XGF9bOSTqR3v5NDoVk2Um1DTzDzNaGEBsLFK73MYWRWF20/73lXYu/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+90GaqulLbMzkXtcvUDqGzDw73eUyF/S/il+FJwGJGQ=;
	b=0lyWl/USm7DLUv950FuvYzBN4N2jbMincybLizI//FagrKbe+eR/rOcLXelhjPlb8Pq9
	 byxGcew4VW80FzbbJ0RQZWAAzKSR6Y/s5SxWwa7RnKU/KdZZ4RFVAiG7p4AbfE3cL35Cj
	 P3LhgwFQL6LSa+RNeWBjYMlzwJydAC6/enhMYhgoQpYqzTQLNR6eIXjLO3O0TfGq624N8
	 4FJEEMBEUHtGHPnUqP8suRxuNnkqYwqt5ySPvD8vPPaliwECgsj4SDPVReRgFvireby0M
	 cOXnuLosO4QMIE7sz/00g2Cxxvia6RnM5ZSZ5Nu32rA5DNNaZbLY1t1hHfAITtSYhjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t99hftuC;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3D606A32E
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 23:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC3D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t99hftuC
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed08b07213so220085ad.2
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794095143; x=1794699943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+90GaqulLbMzkXtcvUDqGzDw73eUyF/S/il+FJwGJGQ=;
        b=t99hftuCufoLgV09ZO6+4dIf2ukhvMoEP+61YdhEOhf7YSi58CwSVDeJG4vbf3a3X8
         4z9Noq+c7PW8djPNKDE6uTspZmoWjmZmO/7by9zgU54pYS8tOnrDwQCpzIAH6if1HjhQ
         2SiJmGQIudw2haP4YDJz5X6WcjlABXmgwUUdG7qM8x8JKIXusWRJF3YJx7R3z0ISMqFO
         wNguo1q6vliDlDhZD8RQcF6XG8OM1sGpvoaJQCZgUvWZZ2SeTHgjKfpTS9s0jtllKtAN
         E3ey813fYio1L7RpYMfMwqmikEIDN+WK6aeCVYBHw4pa6Ythb54Dikj6pUq0Zrg5dB9w
         iSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794095143; x=1794699943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+90GaqulLbMzkXtcvUDqGzDw73eUyF/S/il+FJwGJGQ=;
        b=uPHY53pqzJUd4SflrJX+9R5u80VHpkzsCHD6y4+/Cvjh5JhH1QzCVm9R67Sm2uRIvh
         w9gt1LIxSRlAxObK6qd50J2icfjeNyYqaDEF2wQp/oHiqB6FDYfoFfpHUGmKPwPygeiB
         M8N+o+k7ncHQZoCmt2e772xWX/aVAkrSvsRSLL4HdV5P0hgkUefWRrVs9slRCtDTR2ts
         HytEXUP4Zq+f0d7/jJX+SZbnXKXNxUEXBpDfF69v0OD4bmfEDFQIoqxiPFD/Y5+wmICW
         o2iLBikyO6ODJuRuq+kCyhr2/b5/aU/3kbSZyUmXdB96LQ5v7ymySTxlD7zt5Ks6ynjr
         Cyug==
X-Forwarded-Encrypted: i=1; AL+hErGEF/l+aVn2d+tLWVmPfqAubIC/jqIN2fHJ7sfeIRBBVviTFh4OS7OrcEpNlM1ndAZbFybISA9eMpCUHg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+/FBy2aXv+cjEcdmj5URqun5YXGNYyNLXHbUtEMVGWQ11EO4oN
	HsbBDlq9mG7zjnrzQWSnpJ0MofnbwupEXhvS1TkGAAT1yp3FENT3iJ43
X-Gm-Gg: AYBFou1xE3oFxv4sDtRhNTCnNGcAf4d3A/jJuRTTIsmDolcYw9ro1dBsDKHQX7KJOe5
	bsosEH44mNv6FgdOAg8WVoukcwfHymF/TrmBbm1hjQ3hBUN3nmNKAJo5q5uAzDI/tR9gugFBbT7
	GgnNKuU7sOro/LlOUcDYuK4PvP1ZJEf5OKatufPzGs4bzCM9YbLTA6z3W7qDPgb8VXl3Jy2X7wt
	AgDHUgqJ+N0MHNWDuFn6RYuxBuzOx86X5FJYC52yp0Ck9IJOleGpez8+ggcxp+8Ev8eJQ+KntZJ
	raxjeBLoO+D5yEHesAvOyr5BCQi/fSXCtIY0XFNycO/d6SS7MIalwCLY1MbzNKO/hdbYSHzIlrx
	MkhuU/V8wmkiXb2ciivcuvFMx1T3FRirpYCX02XyY1cBX5b2Z9cq9hOEZOrVbhAQQPFZJoUVPOl
	2tzN8UMle7gOxWMvhnhe2RZRO6DLToXmhIECFKwLKuB+TGSTKmbR2o3kV/wf7A+YrpnbyLUPHS/
	ayqnfweE2bIzXOTK3Y/Yd3ZqG9qW8hrXdGekLNNSGmUzXa0bVCBjIf9MkAa1GTRqrBe6BF0wfBM
	9TrX3LkCQHxGib0xRq9KNNg1z8Hd/lGwrl4aaVW0VbaNjyscs8eacPvhaGBhItFv/aiLdBBOvzB
	7sWYK5osiyM+qKfS+oOsyGHgNDzD3rGcwFFF29HyD4LBRIoPDw1tkv7RIe2QufkrL
X-Received: by 2002:a17:90b:3f88:b0:3a0:516d:9f88 with SMTP id 98e67ed59e1d1-3b12d336fc4mr47264a91.26.1794095143120;
        Sat, 07 Nov 2026 15:45:43 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([203.94.55.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d2faesm4984476a91.14.2026.11.07.15.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 15:45:42 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: Sanjay Govind <sanjay.govind9@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev
Subject: [PATCH v3] HID: santroller: add driver for Santroller controllers
Date: Sun,  8 Nov 2026 12:44:45 +1300
Message-ID: <20261107234444.960207-2-sanjay.govind9@gmail.com>
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
a matching input/output features report pair use default HID handling
within this driver, without Santroller-specific setup. Devices that
advertise the pair but fail to answer are still connected as plain
gamepads.

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
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
- Retry failed output sends up to three total attempts, with a 20 ms
  delay between attempts. Refresh retries from current state under the
  lock and stop on disconnect or disabled output. Persistent failures
  are still logged and abandoned after the bounded attempt limit.
- Correct the fallback description: interfaces without the features
  report pair use default HID handling within Santroller, rather than
  binding to hid-generic.
- Use heap-backed storage for the feature query because USB transports
  may DMA the buffer. Distinguish local allocation failure from transport
  errors, stop retrying when the device is gone, and return zero on a
  successful query. Add a short wait after transient send errors to avoid
  exhausting retries immediately.

Testing:
- x86-64 GCC 16.2.1, W=1: vmlinux and modules linked with Santroller
  modular/USB disabled, modular/USB HID built in, both modular,
  Santroller built in/USB HID modular, and built in/USB disabled.
  Verified hid_is_usb symbol reachability. No driver warnings or link
  errors; one unrelated proc_sysctl.c unused-variable warning.
- On 7.2.11-arch1-1, tested the final rebuilt module: USB and Bluetooth
  inputs, rumble, player LEDs, RGB and suspend/resume; USB unplug/replug;
  euphoria LED.
- A v1 USB device lacking the features-report pair bound with default
  HID handling; buttons and axes worked, without force feedback or LEDs.
- With firmware modified to suppress the features reply while retaining
  the report pair, verified -ETIMEDOUT and plain-gamepad registration
  without force feedback; the submitter confirmed inputs still worked.
- Ten ASan/UBSan fault-injection scenarios passed using the actual output
  worker functions, covering retries, exhaustion, disconnect, updated
  state and shutdown. The serial harness does not test kernel locking
  or real transports.
- Checkpatch: no errors, one existing -ENOSYS warning.
- Not tested: the exact Xtensa/SPARC64 robot configs.

AI assistance:
- Copilot assisted with revision preparation, build validation and this
  testing summary. The existing revision changelog describes changes
  prepared with AI assistance; the submitter remains responsible for
  reviewing and understanding the code before submission.
- Sashiko using Claude Code reviewed the driver. Copilot checked its
  output-loss finding with fault injection and implemented bounded
  retries, and corrected the fallback description.
---
 MAINTAINERS                  |   6 +
 drivers/hid/Kconfig          |  12 +
 drivers/hid/Makefile         |   1 +
 drivers/hid/hid-ids.h        |   4 +
 drivers/hid/hid-santroller.c | 709 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 732 insertions(+)

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
index 000000000000..7dcc5d7eae60
--- /dev/null
+++ b/drivers/hid/hid-santroller.c
@@ -0,0 +1,709 @@
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
+						   SANTROLLER_FEATURES_RETRY_DELAY);
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

base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
