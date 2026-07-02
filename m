Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63531F9B5;
	Thu,  2 Jul 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013359; cv=none; b=GaJYNUS87TtsRyCJCt2p18fbaGrpF7AwgwEnDPmEk5F+A3D75OeILiWjqekCiwLqvTaWJ0+6LGgo/vE5HKNB1I6BsgeiwVIWPboMpOaFN5LfxX4JxU8msUZ6ckQATXKlMiqB0OzO2zvBjOQmDlvADjeSdTGe+3Rh0lYIGzgPhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013359; c=relaxed/simple;
	bh=2tcY+aGgYPWHtj9yT/LqegciHTB7sLBWM8NMS9o/Ef8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvjn+YUwFFFAPl8J8chNXtWoGJ2HSdRdSmtcgPl6kQmJ99u93CNkjwW+dveISkVl8JejpZPG3iu39xBr+x7qyadIfd8o5AdLeaXkmxV9j46yreSBNgHtzFmDsH3J+yKW5P3gc5xsCq+arKysFagzlXm/qhLOg+tGE291HnIB1fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK58KyvP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK58KyvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD471F000E9;
	Thu,  2 Jul 2026 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013357;
	bh=ArDFk62S1ooc1s9sBqz0K16vudhtEHnY/wAxtOBbcGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZK58KyvPjgaGrbjjrjB1yPnKIiN6vQKSSPvF/BEn7FvNeUadS8TW6AfT6t7B0ETF6
	 pL65Ssl9tTXp8KV4gJIhyw+wN91lmP+BqNUaTqTTU0oNU8geli05PLHP7+izQImXUg
	 rySIz3iGW+LOAUiOv97xlE7QoZenM9/igXWFe//aVxxWKo0ZMo6tEUsNDRZYhqxU+l
	 6xIi2GMUfQl9Ux4/fe5rURQ4P2PM/+dN+hODj/PHc0bqNcjpy1cN5amhZxxxk50zKa
	 xHRt0fNtPWgutaVq6FMgvLPZyqxtKFRZ94S4TVp0beocxdyCCBZPOJd6lPEd5X7CbA
	 r84t6iFVH/vcA==
Date: Thu, 2 Jul 2026 18:29:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: temperature: hid-sensor-temperature: use
 common device for devres
Message-ID: <20260702182914.3b2d1126@jic23-huawei>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-6-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-6-b87f01f5efbc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 02 Jul 2026 21:48:03 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org=
> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> kmemdup() is used for memory that is logically tied to the HID
> platform device, even though the driver binds into the IIO framework.
>=20
> Using &indio_dev->dev for devres allocations works functionally, but it
> results in two separate devres ownership trees=E2=80=94one for the HID
> platform device (pdev) and another for the IIO device (indio_dev).
>=20
> The devres framework is intended to have a single, well-defined parent
> device. Since the memory originates from HID sensor probing and is not
> IIO-specific, &pdev->dev is the correct and logical owner.
>=20
> Switch to using the platform device for devm_kmemdup() so that all
> resources are released deterministically and consistently.
>=20
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Applied this one.
> ---
>  drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 18da85e6c60e..6dfb606a53af 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -213,8 +213,8 @@ static int hid_temperature_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	temp_chans =3D devm_kmemdup(&indio_dev->dev, temperature_channels,
> -				sizeof(temperature_channels), GFP_KERNEL);
> +	temp_chans =3D devm_kmemdup(&pdev->dev, temperature_channels,
> +				  sizeof(temperature_channels), GFP_KERNEL);
>  	if (!temp_chans)
>  		return -ENOMEM;
> =20
>=20

