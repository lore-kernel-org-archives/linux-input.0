Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED7381E95
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407082; cv=none; b=m0EvxbZYBhzbUIEBTjUzoamnC1IVrYEimI/m8zGzv2LLFX/BIXheyoilaROc1mwJ+gXUYZFrHX1kzmgLSDoNHRLjkWCAiN8KdxY6Rwp4eposwRgg5rr9kQ/XiBUKB0MTTpM9KorF34Ua/ciopRfuGVM5TjF5q2+zkutQyuffOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407082; c=relaxed/simple;
	bh=ruv/y7I+H1MknWzY60RweZdhrpIctQtjWoXGDPWfzjc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ppLBTGvHKsrKY2Iw5BGp6BP0jssEaS4W+DJ00LM0XKcpOFRyKDUf6jHWzIlh1l+P2t5o9UYAIApkStJINBn3e7nsgBccjcqeyZxUqOl5u0b9Ipwe/baun2z7x+dAQ3vePm8dIW7Pn5+bclPHCdT0zm2N0UhL0PhVtoVuCxFOecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElH8ZppP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElH8ZppP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947661F000E9;
	Thu, 30 Jul 2026 10:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407080;
	bh=GYSd/DjD3mFsxY4US1Zy26z8jSkLIz93ng4HRLCKrsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElH8ZppPfptSp6Nfrc+f7uciqc3c7ANyX7zPQs76z6rmle4vug43ie6aZZ3DHqDCn
	 c3Q8qt4yhVa1d0z798Qy4Cxr6qNXMIrmK6qG+ccqEB0dFbENQu4puxVbycyoRKqxJN
	 i0JbMotOWexn2JaKQrc7t0S5VByNOAWy/cupM6mzXlOoHUnEUT3+bexQKiDBi9Pr/a
	 n467aJGHaWhbKF2OfAadfNeO9q4F+lvJWHmYqVGsqndYaYTWcAmXeOa8IXad3uC2aV
	 5vOOTa0Vpiil/GsQH1XjmHkBuHDGGwXrNFYVOFue/iJuQ/F4bP34rEYs/qaNIlzBu+
	 hxaUzw5TawkNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] input: ff-memless: Add trigger left/right in
 ml_combine_effects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guillaume Casal" <guillaume.casal.42@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730095317.767418-3-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730095317.767418-3-guillaume.casal.42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:24:40 +0000
Message-Id: <20260730102440.947661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Extending `struct ff_rumble_effect` breaks backward compatibil=
ity for legacy userspace applications by interpreting uninitialized union p=
adding as valid rumble magnitudes.
--

--- Patch [2]: [PATCH 2/3] input: ff-memless: Add trigger left/right in ml_=
combine_effects ---
commit 3748260413928654275c7c17fc4ca45fccc0a9ee
Author: Daniel Bomar <dbdaniel42@gmail.com>

input: ff-memless: Add trigger left/right in ml_combine_effects

Combine the new trigger magnitudes alongside the existing strong and weak
magnitudes, so that drivers using input_ff_create_memless() receive them
the same way.

> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> index d1fefd1dfc0de..f6e7f5e93c687 100644
> --- a/drivers/input/ff-memless.c
> +++ b/drivers/input/ff-memless.c

[ ... ]

> @@ -269,6 +269,8 @@ static void ml_combine_effects(struct ff_effect *effe=
ct,
>  	case FF_RUMBLE:
>  		strong =3D (u32)new->u.rumble.strong_magnitude * gain / 0xffff;
>  		weak =3D (u32)new->u.rumble.weak_magnitude * gain / 0xffff;
> +		trigger_left =3D (u32)new->u.rumble.trigger_left * gain / 0xffff;
> +		trigger_right =3D (u32)new->u.rumble.trigger_right * gain / 0xffff;

[Severity: Critical]
Does interpreting these new fields break backward compatibility for legacy
userspace applications?

Because struct ff_rumble_effect is part of a union dominated by larger
structs in struct ff_effect, extending its size did not change the total si=
ze
of struct ff_effect.

Legacy applications allocating struct ff_effect on the stack, setting
type =3D FF_RUMBLE, and initializing only strong_magnitude and weak_magnitu=
de
could unknowingly pass uninitialized bytes to the kernel.

Since this code actively scales and applies trigger_left and trigger_right,
wouldn't those uninitialized bytes from the stack result in random trigger
vibrations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730095317.7674=
18-1-guillaume.casal.42@gmail.com?part=3D2
