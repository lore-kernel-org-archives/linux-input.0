Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061671;
	b=2PKG5rNi+p3/6haqNd2Z5LlCcTxzaXEhhZlYwSdjIeIw1NTynU49DjoQC68kZW6qc6t0
	 1Ehq3Ni0cH1rktMobTdejHNz7gO5ye9cJ1KDawfX63EqtQ2APVwdy9J8S2eWbG4t86xio
	 lWicAfTDSIEAHo+O64eovBEEagRzLsmls2CGHBzhhgvQ0TXSLOqcwvBUiC3ocYSjUDwJd
	 ZjQckh7AqmB1d6unNzZYJHT4jSIcoz9fMBtnWww3pj67ALPM3KXXMEJAZegSa9w+QauC6
	 iiPZnGqj4vQeHGtzZYaz2YuSaDXCu84sKpzTnxCrbUAk7EfCkVZdnaQdqjGXG5Uy75g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061671;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/5L6ML2Btg/5xClL9djgTbo4vdv09qPDOCNhoqmtZlw=;
	b=VcJotmB0HJBHo+1HNEoVJZhLoI3i8amwxLmAiTo6D/3stxhqGw5Mm+eIH5qqKVbbOu5p
	 72dgRK2MYrTC5nDiMxuZ6IYjcFuy45c3Drxh4eMQardI1My2dxKf5DPUmc1/Q8JqHSyKi
	 oh14ao+u6dlNnTY9aMGzOEOUMl+fn0nDYYB2WiJTAEWG7WFUFq/bUsJ8DlbugW2pIrqEz
	 vHR+oiyLG6E2B56NJfaxTvEPNuhR1LH/Nqt3CJ06GebthFuwPLVvbKjuflUxiIMDdI8zZ
	 Os/BQqbfZy+OTGyrcCRPSbY+vG8zf/oSrJ9gvGpDT6+Yv9+G9gfaCAxLQ3nYZIVWtag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnTayqyr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB8606A32D
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnTayqyr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B813D1F008A3;
	Sat,  7 Nov 2026 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794061671;
	bh=/5L6ML2Btg/5xClL9djgTbo4vdv09qPDOCNhoqmtZlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnTayqyrBLKEAcy2mHMYSomxaTLGJC0eGZD7bkpXaPaqnWywW7xXDtqzZnr2Gl00O
	 lKbhIMewmb+zsMTeq44fMe1Z2bnjVUda1w3RTQi6LSKwsM3kxYL8bwJYL2VFUKABm6
	 9MFwxVzZ/Em96ii33F5bznMyjQaAUCQC5NkasgfF3Sr97lw23DjOTBXpxse3A2lxr1
	 pXdCOpQhRnGMdFBsAl/nJFB7IH3VOs0oIsle0EC+eDBYI2aOj3yVbamcxOM+C9XWtY
	 I2+kr1vCqOZYoirjB25K89SI5NQq3EZUlVw5oOWi2rVUOi0FMX035Yh2BzG5mbsYFU
	 AwQd06OkT4xvQ==
Message-ID: <sashiko-outbox-202953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] rust: serio: add serio bus abstractions and
 port Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vecheslav Filatov" <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261107141156.591711-3-harepro29@gmail.com>
References: <20261107141156.591711-1-harepro29@gmail.com>
 <20261107141156.591711-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:27:50 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] rust: serio: invalid irqreturn constants in
  Registration::interrupt_callback()
- [Medium] rust: serio: unsound Device<Bound> cast in
  Registration::connect_callback()
--

commit 2cd8430f1d5375be91eaa8f7c615434521c81d61
Author: Vecheslav Filatov <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports the
Gravis Stinger serial gamepad driver to Rust.

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..a1b29965e8708
> --- /dev/null
> +++ b/rust/kernel/serio.rs

[ ... ]

> +pub trait Driver: Send + Sync + Sized {
> +    /// Context data stored per connected device instance.
> +    type Data: ForeignOwnable + Send + Sync;
> +
> +    /// Pending resources allocated during probe to be published after t=
he port opens.
> +    type Pending;
> +
> +    /// Published device handle created after the port opens.
> +    type Published;
> +
> +    /// Device ID match table.
> +    const ID_TABLE: IdTable;
> +
> +    /// Initializes driver data before the port is opened.
> +    fn init(dev: &Device<device::Bound>) -> Result<(Self::Data, Self::Pe=
nding)>;

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
> +        // 1. Initialize driver data before port is opened.
> +        let (data, pending) =3D match T::init(dev) {
> +            Ok(d) =3D> d,
> +            Err(e) =3D> return e.to_errno(),
> +        };

[Severity: Medium]
Is it sound to pass &Device<device::Bound> to T::init() here?

Because serio::Device<Ctx> implements AsRef<device::Device<Ctx>>, safe
Driver::init() implementations can obtain &device::Device<device::Bound> and
register devres resources via Devres::new() or devres::register(). However,
when binding manually through sysfs drvctl, serio_bind_driver() invokes
connect outside really_probe() and does not call devres_release_all() on
failure:

drivers/input/serio/serio.c:serio_bind_driver() {
	...
		serio->dev.driver =3D &drv->driver;
		if (serio_connect_driver(serio, drv)) {
			serio->dev.driver =3D NULL;
			return -ENODEV;
		}
	...
}

If T::init(), serio_open(), T::start(), or device_bind_driver() fails in th=
at
path, any devres resource registered during T::init() is left unrevoked on =
an
unbound device, violating Devres revocation guarantees and causing subseque=
nt
really_probe() attempts on the port to fail with -EBUSY. Passing
&Device<device::Normal> (or &Device) to Driver::init() would avoid exposing
Bound-only APIs before binding is guaranteed.

[ ... ]

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
> +        match T::interrupt(&mut borrowed, data, flags) {
> +            IrqReturn::None =3D> bindings::irqreturn::IRQ_NONE,
> +            IrqReturn::Handled =3D> bindings::irqreturn::IRQ_HANDLED,
> +        }
> +    }

[Severity: High]
Does interrupt_callback() fail to compile because bindings::irqreturn::IRQ_=
NONE
and bindings::irqreturn::IRQ_HANDLED do not exist?

bindgen generates bindings::irqreturn as a type alias for ffi::c_uint with
top-level constants bindings::irqreturn_IRQ_NONE and
bindings::irqreturn_IRQ_HANDLED (as used in rust/kernel/irq/request.rs), so
resolving IRQ_NONE and IRQ_HANDLED as associated items on bindings::irqretu=
rn
fails with rustc error E0599.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107141156.5917=
11-1-harepro29@gmail.com?part=3D2
