Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AA303A37
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543140; cv=none; b=fjXgETuhCtyVQNvp+bF1JZWX/FYA1of7Lqt+zOwqFT7dTOMPM33fk6OM3dN3NQXpQMELWLsPpFLzVF/mqEKOzsAXhXD2NR9XuZWNlBFU1CRKTjuU7YK0fOu88u0bENQrhzZlu802LBNUBCewpwFl1iI2idnNjOHhlhDiaklwQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543140; c=relaxed/simple;
	bh=ZChyq+IFSy3oeejZkn28I9Sqt5oJbXC4GY40ENkU6Kw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PgRmLtbnl1KmqPbi7OJvM0nZerjZ1gq7sp67Xlov6DtxMbi8P5vxFxhYZurjS9EVb5SiGCcZM15xJ5wTKTxbnTu1SeCSzuARinCbouF/uY4ZA7ODrV7z+vnlETuGweRlDVNPE/344iPvY1z+kkZnQxBFOqu+pY7UyXtxv02/3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp9LVDbm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp9LVDbm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA901F000E9;
	Mon, 20 Jul 2026 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784543139;
	bh=9o5aAPNMAc580o1wfkOqXsTiic4PIxk5lOAHtCD+ut0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jp9LVDbmJXWNvuTO5q20BaC1E/pA9HQsm8iNr7iezbzxxRQWyZWV9DpbOsCsCc7Ba
	 PkBLNFV9xe/EazwOzQKx6N/C6H0AW2BvFPAkJW4Qar1t5G89539AjbX+rykGCTShS3
	 AMCQxmNl1RCfQ6xCr5XLNMdXiFv/J/UytDYDcgetsOPO0hSeTbQph84yYyVY6ZcH+6
	 unBl9NUNlt/7slq069UjnSOu+zUigZPxPBwBsLE3+VzNZ/Ek2Ff6lzFK1zCqG4v04l
	 uCLr9lHeeXGlG9I6ir4pn6eABPAi/G1YwLE+sWXweJdIqt2Fx4mZkThUYmiEa48b81
	 GWF16qvCWcRFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] Input: applespi - use unified wait queue with
 timeouts for drain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720101435.13612-2-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
 <20260720101435.13612-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:25:38 +0000
Message-Id: <20260720102538.BEA901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Ignoring the return value of `wait_event_lock_irq_timeout()` allow=
s driver unbinding to complete while asynchronous SPI transfers are still i=
n flight, leading to Use-After-Free and DMA memory corruption.
--

--- Patch [1]: [PATCH v2 1/5] Input: applespi - use unified wait queue with=
 timeouts for drain ---
commit 61741ce5d99a882b41af91bac9c6e65e14a201cf
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - use unified wait queue with timeouts for drain

This commit consolidates the wait queues by renaming drain_complete to
wait_queue and replaces wait_event_lock_irq() with
wait_event_lock_irq_timeout() using a 3-second timeout during read and
write drains. This aims to prevent indefinite lockups during driver unbind
or PM transitions if the hardware is unresponsive.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index b5ff71cd5a701..64bbeba85ea9e 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c

[ ... ]

> @@ -1793,21 +1793,33 @@ static int applespi_probe(struct spi_device *spi)
> =20
>  static void applespi_drain_writes(struct applespi_data *applespi)
>  {
> -	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> =20
>  	applespi->drain =3D true;
> -	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
> -			    applespi->cmd_msg_lock);
> +	wait_event_lock_irq_timeout(applespi->wait_queue,
> +				    !applespi->write_active,
> +				    applespi->cmd_msg_lock,
> +				    msecs_to_jiffies(3000));

[Severity: High]
If this timeout expires (returning 0), the function will return while
applespi->write_active is still true.=20

During driver unbind, applespi_remove() calls applespi_drain_writes(). If
it returns early due to a timeout, applespi_remove() will complete, and
devres will free the devm-managed applespi_data structure and DMA buffers
like tx_buffer and rx_buffer.

Won't the SPI controller continue performing DMA into this freed memory?

Additionally, when the SPI transfer eventually completes, the SPI core
invokes the completion callback which dereferences the freed context:

applespi_async_write_complete(void *context) {
        struct applespi_data *applespi =3D context;
        enum applespi_evt_type evt_type =3D applespi->cmd_evt_type;
        ...
        applespi_get_trace_fun(evt_type)(evt_type, PT_WRITE,
                                         applespi->tx_buffer,
                                         APPLESPI_PACKET_SIZE);
        ...
}

Could this lead to a use-after-free and DMA memory corruption? Should the
timeout return value be checked and handled, perhaps by canceling in-flight
SPI messages before returning?

> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
>  }
> =20
>  static void applespi_drain_reads(struct applespi_data *applespi)
>  {
> -	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> =20
> -	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
> -			    applespi->cmd_msg_lock);
> +	wait_event_lock_irq_timeout(applespi->wait_queue,
> +				    !applespi->read_active,
> +				    applespi->cmd_msg_lock,
> +				    msecs_to_jiffies(3000));

[Severity: High]
Similar to the drain_writes case above, if this wait times out, the function
returns while applespi->read_active is still true.

Does this expose the same use-after-free and memory corruption risks during
unbind if devm-managed structures are freed while reads are still in flight?

> =20
>  	applespi->suspended =3D true;
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720101435.1361=
2-1-fourdollars@debian.org?part=3D1
