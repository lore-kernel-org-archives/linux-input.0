Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2F257845
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019862; cv=none; b=hyZ9w1OoWWcY/U54cQbkP2IxeUdlC61E8w+Vhmc5driri88mVVQ912g17C6fuPHFflC0RGdnYj8VtXJlcMF4ab8PyQGqiVhpVuj7zEr9PF+ic1VDXbawEEdNZZMSGhQ7rlLBcbbrcDTD+3f6fWc3vHPuMTR/LRRdBx4PUdS4Rxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019862; c=relaxed/simple;
	bh=zEG3k5QiJ5NuFXz/luIutGO0FAm5gRbHyscudAfBL00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kvaZ4x8pPEJrW+sl3+rfFg3wurZ5HV81FrTobkxvzqOJwJYHvvVOgW9QJqer0z8bnFIC45i31L0+uKGVbXGfUUgFEBBryZOXD5K6qfSmob2ShZoShofsyH0dGhytSz8DC6BtoRnILIMcJEGjc0Vb5YXSfCsjoASnGpHT5IHhHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZuTPkbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZuTPkbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5103F1F000E9;
	Thu,  6 Aug 2026 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019858;
	bh=eV35Rx4bImmyQHkI7SFQzHMF2i05f/DEV3GwRzCOJX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MZuTPkbU7zlY55/FGJPXesJ4r07lGbEZ8tLMtRF7wJq8sBEbnxAy1gAt5j1H15pZk
	 V+T3DhSYC3WAYdIXCoXJIoD2rDl74PJA+pGE6u435jUmmHFQyyKqpsz9jDVfNZ4sC4
	 izRMEKr5ycgCYOQSzTjEm6HWwllSKlZbR5x9MZBr9/aF33QwbIlXSNY6yNOXr6S+8X
	 DrYANP/PwtZHPfwCao5lKP4A54RH2p18yuZ03dAWXwRkiQhjDac08lif2R9BYiqvll
	 bQHARUmazzq2nXZxm1E+zd2iQFYDTVVJgV7BcvC/pLfT9yuxy4VHGzjUz30fKw0PQZ
	 vwm8RzxvzJ+QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/13] iio: hid-sensors: remove unused iio_dev
 argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-1-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-1-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:37:37 +0000
Message-Id: <20260806123738.5103F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of `sensor_hub_raw_event` and a child IIO dri=
ver's `remove` function can cause a Use-After-Free on the IIO device state.
--

--- Patch [1]: [PATCH v5 01/13] iio: hid-sensors: remove unused iio_dev arg=
ument ---
commit c12a28d854a2931313f7d217face266eaf20a33a
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: hid-sensors: remove unused iio_dev argument

hid_sensor_remove_trigger() no longer uses the iio_dev argument. Remove the
unused argument from all HID IIO drivers to match updated function prototyp=
e.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
[ ... ]
> @@ -415,7 +415,7 @@ static void hid_accel_3d_remove(struct platform_devic=
e *pdev)
> =20
>  	iio_device_unregister(indio_dev);
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
This isn't a bug introduced by this patch, but does the concurrent execution
of sensor_hub_raw_event() and this remove() function cause a use-after-free
on the IIO device state?

Looking at sensor_hub_remove_callback() in drivers/hid/hid-sensor-hub.c, it
removes the callback using dyn_callback_lock but does not synchronize with
pdata->lock:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
    // list removal
    spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
}

If an unbind happens concurrently with an incoming hardware event:

CPU1
sensor_hub_raw_event()
    acquires pdata->lock
    finds registered callback

CPU2
hid_accel_3d_remove()
    sensor_hub_remove_callback()
        removes callback and returns
    devres framework frees the IIO device state

CPU1
sensor_hub_raw_event()
    if (callback->capture_sample) {
        callback->capture_sample(...) // Dereferences freed IIO state

Can this lead to memory corruption during physical device removal or sysfs
unbind?

> -	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
> +	hid_sensor_remove_trigger(&accel_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D1
