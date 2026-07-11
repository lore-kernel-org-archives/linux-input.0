Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C5209F43;
	Sat, 11 Jul 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809033; cv=none; b=qG5CHSSWC4uuXac/VNt8u1p6dPXGehQBXPq3y2vsvqLCwBUHjfoNlmXUKGNwwG6Rc0Tq7YZIgnDbfHH7kl87OLuUu7giUhg1qLk/b7efAQIzWx+wDKxjAxFdhiVFLRBJbK3UZh3Z6dzSB6B47svWViV1Pmr9Ohuxw+ES0psvsvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809033; c=relaxed/simple;
	bh=supmCUVaXd1obGV0yvr+xSJ3mQ5JGRtH8m6Moq53ekM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTmeEXvhzdtfewNhzSd3d26skteMNEXPTJjD6AKHY9rno8opEhhAN3HIpvdBL1eu1wuxMxNpClYr6VSxR4OK/QAZg28aKjkr0nX8y46/Wn5izEWntJCBNDX17ZORuz2E1+1spyleUcdElMU7ORKRSrFimX7jOQ6AKEpbDOQLOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGKF5HRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGKF5HRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FED1F000E9;
	Sat, 11 Jul 2026 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783809032;
	bh=8g5HW2uwhShdm/MWyNcydXrPVZ7yuPXO7mNgxYu2iXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FGKF5HRpmS9MGtk6688vi9M2HdBjhsHhgPZjjgjHz7OFB0tgF2E89s03npU2KCPa2
	 vvD/AwKwaVfiYSPaI/y8C9YKGExqZ6lkCe6R8JE9qqb+WgqetWlzsm5GTz9fAURJvM
	 FSopUJEZ3DSm5M63TZMBxt2xdOuNhkb+C6G+dq9+lPwJ0uTZe4eXoCu9vTRguYhQPm
	 D290NFzYZiArI5NTZtoTGHmnKeg3TKfrWBFWRM6XiMYnS1HTtkf58YCBhjOFFSo/x+
	 uuTwMfkut7o7Pdayc9wsMIeaaRuM93Wpy71+e3OPd6yOq3KD5q0zlw3ctZG/I6ChRZ
	 Vb2i3Fg+HHgvw==
Date: Sat, 11 Jul 2026 23:30:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hongyan.song@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Message-ID: <20260711233024.495e3e55@jic23-huawei>
In-Reply-To: <086180fe0da41a5e8ce1b130483996a366f588ea.camel@linux.intel.com>
References: <20260625121611.2003780-1-sanjayembedded@gmail.com>
	<086180fe0da41a5e8ce1b130483996a366f588ea.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Jul 2026 16:25:41 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Thu, 2026-06-25 at 17:46 +0530, Sanjay Chitroda wrote:
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >=20
> > Avoid using devm_iio_device_register(), as this driver requires
> > explicit
> > error handling and teardown ordering.
> >=20
> > With devm_iio_device_register(), IIO device remains registered until
> > the
> > devres cleanup phase. However, driver's remove() callback removes the
> > sensor hub callback and trigger support. This can create a race
> > window
> > where IIO device is still visible and read_raw() requests are issued.
> > These requests might call sensor_hub_input_attr_get_raw_value(),
> > which
> > waits up to 5 seconds for a response from the sensor hub callback
> > that
> > has already been removed.
> >=20
> > Add an explicit iio_device_unregister() call in the teardown path to
> > ensure deterministic cleanup, so that userspace can no longer access
> > the
> > device once backend resources begin to be dismantled.
> >=20
> > Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >  =20
>=20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to the fixes-togreg branch of iio.git.

Note that to take anything non fix related on top of this will require
me waiting until this is upstream.  I'm not sure how many fixes
I'll have outstanding (and so if I will soon reach critical mass)
but most likely that will be at least a few weeks at least.

Thanks

Jonathan


>=20
> > ---
> > Changes in v2:
> > - Added review tags of Maxwell and Andy along with stable Cc
> > - Based on input from Srinivas and investigation use-after-free
> > =C2=A0 explanation was not sufficiently justified so updated the commit
> > =C2=A0 message with appropriate information and kept Fixes tag
> > - Link to v1:
> > https://lore.kernel.org/all/20260622052135.1804135-1-sanjayembedded@gma=
il.com
> > ---
> > =C2=A0drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> > b/drivers/iio/temperature/hid-sensor-temperature.c
> > index a8d3a15f9c53..ab6ec8f659b8 100644
> > --- a/drivers/iio/temperature/hid-sensor-temperature.c
> > +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> > @@ -244,7 +244,7 @@ static int hid_temperature_probe(struct
> > platform_device *pdev)
> > =C2=A0	if (ret)
> > =C2=A0		goto error_remove_trigger;
> > =C2=A0
> > -	ret =3D devm_iio_device_register(indio_dev->dev.parent,
> > indio_dev);
> > +	ret =3D iio_device_register(indio_dev);
> > =C2=A0	if (ret)
> > =C2=A0		goto error_remove_callback;
> > =C2=A0
> > @@ -264,6 +264,7 @@ static void hid_temperature_remove(struct
> > platform_device *pdev)
> > =C2=A0	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > =C2=A0	struct temperature_state *temp_st =3D iio_priv(indio_dev);
> > =C2=A0
> > +	iio_device_unregister(indio_dev);
> > =C2=A0	sensor_hub_remove_callback(hsdev,
> > HID_USAGE_SENSOR_TEMPERATURE);
> > =C2=A0	hid_sensor_remove_trigger(indio_dev, &temp_st- =20
> > >common_attributes); =20
> > =C2=A0} =20

