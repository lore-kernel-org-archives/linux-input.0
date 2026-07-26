Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFE386575
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065219; cv=none; b=sS/i02eW/Fheb+0T5fGqQUnJsdKmWFKguP4Krzo+2cvCEulHU6TrySTgB6fcd6aGf3L5p2jvZt9WDTxMhRrpaniNjDTG5kWR+pAcrgw7JfRIfodI7EB8aEniuJfcj+pHki2IpiCmM4Xmv3lwUFLWhCRPtqGv5uNq2wyBhsEZQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065219; c=relaxed/simple;
	bh=o7BQplkEphYj135t0HjUXsOWyusGO9vLeUuDvNl17Bw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TaIcB67YgTI40LVfiTd1Ok4W/CQ3qEh5UB2NQ/WalvU8S/KX+s5mIWWUwiwWYRD7oY34NaFyMSOIxQ428B3Ti3ojxKFlRF5cf/C+II5JeWAE5HS/0luZapoJ1YIcBktrCJ87IgFN0IZABss4pToJ+o7U95PlPxh8PqQ4t1e9IQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGTV4l+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGTV4l+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D911F00A3A;
	Sun, 26 Jul 2026 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785065218;
	bh=qeo/3wr1s5vMvUVhEHnN6l+T5xO9Ax1rNp223yxlKd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGTV4l+ZoE5g/Lg2V8n0na3P4ekXDu0hlvKcEJe/+9GPQRxc7q9xn/VVGXMiMhwDj
	 IGqKnZcUuGqyljkC3daoNiWn+w0UviyJti8pNoFROD4rQJljViBFjCDpq2o99vs3o4
	 lDEUflXG7x5xgzXdy05ygTr7YtUlNeE4eE0wQNNXZ/PeIjBCW5GtNar2W1huTFYMNJ
	 aMG35nx4X5YoL39TIAtziYffceqYJgVIfIHimjXKIGrp94t5Kc+DEONeHdIFnLPKFJ
	 bFP0lHkbJCXGWCDbE0Sk6fNRADmchMa5YmSrDFqPvL5AQR4Bek2hdywfh6kR6Z3ynP
	 7LTZOihstaUrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Input: tca8418_keypad - fix potential infinite loop
 and OOB access on invalid keycodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhian Liang" <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260726111502.2252-1-liangzhan5dev@gmail.com>
References: <20260726111502.2252-1-liangzhan5dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 11:26:57 +0000
Message-Id: <20260726112658.37D911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to resolve the infinite loop caused by invalid key=
codes (e.g., 0xFF from a stuck I2C bus) and introduces continuous log spam =
that causes a soft lockup.
- [High] Hardware interrupts are never disabled on driver unbind or during =
a probe failure, which can lead to an IRQ storm on shared interrupt lines.
- [High] Clearing the interrupt status register after draining the FIFO int=
roduces a race condition that can result in dropped or delayed key events.
--

--- Patch [1]: [PATCH v3] Input: tca8418_keypad - fix potential infinite lo=
op and OOB access on invalid keycodes ---
commit 6913c66fea4ba1ffd746fcc00c1d3e4e7e05ef21
Author: Zhian Liang <liangzhan5dev@gmail.com>
Subject: Input: tca8418_keypad - fix potential infinite loop and OOB access=
 on invalid keycodes

This patch modifies the empty-FIFO check to evaluate the extracted keycode
rather than the raw register. It also adds a bounds check against the
configured matrix dimensions to skip invalid events.

Cc: stable@vger.kernel.org

> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyb=
oard/tca8418_keypad.c
> index 4616afa0286c3..41836c79261a1 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -171,19 +173,28 @@ static void tca8418_read_keypad(struct tca8418_keyp=
ad *keypad_data)
>  			break;
>  		}
> =20
> -		/* Assume that key code 0 signifies empty FIFO */
> -		if (reg <=3D 0)
> -			break;
> =20
>  		state =3D reg & KEY_EVENT_VALUE;
>  		code  =3D reg & KEY_EVENT_CODE;
> =20
> +		/* Key code 0 signifies empty FIFO */
> +		if (!code)
> +			break;
> +
>  		row =3D code / TCA8418_MAX_COLS;
>  		col =3D code % TCA8418_MAX_COLS;
> =20
>  		row =3D (col) ? row : row - 1;
>  		col =3D (col) ? col - 1 : TCA8418_MAX_COLS - 1;
> =20
> +		/* Validate against configured matrix size */
> +		if (row >=3D keypad_data->rows || col >=3D keypad_data->cols) {
> +			dev_err(&keypad_data->client->dev,
> +				"invalid key code %d (row %d, col %d)\n",
> +				code, row, col);
> +			continue;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but does this actually fix the
infinite loop on hardware faults as described in the commit message?

If the hardware returns 0xFF due to a stuck I2C bus, the code variable
evaluates to 127 because of the bitwise AND operation:

code =3D reg & KEY_EVENT_CODE;

Since 127 is not 0, the new empty FIFO check (!code) is bypassed.

The execution then falls through to the new validation check, which catches
the invalid bounds, prints the dev_err message, and executes continue.

Will this cause the do-while loop to immediately fetch 0xFF again without
terminating, creating a continuous stream of dev_err log spam and a soft
lockup?=20

Should this loop have a safeguard or break on sequential invalid reads
instead of continuing?

[ ... ]

> @@ -299,6 +310,8 @@ static int tca8418_keypad_probe(struct i2c_client *cl=
ient)
> =20
>  	keypad_data->client =3D client;
>  	keypad_data->row_shift =3D row_shift;
> +	keypad_data->rows =3D rows;
> +	keypad_data->cols =3D cols;
> =20
>  	/* Read key lock register, if this fails assume device not present */
>  	error =3D tca8418_read_byte(keypad_data, REG_KEY_LCK_EC, &reg);

[Severity: High]
This is a pre-existing issue, but does the driver safely handle probe
failures or driver unbinding?

Looking at tca8418_keypad_probe(), if input_register_device() fails, the
probe function returns an error and devres unwinds. However,
tca8418_configure() was already called earlier in the probe, which enables
interrupts on the hardware.=20

Since there is no .remove callback in tca8418_keypad_driver, and no devm
cleanup action to disable the hardware interrupt, an unbind or probe failure
leaves the device asserting the shared IRQ line indefinitely.=20

Could this lead to an unhandled IRQ storm that forces the kernel to disable
the shared IRQ line, breaking other devices?

[Severity: High]
This is another pre-existing issue, but is there a race condition in
tca8418_irq_handler() that drops key events?

The IRQ handler drains the FIFO by calling tca8418_read_keypad()
and then subsequently clears the interrupt status register:

drivers/input/keyboard/tca8418_keypad.c:tca8418_irq_handler() {
    ...
    if (reg & INT_STAT_K_INT)
        tca8418_read_keypad(keypad_data);

    /* Clear all interrupts, even IRQs we didn't check (GPI, CAD, LCK) */
    reg =3D 0xff;
    error =3D tca8418_write_byte(keypad_data, REG_INT_STAT, reg);
    ...
}

If a new key is pressed immediately after the FIFO is drained but before
tca8418_write_byte() executes, the hardware queues the event and asserts
K_INT again. The driver then writes 0xff, clearing the newly asserted K_INT
without ever reading the event.=20

Could this cause a key release event to be permanently left in the FIFO,
resulting in an indefinitely stuck key?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726111502.2252=
-1-liangzhan5dev@gmail.com?part=3D1
