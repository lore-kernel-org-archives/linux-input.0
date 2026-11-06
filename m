Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000483;
	b=zUoKuxAO5v55wcgI52KVveP8AkPguYgjunJVLlqTZ7Bl+saZVGxsnD2xK/fae72zFmsT
	 imAIbm3lDWE3AqjCpupf81osMYiTjx8fRvyH3N0mCAaRNn+0PLWJ5Xz1np5C146eP3Bgk
	 PhJEfqM/PmeXytcDHZD3BkVZtuVQH2/39kGHNKaiY2Nv0BJOfp4NoDpX3g9Be8P4tPLRj
	 CoUHxSdyRtMX8d3IGZlh4rjc59TL7+l6PQ4pfT/tJ2ADFfJYT4Lxc26NDwrnAxCeN0qN/
	 0r60z/H6nXCRt6wGf8wIO1tmX7gmWBlsDNKHnANKDqWudHK/Mzz796Znzi2YMKby67g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0cps4azkeQeAAjt2CPfu8ck4GXrd0/o1W+lmQpN8b+U=;
	b=TZb3InPIs56xWewDKv0rhOAsBhO+HmI+OKFN1ZTHRiQYfimiCpTSrS23b2RwHUx272NR
	 ST6Yz41DFVox4RkSLsrR2SuRURu7ooZmhbCctdBH30fXIh/jt6CBxttlHl48m2LhuyLn5
	 F2oAFhSiLuuqruDgG+NsISiFmMeCqCLJuHAastqRC7K+uhI8sZYVMe1CxGFcKasQs0dHt
	 eOD96JTAkpMU1f6wKBkKPbdudXNMELGBHwdrlsGLiOa4NE41WHf2cu51HlrL5IEwvO70u
	 WcDhkzz9cH5IuC5h/sPFJJQa7DP2/7kwobtY79nf7a8iehGimiE+n87pCetKDWQ0E3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoBzNxJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AC606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VoBzNxJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2101F0089F;
	Fri,  6 Nov 2026 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000482;
	bh=0cps4azkeQeAAjt2CPfu8ck4GXrd0/o1W+lmQpN8b+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VoBzNxJjhjeOcKYxoVC9MgBmlT/jUOBzWXLqJ4LN/kk41PTpDDadE0EYZ8Q9jwU1U
	 ZOzK5wb1zAEsy3abDAo95UXZPLMk5U6O9GT5OF/bN1l0Qy1LJBwThiM2ru4+XlgK25
	 EvsNA9QAmGr7N07PvvWRvZukw98gTf+qOwMRs1NSyZr9abWWIVGqEfQft5u8JW4vtA
	 OAvVHeFjwHQuYXu5O+uCMZWr/U6kJKuyFZ6mETp0JzDy+z2PMqYYFSfK9DQ4ZnJLB5
	 3P8UPqvkEj8cvSn8vz6/TbV0vEFKLCXZPmgtZ2TV1bLYCY0S71+Yy65JltBV+1CkiS
	 pb4R0OnB8E8rg==
Message-ID: <sashiko-outbox-202296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106211034.401918-3-harepro29@gmail.com>
References: <20261106211034.401918-1-harepro29@gmail.com>
 <20261106211034.401918-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 21:28:01 +0000
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
- [High] Input: joystick - unintended removal of analog.o and db9.o from
  Makefile
- [High] rust: serio: concurrent borrow_mut() and data race between
  start() and interrupt()
- [Medium] rust: serio: non-existent bindings::irqreturn::IRQ_* paths in
  interrupt_callback()
- [Low] rust: serio: non-vertical import style in serio.rs and
  stinger_rust.rs
- [Low] rust: serio: missing #[inline] on Registration::drop() and
  Driver defaults
--

commit 26aa0ef3bea4ec16308e3ef9c8b5857b4bc682ad
Author: clicedvly768 <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports
the Gravis Stinger serial gamepad driver to Rust.

> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Mak=
efile
> index 9976f596a9208..31e23236ff91a 100644
> --- a/drivers/input/joystick/Makefile
> +++ b/drivers/input/joystick/Makefile
> @@ -10,9 +10,7 @@ obj-$(CONFIG_JOYSTICK_ADC)		+=3D adc-joystick.o
>  obj-$(CONFIG_JOYSTICK_ADI)		+=3D adi.o
>  obj-$(CONFIG_JOYSTICK_AMIGA)		+=3D amijoy.o
>  obj-$(CONFIG_JOYSTICK_AS5011)		+=3D as5011.o
> -obj-$(CONFIG_JOYSTICK_ANALOG)		+=3D analog.o
>  obj-$(CONFIG_JOYSTICK_COBRA)		+=3D cobra.o
> -obj-$(CONFIG_JOYSTICK_DB9)		+=3D db9.o
>  obj-$(CONFIG_JOYSTICK_FSIA6B)		+=3D fsia6b.o

[Severity: High]
Were the build rules for analog.o and db9.o removed by mistake? Dropping
these lines causes builds with CONFIG_JOYSTICK_ANALOG or
CONFIG_JOYSTICK_DB9 enabled to stop compiling both drivers.

[ ... ]

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..bd3fae462bb53
> --- /dev/null
> +++ b/rust/kernel/serio.rs
> @@ -0,0 +1,301 @@
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
> +use core::{marker::PhantomData, pin::Pin};

[Severity: Low]
This isn't a bug, but the imports here and in
drivers/input/joystick/stinger_rust.rs group multiple items on a single
line instead of using the kernel Rust vertical import style with one item
per line and a trailing // comment.

[ ... ]

> +        // 3. Open serio port.
> +        // SAFETY: `serio` and `drv` are valid non-null pointers provide=
d by the kernel.
> +        let ret =3D unsafe { bindings::serio_open(serio, drv) };
> +        if ret !=3D 0 {
> +            // SAFETY: Clean up drvdata if open failed.
> +            unsafe {
> +                bindings::serio_set_drvdata(serio, core::ptr::null_mut()=
);
> +                let data =3D <T::Data as ForeignOwnable>::from_foreign(r=
aw_data);
> +                T::disconnect(data);
> +            }
> +            return ret;
> +        }
> +
> +        // 4. Start driver and publish devices now that port is open and=
 interrupts are active.
> +        // SAFETY: `raw_data` was created via `into_foreign()` above and=
 remains valid.
> +        let mut borrowed =3D unsafe { <T::Data as ForeignOwnable>::borro=
w_mut(raw_data) };
> +        if let Err(e) =3D T::start(&mut borrowed) {
> +            // SAFETY: Close port and clean up on start failure.
> +            unsafe {
> +                bindings::serio_close(serio);
> +                bindings::serio_set_drvdata(serio, core::ptr::null_mut()=
);
> +                let data =3D <T::Data as ForeignOwnable>::from_foreign(r=
aw_data);
> +                T::disconnect(data);
> +            }
> +            return e.to_errno();
> +        }
> +
> +        0
> +    }
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

[Severity: High]
Can Registration::interrupt_callback() and Registration::connect_callback()
call ForeignOwnable::borrow_mut() on raw_data at the same time?

Once bindings::serio_open() returns in connect_callback(), port interrupts
are enabled while connect_callback() runs T::start(&mut borrowed) in
process context without holding serio->lock:

CPU0                                  CPU1 (<hardirq>)
Registration::connect_callback()
  bindings::serio_open(serio, drv)
  ForeignOwnable::borrow_mut(raw_data)
  StingerDriver::start(&mut borrowed)
    alloc.register()
                                      Registration::interrupt_callback()
                                        ForeignOwnable::borrow_mut(raw)
                                        StingerDriver::interrupt()
                                          stinger.process_packet()
                                            self.input.as_ref()
    stinger.input =3D Some(...)  <-- aliasing &mut / data race

This creates two concurrent mutable references to Stinger (undefined
behavior in Rust) and races the unsynchronized write to stinger.input in
StingerDriver::start() against reads of self.input in
Stinger::process_packet(), allowing a torn read of RegisteredDevice.

In addition, on the T::start() error path,
ForeignOwnable::from_foreign(raw_data) is called while borrowed is still
in scope, violating the ForeignOwnable::borrow_mut() safety requirement
that all borrows end before from_foreign() is called.

> +        match ret {
> +            IrqReturn::None =3D> bindings::irqreturn::IRQ_NONE,
> +            IrqReturn::Handled =3D> bindings::irqreturn::IRQ_HANDLED,
> +        }
> +    }

[Severity: Medium]
Does bindings::irqreturn::IRQ_NONE compile when CONFIG_SERIO=3Dy is enabled?
Bindgen generates bindings::irqreturn as a type alias for c_uint and
emits top-level constants bindings::irqreturn_IRQ_NONE and
bindings::irqreturn_IRQ_HANDLED (as used in rust/kernel/irq/request.rs),
so referencing associated constants on bindings::irqreturn fails to
build.

[ ... ]

> +impl<T: Driver> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: Unregister driver with kernel. `self.drv` is valid an=
d registered.
> +        unsafe {
> +            bindings::serio_unregister_driver(self.drv.get());
> +        }
> +    }
> +}

[Severity: Low]
Should Registration::drop() and the default methods Driver::start() and
Driver::disconnect() be marked #[inline]? In the kernel crate, small
functions and functions that forward directly to a C binding call are
annotated with #[inline].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106211034.4019=
18-1-harepro29@gmail.com?part=3D2
