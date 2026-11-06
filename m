Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993402;
	b=uGyOyX1rVGyOhg9i+xvQA2PWq4WCrugTNQUzsT8fEFcardIxjg57fSq90XivDOyQustb
	 iB/G90rYj+eHy7DhfleXpKygABohrG9S5ZuPw0gwergU2iGP6bO5kelw9sAwgNWxC46ra
	 sj04/7xk93OrTwrmN5bvtvfFYcibgtYMYTmuLlMSEBdJf3yeFghKPNxTtjriGbN6FRAGl
	 qyoaRM9Kt7GCg0mapPIrYdsQ/bt9LtnGLJEq2AnZ97kIwL+o2xiwXntO4Eb4a8Xpa60eU
	 ARfinbmTrKfyJsStNtXLuvj4h/tbnuooZz/zlB1CBN20EBUUXicFwp0yJgIFv2CvKHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993402;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TOk7AMs2k+53CO+bLpbRykKFsHK8W0RQoT7g/eptHIo=;
	b=DVKwoIJzsf1+D3co6GKe2anODGFM1kx3q6Zg+RtfRJIo567p3SXwjthKFrgR5TAhdHGt
	 OF4cqDVVJaphUo9kas9zIqLMjNNbgwoGFPWMrWCsozbkyR7ypZfeXCj+p5/dhF4woiFUc
	 Smm4c1Tv2DaIpsLeeNypMIfBeIk33LML6V48CnZVKj7F/Rp6xbismg3b1h+wsgiAPQz63
	 Y4frS6R2KG7qoU3VK/94VXnXsqIFjjMlXEkg7XasWwgMU/fW1aomU94psaDm8jckLK3gm
	 UbQbEnU7HJBlsGuJhzdN8aijQhC5OAuz7/e6LJzu46oppY76YwaNzCegKGkZAZ5D6Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9l7XaEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BD606A32E
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9l7XaEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBC11F008A1;
	Fri,  6 Nov 2026 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793993400;
	bh=TOk7AMs2k+53CO+bLpbRykKFsHK8W0RQoT7g/eptHIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9l7XaEntxOIDvxrD8+FQks+PYrKB1XsIESiGlz6UZ9fnRqkeXW6YQuvZpJN0ucij
	 Hbg9T/IuNDGrDy/LKxMXrVE+OdkEz5gcDNosQveh26MIO/jmDRlKjXttGNKCIJR6f8
	 F4qNFH3Mgd21Akvvegn3wJYVOlioDo2j+p/KBOO2UrlsLkhol96x6UPA8FqW62ApaC
	 4oUgQQIUvG4PDu6U1cY8YUv+0Kq6OeyCgpGFgHDHXmX3PkFzv0ymY7BT5djv9JOybo
	 Y495IUw7p2fbwLbP1Xz4vjzLS8NeXOWIDwdxjQztVknc5rgNcI4qeoSf9xf0Mevnhc
	 2+3JD4BYfcOcw==
Message-ID: <sashiko-outbox-202151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] rust: input: add input device abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106191714.334055-2-harepro29@gmail.com>
References: <20261106191714.334055-1-harepro29@gmail.com>
 <20261106191714.334055-2-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:29:59 +0000
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
- [High] rust: input: unconditional build breaks when CONFIG_INPUT is n
  or m
- [High] rust: input: unsound raw pointer parameter in
  AllocatedDevice::set_phys()
- [High] rust: input: out-of-bounds write in
  AllocatedDevice::set_abs_params()
- [Low] rust: input: missing #[inline] on small C-binding wrapper
  methods
- [Low] rust: input: non-vertical import style and unsorted
  include/module lists
--

commit 9cd0fd4d5edfd06c93102ba62a703d2a5e1c93f2
Author: clicedvly768 <harepro29@gmail.com>

rust: input: add input device abstractions

This commit adds Rust abstractions and C helper wrappers for allocating,
configuring, registering, and reporting events on Linux input devices
(struct input_dev).

> diff --git a/rust/kernel/input.rs b/rust/kernel/input.rs
> new file mode 100644
> index 0000000000000..dc617fdbdcfd3
> --- /dev/null
> +++ b/rust/kernel/input.rs
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Input subsystem abstractions for safe Rust drivers.
> +//!
> +//! Provides a safe Rust object-oriented interface around Linux `struct =
input_dev`,
> +//! ensuring safe allocation, capability configuration, registration, an=
d RAII cleanup.
> +
> +use crate::{bindings, error::Result, prelude::*, str::CStr};

[Severity: Low]
This isn't a bug, but the crate imports here use a single-line horizontal
list instead of the vertical import style from the Rust coding guidelines.
Also, #include <linux/input.h> in rust/bindings/bindings_helper.h,
#include "input.c" in rust/helpers/helpers.c, and pub mod input; in
rust/kernel/lib.rs are appended at the bottom of each file instead of in
their sorted sections (though commit "rust: serio: add serio bus
abstractions" later moves those three entries into alphabetical order).

[ ... ]

> +    /// Sets the human-readable device name.
> +    pub fn set_name(&mut self, name: &'static CStr) {
> +        // SAFETY: `self.ptr` is valid and `name` has static lifetime.
> +        unsafe {
> +            (*self.ptr.as_ptr()).name =3D name.as_char_ptr().cast();
> +        }
> +    }
> +
> +    /// Sets the physical location string.
> +    pub fn set_phys(&mut self, phys: *const u8) {
> +        // SAFETY: `self.ptr` is valid.
> +        unsafe {
> +            (*self.ptr.as_ptr()).phys =3D phys.cast();
> +        }
> +    }

[Severity: High]
Can safe Rust callers pass an invalid, short-lived, or non-NUL-terminated
pointer to AllocatedDevice::set_phys()?

The input core does not copy dev->phys and dereferences it as a
NUL-terminated C string during registration in input_dev_uevent() as well
as when reading /sys/class/input/inputN/phys, /proc/bus/input/devices, or
handling the EVIOCGPHYS ioctl, which can cause a use-after-free or
out-of-bounds read.  Like set_name() above, set_phys() should take
&'static CStr instead of *const u8.

[ ... ]

> +    /// Sets parameter limits for an absolute axis.
> +    pub fn set_abs_params(&mut self, axis: u32, min: i32, max: i32, fuzz=
: i32, flat: i32) {
> +        // SAFETY: `self.ptr` is valid.
> +        unsafe {
> +            bindings::input_set_abs_params(self.ptr.as_ptr(), axis, min,=
 max, fuzz, flat);
> +        }
> +    }

[Severity: High]
Can AllocatedDevice::set_abs_params() write out of bounds when axis >=3D
ABS_CNT (0x40)?

Unlike input_set_capability(), input_set_abs_params() does not bounds-check
axis:

drivers/input/input.c:input_set_abs_params() {
    ...
	__set_bit(EV_ABS, dev->evbit);
	__set_bit(axis, dev->absbit);

	input_alloc_absinfo(dev);
	if (!dev->absinfo)
		return;

	absinfo =3D &dev->absinfo[axis];
    ...
}

Because dev->absbit and the kcalloc(ABS_CNT, ...) array in dev->absinfo are
only sized for ABS_CNT elements, a safe Rust caller passing axis > ABS_MAX
corrupts memory past dev->absbit in struct input_dev and past the end of
the heap-allocated dev->absinfo array.

[ ... ]

> +impl RegisteredDevice {
> +    /// Reports a binary key/button press or release event.
> +    pub fn report_key(&self, code: u32, value: bool) {
> +        // SAFETY: `self.ptr` points to a valid registered `struct input=
_dev`.
> +        unsafe {
> +            bindings::input_report_key(self.ptr.as_ptr(), code, if value=
 { 1 } else { 0 });
> +        }
> +    }
> +
> +    /// Reports an absolute axis coordinate.
> +    pub fn report_abs(&self, axis: u32, value: i32) {
> +        // SAFETY: `self.ptr` points to a valid registered `struct input=
_dev`.
> +        unsafe {
> +            bindings::input_report_abs(self.ptr.as_ptr(), axis, value);
> +        }
> +    }
> +
> +    /// Synchronizes input events (signals completion of an event packet=
).
> +    pub fn sync(&self) {
> +        // SAFETY: `self.ptr` points to a valid registered `struct input=
_dev`.
> +        unsafe {
> +            bindings::input_sync(self.ptr.as_ptr());
> +        }
> +    }
> +}

[Severity: Low]
Should the small wrapper methods on AllocatedDevice and RegisteredDevice
that set struct fields or forward directly to C bindings be marked
#[inline]?

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 4d5c96ddc49c7..559fc79b1e820 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -310,3 +310,4 @@ pub fn file_from_location<'a>(loc: &'a core::panic::L=
ocation<'a>) -> &'a core::f
>          c"<Location::file_as_c_str() not supported>"
>      }
>  }
> +pub mod input;

[Severity: High]
Does building the kernel fail at link time when CONFIG_RUST=3Dy and
CONFIG_INPUT is m or n?

CONFIG_INPUT is a tristate Kconfig symbol, and include/linux/input.h does
not provide inline stub fallbacks for input_event(),
input_allocate_device(), input_free_device(), input_register_device(),
input_unregister_device(), input_set_capability(), or
input_set_abs_params().  Because rust/kernel.o and rust/helpers/helpers.o
are always built into vmlinux, leaving pub mod input; in rust/kernel/lib.rs
and rust/helpers/input.c unguarded causes undefined symbol references
during vmlinux linking whenever CONFIG_INPUT!=3Dy.  Gating pub mod input;
with #[cfg(CONFIG_INPUT =3D "y")] (or #[cfg(CONFIG_INPUT)] if modular calle=
rs
are supported where appropriate) and guarding rust/helpers/input.c with
#ifdef CONFIG_INPUT avoids the link failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106191714.3340=
55-1-harepro29@gmail.com?part=3D1
