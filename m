Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992650;
	b=BGC2gMXyT6HKGqweUVzrXR8Vel8zcEH8bnIKWATbvWwyA1aTrDNrrfdu+7/+UMuWyDLf
	 nkkH3Qoqx7Ljeo5EzEzWAwLPz4fXWbfZVIWnea7cGBsPEJeQpH3wh8YO/NrGDm2u4gtFe
	 h5Rw5ehh7vN/2s2RzIjNdZrK2kLmOZtBEVkqHDVlk2ugQelzc5rso2FkrUzrS6V0lX7Yj
	 NGV7zSdLmcyinUlOOzvhdHhU73xbvPR5pzfRnDsJLezSOztOtb/jn3SJTWVlY1YIgv4H/
	 coX68nNCV2gyJFHocwfHa9SPXdvADU2uCCCBA9d/7rG21qnJ2TKKvlL05qFr12ne1Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zHzf9wgU5VyZ/mS1QgmWRiHGGDAEn/QphPu9g4oJOcM=;
	b=ffH383cLYXY5E+nffLSyd+pWpuUwaC4vjcvmr+v1ONS4xFq+Y5svryKBfuKSYLP5g6zo
	 VWefhCFLUcEvvc12z6n6YEdn+lULf6uGtJYDrpYIja0QqM7Rm3A+eDE3tD+RT6M0Y9LsQ
	 aOW7ngP0Pa2m4rLAWyLymJb0gL6Yrp1Q9w5WYdDLVKK4pFqwToMX2XVWhHNJXIyokr2Pb
	 Jvd425TQhj/aWIBlbBeC25rp4K9nu+mGE0DDl/Bpc9Ua4bSWYI6DWfS6aCmwoSS9lGq1/
	 6mM01Hqzu+9HkwRTSg23KC2XVqb4YIOBLXHiuNzVZ/ynOYQv2Z4ohm0RutjKKu4xC4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CMKD5I93;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A6606A32E
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620A6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CMKD5I93
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1349438f8f.1
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992649; x=1794597449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHzf9wgU5VyZ/mS1QgmWRiHGGDAEn/QphPu9g4oJOcM=;
        b=CMKD5I93WeAuYhjdumM0f2Q/Doq1Z7c3KwaD0uZfgZdc0m/AgUvzx4rNmLonwvzBtw
         j1IuVkwLTFDIVrHz+5DvVwP+R0eTZ1O0nAMHdyy2vgTIjr6eBkDRCVGgZHdE0Acda3+W
         Tgy+G12i8QxN0XPY0s7G9Z/y0gN7MG9tlN6y/A+V9aPO3B9SwEuAPtAHepvgjlR/r9Xo
         a7yV4PTP6c3BI5tnwOT63tZlVWdmGWSoxyj0Fkfbg84QApmoQJcD3/qe68KyuGhBJcD3
         3w/XScuDBFrQ9a+t9wfswFJIQ+Sn5G6psxIO03FmwgXgeC4vztUxfBry/1GVaFhK2NyR
         pLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992649; x=1794597449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHzf9wgU5VyZ/mS1QgmWRiHGGDAEn/QphPu9g4oJOcM=;
        b=tVaHoljggk5SmWjgunFjqBKyBkFq/Go3zo4HzukFwX0nwsUwC6eKOEq/8WrJuAot1u
         K1RC/VNLVG7WybJyUByIPZqwIIALBVr0v1hSMrqO+Nf6LJISd/24ccW2zQVUAelPtLPD
         137euBs0QAHmLqacaMyYRgLRtB6zFHHTjL4mixtOF+NelnLygE6sV34mDG633RSXuII7
         Y0NuEaRzRHhL6klN2erbJo2HHdpJqPV/H7+y77XFBI2sETyTOHAW1xjcYTN1mm4FY/w4
         DO8ozv9z4z4JBffjXwd7q7bA92mhCobelip4kDK7vGtZtt6RFnE2FqO6JRmb3R1mNSkh
         FwXw==
X-Forwarded-Encrypted: i=1; AL+hErHWx8ZpLct40lcKqxdim8WebJcD4OpIve7mvxCfGENbBcY3DF5FpNQYKcO9iyDb7q35rDq+teryxklWrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z87zz9q/5qT2a3umzYrtaWkqRf//h+3yhhEKui7IP0QNx/uG4Da
	ZHISHnA4qRCezZAO62/3OfDfZiTgAnHDkDr6470g0ylAzxzS/e+91P6X
X-Gm-Gg: AYBFou1IrA+/NsNINcshQq0H0/HeD1UP69YicnlB4X9nSKgxDy/JmvhhSxTiQc7EVFW
	1GJEAIAfcKrjXorbO3gMx1O0O8d7Lsiq5iKy838qgKtGjdQiPBje1KL0PkeSwt7+qYg3Vz29Auc
	3j0zbGXj0P5LEggJC3lxxLUvIrvYkSRp+VMkpWvaHUx/jwuXnpwuAK8YtXk9+mDauW1z/9ACHjy
	OF9UuYAw+wVDgxEiF/9CEgb/XSnwtl0P+xjeFNWIpq8wUXUfhva+l6rg15pd7cyAtPqXVxokMke
	JycT4cQ8MMWPb6qf+60D21BMzaxPc2FqCCun4UlgUm020rlJDQi02VNhFgQsH3RP4LVYlWzV3Sm
	2QWWa9vTNZcqwC5yU3hjINmOvURPw85b2+Xdwl2H+7gwAgrRhAvkhqnIsvJkRBit1awhCcotxt8
	3tJXNiCyWXfU2qEckRL/zcaKD8cavFRc5tVcH4hQqYLELnxqFox4HiZXCGmkjrdCI8mEdOamZ3Y
	PI1RS7hpKXCqyuOdAyQCyoyV3t6MqKtIGGAko67M1oHMJyswaf5t2YemLz5krpuRfCZJorH0DLB
	ChNv85QisYGWuWCDr12tMN9HUHrWk4FolFEuGUnm0Q+OZPzTKYfo19xp25bbbTtVVEoc4PyBSqA
	HuuqMVbXSAA/iughIF/uG29Rg5TzePl+W3OIJls8kcmoVk6py
X-Received: by 2002:a05:6000:460c:b0:490:9fe2:6a2f with SMTP id ffacd0b85a97d-49119a0702dmr12551302f8f.14.1793992648427;
        Fri, 06 Nov 2026 11:17:28 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6187sm5224380f8f.46.2026.11.06.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:17:27 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH 1/3] rust: input: add input device abstractions
Date: Sat,  7 Nov 2026 00:17:12 +0500
Message-ID: <20261106191714.334055-2-harepro29@gmail.com>
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

Add safe Rust abstractions for Linux input devices (struct input_dev).

This provides:
- `AllocatedDevice`: a newly allocated, unregistered input device handle
  that allows configuring capabilities (keys, absolute axes limits)
  before registration.
- `RegisteredDevice`: a registered input device handle providing safe
  methods to report keys, absolute coordinates, and synchronization
  events. Automatically calls `input_unregister_device` on drop (RAII).
- Constants for bus types (`bus::*`) and event types (`event_type::*`).
- C helper wrappers for inline static functions in <linux/input.h>.

Signed-off-by: clicedvly768 <harepro29@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/input.c            |  18 ++++
 rust/kernel/input.rs            | 174 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 5 files changed, 195 insertions(+)
 create mode 100644 rust/helpers/input.c
 create mode 100644 rust/kernel/input.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..301c75cfeb61 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -171,3 +171,4 @@ const unsigned long RUST_CONST_HELPER_GPU_BUDDY_TRIM_DISABLE = GPU_BUDDY_TRIM_DI
 #include "../../drivers/android/binder/rust_binder.h"
 #include "../../drivers/android/binder/rust_binder_events.h"
 #endif
+#include <linux/input.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index d62c7be1ca7b..0bc33a7b4351 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -109,3 +109,4 @@
 #include "wait.c"
 #include "workqueue.c"
 #include "xarray.c"
+#include "input.c"
diff --git a/rust/helpers/input.c b/rust/helpers/input.c
new file mode 100644
index 000000000000..531733d32f9c
--- /dev/null
+++ b/rust/helpers/input.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/input.h>
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
diff --git a/rust/kernel/input.rs b/rust/kernel/input.rs
new file mode 100644
index 000000000000..dc617fdbdcfd
--- /dev/null
+++ b/rust/kernel/input.rs
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Input subsystem abstractions for safe Rust drivers.
+//!
+//! Provides a safe Rust object-oriented interface around Linux `struct input_dev`,
+//! ensuring safe allocation, capability configuration, registration, and RAII cleanup.
+
+use crate::{bindings, error::Result, prelude::*, str::CStr};
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
+    /// I8042 PS/2 bus.
+    pub const I8042: u16 = bindings::BUS_I8042 as u16;
+}
+
+/// Linux input event types.
+pub mod event_type {
+    use super::*;
+
+    /// Synchronisation event.
+    pub const SYN: u32 = bindings::EV_SYN;
+    /// Key or button event.
+    pub const KEY: u32 = bindings::EV_KEY;
+    /// Relative movement event.
+    pub const REL: u32 = bindings::EV_REL;
+    /// Absolute movement event.
+    pub const ABS: u32 = bindings::EV_ABS;
+}
+
+/// An allocated input device that hasn't been registered yet.
+pub struct AllocatedDevice {
+    ptr: NonNull<bindings::input_dev>,
+}
+
+impl AllocatedDevice {
+    /// Allocates a new input device.
+    pub fn new() -> Result<Self> {
+        // SAFETY: `input_allocate_device` returns either a valid pointer or NULL.
+        let ptr = unsafe { bindings::input_allocate_device() };
+        let ptr = NonNull::new(ptr).ok_or(crate::error::code::ENOMEM)?;
+
+        Ok(Self { ptr })
+    }
+
+    /// Sets the human-readable device name.
+    pub fn set_name(&mut self, name: &'static CStr) {
+        // SAFETY: `self.ptr` is valid and `name` has static lifetime.
+        unsafe {
+            (*self.ptr.as_ptr()).name = name.as_char_ptr().cast();
+        }
+    }
+
+    /// Sets the physical location string.
+    pub fn set_phys(&mut self, phys: *const u8) {
+        // SAFETY: `self.ptr` is valid.
+        unsafe {
+            (*self.ptr.as_ptr()).phys = phys.cast();
+        }
+    }
+
+    /// Sets device identifier (bus type, vendor, product, version).
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
+    /// Enables support for a capability (e.g. key or axis).
+    pub fn set_capability(&mut self, type_: u32, code: u32) {
+        // SAFETY: `self.ptr` is valid and type/code are valid capability values.
+        unsafe {
+            bindings::input_set_capability(self.ptr.as_ptr(), type_, code);
+        }
+    }
+
+    /// Sets parameter limits for an absolute axis.
+    pub fn set_abs_params(&mut self, axis: u32, min: i32, max: i32, fuzz: i32, flat: i32) {
+        // SAFETY: `self.ptr` is valid.
+        unsafe {
+            bindings::input_set_abs_params(self.ptr.as_ptr(), axis, min, max, fuzz, flat);
+        }
+    }
+
+    /// Registers the input device with the kernel subsystem.
+    ///
+    /// Consumes the `AllocatedDevice` and returns a registered RAII handle [`RegisteredDevice`].
+    pub fn register(self) -> Result<RegisteredDevice> {
+        let dev_ptr = self.ptr.as_ptr();
+        core::mem::forget(self);
+
+        // SAFETY: `dev_ptr` was allocated by `input_allocate_device()`.
+        let ret = unsafe { bindings::input_register_device(dev_ptr) };
+        if ret != 0 {
+            // SAFETY: Clean up on failure.
+            unsafe {
+                bindings::input_free_device(dev_ptr);
+            }
+            return Err(crate::error::Error::from_errno(ret));
+        }
+
+        // SAFETY: `dev_ptr` is known valid and non-null from `AllocatedDevice`.
+        let ptr = unsafe { NonNull::new_unchecked(dev_ptr) };
+        Ok(RegisteredDevice { ptr })
+    }
+}
+
+impl Drop for AllocatedDevice {
+    fn drop(&mut self) {
+        // SAFETY: Device was allocated but not registered; free it cleanly.
+        unsafe {
+            bindings::input_free_device(self.ptr.as_ptr());
+        }
+    }
+}
+
+/// A registered input device capable of reporting events.
+pub struct RegisteredDevice {
+    ptr: NonNull<bindings::input_dev>,
+}
+
+impl RegisteredDevice {
+    /// Reports a binary key/button press or release event.
+    pub fn report_key(&self, code: u32, value: bool) {
+        // SAFETY: `self.ptr` points to a valid registered `struct input_dev`.
+        unsafe {
+            bindings::input_report_key(self.ptr.as_ptr(), code, if value { 1 } else { 0 });
+        }
+    }
+
+    /// Reports an absolute axis coordinate.
+    pub fn report_abs(&self, axis: u32, value: i32) {
+        // SAFETY: `self.ptr` points to a valid registered `struct input_dev`.
+        unsafe {
+            bindings::input_report_abs(self.ptr.as_ptr(), axis, value);
+        }
+    }
+
+    /// Synchronizes input events (signals completion of an event packet).
+    pub fn sync(&self) {
+        // SAFETY: `self.ptr` points to a valid registered `struct input_dev`.
+        unsafe {
+            bindings::input_sync(self.ptr.as_ptr());
+        }
+    }
+}
+
+impl Drop for RegisteredDevice {
+    fn drop(&mut self) {
+        // SAFETY: `self.ptr` is a valid registered device.
+        // `input_unregister_device` automatically unregisters and frees it.
+        unsafe {
+            bindings::input_unregister_device(self.ptr.as_ptr());
+        }
+    }
+}
+
+// SAFETY: `RegisteredDevice` can be safely sent across threads (the input core is thread-safe).
+unsafe impl Send for RegisteredDevice {}
+// SAFETY: `RegisteredDevice` can be safely shared across threads.
+unsafe impl Sync for RegisteredDevice {}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..35cbde5f6a97 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -314,3 +314,4 @@ pub fn file_from_location<'a>(loc: &'a core::panic::Location<'a>) -> &'a core::f
         c"<Location::file_as_c_str() not supported>"
     }
 }
+pub mod input;
-- 
2.56.0

