Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996187;
	b=GnduiuP2RMQHDXedsvXDrOiiC+F3huwufK1rgORoH52+RC6gExhOZ+M5aUdMvBtusRM8
	 kiEt/dMgx0Tly6SC0Cs9Tm7Gcr/PUI9JR4NvBD/i9DDr+YGaS8PKM+3FE3meFiziGVY73
	 L8bKTE9HZTA1gXi6xPnuIPs72/213gxKDxyiRP5BqwyfjGsoc1U4tDfPkkyttRW97zAlO
	 T8L5LzRRS7Yj9RM1H5InEmj0PlEuHsHLqSgl6yLc0o5CZUzbUQg5tMNhzc9ILArdapHeZ
	 jxT4hD4wgPreuBh88VApcVMQhgV/TqGL03NjtOgV1541LTx6aRhYbccLPaKn/tYS7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u96v/l1+xXJ2MV/8Ktn1lnD96esk0JZnnP96V1E2tac=;
	b=MJeQTAYBOAxH5h+Es4slnhhZcw4MeA3gNzpnPqHMCE8/DWJ6heRdFFI0hTdjM6S9j0+O
	 uhxT88jz7LYuaUFknDtT6jU35VC129SEKXpXPD14dpTf/B7fpJA7gFna3EsHaywOjWtMJ
	 RG2diKSxVIjar7dedJSyH4LsHtNeQaM7+JWJUTLPuS4cRkwG3smFwnlWmrTSbtjl8ecF0
	 zrY58XzBF7qlKbjO1hYzJ1Gi/qaFgUVKpAojrpcd0VkskzTn06NgqsfBvwOk+Yv0uL7Tz
	 4sLlfvQNUtHNfndAI0wYCFZnZ0Oxb0w1fvtwmpUNl1YwxFO8Cdk86PiXdIP085mACtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gb2BWq23;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B7606A337
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 20:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 461B7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gb2BWq23
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10632825e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 12:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996186; x=1794600986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u96v/l1+xXJ2MV/8Ktn1lnD96esk0JZnnP96V1E2tac=;
        b=gb2BWq23VTGwtOkewQgTIO8/qAv5pyYkWXkyhtMjA950ErrbCN3lwb8cIxCTEp/lkt
         j2HlSowOWP5TP0twDa5Y8P0ZtR2drK2hOs36NzmS4YeE1N/xNGa7S7TTBYY9ytLTk7gD
         tYtcCrQHQ1cRLRXliXYvGJrqE+CuaqrJ9gcFZQS3bYFOi/sIr6tpNCoqOxvnjqWKFS/7
         k1I/kA2mLVun+dzUFLVp5tKajCVgr1nQKIutfcEGJafj73oj6nnVw0EE5ymDHf2zXrNK
         V2yBx3tXJdfFk+5yI3/qOYYLyIldXM81qJjm4vt3dyInKatNT2WyoB35DYvXOaUWjdlo
         rI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996186; x=1794600986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u96v/l1+xXJ2MV/8Ktn1lnD96esk0JZnnP96V1E2tac=;
        b=jyn6kH8nhYtu+9rBR00R/t2MkA5FiEd9WsTkMB7J8HDo2OeN8igVT4lM7nAkTWmIwU
         c5pPGiKxo8HeFHWYcJwBo6jRPSihiGnwHF/6UQuVraM/3HDTHv+BDsEpSBRbm/G5LKPk
         Uni3qJ8dSZ2nFeY1p9cNWYSd40xu/g3aN4Z+TIUIDKHmjF0U+tuAZ92QaI/YTaCNMl0E
         qgnEsx5U8NaE8mgKbvuAwrxkWsSIN/3/XKofS0+SzjwXW9k3dDvxD6C/VktfwIpHw2Q+
         9IXUPae+k8p6U46AkqV0zXT6CUg/ZJtzBoY3IrLRR8JiPlZH6ZA8xvB7gw8/UMAh4NYq
         Cf3w==
X-Forwarded-Encrypted: i=1; AKwUvBzgI2Qe69MozbOVuDlWNa2z9ejxy4I+AQVgYOj+iBjvwSX8G8IseWsXFc7tZUd57m2drPhFASW+4p7RPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+yVh++C435+5/DRmWIQPlXwnkqKNFJ5+HfgGHoSRCXU7hFoxDe
	H5WA2LdPhLHpEHjlHgJ843m6gmhPkBI3+Kh2tgJS01mQhK9lJvzTO5K5UU2AgN/epcJhODwA
X-Gm-Gg: AYBFou2WtoXtXZgkHGJ0cYFfNb953rDCxw5zPgc66NkKAnyqcPTZB7yei54nQsw98Y/
	yeGPtFC10URSgVUfDbHnoXwh9zx7m60k4KeGLEmJ2SZ5LXVWAAkEufhvdHOHDQoHvCXFiSu2GtX
	mxAd/zfHhmSvKBIUMAQuCPTUkkBJUwjdxI9gc0/37eFIu6PWkVxFRtcoo4Ah2BV3R9nET6bQoH6
	s9+U5Z2q/BtqXZoU5lnAkgaOzC35a9Ad5KYq2hw7+NTMlcADWgAj7orcA5r3XaL9DU0RmSbOol5
	2yiRq0QlQdqJzQli9IvknfBwzn/JZWgxkKm72y+JONVAQBQ8rUQv99vk7gIFnIyd7HYKaLAWiFc
	qsPdV2bcwi/lCAukamG0x9Sa2ZjZBfpNg9xUcnaN7Lx4Yj2IIIHKdA00IURJv2ofAvK6SWjqFsw
	coIoZ5vzSwxEG68BNgSSo+FfCwEOAW+I56h8grDy40cE9aVRhRnJr9Iuh6r6DKXNOPKWpNGMtgi
	PkE+Kj47N0qMerKmRwGcgCF49j/SoMNXSMpuSbAGhzNrd8bKj0sxJ2ZM+z+ou26PBfHhWFEKzU5
	HMp3QZr8XFiSFoOfXHM3RRcdKlBxtJJn3fjW5n210Akz4KBoXrCFW2aOufjkl8yAyDAjtwLvDIi
	k1GybeN58Z8JUw4+rwlSWDEkSfKVTapwtESRw7dI9la/XgsRP
X-Received: by 2002:a05:600c:1d0b:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4b6e0170a5cmr62501085e9.27.1793996185393;
        Fri, 06 Nov 2026 12:16:25 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d609a3sm5849954f8f.7.2026.11.06.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:16:25 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v2 1/2] rust: input: add input device abstractions
Date: Sat,  7 Nov 2026 01:14:28 +0500
Message-ID: <20261106201429.376997-2-harepro29@gmail.com>
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

Add safe Rust abstractions for Linux input devices (struct input_dev).

This provides:
- `AllocatedDevice`: a newly allocated, unregistered input device handle
  that allows configuring capabilities (keys, absolute axes limits, parent
  device) before registration.
- Safe string methods: `set_name` and `set_phys` accept `&'static CStr`
  to prevent use-after-free since the input core does not copy strings.
- Bounds-checked `set_abs_params` validating `axis < ABS_CNT` (0x40)
  to prevent memory corruption in `dev->absinfo`.
- `RegisteredDevice`: a registered input device handle providing safe,
  inlined methods to report keys, absolute coordinates, and synchronization
  events. Automatically calls `input_unregister_device` on drop (RAII).
- Constants for bus types (`bus::*`) and event types (`event_type::*`).
- Alphabetically sorted imports and module entries gated with
  `#[cfg(CONFIG_INPUT = "y")]` and `#if IS_REACHABLE(CONFIG_INPUT)`
  to avoid link failures when CONFIG_INPUT is disabled or modular.

Signed-off-by: clicedvly768 <harepro29@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/input.c            |  22 ++++
 rust/kernel/input.rs            | 214 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 5 files changed, 240 insertions(+)
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/kernel/input.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..4b09d3980e10 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -64,6 +64,7 @@
 #include <linux/fwctl.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7b..77cec85ad153 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -67,6 +67,7 @@
 #include "fs.c"
 #include "fwctl.c"
 #include "gpu.c"
+#include "input.c"
 #include "interrupt.c"
 #include "io.c"
 #include "irq.c"
diff --git a/rust/helpers/input.c b/rust/helpers/input.c
new file mode 100644
index 000000000000..f43a06acfdc3
--- /dev/null
+++ b/rust/helpers/input.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/input.h>
+
+#if IS_REACHABLE(CONFIG_INPUT)
+
+__rust_helper void rust_helper_input_report_key(struct input_dev *dev, unsigned int code, int value)
+{
+	input_report_key(dev, code, value);
+}
+
+__rust_helper void rust_helper_input_report_abs(struct input_dev *dev, unsigned int code, int value)
+{
+	input_report_abs(dev, code, value);
+}
+
+__rust_helper void rust_helper_input_sync(struct input_dev *dev)
+{
+	input_sync(dev);
+}
+
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
diff --git a/rust/kernel/input.rs b/rust/kernel/input.rs
new file mode 100644
index 000000000000..bef0c3a07da0
--- /dev/null
+++ b/rust/kernel/input.rs
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Input subsystem abstractions for safe Rust drivers.
+//!
+//! Provides a safe Rust object-oriented interface around Linux `struct input_dev`,
+//! ensuring safe allocation, capability configuration, registration, and RAII cleanup.
+
+use crate::{
+    bindings, device,
+    error::{
+        code::{EINVAL, ENOMEM},
+        Result,
+    },
+    prelude::*,
+    str::CStr,
+};
+use core::ptr::NonNull;
+
+/// Bus types for input devices.
+pub mod bus {
+    use super::*;
+
+    /// PCI bus.
+    pub const PCI: u16 = bindings::BUS_PCI as u16;
+    /// USB bus.
+    pub const USB: u16 = bindings::BUS_USB as u16;
+    /// RS232 serial bus.
+    pub const RS232: u16 = bindings::BUS_RS232 as u16;
+}
+
+/// Event types reported by input devices.
+pub mod event_type {
+    use super::*;
+
+    /// Key or button press/release events.
+    pub const KEY: u32 = bindings::EV_KEY;
+    /// Absolute axis movement events.
+    pub const ABS: u32 = bindings::EV_ABS;
+}
+
+/// An allocated input device being configured prior to registration.
+pub struct AllocatedDevice {
+    ptr: NonNull<bindings::input_dev>,
+}
+
+impl AllocatedDevice {
+    /// Allocates a new input device.
+    pub fn new() -> Result<Self> {
+        // SAFETY: `input_allocate_device` returns either a valid pointer or NULL.
+        let ptr = unsafe { bindings::input_allocate_device() };
+        let ptr = NonNull::new(ptr).ok_or(ENOMEM)?;
+
+        Ok(Self { ptr })
+    }
+
+    /// Sets the human-readable device name.
+    #[inline]
+    pub fn set_name(&mut self, name: &'static CStr) {
+        // SAFETY: `self.ptr` is valid and `name` has static lifetime.
+        unsafe {
+            (*self.ptr.as_ptr()).name = name.as_char_ptr().cast();
+        }
+    }
+
+    /// Sets the physical location string.
+    ///
+    /// The input core does not copy the string and requires it to remain valid
+    /// throughout the device's lifetime, so a static NUL-terminated C string is required.
+    #[inline]
+    pub fn set_phys(&mut self, phys: &'static CStr) {
+        // SAFETY: `self.ptr` is valid and `phys` has static lifetime.
+        unsafe {
+            (*self.ptr.as_ptr()).phys = phys.as_char_ptr().cast();
+        }
+    }
+
+    /// Sets device identifier (bus type, vendor, product, version).
+    #[inline]
+    pub fn set_id(&mut self, bustype: u16, vendor: u16, product: u16, version: u16) {
+        // SAFETY: `self.ptr` is valid.
+        unsafe {
+            let dev = self.ptr.as_ptr();
+            (*dev).id.bustype = bustype;
+            (*dev).id.vendor = vendor;
+            (*dev).id.product = product;
+            (*dev).id.version = version;
+        }
+    }
+
+    /// Sets the parent device for this input device.
+    #[inline]
+    pub fn set_parent(&mut self, parent: &device::Device) {
+        // SAFETY: `self.ptr` is valid, and `parent.as_raw()` returns a valid `struct device`.
+        unsafe {
+            (*self.ptr.as_ptr()).dev.parent = parent.as_raw();
+        }
+    }
+
+    /// Enables support for a capability (e.g. key or axis).
+    #[inline]
+    pub fn set_capability(&mut self, type_: u32, code: u32) {
+        // SAFETY: `self.ptr` is valid and type/code are valid capability values.
+        unsafe {
+            bindings::input_set_capability(self.ptr.as_ptr(), type_, code);
+        }
+    }
+
+    /// Sets parameter limits for an absolute axis.
+    ///
+    /// Bounds-checks `axis < ABS_CNT` (0x40) to prevent out-of-bounds writes
+    /// to the `absinfo` array in `struct input_dev`.
+    pub fn set_abs_params(
+        &mut self,
+        axis: u32,
+        min: i32,
+        max: i32,
+        fuzz: i32,
+        flat: i32,
+    ) -> Result {
+        if axis >= bindings::ABS_CNT {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: `self.ptr` is valid and `axis` has been verified within bounds.
+        unsafe {
+            bindings::input_set_abs_params(self.ptr.as_ptr(), axis, min, max, fuzz, flat);
+        }
+        Ok(())
+    }
+
+    /// Registers the input device with the kernel input core.
+    ///
+    /// Consumes the `AllocatedDevice` and returns a [`RegisteredDevice`].
+    pub fn register(self) -> Result<RegisteredDevice> {
+        let ptr = self.ptr;
+        // Don't run the AllocatedDevice drop destructor, registration takes ownership.
+        core::mem::forget(self);
+
+        // SAFETY: `ptr` is valid and was allocated by `input_allocate_device`.
+        let ret = unsafe { bindings::input_register_device(ptr.as_ptr()) };
+        if ret != 0 {
+            // SAFETY: Free the allocated device if registration failed.
+            unsafe {
+                bindings::input_free_device(ptr.as_ptr());
+            }
+            return Err(crate::error::Error::from_errno(ret));
+        }
+
+        Ok(RegisteredDevice { ptr })
+    }
+}
+
+impl Drop for AllocatedDevice {
+    fn drop(&mut self) {
+        // SAFETY: `self.ptr` was allocated by `input_allocate_device` and has not been registered.
+        unsafe {
+            bindings::input_free_device(self.ptr.as_ptr());
+        }
+    }
+}
+
+// SAFETY: `AllocatedDevice` exclusively owns its `input_dev` pointer and can be transferred
+// across threads.
+unsafe impl Send for AllocatedDevice {}
+
+/// A registered input device capable of reporting events to userspace.
+pub struct RegisteredDevice {
+    ptr: NonNull<bindings::input_dev>,
+}
+
+impl RegisteredDevice {
+    /// Reports a binary button or key state event.
+    #[inline]
+    pub fn report_key(&self, code: u32, value: bool) {
+        // SAFETY: `self.ptr` is valid and registered with the input core.
+        unsafe {
+            bindings::input_report_key(self.ptr.as_ptr(), code, if value { 1 } else { 0 });
+        }
+    }
+
+    /// Reports an absolute axis position value.
+    #[inline]
+    pub fn report_abs(&self, code: u32, value: i32) {
+        // SAFETY: `self.ptr` is valid and registered with the input core.
+        unsafe {
+            bindings::input_report_abs(self.ptr.as_ptr(), code, value);
+        }
+    }
+
+    /// Flushes and synchronizes all reported events into a single input packet.
+    #[inline]
+    pub fn sync(&self) {
+        // SAFETY: `self.ptr` is valid and registered with the input core.
+        unsafe {
+            bindings::input_sync(self.ptr.as_ptr());
+        }
+    }
+}
+
+impl Drop for RegisteredDevice {
+    fn drop(&mut self) {
+        // SAFETY: `self.ptr` was successfully registered with `input_register_device`.
+        // Unregistering automatically unbinds and frees the device.
+        unsafe {
+            bindings::input_unregister_device(self.ptr.as_ptr());
+        }
+    }
+}
+
+// SAFETY: `RegisteredDevice` can be safely transferred across threads.
+unsafe impl Send for RegisteredDevice {}
+// SAFETY: Event reporting on `input_dev` is thread-safe (protected by internal locks in the
+// input core).
+unsafe impl Sync for RegisteredDevice {}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..ff5c978758d0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -88,6 +88,8 @@
 #[doc(hidden)]
 pub mod impl_flags;
 pub mod init;
+#[cfg(CONFIG_INPUT = "y")]
+pub mod input;
 pub mod interop;
 pub mod interrupt;
 pub mod io;
-- 
2.56.0

