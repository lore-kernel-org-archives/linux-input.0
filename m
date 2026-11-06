Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996191;
	b=s7xGw8H/MfN4TlcEpfaM/SyzTpUmWwUBW6elhm988DJ5ZSnaELUQdk3eZCnGUNPZ8o3b
	 /UrThiRxdtO7o9dOOHo649GWfdQrhC+FBVxF/qcXW2bv6uvNY38vpjngVSdMwHNlnNPNL
	 IvVaT+ZShnpHyff6SRpdbc5/QuUYKdad9xV3QO/oRAgfI1ls39lIORTIDKE9yfZCthlUf
	 2P+84DEDHCoZfkIxTq5rQVHix0Fp2DuvqXQsWtCDxNTO2ARzOGdVE9Uu7ulJXKF+J4q/S
	 B1AMsPuFhM96QGTzAzsVxDfhDIHjuNK4SGaDv4dynL1g1Rn5mi2JH5Y+31E+rQ45RWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+V8fUXP+21eSF1SdOw1fNEVBAK4LZddVaY1RMJUR/EE=;
	b=zr5ErkIDrfgtQyCc2xMshXNgyluuiAB+hhdrM4doH86mIJEtAUAIomvs8MSFGjTfbAEu
	 dXkOL0kCtEsKoQrpNKP8xmqxCHsYyJzJlMoUdjtsJaoQBWYijtZCbjlQa0r6uXU3m0cT2
	 XWx0KwN2m/bnj1HdwyYCmDcP4UZheNJIR/5IvkgV1R52bwDfjMEKyTzBYNIoY1GynQA4n
	 epw19HQijfJtUTC/pfe7/VuaA2o00D51h1kYBfQKXnlyGeuVYmSNJkezu7zV8YDVqWp7V
	 zNC7Rmu+6bd60V/DJduHXl8cEKoFGMicgbAhbehSnV4LYMHCVJ1cYv1YLMo3YNG5JIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5qTnmbi;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93182606A32D
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 20:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93182606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5qTnmbi
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e4831c028so1097328f8f.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 12:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996189; x=1794600989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+V8fUXP+21eSF1SdOw1fNEVBAK4LZddVaY1RMJUR/EE=;
        b=R5qTnmbiHDBF4a2HdABpT5UTEnuAmQXRB3vZe0h7W3YXeBmfcXfaV45IFbwDPghZGy
         iF1MUm5xG+e5R/DBxlhLk6ox+6v9/WHVM9LTN5AR9SO0mRVphbY/GkxiBiT76lwX4975
         zimgyLS4b2ofLjrsFtYuiyn1uwPfWFaaxXRnmB1k0BoV5oNz6G1mMoYybaBl1i/QHyGM
         wEsm3TFip/TRzoDsERaKqN6PMJEVcVBlyRmXnHq4yHsVN3P9ljKPWCAkwi8vGPQp5+sU
         fudfoGEufGQD3qgCBgkD6eDqSmdEFI3O3M6NUKUQAo1ZbZYBW6fOQ/YwDVbHijpcETgg
         Dubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996189; x=1794600989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+V8fUXP+21eSF1SdOw1fNEVBAK4LZddVaY1RMJUR/EE=;
        b=UfplMODXFCNjBEByK6rtb/9PogAychHl4cJkTKjLteaT/7Plcm2AG8UWZexMsn5KfD
         C+TfCG//DwG9H6sLRhozkzPPsRMu8CvxPqhagq4fpDDy05wOTokJQ1YuFpXIkqdjIXuP
         /5GaqE+wja73FeM7kl0aRL5aAbXbwPgTmkZI/UUW9dyrCP5uCoMQsyXGDkKEmjfS+xkq
         /+G+8bd69AjcWDGVBqZQvfXmT/+DYapT2ndr/la4nBFBKfG44iRBpRJ2RQW7GhFmheKt
         fADnnr+5/HQYIoPfUzdgbBU9mVMnPsL/7YmE+M68xr4js62jWSpIxV4+x1849Cd0GTah
         kb0A==
X-Forwarded-Encrypted: i=1; AL+hErELvr2QWOiPK2ULY258Q7xE5rGRb4wZkiljM46xm2a7LtMMjZB0GBOw6KHqgiZxQclOMmp8mgQloDxezg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+PdTMjfYqzfMvgVThNiBfC+RZD7qPt5b68Ch2t/+fiKDJ/SmC6
	+wy2fmEod8sM5TKN55NLAAOEAa9DnHK/rT7Ks0OsTw8aJ2BOJnlssHRPHBGPqxylrTze1/Ru
X-Gm-Gg: AYBFou13/BmyFrGiNKFMA++iafIg4LZxbtkg+4wHMC4XI9DRmDu0SEw1kOLaf6yBW3k
	PtTTNe2C/oQixNRK1VX703H4fK/Wz4gzhWN8uu9hAoVUrePZty946PAzj8aRf+hRQ1CYH++Xl0y
	MlfjshBYK7Oxw2tvdbbwieoiP00LLT0Kr/tpVWMOMciODmNRLQWI3cElGEEC2yIIEabCEsHdgaC
	Z2mmkXqWf6u3Wunf3PCcMBaM69Ux0DmiL1XczcOh7CXqQQNWrZPyhW0FGuuaecTa/5vHnWblvBD
	hVIWq26ps0KXhbX6y4UO3lmp2FCnIdE+ttzxQrOJg0PL5cQN/HULyrhl5di4PaxKH2FcZHAiTzh
	MrcvEhZ5kKDukcGn68iSUVffN2LlOT3m62q/32JBjsvdIE09tM2C8REV04SNO1PIoHQgMq9PCnH
	gvQp+Srj7MjoDlGLs4RwP7LVVoyGPjW+w58YItbw/s1SM3nRj8XyB6c/dooDTEMdlb1pjK83MNP
	H8iA3poQ152c6Xvhv9LEDX31mB5cNiGFET6bvmF9kRcEx2LS1A0tAUJg7qCqFvqJhPGbkyJ5+cg
	6JQ0165cSVXe8XkeRiRwU4kH/hXPIIJv8vQ6cWDlqT3T4XR+lXCEYcp33MXFjhNUkJ4tcNOAkUf
	F1MVYF183Wr2wjOGrh7ekcOYG1Zh9BQTTmjt4LgfmRCMEQOBl68SmHLWVP4q0YAKX764Zug==
X-Received: by 2002:a05:6000:26c6:b0:48e:4a8a:e17f with SMTP id ffacd0b85a97d-49272d1c6e0mr6791981f8f.4.1793996188705;
        Fri, 06 Nov 2026 12:16:28 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d609a3sm5849954f8f.7.2026.11.06.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:16:28 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v2 2/2] rust: serio: add serio bus abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 01:14:29 +0500
Message-ID: <20261106201429.376997-3-harepro29@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106201429.376997-1-harepro29@gmail.com>
References: <20261106201429.376997-1-harepro29@gmail.com>
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

Add safe Rust abstractions for the serio (Serial I/O) bus subsystem and
port the legacy Gravis Stinger serial gamepad driver to safe Rust.

This introduces:
- `DeviceId`: a transparent wrapper around `struct serio_device_id`
  implementing `RawDeviceId` for type-safe matching tables.
- `IdTable` and `serio_device_table!` macro: guarantees a zero sentinel
  termination entry at compile time and creates modpost device aliases.
- `Device`: a borrowed serio port device instance implementing
  `AsRef<device::Device>` and `Deref<Target = device::Device>`.
- `IrqReturn`: re-exports `kernel::irq::IrqReturn` for interrupt handling.
- `Driver` trait: safe interface for serio drivers (`connect`,
  `interrupt`, `disconnect`).
- `Registration<T>`: safe RAII registration adapter that stores
  `Opaque<bindings::serio_driver>` inside `Pin<KBox<...>>` to avoid
  aliasing violations, and calls `__serio_register_driver` with the
  caller's `&'static ThisModule` to correctly track module ownership.
- Port management in `connect_callback`: opens the serio port prior
  to probe completion, sets driver data safely, and correctly propagates
  negative error numbers.
- `stinger_rust`: port of the Gravis Stinger serial gamepad driver in
  safe Rust (`drivers/input/joystick/stinger_rust.rs`), containing zero
  unsafe blocks, using `kernel::input` and `kernel::serio` abstractions.
- Non-regression Kconfig: adds `CONFIG_JOYSTICK_STINGER_RUST` guarded on
  `RUST && SERIO=y && INPUT=y` while retaining the original C driver
  (`stinger.c`) to maintain hardware support on non-Rust configurations
  and architectures without HAVE_RUST.
- Gated module entry `#[cfg(CONFIG_SERIO = "y")]` and helper guards
  `#if IS_REACHABLE(CONFIG_SERIO)` to avoid undefined symbols when serio
  is disabled or modular.

Signed-off-by: clicedvly768 <harepro29@gmail.com>
---
 drivers/input/joystick/Kconfig         |  14 ++
 drivers/input/joystick/Makefile        |   4 +
 drivers/input/joystick/stinger_rust.rs | 178 +++++++++++++++++
 rust/bindings/bindings_helper.h        |   1 +
 rust/helpers/helpers.c                 |   1 +
 rust/helpers/serio.c                   |  17 ++
 rust/kernel/lib.rs                     |   2 +
 rust/kernel/serio.rs                   | 256 +++++++++++++++++++++++++
 8 files changed, 473 insertions(+)
 create mode 100644 drivers/input/joystick/stinger_rust.rs
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/serio.rs

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 7755e5b454d2..89cc1dd9d865 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -197,6 +197,20 @@ config JOYSTICK_STINGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called stinger.
 
+config JOYSTICK_STINGER_RUST
+	bool "Safe Rust implementation of Gravis Stinger gamepad driver"
+	depends on JOYSTICK_STINGER
+	depends on RUST && SERIO = y && INPUT = y
+	default y
+	help
+	  Say Y here to use the safe Rust rewrite of the Gravis Stinger
+	  gamepad driver instead of the legacy C implementation.
+
+	  The Rust driver provides memory safety guarantees while preserving
+	  full hardware protocol compatibility.
+
+	  If unsure, say Y.
+
 config JOYSTICK_TWIDJOY
 	tristate "Twiddler as a joystick"
 	select SERIO
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 9976f596a920..786f950dcf52 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -33,7 +33,11 @@ obj-$(CONFIG_JOYSTICK_SENSEHAT)	+= sensehat-joystick.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
 obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
+ifdef CONFIG_JOYSTICK_STINGER_RUST
+obj-$(CONFIG_JOYSTICK_STINGER)		+= stinger_rust.o
+else
 obj-$(CONFIG_JOYSTICK_STINGER)		+= stinger.o
+endif
 obj-$(CONFIG_JOYSTICK_TMDC)		+= tmdc.o
 obj-$(CONFIG_JOYSTICK_TURBOGRAFX)	+= turbografx.o
 obj-$(CONFIG_JOYSTICK_TWIDJOY)		+= twidjoy.o
diff --git a/drivers/input/joystick/stinger_rust.rs b/drivers/input/joystick/stinger_rust.rs
new file mode 100644
index 000000000000..6250d628ee3d
--- /dev/null
+++ b/drivers/input/joystick/stinger_rust.rs
@@ -0,0 +1,178 @@
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
+const DRIVER_PHYS: &CStr = c"serio0/input0";
+
+const STINGER_MAX_LENGTH: usize = 8;
+
+kernel::serio_device_table!(
+    STINGER_IDS,
+    [serio::DeviceId::new(
+        bindings::SERIO_RS232 as u8,
+        bindings::SERIO_ANY as u8,
+        bindings::SERIO_ANY as u8,
+        bindings::SERIO_STINGER as u8,
+    )]
+);
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
+    const ID_TABLE: serio::IdTable = &STINGER_IDS;
+
+    fn connect(dev: &mut serio::Device) -> Result<Self::Data> {
+        let mut input_alloc = AllocatedDevice::new()?;
+
+        input_alloc.set_name(DRIVER_DESC);
+        input_alloc.set_phys(DRIVER_PHYS);
+        input_alloc.set_id(bus::RS232, bindings::SERIO_STINGER as u16, 0x0001, 0x0100);
+        input_alloc.set_parent(dev);
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
+        input_alloc.set_abs_params(bindings::ABS_X, -64, 64, 0, 4)?;
+        input_alloc.set_abs_params(bindings::ABS_Y, -64, 64, 0, 4)?;
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
+    name: "stinger_rust",
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
+    fn init(module: &'static ThisModule) -> Result<Self> {
+        let reg = serio::Registration::<StingerDriver>::new(DRIVER_NAME, module)?;
+        pr_info!("Gravis Stinger safe Rust driver initialized\n");
+        Ok(Self { _reg: reg })
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4b09d3980e10..0e44af5d770c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -89,6 +89,7 @@
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/serdev.h>
+#include <linux/serio.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 77cec85ad153..61cf3f77e85a 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -96,6 +96,7 @@
 #include "scatterlist.c"
 #include "security.c"
 #include "serdev.c"
+#include "serio.c"
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
diff --git a/rust/helpers/serio.c b/rust/helpers/serio.c
new file mode 100644
index 000000000000..849d0d48ac62
--- /dev/null
+++ b/rust/helpers/serio.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/serio.h>
+
+#if IS_REACHABLE(CONFIG_SERIO)
+
+__rust_helper void *rust_helper_serio_get_drvdata(struct serio *serio)
+{
+	return serio_get_drvdata(serio);
+}
+
+__rust_helper void rust_helper_serio_set_drvdata(struct serio *serio, void *data)
+{
+	serio_set_drvdata(serio, data);
+}
+
+#endif /* IS_REACHABLE(CONFIG_SERIO) */
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ff5c978758d0..711b7ef06b57 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -134,6 +134,8 @@
 pub mod seq_file;
 #[cfg(CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS)]
 pub mod serdev;
+#[cfg(CONFIG_SERIO = "y")]
+pub mod serio;
 pub mod sizes;
 #[cfg(CONFIG_SOC_BUS)]
 pub mod soc;
diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
new file mode 100644
index 000000000000..b4a8ec7139a2
--- /dev/null
+++ b/rust/kernel/serio.rs
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Serio (Serial I/O) bus abstractions for safe Rust drivers.
+//!
+//! Provides a safe Rust interface for serio devices and drivers in the Linux kernel,
+//! supporting input devices such as serial gamepads (e.g. Gravis Stinger), mice, and keyboards.
+
+use crate::{
+    bindings, device,
+    device_id::{IdTable as GenericIdTable, RawDeviceId},
+    error::{to_result, Result},
+    ffi::{c_int, c_uchar, c_uint},
+    prelude::*,
+    types::{ForeignOwnable, Opaque},
+    ThisModule,
+};
+use core::{marker::PhantomData, ops::Deref, pin::Pin, ptr::NonNull};
+
+pub use crate::irq::IrqReturn;
+
+/// Identifies supported serio hardware devices for auto-probing and matching.
+#[repr(transparent)]
+#[derive(Copy, Clone)]
+pub struct DeviceId(bindings::serio_device_id);
+
+impl DeviceId {
+    /// Creates a new serio device identifier.
+    #[inline]
+    pub const fn new(type_: u8, extra: u8, id: u8, proto: u8) -> Self {
+        Self(bindings::serio_device_id {
+            type_,
+            extra,
+            id,
+            proto,
+        })
+    }
+}
+
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper around `bindings::serio_device_id`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::serio_device_id;
+}
+
+/// Type alias for serio device ID tables.
+pub type IdTable = &'static dyn GenericIdTable<DeviceId, ()>;
+
+/// Creates a serio device table with a zero sentinel for module autoloading and matching.
+#[macro_export]
+macro_rules! serio_device_table {
+    ($table_name:ident, [$($id:expr),* $(,)?]) => {
+        $crate::module_device_table!(
+            "serio",
+            $crate::serio::DeviceId,
+            $table_name,
+            @none,
+            [$($id),*]
+        );
+    };
+}
+
+/// A serio port device instance passed to driver callbacks.
+pub struct Device {
+    ptr: NonNull<bindings::serio>,
+}
+
+impl Device {
+    /// Returns the raw pointer to the underlying `struct serio`.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::serio {
+        self.ptr.as_ptr()
+    }
+
+    /// Reads the physical device path into a buffer.
+    #[inline]
+    pub fn phys(&self) -> &[u8; 32] {
+        // SAFETY: `self.ptr` points to a valid `struct serio`.
+        unsafe { &(*self.ptr.as_ptr()).phys }
+    }
+}
+
+impl AsRef<device::Device> for Device {
+    #[inline]
+    fn as_ref(&self) -> &device::Device {
+        // SAFETY: `self.ptr` points to a valid `struct serio`, which embeds `struct device dev`.
+        unsafe {
+            let dev = core::ptr::addr_of_mut!((*self.ptr.as_ptr()).dev);
+            device::Device::from_raw(dev)
+        }
+    }
+}
+
+impl Deref for Device {
+    type Target = device::Device;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.as_ref()
+    }
+}
+
+/// Trait implemented by serio device drivers.
+pub trait Driver: Send + Sync + Sized {
+    /// Context data stored per connected device instance.
+    type Data: ForeignOwnable + Send + Sync;
+
+    /// Device ID match table.
+    const ID_TABLE: IdTable;
+
+    /// Called when a matching serio port is detected.
+    fn connect(dev: &mut Device) -> Result<Self::Data>;
+
+    /// Called in interrupt context when a new byte arrives from the serio port.
+    fn interrupt(
+        data: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        byte: u8,
+        flags: u32,
+    ) -> IrqReturn;
+
+    /// Called when the device is disconnected.
+    fn disconnect(_data: Self::Data) {}
+}
+
+/// Driver adapter that bridges the safe Rust [`Driver`] trait to the C serio bus subsystem.
+pub struct Registration<T: Driver> {
+    drv: Pin<KBox<Opaque<bindings::serio_driver>>>,
+    _p: PhantomData<T>,
+}
+
+impl<T: Driver> Registration<T> {
+    /// Registers a serio driver with the kernel.
+    pub fn new(name: &'static CStr, module: &'static ThisModule) -> Result<Self> {
+        let drv = bindings::serio_driver {
+            description: name.as_char_ptr(),
+            id_table: T::ID_TABLE.as_ptr(),
+            manual_bind: false,
+            write_wakeup: None,
+            interrupt: Some(Self::interrupt_callback),
+            connect: Some(Self::connect_callback),
+            reconnect: None,
+            fast_reconnect: None,
+            disconnect: Some(Self::disconnect_callback),
+            cleanup: None,
+            driver: bindings::device_driver {
+                name: name.as_char_ptr(),
+                ..Default::default()
+            },
+        };
+
+        let drv_box = KBox::into_pin(KBox::new(Opaque::new(drv), GFP_KERNEL)?);
+
+        // SAFETY: `drv_box` is pinned on the kernel heap at a permanent address.
+        // `module` and `name` are valid static references.
+        let ret = unsafe {
+            bindings::__serio_register_driver(drv_box.get(), module.as_ptr(), name.as_char_ptr())
+        };
+        to_result(ret)?;
+
+        Ok(Self {
+            drv: drv_box,
+            _p: PhantomData,
+        })
+    }
+
+    /// # Safety
+    ///
+    /// Must only be invoked by the serio subsystem when a matching port is probed.
+    /// `serio` and `drv` must be valid non-null pointers provided by the kernel.
+    unsafe extern "C" fn connect_callback(
+        serio: *mut bindings::serio,
+        drv: *mut bindings::serio_driver,
+    ) -> c_int {
+        let Some(serio_nn) = NonNull::new(serio) else {
+            return crate::error::code::EINVAL.to_errno();
+        };
+
+        // SAFETY: `serio` and `drv` are valid non-null pointers provided by the kernel.
+        let ret = unsafe { bindings::serio_open(serio, drv) };
+        if ret != 0 {
+            return ret;
+        }
+
+        let mut dev = Device { ptr: serio_nn };
+
+        let data = match T::connect(&mut dev) {
+            Ok(d) => d,
+            Err(e) => {
+                // SAFETY: Close the opened port on probe error.
+                unsafe { bindings::serio_close(serio) };
+                return e.to_errno();
+            }
+        };
+
+        let raw_data = data.into_foreign();
+        // SAFETY: `serio` is valid; store driver data pointer.
+        unsafe {
+            bindings::serio_set_drvdata(serio, raw_data.cast());
+        }
+
+        0
+    }
+
+    /// # Safety
+    ///
+    /// Must only be invoked by the serio subsystem during an interrupt on a connected port.
+    /// `serio` must be a valid pointer.
+    unsafe extern "C" fn interrupt_callback(
+        serio: *mut bindings::serio,
+        data: c_uchar,
+        flags: c_uint,
+    ) -> bindings::irqreturn_t {
+        // SAFETY: `serio` is valid.
+        let raw = unsafe { bindings::serio_get_drvdata(serio) };
+        if raw.is_null() {
+            return bindings::irqreturn::IRQ_NONE;
+        }
+
+        // SAFETY: `raw` was created via `into_foreign()` in `connect_callback`.
+        let mut borrowed = unsafe { <T::Data as ForeignOwnable>::borrow_mut(raw) };
+        let ret = T::interrupt(&mut borrowed, data, flags);
+        bindings::irqreturn_t(ret as c_uint)
+    }
+
+    /// # Safety
+    ///
+    /// Must only be invoked by the serio subsystem when disconnecting a port.
+    /// `serio` must be a valid pointer.
+    unsafe extern "C" fn disconnect_callback(serio: *mut bindings::serio) {
+        // SAFETY: `serio` is valid.
+        let raw = unsafe { bindings::serio_get_drvdata(serio) };
+        if raw.is_null() {
+            return;
+        }
+
+        // SAFETY: Close port, clear drvdata, and pass owned data back to disconnect.
+        unsafe {
+            bindings::serio_close(serio);
+            bindings::serio_set_drvdata(serio, core::ptr::null_mut());
+            let data = <T::Data as ForeignOwnable>::from_foreign(raw);
+            T::disconnect(data);
+        }
+    }
+}
+
+impl<T: Driver> Drop for Registration<T> {
+    fn drop(&mut self) {
+        // SAFETY: Unregister driver with kernel. `self.drv` is valid and registered.
+        unsafe {
+            bindings::serio_unregister_driver(self.drv.get());
+        }
+    }
+}
+
+// SAFETY: `Registration` can be safely sent to another thread.
+unsafe impl<T: Driver> Send for Registration<T> {}
+// SAFETY: `Registration` can be safely shared across threads.
+unsafe impl<T: Driver> Sync for Registration<T> {}
-- 
2.56.0

