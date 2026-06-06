Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A50306D3F
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780746658; cv=none; b=oPYOn/41/tNGQiD4pyeQje8O+TXHqDCnAQaW7KgP9JUhT4dnRn4R+0VipU4e1Fjvl4HdoPnXMtEwQrK20ET9hQmz7af63oVZC0jZQrsGRAjqHYX447e7NsNvpZOemSTx3e8NMbZ1PEMJr+owQt4psLogti2+//ebPO/V+B4f/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780746658; c=relaxed/simple;
	bh=1Q7zB1NGakjkYp5dtZgf9PlBYrV2oNBH+Vhz6rclwI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WSn55yvxxSLe+2u55kcIu0utq9Qn9yX04uli/r4wiunWwbyIuTRgoReHq2vmNa0xSpyHx2qPQGGcsdH3cds3154XQ9BuC1dgrxQpURwxNIAzQVz8JF/53Mjh2fb3eBWsmxKdjjLB1DkDMDToY4P0T2lAeEFxhz8OuAqUk7WmWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrZbYIvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrZbYIvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8898D1F00893;
	Sat,  6 Jun 2026 11:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780746656;
	bh=hQrWEIiAcvVu/7R31/f9LG3TM1wkHDkHzAWWVeQo/5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CrZbYIvHDeKHaT+DZ6KZKPpIoZcTj+579MDmd8iYNAXcmMYuQAnGxO587gvY2kgJu
	 Ptt9YQcpYII2hPxTpI+qmAsv0O7obXOlQ+7TzH1fPPdvCEh88S9cvEVQRD+1GJSLVx
	 lle18jt6DBhA3S/HA02qw0y5g86dwQPTXvChw0N9xabeaa9y643u2bt5+mEqj7/4lI
	 An1YhaSo+9dN7eQidtFYfvaQkz5dEP6DHjc+oVikpO7BYo77R2PA0JuS2DUp2lifAB
	 XsW0p4DnhUqDhJcv6IRUIzfFN8UQNwapCehfO5yuUT1pI7kHUkAY96VUUy8/aNmD55
	 hwDTEn9fpY4FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] iio: pressure: hid-sensor-press: Fix race between
 callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-4-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-4-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 11:50:56 +0000
Message-Id: <20260606115056.8898D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Reordering teardown introduces list corruption and UAF via con=
current buffer access.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the lack of sync=
hronization in sensor hub callback removal leads to Use-After-Free, and thi=
s patch exposes the race on the probe error path.
--

commit 82bc619c3ad12fb028f336e0c55f37d3a740bf6e
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: pressure: hid-sensor-press: Fix race between callback registration and=
 device exposure

The driver registers the IIO device before completing sensor hub
callback registration and unregisters callbacks while the IIO device
is still exposed during teardown. This patch reorders callback
registration and IIO device registration in probe and remove paths.

> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressu=
re/hid-sensor-press.c
> index a039b99d9851d..09795473948a9 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
[ ... ]
> @@ -304,13 +298,19 @@ static int hid_press_probe(struct platform_device *=
pdev)
>  					&press_state->callbacks);
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
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);

[Severity: High]
This is a pre-existing issue, but the lack of synchronization in sensor
hub callback removal might lead to a use-after-free, and this patch
exposes it on the probe error path.

When sensor_hub_remove_callback() deletes the list entry:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    list_del(&callback->list);
    kfree(callback);
    ...
}

it doesn't appear to wait for active readers to finish processing. If
iio_device_register() fails, the driver calls sensor_hub_remove_callback()
and returns, allowing devres to free the press_state memory.=20

Could a suspended or delayed sensor_hub_raw_event() thread resume and
dereference the freed memory?

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
>  	return ret;
> @@ -323,8 +323,8 @@ static void hid_press_remove(struct platform_device *=
pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct press_state *press_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);

[Severity: Critical]
Does this reversed teardown order introduce list corruption or a
use-after-free through concurrent buffer access?

By calling iio_device_unregister() before removing the sensor hub
callback, incoming HID events can still trigger press_proc_event().
This locklessly pushes to buffers:

drivers/iio/pressure/hid-sensor-press.c:press_proc_event()
  iio_push_to_buffers_with_ts()
    iio_push_to_buffers()
      list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list)

While this runs, iio_device_unregister() actively removes buffers
from the list:

iio_device_unregister()
  iio_disable_all_buffers()
    list_del_init()

Could iterating over the buffer list while it is being modified by
list_del_init() cause the lockless reader to follow the self-referential
next pointer, leading to an infinite loop or use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D4
