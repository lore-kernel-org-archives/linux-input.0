Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540E400DFC
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565427; cv=none; b=PIFWVgpQ0j/3j4UI6UUdimf4Is2DwgcYzmyiOrYhgUTxDWm0aPuy6hAujGSJOE5FlfHeqh95h++oPWCI2D+ICJBDpr2+uiivzulcGkIEvbyt6bofKGNYxApZ6Vgr0RWuPlWnuy/FdXbxJRsRV8bm+ComSWiyAP0cJxMowBp1KUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565427; c=relaxed/simple;
	bh=fTG/pGS409vspzkhWuhrVlse3fnop725kV7Ua94fIHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bvE2KvJJLidlniZlLZlRUDE4JWfygSsF/RTyaBQbstl5SO9VxFhOJQTm8fqq2wnyOrmDQpOse2urO2zi/AT7+/iXr9vAqqNW2X63ab+uwo9yD/UAWXqa756bs3sQvGWPrrr3yaL1Qi1tBijJmVRwgsJdqLa0vOHLq+DLvn7cYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTtRgbBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTtRgbBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95E21F000E9;
	Mon, 20 Jul 2026 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784565426;
	bh=eLq+rB0WQ4bwwfQl2o8GINU49c4zSEtmGA1SlX0x72s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTtRgbBmAo20eumN/Fdn5KfrmI0cY+J4zkrP8MWohT8X9hne7mG6LFW8pjNZU9toS
	 yCSlPWEW37sDiSwDKqA1OV+fcYpijsqwFHPqxPsktXNojzVcX1GR3iL8tk652xfQFQ
	 8Da03MKSHcB0BDglvc2VO0xUCX+3g6ycI6xyU981Rj0q5btM8ulRO+rvCT6IJPX48M
	 jYZr9t2bvd1W+ZwjDogsVf7qwT0R8/p9N31cs4GkzwPUmAvFa3NhFC0WVhJi5WtahW
	 zfx+rYH+TDa+hf+ROqWibjKhnya75JV98wVeJnW8WUH1P2syalFNOXBuB4j5coAp5Q
	 9eKR+3M0/Bv3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] Input: applespi - fix use-after-free in
 applespi_remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260720162219.32324-6-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
 <20260720162219.32324-6-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:37:05 +0000
Message-Id: <20260720163705.D95E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Improper mixing of `spin_lock_irqsave` with `wait_event_lock_irq=
` variants.

Pre-existing issues:
- [High] The driver fails to clear the `cancel_spi` flag during resume, ren=
dering the keyboard and touchpad permanently dead after the first suspend c=
ycle.
--

--- Patch [5]: [PATCH v3 5/5] Input: applespi - fix use-after-free in apple=
spi_remove() ---
commit dde1844e9ce22b6dd80fd613693670eb010fc66b
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - fix use-after-free in applespi_remove()

Replace the separate read and write drain helpers with a single barrier usi=
ng
cancel_spi and wait_event_lock_irq_timeout(). Wait for outstanding
asynchronous SPI operations to complete before tearing down the driver
context.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index a21e89f303879..6027808421247 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1939,14 +1939,29 @@ static void applespi_drain_reads(struct applespi_=
data *applespi)
>  static void applespi_remove(struct spi_device *spi)
>  {
>  	struct applespi_data *applespi =3D spi_get_drvdata(spi);
> +	unsigned long flags;
> +	long ret;
> =20
> -	applespi_drain_writes(applespi);
> -
> +	/* Disable GPE and remove handler first to prevent interrupt storm */
>  	acpi_disable_gpe(NULL, applespi->gpe);
>  	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
>  	device_wakeup_disable(&spi->dev);
> =20
> -	applespi_drain_reads(applespi);
> +	/* Prevent any new SPI transfers and wait for outstanding ones */
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +	applespi->cancel_spi =3D true;

[Severity: High]
This is a pre-existing issue, but does the driver fail to clear the
cancel_spi flag during resume?

When the system suspends, applespi_drain_writes() sets
applespi->cancel_spi =3D true. Upon waking up, applespi_resume() executes a
state restoration block but appears to omit resetting this flag:

applespi_resume() {
	...
	scoped_guard(spinlock_irqsave, &applespi->cmd_msg_lock) {
		applespi->drain =3D false;
		applespi->have_cl_led_on =3D false;
		applespi->have_bl_level =3D 0;
		applespi->cmd_msg_queued =3D 0;
		applespi->read_active =3D false;
		applespi->write_active =3D false;

		applespi->suspended =3D false;
	}
	...
}

Because of this, subsequent calls to applespi_async() will reject all new
SPI transfers and return -ESHUTDOWN, leaving the keyboard and touchpad
permanently unresponsive after the first suspend cycle.

Could cancel_spi be reset to false in applespi_resume() to avoid this?

> +	ret =3D wait_event_lock_irq_timeout(applespi->wait_queue,
> +					  !applespi_async_outstanding(applespi),
> +					  applespi->cmd_msg_lock,
> +					  msecs_to_jiffies(3000));

[Severity: Medium]
Is there an API mismatch between spin_lock_irqsave() and the lock variants
used inside the wait macros?

applespi_remove() acquires the lock using spin_lock_irqsave(). Inside this
critical section, it calls wait_event_lock_irq_timeout().

This macro internally drops the lock using spin_unlock_irq(), which
unconditionally enables interrupts, and then reacquires it with
spin_lock_irq(). This completely overrides the interrupt state saved in the
flags variable.

Should this code just use spin_lock_irq() directly to avoid the mismatch?

> +	if (!ret && applespi_async_outstanding(applespi)) {
> +		dev_warn(&applespi->spi->dev,
> +			 "Timed out waiting for SPI transfers to drain, waiting unconditional=
ly\n");
> +		wait_event_lock_irq(applespi->wait_queue,
> +				    !applespi_async_outstanding(applespi),
> +				    applespi->cmd_msg_lock);
> +	}
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> =20
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720162219.3232=
4-1-fourdollars@debian.org?part=3D5
