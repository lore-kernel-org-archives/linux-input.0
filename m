Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993756;
	b=xJ51/OSCdHbFdFCw+eruWMpyIwu/zQitUg1DWxcUrd8LKGqIw1QmTcB19WN+JtmL5lE7
	 FM2NVSk4f3bi267viWSbDvF4SANp+H67LqAhgg/lzOKqxHbRif3f6J/vBTlcxaIC4WrH/
	 24obL36pNcYXFGma/DU+b/stmR046yv7uakd/M9XUaLl1s9IUTEVMiMg5yHaPHrbQU+hx
	 aB/84T29KK2V2/IWgVPmb7biZosrFS4iMa1RmGSRtlHdEqO3MUvwWVj7pFTvjY5rD7xd0
	 B7Hs5qzuoo3kyNBGTG/u8DGkl9B4DvkcPE0QRR6pER0G43vdWYYztu627YUkbLCDQKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993756;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D/dJh5QgfytodgdhBEPP21h5wgOBhHMT/zHyjBq9BjA=;
	b=G+JHhG8pYy8FhvVQ9mVgD+LLiQeVDQBLwj88xeFcgYxJk1r6y07CFbc/YdTCB69V/IvD
	 HZWP7b/SAiM6rJJbsVqsuW+W0CURvaisERVqfNYVALG2se3tF7Fmr3SVTUMxVBdF1SZ7W
	 SgRmAC0Q1lpk8I7UDdnlkXME1kUHwK5695dhNFFsTnwkmKGWmEnbZEumpUVwt12C/++jL
	 qH8P68/NeLWy7xo9fkfFgVf8JQY8OVBR1ZMQdhl24VB4EX0NAYXbHXR4WjwtYo2voZ07x
	 EwW05C6MpfPpDqLUWeeMrymzy/bhpDZk36c7U7mod4IIzdL3nJIRt42/3OBWPTtnA0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ80JHJa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69150606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZ80JHJa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36E01F0089F;
	Fri,  6 Nov 2026 19:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793993756;
	bh=D/dJh5QgfytodgdhBEPP21h5wgOBhHMT/zHyjBq9BjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZ80JHJaJetjV+S8vSoduYiOiirkBq02+s1mGaTMBFyPk0iQTIOnuVlojjbbr8sWK
	 5d7UXBlSZwxcdbRSwDm/q15rkiuVqzV7i85dYJ3rr2O3iOLqIxjMY5d5+JhI65R1Ei
	 zXAlaAgPH3duEauJ8owHLcHjIAnKfcDgOyK3/Ez++iDfIIzLMuod6iGSzdvVW9gZGK
	 Xv9x9zY0V7EAhIPRVQQS67Puq1RQC93Y7zmb0iCS9ZOglx2H05uTBt45bH2HvV/BwK
	 CPEYmIX+Op3LS5KwE13Mlx6bXw2851qyUZJpXLCXqcwKZmAjlaNsVYr+v9EE7EKoWL
	 v00UDrFNzzrcg==
Message-ID: <sashiko-outbox-202155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rust: serio: add serio bus abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106191714.334055-3-harepro29@gmail.com>
References: <20261106191714.334055-1-harepro29@gmail.com>
 <20261106191714.334055-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:35:55 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] rust: serio: rust_helper_serio_register_driver() uses wrong
  THIS_MODULE
- [High] rust: serio: Driver::ID_TABLE slice lacks sentinel causing OOB
  read
- [Medium] rust: serio: unguarded serio and input build fails when
  CONFIG_SERIO=3Dm/n
- [Medium] rust: serio: connect_callback() negates negative errno and
  opens port late
- [Medium] rust: serio: Registration stores serio_driver without Opaque
  causing UB
- [Low] rust: serio: IrqReturn duplicates kernel::irq::IrqReturn with
  wrong paths
- [Low] rust: serio: Device and Registration bypass generic driver
  infrastructure
- [Low] rust: serio: missing inline attributes, non-vertical imports,
  and core::ffi
--

commit a79cbd7ccd6c2d027f39fc787dc865ce37a52295
Author: clicedvly768 <harepro29@gmail.com>

rust: serio: add serio bus abstractions

This commit adds Rust abstractions and C helper wrappers for the serio
bus subsystem, including DeviceId, Device, IrqReturn, Driver, and
Registration.

> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7a11f5fa461d2..84ffdb015b6d9 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -66,6 +66,7 @@
>  #include "fs.c"
>  #include "fwctl.c"
>  #include "gpu.c"
> +#include "input.c"
>  #include "interrupt.c"
>  #include "io.c"
>  #include "irq.c"
> @@ -92,6 +93,7 @@
>  #include "scatterlist.c"
>  #include "security.c"
>  #include "serdev.c"
> +#include "serio.c"
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"

[ ... ]

> diff --git a/rust/helpers/serio.c b/rust/helpers/serio.c
> new file mode 100644
> index 0000000000000..cd061495d9b1d
> --- /dev/null
> +++ b/rust/helpers/serio.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/serio.h>
> +
> +__rust_helper void *rust_helper_serio_get_drvdata(struct serio *serio)
> +{
> +	return serio_get_drvdata(serio);
> +}
> +
> +__rust_helper void rust_helper_serio_set_drvdata(struct serio *serio, vo=
id *data)
> +{
> +	serio_set_drvdata(serio, data);
> +}
> +
> +__rust_helper int rust_helper_serio_register_driver(struct serio_driver =
*drv)
> +{
> +	return __serio_register_driver(drv, THIS_MODULE, KBUILD_MODNAME);
> +}

[Severity: High]
Does evaluating THIS_MODULE and KBUILD_MODNAME inside
rust_helper_serio_register_driver() leave drv->driver.owner as NULL for
loadable Rust serio drivers?

Because rust/helpers/serio.c is compiled into rust/helpers/helpers.o rather
than the registering driver module, THIS_MODULE expands to NULL (when
helpers.o is built-in) and KBUILD_MODNAME expands to "helpers".  When
__serio_register_driver() sets drv->driver.owner =3D owner, neither the
driver core nor serio_queue_event() (via try_module_get(drv->driver.owner))
can pin the driver module while ports are bound or kseriod events are
queued, allowing the module to be unloaded while still in use and causing a
use-after-free.

Since __serio_register_driver() and serio_unregister_driver() are already
exported non-inline C functions, these two helpers can be dropped and
Registration::new() can take a &'static ThisModule and pass
module.as_ptr() and name.as_char_ptr() directly to
bindings::__serio_register_driver().

> +
> +__rust_helper void rust_helper_serio_unregister_driver(struct serio_driv=
er *drv)
> +{
> +	serio_unregister_driver(drv);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 559fc79b1e820..c9f82dce8f823 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -86,6 +86,7 @@
>  #[doc(hidden)]
>  pub mod impl_flags;
>  pub mod init;
> +pub mod input;
>  pub mod interop;
>  pub mod interrupt;
>  pub mod io;
> @@ -128,6 +129,7 @@
>  pub mod seq_file;
>  #[cfg(CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS)]
>  pub mod serdev;
> +pub mod serio;
>  pub mod sizes;
>  #[cfg(CONFIG_SOC_BUS)]
>  pub mod soc;

[Severity: Medium]
Does building with CONFIG_SERIO=3Dm or CONFIG_SERIO=3Dn (or CONFIG_INPUT=3D=
m/n)
fail to link vmlinux?

CONFIG_SERIO and CONFIG_INPUT are tristate Kconfig options, and
include/linux/serio.h and include/linux/input.h declare
__serio_register_driver(), serio_unregister_driver(), serio_open(),
serio_close(), and the input_*() functions without inline stubs when
disabled.  Because rust/kernel/lib.rs and rust/helpers/helpers.c are always
built into vmlinux when CONFIG_RUST=3Dy, compiling rust/helpers/serio.c,
rust/helpers/input.c, kernel::serio, and kernel::input without Kconfig
guards causes undefined symbol references at link time whenever
CONFIG_SERIO or CONFIG_INPUT is n or m.

[ ... ]

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..3b752ce4b64de
> --- /dev/null
> +++ b/rust/kernel/serio.rs
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Serio (Serial I/O) bus abstractions for safe Rust drivers.
> +//!
> +//! Provides a safe Rust interface for serio devices and drivers in the =
Linux kernel,
> +//! supporting input devices such as serial gamepads (e.g. Gravis Stinge=
r), mice, and keyboards.
> +
> +use crate::{
> +    bindings,
> +    error::{to_result, Result},
> +    prelude::*,
> +    types::ForeignOwnable,
> +};
> +use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
> +
> +/// Identifies supported serio hardware devices for auto-probing and mat=
ching.
> +#[repr(transparent)]
> +#[derive(Copy, Clone)]
> +pub struct DeviceId(bindings::serio_device_id);
> +
> +impl DeviceId {
> +    /// Creates a new serio device identifier.
> +    pub const fn new(type_: u8, extra: u8, id: u8, proto: u8) -> Self {
> +        Self(bindings::serio_device_id {
> +            type_,
> +            extra,
> +            id,
> +            proto,
> +        })
> +    }
> +}

[Severity: Low]
This isn't a bug, but there are a few style and convention issues in this
file:

- The imports at the top use horizontal grouping instead of the kernel
  vertical import style.
- Small functions in the kernel crate (DeviceId::new(), IrqReturn::to_c(),
  Device::as_raw(), and Device::phys()) are missing #[inline] attributes.
- connect_callback() and interrupt_callback() use core::ffi::{c_int,
  c_uchar, c_uint} instead of the crate::ffi / prelude C integer types.

> +
> +/// Status returned by a serio driver interrupt handler.
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +pub enum IrqReturn {
> +    /// Interrupt was not handled by this driver.
> +    None,
> +    /// Interrupt was successfully handled.
> +    Handled,
> +}
> +
> +impl IrqReturn {
> +    fn to_c(self) -> bindings::irqreturn_t {
> +        match self {
> +            Self::None =3D> bindings::irqreturn::IRQ_NONE,
> +            Self::Handled =3D> bindings::irqreturn::IRQ_HANDLED,
> +        }
> +    }
> +}

[Severity: Low]
Can this reuse kernel::irq::IrqReturn instead of defining a second
IrqReturn enum?  Also, bindgen generates bindings::irqreturn_IRQ_NONE and
bindings::irqreturn_IRQ_HANDLED rather than bindings::irqreturn::IRQ_*.

> +
> +/// A serio port device instance passed to driver callbacks.
> +pub struct Device {
> +    ptr: NonNull<bindings::serio>,
> +}

[Severity: Low]
Should Device and Registration integrate with the generic device and
driver abstractions in kernel::device and kernel::driver?

Wrapping Opaque<bindings::serio> with a device::DeviceContext parameter and
implementing AsRef<device::Device<Ctx>> (and using driver::RegistrationOps
/ driver::DriverLayout for registration) would allow serio drivers to
obtain a &device::Device for setting parent devices (such as
input_dev->dev.parent =3D &serio->dev), logging via dev_info! / dev_err!, a=
nd
using devres.

[ ... ]

> +/// Trait implemented by serio device drivers.
> +pub trait Driver: Send + Sync + Sized {
> +    /// Context data stored per connected device instance.
> +    type Data: ForeignOwnable + Send + Sync;
> +
> +    /// Device ID match table.
> +    const ID_TABLE: &'static [DeviceId];

[Severity: High]
Can passing a plain &'static [DeviceId] slice to C as drv->id_table cause
an out-of-bounds read in serio_match_port()?

drivers/input/serio/serio.c:serio_match_port() walks the table until it
reaches a zeroed sentinel entry:

drivers/input/serio/serio.c:serio_match_port() {
	while (ids->type || ids->proto) {
		if ((ids->type =3D=3D SERIO_ANY || ids->type =3D=3D serio->id.type) &&
...
		ids++;
	}
}

Because Driver is a safe trait and &[DeviceId] does not enforce a trailing
zero sentinel (and an empty slice passes a dangling pointer from
as_ptr()), any safe Driver implementation that does not manually append a
zeroed DeviceId entry will cause serio_match_port() to read past the end of
ID_TABLE when probing a non-matching port.  DeviceId should implement
kernel::device_id::RawDeviceId and use kernel::device_id::IdTable /
IdArray so the zero terminator is guaranteed at compile time.

[ ... ]

> +    /// # Safety
> +    ///
> +    /// Must only be invoked by the serio subsystem when a matching port=
 is probed.
> +    /// `serio` and `drv` must be valid non-null pointers provided by th=
e kernel.
> +    unsafe extern "C" fn connect_callback(
> +        serio: *mut bindings::serio,
> +        drv: *mut bindings::serio_driver,
> +    ) -> core::ffi::c_int {
> +        let Some(serio_nn) =3D NonNull::new(serio) else {
> +            return -(crate::error::code::EINVAL.to_errno());
> +        };
> +
> +        let mut dev =3D Device { ptr: serio_nn };
> +
> +        let data =3D match T::connect(&mut dev) {
> +            Ok(d) =3D> d,
> +            Err(e) =3D> return e.to_errno(),
> +        };
> +
> +        let raw_data =3D data.into_foreign();
> +        // SAFETY: `serio` is valid; store driver data pointer.
> +        unsafe {
> +            bindings::serio_set_drvdata(serio, raw_data.cast());
> +        }
> +
> +        // SAFETY: Open serio port to start receiving characters.
> +        let ret =3D unsafe { bindings::serio_open(serio, drv) };

[Severity: Medium]
Does connect_callback() return a positive errno on NULL and invoke
T::connect() before the port is opened?

Error::to_errno() already returns a negative errno (-22 for EINVAL), so
-(crate::error::code::EINVAL.to_errno()) returns +22 instead of -EINVAL.

In addition, calling T::connect() before serio_set_drvdata() and
serio_open() means the serio port is not open during T::connect(), and a
driver that registers an input device inside T::connect() exposes the input
device to userspace before serio_open() has succeeded.

[ ... ]

> +impl<T: Driver> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: Unregister driver with kernel.
> +        unsafe {
> +            bindings::serio_unregister_driver(self.drv.as_mut().get_mut(=
));
> +        }
> +    }
> +}

[Severity: Medium]
Does self.drv.as_mut().get_mut() violate Rust's aliasing rules while the
serio driver is still registered with the kernel?

Registration<T> stores bindings::serio_driver directly in
Pin<KBox<bindings::serio_driver>> without wrapping it in
kernel::types::Opaque.  While the driver is registered, C code in the
serio core holds pointers to struct serio_driver and accesses or mutates
its fields (such as drv->manual_bind in bind_mode_store() and
serio_unregister_driver()), so creating an exclusive &mut
bindings::serio_driver before serio_unregister_driver() completes is
undefined behavior.  Wrapping bindings::serio_driver in Opaque avoids
forming an exclusive reference to C-owned memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106191714.3340=
55-1-harepro29@gmail.com?part=3D2
