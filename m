Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E637F000
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747755; cv=none; b=NcEKuTawVxx671I11YZFqiAG94jLmTER4B06boHh2rsyrKiYxldmdPkFVfLhu0Ogb+Lt9tMezEMBBejybFl4CZLa0fLEITdkI3Pl4yF8NQ2g8kqeA6E9xZujmLIXfwoSBnF4q65DUNq8GAAPcIMw2vEcKTokYLLH/nApXXH0+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747755; c=relaxed/simple;
	bh=kxmRi3AXFVlJcKEGcfosua7Py8L7QvNqKu5BEL78Ess=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t8Bh/H2ZidmiKejHeYkzC4D2rHHCnUUi0B5TJbaymgHFa4ii4kQOoCGsC0/O3FINMq0aTfZamaP0SqkXQXEV9jsvr8JuEYgLl7ovlKEBDgrvmDnm8IaHRZ55qnKBg5bTEfJbHWm/FMdoyfHtXggMkYAzUMEqn9iTKR5RDI9G+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpzSCjPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpzSCjPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897801F00893;
	Sat,  6 Jun 2026 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780747753;
	bh=cNWeZDprNWUnFoYLLuiVgGQgV1Qcuz/iJwFJ/VPo7HE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QpzSCjPYxfQyPnhKnYxE8y5iQrTruhb/n1WN0L8zjBWZZvOA4jWPZNs3juTe6kKcX
	 T6TO1FEjVDpEfmddxbEz55nbUml1hGDXzi/IeHwpWaS8esAozev6HOrrgyEOZTJNLk
	 YBN1VCSvD5FIbFudSsJdy2M7nDYjV5sLYVVLZKZ0eSeE09Or2oZ98GhiggXpzdWNPT
	 S8gE/nQjxeZJZEPRcArnNT3bE9+Dalf/fI8pVj9nQvq0K2nV0jDTQg5SL24NOZiK6e
	 4M9uBlD6BD1X9dWUmLJCCCQmuoXT7s+Pblg1eKZH3gq56080DMPu+M+KA7eOHh59KR
	 J/oNjwCTLL0Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-5-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-5-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:09:13 +0000
Message-Id: <20260606120913.897801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Explicitly calling `iio_device_unregister()` before stopping the h=
ardware data source causes a hard lockup.

Pre-existing issues:
- [High] The driver uses a single global static `struct hid_sensor_hub_call=
backs temperature_callbacks` which is modified during `probe()`. If multipl=
e temperature sensors are probed, the `pdev` pointer within this global str=
uct is overwritten by the most recently probed device. This causes events f=
rom all sensors to be routed to the last probed sensor's IIO device, leadin=
g to data corruption. Furthermore, if a sensor is removed, the remaining se=
nsors will dereference a dangling `pdev` pointer when handling events, caus=
ing a Use-After-Free.
- [High] The sensor hub remove callback lacks synchronization with active e=
vent processing, leading to use-after-free on module unload or device unbin=
d.
--

commit 40b43e4e8d671ec0d491c5e0ebefd5ffcf97e7ad
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_reg=
ister()

This commit switches from devm_iio_device_register() to the non-devm
iio_device_register() to avoid mixing devm APIs with goto-based unwinding.
It adds an explicit iio_device_unregister() call in the teardown path to
ensure deterministic cleanup.

> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 9f628a8e5cfbe..34bff7e9f3a33 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -244,7 +244,7 @@ static int hid_temperature_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		goto error_remove_trigger;
> =20
> -	ret =3D devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> +	ret =3D iio_device_register(indio_dev);

[Severity: High]
This isn't a bug introduced by this patch, but does the driver use a
single global static struct hid_sensor_hub_callbacks temperature_callbacks
which is modified during probe()?

If multiple temperature sensors are probed, the pdev pointer within this
global struct is overwritten by the most recently probed device:

drivers/iio/temperature/hid-sensor-temperature.c:hid_temperature_probe() {
        ...
        temperature_callbacks.pdev =3D pdev;
        ret =3D sensor_hub_register_callback(hsdev,
                                        HID_USAGE_SENSOR_TEMPERATURE,
                                        &temperature_callbacks);
        ...
}

This causes events from all sensors to be routed to the last probed sensor's
IIO device, leading to data corruption.

Furthermore, if a sensor is removed, the remaining sensors will dereference
a dangling pdev pointer when handling events, causing a use-after-free.

>  	if (ret)
>  		goto error_remove_callback;
> =20

[ ... ]

> @@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_de=
vice *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct temperature_state *temp_st =3D iio_priv(indio_dev);
> =20
> +	iio_device_unregister(indio_dev);

[Severity: High]
Does explicitly calling iio_device_unregister() before stopping the
hardware data source cause a hard lockup?

The modified teardown order unregisters the IIO device before the sensor
hub callback is removed. This function deletes the buffer from the IIO core
buffer list.

Concurrently, incoming hardware interrupts can invoke
temperature_proc_event() which locklessly iterates over the same buffer
list using list_for_each_entry().

If list_del_init() executes concurrently during the iteration, the lockless
traversal can enter an infinite loop. Because the event handler executes
with IRQs disabled, this could cause a hard lockup.

>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);

[Severity: High]
This is a pre-existing issue, but does sensor_hub_remove_callback() lack
synchronization with active event processing?

When sensor_hub_remove_callback() unlinks the callback from
dyn_callback_list, it returns immediately without waiting for concurrent
executions of sensor_hub_raw_event() to finish.

Since the raw event handler drops dyn_callback_lock before executing the
callbacks, remove() can complete and trigger devres cleanup while the raw
event handler is still actively dereferencing the IIO device on another
CPU, potentially leading to a use-after-free.

>  	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D5
