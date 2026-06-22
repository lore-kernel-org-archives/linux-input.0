Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825F241C8C
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106969; cv=none; b=VDfrl7r8owRMdbo72W+g2tzMwgxeg8YrGTW2Dv4KJlAjIBXXQuU3ORlOvTxfVvA5IWj0Ehy7ug7tksZw518hqf/Je4/sNPi+o7jYD3MS2xewOGe+QUBhqfXJlzR6ualZNAD1kqsLvqwlxmm4pZK2ZHCXK9whMC9uQ9p5Q9c96Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106969; c=relaxed/simple;
	bh=I4dXchJW9el9Do6emOC3LtNwCvkSdCDM2R0AnpjdJa0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=StidNBeiggfWAqsqgvTace3ta0eowPSJnscXRQIaJ8O9xXinG0zSVNgh39YRJkAjHzAdI2lJUPZOsRVFs+/oUEshm68Drt/6pmhg0AJA6jKVJ20AcF+EbCuOLOkDYxx6b2hjj3X9L3u2D3ZUVhlkd7MT6wDVdy/+pt9MLId4wc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTDbG8TO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTDbG8TO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FA21F000E9;
	Mon, 22 Jun 2026 05:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782106968;
	bh=xq7iXlWx9Gs+aihejK04X/Wb1Wkcg8gIp2aaladz0hM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GTDbG8TOUn9Ch0T1O+swPoJ3RZDxtToqaytL/IKyQO6E2Uj+dzBeYTSSMax8PWDzT
	 law0HWIQtf8LddqLIACjQ7A6Axe9HKG6K2Mfq125MOaQfZBrubxE5QDsGRkbuTd8Zw
	 gtTohPKA8hZ4bugEOUKf1acO4r3N8E6p//3jQqva08ygF9hjdcY4qd/XV4mw98jC/c
	 vdGJVZORWEvhzfPkE13eTDZMy9Xb1vDygO3XkzESvRaP14PUhQm1zadNyUuNx5u6JA
	 SIvIAb2zf67zTQ7R8/J+0qRqqJvldTad1BTRKA9f3wGZt1ryzNK9/+vWtkVdnoA0LF
	 QFpMFZI2eQOzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] iio: light: hid-sensor-prox: Avoid race between
 callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-5-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-5-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:42:47 +0000
Message-Id: <20260622054248.06FA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The reordering introduces a Use-After-Free race condition in t=
he probe error path due to a lack of synchronization when removing the call=
back.
- [Critical] Reordering `sensor_hub_remove_callback()` after `iio_device_un=
register()` creates a severe race condition where lockless list traversal r=
aces with IIO buffer teardown, potentially causing an infinite loop.

Pre-existing issues:
- [Critical] Preexisting Use-After-Free in the device remove path due to la=
ck of callback synchronization.
--

commit a4fd8cfbe15835905bbb5054997cb2a8715dcdd2
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-prox: Avoid race between callback setup and device e=
xposure

The driver currently exposes the IIO device to userspace before completing
sensor hub callback registration, and similarly removes callbacks while the
device can still be accessed during teardown. This reorders probe and remove
paths to avoid a race window.

> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-=
sensor-prox.c
> index 9059f00f0cedf..11609dc4c5dc6 100644
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
> =20
>  	return ret;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: Critical]
Could this introduce a use-after-free if the callback fires during error
handling?

Looking at sensor_hub_remove_callback(), it unlinks the callback from the
list but does not appear to wait for actively executing handlers to finish.
If a sensor event triggers concurrently, hid_prox_probe() could return,
allowing the devres framework to free the indio_dev and prox_state memory.

Would an actively executing callback then dereference this freed memory?

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
>  	return ret;
> @@ -344,8 +344,8 @@ static void hid_prox_remove(struct platform_device *p=
dev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct prox_state *prox_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: Critical]
Does reordering these calls create a race condition with IIO buffer teardow=
n?

By unregistering the IIO device before removing the sensor hub callback, a
concurrently firing callback could invoke iio_push_to_buffers() while
iio_device_unregister() is tearing down the buffers.

iio_push_to_buffers() traverses the buffer list locklessly:

    list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {

At the same time, iio_device_unregister() modifies this list using
list_del_init() via iio_buffer_deactivate(). If the lockless iterator
evaluates a buffer node exactly when list_del_init() resets its pointers to
point to itself, could this cause an endless loop and a hard CPU stall?

[Severity: Critical]
This is a pre-existing issue, but does sensor_hub_remove_callback() properly
synchronize with active callbacks before returning?

Since sensor_hub_remove_callback() unlinks the callback but does not wait
for executions of sensor_hub_raw_event() to finish, hid_prox_remove() can
return while callbacks are still running.

Once the function returns, the devres framework frees indio_dev and
prox_state. Can this lead to a use-after-free when the still-running
callback attempts to access the freed memory?

>  	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D5
