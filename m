Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D238B7BB;
	Tue, 26 May 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810903; cv=none; b=RRac6MsxNXnDEaKwdLNxmzYktA9zEsgjA+d7achg4igqRQuV5qA6/8vGGJgZPZ+yi2xannZbiKv0cEdULTkH9FbD5Db//8W85P0LCDqB3nKmq/aS9rGOKTjENFSNTNzoygnUuxP+OcemSLhccBGKSQMa95D9K23Inz49cl6Hk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810903; c=relaxed/simple;
	bh=xQy283gCLbBhywV9MA7r/U/va4oIlNsHJ32anFRrfBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5fUa27BUY9mpPWkrc3BDwTIU3sPTtQb5Epyz5jKwIsCkAihoGnc1AVoGN5oltQS1ZErVOwftUedyKOxQhGF1gSZcRHNLRMeCSytsKXXB1Jw0EgxTw9OO4zjnlQcgFCmvygd/ydGeT2QNgif1/dbP3q//Hbl0Hvx6NgHftw0z9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeClol8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeClol8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC3D1F000E9;
	Tue, 26 May 2026 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779810902;
	bh=+yGJRf5SYmp9eRRyQn4/080JDtuOTCKqlhKMqKb5KyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JeClol8LMWf40eMF2uAXzAun3EBDJxDRV3UpBYdsjOFL4xu5caSOkeGFuMkfS4Wfs
	 rDjLzoIjGedXHs1DXVvoTYEOifbteINq7jYDZrXtgu3tJwBT6O29dfK55iDeR1Yx4F
	 VSLZvMI0AmZc2DTNU/KGCK8jjNDgo16gqKpCOUvbSuj46mkCgfobEfPjhCw4iAcxMo
	 vzGEKayxnaV+pn1NXsOcDogH0LtnQIc5/Ibabso/igQw7NfG9CclP67fJq677b9B1y
	 csbTG0suaI6s7mBtkM3OgkxjQQVpNsvuYN5YaCdPMg1Rc00UlV9r03U1qr0wTFhkLu
	 lADR8FCarXmLA==
Date: Tue, 26 May 2026 16:54:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jikos@kernel.org,
 srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 35/36] iio: pressure: hid-sensor-press: drop
 hid_sensor_remove_trigger() using devm API
Message-ID: <20260526165451.6a587221@jic23-huawei>
In-Reply-To: <39A229F0-436E-4AAC-82A4-9B04733E9EE3@gmail.com>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com>
	<20260524192943.1196773-6-sanjayembedded@gmail.com>
	<0a8ebbd2-5de6-48d2-9218-f7b816eb3455@wanadoo.fr>
	<39A229F0-436E-4AAC-82A4-9B04733E9EE3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 22:35:50 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 25 May 2026 3:39:11=E2=80=AFpm IST, Christophe JAILLET <christophe.jai=
llet@wanadoo.fr> wrote:
> >Le 24/05/2026 =C3=A0 21:29, Sanjay Chitroda a =C3=A9crit=C2=A0: =20
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >>=20
> >> Use devm_hid_sensor_setup_trigger() to automatically release resource
> >> during fail, unbind or removal of driver using devres framework.
> >>=20
> >> This simplify the setup, remove goto, avoid manual resource cleanup in
> >> teardown path.
> >>=20
> >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> ---
> >>   drivers/iio/pressure/hid-sensor-press.c | 10 +++-------
> >>   1 file changed, 3 insertions(+), 7 deletions(-)
> >>=20
> >> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pre=
ssure/hid-sensor-press.c
> >> index fee7dcb86801..8438498c9aeb 100644
> >> --- a/drivers/iio/pressure/hid-sensor-press.c
> >> +++ b/drivers/iio/pressure/hid-sensor-press.c
> >> @@ -291,8 +291,8 @@ static int hid_press_probe(struct platform_device =
*pdev)
> >>     	atomic_set(&press_state->common_attributes.data_ready, 0);
> >>   -	ret =3D hid_sensor_setup_trigger(indio_dev, name,
> >> -				&press_state->common_attributes);
> >> +	ret =3D devm_hid_sensor_setup_trigger(dev, indio_dev, name,
> >> +					    &press_state->common_attributes);
> >>   	if (ret) {
> >>   		dev_err(dev, "trigger setup failed\n");
> >>   		return ret;
> >> @@ -301,7 +301,7 @@ static int hid_press_probe(struct platform_device =
*pdev)
> >>   	ret =3D iio_device_register(indio_dev); =20
> >
> >Hi,
> >
> >Looks like devm_iio_device_register() would now make sense and simplify =
things even further.
> >
> >CJ =20
>=20
> Hi CJ,
>=20
> Yes, as mentioned in cover letter most of HID IIO drivers have potential =
and will converted to devm based driver gradually.

This is putting a lot of churn and many patches on a critical driver
(given this device is in a lot of laptops). As such I think it's fine
to do prep for devm in separate changes, but the final per driver change
should be one per driver to go fully devm rather than doing it in smaller
chunks.  I obviously want to see this well tested, and don't want to have
to keep asking people to test 'the next' set of changes.

Jonathan

>=20
> Welcoming all suggestions and especially if someone can validate and have=
 Tested-by tag.
>=20
> Thank, Sanjay
>=20
> > =20
> >>   	if (ret) {
> >>   		dev_err(dev, "device register failed\n");
> >> -		goto error_remove_trigger;
> >> +		return ret;
> >>   	}
> >>     	press_state->callbacks.send_event =3D press_proc_event;
> >> @@ -318,8 +318,6 @@ static int hid_press_probe(struct platform_device =
*pdev)
> >>     error_iio_unreg:
> >>   	iio_device_unregister(indio_dev);
> >> -error_remove_trigger:
> >> -	hid_sensor_remove_trigger(&press_state->common_attributes);
> >>   	return ret;
> >>   }
> >>   @@ -328,11 +326,9 @@ static void hid_press_remove(struct platform_de=
vice *pdev)
> >>   {
> >>   	struct hid_sensor_hub_device *hsdev =3D dev_get_platdata(&pdev->dev=
);
> >>   	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> >> -	struct press_state *press_state =3D iio_priv(indio_dev);
> >>     	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
> >>   	iio_device_unregister(indio_dev);
> >> -	hid_sensor_remove_trigger(&press_state->common_attributes);
> >>   }
> >>     static const struct platform_device_id hid_press_ids[] =3D { =20
> > =20

