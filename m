Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187873;
	b=M+PScHyYlPMCfrIivoMcUGKfuKGm/Vw/zfzvaMK9kc35hmJ4OnhPy8WXU/jrtOX5r0ob
	 OfEV09c8uwI47m5Inez+ru63GgaDpsuh5sXJYUx1tnjmhLoWIcj/iuui1Ch3AhHHciw7W
	 CepgHCVttDgkymY7o1w7ryA8yDWc9xSvl/4t4KGOeN6qxeLu8DR3VNGKLEQtl1JZH+Ql8
	 4Jr+4eYUZMJVS/1r/dRvq5Ey73laymneM+JQtbGVsA8wBslyVjKjIiwzldQKU1kEyRZDa
	 aeY0st7sai3obWduL4YXEkfReFdZjkCRxtAZYXcBXin5AqPdmaqpP5nTvkzJv1M0WVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2FMMY3uG/SZyA6QFetnUQeI/P1ljJJ/yhhk5MW6M8Tg=;
	b=vfDqYhojXwEYcwtMVJjEmUv5qqfXGRo42KUp3lteOEe/epR3ZqLxv3zpnE8nUMPkMl61
	 BH+D71VmKIgJ1couYZg88snbNRcII7IAfD8omnzfVhTif/2WgfHheYgr3uMUrAe7c56M6
	 f92h/Ly+qYJcWoNhtG+795QQRIfvlSl6XpE8gFEPLRdP2PwautmdIFmwSTyWkU53B9kwh
	 KK6pLRRdz9Is35Qbo5sBgCwIhkcqV6NFyJ7Dem/C+QvxBiFE9KpyNzETscP/U5V5ZHWYy
	 qkd3ffTFFFXBsQ8IHllHogVGLbxoeVM7aKByf5pQPNtQUNhxGZYL7vQfPkZPF6TpJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ViJ5/dMz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D35606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViJ5/dMz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EB61F0089F;
	Mon,  9 Nov 2026 01:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794187872;
	bh=2FMMY3uG/SZyA6QFetnUQeI/P1ljJJ/yhhk5MW6M8Tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ViJ5/dMzGYd6IhdI3jBSwvhuNGkW0Sfeg4UlKtlBI2dau7Jxg59WVC2wKMnVAi3qq
	 /CL3NDQumrahtkY3MA8lATx9wMBi3TquS6nKT6OSHvz1wM5nvTYvCBDNriF5m0AeCo
	 SFpV/4YRFIPP+bvTcG8BSLuKVf6/vvjOloL5bGJrhCnNAVmh6kp/RkulXsQM1JMgnl
	 WFLa/5WvbIU9VC3SprdF+GIpS3mf3MOOzRC3l0gClGu1H45MQEFm0wAvrgAX0PhUbf
	 FpeKLXmkBEKHaE0s4zL/MHEFYEFiPZJdMLWR2d2+oyV3DCX/UVCWp8yUO90OnChywa
	 x77n+l9APvyEw==
Message-ID: <sashiko-outbox-204298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: sidewinder - use scnprintf() for the port
 names
Reply-To: sashiko-reviews@lists.linux.dev
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109010548.438699-1-xujiahao@cmss.chinamobile.com>
References: <20261106033300.3439313-1-xujiahao@cmss.chinamobile.com>
 <20261109010548.438699-1-xujiahao@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:31:11 +0000
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
- [High] Input: sidewinder - 64-bit division in sw_3dp_id() breaks
  32-bit builds
--

commit 126f9830817fff924c0c3fe1b867c22b8b4a2692
Author: xujiahao <xujiahao@cmss.chinamobile.com>

Input: sidewinder - use scnprintf() for the port names

This commit switches sw_3dp_id() and sw_connect() from snprintf() to
scnprintf() to silence -Wformat-truncation warnings.

Link: https://lore.kernel.org/all/20261106033300.3439313-1-xujiahao@cmss.ch=
inamobile.com/

> diff --git a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick=
/sidewinder.c
> index 7f37d18c8477a..bca81df19da44 100644
> --- a/drivers/input/joystick/sidewinder.c
> +++ b/drivers/input/joystick/sidewinder.c
> @@ -535,12 +535,12 @@ static void sw_3dp_id(unsigned char *buf, char *com=
ment, size_t size)
> =20
>  	pnp[7] =3D rev[8] =3D 0;
> =20
> -	snprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
> -		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |		/* Two 6-bit values */
> -			sw_get_bits(buf, 16, 6, 1)) / 100,
> -		(int) ((sw_get_bits(buf, 8, 6, 1) << 6) |
> -			sw_get_bits(buf, 16, 6, 1)) % 100,
> -		 pnp, rev);
> +	scnprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
> +		  (int)(((sw_get_bits(buf, 8, 6, 1) << 6) |	/* Two 6-bit values */
> +			  sw_get_bits(buf, 16, 6, 1)) / 100),
> +		  (int)(((sw_get_bits(buf, 8, 6, 1) << 6) |
> +			  sw_get_bits(buf, 16, 6, 1)) % 100),
> +		  pnp, rev);
>  }

[Severity: High]
Does wrapping `/ 100` and `% 100` inside the `(int)` cast break the build on
32-bit architectures?

sw_get_bits() returns `__u64`.  Previously, the `(int)` cast truncated the
bitwise OR result before dividing by 100, whereas moving the outer
parentheses around `/ 100` and `% 100` turns them into 64-bit unsigned
division and modulo, emitting undefined references to `__udivdi3` and
`__umoddi3` (or `__aeabi_uldivmod`) at link time on 32-bit targets.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109010548.4386=
99-1-xujiahao@cmss.chinamobile.com?part=3D1
