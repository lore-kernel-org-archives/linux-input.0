Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034203;
	b=Pzi6QfnkEamD6SJ6BdKAGNSVAS3ray5sat6rvWbLsBb3XFH84zjh5CVwajBpHa6CQbtl
	 ej2hiCg9NBOBbfBR8mUGjCxSHpxWFIdxrxD/X/zjdEfhMamBMCIq+jUGVsibnxcNSqOZM
	 H5RcYzEI0IUPkDL6YgKk3K6Qia9C52EbeoN4e0AtGI9xDppmg1euQiUao2teGdZ676RGW
	 TtN0kuP4G8NbuKFJ8TbHrFOmQsx8IPSO3mEXwIeKV+5vVfhKJgJYYgITqJbqY4WnarDyN
	 jbYGCiOjHxE44A4A1H75x3PASDsH4rBXtBb6+Oou8GmjKvECdQy6ZuC9w2YVoVZgx9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034203;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fgXfnDlgbVF7FluVW3/BVFkMI63apPUfHhS+YjkulU4=;
	b=HXjOThvSRrIMf76wx0rLPgDK6TIqZfO+0Ve7w63xSKdNmvmyGWFmuxkmX9AzXazcTkqw
	 KfRaRbl7z2l06T537zlZ1b+r8i9wxftpYA1XdbOlqG2gHZHtKqCHSHYIHnpMVnvo+S+gV
	 TNXChyE4zFd6Qa3Pc/QweMSUPMe0iQ4MfNBwDh32/fg5zuqu9E7qUVnihRoLHPKXFGP4j
	 ByVfCn7fzldiVl3MfR0PEhke+39nGvHch5/FlnEHGcakO5pl+w5k2srAzZzOr7rc7pTD1
	 B1eOOexeQs/RmzDJpuy7ve6xYn/T+EibFluVEbCu2CrMhxF1rpSvbmNMc3N1TTRyLxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i9/sRALU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411B606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9/sRALU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D01F008A2;
	Sat,  7 Nov 2026 06:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794034203;
	bh=fgXfnDlgbVF7FluVW3/BVFkMI63apPUfHhS+YjkulU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9/sRALUy6aafGySO5qHQ5TeTEEZlmx/hKLFtKF0C/2v35WXAxSqkPs8Rb64C6Mc0
	 C00/55P4277i2slIkK125XFIUta8iNZ0yFSpNHIo/7tOENZwE284rcj+57eepQpXAm
	 KwZebntmTN7ACBzkrdtBDDB4cRkQZ04/G+TUx6aRnpWNapl5hLbKNBJV5Ku+3ry0IA
	 c3d9909CcaNUdKpwSJtFeXKFeK0315tSTqaFpblKzaWO1X61xvz+CYh6Btr8x04Tzs
	 ZKsSku9MDSVU48QRmLh71O3xJZE8AAW1Z9LQoTy1hON59xUeKtChLNVpXaaOWxHKLn
	 BDfsecpQhlvUw==
Message-ID: <sashiko-outbox-202671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] rust: serio: add serio bus abstractions and port
 Gravis Stinger driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vecheslav Filatov" <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261107063520.489958-3-harepro29@gmail.com>
References: <20261107063520.489958-1-harepro29@gmail.com>
 <20261107063520.489958-3-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 06:50:02 +0000
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
- [High] rust: serio: non-existent crate::bindings::irqreturn::IRQ_* in
  mod bindings
--

commit e108571e336aa2835a298065109700e94f7a4ab9
Author: Vecheslav Filatov <harepro29@gmail.com>

rust: serio: add serio bus abstractions and port Gravis Stinger driver

This commit adds Rust abstractions for the serio bus subsystem and ports
the Gravis Stinger serial gamepad driver to Rust.

> diff --git a/rust/kernel/serio.rs b/rust/kernel/serio.rs
> new file mode 100644
> index 0000000000000..dc0de5f527158
> --- /dev/null
> +++ b/rust/kernel/serio.rs
> @@ -0,0 +1,341 @@

[ ... ]

> +mod bindings {
> +    pub(super) use crate::bindings::*;
> +
> +    #[allow(non_upper_case_globals)]
> +    pub(super) const irqreturn_IRQ_NONE: crate::bindings::irqreturn_t =3D
> +        crate::bindings::irqreturn::IRQ_NONE;
> +    #[allow(non_upper_case_globals)]
> +    pub(super) const irqreturn_IRQ_HANDLED: crate::bindings::irqreturn_t=
 =3D
> +        crate::bindings::irqreturn::IRQ_HANDLED;
> +}

[Severity: High]
Does this fail to build when CONFIG_RUST=3Dy and CONFIG_SERIO=3Dy are enabl=
ed?

bindgen generates crate::bindings::irqreturn as a type alias for c_uint
and exposes the enum variants as top-level constants
crate::bindings::irqreturn_IRQ_NONE and
crate::bindings::irqreturn_IRQ_HANDLED (as used in
rust/kernel/irq/request.rs). Referencing crate::bindings::irqreturn::IRQ_*
fails to compile with E0599 and shadows the existing top-level constants;
importing crate::bindings directly avoids the need for this wrapper
module.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107063520.4899=
58-1-harepro29@gmail.com?part=3D2
