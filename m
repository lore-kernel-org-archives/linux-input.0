Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99351898FB
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133270; cv=none; b=WEQpZYuSy6tAmcFmPZChKuFcSqhMj9kkyPAvRr2isEaqnJgLx2xNkH8NrBfLDQ18ALuznmXCBO0A4rKVOfgQSZ2v5LkgurQpSipeVwuAdcB7bgkyc0eToBmSldDNaUha1sRmHDj+WLaDiYBeAxw7Q3mucIEAakRmRhcZjUN3Mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133270; c=relaxed/simple;
	bh=nOAyNL7kNs3f3TIwKzlMIhBTMYig1uZrGdz3/RWqJlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUmAP1iBwlV4ShXohumL4Hj7X+YHm7npR5d6gimeHGLWTLHplxsOWqCcG/8yVCFOl7WEOOx3bWHw+4zydNSEj7cJJ14qRTPqOp4OPMQDIYZvrX/WgPMepz2NL4aiDA4eN7IwdKwJc2EhQ9EPlCDHk7cRqlktlbUtVha6RUa9KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JItua7D8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JItua7D8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACAF1F00893;
	Wed, 10 Jun 2026 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781133268;
	bh=hTXACzupclAAZXpVKA8KCmodeINl4WARihKiD3hHv0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JItua7D81EXISZhWQJQrHFHdsW3lX9ZRyZ1XHGf1dPxR0jvTuNCtuLL+AL4aJI1gk
	 Ow9fIyu4vBKN0U+aqt1MQj7PT7NO8PmKcoaDnsqmSP7iNvJXgHyFZi/s7J/hZfH8ly
	 BOaGsyETgJdeoescfs8DYsU+OS7N+o3xQ8/5MK5YTvn0dyy+26zWzXQtrs/tVw/41y
	 Xl8VUI6Swgn+1e9vTcU7jPD/c/4jk+AWnWLhYD26QzCrP0MZg8rQulR3fbjT0LKX6h
	 oZqoJQE7RjlF/Cjr61YZ9eb8RSuNn7W/9GUl/PtpGKlKSJwT0PUyFyXn/R3pKY10gE
	 VeWOjmpU92ypg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: ipaq-micro-keys - add length check in
 micro_key_receive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <aintAvTyw4CVb5hG@google.com>
References: <aintAvTyw4CVb5hG@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 23:14:28 +0000
Message-Id: <20260610231428.AACAF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `micro_key_start()` and `micro_key_stop()` acquire `keys->micro->l=
ock` without disabling interrupts, leading to a potential deadlock with the=
 MFD serial interrupt handler.
--

commit 33b9102060e60926d04c255f54b3c13bbafe5ca3
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: ipaq-micro-keys - add length check in micro_key_receive
   =20
    The driver accesses the message payload (msg[0]) without checking if
    the length is greater than zero. The parent MFD driver can produce a
    payload with a length of 0, in which case msg[0] would be uninitialized
    or stale.
   =20
    Add a check to return early if len is less than 1.
   =20
    Reported-by: sashiko-bot@kernel.org
    Assisted-by: Antigravity:gemini-3.5-flash
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/key=
board/ipaq-micro-keys.c
> index 695ef3c2081a4..b2068fbc82651 100644
> --- a/drivers/input/keyboard/ipaq-micro-keys.c
> +++ b/drivers/input/keyboard/ipaq-micro-keys.c
> @@ -43,6 +43,9 @@ static void micro_key_receive(void *data, int len, unsi=
gned char *msg)
>  	struct ipaq_micro_keys *keys =3D data;
>  	int key, down;
> =20
> +	if (len < 1)
> +		return;
> +
>  	down =3D 0x80 & msg[0];
>  	key  =3D 0x7f & msg[0];
> =20

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential deadlo=
ck
involving keys->micro->lock when looking at the surrounding code.

Does the use of guard(spinlock) in micro_key_start() and micro_key_stop()
risk a deadlock with the MFD serial interrupt handler?

drivers/input/keyboard/ipaq-micro-keys.c:micro_key_start() {
	guard(spinlock)(&keys->micro->lock);
	...
}

drivers/input/keyboard/ipaq-micro-keys.c:micro_key_stop() {
	guard(spinlock)(&keys->micro->lock);
	...
}

The keys->micro->lock spinlock is also acquired within the MFD driver's hard
IRQ handler in micro_serial_isr(). Since micro_key_start() and
micro_key_stop() are called in process context without disabling local
interrupts, could an interrupt firing on the same CPU while the lock is held
cause the ISR to try acquiring the lock again and hang?

Should these functions be using guard(spinlock_irqsave) or equivalent to
prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aintAvTyw4CVb5hG@go=
ogle.com?part=3D1
