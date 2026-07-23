Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDE41D655;
	Thu, 23 Jul 2026 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850685; cv=none; b=hrZ+myd7XfNk6hmyMmT0LFopEfc0kwEbTGcaOqEa4hoJcf9QuVVTRJxoAofxDhLLnbtnIjdmVjhMnLWM4ZOtpnjCvTOo6GaDPQ5dYPNeuFLeLXonVXVDddwJVYNDoe/pScgR6E/z/VnwPediA1XWplQZSCweAWKXEfLxz9d9A+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850685; c=relaxed/simple;
	bh=ZJXzpyufsw8PwYbtgfI9jUDAXQWxNWitsQruLI8peoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cl0aIgoph786okH5KQep50dyOxcsu/KY4ZDV6rnXyZPHCMZ0IHFHgDBrIBNM+EyKmAz95Y7+u34Q5joS6NelkSl5zDnjqTpDT4cbt4uXFL7UGfmfWYQmKiSATFEUpQPOC7jE8FR6G2cr2oIt6DzOWVfttj2LX50irYrwncZxWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4B75ydc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4B75ydc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFE21F000E9;
	Thu, 23 Jul 2026 23:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784850678;
	bh=9UvHGaa4uuWjAN3PDl73G2JnGET5WJfOkxk/QHOe+Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c4B75ydcbkj8bbYMTDPQ2ptLq7IyOjAQmnKF48/vMVaHc+UQ7bOS1RCHrQunPU1Yj
	 +fydKaTnb6VXacgB9jhmzl9XURVz0//mwC9UuxJDvu/3xJ2q3hqa5GveUA4f+p1rMK
	 YPNCBl7nU8Lxfz1eZnWfmr/fNUfnaW92N4GYpGfOysx4aKhsYyhLyKGMNXuO2lbV+t
	 HPe28FmlQt/AJ4hGmw/qoXMOhCOBCsHoP6BAR/7FP5MQ3a983cUjC0U4LYksH9ORGY
	 xHOC7Au7k8BuKY2RW3h2u6JWd09eFqRfiLsMRBfi59WJIw2plVLwmCMMp/KSIPLeTq
	 1qf2FHBkEC04g==
Date: Fri, 24 Jul 2026 00:51:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: gyro: hid-sensor-gyro-3d: use local struct
 device
Message-ID: <20260724005113.6cc58644@jic23-huawei>
In-Reply-To: <al54b953O6JXcbU6@ashevche-desk.local>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
	<20260720-hid-iio-local-struct-device-v1-2-74496fee6327@gmail.com>
	<al4MeTgAWWkJsb1T@ashevche-desk.local>
	<1E009860-0A0F-4F8D-8017-CE5739F22144@gmail.com>
	<al54b953O6JXcbU6@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026 22:35:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jul 20, 2026 at 10:20:28PM +0530, Sanjay Chitroda wrote:
> > On 20 July 2026 5:24:33=E2=80=AFpm IST, Andy Shevchenko <andriy.shevche=
nko@intel.com> wrote: =20
> > >On Mon, Jul 20, 2026 at 03:10:14PM +0530, Sanjay Chitroda via B4 Relay=
 wrote: =20
>=20
> ...
>=20
> > >> -		dev_err(&pdev->dev, "failed to setup common attributes\n");
> > >> +		dev_err(dev, "failed to setup common attributes\n");
> > >>  		return ret; =20
> > >
> > >Nope, First one (to eliminate a lot of churn) should be to convert thi=
s and
> > >similar to use
> > >
> > >		return dev_err_probe(...); =20
> >=20
> > Thank you for your input.
> >=20
> > I'm planning to have a incremental series: first introduce a local "dev"
> > pointer, then convert the resource management to "devm_*", and finally
> > replace the remaining error reporting with "dev_err_probe()".
> >=20
> > This keeps each series focused and avoids introducing intermediate patt=
erns such as:
> >=20
> >    ret =3D dev_err_probe(dev, ret, ...);
> >    goto error;
> >=20
> > Once the cleanup paths are removed, those sites naturally become:
> >=20
> >    return dev_err_probe(dev, ret, ...);
> >=20
> > Does this approach sound reasonable? =20
>=20
>=20
> No. First you should drop the dead code for sure (see above).
> Second, try to convert to dev_err_probe() as many drivers as you can with=
out an
> intermediate change. If the driver requires an intermediate thing like th=
e above
> it means it requires bigger refactoring. So, you should not have intermed=
iate
> churn. With your current approach there are drivers that will have it, an=
d for
> them you need to have different strategy (see my proposal in the above li=
nes).

Note it is fine to bring in struct device *dev =3D ... as part of any
other cleanup change where it shortens things.=20

Once you have done the more significant changes, chase them with a patch
in the same series to make use of dev in any remaining places.

The trick is to do all cleanup that is trampling on same lines in one
series so things like leaving a few cases to sweep up at the end in
a trivial patch look sensible.   Give you are working on a lot of
drivers, perhaps to keep things manageable you should clean up one or
two completely in a series then follow up with additional series to make
similar changes in the rest.

Jonathan


>=20

