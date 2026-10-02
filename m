Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC077476CC3
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932440; cv=none; b=VE1UOm0wKTVecBazgl3YxuNZNOVQBP63/MF8h/uZiNbC3Z88brlT748e55O0Djox5GzIJ9DVIzXCwieL6KFGIIzyeGy+Xp39BQu0ewJBAg44KLF7G4SNKICkR79/Yg/3DOHsXNRTC0ope6/5fsI3W78ozRZrB7Luu1ipwjpuzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932440; c=relaxed/simple;
	bh=pIsjaRA9bWTHMJ5bdykcUq+mcyKjaRKNINA0U6BnVjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRmbxAJva4X9l5FWyiaZEDMSDBJ/CSBHT6lZlBI201KNuXdF4gXqji42jwQpYEtzBVrPSwCU2l1TGnFzTJUbGMaFr8+QqKTGwj5eLxK9JXSpHPnIStCklcy2JHyM1uXe9J/YW2Nk1G3hiz1R4AnaxqXwgoTUwMrgJ58f5LfaD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaFccIIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaFccIIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7771F0089A;
	Fri,  2 Oct 2026 09:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932438;
	bh=UsGMEyc98QyT8yIcCCkYwGf6ZXobU1e7ssAjrC5/OVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MaFccIIJxAty1F/kdo09XWPLO9vsZ9TgpjvG+YV0f77UaVZUqas0/oTNCa8YobFGt
	 gXnDvtOfMJnEQP9HAiATCJ8QA9dZWZCmsHDJUK7iaC67nRjvc0XowajtexnFF86H4k
	 PpM1FWSQ9PplJc4+pJ2J4u3RZLHNlz91btBHLJGHHZ47FG96casklC4JyeEMOn489B
	 jpMX9vP3ICQyPHLFCVdUEujzRfli+zurhn9tJ3BPA+7XBMtvfHt5BIxLJFHH2dFLmc
	 C0Zo6+Jp4ioVf5GNXjkaSFszoS67JTtPZ5xtYWYwoIRwj8mcXHDMdJ9Zowb0R0UHtd
	 Q3UIJrFTt120A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] HID: logitech-hidpp: support ratchet wheel
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RXJpayBIw6VrYW5zc29u?= <erikhakan@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261002-bolt-input-rfc-v1-4-333e1f350586@gmail.com>
References: <20261002-bolt-input-rfc-v1-0-333e1f350586@gmail.com>
 <20261002-bolt-input-rfc-v1-4-333e1f350586@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:58 +0000
Message-Id: <20261002091358.7A7771F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: UAF in hidpp20_ratchet_wheel_raw_event() on registration fail=
ure
--

commit ef099676a0f82cda930a8a2414084557ddb81f29
Author: Erik H=C3=A5kansson <erikhakan@gmail.com>

HID: logitech-hidpp: support ratchet wheel

This commit adds support for the 0x2130 Ratchet wheel feature on Logitech
devices. It detects the feature, handles HID++ scroll events, and enables
HID++ wheel diversion by default for Bolt-connected devices.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 9217ad4a97f43..6195080505cbb 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -4213,6 +4267,44 @@ static int hidpp20_hires_wheel_raw_event(struct hi=
dpp_device *hidpp,
>  	return 0;
>  }
> =20
> +static int hidpp20_ratchet_wheel_raw_event(struct hidpp_device *hidpp,
> +					   u8 *data, int size)
> +{
> +	int delta_v, delta_h;
> +
> +	if (hidpp->ratchet_wheel_feature_index =3D=3D 0xff)
> +		return 0;
> +
> +	if (size < 6)
> +		return 0;
> +
> +	if (data[0] !=3D REPORT_ID_HIDPP_LONG ||
> +	    data[2] !=3D hidpp->ratchet_wheel_feature_index)
> +		return 0;
> +
> +	if (data[3] !=3D EVENT_RATCHET_WHEEL_MOVEMENT)
> +		return 0;
> +
> +	if (!hidpp->input)
> +		return 1;
> +
> +	delta_v =3D (s8)data[4];
> +	delta_h =3D (s8)data[5];
> +	if (delta_v) {
> +		input_report_rel(hidpp->input, REL_WHEEL_HI_RES, delta_v * 120);

[Severity: High]
Could this lead to a use-after-free if input device registration fails?

In the hidpp_connect_event() worker, the allocated input device is assigned=
 to
hidpp->input before calling input_register_device(). If registration fails,
the worker handles the failure by setting hidpp->input =3D NULL and freeing=
 the
device.

Because hidpp20_ratchet_wheel_raw_event() is a lockless interrupt handler,
is it possible for it to check that hidpp->input is valid, race with the
failure path freeing the device, and then dereference a freed pointer when
calling input_report_rel()?

> +		input_report_rel(hidpp->input, REL_WHEEL, delta_v);
> +	}
> +	if (delta_h) {
> +		input_report_rel(hidpp->input, REL_HWHEEL_HI_RES,
> +				 delta_h * 120);
> +		input_report_rel(hidpp->input, REL_HWHEEL, delta_h);
> +	}
> +	if (delta_v || delta_h)
> +		input_sync(hidpp->input);
> +
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-bolt-input=
-rfc-v1-0-333e1f350586@gmail.com?part=3D4
