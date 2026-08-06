Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C621A704B
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020052; cv=none; b=Q2nXL0Un3No6qzx/gdqUH/QHu85x2ndJdYkS06OtUEefhvg3zBjoIEq28VYzsk5KVeV8bOQWlfC+Pz5HafIqnOu731YcrnKewOu2YGbhwa5Wgdi5cyFk4ov67422lNRTU8W3R5B+qIu+7hlZyCodOQT53FAD+etNFNHx5UR2NlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020052; c=relaxed/simple;
	bh=klqi1jNMUJF0Rm0T8RwjgxwjraeZ9+Ucq90C/mYHL90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KGvqis1sWXy5tXt9mX4k2zoqjOnd6Ig1mz+w9JXHBP0YuXWF0pnR2MHmzFfvQG6Mubz08kDmBxOuXa16N8YV+qpZzr3ibNwUlQzMFNrm+GLUWpF8N9fhb48M8FxZ6GlturVPr/au/2Z1OpB7bfQZHp82s4GLVYKwcR0OBcJ73cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id5aHg/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id5aHg/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A3A1F000E9;
	Thu,  6 Aug 2026 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020050;
	bh=zwF+YmBbXrI5kIfSZHwL5L3sZwoxl5YI7cg16y6cHPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=id5aHg/xIByaCbxEoMGAmmswICTwRr86NSd61bEUj1l4Y1KCs8VL5BdDwVGDjMOri
	 HBBCIXbhzl0VLlV79BbFZTMYpqWBYGFCXrBuJe1CPe9eJzYU+K+vH1470EMiRNpmuw
	 eydw3SQyXrd6BfAGpTCBkBEtwWTH79cmfXx0/0QhMPZmcfXQtwUTOfPjHoMdINM/Tu
	 Uy7WmVjkXczKkp+acVjCvPFrvUR6rz72zN4QUQ+bVk+jJOpsMLdbWUlUwZQKELy/Vk
	 xNVls8IBfFDihO+m+3Ld72ZlYKqVBMTv/+TlKfnb96ltbAItAMkxG4/1xB7boP0aA9
	 3W+Vo/XsQUA+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/13] iio: light: hid-sensor-als: convert probe and
 teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-8-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-8-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:40:49 +0000
Message-Id: <20260806124050.93A3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Definitive UAF Race Condition: Concurrent execution of sensor_hub_=
raw_event and driver teardown causes use-after-free on IIO state.
--

--- Patch [8]: [PATCH v5 08/13] iio: light: hid-sensor-als: convert probe a=
nd teardown to devm-managed resources ---
commit f3d5af6f98e23ba8f31c7ee56aed1d7b68b69703
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-als: convert probe and teardown to devm-managed reso=
urces

Convert HID IIO driver resource management to use devm-managed helpers,
tying the lifetime of all resources to the device. This simplifies the probe
path by removing goto-based error handling and eliminates the remove callba=
ck
entirely.

> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index 10bf46ea4f475..633fd15699873 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c

[ ... ]

> @@ -406,37 +407,14 @@ static int hid_als_probe(struct platform_device *pd=
ev)
>  	als_state->callbacks.send_event =3D als_proc_event;
>  	als_state->callbacks.capture_sample =3D als_capture_sample;
>  	als_state->callbacks.pdev =3D pdev;
> -	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->c=
allbacks);
> +	ret =3D devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
> +						&als_state->callbacks);

[Severity: High]
This is a pre-existing issue, but does this code leave us vulnerable to a
use-after-free during driver unbind?

If a user unbinds the driver via sysfs while the HID sensor hub hardware is
actively sending events on another CPU, devres will trigger
sensor_hub_remove_callback().

The event thread sensor_hub_raw_event() processes HID events and calls
capture_sample() while holding the pdata->lock spinlock. However,
sensor_hub_remove_callback() only acquires dyn_callback_lock and fails to
acquire pdata->lock:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
    spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
    list_for_each_entry(callback, &pdata->dyn_callback_list, list)
        if (callback->usage_id =3D=3D usage_id && callback->hsdev =3D=3D hs=
dev) {
            list_del(&callback->list);
            kfree(callback);
            break;
        }
    spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
    ...
}

Because the unbind thread does not wait for actively executing event handle=
rs
to finish, it can lead to this sequence:

CPU1 (Event thread)
sensor_hub_raw_event()
    // holding pdata->lock
    if (callback->capture_sample) {
        // paused before or during capture_sample execution

CPU2 (Unbind)
devres cleanup calls sensor_hub_remove_callback()
    list_del(&callback->list);
    kfree(callback);
devres cleanup frees indio_dev (which contains als_state)

CPU1 (Event thread resumes)
        callback->capture_sample(hsdev, ...) -> accesses freed als_state

Can we safely free als_state without ensuring that concurrently executing
event threads have fully completed?

>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_remove_trigger;
> -	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D8
