Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07DA25A2C6
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019965; cv=none; b=BsWS7BG8j3ynvLgYszu8l9WssekxAxsU2qlJ8cQeTANChiqp2ke6RBwMhAe2RrJE8o2ZG2YrOl2munKvwAbcDZSvoCKeGhBN6fFkYmcYB+qi1XvzfGaskdFTxyjwIMH8kDwHJ8xGSvd/7jtIoHi0G+MHpBeNJZ18Fu57UWjadVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019965; c=relaxed/simple;
	bh=NAsYvsLcUhMrduMDbhTy6WbPPXOaIDlORx584rPaD/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIYlsjTcQkLM7ybxxbx3lpJGolyxXo69aPqndPjg7uJmkhdUAxMD+j34BZXSwyFxh/TS6T45s4XrzP/+ZPJk7/mEL7bz6H59gSwq8VbyOgSr10DGd2tlkdOmb1V0wztALXDsxBdDGWWrB4AKFEMz+/b9rRMlB36cZbm2A7T7SLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjatq3Qq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjatq3Qq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594AF1F000E9;
	Thu,  6 Aug 2026 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019961;
	bh=ic04l2dQrvUPoxi83+2RDTunyFMGmnyc+mFdljikp1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zjatq3Qq/QSh/KIl0qoi9ug7zBB8u8XiHqwQ07tnUOuG6PWsNEigyQGnl2qWB+j22
	 aMg1rR4fE94msY51ecCUZ3WMJNKZ2o3ZyQ6fGRq9QC3mvKmx9xB0a+UcDzjspkGKzR
	 EcwZwiB6woathVYAaJHwDGiVj0QOjw4Iy899l5eOaaOJkk9wmaI2LbnhmWR7H02unA
	 1vtxucvEb8v0sAp2q8DehSbCM502FlLPQZEpALFEGN6n1m5d6CfKd8oduNslgePwl+
	 vU4a9ELlHFrw7vG1xX78ZDJ4HMCPP6Z2LTfgQfzNFxqD7R8DMtMeJZ2ooGvrCFrBEG
	 8522sdqMfrxcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/13] iio: light: hid-sensor-prox: convert probe and
 teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-7-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-7-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:39:20 +0000
Message-Id: <20260806123921.594AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lack of synchronization between sensor hub callback removal and co=
ncurrent raw event execution leads to a potential use-after-free when the d=
river unbinds.
--

--- Patch [7]: [PATCH v5 07/13] iio: light: hid-sensor-prox: convert probe =
and teardown to devm-managed resources ---
commit 7c95d6a6926ff8d97206e6616bea5d2357682664
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Subject: iio: light: hid-sensor-prox: convert probe and teardown to devm-ma=
naged resources

Convert HID IIO driver resource management to use devm-managed helpers,
tying the lifetime of all resources to the device. HID trigger setup, IIO
registration, and sensor hub callback resource are now managed using devm A=
PIs.
This simplifies the probe path by removing goto-based error handling and
eliminates the remove callback entirely.

> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-=
sensor-prox.c
> index 5e28f9b7f40a1..355b7b02868ca 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
[ ... ]
> @@ -309,38 +310,14 @@ static int hid_prox_probe(struct platform_device *p=
dev)
>  	prox_state->callbacks.send_event =3D prox_proc_event;
>  	prox_state->callbacks.capture_sample =3D prox_capture_sample;
>  	prox_state->callbacks.pdev =3D pdev;
> -	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage,
> -					   &prox_state->callbacks);
> +	ret =3D devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
> +						&prox_state->callbacks);

[Severity: High]
This is a pre-existing issue, but does removing the callback lack
synchronization with concurrent raw events, leading to a potential
use-after-free during driver unbind?

When the driver unbinds, sensor_hub_remove_callback() deletes the callback
under dyn_callback_lock but returns immediately without synchronizing again=
st
ongoing events:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
		if (callback->usage_id =3D=3D usage_id &&
						callback->hsdev =3D=3D hsdev) {
			list_del(&callback->list);
			kfree(callback);
			break;
		}
	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);

	return 0;
}

Concurrently, if a hardware event triggers, sensor_hub_raw_event() can look=
up
the callback and execute its functions while holding pdata->lock:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
...
		callback =3D sensor_hub_get_callback(hdev,
				report->field[i]->physical ? report->field[i]->physical :
							     report->field[i]->application,
				report->field[i]->usage[0].collection_index,
				&hsdev, &priv);
		if (!callback) {
			ptr +=3D sz;
			continue;
		}
...
			if (report->field[i]->logical)
				callback->capture_sample(hsdev,
					report->field[i]->logical, sz, ptr,
					callback->pdev);
...
}

Because sensor_hub_remove_callback() doesn't wait for pdata->lock (or
otherwise synchronize with the raw event handler), the devres framework can
proceed to free prox_state while sensor_hub_raw_event() is still executing
and trying to call the now-freed capture_sample() or send_event() function
pointers.

>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_remove_trigger;
> -	}
> -
> -	ret =3D iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> -		goto error_remove_callback;
>  	}
> =20
> -	return ret;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D7
