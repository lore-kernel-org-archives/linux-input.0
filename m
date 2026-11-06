Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996828;
	b=uc8q5L5t0FAtWhwRzqmLjY76cgtT/f9ssTvVn0Go0JQSuy4stapGwX85RnSPzJqBtAzb
	 41bcW2KhxSwYuEQLZmR2EGZxT6aG/2QKfjygV/xLVeFSsaIGlDJNGpsG5TK/PszZMyyv5
	 qD4eqkHzVbbX4rU8eTutMHF31LYb1GuIOu3KbcrUPHslu8M1kqoDE6MIRFoG+9MKDrgd3
	 3W5EZn/08VM9BMxO3MVXFtMIFXk/OHxvB9cPy9hE8SzLKZtE5g3DQCC8KkTihoTgifGp/
	 yu8w8eLqU3JcQUEOY0+n60J07jLvQKh515CXlDjJRS5I10LfrN6uSEqaJhcY6PAPwvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A/QX2aLLMls9nToWK/cadKDUuZNebLWtLfJg6RqpUeY=;
	b=VC1UBRO9Lu0gmt3Izp8ocFNmplWg14kqZmCv1+jWNJgOTTdZfPAyoMDfswxwOmuNUCsM
	 xTWuIzGd5Lt/tPmsWV3kPGAa2D7YSvflTb0Yv/5ZDcKu6AmqWIBeVl9TPpTmxBGC3C+DF
	 mY4f32uVWRhnbqO3H4qnR7NWGm5meUXE08pjffYI5VWN+EgM0oLMko3rnYmPm72dYZUBM
	 L93kFti1rsK/geeYd2uWGlm/5OjNiWax0FgKojikFSN6xtip4mWMX1CS3QyFFqbHhxVmR
	 57ryDxxC+qzrJew/nesKCR9jFd0K3Z9im2vso7kdJF7rDuEeTSiztPpM+lvAxXafYHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGnobSon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1350B606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGnobSon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4790C1F0089F;
	Fri,  6 Nov 2026 20:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793996827;
	bh=A/QX2aLLMls9nToWK/cadKDUuZNebLWtLfJg6RqpUeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TGnobSon9dmT77aqUApkPW3WxEJM8Hpwb4tIRfWCVacDXIwKEQF4VDDUMVnCka2b1
	 zTMiv8zeec852p22/Og4r7SgS89EJQC0yVFRRSDCWm6hYF37kReja0weTEgpFtEASw
	 CJ8cGM48PsfqoUe2pH7GSKJNIhVRurua7oFKwnnHjhvcDdyBhBMP9edPEtKVwZ4F8t
	 piZShw/YNImDnTOXv72bACIuLRY3tIGVgFvI3JzIiM0+iR8BMLg4EnXKHn5eKHvgN9
	 9j1dJr8j/62BsT1QAYG0e1b2YV8ntFo2V2pUjA9OlM8c4OuIB1Vcq9jlGgxtTuiUlJ
	 ySYXRRuBJgAiw==
Message-ID: <sashiko-outbox-202208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] rust: input: add input device abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106201429.376997-2-harepro29@gmail.com>
References: <20261106201429.376997-1-harepro29@gmail.com>
 <20261106201429.376997-2-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:27:06 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] rust: input: unreferenced parent pointer in
  AllocatedDevice::set_parent()
- [Low] rust: input: missing #[inline] on C wrapper methods in input.rs
- [Low] rust: input: non-vertical import style and redundant imports in
  input.rs
- [Low] rust: input: duplicate error cleanup in
  AllocatedDevice::register()
--

commit e772f543b269b5d6668847be715161384d0d5953
Author: clicedvly768 <harepro29@gmail.com>

rust: input: add input device abstractions

This commit adds Rust abstractions for allocating, configuring, and
registering Linux input devices (struct input_dev).

> diff --git a/rust/kernel/input.rs b/rust/kernel/input.rs
> new file mode 100644
> index 0000000000000..bef0c3a07da06
> --- /dev/null
> +++ b/rust/kernel/input.rs
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Input subsystem abstractions for safe Rust drivers.
> +//!
> +//! Provides a safe Rust object-oriented interface around Linux `struct =
input_dev`,
> +//! ensuring safe allocation, capability configuration, registration, an=
d RAII cleanup.
> +
> +use crate::{
> +    bindings, device,
> +    error::{
> +        code::{EINVAL, ENOMEM},
> +        Result,
> +    },
> +    prelude::*,
> +    str::CStr,
> +};

[Severity: Low]
This isn't a bug, but the imports here group multiple items on a single line
without trailing comments instead of using the kernel vertical import style.
Also, EINVAL, ENOMEM, Error, Result, and CStr are already exported by
crate::prelude::*, so importing them explicitly is redundant.

[ ... ]

> +    /// Sets the parent device for this input device.
> +    #[inline]
> +    pub fn set_parent(&mut self, parent: &device::Device) {
> +        // SAFETY: `self.ptr` is valid, and `parent.as_raw()` returns a =
valid `struct device`.
> +        unsafe {
> +            (*self.ptr.as_ptr()).dev.parent =3D parent.as_raw();
> +        }
> +    }

[Severity: Medium]
Can AllocatedDevice::set_parent() leave dev.parent as a dangling pointer?

set_parent() takes a short-lived &device::Device borrow and stores
parent.as_raw() in dev.parent without holding a reference count or tying the
lifetime of AllocatedDevice to parent.  The C driver core does not call
get_device(dev->parent) until input_register_device() -> device_add(), and
input_alloc_absinfo() also dereferences dev->dev.parent before registration=
 on
allocation failure.  If a caller drops the parent device after set_parent()
returns, a subsequent call to set_capability(), set_abs_params(), or
register() from safe Rust will trigger a use-after-free.

> +    /// Enables support for a capability (e.g. key or axis).
> +    #[inline]
> +    pub fn set_capability(&mut self, type_: u32, code: u32) {
> +        // SAFETY: `self.ptr` is valid and type/code are valid capabilit=
y values.
> +        unsafe {
> +            bindings::input_set_capability(self.ptr.as_ptr(), type_, cod=
e);
> +        }
> +    }
> +
> +    /// Sets parameter limits for an absolute axis.
> +    ///
> +    /// Bounds-checks `axis < ABS_CNT` (0x40) to prevent out-of-bounds w=
rites
> +    /// to the `absinfo` array in `struct input_dev`.
> +    pub fn set_abs_params(
> +        &mut self,
> +        axis: u32,
> +        min: i32,
> +        max: i32,
> +        fuzz: i32,
> +        flat: i32,
> +    ) -> Result {
> +        if axis >=3D bindings::ABS_CNT {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: `self.ptr` is valid and `axis` has been verified with=
in bounds.
> +        unsafe {
> +            bindings::input_set_abs_params(self.ptr.as_ptr(), axis, min,=
 max, fuzz, flat);
> +        }
> +        Ok(())
> +    }
> +
> +    /// Registers the input device with the kernel input core.
> +    ///
> +    /// Consumes the `AllocatedDevice` and returns a [`RegisteredDevice`=
].
> +    pub fn register(self) -> Result<RegisteredDevice> {
> +        let ptr =3D self.ptr;
> +        // Don't run the AllocatedDevice drop destructor, registration t=
akes ownership.
> +        core::mem::forget(self);
> +
> +        // SAFETY: `ptr` is valid and was allocated by `input_allocate_d=
evice`.
> +        let ret =3D unsafe { bindings::input_register_device(ptr.as_ptr(=
)) };
> +        if ret !=3D 0 {
> +            // SAFETY: Free the allocated device if registration failed.
> +            unsafe {
> +                bindings::input_free_device(ptr.as_ptr());
> +            }
> +            return Err(crate::error::Error::from_errno(ret));
> +        }
> +
> +        Ok(RegisteredDevice { ptr })
> +    }
> +}

[Severity: Low]
This isn't a bug, but calling core::mem::forget(self) before
input_register_device() forces the error path in register() to manually call
input_free_device() and Error::from_errno(), duplicating Drop::drop() for
AllocatedDevice and error::to_result().  Checking
to_result(unsafe { bindings::input_register_device(self.ptr.as_ptr()) })?
before forgetting self would let Drop handle cleanup on failure.

> +impl Drop for AllocatedDevice {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.ptr` was allocated by `input_allocate_device` a=
nd has not been registered.
> +        unsafe {
> +            bindings::input_free_device(self.ptr.as_ptr());
> +        }
> +    }
> +}

[ ... ]

> +impl Drop for RegisteredDevice {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.ptr` was successfully registered with `input_re=
gister_device`.
> +        // Unregistering automatically unbinds and frees the device.
> +        unsafe {
> +            bindings::input_unregister_device(self.ptr.as_ptr());
> +        }
> +    }
> +}

[Severity: Low]
Small functions in kernel crate abstractions that forward to C bindings sho=
uld
be marked #[inline].  AllocatedDevice::new(),
AllocatedDevice::set_abs_params(), AllocatedDevice::register(),
<AllocatedDevice as Drop>::drop(), and <RegisteredDevice as Drop>::drop() a=
re
missing #[inline].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106201429.3769=
97-1-harepro29@gmail.com?part=3D1
