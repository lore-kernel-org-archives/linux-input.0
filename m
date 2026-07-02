Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86133101C8
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011806; cv=none; b=qAGAySrxOYabxo8w5nDrSa0b1Ufl85N3cxyZzJHou2GwW3lUhE9Lpita/fwgfSaKPhMV6VG+Cl0PDDhccKfuCGX6PZCtztzDEPslvCKnX+MfmZugbQmexmk5zT8hoDaVavoISRMl3V94gf/mDpibV0k6v34qiSAeP56Lt5j04+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011806; c=relaxed/simple;
	bh=CMzNnloBiY2Q29+ec8GWWon2Ehh5rbRa73FJ1Py3gb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQ2+qtlb5g3ORDbeVwdYZWoliKyILvqWKYkL5wfStS7lOntsjR1VB6k/KI4x9OPWi75SOTI08t6YOextxJ4fnfuoYFBaZCshyG6VVyTDclqyEEOlS8ZfwCfG+1JlX7ue9uvl70tAyT2jIhlKqxYseMFgu2A4XWTwtQDtLJ1autk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlCjUL9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlCjUL9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F0B1F000E9;
	Thu,  2 Jul 2026 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011805;
	bh=oQzG5gXu6/bU81/lCkyMCjd/CqkJzX0oN16sVOtlYPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlCjUL9xHOi7ldX4NxvpuLXLJtjEI/tGeQO1UAlV2l05Cx+S5pK+KMJrp0HEIeao1
	 Grt+l8QPMotljvbJk6K1klQwzCyr7cPiCHUIvercXhPG72chca+6no9iB1CFJFoySV
	 Q3Q3ymFJm/VCWRhIEEPtk0AyHEhaB3resGJ18ccGj+fkOxmLlVwUucPqZ+fSCVtHXI
	 CpYvGWMhCkKKeF3fhdJ3SK6Dgn8RwEqQus3HEzK5mUVhrkdMCaAZJm/33hJT/VmlIc
	 wiu1YzU/tQQIgEu77dF/dlCqv6/8vcdHD0WPDpvF7kNkFE3TUQBe1kJUte0pvWwmc7
	 94xpGR/ETS+qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] iio: humidity: hid-sensor-humidity: use common
 device for devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-4-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
 <20260702-15-jun-hid-iio-alignment-v2-4-b87f01f5efbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:03:25 +0000
Message-Id: <20260702170325.83F0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Switching devres allocation for `humid_chans` from `&indio_dev->de=
v` to `&pdev->dev` breaks the IIO object lifetime model, introducing a Use-=
After-Free (UAF) vulnerability when the IIO device outlives the platform de=
vice.
--

commit 2c7cc72d2b1a34bface667809d68f3aaec43f667
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: humidity: hid-sensor-humidity: use common device for devres

This commit changes the devres allocation for the humidity channels to use
the platform device instead of the IIO device. The goal is to consolidate
devres ownership under a single parent device.

> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> index 8dd8bc0b3ba18..b7130eac03945 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -216,7 +216,7 @@ static int hid_humidity_probe(struct platform_device =
*pdev)
>  	if (ret)
>  		return ret;
> =20
> -	humid_chans =3D devm_kmemdup(&indio_dev->dev, humidity_channels,
> +	humid_chans =3D devm_kmemdup(&pdev->dev, humidity_channels,

[Severity: High]
Does this change introduce a regression if the IIO device outlives the
platform device?

If an in-kernel consumer obtains a channel reference via iio_channel_get(),
it increments the reference count of the IIO device (indio_dev->dev). This
allows indio_dev to outlive the platform device.

When the platform device is unbound, the devres framework will free
humid_chans because its lifetime is now tied to &pdev->dev. However, the
consumer will still hold an iio_channel structure where chan->channel points
into the now-freed humid_chans array.

If the consumer later calls APIs like iio_read_channel_ext_info(), could th=
is
dereference chan->channel->ext_info and access freed memory?

>  				   sizeof(humidity_channels), GFP_KERNEL);
>  	if (!humid_chans)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-15-jun-hid=
-iio-alignment-v2-0-b87f01f5efbc@gmail.com?part=3D4
