Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004266;
	b=G/egYLWb874K+K7DkoD/N+EYHPgK9y+eajjQKjERLe35lB2t+w4c44DUi5mLZOfchneH
	 FncxeI30azRxLoXvQy8raNwZDGR4ob6SHvM4FYrtB79VBvA7LqG/iDd5nVU14JWVVkABe
	 CPc3/QArApOeMbOvPKSywlQDQernFxMSkrwx4bzMwQY3DOHgqUEStkyHZhyZWdDKhHVP5
	 5CjeP+2WJmWeblxwOtkuTIH+/g1K/EBYc346oMxcJdGUwXoUpc5Rn9F/Z2H6PTBcSDPyV
	 hkGnD0O0rwy8ekQKIRUOl4UGyXkBAwXZuyJvzuwkHpBL57/sM8ljMTe35aYL5P4Lh1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=96n/UpT9P6ccP/2QVOMqllAsU3WstwUK5mdA4WhPycM=;
	b=Qi5NBlr1BzRt9/acTgvG2CpnAn9J/RRiuf3oNIcKRkGBT/drHiuPBy8ANryZwSB/W+Xp
	 P6WQeVZfKKXvqICwD/+PGYwAHJru5oIs05lcEG0IQa3mavruuWGQ3KVYpN3ynDEo8M7ca
	 2vFbfw51gnP7bqBDULE4SkJ2X8qg4BT5SFgiKN8+8Goh43qk1FVtVATA7egktwVxGP6uS
	 ljsl+KnFfzu40bBlH5y0CN+ONfpkmZKHHqQGoiDqtPHcO2SLcFzfIhtSguMY8Zzn/5S3r
	 1j3R188G4s3gSdgfxcTNYdG2yF5ngtp7FqD1M3LOc+MQmoqJ/DjZ/xqL5DRDESWsTQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t4a0niIz;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E877606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 22:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E877606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t4a0niIz
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so11667595e9.2
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 14:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794004264; x=1794609064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96n/UpT9P6ccP/2QVOMqllAsU3WstwUK5mdA4WhPycM=;
        b=t4a0niIzU7D0sKg5NAFsO0uPOqEpmZJuLlyJmCMTGMZPLwcNyVnvS8IR7bkkjZ6s3X
         HBF2nnJfnCNuvmUILjggUz40KVjWk8Q01GsL/0RedR748UqSkuPXAcTn9+cjk2/tb+GD
         m9R/iolTt+Zob//DQUk3G81Oow9cOC5kpvM28TlTl/TKkNysAZfMEz3i2Xy/BnpDW/e+
         m+LakC5/4CO+fOdWlLZpPEv3TWNFOY/s00TQMvMxNdPzLJui3DYNpt53ZTwcC7irzwf1
         wFdQH2pfwbyvvusxZPAUIST+UrpBKD669lMPTiBqr067BtxYOh+Aj//vY7yVNgmCwA7E
         hcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004264; x=1794609064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=96n/UpT9P6ccP/2QVOMqllAsU3WstwUK5mdA4WhPycM=;
        b=CGEnVHQQqOW8dHleHY7mu7PIcdm2SOJSASuheYSIsG7caNgQ/WDciX43M74kAyNjHs
         CjNMuXxzLph9RSqMc89OvnhG9mJsJFnjVMDsOSdJpoGBfqmoVKIGZ7PrU2ERNo4Qkggo
         Q/5j6XkNIDJxvX0wj+b9jQTJn+QZicsdnPy6gT79d/IU6AO/u9p1Dageu9Hxy+jtbklf
         XA4awuZZnV8XkoWyDQdFIgZYpuIvPKpua6LNKf7vNWN1ndoKbAYng1zFaYXQ8tnCZ8JJ
         ssnkxXOMYu0ceOvCBHNVdu1zHTMZ859McQD+ulBn//okYnpJZpTquErxYjpe/TXkuAMQ
         SSwg==
X-Forwarded-Encrypted: i=1; AL+hErHcKZ+p4z2pK+QsePM8Jk6h1QfvtjSHdD8DJCrPTOOSiWC0QkWnPzRNG+Ty5/3Md9FrklptsSLfzC1czg==@vger.kernel.org
X-Gm-Message-State: APuU4Z973JCMNdBgIDqC3nqE7U0BvPn0+pfQRs6NoDWm9/OwTagjifxV
	+685YYRLf5txLrUOM3yG6YY3D7HzCie5ZT0n9gob+VVwJjJCcGC3ecz9
X-Gm-Gg: AYBFou3znYvFiS9lZkBWNGB56pPn4QIrO/IcWXABeSc+cgCUoDA336t4aNEzDE8U11A
	poepnA/J1qiwxoXy2sE8OX/LtAemQbHIRxmfrcpFQNCwIeBVoQVBQf28gK2GBlhasyf8kGgCQSE
	Z8Ue9NepalrLx6zk0b8tvfGm8nFSzKp+jEdottVIQu6SliSLQ8/JgFlKZxCPZd22ylBofPjHYZG
	QoPNkZWketw2gu5IFRMg6joTWCvpEJxJMncYOFYIyHWtYmDAjsGn5aTotJq+YZ0XP3ZYGnQcTjZ
	ZVFih5HkjQ3gjYJAzoLVt4DinHZhxAUJv5pYR4kyPx2I/Lv39hZo3XNK5TLm+4vD0GpvfCZ34rj
	lSG6gArqO26jP181rX2m9sNOPWiE+3wpdhaFiuVQSwK2eEeZv8ghunGmntAefnyh75qsKGtAyBJ
	cmRG5JYe2whI3YEdIW6Cfzk9ykIeTsSxk5YLPCyd9WkJgsPbTvfQCAvPBiXTnhW0+r93toXDLEC
	in8Cp1R9ajH4S+/hkgZkkblHn5yAfE6nIAHOg2w1yfB6S5meG2YMDuYGdtuP1BWxIScKhwJ/wJj
	jrJ+Pc8cpWqpY5gdppgPZBuaB61rj3sVND5sjAAURJG34mxnUO0abForVjPjEd+k9MIvPoqa95f
	lvhtLN69fJesyd6YxaBkUS8aSs56lxdxOL2RMunTN4VtBatzp
X-Received: by 2002:a05:6000:22c1:b0:48d:f02e:f7cc with SMTP id ffacd0b85a97d-4927678cc3bmr8621565f8f.24.1794004263518;
        Fri, 06 Nov 2026 14:31:03 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d8472969sm6262367f8f.58.2026.11.06.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:31:02 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v5 2/2] rust: serio: add serio bus abstractions and port Gravis Stinger driver
Date: Sat,  7 Nov 2026 03:30:33 +0500
Message-ID: <20261106223033.452853-3-harepro29@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106223033.452853-1-harepro29@gmail.com>
References: <20261106223033.452853-1-harepro29@gmail.com>
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
- DeviceId: a transparent wrapper around struct serio_device_id
  implementing RawDeviceId for type-safe matching tables.
- IdTable and serio_device_table! macro: guarantees a zero sentinel
  termination entry at compile time and creates modpost device aliases.
- Device: a serio port device instance implementing AsBusDevice,
  impl_device_context_deref!, and AsRef<device::Device>.
- Port lifecycle & interrupt race protection: T::init initializes
  driver state and allocates input devices, storing drvdata BEFORE
  serio_open() opens the hardware port. T::start publishes child
  devices only after serio_open() succeeds, and T::attach safely
  binds them under serio_pause_rx to eliminate races with interrupts.
- IrqReturn mapping: properly converts kernel::irq::IrqReturn
  variants to C irqreturn struct values without UB.
- Driver trait: safe interface for serio drivers (init, start,
  attach, interrupt, disconnect).
- Registration<T>: safe RAII registration adapter that stores
  Opaque<bindings::serio_driver> inside Pin<KBox<...>> and calls
  __serio_register_driver with the caller's &'static ThisModule
  to correctly track module ownership.
- stinger_rust: port of the Gravis Stinger serial gamepad driver in
  safe Rust (drivers/input/joystick/stinger_rust.rs), containing zero
  unsafe blocks, preserving the userspace device name ("Gravis Stinger")
  for udev/EVIOCGNAME, dynamically formatting phys paths ("%s/input0"),
  and compiling as the standard stinger.ko module name.
- Non-regression Kconfig: adds CONFIG_JOYSTICK_STINGER_RUST guarded on
  RUST && SERIO=y && INPUT=y while retaining the original C driver
  (stinger.c) to maintain hardware support on non-Rust configurations
  and architectures without HAVE_RUST.
- Gated module entry #[cfg(CONFIG_SERIO = "y")] and helper guards
  #if IS_REACHABLE(CONFIG_SERIO) to avoid undefined symbols when serio
  is disabled or modular.

Signed-off-by: clicedvly768 <harepro29@gmail.com>
---
 drivers/input/joystick/Kconfig         |  14 ++
 drivers/input/joystick/Makefile        |   3 +
 drivers/input/joystick/stinger_rust.rs | 191 +++++++++++++++
 rust/bindings/bindings_helper.h        |   1 +
 rust/helpers/helpers.c                 |   1 +
 rust/helpers/serio.c                   |  27 ++
 rust/kernel/lib.rs                     |   2 +
 rust/kernel/serio.rs                   | 327 +++++++++++++++++++++++++
 8 files changed, 566 insertions(+)
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
index 9976f596a920..2ba3391af7c9 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -33,6 +33,9 @@ obj-$(CONFIG_JOYSTICK_SENSEHAT)	+= sensehat-joystick.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
 obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
+ifdef CONFIG_JOYSTICK_STINGER_RUST
+stinger-objs				:= stinger_rust.o
+endif
 obj-$(CONFIG_JOYSTICK_STINGER)		+= stinger.o
 obj-$(CONFIG_JOYSTICK_TMDC)		+= tmdc.o
 obj-$(CONFIG_JOYSTICK_TURBOGRAFX)	+= turbografx.o
diff --git a/drivers/input/joystick/stinger_rust.rs b/drivers/input/joystick/stinger_rust.rs
new file mode 100644
index 000000000000..af78524fadcf
--- /dev/null
+++ b/drivers/input/joystick/stinger_rust.rs
@@ -0,0 +1,191 @@
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
+    bindings, //
+    device,   //
+    input::{
+        bus,              //
+        event_type,       //
+        AllocatedDevice,  //
+        RegisteredDevice, //
+    }, //
+    prelude::*, //
+    serio::{
+        self,      //
+        IrqReturn, //
+    }, //
+    types::ForeignOwnable, //
+};
+
+const DRIVER_NAME: &CStr = c"stinger";
+const DRIVER_DESC: &CStr = c"Gravis Stinger";
+const DRIVER_SERIO_DESC: &CStr = c"Gravis Stinger gamepad driver";
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
+    input: Option<RegisteredDevice>,
+    idx: usize,
+    data: [u8; STINGER_MAX_LENGTH],
+}
+
+impl Stinger {
+    /// Decodes incoming 4-byte packets from the Gravis Stinger and reports input events.
+    fn process_packet(&self) {
+        let Some(input) = self.input.as_ref() else {
+            return;
+        };
+
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
+        input.report_key(bindings::BTN_A, ((d0 & 0x20) >> 5) != 0);
+        input.report_key(bindings::BTN_B, ((d0 & 0x10) >> 4) != 0);
+        input.report_key(bindings::BTN_C, ((d0 & 0x08) >> 3) != 0);
+        input.report_key(bindings::BTN_X, ((d0 & 0x04) >> 2) != 0);
+        input.report_key(bindings::BTN_Y, ((d3 & 0x20) >> 5) != 0);
+        input.report_key(bindings::BTN_Z, ((d3 & 0x10) >> 4) != 0);
+        input.report_key(bindings::BTN_TL, ((d3 & 0x08) >> 3) != 0);
+        input.report_key(bindings::BTN_TR, ((d3 & 0x04) >> 2) != 0);
+        input.report_key(bindings::BTN_SELECT, ((d3 & 0x02) >> 1) != 0);
+        input.report_key(bindings::BTN_START, (d3 & 0x01) != 0);
+
+        // Report 2-axis position: coordinates in range -64..64
+        input.report_abs(bindings::ABS_X, (d1 & 0x3f) - ((d0 & 0x01) << 6));
+        input.report_abs(bindings::ABS_Y, ((d0 & 0x02) << 5) - (d2 & 0x3f));
+
+        input.sync();
+    }
+}
+
+/// Serio driver implementation for Gravis Stinger gamepad.
+struct StingerDriver;
+
+impl serio::Driver for StingerDriver {
+    type Data = KBox<Stinger>;
+    type Pending = AllocatedDevice;
+    type Published = RegisteredDevice;
+
+    const ID_TABLE: serio::IdTable = &STINGER_IDS;
+
+    fn init(dev: &serio::Device<device::Bound>) -> Result<(Self::Data, Self::Pending)> {
+        let mut input_alloc = AllocatedDevice::new()?;
+
+        input_alloc.set_name(DRIVER_DESC);
+        input_alloc.set_id(bus::RS232, bindings::SERIO_STINGER as u16, 0x0001, 0x0100);
+        input_alloc.set_parent(dev.as_ref());
+        input_alloc.set_phys_from_parent(dev.phys())?;
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
+        // Configure 2-axis analog input
+        input_alloc.set_abs_params(bindings::ABS_X, -64, 64, 0, 4)?;
+        input_alloc.set_abs_params(bindings::ABS_Y, -64, 64, 0, 4)?;
+
+        let stinger = KBox::new(
+            Stinger {
+                input: None,
+                idx: 0,
+                data: [0; STINGER_MAX_LENGTH],
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok((stinger, input_alloc))
+    }
+
+    fn start(pending: Self::Pending) -> Result<Self::Published> {
+        pending.register()
+    }
+
+    fn attach(
+        stinger: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        published: Self::Published,
+    ) {
+        stinger.input = Some(published);
+    }
+
+    fn interrupt(
+        stinger: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        data: u8,
+        _flags: u32,
+    ) -> IrqReturn {
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
+        IrqReturn::Handled
+    }
+
+    #[inline]
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
+    fn init(module: &'static ThisModule) -> Result<Self> {
+        let reg =
+            serio::Registration::<StingerDriver>::new(DRIVER_NAME, DRIVER_SERIO_DESC, module)?;
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
index 000000000000..f88b6c2a900b
--- /dev/null
+++ b/rust/helpers/serio.c
@@ -0,0 +1,27 @@
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
+__rust_helper void rust_helper_serio_pause_rx(struct serio *serio)
+{
+	serio_pause_rx(serio);
+}
+
+__rust_helper void rust_helper_serio_continue_rx(struct serio *serio)
+{
+	serio_continue_rx(serio);
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
index 000000000000..aca0b5a4f874
--- /dev/null
+++ b/rust/kernel/serio.rs
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Serio (Serial I/O) bus abstractions for safe Rust drivers.
+//!
+//! Provides a safe Rust interface for serio devices and drivers in the Linux kernel,
+//! supporting input devices such as serial gamepads (e.g. Gravis Stinger), mice, and keyboards.
+
+use crate::{
+    bindings, //
+    device,   //
+    device_id::{
+        IdTable as GenericIdTable, //
+        RawDeviceId,               //
+    }, //
+    error::{
+        to_result, //
+        Result,    //
+    }, //
+    ffi::{
+        c_int,   //
+        c_uchar, //
+        c_uint,  //
+    }, //
+    prelude::*, //
+    types::{
+        ForeignOwnable, //
+        Opaque,         //
+    }, //
+    ThisModule, //
+};
+use core::{
+    marker::PhantomData, //
+    pin::Pin,            //
+};
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
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::serio>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: device::DeviceContext> Device<Ctx> {
+    /// Returns the raw pointer to the underlying `struct serio`.
+    #[inline]
+    pub(crate) fn as_raw(&self) -> *mut bindings::serio {
+        self.0.get()
+    }
+
+    /// Reads the physical device path into a buffer.
+    #[inline]
+    pub fn phys(&self) -> &[u8; 32] {
+        // SAFETY: `self.as_raw()` points to a valid `struct serio`.
+        unsafe { &(*self.as_raw()).phys }
+    }
+}
+
+// SAFETY: `serio::Device` is a transparent wrapper of `struct serio`.
+// The offset is guaranteed to point to a valid device field inside `serio::Device`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = core::mem::offset_of!(bindings::serio, dev);
+}
+
+kernel::impl_device_context_deref!(unsafe { Device });
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    #[inline]
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct serio`.
+        let dev = unsafe { core::ptr::addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+/// Trait implemented by serio device drivers.
+pub trait Driver: Send + Sync + Sized {
+    /// Context data stored per connected device instance.
+    type Data: ForeignOwnable + Send + Sync;
+
+    /// Pending resources allocated during probe to be published after the port opens.
+    type Pending;
+
+    /// Published device handle created after the port opens.
+    type Published;
+
+    /// Device ID match table.
+    const ID_TABLE: IdTable;
+
+    /// Initializes driver data before the port is opened.
+    fn init(dev: &Device<device::Bound>) -> Result<(Self::Data, Self::Pending)>;
+
+    /// Registers/publishes child devices in process context after `serio_open` succeeds.
+    fn start(pending: Self::Pending) -> Result<Self::Published>;
+
+    /// Attaches the published child device under `serio_pause_rx` to eliminate races.
+    fn attach(
+        data: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        published: Self::Published,
+    );
+
+    /// Called in interrupt context when a new byte arrives from the serio port.
+    fn interrupt(
+        data: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        byte: u8,
+        flags: u32,
+    ) -> IrqReturn;
+
+    /// Called when the device is disconnected.
+    #[inline]
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
+    pub fn new(
+        name: &'static CStr,
+        description: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result<Self> {
+        let drv = bindings::serio_driver {
+            description: description.as_char_ptr(),
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
+        if serio.is_null() {
+            return crate::error::code::EINVAL.to_errno();
+        }
+
+        // SAFETY: `serio` is valid. `Device<Bound>` is repr(transparent).
+        let dev = unsafe { &*(serio.cast::<Device<device::Bound>>()) };
+
+        // 1. Initialize driver data before port is opened.
+        let (data, pending) = match T::init(dev) {
+            Ok(d) => d,
+            Err(e) => return e.to_errno(),
+        };
+
+        let raw_data = data.into_foreign();
+
+        // 2. Set drvdata BEFORE opening port so interrupts never encounter NULL.
+        // SAFETY: `serio` is valid; store driver data pointer.
+        unsafe {
+            bindings::serio_set_drvdata(serio, raw_data.cast());
+        }
+
+        // 3. Open serio port.
+        // SAFETY: `serio` and `drv` are valid non-null pointers provided by the kernel.
+        let ret = unsafe { bindings::serio_open(serio, drv) };
+        if ret != 0 {
+            // SAFETY: Clean up drvdata if open failed.
+            unsafe {
+                bindings::serio_set_drvdata(serio, core::ptr::null_mut());
+                let data = <T::Data as ForeignOwnable>::from_foreign(raw_data);
+                T::disconnect(data);
+            }
+            return ret;
+        }
+
+        // 4. Publish child devices in process context now that port is successfully opened.
+        let published = match T::start(pending) {
+            Ok(p) => p,
+            Err(e) => {
+                // SAFETY: Close port and clean up if device publication failed.
+                unsafe {
+                    bindings::serio_close(serio);
+                    bindings::serio_set_drvdata(serio, core::ptr::null_mut());
+                    let data = <T::Data as ForeignOwnable>::from_foreign(raw_data);
+                    T::disconnect(data);
+                }
+                return e.to_errno();
+            }
+        };
+
+        // 5. Attach published resources under `serio_pause_rx` to eliminate races with interrupts.
+        // SAFETY: `serio_pause_rx` holds `serio->lock`, preventing concurrent interrupt execution.
+        unsafe {
+            bindings::serio_pause_rx(serio);
+            let mut borrowed = <T::Data as ForeignOwnable>::borrow_mut(raw_data);
+            T::attach(&mut borrowed, published);
+            bindings::serio_continue_rx(serio);
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
+            return bindings::irqreturn(IrqReturn::None as u32);
+        }
+
+        // SAFETY: `raw` was created via `into_foreign()` in `connect_callback`.
+        let mut borrowed = unsafe { <T::Data as ForeignOwnable>::borrow_mut(raw) };
+        let ret = T::interrupt(&mut borrowed, data, flags);
+        bindings::irqreturn(ret as u32)
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
+    #[inline]
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

