Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2644AB9B;
	Thu, 23 Jul 2026 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806801; cv=none; b=P48dYKmkP1lk3BZBZaVXtli2NbEPxtRPmXzRsYFPkQFTVzrsqE9+acAzpR81W/GcMKGcPH+IqvIBAU8QwH3x0aOIidS81dQm6We8yUkeTIEQjPbgLxpCIFv5qoxwILSOIAyEpKr62pnAvznjMU+qXuGPM9Lr/kKkuY9DxQ7oUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806801; c=relaxed/simple;
	bh=Cr+1fctMnp+mLSqFV11TOaDmgUiP/Jg2yDVHx5TX4P0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GEuoVEeZQdodOezJDJVphb/FGKE3hQKfCzYOGGW0TnQKqxwajkCilRfpVTzHVJJIjPyTtg5KDPhZGjRGeBDZ3YVpe3KrNGKXAngfXWBwlhfTMMkvKW8PlCXbMJDagiOVLX45ZihK7cMx7iW1aL1ZDQQ7J489v45q/oh0lshx3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huQ4u/d1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huQ4u/d1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5396E1F00A3A;
	Thu, 23 Jul 2026 11:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806799;
	bh=ltT8We79rFcljm+IF1xPv/D+Q5iFH4zjOUEw7iAB0EI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=huQ4u/d1crRtZPga2sHXiaLKWybCSZDX7zhdOtrk56FqKURqtqW0q7jgAHABBuyE1
	 tWOxnFfMLrc8cRQ52OTzMIX0iRcSlFOFWxhourvrwGDe+65q9HeV5PmbsTFf91f7TO
	 gqFfxWCT0niG6nhdT3MiWMgrttmUI9d8pRGIQnsZbgX2z2CkvVEq7ft8WV996rWmkX
	 qCbZGL1B44yriWErLaiXt9Y8nPeM6lobDKJiwCXwJXTPCChYsCmUaoT4nm4069ucKv
	 9fpHTU+8Z4qXea8ERxAg0oRyIwLgsKsF9jIydi8psE8GYPEwJW29PSGzvrktE09K5+
	 0ws0wceu70a1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] Input: edt-ft5x06 - poll while a contact is down to
 recover dropped releases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandre Hamamdjian" <azkali.limited@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260723-b4-ft5426-v1-4-d4b4e32be042@gmail.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
 <20260723-b4-ft5426-v1-4-d4b4e32be042@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:39:58 +0000
Message-Id: <20260723113959.5396E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The polling worker can be erroneously re-armed during device suspe=
nd, leading to invalid I2C accesses while the device is powered off.
- [Medium] A single transient I2C read failure after an idle period immedia=
tely triggers a spurious controller reset.
- [Medium] The controller reset recovery logic breaks permanently after ~24=
.8 days of uptime on 32-bit systems due to jiffies wrap-around.
--

--- Patch [4]: [PATCH 4/4] Input: edt-ft5x06 - poll while a contact is down=
 to recover dropped releases ---
commit 601140d3fc50fbfeaa9e78699c5e29c00098c932
Author: Alexandre Hamamdjian <azkali.limited@gmail.com>

Input: edt-ft5x06 - poll while a contact is down to recover dropped releases

This commit adds a polling mechanism to recover from dropped release events
on unreliable I2C buses. It tracks active contacts and polls the panel while
any are down, synthesizing releases if contacts disappear. It also adds a
bounded retry for transient bus errors and a controller reset mechanism if
reads fail for over a second.

> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index ac61ac44fd649..794c0650f5cb3 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
[ ... ]
> @@ -321,26 +333,83 @@ static int edt_ft5x06_bulk_read(struct regmap *map,=
 unsigned int start,
[ ... ]
> +static void edt_ft5x06_fetch_and_report(struct edt_ft5x06_ts_data *tsdat=
a)
>  {
[ ... ]
> +	for (tries =3D 0; tries < 4; tries++) {
[ ... ]
> +	}
>  	if (error) {
>  		dev_err_ratelimited(dev, "Unable to fetch data, error: %d\n",
>  				    error);
> -		goto out;
> +		/*
> +		 * A run of failed reads with no success for over a second means
> +		 * the controller is wedged rather than just glitching; pulse the
> +		 * reset line to recover it and drop any held contacts, since the
> +		 * post-reset finger state is unknown.
> +		 */
> +		if (tsdata->reset_gpio &&
> +		    time_after(jiffies, tsdata->last_success + HZ) &&
> +		    time_after(jiffies, tsdata->last_reset + 2 * HZ)) {

[Severity: Medium]
Will a single transient I2C read failure after an idle period immediately
trigger a spurious controller reset?

If the device sits idle for > 1 second, tsdata->last_success becomes stale.
When a new touch arrives, if the very first I2C read fails due to a transie=
nt
bus error, the time_after(jiffies, tsdata->last_success + HZ) check evaluat=
es
to true.

This bypasses the intended 1-second delay of continuous failures, and
immediately pulses the reset line, causing a 300ms stall and dropping the
initial touch.

[Severity: Medium]
Does the controller reset recovery logic break permanently after ~24.8 days=
 of
uptime on 32-bit systems due to jiffies wrap-around?

If the system runs for more than 24.8 days (exceeding MAX_JIFFY_OFFSET)
without the touchscreen wedging, tsdata->last_reset remains at its
initialization value.

A subsequent I2C bus error triggering the recovery path would cause the
time_after(jiffies, tsdata->last_reset + 2 * HZ) check to evaluate to false
due to signed integer overflow, bypassing the reset entirely until jiffies
wraps around the rest of the 32-bit space.

> +			tsdata->last_reset =3D jiffies;
> +			gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
[ ... ]
> +static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
> +{
> +	struct edt_ft5x06_ts_data *tsdata =3D dev_id;
> +
> +	guard(mutex)(&tsdata->io_lock);
> +	edt_ft5x06_fetch_and_report(tsdata);
> +	if (tsdata->down_mask)
> +		mod_delayed_work(system_wq, &tsdata->poll_work,
> +				 msecs_to_jiffies(EDT_POLL_INTERVAL_MS));
> =20
> -out:
>  	return IRQ_HANDLED;
>  }
[ ... ]
> @@ -1383,6 +1521,9 @@ static int edt_ft5x06_ts_suspend(struct device *dev)
>  	struct gpio_desc *reset_gpio =3D tsdata->reset_gpio;
>  	int ret;
> =20
> +	/* stop the poll worker so it cannot touch i2c after power-down */
> +	cancel_delayed_work_sync(&tsdata->poll_work);
> +

[Severity: High]
Can the polling worker be erroneously re-armed during device suspend?

In edt_ft5x06_ts_suspend(), cancel_delayed_work_sync() is called to stop
the poll worker, but the device's interrupt is not disabled until several
operations later (or never disabled in HIBERNATE mode).

If an interrupt occurs in this window, the ISR edt_ft5x06_ts_isr() runs,
observes a non-zero down_mask, and unconditionally calls mod_delayed_work().

This could cause the worker to execute after the suspend function has disab=
led
regulators and suspended the I2C adapter, potentially leading to I2C access
timeouts or hardware hangs.

>  	if (device_may_wakeup(dev))
>  		return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-b4-ft5426-=
v1-0-d4b4e32be042@gmail.com?part=3D4
