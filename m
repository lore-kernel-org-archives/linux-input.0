Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794036169;
	b=kq5s4NLwzePSB+D7bdz9AmKZw3egtxSnNUCF0GixqAcZ0MHRiD7dTvLdo7pcA6kyXgSX
	 FcSKsFT+IbMcbIwaZykTMZMda1dADbWyyaoaEORwydZbxNrbo/ccisZEhpJ6/p5LQ706p
	 SYxiZ/zpamPaCTUKw+IH61pumVZp8e4TWPYzf65tTRinJ7L7q44VMBJHaLmTyo4a48yLO
	 a5kEOwFyqC53K2hnW792MzMaHZst+07qXTWwCPtRRFnCfu9/r/S1A8UA/jq3xvjSxXxI2
	 4N7jgKxGNeW0G96uRDRAWLWpT8fhLk8TNZOQX34UvC6NtLG3bqYvZJ8ZUk9inDI/M5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qbH8EttvH59RugU4BW+FC+QS9ahAoLb2gTdzk4uHk6Y=;
	b=D1HN4M+TlKPa4gzlZ5+gSiNxCnuYBS66Hjlqs8dtjLx4QD9ChT0SMQXRX0Ny+sMSgKlN
	 Liq9HGU5nyoDbDd30VNmEXLwY4UFst4KnuBYqa7roF7YzqgV5ZA7GrCH/sbqzgMfe7ymi
	 3AseuDRaEjQHGsznAG5NrdB9J3+GN3oZavsfY+uXBUmMVihBJkcIVwC0m0hVa+a8ekCaf
	 8Z9nElLzTTbQ5uM/oDWHPc4pCyM6CGmNIL5sdPW6A3sC4aYdj7s3Q8vkT+hgW7QJuihlX
	 jc9AQpPDzyjYSJurgFijk1DhQK9L3I3dHxxJvtpjgFeA6prwibnViNwFEvjL8iRHTaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVnp1BXW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C67606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVnp1BXW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1B21F0089F;
	Sat,  7 Nov 2026 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794036169;
	bh=qbH8EttvH59RugU4BW+FC+QS9ahAoLb2gTdzk4uHk6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVnp1BXWGUnvw3cI7qBnbDPwrS20NPQtdOiDbvZMKeQxEp3OeSILTW32AZ6lWygM8
	 NpRxFxcLulEEuVz5O8eGt7R9+zBTlJG41ZZ+fzyF1X3vN+mnjjdQto8qLTV+Farkqg
	 mNfL9rPq69Ay/q3XeC6Zc6V2W6chMtZw5WUjvCN1Qc+smtH5mDT8SwCqUuWzlaQE/j
	 C0bDtXUA/959CX5Im3l+KGH9RX5rJZKBbZFJ2NPgPU24U15SMHdoeRTAeqHGiS/DNM
	 Ei45slkBvMHGzPs7+hop1Y8ztX1cE4z10zLvlURb3OVESvdX2tWNk0Lq+Q24u1m2y1
	 wCK53Q188gcdA==
Message-ID: <sashiko-outbox-202704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vecheslav Filatov" <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261107070010.500128-3-harepro29@gmail.com>
References: <20261107070010.500128-1-harepro29@gmail.com>
 <20261107070010.500128-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 07:22:48 +0000
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
- [High] rust: serio: non-existent bindings::irqreturn::IRQ_* paths
  break build
--

commit 7de59dece60ff6273292c2ada6f83924d551c7fd
Author: Vecheslav Filatov <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports the
Gravis Stinger serial gamepad driver to Rust.

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..4e16917ddd70c
> --- /dev/null
> +++ b/rust/kernel/serio.rs
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
Does this fail to build when CONFIG_RUST=3Dy and CONFIG_SERIO=3Dy are enabl=
ed?
bindgen generates bindings::irqreturn as a u32 type alias with flat top-lev=
el
constants bindings::irqreturn_IRQ_NONE and bindings::irqreturn_IRQ_HANDLED
(as used in rust/kernel/irq/request.rs), so resolving associated items
IRQ_NONE and IRQ_HANDLED on bindings::irqreturn fails with E0599.  Dropping
these local constants and using bindings::irqreturn_IRQ_NONE and
bindings::irqreturn_IRQ_HANDLED directly in Registration::interrupt_callbac=
k()
will fix the build.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107070010.5001=
28-1-harepro29@gmail.com?part=3D2
