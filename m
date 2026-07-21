Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD43B3BEB;
	Tue, 21 Jul 2026 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628025; cv=none; b=HpXAVT11rdC53wyYhqVpxN1e1mVBNbXtVUm51G3CSkuAEHUF3t7gqpFvHUOEuEgk9L0Co5T5y0oVxs+0Hm/ryBCbV/HztPvuRkh4JRn/74XkINwcUT3fg8wQWESHKXtZD2z3LSNOMUrxuaFPdlmv7ZJXJ9I6oHr1jo/qZh6EM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628025; c=relaxed/simple;
	bh=hyx28/R/q585/NErWvU1HX3vxMjHbYmexSk5L0mBkHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=schqhX4FkiwQq92ntu8n5gmRxWDDDocZyu48B+7AuQYsJeHTmVCrUOf8CPByDlZTgF0T3HzcUF6NUb5Nn2VznP1azCsqlZbjhA4WGNu0k663nyPNLBqyJRH7jZ/0fU9lE0a8RrblaLIaXcFfGrl143egrCWwf9HKV4Vp7nK27no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQdxSWqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQdxSWqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E0E1F000E9;
	Tue, 21 Jul 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628023;
	bh=BvZoPtnmGcdZHvQuX4vS+tidmT29ab93FWVEvWPvIOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQdxSWqF7QSr3fHvMpQ8LRL31RRDo9TcrcPgoG6OTWPa6kU507G6QbMI3REg3nyRi
	 fPKlvXD6EnOkg5n4cOfni/ySHVueFkOf3ob8HLubBaZdQKK6ViidCXGfMBnJokF7IM
	 RtatFYMrKSFtkaz/oKK6pgXybWab/mzwuwWG78suug8rq3z4+MONTR69Y+QEzyx1+2
	 JzLzpJy4vKdozKmDN/YouSDHyBvl+jErer1n5jGSLT19KZkrop31m2XFPXyYX5mB0i
	 sc2GGNzK1SrJENs24Vs1hSH++RnbKkR+MvrwqHLJglY1Gv72yZQdUBO0L6Frsx98TF
	 M+nRcOCfkzF6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/7] input: keyboard: Add driver for ASUS
 Transformer dock multimedia keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org
In-Reply-To: <20260721095233.420823-5-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:00:22 +0000
Message-Id: <20260721100023.02E0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent lockless access to the shared state variable `priv->s=
pecial_key_pressed` across different execution contexts without `READ_ONCE(=
)` / `WRITE_ONCE()` annotations.
--

--- Patch [4]: [PATCH v10 4/7] input: keyboard: Add driver for ASUS Transfo=
rmer dock multimedia keys ---
commit 258dea9f255ed0dea28a80d3eb88521b79b225d6
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: keyboard: Add driver for ASUS Transformer dock multimedia keys

This patch adds support for the multimedia top button row of the ASUS
Transformer's Mobile Dock keyboard. It enables function keys by default
and allows switching to multimedia keys by pressing ScreenLock + AltGr.

> diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/drivers/=
input/keyboard/asus-transformer-ec-keys.c
> new file mode 100644
> index 0000000000000..44235e4a7f548
> --- /dev/null
> +++ b/drivers/input/keyboard/asus-transformer-ec-keys.c

[ ... ]

> +static void asus_ec_input_event(struct input_handle *handle,
> +				unsigned int event_type,
> +				unsigned int event_code, int value)
> +{
> +	struct asus_ec_keys_data *priv =3D handle->handler->private;
> +
> +	/* Store special key state */
> +	if (event_type =3D=3D EV_KEY && event_code =3D=3D KEY_RIGHTALT)
> +		priv->special_key_pressed =3D !!value;

[Severity: Medium]
Could this lockless write cause data races when accessed concurrently?

This executes in the input core's event delivery context, while the
EC notification path reads it. Should this use WRITE_ONCE() to prevent
potential KCSAN warnings about unmarked data races?

> +}

[ ... ]

> +static int asus_ec_keys_process_key(struct input_dev *dev, u8 code)
> +{
> +	struct asus_ec_keys_data *priv =3D dev_get_drvdata(dev->dev.parent);
> +	unsigned int key =3D 0;
> +
> +	if (code =3D=3D 0)
> +		return NOTIFY_DONE;
> +
> +	/* Flip special key mode state when pressing SCREEN LOCK + R ALT */
> +	if (priv->special_key_pressed && code =3D=3D 1) {

[Severity: Medium]
Is it possible to read a stale value here due to concurrent modification?

Since priv->special_key_pressed is updated in the input event path and
read here in the blocking notifier thread without synchronization, should
this use READ_ONCE() to ensure the compiler doesn't perform unexpected
optimizations?

> +		priv->special_key_mode =3D !priv->special_key_mode;
> +		return NOTIFY_DONE;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095233.4208=
23-1-clamor95@gmail.com?part=3D4
