Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92D48C41D;
	Tue,  5 May 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998762; cv=none; b=K3+pPvlXq5K0HI2PidEqt4XS6c9Ei6bFUG0WXsQk6Ptc2uBrbDqXiFbIgKIOKykAElKuxtM0F/DD4Ykpb4gZ+XamneIxVC3g8jnW5jaMo0Jrk813iC0czGyoI/PQITbwXp8Mt6bHpq9SngrhUMEzhlh1MTOndDC+dXAdPWAH+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998762; c=relaxed/simple;
	bh=TZ41cIBjsX6I4sUdbZ6JVvTnjKVYGi3njK3h98YNW2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCwVY6WuzhWalX8vxOqSJfhIXPR3ZtTDAikKa0cNIdl66iT5pMqG9rJ9SnULv39j+va48u0vE0fzIQ+SuVkt1sL0e2rGp1zz/y7rzKTwZdIqQ5OKtiVDULstXCwxusnJHDVEHqOlBj3dbo8AYrENIEfvjlo8El6XaRTC4pY6aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjGKVp1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjGKVp1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11D4C2BCB4;
	Tue,  5 May 2026 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998761;
	bh=TZ41cIBjsX6I4sUdbZ6JVvTnjKVYGi3njK3h98YNW2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BjGKVp1Q3uQ13tFVsUqfRrsOkOe72qGvDvGmogjIry7VLRE/SmhvSRZQJ7m30ZZNP
	 Z6Kp31CEAMnGSQKFV8vheh59R3Ic9uW213WOxLKNPHmestdkq0C4DF6n7sFTnAJOpK
	 jqBJWw1z5mfB9FJuRfdh8hk+wlJz985qtRXfD88UPI5pczfXkf3UyWisFSQtrVr1e6
	 JfwvdkqKz7QEtlMtRW3jZzln3dIakVTGD7IFK9I0+EnS3X7KPTesIl3ZcrIYC4PM5H
	 j/ehgRW3ucHsK/pR6KvODZXSzQ9i7DrthU3l9J0yr0nRGYk1c85Ky6XyDW8ZqJoiJG
	 xak4UCF4W9sOA==
Date: Tue, 5 May 2026 17:32:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, jikos@kernel.org,
 srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: humidity: drop hid_sensor_remove_trigger()
 using devm API
Message-ID: <20260505173233.0b83f93c@jic23-huawei>
In-Reply-To: <CAHp75VdzPr+SLCPT85zw6aK8pSueBHr-OFpJ1Vmsow61e8=p4w@mail.gmail.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
	<20260429175918.2541914-5-sanjayembedded@gmail.com>
	<afJdJIQS1vwOcaGT@ashevche-desk.local>
	<12C22ED3-20F9-401C-ACC9-D666393B292A@gmail.com>
	<CAHp75VdzPr+SLCPT85zw6aK8pSueBHr-OFpJ1Vmsow61e8=p4w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 May 2026 21:25:35 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Apr 30, 2026 at 10:21=E2=80=AFPM Sanjay Chitroda
> <sanjayembeddedse@gmail.com> wrote:
> > On 30 April 2026 1:03:56=E2=80=AFam IST, Andy Shevchenko <andriy.shevch=
enko@intel.com> wrote: =20
> > >On Wed, Apr 29, 2026 at 11:29:18PM +0530, Sanjay Chitroda wrote:
> > > =20
> > >> Use devm_hid_sensor_setup_trigger() to automatically release resourc=
e =20
>=20
> resources
>=20
> > >> during fail, unbind or removal of driver using devres framework. =20
>=20
> failure
>=20
> > >>
> > >> This simplify the setup, remove goto, avoid manual resource cleanup =
in =20
>=20
> simplifies
> removes
> and avoids
>=20
> OR
>=20
> "This is done in a way to simplify..."
>=20
> > >> teardown path. =20
>=20
> ...
>=20
> > >> +    ret =3D devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_de=
v, name,
> > >> +                                        &humid_st->common_attribute=
s); =20
> > >
> > >I believe the first parameter is utterly wrong here.
> > >Or other way around, same issue but in the previous patch.
> > > =20
> > Thank you Andy for the review comment.
> >
> > It looks in same humidity probe of hid sensor with devm API two device =
pointer are used &pdev->dev and &indio_dev->dev; ideally all devm should ha=
ve same parent device for devres resource framework and over here preferabl=
e and consistent device should be &pdev->dev;
> >
> > I would first update existing devm_* API to have consistent device and =
on top of that will use same device in devm conversation.
> >
> > While for gyro change device is consistent as &pdev->dev across all dev=
m API. =20
>=20
> The idea is that you have to go deeply understanding the object
> lifetimes for the cases of different device instances along with
> userspace communication channels (all possible ABIs the driver uses).
> With only that the proper parameter may be chosen or even confirmed
> that device managed resources must not be used. Yeah, this is one of
> the downsides of devm_*() APIs.
>=20
FWIW it's always wrong from a design point of view to use iio_dev->dev
for devm.  It works but leaves us open to getting the ordering wrong
as some other stuff (including things you can't necessarily see explicitly
in a driver) will be using the parent device.

Jonathan

