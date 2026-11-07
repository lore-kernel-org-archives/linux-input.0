Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065726;
	b=4pQkFrDXlWlC4Cyyp1eP4EoN29+2AUpQXq6pzjA3zRad+yr+vB023q47SoXK6FOft0jj
	 +hov9E04Wd/YjzcQ+DoDB6K1nA5Ma1Ied+hf7ItGyGyn/7kdfjoupsrUOukP4rhsmKPmt
	 +rBb1NR4DKdTN9KynQ8rZuCmkqpPc+fSCna/+vlZwCwLRGLPGwuJDmFsXTDM5wNDdD7Jh
	 VWMCZCZd4eJJX6s2Sj+DaARo9L1feIQXhzgZ3g4jz7m1ufnr/SBCcOupCSq99oCGGOi4/
	 YXfvRVgNAaLpYnZeuJ1PNiyoa5C6BJ+jYI0FO+DFc2k15F8RaeqpT+NIb11N/poKlrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065726;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8cKDtg2vvKD3nM4ZLejQ3NF0UdP9W/NjGaJcslnrOqY=;
	b=fZAbTtKIkI8eYTKvPTLI8cX6qC19m/Hat/HhsjWXYrh/2bXbye3Brc4xiXkxC+fYHiJN
	 n91k2iCZ89QrWVRz9jITFlbTHxpRqJulxVXxsUoQiYCnfi2U5tu1EQVuUUyckXhDXINfi
	 AQ78CIZcvpZRkWiH9z9ft9NxdPpQIzlMwZaLr82Z5SwLhoOPKS8xeyYYP7wt7N/ZVRCad
	 2pj9UUNF7AxOTF7qdexcFWpx2/UdXz7KtWCZXrJofmS1pJzX/BzMaCIZ2ixIWBXBIBHcD
	 orSWFSmaadOKpPK8KGpDn6JsfEt96y6IoKanolVWtHs0A9cHeEKN6NWeAgbf4kAtiNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOWOYgsS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52E606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOWOYgsS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940A01F0089F;
	Sat,  7 Nov 2026 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794065725;
	bh=8cKDtg2vvKD3nM4ZLejQ3NF0UdP9W/NjGaJcslnrOqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOWOYgsSB+3crY3Ae/gW4z1B8anYUzfome134px3l6IG5oFTE4UAy+1uX78UzgrQJ
	 4Z1ERN+OgaxjQZLiZDGlbhsJIaP2Uoo1sKBVrZEfuQUAxGVro1f0MrrLGh26sL7rXk
	 KQq3CL7P4TUP9fOO3a6Zwri+F0XgAwXOf0WZmwoLefIDud+junfJQ9Rp55Oc8StjDa
	 1fkv1Ma0L8CY6TEIRAG2xHyNN/XoF23zLQp67QsQkfaOhdB9tY5L+7LGS4GxIC7CPy
	 kXYu/fF9kaUZ8i5KPYZtjwuYfzLsaSO/vDmg0KfZ86Tj1c2bfF3IgxFUSnHO/US0Mk
	 IosG53uzbYUpw==
Message-ID: <sashiko-outbox-202996@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/2] rust: serio: add serio bus abstractions and
 port Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vecheslav Filatov" <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261107151238.607451-3-harepro29@gmail.com>
References: <20261107151238.607451-1-harepro29@gmail.com>
 <20261107151238.607451-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 15:35:25 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] rust: serio: invalid irqreturn constants in
  Registration::interrupt_callback()
--

commit f585fad088f2bb569ece89cb8cd21210ef843ac9
Author: Vecheslav Filatov <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports
the Gravis Stinger serial gamepad driver to Rust.

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..add6dc47bdbf3
> --- /dev/null
> +++ b/rust/kernel/serio.rs
> @@ -0,0 +1,331 @@

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
Does Registration::interrupt_callback() fail to compile when CONFIG_RUST=3Dy
and CONFIG_SERIO=3Dy?  bindgen generates bindings::irqreturn as a type alias
for ffi::c_uint with top-level constants bindings::irqreturn_IRQ_NONE and
bindings::irqreturn_IRQ_HANDLED (as used in rust/kernel/irq/request.rs),
so bindings::irqreturn::IRQ_NONE and bindings::irqreturn::IRQ_HANDLED do
not exist.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107151238.6074=
51-1-harepro29@gmail.com?part=3D2
