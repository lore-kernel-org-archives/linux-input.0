Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002788;
	b=nYErNdW2G1dCSA+J7wg0cAqz7zFiJG/JKygbL+yEO0gaKt/eNxoynfCx60qaQlIPsU5o
	 P94HfN4k1l/aiRnTBWipEvUDD8OJjshdcL3OyGzIeWUEqLCpEXWUT0/AixaBiXu03/cLq
	 rzq7W6wyqQHlRcXulZHGeu2t5xhZtF+zQmaqd68Rgg3YRMevMTHrr1CETTT3vDJO6anIk
	 CJciQR1Elfi8tfjZ7g9Aghic/6/bAZ0eqh4PMZ4MZ7quRQ3fzpUjdWVtjCFlJzRX3+Pw+
	 qjWSEC1slIlIjHbpEKzgXUwnw/Bzk7Vzkfhsx0l6OlfN9XzLnCCT24wWmTuIGnccVlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002788;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lg7SjyaD/murgeoDBZDKIt2hok5ZTuzCF9yolhWV5tA=;
	b=I/qtmbmdRBYJ4kPn+UiDiIlhUC0KwQUoY6uvxXVfmwGsiIc+miUL6Ydfk8LzY4iBDtED
	 ZEp9aFiBuU7lOcqusmpzO9hBExJLwvETDAsG2eRvtgmV4i3ycg6e1acqb1dI8+GtHi+I1
	 XJIhS7PCAWoFPKH1sUsUEnpI9qCtHKs1Ro/0ESXJCQRIkB3J6NJj8kHHbKePHZChJHZOJ
	 MBZQ81gaclsDRAIsgYmP4lzP7dLzAt+PmEvxFrdI9xPK+OY2eCO+ITDg9raxGfcLDAwut
	 ZnpNLwI4x3VKTEMzEUIRYu/MS+xaP6+m/OJW8d8pDQccKQ6w7bvCFxC6lQ3VMTtn1hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eBwFP/jn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BF606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBwFP/jn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5728C1F0089F;
	Fri,  6 Nov 2026 22:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794002787;
	bh=lg7SjyaD/murgeoDBZDKIt2hok5ZTuzCF9yolhWV5tA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBwFP/jnJUDm8JYfzAkPXo95LZZE58HtY9yAW317x6nMV/4MwcUqP8WyoTATGpKJr
	 acfHmiy0PZtLEL2x9neIT5cQzGqZCSiPygQK5iwZIYdstLGl0+WjUmNJydxWpJ0q+w
	 zcQURRVdBvLlZ6cEr7gRHwWc0M4wIHNkXTAVzQ7W8qcEyyVFlY0PNGDxWCP8ee4AyB
	 NVlRl8VOQU1npER3s1ff7BsSHvEIqBJYxLkGGkkv1E5lwBcTChyHkziDiH08K9UuyJ
	 nauFB/FW4eCh5jMNus1Bc0WsiLiX0m9DcX+jB/3V9wAUdM41vdii08P+E4mMED7VLO
	 cqA2PF1d15PzQ==
Message-ID: <sashiko-outbox-202311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106214322.421869-3-harepro29@gmail.com>
References: <20261106214322.421869-1-harepro29@gmail.com>
 <20261106214322.421869-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 22:06:26 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] rust: serio: invalid irqreturn_t constructor call in
  interrupt_callback()
- [Medium] rust: serio: premature input registration before serio_open()
  in connect()
- [Low] rust: serio: redundant as_device() and public as_raw() on
  serio::Device
--

commit 98f91fdb41f94854e741d0d25d20d83c3e00ed06
Author: clicedvly768 <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports the
Gravis Stinger serial gamepad driver to Rust.

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..1878055fb6449
> --- /dev/null
> +++ b/rust/kernel/serio.rs
[ ... ]
> +impl<Ctx: device::DeviceContext> Device<Ctx> {
> +    /// Returns the raw pointer to the underlying `struct serio`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::serio {
> +        self.0.get()
> +    }
> +
> +    /// Reads the physical device path into a buffer.
> +    #[inline]
> +    pub fn phys(&self) -> &[u8; 32] {
> +        // SAFETY: `self.as_raw()` points to a valid `struct serio`.
> +        unsafe { &(*self.as_raw()).phys }
> +    }
> +
> +    /// Returns a reference to the base [`device::Device`].
> +    #[inline]
> +    pub fn as_device(&self) -> &device::Device {
> +        // SAFETY: `self.as_raw()` points to a valid `struct serio`.
> +        unsafe {
> +            let dev =3D core::ptr::addr_of_mut!((*self.as_raw()).dev);
> +            device::Device::from_raw(dev)
> +        }
> +    }
> +}
> +
> +// SAFETY: `serio::Device` is a transparent wrapper of `struct serio`.
> +// The offset is guaranteed to point to a valid device field inside `ser=
io::Device`.
> +unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Dev=
ice<Ctx> {
> +    const OFFSET: usize =3D core::mem::offset_of!(bindings::serio, dev);
> +}
> +
> +kernel::impl_device_context_deref!(unsafe { Device });
> +
> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
> +    #[inline]
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
> +        // `struct serio`.
> +        let dev =3D unsafe { core::ptr::addr_of_mut!((*self.as_raw()).de=
v) };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}

[Severity: Low]
This isn't a bug, but Device::as_device() duplicates the
AsRef<device::Device<Ctx>> implementation right below it while erasing the
DeviceContext parameter Ctx.  Other bus device abstractions in rust/kernel/
expose the base device through as_ref() (which StingerDriver::connect() can
call instead of as_device()) and keep as_raw() private or pub(crate) rather
than exposing the raw pointer outside the kernel crate.

> +
> +/// Trait implemented by serio device drivers.
> +pub trait Driver: Send + Sync + Sized {
> +    /// Context data stored per connected device instance.
> +    type Data: ForeignOwnable + Send + Sync;
> +
> +    /// Device ID match table.
> +    const ID_TABLE: IdTable;
> +
> +    /// Initializes driver data and registers child devices when a match=
ing port is detected.
> +    fn connect(dev: &Device<device::Bound>) -> Result<Self::Data>;
[ ... ]
> +    unsafe extern "C" fn connect_callback(
> +        serio: *mut bindings::serio,
> +        drv: *mut bindings::serio_driver,
> +    ) -> c_int {
> +        if serio.is_null() {
> +            return crate::error::code::EINVAL.to_errno();
> +        }
> +
> +        // SAFETY: `serio` is valid. `Device<Bound>` is repr(transparent=
).
> +        let dev =3D unsafe { &*(serio.cast::<Device<device::Bound>>()) };
> +
> +        // 1. Initialize driver data and register input devices before t=
he port is opened.
> +        let data =3D match T::connect(dev) {
> +            Ok(d) =3D> d,
> +            Err(e) =3D> return e.to_errno(),
> +        };
> +
> +        let raw_data =3D data.into_foreign();
> +
> +        // 2. Set drvdata BEFORE opening port so interrupts never encoun=
ter NULL.
> +        // SAFETY: `serio` is valid; store driver data pointer.
> +        unsafe {
> +            bindings::serio_set_drvdata(serio, raw_data.cast());
> +        }
> +
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
> +        0
> +    }

[Severity: Medium]
Does calling T::connect() before bindings::serio_open() publish the input
device to userspace before the serio port is opened?

In StingerDriver::connect(), input_alloc.register() registers the input
device and emits a KOBJ_ADD uevent before KBox::new() allocates the Stinger
state and before connect_callback() calls serio_open():

drivers/input/joystick/stinger_rust.rs:StingerDriver::connect() {
    ...
        let registered =3D input_alloc.register()?;

        let stinger =3D KBox::new(
            Stinger {
                input: registered,
                idx: 0,
                data: [0; STINGER_MAX_LENGTH],
            },
            GFP_KERNEL,
        )?;
    ...
}

In the C stinger driver, input_register_device() is only called after
serio_open() succeeds.  With the single connect() callback here, userspace
can open the input device before the underlying serio port is open, and if
KBox::new() or serio_open() fails, the input device is published and
immediately unregistered (emitting spurious KOBJ_ADD and KOBJ_REMOVE
uevents) and T::disconnect() is invoked on a connection that never
succeeded.

Also, the commit message states that Driver provides separate init and start
callbacks so devices are published in T::start after serio_open(), which
does not match the Driver trait in the patch.

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
> +            return bindings::irqreturn_t(IrqReturn::None as c_uint);
> +        }
> +
> +        // SAFETY: `raw` was created via `into_foreign()` in `connect_ca=
llback`.
> +        let mut borrowed =3D unsafe { <T::Data as ForeignOwnable>::borro=
w_mut(raw) };
> +        let ret =3D T::interrupt(&mut borrowed, data, flags);
> +        bindings::irqreturn_t(ret as c_uint)
> +    }

[Severity: High]
Does bindings::irqreturn_t(...) fail to compile when CONFIG_SERIO=3Dy and
CONFIG_RUST=3Dy are enabled?

bindgen generates bindings::irqreturn_t as a type alias for c_uint rather
than a tuple struct, so calling bindings::irqreturn_t(...) as a constructor
fails with rustc error E0423.  Cast the return value with
IrqReturn::None as bindings::irqreturn_t and ret as bindings::irqreturn_t
instead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106214322.4218=
69-1-harepro29@gmail.com?part=3D2
