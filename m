Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997228;
	b=coYKHF+9FUVFvYKROWbejtWDge6zGe+ARhtAik+dufFKT5ZcaqTG/RmOKC09aSeLOBgE
	 lEyaMXEgbDWEd2yCCcNagdmBn7+d+bT15FGjfMkcJQeDgoCz4uoaj9mgD7zLkodTGymdF
	 pI1wqbZD/lGS2VKUKlM4E/xaiuijWNgqCQ3YdxcXZa24p8g4NX14HtA5iV/2xSJ+MeapG
	 9AJ32Qlt042MyEH9WPmyU9W4Er3ZbKu6aMfmqm/r47FWA940JrzltZtJKKOQzmU+jU6Qy
	 iZFjKrpc8LvMwNgxbTy4f154DtPoY1qJcWLtmzqhvZdIRlwvo5zsQWAZbIPZVxLtiig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fr1OCW1Icgttvwil6Etw95EcIoJi1yWEiigzlSQZ2H8=;
	b=ETBNc5MlDImrf0NVo9X4Y8V9e9rPR2L0sEO1uSaqBqvjZYv/NAZNOaQOC7eAM5GXvl4Q
	 IRkJJgQOE07/0hIhiStg+gK8GS0WT+v6jMOB6OIKpE3Urx0XWdpRw9hCs4tOPy9SwxYhZ
	 D/ZX6NzSOzjtW3OVUGHbqMVplduzCeXxcZNSfITVSSgFxG/iReISJUGKAZW4c8Bzv7ta4
	 KTgFnCglQalAipPN2MukdBwmHyQZJyiVgvZAkVSVzMqP2jIbdtO+JzGpLOl9tq9jdk2TU
	 Un7MT4qr0F03Dg47dj1EUCE3kyWpMpVlL9sgRRn7feYpFJ9KfhC5tfFxxJ+M1jGx19A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeJ+W2kX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C36606A332
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeJ+W2kX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEBE1F008A1;
	Fri,  6 Nov 2026 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997228;
	bh=fr1OCW1Icgttvwil6Etw95EcIoJi1yWEiigzlSQZ2H8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AeJ+W2kXjoGeoF6wUjUs97tEmHgF5hjSv2jX6kXL47yeELcsvcq8g3L8a9gt7Gv5h
	 lwOkKrW2WayksHIRo73bYBf3gpCiTIhOlnacI7gh7uZw3SUT1YwghRwwYIP/baXCJi
	 GGczg6IJOe3X71mEFBg9FwWl5cSJpLLPK0dxYeNFJPiJzMtdnwoqvguG/mgiRJ3MyA
	 18Zg2WiPFUUvuXBjAT7pM6McKfLPzOdPbAzh4Om9B/VJwF0d6VK3kYL2EzBugjWWSW
	 YiOqDyULN2Wcuiv5y3R0N1lcpGImc6fSIDhUbagnRYlKGSflYn7AtQzsuitPj+v1cQ
	 kW5aQgcamxTew==
Message-ID: <sashiko-outbox-202229@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106201429.376997-3-harepro29@gmail.com>
References: <20261106201429.376997-1-harepro29@gmail.com>
 <20261106201429.376997-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] rust: serio: premature serio_open() and unlocked drvdata in
  connect_callback()
- [Medium] input: stinger_rust changes device name, phys path,
  description, and module name
- [Medium] rust: serio: invalid irqreturn_t and IRQ_NONE bindings in
  interrupt_callback()
- [Low] rust: serio: Device and Registration bypass generic driver
  abstractions
- [Low] rust: serio: non-vertical import style in serio.rs and
  stinger_rust.rs
--

commit 986d37559af3527a1a01463ffbfccd5c47d94c58
Author: clicedvly768 <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports
the Gravis Stinger serial gamepad driver to Rust.

> diff --git a/drivers/input/joystick/stinger_rust.rs b/drivers/input/joyst=
ick/stinger_rust.rs
> new file mode 100644
> index 0000000000000..6250d628ee3da
> --- /dev/null
> +++ b/drivers/input/joystick/stinger_rust.rs

[ ... ]

> +const DRIVER_NAME: &CStr =3D c"stinger";
> +const DRIVER_DESC: &CStr =3D c"Gravis Stinger gamepad";
> +const DRIVER_PHYS: &CStr =3D c"serio0/input0";

[ ... ]

> +    fn connect(dev: &mut serio::Device) -> Result<Self::Data> {
> +        let mut input_alloc =3D AllocatedDevice::new()?;
> +
> +        input_alloc.set_name(DRIVER_DESC);
> +        input_alloc.set_phys(DRIVER_PHYS);

[Severity: Medium]
Does replacing stinger.c with stinger_rust.rs when
CONFIG_JOYSTICK_STINGER_RUST=3Dy change the userspace-visible device and
module attributes?

In drivers/input/joystick/stinger.c, stinger_connect() sets input_dev->name
to "Gravis Stinger" and formats input_dev->phys dynamically as "%s/input0"
from serio->phys.  Setting the name to "Gravis Stinger gamepad" breaks
userspace controller mappings and udev rules that match EVIOCGNAME, and
hardcoding "serio0/input0" (leaving serio::Device::phys() unused) reports
the wrong physical path on any port other than serio0 or when multiple
devices are attached.

In addition, drivers/input/joystick/Makefile builds stinger_rust.ko (with
module! name "stinger_rust") instead of stinger.ko as documented in the
CONFIG_JOYSTICK_STINGER Kconfig help text, and Registration::new() sets
serio_driver.description to "stinger" instead of "Gravis Stinger gamepad
driver".

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..b4a8ec7139a28
> --- /dev/null
> +++ b/rust/kernel/serio.rs
> @@ -0,0 +1,256 @@
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
> +    bindings, device,
> +    device_id::{IdTable as GenericIdTable, RawDeviceId},
> +    error::{to_result, Result},
> +    ffi::{c_int, c_uchar, c_uint},
> +    prelude::*,
> +    types::{ForeignOwnable, Opaque},
> +    ThisModule,
> +};
> +use core::{marker::PhantomData, ops::Deref, pin::Pin, ptr::NonNull};

[Severity: Low]
This isn't a bug, but the imports here and in
drivers/input/joystick/stinger_rust.rs group multiple items on single
horizontal lines instead of following the kernel vertical import style in
Documentation/rust/coding-guidelines.rst.

[ ... ]

> +/// A serio port device instance passed to driver callbacks.
> +pub struct Device {
> +    ptr: NonNull<bindings::serio>,
> +}

[ ... ]

> +/// Driver adapter that bridges the safe Rust [`Driver`] trait to the C =
serio bus subsystem.
> +pub struct Registration<T: Driver> {
> +    drv: Pin<KBox<Opaque<bindings::serio_driver>>>,
> +    _p: PhantomData<T>,
> +}

[Severity: Low]
Should serio::Device and serio::Registration use the generic bus device and
driver registration infrastructure in the kernel crate instead of custom
wrappers?

Other bus abstractions (such as serdev, i2c, platform, and pci) define
Device<Ctx: device::DeviceContext =3D device::Normal> as a repr(transparent)
wrapper around Opaque<bindings::...> implementing device::AsBusDevice<Ctx>
and AlwaysRefCounted, and implement driver::DriverLayout and
driver::RegistrationOps on an Adapter<T> type.  Because serio::Device lacks
a DeviceContext parameter, driver callbacks do not receive
&serio::Device<device::Bound> and cannot use device-managed resources such
as devres::register() or Devres::new().

[ ... ]

> +    unsafe extern "C" fn connect_callback(
> +        serio: *mut bindings::serio,
> +        drv: *mut bindings::serio_driver,
> +    ) -> c_int {
> +        let Some(serio_nn) =3D NonNull::new(serio) else {
> +            return crate::error::code::EINVAL.to_errno();
> +        };
> +
> +        // SAFETY: `serio` and `drv` are valid non-null pointers provide=
d by the kernel.
> +        let ret =3D unsafe { bindings::serio_open(serio, drv) };
> +        if ret !=3D 0 {
> +            return ret;
> +        }
> +
> +        let mut dev =3D Device { ptr: serio_nn };
> +
> +        let data =3D match T::connect(&mut dev) {
> +            Ok(d) =3D> d,
> +            Err(e) =3D> {
> +                // SAFETY: Close the opened port on probe error.
> +                unsafe { bindings::serio_close(serio) };
> +                return e.to_errno();
> +            }
> +        };
> +
> +        let raw_data =3D data.into_foreign();
> +        // SAFETY: `serio` is valid; store driver data pointer.
> +        unsafe {
> +            bindings::serio_set_drvdata(serio, raw_data.cast());
> +        }
> +
> +        0
> +    }

[Severity: High]
Does calling serio_open() before T::connect() and serio_set_drvdata() race
with incoming serial interrupts?

serio_open() binds serio->drv under serio->lock and immediately enables
port interrupts via serio->open(serio), while T::connect() sleeps (for
example in AllocatedDevice::new(), input_alloc.register(), and KBox::new()
in StingerDriver::connect()) before drvdata is populated:

CPU0                                  CPU1 (<hardirq>)
connect_callback()
  serio_open(serio, drv)
  T::connect(&mut dev)
                                      serio_interrupt()
                                        spin_lock_irqsave(&serio->lock)
                                        interrupt_callback()
                                          serio_get_drvdata() -> NULL
                                          return IRQ_NONE  <-- drops byte
  serio_set_drvdata(serio, raw_data)
                                        interrupt_callback()
                                          serio_get_drvdata()  <-- data race
                                          ForeignOwnable::borrow_mut(raw)

First, any bytes arriving while T::connect() runs are dropped because
drvdata is still NULL.  In StingerDriver::interrupt(), packets are framed
solely by counting 4 bytes (stinger.idx =3D=3D 4), so dropping 1 to 3 bytes
during connect permanently misaligns all subsequent packet decoding.

Second, serio_set_drvdata() performs a plain unlocked store to
serio->dev.driver_data without holding serio->lock or issuing a release
barrier, racing with interrupt_callback() reading serio_get_drvdata() and
dereferencing T::Data on weakly-ordered architectures.

Third, StingerDriver::connect() calls input_alloc.register() before
KBox::new(Stinger { ... }, GFP_KERNEL) and before drvdata is set, exposing
the input device to userspace before driver initialization can no longer
fail.

In C serio drivers such as stinger_connect() in
drivers/input/joystick/stinger.c, driver state is allocated and stored via
serio_set_drvdata() before calling serio_open() (which synchronizes under
serio->lock in serio_set_drv()), and input_register_device() is called
after serio_open() succeeds.

> +
> +    /// # Safety
> +    ///
> +    /// Must only be invoked by the serio subsystem during an interrupt =
on a connected port.
> +    /// `serio` must be a valid pointer.
> +    unsafe extern "C" fn interrupt_callback(
> +        serio: *mut bindings::serio,
> +        data: c_uchar,
> +        flags: c_uint,
> +    ) -> bindings::irqreturn_t {
> +        // SAFETY: `serio` is valid.
> +        let raw =3D unsafe { bindings::serio_get_drvdata(serio) };
> +        if raw.is_null() {
> +            return bindings::irqreturn::IRQ_NONE;
> +        }
> +
> +        // SAFETY: `raw` was created via `into_foreign()` in `connect_ca=
llback`.
> +        let mut borrowed =3D unsafe { <T::Data as ForeignOwnable>::borro=
w_mut(raw) };
> +        let ret =3D T::interrupt(&mut borrowed, data, flags);
> +        bindings::irqreturn_t(ret as c_uint)
> +    }

[Severity: Medium]
Does interrupt_callback() fail to compile when CONFIG_SERIO=3Dy and
CONFIG_RUST=3Dy?

bindgen generates irqreturn and irqreturn_t as type aliases for ffi::c_uint
along with top-level constants (as seen in rust/kernel/irq/request.rs), not
a module or newtype struct.  bindings::irqreturn::IRQ_NONE does not exist
(it is bindings::irqreturn_IRQ_NONE), and bindings::irqreturn_t(ret as
c_uint) attempts to call a type alias as a tuple struct constructor instead
of casting with ret as bindings::irqreturn_t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106201429.3769=
97-1-harepro29@gmail.com?part=3D2
