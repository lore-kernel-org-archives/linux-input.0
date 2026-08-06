Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E45223BD06
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020268; cv=none; b=FwCXCuvcBsLW7VS5iLe21xXArC6dfn7nKx1SP7HLyW+dT6TA2qErJ1H0GVtz5szam2/8dbRn+mgla09T9nHUDQMtE967EEBKiOdEik3L9ibxWgsu92DGsr6b9lWMZ+BIZaPGogCisFgvhCD5hP7Hkc738khEkV4oFKD0QuLN2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020268; c=relaxed/simple;
	bh=XZoV+E7tmgc6GFaHrrYnqMjIEYS04y+PnsWZqZnXo2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OvTyeoRedbt6wPI472x5oSw9osWlE35ed5hURAmUTNcUqR5TNLnhgMAhgLk4GVHQf0g2p6Jue3YASuU8RCkEOTFbUBZJorbbdp28a97Kms2JnNKY/0susE3xCSMsNHnGve9Oz8VYMGK2Z1r1WDpui0hPxn4N9idejWjtwINoCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy+lD5eU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy+lD5eU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FFE1F000E9;
	Thu,  6 Aug 2026 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020266;
	bh=2IPoL/mmDo4EIUCheyhD9c2Kkz3oVbo2IjIqeXQEBFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oy+lD5eUmYCBQBst2jV4coPmoBe38KdFcUa6hFwYr2vVkrWkY4Jy3JmB3+NgfCqU0
	 LyqHUV8vvhunPgsQfyV4DGBpcTe9e3oJujvU6pf7BLdFagpsM8i+ZIfV54A+zR/uOb
	 jBuSK2coziSZUfQuhaByTNF6ou+NdJD6t8wYb0VCZq7wWOKFm39MIdjrEEDmylLeUY
	 Bvy5iDYLvihs9iVaHo1/UuixpiA1f3ergU1i7x2hgw2IhVMWERuh+p4NU1T+X16GRz
	 Tq23FDgMTnfw7R316CX2gM/QCL5u90xbvLAjiJicWj4DmC3J6G68wbEH+rKtodp57P
	 8nCsSxkZu+WOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/13] iio: pressure: hid-sensor-press: convert probe
 and teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-13-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-13-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:44:25 +0000
Message-Id: <20260806124426.B2FFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrency UAF during device unbind between `sensor_hub_raw_event=
` and `sensor_hub_remove_callback`.
--

--- Patch [13]: [PATCH v5 13/13] iio: pressure: hid-sensor-press: convert p=
robe and teardown to devm-managed resources ---
commit 45fb35e2b8f4da70b5748e13b1091b8fdbd11a47
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: pressure: hid-sensor-press: convert probe and teardown to devm-managed=
 resources

The commit converts HID IIO driver resource management to devm-managed help=
ers.
This ties the lifetime of all resources to the device and simplifies the pr=
obe
path by removing explicit error handling and teardown paths.

> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressu=
re/hid-sensor-press.c
> index 4e0f42fefd6b4..8ebb8f54a0cb9 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
[ ... ]
> @@ -288,38 +289,15 @@ static int hid_press_probe(struct platform_device *=
pdev)
>  	press_state->callbacks.send_event =3D press_proc_event;
>  	press_state->callbacks.capture_sample =3D press_capture_sample;
>  	press_state->callbacks.pdev =3D pdev;
> -	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_PRESSURE,
> -					   &press_state->callbacks);
> +	ret =3D devm_sensor_hub_register_callback(dev, hsdev,
> +						HID_USAGE_SENSOR_PRESSURE,
> +						&press_state->callbacks);

[Severity: High]
This is a pre-existing issue, but can unbinding this driver race with event
delivery and cause a use-after-free?

When the child driver unbinds, devm triggers sensor_hub_remove_callback(),
which removes the callback from dyn_callback_list and frees it using
dyn_callback_lock:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
		if (callback->usage_id =3D=3D usage_id &&
						callback->hsdev =3D=3D hsdev) {
			list_del(&callback->list);
			kfree(callback);
			break;
		}
	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
    ...
}

After this, devm frees the IIO device's private data (press_state).

However, there doesn't appear to be any synchronization to ensure that a
concurrently executing sensor_hub_raw_event() on another CPU has finished
using the callback pointer.

If sensor_hub_raw_event() is actively dispatching an event under pdata->loc=
k,
could it invoke the callback with a stale pointer and write to freed memory?

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
		if (callback->capture_sample) {
			if (report->field[i]->logical)
				callback->capture_sample(hsdev,
					report->field[i]->logical, sz, ptr,
					callback->pdev);
			else
				callback->capture_sample(hsdev,
					report->field[i]->usage->hid, sz, ptr,
					callback->pdev);
		}
    ...
}

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
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D13
