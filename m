Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BD2D3A7C;
	Fri, 16 Oct 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141451; cv=none; b=iHEMOORam6zK+Qccuir6wkIGvmYlblfKmZiNiRpCxWqCgWWPN5BXxDGhbOb5nPimsR2Adi+R/UWx7fnSCxNuSgsn/5UFRfj7croOU5RTsW5t1iGNhgHeUfgahAGXfpm98sY7vfOmCXjmyQ1RBmn8RZ+w7KWKrRjzcFcuvV2VeEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141451; c=relaxed/simple;
	bh=tlpTuFAVzicUA7VVx+4eb1I7J+SIaMC4Zc5xzo1cOc0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sK/XIxnbzGWaAgb+PIJKqnaWyQcV5jpMnAKjzCwjPMGL9kMM+uojkrPZfWl8DuybYvquBOsO58ephwklxXK/FXgZYUQKofRi2MZGKDY3VWIUFLYAkJX3wmsjR1UZWP685QBcVdu4vz8fDgeppeTr4H6vSnZ8rmsU2Euf4Gf3dSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVkXHhKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVkXHhKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD831F000C4;
	Fri, 16 Oct 2026 09:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792141450;
	bh=9Y6wSV7NpmoX7U6K1+n8oGfIJGsJhi/squ4DH6Ju00k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=iVkXHhKAMB3Dw0vQL/O99AzlSPxw56YY/QRec/Bl+jepScD02HRHl0QbwryR4RySp
	 Jas+j0kLtzsgmBilGXXpDrGQO5CQSDJ2sEqmJ8RZ53Bgk/Q68+vlVslS/Hqa+ROU2O
	 Bm/l9vji04W6XolqyYULrp1tyxKtvf6K661at7r4V0x/OwSvN92bxNOZ6y8V3oTOwo
	 lLnsWlXf8hNHXaLmS4gvGb25FwkSuNwq2z4APtlXzDUgZwDiTjjpT5eDLsfFX5NGGN
	 vWK4FXgLrDWqGqQAxLgzr7RXRqNLlG9lm0/AYVk3b3NfH9jJINNaQ2l1OpSJi/jmIc
	 ADZSY2ywlqj/w==
Date: Fri, 16 Oct 2026 11:04:07 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?M=E9ven_Car?= <meven29@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: logitech-headset: add a battery driver for the
 PRO X 2
In-Reply-To: <20261011124110.62621-1-meven@kde.org>
Message-ID: <217o9262-51s4-4r93-o651-27124010q4s5@xreary.bet>
References: <20261011124110.62621-1-meven@kde.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 11 Oct 2026, M=C3=A9ven Car wrote:

> The PRO X 2 LIGHTSPEED receiver does not speak HID++, so
> hid-logitech-hidpp cannot read its battery. Its report descriptor has a
> consumer collection for the media keys and two vendor collections, and
> no report 0x10 or 0x11.
>=20
> The battery answers on usage page 0xffa0. A single 64 byte frame on
> report 0x51 asks for it, with no handshake, and the reply gives the
> level and whether the headset is charging. The driver asks every 120
> seconds. It also reads the power frames that the headset sends on its
> own. A switch-off frame marks the headset absent at once, and a
> switch-on frame moves the next request to one second later, so the level
> appears without waiting for the poll.
>=20
> hid-generic sets HID_QUIRK_INPUT_PER_APP, so this receiver had one input
> device per application collection, among them the Consumer Control node
> for the media keys. A driver does not inherit that quirk, so probe sets
> it and the input devices stay as they were.
>=20
> The power supply is registered with POWER_SUPPLY_SCOPE_DEVICE. The
> headset is present from a reply until the next switch-off frame, and
> capacity returns -ENODATA while it is absent, so a headset that is off
> when the driver binds reports no level.
>=20
> The G522 LIGHTSPEED uses the same vendor protocol with a different frame
> layout. That device is left out until someone can test it.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: M=C3=A9ven Car <meven@kde.org>
> ---
> Changes in v3:
> - Request the battery level one second after a power-on frame, so the
>   level appears without waiting for the 120 second poll.
> - Report the headset as absent until the first battery reply, and return
>   -ENODATA for capacity while it is absent.
> - Queue the poll on system_dfl_wq instead of the system_wq.
>=20
>  drivers/hid/Kconfig                |  11 +
>  drivers/hid/Makefile               |   1 +
>  drivers/hid/hid-ids.h              |   1 +
>  drivers/hid/hid-logitech-headset.c | 319 +++++++++++++++++++++++++++++
>  4 files changed, 332 insertions(+)
>  create mode 100644 drivers/hid/hid-logitech-headset.c
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 48934c4f3..5c845b1b8 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -670,6 +670,17 @@ config HID_LOGITECH_DJ
>  =09generic USB_HID driver and all incoming events will be multiplexed
>  =09into a single mouse and a single keyboard device.
> =20
> +config HID_LOGITECH_HEADSET
> +=09tristate "Logitech wireless headset battery"
> +=09depends on USB_HID
> +=09select POWER_SUPPLY
> +=09help
> +=09Support for the battery of Logitech wireless gaming headsets that
> +=09report it over a vendor collection instead of HID++.

Thanks a lot for the patch.

One question though -- is it really practical to have this as a user=20
selectable option?
I think it'd make sense to have just selected by HID_LOGITECH_DJ the same=
=20
way as it selects HID_LOGITECH_HIDPP. What do you think?

Thanks,

--=20
Jiri Kosina
SUSE Labs

