Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB1308F03
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566014; cv=none; b=d6F9e/XKopZmBO+ScLm2j3a2yMv4yJOop3Ic+ryP0bY5pASgXo/BTAQoLU6IM/B+/mmasn3XQu5/x8nJ6SNOqv6eNGogAz+yPXe5FGvD8uC26zcpSXsoPx4bGVbrHxphw9lGG6M94IGs783Xr2mdgCdCr53UZ9NwMp77Q51x4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566014; c=relaxed/simple;
	bh=gsA1PzRt0k485igGnJfwsPxucXgb6WWJO7ch2DXtkCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aEFdTzd669HwDdy4RYoRG/EthJ3Shryi6A06/Brfah7VQ4hDeJhYbxSTN84DA0exepLmJrPxMrtHgZ3Q3IYCFCbdl/5HgLHYz0//ncLFJasqvU9I7/bvcSTakCl11cFUTzhJvbNjTlt5askyN4pkSUQTPTSomke55kihR6Rwjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDlpllww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDlpllww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8842E1F000E9;
	Mon, 20 Jul 2026 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566012;
	bh=dmTmBJn9tIhMxbrFQZtPEQHwuQSXt0i7MC7KgtoYjp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HDlpllwwf1exblAhyzHDIVhRC5Gs4M7Jx6pIir1BZQb5b2Ayinb59SEAN+DxRJp4K
	 RzsGDTAKBX52vnflPFFUx2lFVyVxTA3Cnx8CvT2iTkRj+Q/wjY1FyNkkAyxHsageOL
	 U8cq0SCDr6rX8FrUjQPUq3OUuf7p5AmeFsm5SRNHI8I+CrblZSGVto1ak5Pm4PXLxk
	 S1qydgt9JMlwS2bvQRNChE/GdrYl+t8vD3osAaRs3E1rHZspKdTfIT1iUwcZCNXYq3
	 ERTf4yfZLX/cFoPXYb0TDZpTnMMTZCiskpm+B2ue7ErJsMNS8Si5QATCPY0dNxUJVy
	 EF9ucfADHvEvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] Input: applespi - use unified wait queue with
 timeouts for drain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720162219.32324-2-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
 <20260720162219.32324-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:46:52 +0000
Message-Id: <20260720164652.8842E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The patch attempts to prevent indefinite lockups during driver u=
nbind or PM transitions by adding a timeout to the drain waits. However, up=
on timeout, it explicitly falls back to waiting unconditionally on the exac=
t same condition, neutralizing the protection and still causing an indefini=
te lockup.
- [Low] Unnecessary removal of scope-based cleanup `guard()`, reverting to =
manual spinlock management.

Pre-existing issues:
- [Critical] Missing cancel_work_sync() in applespi_remove() causes Use-Aft=
er-Free of applespi_data when the workqueue executes.
--

--- Patch [1]: [PATCH v3 1/5] Input: applespi - use unified wait queue with=
 timeouts for drain ---
commit 08fd2aeb0171b9531113cd115a28c72f63462dc0
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - use unified wait queue with timeouts for drain
   =20
Consolidate wait queues by renaming drain_complete to wait_queue and use
wait_event_lock_irq_timeout() with a 3-second timeout during read and write
drains to prevent indefinite lockups during driver unbind or PM transitions
if the hardware becomes unresponsive.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index b5ff71cd5a701..c501bf7e517e4 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c

[ ... ]

> @@ -1793,21 +1793,49 @@ static int applespi_probe(struct spi_device *spi)
> =20
>  static void applespi_drain_writes(struct applespi_data *applespi)
>  {
> -	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
> +	unsigned long flags;
> +	long ret;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);

[Severity: Low]
This isn't a bug, but is it necessary to revert from guard() to manual
spin_lock_irqsave() here?

The input subsystem guidelines prefer using modern cleanup primitives like
guard() in new or refactored code. wait_event_lock_irq_timeout() should
work correctly with the hidden flags variable established by guard().

> =20
>  	applespi->drain =3D true;
> -	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
> -			    applespi->cmd_msg_lock);
> +	ret =3D wait_event_lock_irq_timeout(applespi->wait_queue,
> +					  !applespi->write_active,
> +					  applespi->cmd_msg_lock,
> +					  msecs_to_jiffies(3000));
> +	if (!ret && applespi->write_active) {
> +		dev_warn(&applespi->spi->dev,
> +			 "Timed out waiting for write drain, waiting unconditionally\n");
> +		wait_event_lock_irq(applespi->wait_queue,
> +				    !applespi->write_active,
> +				    applespi->cmd_msg_lock);

[Severity: Medium]
Does this fallback logic defeat the purpose of the timeout?

The commit message states the timeout is meant to prevent indefinite lockup=
s,
but if a timeout occurs here, wait_event_lock_irq() waits unconditionally
on the exact same condition.=20

If the hardware is genuinely unresponsive, won't this just delay the indefi=
nite
lockup by 3 seconds rather than preventing it?

> +	}
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
>  }
> =20
>  static void applespi_drain_reads(struct applespi_data *applespi)
>  {
> -	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
> +	unsigned long flags;
> +	long ret;
> =20
> -	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
> -			    applespi->cmd_msg_lock);
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +
> +	ret =3D wait_event_lock_irq_timeout(applespi->wait_queue,
> +					  !applespi->read_active,
> +					  applespi->cmd_msg_lock,
> +					  msecs_to_jiffies(3000));
> +	if (!ret && applespi->read_active) {
> +		dev_warn(&applespi->spi->dev,
> +			 "Timed out waiting for read drain, waiting unconditionally\n");
> +		wait_event_lock_irq(applespi->wait_queue,
> +				    !applespi->read_active,
> +				    applespi->cmd_msg_lock);

[Severity: Medium]
Does this read drain fallback have the same indefinite lockup issue as the=
=20
write drain when the hardware fails?

> +	}
> =20
>  	applespi->suspended =3D true;
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
>  }
> =20
>  static void applespi_remove(struct spi_device *spi)

[Severity: Critical]
This is a pre-existing issue, but does applespi_remove() miss a call to
cancel_work_sync(&applespi->work) before returning?

If the driver unbinds while a touchpad info SPI transaction is in flight,
applespi_drain_reads() will block until the read finishes.=20

When the SPI read completes, its handler schedules applespi->work, clears
read_active, and wakes up the drain.=20

If applespi_remove() finishes without cancelling the work, devres will
free applespi_data, which could lead to a use-after-free when the scheduled
applespi_worker() executes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720162219.3232=
4-1-fourdollars@debian.org?part=3D1
