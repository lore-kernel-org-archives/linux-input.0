Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1963115BD
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123936; cv=none; b=fs4WqI/Sypz9UcvQAG3Dpv44awDu+hMqAQ/hkYY4eF7utkbr3BNDATwXXm/UbHJDR4VeOQIVkwadzkbX8u4q6w0QLr8IAjGGkA2hdPVP3Kf0LugnafHMBEEVTe+4Ya4qztU7ZfDju9aBWjOHyB5uDaH31s7y7U4RtWw8fZRZuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123936; c=relaxed/simple;
	bh=fMlqE7KIZgq/fD0ZT+AT5B7Yw4HfXW/v1pRfIqUkyGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVsHJkZKPDvcUv30RQ8ROw9ySFB4tt/zwNP5TDDVAvNi2kzJX500N+nzaZBySjZjSQ4ZSxhslAl/93j4/mu/Z2S0UD+2VzU4A+skLn4nBYWJiDtM9GI8uQwHEfpU3ihprjzijgwju+PBM0PiBNUn8D3+owVw/cb/juuGFvTC8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJDJ/RTG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJDJ/RTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA331F000E9;
	Sun, 30 Aug 2026 21:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123934;
	bh=+puwH36Iq3PKKeNG8Iki3fheqHky1bv3Nw+uz7aR3lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJDJ/RTGXialVNIOa1g9sSnBOXug4PNJFl2d+7IU+xCwt0gPKYBxPCst1/SZg1z4s
	 sZnZgDzmc/eC7H8e+P05yuf/A1z/oygMss16PfFaVdywegcFQrMzOsyDotdCsTI2iv
	 iUBfkXughSz0YNKXZushp7pJ084u2/vnMdYmvfTJ5rY5ZgIbPyGj2U8ZFD631ms+Ng
	 qIx1/wG+eVEbTCaJSfbFaqiDKiEm02nZSm76gyBp7uhuWQeQAto+z3Z5HwI8T0MH4v
	 I9Neam/cv/SDW7fBW5a/4VO448q7ov/ALNDNq8W1drqG48+IyqQc0v2zRuxLinplOr
	 +uP3kFd2jeg6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] Input: gscps2 - protect buffer access in read and
 report helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260830-gscps2-v1-3-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-3-c733d4cae7f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 21:05:33 +0000
Message-Id: <20260830210534.2DA331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware polling loop in `gscps2_writeb_output()` deadlocks if cal=
led synchronously with interrupts disabled.
- [High] Unbounded IO read loop in `gscps2_read_data()` can cause hard CPU =
lockup.
--

commit 9b1c3aa5a5184e24692c48f162f22f58a5172f7a
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: gscps2 - protect buffer access in read and report helpers

This commit adds a spinlock to gscps2_read_data() and gscps2_report_data() =
to
prevent a race condition on the ring buffer consumer index. It fixes an iss=
ue
where concurrent execution could lead to duplicate, skipped, or out-of-order
bytes.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 5b6e311f8a02c..fef6fffb6f865 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
> @@ -238,6 +238,8 @@ static void gscps2_read_data(struct gscps2port *ps2po=
rt)
>  {
>  	u8 status;
> =20
> +	guard(spinlock_irqsave)(&ps2port->lock);
> +
>  	do {
>  		status =3D gscps2_readb_status(ps2port->addr);
>  		if (!(status & GSC_STAT_RBNE))

[Severity: High]
This is a pre-existing issue, but can this unbounded loop risk a hard CPU
lockup?

If the MMIO space becomes unreadable due to a hardware failure, device
disconnection, or bus error, gscps2_readb_status() typically returns 0xFF.

Since 0xFF & 0x01 (GSC_STAT_RBNE) is non-zero, this exit condition never
becomes true:

    if (!(status & GSC_STAT_RBNE))
        break;

The loop body reads the input data, but since the hardware is in a failed
state, it will also return 0xFF, causing the loop to never terminate.

[ ... ]

> @@ -255,7 +257,7 @@ static bool gscps2_report_data(struct gscps2port *ps2=
port)
>  	unsigned int rxflags;
>  	u8 data, status;
> =20
> -	while (ps2port->act !=3D ps2port->append) {
> +	while (true) {
>  		/*
>  		 * Did new data arrived while we read existing data ?
>  		 * If yes, exit now and let the new irq handler start
> @@ -264,17 +266,20 @@ static bool gscps2_report_data(struct gscps2port *p=
s2port)
>  		if (gscps2_readb_status(ps2port->addr) & GSC_STAT_CMPINTR)
>  			return true;
> =20
> -		status =3D ps2port->buffer[ps2port->act].str;
> -		data   =3D ps2port->buffer[ps2port->act].data;
> +		scoped_guard(spinlock_irqsave, &ps2port->lock) {
> +			if (ps2port->act =3D=3D ps2port->append)
> +				return false;
> +
> +			status =3D ps2port->buffer[ps2port->act].str;
> +			data   =3D ps2port->buffer[ps2port->act].data;
> +			ps2port->act =3D (ps2port->act + 1) & BUFFER_SIZE;
> +		}
> =20
> -		ps2port->act =3D (ps2port->act + 1) & BUFFER_SIZE;
>  		rxflags =3D ((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0) |
>  			  ((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0);
> =20
>  		serio_interrupt(ps2port->port, data, rxflags);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the
hardware polling loop in gscps2_writeb_output() to deadlock if called
synchronously from here?

When serio_interrupt() is called with interrupts disabled (since it is invo=
ked
from the gscps2_interrupt() hardware IRQ handler), an input driver like atk=
bd
can call serio_write() synchronously.

This calls gscps2_writeb_output(), which has this loop:

    while (gscps2_readb_status(addr) & GSC_STAT_RBNE)
        cpu_relax();

If a new byte arrives from the hardware device, GSC_STAT_RBNE (Receive Buff=
er
Not Empty) becomes set.

The loop waits for RBNE to be cleared, but RBNE is only cleared when the
receive data register is read.

Since we are spinning inside this loop, we never read the data register, and
the IRQ handler cannot run to read it either.

>  	}
> -
> -	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-gscps2-v1-=
0-c733d4cae7f9@gmail.com?part=3D3
