Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25D42050
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331982; cv=none; b=YqWVVpB+YK+e/qHfOR9jouBiGEqSTHrnQmkKYq8qJ4iVug2jfu50oBhe2NwFnqIgLaKRaVlvOF9BmwUBx+4y05hbgCWlhRlOJAfN3CUvyOpFv13XTn5zdbH3eRsEvIRGlFPdo/hZ56xCnzlFgegSTEE+O1dP3xGiVbzD9o4C8OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331982; c=relaxed/simple;
	bh=A1GL/pha6K0jyc1DFWZ5gc1PvKbxLIcbkqp8wLrFGJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sW2dhnwNWklbrKHOH2JhOTNhaMWzsOsDJCuVlqsdo01csfZFwn8IAOXuoFtIpTJMiAUNVdec3pw0ou5XgI6vhBc5CkQcdQOQzPQZ0WpIrMJvJtCU04xDIVknl3IyMignqnWRZj6p0OLHcEhw75qjmliBKBr0Tihaqna6xTapFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm5fiRgb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm5fiRgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7770C4AF0D;
	Sat,  9 May 2026 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778331982;
	bh=A1GL/pha6K0jyc1DFWZ5gc1PvKbxLIcbkqp8wLrFGJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Wm5fiRgb2x5TwIO1zrk/92GDzSaJorSFpWOxTUCaAzwTRz+1PckNA1WPdBSVr6FNy
	 RTQYUkPldGaUs1fIqcpYhsD10EwxGEYPt5snu6HHhOOf22D463ETSfEfni3xfVnt+Z
	 C3FB1RwmYKuPqPC7XMlCxwa1WhH5B3vWIQbz957ZvgZ+GaIjc1OxjyEAtKImmn2nzS
	 BNJGYvT97KBvHD0B2OnzlWgmMp+G4uv3gDAZ9BxeQZ7FXjlFPZyiO+IMHOEJQnk/1q
	 bsua/etbnCCwbx4EbdW0nJFrMCUktSaOFOFUgy5c8w9WroXnA1i8u6xNL9qQmnqMte
	 vHIAn1H8QLdvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] iio: humidity: hid-sensor-humidity: use common
 device for devres
Reply-To: sashiko@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260509101040.791404-8-sanjayembedded@gmail.com>
References: <20260509101040.791404-8-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 13:06:21 +0000
Message-Id: <20260509130621.D7770C4AF0D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free due to lifetime mismatch between IIO device and pla=
tform device devres
--

commit 2edcf899b7cb430d80f56a0ef1506dd20ea46d9d
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: humidity: hid-sensor-humidity: use common device for devres

This commit changes the devres allocation of humidity channels to use the
platform device instead of the IIO device. The goal is to have a single,
well-defined parent device for devres ownership.

> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -215,7 +215,7 @@ static int hid_humidity_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	humid_chans =3D devm_kmemdup(&indio_dev->dev, humidity_channels,
> +	humid_chans =3D devm_kmemdup(&pdev->dev, humidity_channels,
>  				   sizeof(humidity_channels), GFP_KERNEL);

Could this change introduce a use-after-free if the IIO device outlives the
driver binding?

The indio_dev object is allocated using devm_iio_device_alloc(), meaning it=
 is
reference-counted and its lifetime can exceed the platform device binding if
consumers hold a reference.

If the driver unbinds, the pdev devres callbacks will execute and free the
humid_chans memory. However, indio_dev->channels still points to this freed
array.

If a consumer later calls IIO APIs like iio_read_channel_ext_info(), they
will dereference the freed humid_chans memory.

>  	if (!humid_chans)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509101040.7914=
04-1-sanjayembedded@gmail.com?part=3D7
