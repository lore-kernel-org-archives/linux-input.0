Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004256;
	b=yyPm20tZVzJSWF/8kyoiibxTYr82rA/0tFEht+R9T3WMvvvPLw2XX3gs7zPHxLI7pQzn
	 HIWtzZWUb8gzZUWFt1tjquLa1ca/j2j0wRIdFsGauEICR43y7uE8YB1k8bPuxemGMbfsd
	 ypttOxfu3H2fXKtuNN2IgDawdSJTBYHnugXxMYa1QbFVRG+OZUtftg6uj1MeMYmN9lSYX
	 HbhsDwObwjCuPU/CfInDjEqYqYtinmQsVzGz917DXKOTArwHDifnJ/i2FOROwcy1e7wjL
	 0Ewjxidj0w2hqi31D5yU03gf0YTEt0Jgz9Wa3Ia3D1p/HTAqML/NkTfK5FPaAKyGnRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+Oe17h2tTaw5sfrgyYQb7jsPNk+heDTAtLadvY4MXU=;
	b=PVpOtViTPkgZwqHsAiHB5o1zYM+5sY4HzKqhbfzKf3U/aRHi67WoH+HBxhpYZUhidOpK
	 Oh003wyny3h8UBo6nMoKqR+zUyKHCR/CYyTzbkc34G4mDDDoXoOxo3WX4XrcDaRrJEkrJ
	 3nAWfpa+/NzRVvHfK8O6qa9/OREoUPAY9kCeVs1a4krQ/S51/n0fF3H14kB3VSM2R7aLw
	 zZ5z1UfZr53+o7q0DOEmwHNui/gO34HeHo9FOTqK7xS/g8iH/8tuiB2J20FgJ3gr0Zedx
	 3M16U/5+MLHInkLWbtO0QTjh6MOyMMI6EGX2FmQQ08TKq8C3e1tULAst3Ie+mh3pJqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7qPThvw;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00783606A32C
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 22:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00783606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7qPThvw
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so10510405e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 14:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794004254; x=1794609054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+Oe17h2tTaw5sfrgyYQb7jsPNk+heDTAtLadvY4MXU=;
        b=C7qPThvwYZdQp06XRvq/ElLuwmCDI5cS5bAadYmBs7RQFzYt0Wf+abYVE/tP9UuTDv
         41G5RHJ9q5AfK+sb6DlIonwvDf8LEBrZcuw6rSnVwUKSRWJuLPYc9q2C5BmcWCHqG9Mp
         PfwZECz3pGZZLi+R7jqn2iA8CssDBi/hnX7SVWtnMcy8DS6rtUOVrzNbzJjsOHpolWQP
         grvba/QrlmT+plnbPgP6fxchHWu7Ndi/DIb0nTcmbYIGCbxdInaCSruzeqeHJVqLlfcA
         VEnxJ3ONc+OF1IjjNBGMn8nqykH3I+3+MFIZ6s0DO7+KCuVQmyZRnL+PHckjIzSEdH5a
         qm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004254; x=1794609054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+Oe17h2tTaw5sfrgyYQb7jsPNk+heDTAtLadvY4MXU=;
        b=WSmxQgP2ljz+gnlV66if+5anQNzm/XYYhW9FfV2aQ06Pb0TKntgLSIj6mV81RUQ4wQ
         W2xWSQwPNbDH8aCRZPGZoH0Mu6wrTMvLhyNiPtGelBFurSGjZ57cIksGYGteNjhXFvkD
         RARA+QGqHmYKAtRYvSnzhPkpOYN0qyYDm9Cxn+JmX1JHOqmDEkiqxKW32t73uqfp1on8
         ua+Y5RzeQlOkEIk2zFELP8rDqVr1GrP6HLMGOyoKRbjqTweIbN+wSbQIjZTvkw01r/13
         4Evy/4cF1MlIPwe2TG+dY4hKOhdi+g54Ljg0m/e5ymSGxwPaigDtkTkTgOIgT/7Mvet6
         55kg==
X-Forwarded-Encrypted: i=1; AKwUvBxZ9Hm2w70InEKUsKsWBTvmVfR94mZWmpDusyTe5NAG6fgYO6qrudI/Vj0/KP0pysmQqAZsl7wvE9pinQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z844eHPQgk03jmCpxblK4xY0ohnZ1jkcNUqEvAzr+wmATitjReu
	XvGfqqYkl7B3dTnY7CmgY6ZYRlipx8MQ2OLe7A+Ma8BSq7Cw8fxJg4y9
X-Gm-Gg: AYBFou3ywR5YWHu6P/PeHK2kukWf5b4iCmRufGLHTfaHNtD5PdUnZJZRSjD9WyzfemZ
	AIiwyHSG4Z246g1VnklyHN5wFT4nLboTRP04ZWPbB3JCzd41eISu4EYjxudHomTiXvH0SL+Mw43
	0QpelUQpzYzU+4oyEQZqRp8sVjEekUkYz1DrHhQD8yifGGwpIqRq4lhXibBL5s1j9xHLRBtYXg2
	nLMhQ1IlBiwPn+jNyCGndxGryHgZDHzma4B3IysGwkOsdhIwJZCKT14pB+EU00zPHbTEuH4URBY
	SOPRmnd6hEtIn0LJF2fweDkbIlnYQSzeHKwcTvxsRMfcUSOHrQikJYTDLP1m3HEQTpRu7oCWj8I
	+7wOBvmZTqcj7VOfn0+phv6wWU/aYBYQFX6HF2kZHsolJSsfYpj5AcGpepFcw7Xd0zXe5d5EqKt
	eFZXzc/gDPvMUgR+15fnC8MWajYflJUweU2KkKBOf7LhklPT/3Wae5pm232tN6dXdxsJS/Oauab
	5poU0LSssz+/rUyTmZ97BuBwHytb35HFOUuXOziRtptAvw/LnHYQ7XCpADJT/nr2zdvUl2p7U50
	IfeJKE9RTwO5bs9XTTFWKNwlPkiT3RFb/kmW6xcDCg5Bd1lbuk+GrVh+T4UZQ2CE6i90Ndm4Ht5
	7VjgWNCdWLkQrMy6SKHj9aS6vNKd7w2yTmahqp9wMsjI4GAfQ
X-Received: by 2002:a05:600c:630c:b0:4a2:fe11:9a8a with SMTP id 5b1f17b1804b1-4b6d82b3d9fmr71023015e9.0.1794004254270;
        Fri, 06 Nov 2026 14:30:54 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d8472969sm6262367f8f.58.2026.11.06.14.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:30:53 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH v5 1/2] rust: input: add input device abstractions
Date: Sat,  7 Nov 2026 03:30:32 +0500
Message-ID: <20261106223033.452853-2-harepro29@gmail.com>
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

Add safe Rust abstractions for Linux input devices (struct input_dev).

This provides:
- `AllocatedDevice`: a newly allocated, unregistered input device handle
  that allows configuring capabilities (keys, absolute axis limits, parent
  device) before registration.
- Safe string methods: `set_name` and `set_phys` accept `&'static CStr`
  to prevent use-after-free since the input core does not copy strings.
- `set_phys_from_parent`: dynamic physical location path formatting
  ("%s/input0") stored safely in an owned kernel heap buffer.
- Device lifecycle and reference count management: `set_parent` takes
  a reference count via `bindings::get_device` to avoid dangling pointers,
  releasing it appropriately on drop or post-registration.
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
 rust/helpers/input.c            |  22 +++
 rust/kernel/input.rs            | 253 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 5 files changed, 279 insertions(+)
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
index 000000000000..14977298ad47
--- /dev/null
+++ b/rust/kernel/input.rs
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Input subsystem abstractions for safe Rust drivers.
+//!
+//! Provides a safe Rust object-oriented interface around Linux `struct input_dev`,
+//! ensuring safe allocation, capability configuration, registration, and RAII cleanup.
+
+use crate::{
+    bindings,         //
+    device,           //
+    error::to_result, //
+    prelude::*,       //
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
+    phys: Option<KBox<[u8; 64]>>,
+}
+
+impl AllocatedDevice {
+    /// Allocates a new input device.
+    #[inline]
+    pub fn new() -> Result<Self> {
+        // SAFETY: `input_allocate_device` returns either a valid pointer or NULL.
+        let ptr = unsafe { bindings::input_allocate_device() };
+        let ptr = NonNull::new(ptr).ok_or(ENOMEM)?;
+
+        Ok(Self { ptr, phys: None })
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
+    /// Sets the physical location string from a static C string.
+    #[inline]
+    pub fn set_phys(&mut self, phys: &'static CStr) {
+        // SAFETY: `self.ptr` is valid and `phys` has static lifetime.
+        unsafe {
+            (*self.ptr.as_ptr()).phys = phys.as_char_ptr().cast();
+        }
+    }
+
+    /// Sets the physical location string by formatting `<parent_phys>/input0`.
+    #[inline]
+    pub fn set_phys_from_parent(&mut self, parent_phys: &[u8]) -> Result {
+        let mut buf = KBox::new([0u8; 64], GFP_KERNEL)?;
+        let len = parent_phys
+            .iter()
+            .position(|&b| b == 0)
+            .unwrap_or(parent_phys.len());
+        let suffix = b"/input0\0";
+        if len + suffix.len() > buf.len() {
+            return Err(EINVAL);
+        }
+        buf[..len].copy_from_slice(&parent_phys[..len]);
+        buf[len..len + suffix.len()].copy_from_slice(suffix);
+
+        // SAFETY: `buf` is allocated on the kernel heap and its lifetime is tied to `self.phys`.
+        unsafe {
+            (*self.ptr.as_ptr()).phys = buf.as_ptr().cast();
+        }
+        self.phys = Some(buf);
+        Ok(())
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
+    ///
+    /// Holds a reference count on `parent` to prevent dangling pointers before registration.
+    #[inline]
+    pub fn set_parent(&mut self, parent: &device::Device) {
+        // SAFETY: `self.ptr` is valid, and `parent.as_raw()` returns a valid `struct device`.
+        // Acquire a reference to guarantee `parent` remains alive while referenced by `dev.parent`.
+        unsafe {
+            let old = (*self.ptr.as_ptr()).dev.parent;
+            if !old.is_null() {
+                bindings::put_device(old);
+            }
+            (*self.ptr.as_ptr()).dev.parent = bindings::get_device(parent.as_raw());
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
+    #[inline]
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
+    #[inline]
+    pub fn register(mut self) -> Result<RegisteredDevice> {
+        // SAFETY: `ptr` is valid and was allocated by `input_allocate_device`.
+        to_result(unsafe { bindings::input_register_device(self.ptr.as_ptr()) })?;
+
+        // SAFETY: `device_add` during `input_register_device` acquires its own reference
+        // to `parent`, so we drop our pre-registration reference to avoid a leak.
+        unsafe {
+            let parent = (*self.ptr.as_ptr()).dev.parent;
+            if !parent.is_null() {
+                bindings::put_device(parent);
+            }
+        }
+
+        let ptr = self.ptr;
+        let phys = self.phys.take();
+        core::mem::forget(self);
+
+        Ok(RegisteredDevice { ptr, _phys: phys })
+    }
+}
+
+impl Drop for AllocatedDevice {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `self.ptr` was allocated by `input_allocate_device` and has not been registered.
+        unsafe {
+            let parent = (*self.ptr.as_ptr()).dev.parent;
+            if !parent.is_null() {
+                bindings::put_device(parent);
+            }
+            bindings::input_free_device(self.ptr.as_ptr());
+        }
+    }
+}
+
+// SAFETY: `AllocatedDevice` exclusively owns its `input_dev` pointer and can be transferred
+// across threads.
+unsafe impl Send for AllocatedDevice {}
+// SAFETY: `AllocatedDevice` has exclusive ownership and thread-safe methods.
+unsafe impl Sync for AllocatedDevice {}
+
+/// A registered input device capable of reporting events to userspace.
+pub struct RegisteredDevice {
+    ptr: NonNull<bindings::input_dev>,
+    _phys: Option<KBox<[u8; 64]>>,
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
+    #[inline]
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

