Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329B302753
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781644100; cv=none; b=fHqVbXVSuZ2RXeBIGvLoUsH2Q316mbsRJ+FqiXN0Pk1eie2YQOkqtHDCnVxsmhIQt4iysbKm/KGol0vLFxlw+A2/BCYXqe58mc+0bLAUhM02ebeLRFGjEnjPYsmIbtUge4bl9ha3eYUVVFIqP81emuPxYjrQxDG9KXvGWpoM5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781644100; c=relaxed/simple;
	bh=veLr7vK9tsPa/CQxDyn0oliov6pvAv1asKPq4sx9W2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UvfB+ycseqcVGHPFtLC2vT5qXwQpxuMvkItgwEdLcFnjEX3BJmxaurVslswgEmkllZlyykPulnGYpDojrEsKGRPnsOaPY7ZuxXyctIiw3V60vYmbKQQZpwyXtAc7HQGJ0bRBRtYfnnVYI6owTLzwmMXUrLsgitDtA8YpZN93msw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlWg5lgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlWg5lgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB821F000E9;
	Tue, 16 Jun 2026 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781644099;
	bh=AdBxxMi2edzxQuzrw1uDbNBsIHaCCQuTpkh5EwzjEz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dlWg5lgK8Ihq/ZOGH7JWwn3O4puHhv25Fo8FzKIYIKe1bJ5pdjhpWUO4ZbfMBNq1R
	 Iaj4fC480DXGBbH28tDYRwCo7EyjBQJfzvHqCXdUjnjnA/DeEaO90tmQ1hTHNkxNoX
	 ZhEggURlOy1kRv2tDG3q7DHivI2tph3QGWNngzz/ktyF2bpIrlRZL+6cyhc0wf33Lk
	 CR9+v/idFzWsfmE+DrJtUpN8iZMtPqgnV4xJu36ge/+jDH9LVSGsbPV9Ejj3ZtxbTb
	 TQiSQyxkZMtQMaT8qhD2X2nhVj6WMFfr4DMC3a2yTC/FpL3wFP+y0GFFnrTYl5ZVbQ
	 suHYoDwjZBCUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] HID: sony: use dedicated raw_event() handlers in
 sony_raw_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosalie Wanders" <rosalie@mailbox.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260616205042.6671-3-rosalie@mailbox.org>
References: <20260616205042.6671-3-rosalie@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 21:08:18 +0000
Message-Id: <20260616210819.0DB821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race Condition / Null Pointer Dereference in RB4_GUITAR_PS5 initia=
lization.
- [High] Sleeping in Atomic Context in rb3_pro_instrument_raw_event.
--

commit ce2aa734b3cbe3b5ae8274fe7a1ef679e83470b5
Author: Rosalie Wanders <rosalie@mailbox.org>
Subject: HID: sony: use dedicated raw_event() handlers in sony_raw_event()

This commit simplifies how the sony driver processes raw events by introduc=
ing
dedicated handler function pointers inside the sony_sc structure. The
appropriate handler is now assigned during device configuration based on
hardware quirks.

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 315343415e8f1..7da1fd1e52fea 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c

[ ... ]

> +static int rb3_pro_instrument_raw_event(struct sony_sc *sc, u8 *rd, int =
size)
> +{
> +	/* Rock Band 3 PS3 Pro instruments set rd[24] to 0xE0 when they're
> +	 * sending full reports, and 0x02 when only sending navigation.
> +	 */
> +	if (size < 25 || rd[24] !=3D 0x02)
> +		return 0;
> +
> +	/* Only attempt to enable full report every 8 seconds */
> +	if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
> +		sc->rb3_pro_poke_jiffies =3D jiffies + secs_to_jiffies(8);
> +		rb3_pro_instrument_enable_full_report(sc);

[Severity: High]
This is a pre-existing issue, but can this call sequence sleep in an atomic
context?

The raw event handler usually executes in an atomic context, such as a USB =
URB
completion handler. This path calls rb3_pro_instrument_enable_full_report()
which allocates memory using GFP_KERNEL and issues a synchronous USB control
transfer via hid_hw_raw_request().

Could calling these blocking functions in atomic context trigger a might_sl=
eep
warning or lead to a kernel panic?

> +	}
> +
> +	return 0;
> +}

[ ... ]

> -static void rb4_ps5_guitar_parse_report(struct sony_sc *sc, u8 *rd, int =
size)
> +static int rb4_ps5_guitar_raw_event(struct sony_sc *sc, u8 *rd, int size)
>  {
>  	u8 charging_status;
>  	u8 battery_data;
> @@ -1094,6 +1150,9 @@ static void rb4_ps5_guitar_parse_report(struct sony=
_sc *sc, u8 *rd, int size)
>  	u8 battery_status;
>  	unsigned long flags;
> =20
> +	if (unlikely(size !=3D 64 || rd[0] !=3D 0x01))
> +		return 0;
> +
>  	/*
>  	 * Rock Band 4 PS5 guitars have whammy and
>  	 * tilt functionality, they're located at

[Severity: High]
This isn't a bug introduced by this patch, but could this handler dereferen=
ce
a null pointer if an event arrives during device initialization?

Looking at sony_input_configured(), the raw event handler for the guitar is
registered, and hid_hw_open() is called because the device has battery supp=
ort.
However, sc->input_dev is not assigned until after these initialization ste=
ps.

If the device sends a report immediately after the hardware connection open=
s,
would this event handler trigger and attempt to call input_report_abs() usi=
ng
a null sc->input_dev pointer?

> @@ -1138,65 +1197,22 @@ static void rb4_ps5_guitar_parse_report(struct so=
ny_sc *sc, u8 *rd, int size)
>  	spin_unlock_irqrestore(&sc->lock, flags);
> =20
>  	input_sync(sc->input_dev);
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616205042.6671=
-2-rosalie@mailbox.org?part=3D1
