Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCFE33A715;
	Thu,  2 Jul 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013222; cv=none; b=f42wkMXMMLgi3z52qQBz4GPRifDAMW+jqLiIhxrPgi8wXbGW3q/VhvzLNtqdyihCXU/MBfJQjVcDPBbYEE/gN2Rgmix4t9dfzu3HWVUOzyRxDWV5Lw8rG6aaBumEYO5rAfq1qo6/XePEefF+ceTKi3ICYwRD0ZZgD1lfu9tR2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013222; c=relaxed/simple;
	bh=xM7wXElkc6p1/hPEbmGQXB5nkWB4YMUZAj6IYjm3GXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQtD+kBOdyR2/gduiQmQ3wXlY+cEdfUu0djcZvjdkV/x+UdxKROOeMTsaVrV8RpiW2QKsFhgX+35xpCihMszJtx8p/qXgMSrpxdNk7e0l8bddk/1aSqcqTsDitUTP6NOklZNir4LDNETAzffvQoP/NZjpW7JFkMKg6Jj8bS6M4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FreGYn+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FreGYn+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515D81F000E9;
	Thu,  2 Jul 2026 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013221;
	bh=zuQzJwKx7wlris4Q0CuBgvwdsj6DgeV+ONMXBSoLdOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FreGYn+FNEjGhjEhW4eRENB7MLD2+igN7AM4iMN1zvHJDP3txcK1CSEaseEq2cz/T
	 NWXKD8+3jWdueRDMjdjBnnRe3TufPru0dSmjxbCsuUJYGGn+3c4l8vTOk7L814OEj9
	 1SI2AVVnoURDCaug+l21Ea0OMAF38Jv3VANU1ftSwA6nO/26AATxJQyvaNp0RqhQNK
	 NAlpUlnjKuy45uHjb2o0H+22UH/WgxxU2OcEJnonG+rCAjonmrNImdpUKMN5jGY6lu
	 XL3W5OUNSnoGnRqqmWTBtKGM/l3dWXY3jZ5E8sKaZ7GEoFxZuafC1K7dVyK20lvO6X
	 1SiuQAFAHgV/A==
Date: Thu, 2 Jul 2026 18:26:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: position: hid-sensor-custom-intel-hinge:
 use common device for devres
Message-ID: <20260702182656.1a145d1f@jic23-huawei>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-5-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-5-b87f01f5efbc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 02 Jul 2026 21:48:02 +0530
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
>  drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drive=
rs/iio/position/hid-sensor-custom-intel-hinge.c
> index 1f4a40716c3f..eb6c59f81c3f 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -293,7 +293,7 @@ static int hid_hinge_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	indio_dev->num_channels =3D ARRAY_SIZE(hinge_channels);
> -	indio_dev->channels =3D devm_kmemdup(&indio_dev->dev, hinge_channels,
> +	indio_dev->channels =3D devm_kmemdup(&pdev->dev, hinge_channels,
>  					   sizeof(hinge_channels), GFP_KERNEL);
>  	if (!indio_dev->channels)
>  		return -ENOMEM;
>=20

