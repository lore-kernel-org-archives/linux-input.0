Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F4559C82;
	Wed, 23 Sep 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182042; cv=none; b=h3bgdH5tuknXNSHnLcBA98Ky24gVebn1okUL90Y+ObjdoC/PDaebY5OYepYuL8pH5kRRZK1SsxLXO58J6vdPSOQiZjAg8GuMFYA+rJNcxPHOZDKNzfqbhwMXc1HNsl/lmXFAbiGjyveCwpUYK4l32ebzEmereR3S04N0Q1+KmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182042; c=relaxed/simple;
	bh=WfcmS1xtc+P6sdKSOtJprt63zIXwjbO5zEAQvUUCwDY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rCIj/mdl/EiRhOt1JdnGCO89tluno4A5IUjq/w3OuEqmYjl5OP7hDatXb0SCH+0odcGwEhn0Bv4pnIFpCxUwXxfJo8d4I07lJXmhM2Ly3EImiJfM3ajNtuwDFNjFKqlO2KodVGRGJcNPLkxJMuV0wTHJOOkqH5dTV6mJhm6MFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU6Ae0Et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU6Ae0Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3C41F000FF;
	Wed, 23 Sep 2026 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182038;
	bh=pElAvUz/2FfkCAwnKeisXksZERMT6SZBcjUE4S/cPgQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=cU6Ae0EthGBEcr2veKV/piet/5j4p++JF3sSoJrG56Wj/GY1CZBIfTHqGMZgNmIwW
	 woTVVOW1gNvMtSuoILPXYfpnJyMVzNjLuAGPl926Gc5Qfj8Tl8D/uxA6XDOnTOuQoU
	 XTOS4pc0QirQgmY6ZfKJXrCG8rrXyQcAqFy257BUKkss67iTx7iuDNF+NUdz2Jlgr/
	 xgQFvJ9eI9JUdUB9pcSEFje9FtBXlqfjt2CTA/mwXVqo6W4OLKIRF4SlU/h32VoFVP
	 sYGkzdfWy9a+DtyuNi1RJxXZWMNxIl2GCj7yHwYH5EN8aBV0qCkkSQ9lPuZxRxb0kF
	 6YcVnIjURIGqw==
Date: Wed, 23 Sep 2026 18:47:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-2?Q?Tomasz_Paku=B3a?= <tomasz.pakula.oficjalny@gmail.com>
cc: oleg@makarenk.ooo, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: universal-pidff: Add support for Turtle Beach
 VelocityOne Race
In-Reply-To: <20260922131758.1242755-1-tomasz.pakula.oficjalny@gmail.com>
Message-ID: <729138p6-175p-n372-5oq0-62q3o38s14q2@xreary.bet>
References: <20260922131758.1242755-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 22 Sep 2026, Tomasz Paku=C5=82a wrote:

> Add usb VID and device PID to hid-ids.h
>=20
> Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> ---
>  drivers/hid/hid-ids.h             | 3 +++
>  drivers/hid/hid-universal-pidff.c | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b3aca5aa9176..52b25d76cc2a 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1504,6 +1504,9 @@
>  #define USB_DEVICE_ID_ASUS_MD_5110=090x5110
>  #define USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART=090x7100
> =20
> +#define USB_VENDOR_ID_TURTLE_BEACH=090x10f5
> +#define USB_DEVICE_ID_TB_VELOCITYONE_RACE=090x7077
> +
>  #define USB_VENDOR_ID_TWINHAN=09=090x6253
>  #define USB_DEVICE_ID_TWINHAN_IR_REMOTE=090x0100
> =20
> diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universa=
l-pidff.c
> index 60180467a0bf..f1854cfe42d0 100644
> --- a/drivers/hid/hid-universal-pidff.c
> +++ b/drivers/hid/hid-universal-pidff.c
> @@ -187,6 +187,7 @@ static const struct hid_device_id universal_pidff_dev=
ices[] =3D {
>  =09{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_FORTE) },
>  =09{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_LA_PRIMA)=
 },
>  =09{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_TONY_KANA=
AN) },
> +=09{ HID_USB_DEVICE(USB_VENDOR_ID_TURTLE_BEACH, USB_DEVICE_ID_TB_VELOCIT=
YONE_RACE)},
>  =09{}

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

