Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716B3358B9;
	Thu,  2 Jul 2026 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013173; cv=none; b=eiwY/jECdVJsInnSXjbYX4S4IJuskYhAbjSkJjLHJcRMEYq5PdDGjDSTlUZ5vNH6ML1QwTKiCnaSXv2NGHNgM9u5pG1dzuPz2bjmnQQMNT/1NR2gYlJcjwo1UyevzfHrxaRGYdTychQXK1goiJNw6J2wp3dti89cD+Gs0RtK6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013173; c=relaxed/simple;
	bh=KXA8zmj9fiI1ab59gY56j91ZdTVIwO/wh/zV/CW5TKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mopCCmTeCZlGzPksv+XZ+XYp+wuaoAEvdYYDnv0f7/a5sn2xYtNS5cPpF6hkwnE9JsTwy7AjzNcC64SmBGe4E35uIyrMx+/9o5a2qsVrUZUMEwVF4X1QeW7xcAAM2DOCQe2BlSz4bTyztc2BEC+M+MGUIQj3SGo0bcwN75z0Rk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP+aX6sW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP+aX6sW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1C61F000E9;
	Thu,  2 Jul 2026 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013172;
	bh=3WBOWGJN/q6q31LiJhdDyG0sfcJsnLaqdGFil3gWwns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XP+aX6sW9lBn3Ii9K90Rp/tLVGbl5f45AO2rpGUDGpcqkARtQcA84PgPeHQDUuWb/
	 zJC+lW3d+n6Lko6PDbH6jXGihq4Sg7pw2wH1AOGUvvcl03FkjiF/auFDr+Vko0SfOM
	 M7Ot3YQecyeUzBO0ZeaoHMZdpv5BZsfds3ALcfF7nUBqGxpX8ozZCJFbE0qyxmX/QC
	 Oln47llBgdPS1Qziub1fJJOurONjJ7nHqcvrRdalyZ0SP4cQxIiDVB3iNE+touevN0
	 6xZOjPTZl95Hv8eWgWYH0BxleExNuaTUWokqjYA6x4ndm3tzc/C69VdsKgSGkOo8Fl
	 O79c7DNbhq0Bg==
Date: Thu, 2 Jul 2026 18:26:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Zhang Lixu
 <lixu.zhang@intel.com>
Subject: Re: [PATCH v2 4/6] iio: humidity: hid-sensor-humidity: use common
 device for devres
Message-ID: <20260702182607.6527468d@jic23-huawei>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-4-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
	<20260702-15-jun-hid-iio-alignment-v2-4-b87f01f5efbc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 02 Jul 2026 21:48:01 +0530
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
> Tested-by: Zhang Lixu <lixu.zhang@intel.com>

This one is more significant that the formatting change so I'll pick
it up now. Note that it does change the context for that formatting
change patch which touches the line below this change.

So applied by hand to the testing branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hid-sensor-humidity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> index 8dd8bc0b3ba1..b7130eac0394 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -216,7 +216,7 @@ static int hid_humidity_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	humid_chans =3D devm_kmemdup(&indio_dev->dev, humidity_channels,
> +	humid_chans =3D devm_kmemdup(&pdev->dev, humidity_channels,
>  				   sizeof(humidity_channels), GFP_KERNEL);
>  	if (!humid_chans)
>  		return -ENOMEM;
>=20

