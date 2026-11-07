Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033333;
	b=NecgTDJE/S4yuUyxdpm/ZrF4TNv2x1wa2xAeTM8hlmJh+Bs5rP4ORiidAjztuji6JmeT
	 +qGxV/1fQRIC0nek9NbUWopYKmlTvsnDVTCkSjqdsnBS6boYnzQkAY01c7Rj5Xsu/bNDF
	 YKC5fFaCCZo8EtCICcd2SeIqVMFtkz3JMWWFcmo3h2rfTWcMlHnV70Rk25+v4j+ROygFq
	 47UiDYxw7Sd5Wzt6YWHazw3qABxrKMVXqlLIuRJQ84fas1hmBwltOL8snyk5A2dIKo1Yl
	 bnHuMfHCEPQeYIkhP6Gp/GJZagfN1UFLEIVA4sSRkxnJq1VyyVj390RUuaOXQI7cb9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RacPJkBXQjWo1L6NvBAwFVNdOm+cWYSxFk+Cu0fqNro=;
	b=yHyk2AlAc7VfffO8wn0/T49QJrIpV2Pm7qcmXOC0VrFhC0hKyOk+Q7qnvvSJwaYonOO8
	 1v03jMNYVpRgQbOSMwTwfp15G43uDLvn97MvPe47PcgJZBiOhLCYLDNP6gNV8VOtesQ85
	 MLIGQw0rhWfmESoZQVdTQZr6FPwn9KW1GYosufzSmynysRU3rWQuWwN5u28kPBc4qP051
	 jXbRfIq3yFqDMrVaQIXbqQweAHfjNYYEcqrk7sL/AfiMZ1Uy5C2no/mYM3hxUZkxxt7cI
	 hmBT+fDb94wmR7tjK73w0Fh1vo2BrdYaFk4Jgnf7qHkC9INuvYE/bFqO1hV2mlG7thQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Jwtinf2;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5A606A335
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 06:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF5A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Jwtinf2
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so10826465e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 22:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794033331; x=1794638131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RacPJkBXQjWo1L6NvBAwFVNdOm+cWYSxFk+Cu0fqNro=;
        b=0Jwtinf2ziH0ZXYeNDQlT4fUPvKGH9PhmOXQTQuhCw2hIlFgR+NhNtllMimwNNLYmf
         yTaS8n4J9Nt7y8AITrUoZwCvI1GmouMWSA+Onq+uLALBYBLry9T+pY7UNbEVi/jdN5+a
         RrZ/JAjJi11nIyxbO1nfZSMRZpznc0NEhkDn6Mj2GReYr/1XUNHupA3k+LHmwg+d41wP
         XSE8+GCbgBGBEqHjcHIhpTYsyLBoLbgkFW9SZUwbQZQZUoSokX36ArIqByfC86w1h2Px
         Yw2fwkIq+/71VRCYFC8xNKaiDxSFESm5k8XtqWSvw9LFngTeRsHwhge/AT+S+FoRoD0d
         6Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794033331; x=1794638131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RacPJkBXQjWo1L6NvBAwFVNdOm+cWYSxFk+Cu0fqNro=;
        b=Ka2O+fp7Ukqt86rdGMw/wQjbWmXGIXu7H0R2nNta5E5h1oJ0vMzki0eN53Q1/Uzhfa
         XqXOlbz5EGBDieMonTBIKz7fjT6DpKyCLqeDqIMUK1KEWz+iuGv9EGHdv5yTCLgmDEQC
         h0MWArmLYeOS6Z6AG21ht2byIfS16U7oe1YwAGbGnCH3cOD3Igf+LImhWhH+kT4bWZi/
         XlkaqoLWfq6YOBXTpfwzBHmAIRe+/TqgBCje2eXHG66OaynklR7GpDsveEjKW1Q7FvKe
         7PlGo8ohe3oG9TRgQG/Tbap0rgUQ7mIiTU8W2CNckmpGdtM4KkxOWe38YJ9wvD3/pfdL
         xNZA==
X-Forwarded-Encrypted: i=1; AKwUvBxObRN2lI0yk/51duwfER7ECnzG6x2ryAd0l6EdbBFwdZErPTk0iVKlLj57+SeFjgqd0f63e+umkFT3bw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9kekXQ0hcuUw83aQt+25EbMaSECS35rc8G8tx0f4I1u/unzu/d
	LLE03I5HuZQ2iBSKyI74UxWZDhI5dloXUiCYxGMeBNtH6+71LiU2M3gjfsDDNElf7Od3tb6W
X-Gm-Gg: AYBFou3tkLD3K7WtfDbMr2uBNRWJjnwm2m5btb9FsuNF0N+B4EkQohFLloq+6JAyO6t
	jkXaa3TqKPcR0L5xthtMW0teX1NHBKd3hZlJ+Y9g++4BMc3SzRg4IqxnVHKwMC7kj2H2gl4kW3U
	yjKldg+eM6nKi/WgLvd9Jpeo3O/ZlAz9P8fIkKgoNDpNEQlq6guR2BkCK+PW8exuBxWiBPnhbXT
	19ZcGcg+SeJIK1yke/iq/MuqVcRybAmKKA5MjTzDwlb1VRV2XfQKzh5zqpEsvrr1/Sz0HjIRISi
	Iz/ZCnUOixXrJsw7IJhWNNs9fX5oTQzcX4Y01ors0zyWUUTyYUZGLZ4fZ5vFkFza7hO3M31mFL3
	iVC50IY9fSeQAduFRDMzJK8n+v5nzPE48Ok13SLunp6i85ojBIRN+RYeiBfU4HP4/mXMdSVyl2o
	tumLaevx+zAUUxZufyTpFe7ooLW346fO0yBXimTbQiBn/RTdL0AjM9WYAF+HU+TbhiN34s0euOu
	sudFwvhPHgGuW8dxBSW+othAQ2OfKEqoyZt6f9LasqXwHH1QgghoWcRIuPUMNE9q89RmG31sY+l
	4OK+hZBStfmTbpCjL6z37MkZsCqDJXdHl+VKZ/1HEizjZlvWOS6isMzI99i36pSmHAzbLhsksZ2
	oylNmTmgiyiO46wcDC9P4X0G7kK5quEFKNxdVQUpgMBERUL6O
X-Received: by 2002:a05:600c:3b29:b0:4a1:fae5:f2e2 with SMTP id 5b1f17b1804b1-4b6db4a5d89mr86315745e9.4.1794033330741;
        Fri, 06 Nov 2026 22:35:30 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d837e3f5sm7916903f8f.56.2026.11.06.22.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:35:30 -0800 (PST)
From: Vecheslav Filatov <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	Vecheslav Filatov <harepro29@gmail.com>
Subject: [PATCH v7 1/2] rust: input: add input device abstractions
Date: Sat,  7 Nov 2026 11:35:18 +0500
Message-ID: <20261107063520.489958-2-harepro29@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107063520.489958-1-harepro29@gmail.com>
References: <20261107063520.489958-1-harepro29@gmail.com>
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

Signed-off-by: Vecheslav Filatov <harepro29@gmail.com>
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

