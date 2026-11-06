Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992659;
	b=m83Jed9yp6b4DdOBo14PwBIlie6o8JrGVEu60nbJJ2zsnaLNyvE1jht6r2iPzgPAxB4s
	 yYNDeCQ9I0S1JpkMefuOGgwPCj3YTE5Fl7egPuHyIuY12G9cWDXXSTCu5QKpUvFmd6My1
	 0fo+NfTgnCFab0ICbuWgHO/OmRybqH4cmHDsygorvcf7LMv9wG/iJPzqFFUsbX/eI5lMr
	 tScLviWkJsjowjbbtr0vZjB/EVc1IAfwh3kWNB/qdBJQZnidJp4CskKd10A6pvdkNnPeQ
	 W4u0/rUfLNM9jKWGAQRaAKhIp1nwScMnONlNtceYVzTAIq6R2tt2ViS+16edrh1XgtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TkImbWXputW6a+agYt4jOsFgj4Hox0iRR2L6IjAgmzU=;
	b=CwLITYqfUQLEV0ssN9yJlGLG8/YzvyBhtde7+cMQBKx6VEjS2DANWPgeDkxYzXhnuNrc
	 /+i/4K7bAib6if0FEdADrd3QlWzucEDlR2YJVsiJbou/UxDLGHiwJYEX+a+pRjVqs2sI2
	 pMYhzAcTkB1MLAoyHpGeHGrLaKIrwdbRVGxpbYSTNeBy44MBL5NYFuhKBV2pdSnW04fvh
	 waS3y7wOe/OALs+lY8hxBjJssgQ9NSVLgWO2a4zCCpPSG2SG88W1ocrDYxnQ/ZEsyC8VX
	 LGNdvo4LvIM9rVIySdR2vUHMPkDnrZydTX17daKApQ+2BR4S2EXQOS2MDKBVgvkyYGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVrLhAMG;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D7606A329
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 827D7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVrLhAMG
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso11187015e9.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 11:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992657; x=1794597457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkImbWXputW6a+agYt4jOsFgj4Hox0iRR2L6IjAgmzU=;
        b=iVrLhAMGQoiozdJ/8TcqyF+YTD4By+cVarUOFxdXTOKU64YgCBOE69tbzquFeI6T0O
         +l0ESMFjx9hG7EwXNlCHT79pRRShh99S5Ms2flwB9Vk7jKfibKz9WZgJYJwDtqoxBfBA
         OYN8NUN13NBqKr3STroJX+G9sXzw+jVhw2I61PaV9pfxLeApUa23xZmqRudOJ71gKqR1
         fJJoUCDyY73zDaCdE2VPcqK8NG/iW2fUFH+cVjRiN5BK10amWjhwtnfBDXpGqlYePvuq
         1ECuwEkuq43tkKFyZBQob+fWQ5xgagzvLBIbHPVdTM7mnpg08u5QE/ZtOkWzXlCy524f
         vZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992657; x=1794597457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkImbWXputW6a+agYt4jOsFgj4Hox0iRR2L6IjAgmzU=;
        b=1RhfxtRrDYsS5vJL+cYttF2vD/b01lTXJ1Xmyod8NNwtSLo9KJbzf9isuiGpNMsu7g
         QLHzgiqU71GGR+L2LeI6xub9DjKm6cjbBoIjiLK7cbbfijb9qiVq0tyxrxiFwXeEZ3+b
         ovdPrQQe6bkP53KmnRvze7QGe1HP5zS301VIUwqfexuWnZNNLYc3mUKh1jeElsbJCb8P
         JNXY7oCFuvLioIfOYXvFlSEtxGWYhKAS0pgb9qxOgnrR5wN7m+WiCuxySAiWw9K03YoR
         QizeAIjy/rxfusatxOO+DQHDbupMRhS3ukQMDBVUiAuzwH3jVbraf3LteD1DD4ABl0X3
         +ueA==
X-Forwarded-Encrypted: i=1; AKwUvByZh4otl+VwhKzuQCcsSzqfXowZLrW/TekOoL4dfR+0LTdelbtpOc4bMbO4QKsOfmnN3FpvTuw7ZDKOjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+feL17LtwiIeTdaHLXzvcTLcQHs62Up2rbTb6ZR70uDjEYQnFy
	WRqIztADCOotZNidL5nrD1QaaBIg5M8QlD8S1WL/JWkIwryoxwaHXII4
X-Gm-Gg: AYBFou09585JU4QCVr7AJ5E1QCImfnyudvW9qiNU+HyZIkgLItjhRLp3oz/8RkAPiMA
	wLg/NqS9JrDUr3UWK1pYyR7MTYpsGf9QV0Pq6/O6SKh0m88QyOYsiqyFRUTX715ca0uzSVs4iOJ
	7lFC3EFB4WcCT+OUJ9Vqsbfypff3QSAPKGadFS6LS42yCPBHmNeKbw5J5GZ6gYhCsN/H0pyZnJm
	LLvQ+mZY7MojNTIse179Hqi7EzKePmRHLKc+4OawaCyPGsMTi3P2UI4MrQUR+nPnKXQuWyDG/2R
	sfUkqlxsQGYP0floXI18lRz8KB5kxZeIzKbZSOT0TDQthlE3wPsLmwvQsK+Gvqcjc0x51ila621
	BOCXI0MKIbc+/tpC2FcZ8SxIyTyEwZmSvDtiNdPoL1vbD+2ptYZiwKeVTmojwkPAWMcjl7cvYyn
	X+8xFv7mueWajU4BiXZ7TEE8pZddJlp7WJQnPyNcVoiXzfgR04sREuwV/WwuPz6+/2y3rNTryk3
	sIW3ShbC15TnaQ7kKYf+n/jcTCYCmv+48H8Xs3VDaItEDiMBje4wSczr1s3zHifYhmlUZb1Io/y
	o5OqzpsNvNQbjJbHOWuPMp4b4JmG3ohjrFP0Ufz4gXHI7RzFBqKe/hKOp7Yc4eiiQ+2BoA2Qd3X
	X5D2YDhvPpC4JnTJ00zixFme1QvW3ZaDbhT8BNOd0E8qH0ZPd
X-Received: by 2002:a05:600c:19d1:b0:4b1:32c8:27db with SMTP id 5b1f17b1804b1-4b6de691614mr59683945e9.22.1793992656799;
        Fri, 06 Nov 2026 11:17:36 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6187sm5224380f8f.46.2026.11.06.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:17:35 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH 3/3] input: joystick: stinger: port Gravis Stinger driver to safe Rust
Date: Sat,  7 Nov 2026 00:17:14 +0500
Message-ID: <20261106191714.334055-4-harepro29@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106191714.334055-1-harepro29@gmail.com>
References: <20261106191714.334055-1-harepro29@gmail.com>
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

Rewrite the legacy Gravis Stinger serial gamepad driver in safe Rust,
replacing drivers/input/joystick/stinger.c with stinger.rs.

The new implementation:
- Uses the newly introduced `kernel::input` and `kernel::serio`
  abstractions.
- Contains zero `unsafe` blocks in the driver code itself.
- Preserves full protocol compatibility with the Gravis Stinger hardware
  (9600 baud, 8N1, 4-byte packet format with 10 buttons and 2 axes).
- Adds `depends on RUST` to CONFIG_JOYSTICK_STINGER in Kconfig.

Signed-off-by: clicedvly768 <harepro29@gmail.com>
---
 drivers/input/joystick/Kconfig    |   1 +
 drivers/input/joystick/stinger.c  | 191 ------------------------------
 drivers/input/joystick/stinger.rs | 174 +++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 191 deletions(-)
 delete mode 100644 drivers/input/joystick/stinger.c
 create mode 100644 drivers/input/joystick/stinger.rs

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 7755e5b454d2..e672a3bc6dcc 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -188,6 +188,7 @@ config JOYSTICK_SPACEBALL
 	  module will be called spaceball.
 
 config JOYSTICK_STINGER
+	depends on RUST
 	tristate "Gravis Stinger gamepad"
 	select SERIO
 	help
diff --git a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
deleted file mode 100644
index 011f9b137dca..000000000000
--- a/drivers/input/joystick/stinger.c
+++ /dev/null
@@ -1,191 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  Copyright (c) 2000-2001 Vojtech Pavlik
- *  Copyright (c) 2000 Mark Fletcher
- */
-
-/*
- * Gravis Stinger gamepad driver for Linux
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/input.h>
-#include <linux/serio.h>
-
-#define DRIVER_DESC	"Gravis Stinger gamepad driver"
-
-MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-
-/*
- * Constants.
- */
-
-#define STINGER_MAX_LENGTH 8
-
-/*
- * Per-Stinger data.
- */
-
-struct stinger {
-	struct input_dev *dev;
-	int idx;
-	unsigned char data[STINGER_MAX_LENGTH];
-	char phys[32];
-};
-
-/*
- * stinger_process_packet() decodes packets the driver receives from the
- * Stinger. It updates the data accordingly.
- */
-
-static void stinger_process_packet(struct stinger *stinger)
-{
-	struct input_dev *dev = stinger->dev;
-	unsigned char *data = stinger->data;
-
-	if (!stinger->idx) return;
-
-	input_report_key(dev, BTN_A,	  ((data[0] & 0x20) >> 5));
-	input_report_key(dev, BTN_B,	  ((data[0] & 0x10) >> 4));
-	input_report_key(dev, BTN_C,	  ((data[0] & 0x08) >> 3));
-	input_report_key(dev, BTN_X,	  ((data[0] & 0x04) >> 2));
-	input_report_key(dev, BTN_Y,	  ((data[3] & 0x20) >> 5));
-	input_report_key(dev, BTN_Z,	  ((data[3] & 0x10) >> 4));
-	input_report_key(dev, BTN_TL,     ((data[3] & 0x08) >> 3));
-	input_report_key(dev, BTN_TR,     ((data[3] & 0x04) >> 2));
-	input_report_key(dev, BTN_SELECT, ((data[3] & 0x02) >> 1));
-	input_report_key(dev, BTN_START,   (data[3] & 0x01));
-
-	input_report_abs(dev, ABS_X, (data[1] & 0x3F) - ((data[0] & 0x01) << 6));
-	input_report_abs(dev, ABS_Y, ((data[0] & 0x02) << 5) - (data[2] & 0x3F));
-
-	input_sync(dev);
-
-	return;
-}
-
-/*
- * stinger_interrupt() is called by the low level driver when characters
- * are ready for us. We then buffer them for further processing, or call the
- * packet processing routine.
- */
-
-static irqreturn_t stinger_interrupt(struct serio *serio,
-	unsigned char data, unsigned int flags)
-{
-	struct stinger *stinger = serio_get_drvdata(serio);
-
-	/* All Stinger packets are 4 bytes */
-
-	if (stinger->idx < STINGER_MAX_LENGTH)
-		stinger->data[stinger->idx++] = data;
-
-	if (stinger->idx == 4) {
-		stinger_process_packet(stinger);
-		stinger->idx = 0;
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * stinger_disconnect() is the opposite of stinger_connect()
- */
-
-static void stinger_disconnect(struct serio *serio)
-{
-	struct stinger *stinger = serio_get_drvdata(serio);
-
-	serio_close(serio);
-	serio_set_drvdata(serio, NULL);
-	input_unregister_device(stinger->dev);
-	kfree(stinger);
-}
-
-/*
- * stinger_connect() is the routine that is called when someone adds a
- * new serio device that supports Stinger protocol and registers it as
- * an input device.
- */
-
-static int stinger_connect(struct serio *serio, struct serio_driver *drv)
-{
-	struct stinger *stinger;
-	struct input_dev *input_dev;
-	int err = -ENOMEM;
-
-	stinger = kmalloc_obj(*stinger);
-	input_dev = input_allocate_device();
-	if (!stinger || !input_dev)
-		goto fail1;
-
-	stinger->dev = input_dev;
-	snprintf(stinger->phys, sizeof(stinger->phys), "%s/serio0", serio->phys);
-
-	input_dev->name = "Gravis Stinger";
-	input_dev->phys = stinger->phys;
-	input_dev->id.bustype = BUS_RS232;
-	input_dev->id.vendor = SERIO_STINGER;
-	input_dev->id.product = 0x0001;
-	input_dev->id.version = 0x0100;
-	input_dev->dev.parent = &serio->dev;
-
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input_dev->keybit[BIT_WORD(BTN_A)] = BIT_MASK(BTN_A) | BIT_MASK(BTN_B) |
-		BIT_MASK(BTN_C) | BIT_MASK(BTN_X) | BIT_MASK(BTN_Y) |
-		BIT_MASK(BTN_Z) | BIT_MASK(BTN_TL) | BIT_MASK(BTN_TR) |
-		BIT_MASK(BTN_START) | BIT_MASK(BTN_SELECT);
-	input_set_abs_params(input_dev, ABS_X, -64, 64, 0, 4);
-	input_set_abs_params(input_dev, ABS_Y, -64, 64, 0, 4);
-
-	serio_set_drvdata(serio, stinger);
-
-	err = serio_open(serio, drv);
-	if (err)
-		goto fail2;
-
-	err = input_register_device(stinger->dev);
-	if (err)
-		goto fail3;
-
-	return 0;
-
- fail3:	serio_close(serio);
- fail2:	serio_set_drvdata(serio, NULL);
- fail1:	input_free_device(input_dev);
-	kfree(stinger);
-	return err;
-}
-
-/*
- * The serio driver structure.
- */
-
-static const struct serio_device_id stinger_serio_ids[] = {
-	{
-		.type	= SERIO_RS232,
-		.proto	= SERIO_STINGER,
-		.id	= SERIO_ANY,
-		.extra	= SERIO_ANY,
-	},
-	{ 0 }
-};
-
-MODULE_DEVICE_TABLE(serio, stinger_serio_ids);
-
-static struct serio_driver stinger_drv = {
-	.driver		= {
-		.name	= "stinger",
-	},
-	.description	= DRIVER_DESC,
-	.id_table	= stinger_serio_ids,
-	.interrupt	= stinger_interrupt,
-	.connect	= stinger_connect,
-	.disconnect	= stinger_disconnect,
-};
-
-module_serio_driver(stinger_drv);
diff --git a/drivers/input/joystick/stinger.rs b/drivers/input/joystick/stinger.rs
new file mode 100644
index 000000000000..daa199463631
--- /dev/null
+++ b/drivers/input/joystick/stinger.rs
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Gravis Stinger gamepad driver written in safe Rust.
+//!
+//! Rust port of legacy C driver `drivers/input/joystick/stinger.c`.
+//!
+//! Authors:
+//! - Original C driver: Vojtech Pavlik <vojtech@ucw.cz>, Mark Fletcher
+//! - Rust port: Rust for Linux Contributors
+
+use kernel::{
+    bindings,
+    input::{bus, event_type, AllocatedDevice, RegisteredDevice},
+    prelude::*,
+    serio,
+    types::ForeignOwnable,
+};
+
+const DRIVER_NAME: &CStr = c"stinger";
+const DRIVER_DESC: &CStr = c"Gravis Stinger gamepad";
+
+const STINGER_MAX_LENGTH: usize = 8;
+
+/// Per-device state for an attached Gravis Stinger gamepad.
+struct Stinger {
+    input: RegisteredDevice,
+    idx: usize,
+    data: [u8; STINGER_MAX_LENGTH],
+}
+
+impl Stinger {
+    /// Decodes incoming 4-byte packets from the Gravis Stinger and reports input events.
+    fn process_packet(&self) {
+        if self.idx == 0 {
+            return;
+        }
+
+        let d0 = i32::from(self.data[0]);
+        let d1 = i32::from(self.data[1]);
+        let d2 = i32::from(self.data[2]);
+        let d3 = i32::from(self.data[3]);
+
+        // Report button states (active high bits in packet)
+        self.input
+            .report_key(bindings::BTN_A, ((d0 & 0x20) >> 5) != 0);
+        self.input
+            .report_key(bindings::BTN_B, ((d0 & 0x10) >> 4) != 0);
+        self.input
+            .report_key(bindings::BTN_C, ((d0 & 0x08) >> 3) != 0);
+        self.input
+            .report_key(bindings::BTN_X, ((d0 & 0x04) >> 2) != 0);
+        self.input
+            .report_key(bindings::BTN_Y, ((d3 & 0x20) >> 5) != 0);
+        self.input
+            .report_key(bindings::BTN_Z, ((d3 & 0x10) >> 4) != 0);
+        self.input
+            .report_key(bindings::BTN_TL, ((d3 & 0x08) >> 3) != 0);
+        self.input
+            .report_key(bindings::BTN_TR, ((d3 & 0x04) >> 2) != 0);
+        self.input
+            .report_key(bindings::BTN_SELECT, ((d3 & 0x02) >> 1) != 0);
+        self.input.report_key(bindings::BTN_START, (d3 & 0x01) != 0);
+
+        // Report 2-axis position: coordinates in range -64..64
+        self.input
+            .report_abs(bindings::ABS_X, (d1 & 0x3f) - ((d0 & 0x01) << 6));
+        self.input
+            .report_abs(bindings::ABS_Y, ((d0 & 0x02) << 5) - (d2 & 0x3f));
+
+        self.input.sync();
+    }
+}
+
+/// The safe serio driver implementation.
+struct StingerDriver;
+
+impl serio::Driver for StingerDriver {
+    type Data = KBox<Stinger>;
+
+    const ID_TABLE: &'static [serio::DeviceId] = &[
+        serio::DeviceId::new(
+            bindings::SERIO_RS232 as u8,
+            bindings::SERIO_ANY as u8,
+            bindings::SERIO_ANY as u8,
+            bindings::SERIO_STINGER as u8,
+        ),
+        serio::DeviceId::new(0, 0, 0, 0),
+    ];
+
+    fn connect(dev: &mut serio::Device) -> Result<Self::Data> {
+        let mut input_alloc = AllocatedDevice::new()?;
+
+        input_alloc.set_name(DRIVER_DESC);
+        input_alloc.set_phys(dev.phys().as_ptr());
+        input_alloc.set_id(bus::RS232, bindings::SERIO_STINGER as u16, 0x0001, 0x0100);
+
+        // Configure supported buttons
+        for btn in [
+            bindings::BTN_A,
+            bindings::BTN_B,
+            bindings::BTN_C,
+            bindings::BTN_X,
+            bindings::BTN_Y,
+            bindings::BTN_Z,
+            bindings::BTN_TL,
+            bindings::BTN_TR,
+            bindings::BTN_START,
+            bindings::BTN_SELECT,
+        ] {
+            input_alloc.set_capability(event_type::KEY, btn);
+        }
+
+        // Configure 2-axis joystick with flat margin of 4
+        input_alloc.set_capability(event_type::ABS, bindings::ABS_X);
+        input_alloc.set_capability(event_type::ABS, bindings::ABS_Y);
+        input_alloc.set_abs_params(bindings::ABS_X, -64, 64, 0, 4);
+        input_alloc.set_abs_params(bindings::ABS_Y, -64, 64, 0, 4);
+
+        let registered = input_alloc.register()?;
+
+        let stinger = KBox::new(
+            Stinger {
+                input: registered,
+                idx: 0,
+                data: [0; STINGER_MAX_LENGTH],
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok(stinger)
+    }
+
+    fn interrupt(
+        stinger: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        data: u8,
+        _flags: u32,
+    ) -> serio::IrqReturn {
+        if stinger.idx < STINGER_MAX_LENGTH {
+            stinger.data[stinger.idx] = data;
+            stinger.idx += 1;
+        }
+
+        if stinger.idx == 4 {
+            stinger.process_packet();
+            stinger.idx = 0;
+        }
+
+        serio::IrqReturn::Handled
+    }
+
+    fn disconnect(_data: Self::Data) {
+        // Automatically drops `stinger`, unregistering and freeing the input device.
+    }
+}
+
+module! {
+    type: StingerModule,
+    name: "stinger",
+    authors: ["Rust for Linux Contributors"],
+    description: "Gravis Stinger gamepad driver in safe Rust",
+    license: "GPL",
+}
+
+struct StingerModule {
+    _reg: serio::Registration<StingerDriver>,
+}
+
+impl kernel::Module for StingerModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        let reg = serio::Registration::<StingerDriver>::new(DRIVER_NAME)?;
+        pr_info!("Gravis Stinger safe Rust driver initialized\n");
+        Ok(Self { _reg: reg })
+    }
+}
-- 
2.56.0

