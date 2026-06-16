Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250235A3A4
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609241; cv=none; b=JC2KOqPkyzRoKw7zyQAEd8iqb1W0ZCd31wP3Uxga4Q3NikSge91wCvvvsUxRNWlDBadeZtvy01y0MNvHtSwb5aRBuZvd9yrld9+HK35ePnszMXilRoraAlP5+pfYP36Xwv6P5MURwOyTz2s012VHE5MeLZUIDzCHmt3vntpvcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609241; c=relaxed/simple;
	bh=I215KJJTlrLzfiwOfyRBhyvbGns9JvC4eDcuby21uTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IhqcSmSvpXvcrCeFHMNVeS76WIi0glqitQk06uAZQloBllOCGnFiy5WoumOWW+5E88YFPCLbBwco2knDqsnHqTp0ObZrD34e7/LuEJ9RNFZNGJkqa8f3fzdZGzkpP99ZhfOpZVjYF0tNu3fTf8AZc35bUUIXzTSZOfI5pghyfOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu2hbWlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu2hbWlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F17F1F000E9;
	Tue, 16 Jun 2026 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781609240;
	bh=tqZB9U/zPw3nVeWSh7TcICb4IdBzeKmqPF1ibclwRcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vu2hbWlNJJtfYH/y0/hxNU/mGQpA10sxxyk9aL6BMVm/7+aOl8EIOXcwHU8Ze159j
	 KD7IC1W7QBWctKdTW+O/qiHJaMG+9PKY0lX6d6P/Ve8xzjPZoYHV5dDcZcmRYvUFwf
	 iRKxE4BChuYQwln9p1dsj+xN+Ds6h+c+JKlFkicM4rNlm6dtiIZHDu3HYteZ1vyzoR
	 7CH7CcbgONLZzAV/4om11HaCXOH8s4m84TrjHE9ufJguijgP9Sb4r7fVB+AXtFf90b
	 jWHw3Ytj+yF8he2Oz6xRbsaFkJ/I2psvvmLVBOrOUXfc+vISKEU22KMqls+xxSPmw3
	 y+Zsbu/juXTJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] iio: temperature: hid-sensor-temperature: use
 common device for devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-7-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-7-0cd544286575@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:27:19 +0000
Message-Id: <20260616112720.3F17F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of IIO channels array when in-kernel consumers hold=
 references past driver unbind.
- [High] State corruption due to overwriting a static global callbacks stru=
cture during probe.
--

commit 92f73ed0d62d832f9bf6d6b90aa841b134a7d14d
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: temperature: hid-sensor-temperature: use common device for devres

This commit updates hid-sensor-temperature to allocate memory using the
platform device instead of the IIO device. This unifies devres ownership
under the platform device for deterministic resource release.

> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 9f628a8e5cfbe..31ebfd1a1fe2c 100644
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

[Severity: High]
This isn't a bug introduced by this patch, but does using devm_kmemdup()
for the IIO channels array tie its lifecycle to driver unbind rather than
the IIO device's reference-counted lifecycle?

If an in-kernel consumer holds a reference to the IIO device after the
provider driver unbinds, the consumer might access the freed channels array
through its cached iio_channel pointer (e.g., via
iio_read_channel_ext_info(), which does not check if indio_dev->info was
cleared).

Could this lead to a use-after-free? Would it be safer to make the
channels array part of the iio_priv structure so it lives as long as the
indio_dev itself?

>  	if (!temp_chans)
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but looking further down in
hid_temperature_probe(), is it safe to assign pdev to a global static
callbacks structure?

hid_temperature_probe() {
    ...
    temperature_callbacks.pdev =3D pdev;
    ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATUR=
E,
                    &temperature_callbacks);
    ...
}

If a system contains multiple HID temperature sensors, would probing a
second sensor overwrite the pdev pointer with the new device instance?

When the sensor hub receives an event for the first sensor, it might fire
the callback using the pdev of the second sensor, pushing data into the
wrong device's buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-15-jun-hid=
-iio-alignment-v1-0-0cd544286575@gmail.com?part=3D7
