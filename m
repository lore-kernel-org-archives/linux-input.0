Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D8378D9A
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168980; cv=none; b=kWXWUN9KZ1OvrN19Dj+cG0hPMkn29mixFU0XxwQNI+v6ai39oVr2ywolhArT5Toyxmy9zqQbbcqg2ESG6vihdqvg+dXARfC7XxJyfxRHTs5sJoo7Oe8BnsFBzMRGa9lrnIfRWKqINoVUgPViw+MXlfan+Fu4z3HPsA7jaCvJ+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168980; c=relaxed/simple;
	bh=QQTScF4jnqRG5OV7d4kI1KNkP+u4wl9e8n27nRlllcM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qnj7Mzy3L1XDwcWRweRv3pgroQZkOnMv/0g70f+ceURQd8DoxjUNWPC/nR1PjN+OnN6p1O+5rUPB3Vn8+DIfhZWjdnKwZ33qG9/N5OvG0W5xZ2zoyVvTMYO6JaHTC+rGHlg5GJWM5m/1b5CCR3o+fjI84F088OPOxAMEtWl9UTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL62iZDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL62iZDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918A81F000C4;
	Fri, 16 Oct 2026 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792168978;
	bh=HOIHFhvsvg6v6FZq0MTPruK5S/Q2plXZGY4kUvZARNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XL62iZDVHs3fB1fjy2amCoXctfIvc6v4EhwHqJEOVL/W1Yz19YW2iFg1L4Oiva/90
	 1XYtbmqsv8MnyLXiqB4LWI2mFIv9TTC/rYl8mAaNHmU6ZKjFgXoQy/U5mPFfqJeYKI
	 SghUpA4ZuRN5oVLG4TRmSu2+/wPsQeQ+UIHMjDhUlQscT59CQSo8yitULj3eInl6QM
	 RE7Nrq8fkaqKwqJCIOjlPBeYebLiMmSW7JMN930aGj9VriHZT/1d3OwzMn4MB6KpA3
	 eUhtKQ1w5VFYZqBfxIierw3GVhAGwHxuv4WEg3FC0DGZQk2PY2bbQMEVaqCdG0f+Yz
	 cWB1AVTX5AIGw==
Message-ID: <sashiko-outbox-174656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] HID: haptic: reorder try_module_get/get_device
 before input_ff_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016163349.3293666-2-qwe.aldo@gmail.com>
References: <20261016151343.3120300-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-1-qwe.aldo@gmail.com>
 <20261016163349.3293666-2-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:42:58 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] input: FF_HAPTIC capability lost due to input_set_capability() reo=
rdering
--

commit 212e1315f3df5903b889706323b41c9477dd030e
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: haptic: reorder try_module_get/get_device before input_ff_create

Move try_module_get() and get_device() before input_ff_create() in
hid_haptic_init(). The original order placed them after input_ff_create(),
and failures went to input_free which called input_ff_destroy() without
ever setting ret.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 8760eeb08b2cd..9753bbff9d0d0 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
[ ... ]
> @@ -499,39 +497,36 @@ int hid_haptic_init(struct hid_device *hdev,
>  	fill_effect_buf(haptic, &stop_effect, &haptic->stop_effect,
>  			HID_HAPTIC_ORDINAL_WAVEFORMSTOP);
> =20
> -	input_set_capability(dev, EV_FF, FF_HAPTIC);
> +	if (!try_module_get(THIS_MODULE)) {
> +		dev_err(&hdev->dev, "Failed to increase module count.\n");
> +		ret =3D -ENODEV;
> +		goto stop_buffer_free;
> +	}
> +	if (!get_device(&hdev->dev)) {
> +		dev_err(&hdev->dev, "Failed to get hdev device.\n");
> +		ret =3D -ENODEV;
> +		module_put(THIS_MODULE);
> +		goto stop_buffer_free;
> +	}
> =20
> -	flush =3D dev->flush;
> -	event =3D dev->event;
>  	ret =3D input_ff_create(dev, FF_MAX_EFFECTS);
>  	if (ret) {
>  		dev_err(&hdev->dev, "Failed to create ff device.\n");
> +		put_device(&hdev->dev);
> +		module_put(THIS_MODULE);
>  		goto stop_buffer_free;
>  	}
> =20
> +	input_set_capability(dev, EV_FF, FF_HAPTIC);

[Severity: High]
Does moving this call after input_ff_create() break the haptic functionalit=
y?

Looking at input_ff_create() in drivers/input/ff-core.c, it iterates over
dev->ffbit and copies the supported effects into the newly created ff devic=
e:

	/* Copy "true" bits into ff device bitmap */
	for_each_set_bit(i, dev->ffbit, FF_CNT)
		__set_bit(i, ff->ffbit);

If input_set_capability() is called after input_ff_create(), FF_HAPTIC won'=
t be
present in dev->ffbit during the copy. This leaves the internal state incom=
plete
because ff->ffbit will lack the capability, causing the input core to reject
haptic effects when userspace attempts to upload them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016163349.3293=
666-1-qwe.aldo@gmail.com?part=3D1
