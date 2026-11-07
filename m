Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048216;
	b=aH1csWF1wLdzcnb28mvqYd9GTdaRTv8djmFyyudYKlXaZN9R3atyKSeBWtUP/yxWxFW4
	 WE9QqMPoBLKIQNlq9/oqoX/2BFL2TYh0+kMYQjpC3nsMp1CFYLz1tX28V3d3t7Ir2Wv6X
	 NA/SbTiGcHozkvy7HAeOQGBUT688LWxrqlXUxeHrF+WJBu2JK3y7tVdnpWccu3J7W0tGd
	 HaOOsAjQnujrgPdLxWlt8/moEdA/6D6A53bpji/KdGq8igbEPW8yeZSgM8Anyze7rlJKg
	 t1sP3+dB/ByIAsnJ39UTn1BixptyCrzO7GA73YTU8jrESt5qpGw7vgUI/LDVriWbBRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048216;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=giPbV5+A3C01/xSiBJecZKKff0VXrYHGJi91ofl0dcM=;
	b=SwwxjOzDUFl94joHQGP10yY5gUL7pBlHZBo4PvthZdSz4o5ins40V1t0klzvudOGN1Y0
	 9NvySU8jNhi8ki5ZUt3EOmtPTlAAgL5Et+Uaz3TGh/ep9gQx2NxzkQq7N3dHkFoWdu3ki
	 blnKrsNZKdbyO4nOBlUOnChRnlYbwagGit4mfOvTJ3lZ7PZ4f3Eor/SDqIsE+aNzxbkZ5
	 LoSSMSg8MSkiL+k7hExg2zv1CfITWKb8+kCJjiculjVM0oiWCVAYrjrQtCJUgii/jPt+b
	 YMBkVarO77WOUPlowV1X8XQ05ZDiYJcaqbiSYHQ67dJF0WcxUFBWpjGZ4FKgQryaPCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Elg2fRqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E462606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Elg2fRqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B9C1F008A2;
	Sat,  7 Nov 2026 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048216;
	bh=giPbV5+A3C01/xSiBJecZKKff0VXrYHGJi91ofl0dcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Elg2fRqWUXgqJ6OiRoBpMbJxRyrQvVQ37xx8Zc7AA/daq7gfWBL2kndX/OsH0r4kc
	 cHKnnRALyfHvGfJfIiFNOwIoIwYk6gmYTK+TjzQCWFA6rQYoOFL9IVN/JS1gt4aXli
	 uYU9EL81sBKrcWlrLoF5FSfq01760Bl9M4IYt0V2Hf1eGaPqc/gkwm0YoYS4cvIqrI
	 faJt8goxvspCNVX1JK6iL90XVQz9tEpndABsEmBDXBrl2lACIvJUIyaOgpe7ToYxoL
	 g6AztE/t647UpWMWcLy6Gyjzxz/GCuYLQs+i4UeJEPGXott+sAeXmgjtNFg/Hrm49A
	 I6/7F+kEeuqUw==
Message-ID: <sashiko-outbox-202820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vecheslav Filatov" <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261107102106.546041-3-harepro29@gmail.com>
References: <20261107102106.546041-1-harepro29@gmail.com>
 <20261107102106.546041-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:43:35 +0000
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
- [High] rust: serio: non-existent bindings::irqreturn::IRQ_* paths
  break build
- [Medium] rust: serio: unsound Device<Bound> cast in
  Registration::connect_callback()
--

commit 8b9bc178d0ee71cd5694b16b76519c8a7ef9200e
Author: Vecheslav Filatov <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports
the Gravis Stinger serial gamepad driver to Rust.

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..4e16917ddd70c
> --- /dev/null
> +++ b/rust/kernel/serio.rs
> @@ -0,0 +1,336 @@

[ ... ]

> +pub use crate::irq::IrqReturn;
> +
> +#[allow(non_upper_case_globals)]
> +const irqreturn_IRQ_NONE: bindings::irqreturn_t =3D bindings::irqreturn:=
:IRQ_NONE;
> +#[allow(non_upper_case_globals)]
> +const irqreturn_IRQ_HANDLED: bindings::irqreturn_t =3D bindings::irqretu=
rn::IRQ_HANDLED;

[Severity: High]
Does this compile when CONFIG_RUST=3Dy and CONFIG_SERIO=3Dy are enabled?

bindgen generates bindings::irqreturn as a c_uint type alias with top-level
constants bindings::irqreturn_IRQ_NONE and bindings::irqreturn_IRQ_HANDLED
(as used in rust/kernel/irq/request.rs), so bindings::irqreturn::IRQ_NONE
and bindings::irqreturn::IRQ_HANDLED fail to resolve with E0599.  Dropping
these local constants and returning bindings::irqreturn_IRQ_NONE and
bindings::irqreturn_IRQ_HANDLED directly in
Registration::interrupt_callback() avoids the build failure.

[ ... ]

> +/// Trait implemented by serio device drivers.
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

[Severity: Medium]
Is it sound to pass &Device<device::Bound> to T::init() here?

Because Device<Ctx> implements AsRef<device::Device<Ctx>>, safe code in
Driver::init() can obtain &device::Device<device::Bound> and register
managed resources via Devres::new() or devres::register().  However, manual
driver binding through sysfs drvctl calls serio_bind_driver() outside
really_probe():

drivers/input/serio/serio.c:serio_bind_driver() {
	...
		serio->dev.driver =3D &drv->driver;
		if (serio_connect_driver(serio, drv)) {
			serio->dev.driver =3D NULL;
			return -ENODEV;
		}

		err =3D device_bind_driver(&serio->dev);
		if (err) {
			serio_disconnect_driver(serio);
			serio->dev.driver =3D NULL;
			return err;
		}
	...
}

If connect_callback() or device_bind_driver() fails in that path,
devres_release_all() is never called on &serio->dev, leaving any Devres
registered during T::init() unrevoked on an unbound device and causing
later really_probe() attempts on that port to fail with -EBUSY.  Passing
&Device<device::Normal> (or &Device) to Driver::init() prevents callers
from registering devres resources before binding completes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107102106.5460=
41-1-harepro29@gmail.com?part=3D2
