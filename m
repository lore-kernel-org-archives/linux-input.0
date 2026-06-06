Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168E3A3807
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747821; cv=none; b=UHZZfu/1Tm48QXCFUP418wsnG7QMvnLYPCz80yGh4G8lqFFNZoqUJc9rCEkEoE0bxMRnWe9qr+eooeU/JPthL3JU8rEVB3v0Rx5JsPRhlImKcyhlFv5f3hGRYMwFKv9JVE6elG0RlLVz4fGhQob2Nf5GNMN67oFzO65N71ygvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747821; c=relaxed/simple;
	bh=W36BMx6eEymDBxF/gM9jpgY2JTbHq+z3fcO4sUX5aBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pjsBhRR3ozchmN6yqyI0BT/SV923SXTcjwllA4x0XThhBFeag3HrS8e4WmbIfB1zEjJgJiqpAYaxjj+VVjBENlioV+V0P1/r0tu6pIkSag2895Dzycw6LBhI/LUiAQ2UX4I8b85/WdaTa5OD87So9j5dFdhrkGygjN62nxEXbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1Cf+ilg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1Cf+ilg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948A31F00893;
	Sat,  6 Jun 2026 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780747819;
	bh=Umh5oce+Q7Y6P2pg/zaT74zHjEJQAHsMIoYZUzJdvhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1Cf+ilgzJ5QpiSH24uChDmpcSqObVi1xtyPjBd0klP6UD1Dgja+ASSWuOIy67PAT
	 tCenpsUNuY1OZr8/tTLQPQb7OWMpCV7y0JM6bvKSbrC7aPbO549FZes4iHup4RSANJ
	 2PJhN6qnaV+8MQGc6jQt+kAMZ1WRfwfwxMOL4mQWkNaZ5cfr8s6kO8vPvP4MxZo9c5
	 YRiXU80qmY8o81R4XqNGLswYx9EWv5Jo/UkCFJWIj/qsnFwyEgTHahWDZCThfSpOm/
	 dWJHdR9FHKAC/yqFejoSjKNB7pjc7G2YgsuTUhP23cPjMSdcicJDRp5/p7pkqmDfZV
	 j4Un2IDQ0P2jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] iio: orientation: hid-sensor-incl-3d: Fix race
 between callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-2-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:10:19 +0000
Message-Id: <20260606121019.948A31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a Use-After-Free (UAF) vulnerability in the p=
robe error path by registering the sensor hub callback before completing II=
O device registration.
- [High] The patch inverts the teardown order in the remove path, leaving t=
he HID callback active during IIO buffer teardown, which leads to lockless =
list corruption or Use-After-Free.

Pre-existing issues:
- [High] The driver suffers from a pre-existing Use-After-Free vulnerabilit=
y during device removal because `sensor_hub_remove_callback()` does not syn=
chronize with currently executing HID callbacks.
--

commit 7127797d9af9cf3f6a23d56c71b46a308c88b097
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: orientation: hid-sensor-incl-3d: Fix race between callback registratio=
n and device exposure

This commit modifies the probe and remove paths in the HID 3D inclinometer
driver to adjust the registration order between the IIO device and the sens=
or
hub callbacks. It attempts to fix a race condition by registering callbacks
before the IIO device in the probe function, and unregistering the IIO devi=
ce
before removing callbacks in the remove function.

> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/o=
rientation/hid-sensor-incl-3d.c
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
[ ... ]
> @@ -370,13 +364,19 @@ static int hid_incl_3d_probe(struct platform_device=
 *pdev)
>  					&incl_state->callbacks);
>  	if (ret) {
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
>  	return 0;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);

[Severity: High]
Does this error path introduce a use-after-free regression?

By registering the callback before IIO device registration completes, the H=
ID
event callback is added to the active list and can dispatch events
asynchronously immediately.

If iio_device_register() fails, the error path calls
sensor_hub_remove_callback(). However, this function only deletes the
callback from a lock-protected list and does not synchronize with
concurrently executing callbacks:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
    if (callback && collection && callback->send_event)
        callback->send_event(hsdev, collection->usage, callback->pdev);
    ...
}

When the probe function returns, the devres subsystem will free the indio_d=
ev
memory which contains the callbacks structure.

If a concurrent HID event was dispatched just before the callback was
removed, could it locklessly dereference the freed callback->send_event
function pointer?

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
>  	return ret;
[ ... ]
> @@ -389,8 +389,8 @@ static void hid_incl_3d_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct incl_3d_state *incl_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);

[Severity: High]
Might this inverted teardown order cause list corruption or a use-after-fre=
e?

By leaving the HID callback active during IIO device unregistration, the
hardware event source remains active while dismantling structures.

When iio_device_unregister() disables buffers, it removes them from
indio_dev->buffer_list using list_del_init() without holding locks that
protect the push path.

If other sensors keep the shared HID hub active, events for this sensor can
arrive concurrently. The event handler calls iio_push_to_buffers(), which
iterates locklessly:

drivers/iio/industrialio-buffer.c:iio_push_to_buffers() {
    ...
    list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {
        ret =3D iio_push_to_buffer(buf, data);
    ...
}

If these race, could the concurrent modification result in list corruption =
or
dereferencing freed buffers?

[Severity: High]
This is a pre-existing issue, but does sensor_hub_remove_callback() properly
synchronize with executing HID callbacks before device removal completes?

Looking at the implementation, sensor_hub_remove_callback() removes the
callback from a lock-protected list and returns immediately:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
    list_del(&callback->list);
    kfree(callback);
    break;
    ...
}

It does not wait for any actively running callbacks in sensor_hub_raw_event=
()
to finish. Once hid_incl_3d_remove() completes, devres frees the indio_dev
memory containing the incl_state and its callbacks.

If the HID event thread is still executing the callback locklessly, might it
dereference a freed function pointer and access freed memory?

>  	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D2
