Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880F3AFD09
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543431; cv=none; b=ZAkK8CQp8KKK1eDeH7+Rs/VyUPjNfPgMR0rmlHHrf9oU0Tj8yKdPJizB9c+oud3ai66shvlnutJFsBuGeO95tBjWsQKvNPveL0WdkPV+Z7/Z9RRjLnbDGPuevUzr9vT4ccLUuy91uCt93w0uwHiRPmMczEZtH36y+JjS0GPtUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543431; c=relaxed/simple;
	bh=WoLpJfy3GoTSEQrIrtuB8h0qK4F6KVXPLhhtKzHyTEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uy3HSTurfvdE6Q2n9H1CTsncYCvzga3zvzkc1OCUrEKSLRGfIvP++2DUSv3G/uAbQPpg+9J2DVwyaUdwR0KaCV5Ad7ee81joL7WxfRrzl+J2zvyDQ+DubY7k3TCSuotkIpIdJaI8zYr1LXftZyPNo2zUpVxhKA7W1UFRghIgYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSygh+WK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSygh+WK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F941F000E9;
	Mon, 20 Jul 2026 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784543430;
	bh=ZPOyNFA8ADdT506wQqFHVUyLISPTx2i7nuYHFDHIN+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SSygh+WKIAxZxO3xGS73LSzTK51qUI9JYSgManNK/hacSs1t0yDIFfaYSDxz/oWm5
	 a5awWZ7DuM+cCWM+JicH4ddZRs58LfBRizDBneBlou9JdDYk3tKSOrdpyD6SnkwnaY
	 mQNM8D8rP1dlNYpHKUh8o7R6WsKQzdoECYwv7mDMRwnbtJu0M/gMNCstb+h127Hjdy
	 /O+BY0FrE18REjlMkhATuqPAyKjmsMXxGder70/dnKW5RzWOCrzv2/Z/FafjbcSK2/
	 QSgHRQuHu1KFt0scRdzIo6DlwXxAndpJhvIJEYDfbFUnajVkizE8LY+UcD7cDtX6ru
	 qFioxOPb/+p5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] Input: applespi - fix use-after-free in
 applespi_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720101435.13612-6-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
 <20260720101435.13612-6-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:30:29 +0000
Message-Id: <20260720103030.13F941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] applespi_async_complete() triggers a use-after-free by signaling c=
ompletion before actually executing the callback.
- [High] Ignored timeout in `wait_event_lock_irq_timeout` leads to a Use-Af=
ter-Free on outstanding SPI transfers.
- [High] Setting `cancel_spi =3D true` before disabling the level-triggered=
 GPE causes an interrupt storm.
--

--- Patch [5]: [PATCH v2 5/5] Input: applespi - fix use-after-free in apple=
spi_remove() ---
commit 8828f1f25e357bbbc7a4945659f2ddf6d10cda5c
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - fix use-after-free in applespi_remove()

This commit replaces the separate read and write drain helpers with a single
barrier using the existing cancel_spi and wait_event_lock_irq mechanism. It
waits for outstanding asynchronous operations to complete before disabling
the GPE and tearing down the device.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index 95a8f790eaffc..088337f060b24 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1910,15 +1910,22 @@ static void applespi_drain_reads(struct applespi_=
data *applespi)
>  static void applespi_remove(struct spi_device *spi)
>  {
>  	struct applespi_data *applespi =3D spi_get_drvdata(spi);
> +	unsigned long flags;
> =20
> -	applespi_drain_writes(applespi);
> +	/* Prevent any new SPI transfers and wait for outstanding ones */
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +	applespi->cancel_spi =3D true;

[Severity: High]
If we set cancel_spi to true while the level-triggered GPE is still enabled,
could this cause an interrupt storm?

When the GPE fires, applespi_notify() attempts to queue a read via
applespi_async(), which immediately rejects it with -ESHUTDOWN. Because the
read is rejected, the trackpad hardware never deasserts the interrupt line.

Would it be safer to disable the GPE before setting this flag?

> +	wait_event_lock_irq_timeout(applespi->wait_queue,
> +				    !applespi_async_outstanding(applespi),
> +				    applespi->cmd_msg_lock,
> +				    msecs_to_jiffies(3000));

[Severity: High]
If the wait times out (returning 0), the driver continues tearing down and
returns, allowing devm to free the memory. If the delayed SPI transfer
completes shortly after, won't that result in a use-after-free in the SPI
core or applespi_async_complete() when it accesses the freed driver data?

[Severity: High]
Does this wait condition race with the inner completion callback?

Looking at applespi_async_complete(), it signals completion before executing
the inner callback:

drivers/input/keyboard/applespi.c:applespi_async_complete() {
    ...
    info->complete =3D NULL;

    if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
        wake_up_all(&applespi->wait_queue);

    spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);

    if (complete)
        complete(applespi);
    ...
}

If the teardown thread wakes up as soon as applespi_async_outstanding() is
false and frees the device structure, will complete(applespi) dereference
freed memory?

> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> =20
> +	/* Disable GPE and remove handler */
>  	acpi_disable_gpe(NULL, applespi->gpe);
>  	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
>  	device_wakeup_disable(&spi->dev);
> =20
> -	applespi_drain_reads(applespi);
> -
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720101435.1361=
2-1-fourdollars@debian.org?part=3D5
