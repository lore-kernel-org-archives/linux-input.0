Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A42DCBE3
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124041; cv=none; b=mGUPpw9D3Mm5HE0aYZ0WcCDLTslRAtHwCzN3fpk4fm2Os9sFouexwv0benbWF9z9xNe1MrSj4j+6haGc+xnsIWjzwFJc+KAo0bxW50ohjCpGTHy9uA8C6aHlm509TdKIDArDirFsfIWN1p2OGFGlKgHpU0TBlKR68SdaMLgYsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124041; c=relaxed/simple;
	bh=Sobm7qJr8nEyKvcrfcSJ3W9xL0zRGjRUwvvZdHLFqcY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e37L3uXKUs3Bmn0TfIQCfzWMRz9u9fy6DAQfQHeoPBzu5XhZh4PcuPbVD3gghqa5u5xbv1KDLomIwdIVD5D1KIV5S/khGW3MRfbK/oD0UNEfgLOprXBntuiScYMeGnQ9HfqhLzqUkzcoL77PtI5PLE62he0iDPcyB4e0Jwn2UzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYkAk755; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYkAk755"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8091F000E9;
	Sun, 30 Aug 2026 21:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788124040;
	bh=m8uvVsF/V/zAExYst938RWEgf/aSBpxK+qu7hxzVFME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYkAk755tCvGSXcjwjZApS9GV1pnm19PvbyO24mN3GnI5Qg08ioLD463kc3MiHDcB
	 85l+O2RuneswPI0ZmMNeuwnZwIKbrnYLcM9+N73y8AQ16Rna1ixIe+ylWRY22hS8FT
	 QrPtcotiNhxQh97qYwc+3/4LDKHzBkqNdQUzzzO/vv1rN3xI4ZBFvjmx+NbuCHRVxn
	 8aypXloIja1+n7pv1qRgPwnsGMrk04y8DiJxNGfkmVNh9S0SR4AWvGQRcAjywpze0w
	 PDMDaqTOpnbdQYoXIQe1IrtW0BuK8mKXalrWaEKnd5A0fNslbPaOgbL/3UoxUljQxI
	 6JrNEgewQdNLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] Input: gscps2 - serialize concurrent interrupt
 handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260830-gscps2-v1-6-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-6-c733d4cae7f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 21:07:19 +0000
Message-Id: <20260830210719.DE8091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning IRQ_NONE on lock contention in a shared hardware interru=
pt handler fails to clear the hardware interrupt, causing a spurious interr=
upt storm that permanently disables the IRQ line.
--

commit f58a76b080709bfb3ea6255a5211466eb9b5af11
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: gscps2 - serialize concurrent interrupt handlers

This commit serializes executions of gscps2_interrupt() using a new
gscps2_interrupt_lock. It uses a trylock and returns IRQ_NONE when the lock
cannot be acquired to prevent overlapping executions and avoid recursive
deadlocks.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 907fb1537595c..2afd53a163ffa 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c

[ ... ]

> @@ -305,21 +307,31 @@ static irqreturn_t gscps2_interrupt(int irq, void *=
dev)
>  {
>  	struct gscps2port *ps2port;
>  	bool handled =3D false;
> +	bool more_data;
> +
> +	ACQUIRE(spinlock_irqsave_try, lock)(&gscps2_interrupt_lock);
> +	if (ACQUIRE_ERR(spinlock_irqsave_try, &lock))
> +		return IRQ_NONE;

[Severity: High]
Does returning IRQ_NONE on lock contention here fail to clear the hardware
interrupt, causing a spurious interrupt storm?

If CPU A calls gscps2_interrupt() manually (e.g., from gscps2_open()) and
acquires the lock:

CPU A
gscps2_interrupt()
    ACQUIRE(spinlock_irqsave_try, lock)(&gscps2_interrupt_lock); // succeeds

And concurrently, new data arrives causing a hardware interrupt on CPU B:

CPU B (Hardware Interrupt)
gscps2_interrupt()
    ACQUIRE(spinlock_irqsave_try, lock)(&gscps2_interrupt_lock); // fails
    return IRQ_NONE;

Because the interrupt is level-triggered and the source was not cleared, wo=
n't
the interrupt controller immediately re-assert the IRQ on CPU B as soon as =
the
handler returns?

This could trap CPU B in a tight interrupt storm loop. If CPU A takes
significant time in serio_interrupt() (e.g., due to input subsystem lock
contention or console writes), could the storm exceed the kernel's unhandled
interrupt threshold and permanently disable the shared IRQ line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-gscps2-v1-=
0-c733d4cae7f9@gmail.com?part=3D6
