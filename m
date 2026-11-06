Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005076;
	b=CzCVXKc7IlhTOUvEgwgEAJ40QKE5Q1/yjWb4QxCOGK2zdExX1ktTwhpi0qDNp0LIfb3z
	 CXBVpfqAWvIy7HwudH6VcxJRjxsqZ06/nAr1TOrtRN4gCai1Thy3yvkloMzjS8O0XkP1z
	 okS4WPdVG2sbv9uehii0RtpSm/7tYSK3qLoroAejydoM3h2xGAtqdSHJ1Pc7U+D3PyNQI
	 fEGLL6L1arfOdla0BPOkAG3BiBxRskH/t3GNARToaS0ev5A4Toh2/WI6rGFzNW+YNIsF+
	 7fgVdX4uVEZ6EPRZzdDSvK2L/mNvRXF+PYeAg8YZj2pSswOuQBKcw0yJa1iCmBHaOiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005076;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ei8PMMVYPr3xOuH4dFopZejPL+/7Tb3aCd2JolTCf8E=;
	b=NXYdUZ3UE/+steox2c6/QthULZMkwBSGRVFXRrnjk67W3uYdNR5BcbYWHYNaOTuwuv8L
	 fbMj6oyzLCJ6gTc8vT+MHWva0OJvw+JL2YtEGp/9LO3RIDiVYaq8jq3KEB5CIwujoq3LE
	 BohC8y/yPzWoiLGUsq7m81h8WLUKQ/+U9SKPHGvu69mgf18q18qE80l8LvhUzO6pNIqJa
	 Ta+yK6alW1d1jJ7JpaGPgtvtVIslCl8SiTJBk8Y8CszACjtHO8pBJwtiWWPJ1htnGdd7K
	 ovv3QzYcAaxdQtFWpi8DFdThWIz2PzQgLni4ISOgf+Zqykbr3N49r59tzXwgPojTwxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oziuhSef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60740606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oziuhSef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51851F0089F;
	Fri,  6 Nov 2026 22:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794005076;
	bh=Ei8PMMVYPr3xOuH4dFopZejPL+/7Tb3aCd2JolTCf8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oziuhSef2oYJeCCMmqwCiParUwzDGFL+lqHgBSGPQsBrRsbl55Yhy8nuI0tVdtrX8
	 TmDHCJu51BApPzowIxfelQZTemYJwXqR6mtz1Dg8l97vXWy/s9xOq2NcTL2OcOmlRY
	 h+QBxcnI7N+TbJ6ZIkclQ5QlppuXl2fpJgc7BGJCZlxpV6atiZLE4j2Vs2nfcHRY0Z
	 KADI2TspgOxuwj2WxjvQULG8Djk1/NxH9qp/XVB0OQeHYaCfNcCg8vYsjxZO/jdctA
	 TdTnhMLRcaM49BqINYwWXR0GNSTeEnAowkiw7lCViQ+6Uq57el1EJ2SK3J8/pn/07Y
	 +GGLRy22LMhaQ==
Message-ID: <sashiko-outbox-202339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106223033.452853-3-harepro29@gmail.com>
References: <20261106223033.452853-1-harepro29@gmail.com>
 <20261106223033.452853-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 22:44:35 +0000
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
- [High] rust: serio: invalid irqreturn constructor call in
  interrupt_callback()
--

commit 80f5c0b2557c72b097feba2779e0c1b32a6bd3c7
Author: clicedvly768 <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports
the Gravis Stinger serial gamepad driver to Rust.

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..aca0b5a4f8742
> --- /dev/null
> +++ b/rust/kernel/serio.rs

[ ... ]

> +    unsafe extern "C" fn interrupt_callback(
> +        serio: *mut bindings::serio,
> +        data: c_uchar,
> +        flags: c_uint,
> +    ) -> bindings::irqreturn_t {
> +        // SAFETY: `serio` is valid.
> +        let raw =3D unsafe { bindings::serio_get_drvdata(serio) };
> +        if raw.is_null() {
> +            return bindings::irqreturn(IrqReturn::None as u32);
> +        }
> +
> +        // SAFETY: `raw` was created via `into_foreign()` in `connect_ca=
llback`.
> +        let mut borrowed =3D unsafe { <T::Data as ForeignOwnable>::borro=
w_mut(raw) };
> +        let ret =3D T::interrupt(&mut borrowed, data, flags);
> +        bindings::irqreturn(ret as u32)
> +    }

[Severity: High]
Does calling bindings::irqreturn(...) as a tuple-struct constructor break
the build when CONFIG_SERIO=3Dy and CONFIG_RUST=3Dy are enabled?

bindgen emits bindings::irqreturn and bindings::irqreturn_t as type aliases
for ffi::c_uint rather than a newtype struct, so invoking bindings::irqretu=
rn
with function call syntax fails to compile with E0423.  Casting the values
with "as bindings::irqreturn_t" avoids this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106223033.4528=
53-1-harepro29@gmail.com?part=3D2
