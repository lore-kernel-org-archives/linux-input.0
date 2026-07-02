Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB2346E6D
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012687; cv=none; b=C9HPE9kdkriVKRoVNMkj7DJu4iBaAYcMsFt8/vdPhUyLt7lCWvdpQVfL3G7s4LIUrTWU47jEzMGODfEgKstVwalyf5QktYYXG75eCsMoRP08DuvywRE2q3mDi3n7pR1ujLW+74KGmvnb3CJhi8gpDQ+BtxOtCaOeNXTYB+NluEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012687; c=relaxed/simple;
	bh=+9dvjzU47XxM4LZuWAfhTdQF+aSWJT1OBaT0pHHt88A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pOlgHOP4hiSLxC5suiXzmN7Mq4FU0JCKGUDfLbkl5gRLeRZDAEVS9YZS+kPmbl4/StV6HlmQjHoSmKZ8zJwx1SiSIXkc7wK3jneWwkDTZTyjfF8Wd52TYIa7dXR4QA3OIbQFzKTIYwUSxfh7PqeiStO/3VffstFosPkt1BfffNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtVGMiwQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtVGMiwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D2C1F000E9;
	Thu,  2 Jul 2026 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012686;
	bh=HqsybQGSAIi5e0DlOScoG38PmyLg5CF0ITQ1DGcPLhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mtVGMiwQdpkJR3Z5qUQczhe0ygfi47CGxmkOSM4GsXuI2Jf4CSuSa5XUIG7Tv8h6C
	 ZTLuBGtSWHxjnV0E3l3wEUvSF0bJXqbzN4DjNmkxhqixFu09z6iqVqifod9VX7cmAp
	 26mUQmG0voEPdc3FXeYU6Bo0RE+Y/RDVn1sQbHFVLJa0pneKQ3AlWUoVIsYxPDH+cp
	 NDs9E4mY1Uaq+u0mYB5ddfn+W5ncIQAP/9Xbyd8tbMGIIAwv0BKDHXT8BuEbGxL6A5
	 ykXbTu7oanyLbbaOoIFl7w0HnQOHip85GVGfUaVxWzasKrlJZCeSAEZ+60RYfc7+Rg
	 TSTHJL777c4Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] iio: position: hid-sensor-custom-intel-hinge:
 use common device for devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-5-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
 <20260702-15-jun-hid-iio-alignment-v2-5-b87f01f5efbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:18:05 +0000
Message-Id: <20260702171806.11D2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Lifetime mismatch creating a dangling pointer and latent Use-After=
-Free for indio_dev->channels

Pre-existing issues:
- [High] Preexisting Use-After-Free due to lack of synchronization in senso=
r_hub_remove_callback()
--

commit fb5b93327e543a3377eb1d115b291e219ae98165
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: position: hid-sensor-custom-intel-hinge: use common device for devres

This commit changes the devres allocation for the IIO channels array from
using the IIO device to using the platform device. The goal is to bind the
memory lifecycle to the HID platform device instead of the IIO device.

> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drive=
rs/iio/position/hid-sensor-custom-intel-hinge.c
> index 1f4a40716c3f7..eb6c59f81c3f3 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -293,7 +293,7 @@ static int hid_hinge_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	indio_dev->num_channels =3D ARRAY_SIZE(hinge_channels);
> -	indio_dev->channels =3D devm_kmemdup(&indio_dev->dev, hinge_channels,
> +	indio_dev->channels =3D devm_kmemdup(&pdev->dev, hinge_channels,
>  					   sizeof(hinge_channels), GFP_KERNEL);

[Severity: High]
Does binding the channels array to the platform device introduce a lifetime
issue for the IIO device?

In the IIO framework, indio_dev is reference-counted and can outlive the
platform device if an in-kernel consumer holds a reference via
iio_channel_get().

If the platform device unbinds, devres will automatically free the channels
array. However, because indio_dev remains alive, a subsequent access to
channel metadata by the consumer (such as calling
iio_get_channel_ext_info_count()) would dereference the freed channels
array.

>  	if (!indio_dev->channels)
>  		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing
synchronization step when removing callbacks during the error paths here
and in the driver's unbind function?

The HID sensor hub processes events in sensor_hub_raw_event(), which looks
up a callback and executes it (like hinge_capture_sample()) while holding
pdata->lock.

When sensor_hub_remove_callback() is called, it removes the callback from
the list and returns without acquiring pdata->lock or waiting for the
ongoing event processing to finish:

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
}

If the driver is unbound concurrently via sysfs while background sensor
events are being received, devres will free the driver's private state when
the unbind completes. The concurrent sensor_hub_raw_event() could then write
raw sensor data directly into the freed state structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-15-jun-hid=
-iio-alignment-v2-0-b87f01f5efbc@gmail.com?part=3D5
