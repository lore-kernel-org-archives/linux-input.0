Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994133;
	b=RIGVpgdIf13qK3pBzxRlYXzJIjipKybXqt2qChjmTGCSbP0+8xsayjY8HR78n2g77KVY
	 KJIvplpNiBBrVejfWQeUmI8TDR8W5pLZ4Uvk7f7Zvj4AJluPEklYWqIcQqVehKP8sTwzt
	 4BV1kkLmprytRqwnRh2VrLLYoYIRKTKQasDI3+rmnRRKpsiA1Mo763SRfVDyIyNql+qQ4
	 3YWwELVmRPeehobfcvr//p8GVbW3K+dj3eHaXPthAwNCe3+VJWjYCqpDP6Y5CUZ+QAGig
	 FmawU2KwiEYqbvGS2v2RCvUTvmdq0lTHUB9e7m9mhTbZbuK3DxG0GmhC4lR45JzgVOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wQ9DYvZgYtqUFzrW2/aQJksI3VXGFMiBaA2vaFHa9SI=;
	b=VxEFKdBf+g2EG7wNEeevSJ2QRKYkRx9YuhL9jUv5J2mjmHCGEQJybqkcCxePhXrB4HqQ
	 U8DijPrDjxZyqa19+wEV2o4GiqdZXnGkVehkELPTRrPwfgjryxdIJ5F4SviLQ3KIftLN8
	 8NVYgNzr//puLOq0KaoTzMwW1KdENAIi0y09pVddIXmHD+0EOfUQsEoTsuzVlHGSk/6Zd
	 T9PSEBgMXqS0pQarndIAUmDgmTxzcDhoYOc/tFlCSvQJPMc7lmz7rxiwPC5mYRA8bQq9u
	 cCqtHWdS+OYPAVA++yRAaTfYD5TMDNzJEFb0rZ8nN0IdkK7MG+EUAkSZ/UNKg4pXMsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L/FrxuXc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F1606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/FrxuXc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DDF1F0089F;
	Fri,  6 Nov 2026 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994132;
	bh=wQ9DYvZgYtqUFzrW2/aQJksI3VXGFMiBaA2vaFHa9SI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/FrxuXcG8Xzpd48Et2vRsAw4ScYnRRDGSEjLmLwxUxOJ8sUFxSClH176inQDCX+/
	 gBVEYfIEoiloYbj/gfL9yBcilsfIDqAx8WQ+eabXA3id6uBfevLPl00uXGK9pPazuy
	 aR8sIhKei3xdThhGXvIp+i5066KcZvxkidQHBYZ5Wg97COA/9k+HKBDyDkdUoZkVUs
	 VrFLxZ/1N8vkcgOr7uOc8rkPZJkxxVKY61cVHdmb9M/54OsCFFpbcVLoHiTrzZmyo0
	 p1y8zK4qgLvBg3xSuModxB62POHqldH9YXW1p0t0fD8d9CN4gPSWuPaMOMadD/4GTR
	 RLm4VG6EHvfrg==
Message-ID: <sashiko-outbox-202161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] input: joystick: stinger: port Gravis Stinger
 driver to safe Rust
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106191714.334055-4-harepro29@gmail.com>
References: <20261106191714.334055-1-harepro29@gmail.com>
 <20261106191714.334055-4-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:42:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [High] Input: stinger - built-in Rust input/serio fails link when
  INPUT/SERIO=3Dm/n
- [Medium] Input: stinger - depends on RUST drops non-Rust support and
  breaks defconfig
- [Medium] Input: stinger - missing MODULE_DEVICE_TABLE breaks module
  autoloading
- [Medium] Input: stinger - missing input_dev parent in connect() breaks
  sysfs hierarchy
- [Medium] Input: stinger - connect() registers input_dev before
  serio_open()
- [Medium] Input: stinger - driver registration uses helper THIS_MODULE
  instead of owner
- [Medium] rust: input: unsound set_phys() and set_abs_params() on
  AllocatedDevice
- [Medium] rust: serio: missing sentinel guarantee on Driver::ID_TABLE
  slice
- [Medium] rust: serio: missing Opaque wrapper for serio_driver in
  Registration
- [Low] rust: serio: negated to_errno() in
  Registration::connect_callback()
--

commit c0702275451987ccba043dca381ae440cb19b04d
Author: clicedvly768 <harepro29@gmail.com>

input: joystick: stinger: port Gravis Stinger driver to safe Rust

This commit replaces the C Gravis Stinger serial gamepad driver
(drivers/input/joystick/stinger.c) with a Rust implementation
(drivers/input/joystick/stinger.rs) and makes CONFIG_JOYSTICK_STINGER
depend on CONFIG_RUST.

> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kcon=
fig
> index 7755e5b454d2c..e672a3bc6dccf 100644
> --- a/drivers/input/joystick/Kconfig
> +++ b/drivers/input/joystick/Kconfig
> @@ -188,6 +188,7 @@ config JOYSTICK_SPACEBALL
>  	  module will be called spaceball.
> =20
>  config JOYSTICK_STINGER
> +	depends on RUST
>  	tristate "Gravis Stinger gamepad"
>  	select SERIO
>  	help

[Severity: Medium]
Does adding depends on RUST directly to JOYSTICK_STINGER while deleting
drivers/input/joystick/stinger.c cause a hardware support regression on
non-Rust configurations and architectures without HAVE_RUST?

For example, arch/powerpc/configs/ppc6xx_defconfig enables
CONFIG_JOYSTICK_STINGER=3Dm without CONFIG_RUST, so the driver is silently
dropped from that defconfig. Documentation/input/joydev/joystick.rst also
still states that the device is supported by the stinger.c module.

[Severity: High]
Can enabling CONFIG_RUST=3Dy with CONFIG_INPUT=3Dm or CONFIG_SERIO=3Dm (suc=
h as
CONFIG_JOYSTICK_STINGER=3Dm, which only selects SERIO under if INPUT) break
the vmlinux link?

CONFIG_RUST is a bool option, so rust/kernel.o and rust/helpers/helpers.o
are always linked into vmlinux, and both unconditionally compile the input
and serio abstractions and C helpers without guarding on CONFIG_INPUT=3Dy or
CONFIG_SERIO=3Dy. When CONFIG_INPUT or CONFIG_SERIO is modular or disabled,
built-in code in rust/kernel/input.rs and rust/helpers/{input,serio}.c
references input_allocate_device(), input_register_device(), input_event(),
__serio_register_driver(), and serio_unregister_driver(), which are either
in loadable modules or not built at all.

[ ... ]

> diff --git a/drivers/input/joystick/stinger.rs b/drivers/input/joystick/s=
tinger.rs
> new file mode 100644
> index 0000000000000..daa1994636315
> --- /dev/null
> +++ b/drivers/input/joystick/stinger.rs

[ ... ]

> +impl serio::Driver for StingerDriver {
> +    type Data =3D KBox<Stinger>;
> +
> +    const ID_TABLE: &'static [serio::DeviceId] =3D &[
> +        serio::DeviceId::new(
> +            bindings::SERIO_RS232 as u8,
> +            bindings::SERIO_ANY as u8,
> +            bindings::SERIO_ANY as u8,
> +            bindings::SERIO_STINGER as u8,
> +        ),
> +        serio::DeviceId::new(0, 0, 0, 0),
> +    ];

[Severity: Medium]
Does dropping MODULE_DEVICE_TABLE(serio, stinger_serio_ids) without a
replacement module_device_table! or module alias entry break automatic
module loading when CONFIG_JOYSTICK_STINGER=3Dm?

Without the exported device table symbol, modpost no longer emits
MODULE_ALIAS("serio:ty02pr1Eid*ex*") into stinger.ko, so udev/kmod cannot
autoload the module when serio_uevent() reports a matching serio port.

[Severity: Medium]
Can a safe implementation of serio::Driver omit the trailing zero entry in
ID_TABLE and cause an out-of-bounds read in serio_match_port()?

In rust/kernel/serio.rs, Driver::ID_TABLE is typed as a plain slice
&'static [DeviceId] rather than a compile-time zero-terminated array, and
Registration::new() passes T::ID_TABLE.as_ptr() directly to the C serio
core:

rust/kernel/serio.rs:Registration::new() {
    let drv =3D bindings::serio_driver {
        description: name.as_char_ptr().cast(),
        id_table: T::ID_TABLE.as_ptr().cast::<bindings::serio_device_id>(),
}

Because serio_match_port() walks ids++ until both ids->type and ids->proto
are zero, any safe serio::Driver that omits the sentinel entry triggers an
out-of-bounds read past the slice.

> +
> +    fn connect(dev: &mut serio::Device) -> Result<Self::Data> {
> +        let mut input_alloc =3D AllocatedDevice::new()?;
> +
> +        input_alloc.set_name(DRIVER_DESC);
> +        input_alloc.set_phys(dev.phys().as_ptr());
> +        input_alloc.set_id(bus::RS232, bindings::SERIO_STINGER as u16, 0=
x0001, 0x0100);

[Severity: Medium]
Does StingerDriver::connect() register the input device with a NULL parent
instead of &serio->dev?

The C driver set input_dev->dev.parent =3D &serio->dev before calling
input_register_device(), whereas AllocatedDevice::new() wraps
input_allocate_device() without setting dev.parent. Registering with a NULL
parent places the device under /sys/devices/virtual/input/ instead of under
the serio port in sysfs, which breaks udev parent matching (such as ID_PATH
and seat assignment) and suspend/resume ordering.

[Severity: Medium]
Are AllocatedDevice::set_phys() and AllocatedDevice::set_abs_params() sound
as safe functions in rust/kernel/input.rs?

rust/kernel/input.rs:AllocatedDevice {
    pub fn set_phys(&mut self, phys: *const u8) {
        // SAFETY: `self.ptr` is valid.
        unsafe {
            (*self.ptr.as_ptr()).phys =3D phys.cast();
        }
    }
    ...
    pub fn set_abs_params(&mut self, axis: u32, min: i32, max: i32, fuzz: i=
32, flat: i32) {
        // SAFETY: `self.ptr` is valid.
        unsafe {
            bindings::input_set_abs_params(self.ptr.as_ptr(), axis, min, ma=
x, fuzz, flat);
        }
    }
}

set_phys() accepts an arbitrary raw pointer from safe code without any
validity, lifetime, or NUL-termination guarantee, even though the input core
dereferences dev->phys as a C string in input_dev_uevent(), sysfs, procfs,
and EVIOCGPHYS for the lifetime of the device. set_abs_params() passes an
unvalidated axis index to input_set_abs_params(), which executes
__set_bit(axis, dev->absbit) and indexes dev->absinfo[axis] without checking
that axis < ABS_CNT, allowing out-of-bounds writes from safe Rust.

> +
> +        // Configure supported buttons
> +        for btn in [
> +            bindings::BTN_A,
> +            bindings::BTN_B,
> +            bindings::BTN_C,
> +            bindings::BTN_X,
> +            bindings::BTN_Y,
> +            bindings::BTN_Z,
> +            bindings::BTN_TL,
> +            bindings::BTN_TR,
> +            bindings::BTN_START,
> +            bindings::BTN_SELECT,
> +        ] {
> +            input_alloc.set_capability(event_type::KEY, btn);
> +        }
> +
> +        // Configure 2-axis joystick with flat margin of 4
> +        input_alloc.set_capability(event_type::ABS, bindings::ABS_X);
> +        input_alloc.set_capability(event_type::ABS, bindings::ABS_Y);
> +        input_alloc.set_abs_params(bindings::ABS_X, -64, 64, 0, 4);
> +        input_alloc.set_abs_params(bindings::ABS_Y, -64, 64, 0, 4);
> +
> +        let registered =3D input_alloc.register()?;
> +
> +        let stinger =3D KBox::new(
> +            Stinger {
> +                input: registered,
> +                idx: 0,
> +                data: [0; STINGER_MAX_LENGTH],
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        Ok(stinger)
> +    }

[Severity: Medium]
Does StingerDriver::connect() publish the input device before the serio
port is opened?

In the C driver, stinger_connect() set the serio drvdata and called
serio_open() before calling input_register_device(). Here,
input_alloc.register() exposes the device to the input core and userspace
before KBox::new() allocates Stinger and before
Registration::connect_callback() calls serio_set_drvdata() and
serio_open():

rust/kernel/serio.rs:Registration::connect_callback() {
    let data =3D match T::connect(&mut dev) {
        Ok(d) =3D> d,
        Err(e) =3D> return e.to_errno(),
    };

    let raw_data =3D data.into_foreign();
    unsafe {
        bindings::serio_set_drvdata(serio, raw_data.cast());
    }
    let ret =3D unsafe { bindings::serio_open(serio, drv) };
}

Userspace can therefore open the input node before the underlying serio port
is opened, and a failure in KBox::new() or serio_open() registers and
immediately unregisters the input device, emitting spurious uevents.

[Severity: Low]
In Registration::connect_callback() in rust/kernel/serio.rs, does the null
check return a positive value instead of a negative errno?

rust/kernel/serio.rs:Registration::connect_callback() {
    let Some(serio_nn) =3D NonNull::new(serio) else {
        return -(crate::error::code::EINVAL.to_errno());
    };
}

Error::to_errno() already returns a negative errno (-22), so negating it
returns +22 instead of -EINVAL.

[ ... ]

> +struct StingerModule {
> +    _reg: serio::Registration<StingerDriver>,
> +}

[Severity: Medium]
Does dropping serio::Registration<T> violate Rust aliasing rules on
bindings::serio_driver?

rust/kernel/serio.rs:Registration {
    drv: Pin<KBox<bindings::serio_driver>>,
    _p: PhantomData<T>,
}

rust/kernel/serio.rs:Registration::drop() {
    unsafe {
        bindings::serio_unregister_driver(self.drv.as_mut().get_mut());
    }
}

Once serio_register_driver() publishes the driver, the C serio core and
sysfs attributes (such as bind_mode_store(), which writes
serio_drv->manual_bind without locking) hold pointers to the struct and may
read or mutate it concurrently. Storing bindings::serio_driver without
kernel::types::Opaque and calling self.drv.as_mut().get_mut() in drop()
creates an exclusive &mut reference while C still has active aliases.

> +
> +impl kernel::Module for StingerModule {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        let reg =3D serio::Registration::<StingerDriver>::new(DRIVER_NAM=
E)?;
> +        pr_info!("Gravis Stinger safe Rust driver initialized\n");
> +        Ok(Self { _reg: reg })
> +    }
> +}

[Severity: Medium]
Does serio::Registration::new() register the driver with the helper
translation unit's THIS_MODULE and KBUILD_MODNAME instead of the driver
module's owner and name?

StingerModule::init() ignores _module, and Registration::new() calls
rust_helper_serio_register_driver():

rust/helpers/serio.c:rust_helper_serio_register_driver() {
	return __serio_register_driver(drv, THIS_MODULE, KBUILD_MODNAME);
}

Because rust/helpers/serio.c is compiled into the built-in helpers object
rather than into stinger.ko, THIS_MODULE is NULL and KBUILD_MODNAME is
"helpers". When CONFIG_JOYSTICK_STINGER=3Dm, drv->driver.owner is NULL and
drv->driver.mod_name is "helpers", so the driver core cannot pin the module
reference count and /sys/bus/serio/drivers/stinger/module linkage is
broken. Registration::new() should accept &'static ThisModule and pass
module.as_ptr() and module name to __serio_register_driver().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106191714.3340=
55-1-harepro29@gmail.com?part=3D3
