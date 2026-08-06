Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA327057D
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020035; cv=none; b=DUGXdnqRx35Jm45GgnDRxO4ADQC3OfTw99WEtPiM1J/Wpc4WdIrwSpkjXy5ZoJFTQs7PJTqiuenT2oUJ6ddgJ/By5JYRVA6rPeVi2LEwSEUR+IH13JiH/IGwmGRoZkNEuYphAAN2CvJR8dVTSzKeJM5QuGNeRlgigZuQVkagT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020035; c=relaxed/simple;
	bh=fFzlH6ttuQcpVQdrvqe/2dNuXrd1wqR1WL0FZhQVD/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wll+0qQnt+KohLP6iZFLW2sHLgFcqwHN0uf+hxwFa/b/I03zxNIw0r5pdpPX7HeMOsGya1bZLa8v5/aqig7taM+heY+DXlEe6mgkgsLdr5jIiOZ0CVoUpdKKnUFPSt7Cc5E7aKpHNMbYQEX/2cdGvjRY9dmRvrLtoEKUFXGUOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPz3TSuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPz3TSuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F68B1F000E9;
	Thu,  6 Aug 2026 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020033;
	bh=Y08UwGX0NxkfFE6fS8/ZY65ojOai8seqE5YsogB0vsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPz3TSuW+L9uj1wkuXldpSIPuuoX30BoBgXcS1jgRyigKBwwf3gMysj48Uhc8Kllb
	 I3fdGFoLmKKKgWgu7O0E5S4VZVeZFMFivT43P3C/SmYKb44nRXWa8mvuT4g9p8kmOF
	 evf0zYkTZajZdXXHvZGJNLHwDXjODnRB3F+7cgQMPtPJ8vCWP4tFirfAGpchxJtLji
	 IXb6FjIxvBssMY9I7ldijGVRWIcB54c8jfGDEpo+UgnUxGTKce/KM/soOsi/EIhkrw
	 ylO2pfTfO7XiQA3P64D7ZVf5FIi+99UpIJCuFsEGe1IsNWfoH56pr5yPOaGuNiTTTn
	 eDmnCQUFWbBOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/13] HID: hid-sensor-hub: introduce device managed
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-3-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-3-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:40:32 +0000
Message-Id: <20260806124033.4F68B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lack of synchronization in `sensor_hub_remove_callback` allows `se=
nsor_hub_raw_event` to access a freed `usage_callback` during driver unbind.
--

--- Patch [3]: [PATCH v5 03/13] HID: hid-sensor-hub: introduce device manag=
ed API ---
commit 1f72201981d4eabf709dd34d77a678b2f0acfcf2
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

HID: hid-sensor-hub: introduce device managed API

This commit introduces devm_sensor_hub_register_callback() to handle
resource acquisition and release using the device managed framework. It
adds a devres action that automatically unregisters the sensor hub
callback when the device is detached or unbound.

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
[ ... ]
> @@ -187,6 +187,38 @@ int sensor_hub_remove_callback(struct hid_sensor_hub=
_device *hsdev,
>  }
>  EXPORT_SYMBOL_GPL(sensor_hub_remove_callback);
> =20
> +static void sensor_hub_remove_callback_helper(void *ptr)
> +{
> +	struct sensor_hub_cb_devres *res =3D ptr;
> +
> +	sensor_hub_remove_callback(res->hsdev, res->usage_id);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but does
sensor_hub_remove_callback() lack synchronization with ongoing raw events?

When a client driver is unbound via sysfs, this helper will call
sensor_hub_remove_callback() to clean up. While the remove function
acquires pdata->dyn_callback_lock to unlink the callback, it returns
immediately without acquiring pdata->lock.

This means it does not wait for ongoing events to finish:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
        spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
        // unlinks callback
        spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
       =20
        return 0;
}

Meanwhile, sensor_hub_raw_event() can be actively executing on another CPU,
having already dropped dyn_callback_lock:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
        ...
        callback->capture_sample(hsdev, ...);
        ...
}

Because the unbind process continues immediately after the removal returns,
it can free the memory containing the usage_callback (such as through
devres_release_all()).

Could this lead to a use-after-free in sensor_hub_raw_event() when it
dereferences the freed callback pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D3
