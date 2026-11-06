Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992655;
	b=KprUh7kqCzvMTzUP7Ius5tIztVdflKMFf3tQ3WwaN26UlxK5G95Bc2TfWn1RXLMbQuNG
	 OSeU8p2SNlvEpDZSkffD0+xCM4SWKsD/rPSuSV+DNLjjtZF157e4J8PhzjYxUEdl1Bptk
	 JSNqBnE6kahf3f3fBfJiPFJfJuI8bGXC9NHnlcrJ41RhnQRzL9Zlhk2Secw9HSpCCVE2u
	 8EjKmQFW7dAg8Sc6ewZmF/N9og6XJq+ybg61FvBwnAD1rZLlrz9R6EGWkYY5g/eQC9xkn
	 rF4z0JoZqbRYVT6iCCLPnMcqWgelO4Tufvvy9GwZ3XH4ufUZMjpuIzMukLDiC11AK5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LAKdfDkve7SZR0Y/g3YfDp0VLfA5VMBa9XGBYnSqzlg=;
	b=c76AY24eFEV7tr0HEeylX6KGX2+sXlhs4HEVsmHsgulILhdz99sjxkM/qup0/iGxj8CS
	 J8klcOPnySQ1qiZ7mWeCzJ7UtDAruTA9/VUPg7Hq72fXBQN3i3YTfN9KMaRKDywp9+L3/
	 90MA8f3qJvr6UpsZw6kjlnVafRw4XgW0XTxezL+zzfInJSvlEkJzaNfqSavCDUnkZZhtY
	 hUdYbEAm5eyEvnKursZKva0/K9rK362sVTDfetHyGrqA7FcqDR3uI7j5n14lg7Mg7w5/b
	 lu1TfQnPyDihrvojfLkSLW65G+tV7Et2rZSiPoNvetH5+6FHOMcswxKPgO0kHikLTOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxUULQSZ;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383A606A332
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E383A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxUULQSZ
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so8531425e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 11:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992653; x=1794597453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LAKdfDkve7SZR0Y/g3YfDp0VLfA5VMBa9XGBYnSqzlg=;
        b=OxUULQSZHWqNqgu1X2/pHukaaHRRqn1SoGfGsLpQATW13ot1qEC4509Tijytd4E/zT
         7XtCb08z+ITik0lVkmCWaI7PKofosycKOeoSpTJLgk6aWNVrPgryr1K8olfFWEGwhRXn
         Vpyv/cXqyye8vKKvoXMyq+IBt4ObjNhE3Urn+KtN+hwROPnsGSx5nfyyWWAdS75rUcCz
         vXuS57+bFOnMKRGrUjWcQy3rGAuI0NKA9TRc7Ao5L+RU1us0yvyb9hLW0qdMrHAKEBfQ
         dKzR9MxOVFSjJGurTs9ChUCm2JQOR06V/1g1+cIh2EJPPHttO7MKhmVevrV+Qniv18ax
         2kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992653; x=1794597453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LAKdfDkve7SZR0Y/g3YfDp0VLfA5VMBa9XGBYnSqzlg=;
        b=i/udeGrqAhtMg9jKP6+o6TYbd0rz2dCDloGcfSAREUmzUg/FxsJsfid6Dct9foV3qB
         81innSElHTdc3F6FZfSF4FCgQv4qTjTkptmmcUNe0HcaE4ncNCX5LUr6j9D4dIOn80Iz
         GupeyGA00HDv9jXJCQTuBi1LJyoAHEKqV12kGgEw9NIengMUnZK9bsQ1+tqlP03x6z9q
         f+cOCDWTMcSeAtfKnlaCCYtULJaY9/6236NBBsHOJOpwpfSF/nbeDdxD8a5REEbEVcMU
         ShwsboWyViPhaeOA3RfLFnu51gaypDcz2z7BxBQbfUkp+fD0hyZGeaHdL4WhXvKCc1/Y
         uMew==
X-Forwarded-Encrypted: i=1; AKwUvBzB3iiw0ICh8tVkUg4kKE84O2OBlcduJxWDTWehToCZcEg6qdIO+VdrLWZJuHZRiIWg2uDI7GyV6dU52w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8wih+Vj7eznWpKiGf5ACKjGPxzAhb2xTCLtKv2vX45eTzOvuy+
	jDm4W71Z5mVy7IWeO/qvfF3ivuzYogmEJTuCCinD/9sqxXZLfIdQ33rStE5EbGbVTfJolV4B
X-Gm-Gg: AYBFou0Oi2+JGXsZWhkQ6ZQcP2r0qEmusfESa+bV8X3F3h/QflzXLZZVo612z+7giJd
	EfxSEKUdrziU2f1Sm92L2iBTeWitwYNnPzq8O/efjhGraB35XEmwCn/ZG/jTamrddk4FqXKt1Xt
	SO81EPELW68ll/Sz9Xnbogfwgj6XHM+YKmLdKOSTRYBaKa/gchr2DG5TPUBaOOgdRlireQYwMVA
	9NO0+hGAgndMs/AtweRHtqBRkgae/ia+26scQONbar2oKS1yiJC9XaVtTNrxnfoytMKGBzDktOh
	K98EcpEJG9GcVgwi9wNGjxuhc6jaxG8YgOzcvKNhS9uKPPB2eLeg3JbDBzFt0V/VgpOfqpmzI62
	agmy/3I/2jra2iof4A19cKE5CAKMZkYgsgksaVmHJgj/1Hu3q7E/eNLkrynvxSNrtO3GtbIqQY8
	JWVGf4jrDL5HqgUmfn4SfhQy056tMxWPZs46/Fg67wfflIXH93J+OU259QFNk+Ggsg7TsGIVoTc
	cFJOGx2pZlYnJMA8MBNmrQlYXteepNpgAOBimx+mnk+yuPXQ/GhfXQ1H5MuUTUBN/V3RlZ8Pk80
	8RrQWfQhKEnG1AlyiN+msHh7rwFH/eznPxN+6rGcD2l2XJ0GCERC/3alXqQnz8BU9jC6lhAAPc9
	5/eltr9f2JW3gt0mNJw7Tn2daA/A0Jj9blfFZBr64EuArYQrW0YZFThggWNeD2s9UspwdHg==
X-Received: by 2002:a05:600c:83c3:b0:4a2:729:f7ce with SMTP id 5b1f17b1804b1-4b6dd54b63cmr61905445e9.8.1793992653168;
        Fri, 06 Nov 2026 11:17:33 -0800 (PST)
Received: from DESKTOP-KHFMJSR ([194.9.62.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc6187sm5224380f8f.46.2026.11.06.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:17:32 -0800 (PST)
From: clicedvly768 <harepro29@gmail.com>
To: ojeda@kernel.org,
	dmitry.torokhov@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-input@vger.kernel.org,
	clicedvly768 <harepro29@gmail.com>
Subject: [PATCH 2/3] rust: serio: add serio bus abstractions
Date: Sat,  7 Nov 2026 00:17:13 +0500
Message-ID: <20261106191714.334055-3-harepro29@gmail.com>
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

Add safe Rust abstractions for the serio (Serial I/O) bus subsystem.

This introduces:
- `DeviceId`: a transparent wrapper around `struct serio_device_id` for
  device matching tables.
- `Device`: a borrowed serio port device passed to driver callbacks.
- `IrqReturn`: typed enum for serio interrupt handler status.
- `Driver` trait: safe interface for serio drivers (`connect`,
  `interrupt`, `disconnect`).
- `Registration<T>`: safe RAII registration adapter that manages the
  underlying `struct serio_driver` pinned on the kernel heap, registering
  it via `serio_register_driver` and unregistering on drop.
- C helper wrappers for inline/macro serio functions in <linux/serio.h>.

Signed-off-by: clicedvly768 <harepro29@gmail.com>
---
 rust/bindings/bindings_helper.h |   3 +-
 rust/helpers/helpers.c          |   3 +-
 rust/helpers/serio.c            |  23 ++++
 rust/kernel/lib.rs              |   3 +-
 rust/kernel/serio.rs            | 223 ++++++++++++++++++++++++++++++++
 5 files changed, 252 insertions(+), 3 deletions(-)
 create mode 100644 rust/helpers/serio.c
 create mode 100644 rust/kernel/serio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 301c75cfeb61..0e44af5d770c 100644
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
@@ -88,6 +89,7 @@
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/serdev.h>
+#include <linux/serio.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
@@ -171,4 +173,3 @@ const unsigned long RUST_CONST_HELPER_GPU_BUDDY_TRIM_DISABLE = GPU_BUDDY_TRIM_DI
 #include "../../drivers/android/binder/rust_binder.h"
 #include "../../drivers/android/binder/rust_binder_events.h"
 #endif
-#include <linux/input.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0bc33a7b4351..61cf3f77e85a 100644
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
@@ -95,6 +96,7 @@
 #include "scatterlist.c"
 #include "security.c"
 #include "serdev.c"
+#include "serio.c"
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
@@ -109,4 +111,3 @@
 #include "wait.c"
 #include "workqueue.c"
 #include "xarray.c"
-#include "input.c"
diff --git a/rust/helpers/serio.c b/rust/helpers/serio.c
new file mode 100644
index 000000000000..cd061495d9b1
--- /dev/null
+++ b/rust/helpers/serio.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/serio.h>
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
+__rust_helper int rust_helper_serio_register_driver(struct serio_driver *drv)
+{
+	return __serio_register_driver(drv, THIS_MODULE, KBUILD_MODNAME);
+}
+
+__rust_helper void rust_helper_serio_unregister_driver(struct serio_driver *drv)
+{
+	serio_unregister_driver(drv);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 35cbde5f6a97..e4a4525fafdd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -88,6 +88,7 @@
 #[doc(hidden)]
 pub mod impl_flags;
 pub mod init;
+pub mod input;
 pub mod interop;
 pub mod interrupt;
 pub mod io;
@@ -132,6 +133,7 @@
 pub mod seq_file;
 #[cfg(CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS)]
 pub mod serdev;
+pub mod serio;
 pub mod sizes;
 #[cfg(CONFIG_SOC_BUS)]
 pub mod soc;
@@ -314,4 +316,3 @@ pub fn file_from_location<'a>(loc: &'a core::panic::Location<'a>) -> &'a core::f
         c"<Location::file_as_c_str() not supported>"
     }
 }
-pub mod input;
diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
new file mode 100644
index 000000000000..3b752ce4b64d
--- /dev/null
+++ b/rust/kernel/serio.rs
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Serio (Serial I/O) bus abstractions for safe Rust drivers.
+//!
+//! Provides a safe Rust interface for serio devices and drivers in the Linux kernel,
+//! supporting input devices such as serial gamepads (e.g. Gravis Stinger), mice, and keyboards.
+
+use crate::{
+    bindings,
+    error::{to_result, Result},
+    prelude::*,
+    types::ForeignOwnable,
+};
+use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
+
+/// Identifies supported serio hardware devices for auto-probing and matching.
+#[repr(transparent)]
+#[derive(Copy, Clone)]
+pub struct DeviceId(bindings::serio_device_id);
+
+impl DeviceId {
+    /// Creates a new serio device identifier.
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
+/// Status returned by a serio driver interrupt handler.
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub enum IrqReturn {
+    /// Interrupt was not handled by this driver.
+    None,
+    /// Interrupt was successfully handled.
+    Handled,
+}
+
+impl IrqReturn {
+    fn to_c(self) -> bindings::irqreturn_t {
+        match self {
+            Self::None => bindings::irqreturn::IRQ_NONE,
+            Self::Handled => bindings::irqreturn::IRQ_HANDLED,
+        }
+    }
+}
+
+/// A serio port device instance passed to driver callbacks.
+pub struct Device {
+    ptr: NonNull<bindings::serio>,
+}
+
+impl Device {
+    /// Returns the raw pointer to the underlying `struct serio`.
+    pub fn as_raw(&self) -> *mut bindings::serio {
+        self.ptr.as_ptr()
+    }
+
+    /// Reads the physical device path into a buffer.
+    pub fn phys(&self) -> &[u8; 32] {
+        // SAFETY: `self.ptr` points to a valid `struct serio`.
+        unsafe { &(*self.ptr.as_ptr()).phys }
+    }
+}
+
+/// Trait implemented by serio device drivers.
+pub trait Driver: Send + Sync + Sized {
+    /// Context data stored per connected device instance.
+    type Data: ForeignOwnable + Send + Sync;
+
+    /// Device ID match table.
+    const ID_TABLE: &'static [DeviceId];
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
+    drv: Pin<KBox<bindings::serio_driver>>,
+    _p: PhantomData<T>,
+}
+
+impl<T: Driver> Registration<T> {
+    /// Registers a serio driver with the kernel.
+    pub fn new(name: &'static crate::str::CStr) -> Result<Self> {
+        let drv = bindings::serio_driver {
+            description: name.as_char_ptr().cast(),
+            id_table: T::ID_TABLE.as_ptr().cast::<bindings::serio_device_id>(),
+            manual_bind: false,
+            write_wakeup: None,
+            interrupt: Some(Self::interrupt_callback),
+            connect: Some(Self::connect_callback),
+            reconnect: None,
+            fast_reconnect: None,
+            disconnect: Some(Self::disconnect_callback),
+            cleanup: None,
+            driver: bindings::device_driver {
+                name: name.as_char_ptr().cast(),
+                ..Default::default()
+            },
+        };
+
+        let mut drv_box = Pin::new(KBox::new(drv, GFP_KERNEL)?);
+
+        // SAFETY: `drv_box` is pinned on the kernel heap at a permanent address.
+        let ret = unsafe { bindings::serio_register_driver(drv_box.as_mut().get_mut()) };
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
+    ) -> core::ffi::c_int {
+        let Some(serio_nn) = NonNull::new(serio) else {
+            return -(crate::error::code::EINVAL.to_errno());
+        };
+
+        let mut dev = Device { ptr: serio_nn };
+
+        let data = match T::connect(&mut dev) {
+            Ok(d) => d,
+            Err(e) => return e.to_errno(),
+        };
+
+        let raw_data = data.into_foreign();
+        // SAFETY: `serio` is valid; store driver data pointer.
+        unsafe {
+            bindings::serio_set_drvdata(serio, raw_data.cast());
+        }
+
+        // SAFETY: Open serio port to start receiving characters.
+        let ret = unsafe { bindings::serio_open(serio, drv) };
+        if ret != 0 {
+            // SAFETY: Clean up driver data if open failed.
+            unsafe {
+                bindings::serio_set_drvdata(serio, core::ptr::null_mut());
+                let data = <T::Data as ForeignOwnable>::from_foreign(raw_data);
+                T::disconnect(data);
+            }
+            return ret;
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
+        data: core::ffi::c_uchar,
+        flags: core::ffi::c_uint,
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
+        ret.to_c()
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
+        // SAFETY: Unregister driver with kernel.
+        unsafe {
+            bindings::serio_unregister_driver(self.drv.as_mut().get_mut());
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

