Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF213D1CAA
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543415; cv=none; b=K5XVe3H44m3e5I/+x2nvDlFwiPXPVcQ+3fZAIHNjxr4dRCy7qt2C9UZWFYw40/NZMTwTf0B3jKNDjLuQJmxG8Uz8tSYD9wO4OCIBMmqDDFYLXQsvfQg67s1ellwk2T7CbgqrPhflBl0DmPA9vWTEAjAgEWjYKWVBeGGgXLXYmSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543415; c=relaxed/simple;
	bh=BP6e1S/XRFOvepQh+ytOtJENztEBcmsoX/Ijk/FGf0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPC9rvN/A79T7PqAYdZGUehqooUBPdaWqA3/c0zFEp7Wh0/k5f+g554Z3U7epJxBHRGKwH3VzS05P1EhLdrfZuKxLT0YbKUlcsZoJhiZ2KJLXAa3JChhFNqdZP/RZL8AvJb03u/udYOLFQrhOpc49WrDadiZsDtSlyiJlOdGVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn2mJ3Ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn2mJ3Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931641F000E9;
	Mon, 20 Jul 2026 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784543413;
	bh=rlk8oTujq1gI4EjJeePGX4lNDcp07+Ql8NQ2WP1H5OI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kn2mJ3Ol/IhSMGTanPNuacnte/d1sP/OzQQsyYa6lT6a68cNQ0hJlaIZtC4BqFPUn
	 dg/y64eAxtwjyPvMg3dJ4oxF+A0fuHyGbKw6SwNQ2L/IsDC+fMENHCD5jAG4+fXTLO
	 30I0CpOVNgvsN3QErIut7v4tpoQ6Uzvt9t2p3Q0xOWmyARC6ZN1AosEcljg+NNY6mY
	 jgueIYPOo3DxTs33DDC3I9/aUoiAg63LIaDB44kqFeD+AYP/d7PkOuoVQWDU3r4doN
	 SN8PJCc3leKJuh5lHuqk3FTMw/LS+Q9lHcQuCfB4p3NkNrn0TdT6Y4dA6YwhGIu2yH
	 NFUgIzQrz1ikg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] Input: applespi - register touchpad
 synchronously in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720101435.13612-4-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
 <20260720101435.13612-4-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:30:13 +0000
Message-Id: <20260720103013.931641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] A race condition in the SPI completion handler causes a Use-Af=
ter-Free of `applespi` when the probe thread fails.
- [Critical] Ignoring the timeout in `applespi_drain_writes` and `applespi_=
drain_reads` allows the driver to unbind while SPI DMA transfers are active.
- [High] Reading the `tp_dim` debugfs file triggers a NULL pointer derefere=
nce if the touchpad info packet times out during probe.
- [Medium] Data Race when reading `rcvd_tp_info` without `cmd_msg_lock` in =
probe.

Pre-existing issues:
- [High] Failure to call `acpi_finish_gpe()` if `applespi_async()` fails in=
 the GPE interrupt handler.
--

--- Patch [3]: [PATCH v2 3/5] Input: applespi - register touchpad synchrono=
usly in probe ---
commit d8377d333c1aa1ce257aedd6f29080dfb8f5320b
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - register touchpad synchronously in probe

This commit removes the asynchronous worker for touchpad registration.
It replaces it with synchronous registration during driver probe, waiting up
to 3 seconds for the device info packet and falling back to keyboard-only
mode on timeout.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c

[ ... ]

> @@ -1821,6 +1814,20 @@ static int applespi_probe(struct spi_device *spi)
>  	/* trigger touchpad setup */
>  	applespi_init(applespi, false);
> =20
> +	/* set up the touchpad as a separate input device if info is received */
> +	sts =3D wait_event_timeout(applespi->wait_queue,
> +				 READ_ONCE(applespi->have_tp_info),
> +				 msecs_to_jiffies(3000));
> +	if (!sts) {
> +		dev_warn(&applespi->spi->dev,
> +			 "Timed out waiting for touchpad info, continuing keyboard-only\n");

[Severity: High]
If this timeout occurs, applespi->touchpad_input_dev remains null.=20
Will this cause a kernel panic later?

When a user reads the debugfs file, applespi_tp_dim_open() unconditionally
dereferences it:

    snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
             "0x%.4x %dx%d+%u+%u\n",
             applespi->touchpad_input_dev->id.product,
             ...

> +	} else {
> +		sts =3D applespi_register_touchpad_device(applespi,
> +							&applespi->rcvd_tp_info);

[Severity: Medium]
Is there a data race when reading rcvd_tp_info here?

The commit message mentions protecting rcvd_tp_info under cmd_msg_lock,
but applespi_register_touchpad_device() extracts the model info from it
without holding the lock. If the device sends another unexpected touchpad
info packet, could the SPI callback overwrite rcvd_tp_info concurrently?

> +		if (sts)
> +			goto cancel_spi;
> +	}
> +

[ ... ]

> @@ -1853,6 +1860,19 @@ static int applespi_probe(struct spi_device *spi)
>  			    &applespi_tp_dim_fops);
> =20
>  	return 0;
> +
> +cancel_spi:
> +	acpi_disable_gpe(NULL, applespi->gpe);
> +	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);

[Severity: High]
This is a pre-existing issue, but does applespi_notify() have a bug in its
error handling path that could cause a permanent GPE stall?

If applespi_async() fails in applespi_notify() (e.g. transient out of
memory), it returns ACPI_INTERRUPT_HANDLED but misses queuing the async
operation:

    sts =3D applespi_async(applespi, &applespi->rd_m,
                         applespi_async_read_complete);
    if (sts)
        dev_warn(&applespi->spi->dev,
                 "Error queueing async read to device: %d\n", sts);

Because the async task was not queued, applespi_async_read_complete() is
never called. This means acpi_finish_gpe() is never invoked, permanently
leaving the level-triggered GPE unfinished and breaking all input.

> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +	applespi->cancel_spi =3D true;
> +	wait_event_lock_irq(applespi->wait_queue,
> +			    !applespi_async_outstanding(applespi),
> +			    applespi->cmd_msg_lock);
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +
> +	return sts;

[Severity: Critical]
Does this error path introduce a use-after-free for applespi?

When wait_event_lock_irq completes, this probe thread returns an error
and devres frees the applespi structure. However, in
applespi_async_complete():

    if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
        wake_up_all(&applespi->wait_queue);

    spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);

    if (complete)
        complete(applespi);

The completion thread wakes the wait queue and drops the lock. This allows
the probe thread to resume, return, and trigger the devres free operation
before the completion thread executes complete(applespi), leading to a
use-after-free.

>  }
> =20
>  static void applespi_drain_writes(struct applespi_data *applespi)

[Severity: Critical]
I noticed a regression here. Does applespi_drain_writes() allow the driver
to unbind while SPI DMA transfers are still active?

It uses a timeout when waiting for writes to finish:

    wait_event_lock_irq_timeout(applespi->wait_queue,
                                !applespi->write_active,
                                applespi->cmd_msg_lock,
                                msecs_to_jiffies(3000));
                               =20
    spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);

Since the return value of wait_event_lock_irq_timeout() is ignored, if the
SPI hardware is delayed and the timeout expires, this function silently
returns as if the drain succeeded. When applespi_remove() completes,
devres frees the memory. Once the hardware finally processes the transfer,
it will DMA to/from freed memory and execute the completion callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720101435.1361=
2-1-fourdollars@debian.org?part=3D3
