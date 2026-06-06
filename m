Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E69CA4E
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747999; cv=none; b=IwWOnE2l2W8WkVflwb20hFkC43mTgOXL5ppVZiN4u0Tt7ZGnRl2fpz2UMNOHUIWv/4+G+gbdXV3lM6Xum5fOYc51mVC7I7YA0T1Hw+vlnJRblSTMbfNcTTg9KWAsGUDVPmSxE1ZG1D9OaTwxhaggEb3mjPtHSlt7D/lX7p/AwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747999; c=relaxed/simple;
	bh=UUnT816vRj405F6KlXJ37mTu1B/lpPruzbISJAZ3kew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxdn+Gjdjf7ZUkJTAD6Qz6eQgbsjj+i7oD09+Mt1X80JOqBKL3oJmqhhdPPo5/QRs/eJKUTtPc8WQ1AxaYdKmIcHNJjujtzN/TBy0uipHns4/JDjhawz1kh9oeaLRlQWWv58CfJwimO4g6jpa47uOSmlDavrLZO+sCosdIXc1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7w7TniT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7w7TniT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498661F00893;
	Sat,  6 Jun 2026 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780747998;
	bh=r7amO1AEpvHgqwoYXlPBOACRFewRss182crWUSMHr8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K7w7TniTLBLzWDKIL2drX4EW3ta0VqFysQWml8Sq0v3pgMfqBo9bDYj32vHYUsLKM
	 EwkOki6LFP7c7izoG7Lz2JNuiiPFonl6gCcXICbiBqCW7JUWQUQr0kAm7j+7RLOaYl
	 AMTe8yfGiSEOhXqsCC0FzHh6nqyXyq7316+ijmtgJ0p2IlMLxGW4AGpXV3qtR9GgKk
	 Fz4tJsMTZpC92kAOXGzW/FE4hbxUrPh27Qwt5CbHvgj+KoIhlaBP+27kZS8eL33IL0
	 YSeMsffFFlRdsvXL05srztcixTyPlfxi3lvW4+4sudadNrPFavqdUj6q7a8/1H54pQ
	 FaGlabF+muDag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] iio: light: hid-sensor-prox: Fix race between
 callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-6-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-6-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:13:17 +0000
Message-Id: <20260606121318.498661F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Reordering `iio_device_unregister()` before `sensor_hub_remove=
_callback()` introduces a critical data race that can lead to an infinite l=
oop, list corruption, or Use-After-Free during device teardown.

Pre-existing issues:
- [High] Lack of synchronization in `sensor_hub_remove_callback()` fails to=
 flush in-flight events, causing a Use-After-Free of devres-managed memory =
during probe failure.
- [High] Incorrect parsing of little-endian HID report data using host-endi=
an pointer casts.
--

commit 60bbe69d1f4ccbb5130ebd8324841d9eca79e70a
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-prox: Fix race between callback registration and dev=
ice exposure

The driver registers the IIO device before completing sensor hub
callback registration and unregisters callbacks while the IIO device
is still exposed during teardown.

This creates race windows in both probe and remove paths, which can
lead to NULL pointer dereferences or use-after-free.

Fix this by correct ordering of callback registration and
IIO device registration in probe and remove paths.

> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-=
sensor-prox.c
> index edc9274a2c076..3df7f28d3b445 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c

[ ... ]

> @@ -325,13 +319,19 @@ static int hid_prox_probe(struct platform_device *p=
dev)
>  					   &prox_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_iio_unreg;
> +		goto error_remove_trigger;
> +	}
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device register failed\n");
> +		goto error_remove_callback;
>  	}

[Severity: High]
This is a pre-existing issue, but this patch newly exposes it in the probe
error path by moving callback registration before iio_device_register().

When hid_prox_probe() fails here and completes, devres automatically frees =
the
indio_dev and prox_state structures.

sensor_hub_remove_callback() acquires pdata->dyn_callback_lock to remove the
callback from the list, but it does not wait for currently executing callba=
cks
in sensor_hub_raw_event() (which run under pdata->lock) to complete.

Could a still-executing event handler on another CPU dereference the freed
memory, leading to a Use-After-Free?

> =20
>  	return ret;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  error_remove_trigger:

[ ... ]

> @@ -344,8 +344,8 @@ static void hid_prox_remove(struct platform_device *p=
dev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct prox_state *prox_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: Critical]
Does reordering the teardown sequence so that sensor_hub_remove_callback()
runs after iio_device_unregister() leave the sensor hub callback fully
active while the IIO device is being dismantled?

iio_device_unregister() calls iio_disable_all_buffers(), which iterates over
the buffer_list using list_del_init() and frees internal state. Concurrentl=
y,
incoming hardware events trigger prox_proc_event(). While
iio_disable_all_buffers() eventually decrements data_ready to 0,
prox_proc_event() checks data_ready without any locking.

If prox_proc_event() observes data_ready > 0 and calls iio_push_to_buffers()
concurrently with buffer teardown, will it perform a lockless list traversal
over the actively modifying buffer_list?

drivers/iio/industrialio-buffer.c:iio_push_to_buffers() {
	...
	list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {
	...
}

Could this concurrent modification cause the iterator's next pointer to bec=
ome
self-referential, resulting in an infinite loop, or access freed memory
causing a Use-After-Free?

>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at how raw data
is handled in prox_capture_sample() from drivers/iio/light/hid-sensor-prox.=
c:

	switch (raw_len) {
	case 1:
		prox_state->human_presence[chan] =3D *(u8 *)raw_data * multiplier;
		return 0;
	case 2:
		prox_state->human_presence[chan] =3D *(u16 *)raw_data * multiplier;
		return 0;
	case 4:
		prox_state->human_presence[chan] =3D *(u32 *)raw_data * multiplier;
		return 0;
	}

The raw data received from the HID sensor hub is in little-endian format as
per the HID specification.

When raw_data is directly cast to u16 * or u32 * and dereferenced on a Big
Endian architecture, will this host-endian read result in incorrectly swapp=
ed
bytes, producing corrupted sensor readings?

Furthermore, since raw_data points directly into the unaligned HID report b=
yte
array, can this cast trigger an unaligned memory access exception (kernel o=
ops)
on strict architectures? Should this use get_unaligned_le16() or
get_unaligned_le32() instead to correctly parse the little-endian data stre=
am?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D6
