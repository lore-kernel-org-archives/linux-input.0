Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38B3A784E
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159583; cv=none; b=CSrkWIaPTbjkz8ayU/nnaivISsmP7Sr16n1HFIdcFahxHfNpNjRr0zH4aOaHPvexqfzJhIPAY1LOJc/nva5NRezvooPyP70XqHiiP40FjbCMJF4WpQ2TpmEb6pEN7PnkWyunkHC3c0xIlX2kj2HoGlztmfdPv2tT81FJs6l2HsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159583; c=relaxed/simple;
	bh=RhWy/w9H8p4uoQwKDkwF1oiE6C4c4/z9WqNWEcNjTyc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZJW6k2hHGOJVHC3C7y1nGmgk7AUSxPqrTybhbWoFZFkH/VjPAtFjhcIP3WBOimSRxMHHvtVy88EazIpPnmP0+zD+ef9NF6h2FaYudDqDqGvibaRhjQlwGMKCvLRi79FUezAFMkcp1Kth651AibIAwXPP+eMzXD3o1TuH6cwlYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlaCYvGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlaCYvGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6D21F000C4;
	Fri, 16 Oct 2026 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792159582;
	bh=R6pjCR9/xu3ccamLQf0cWbOncM2jbk5ynH2Aw3/l9nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VlaCYvGPfiPa7RcQnRoRX+C+tLBeYJcqYakKvsyaYVLD7tulBoQb0aTVDNiD9YEtG
	 i0J5QvRL+RDrF8TnyaN110LYy7LsPgveh6LCls09aw7tkdeTqW4kIMzXZqFwyzc0Lb
	 keB9cjjGurYGdteFnFr2l+18L2bXe4cYV8xVt/HdmfYIpVA3nRJ6XxA9azb7fp3uuv
	 G8hLAqtoyPB9MizdwqfsiMVnoYxtVty8F+X4TiFFUJXrw8x3S2kMEpqxa0OYPLFBa3
	 KjO3WbJ4VlAFCdtl0krC8mC6/jZoSViCjSh1a832S83PgIW+W52O4j1AUCkUA/IrVx
	 035QeyECJ00cw==
Message-ID: <sashiko-outbox-174419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] HID: haptic: reorder try_module_get/get_device
 before input_ff_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016135516.2957381-2-qwe.aldo@gmail.com>
References: <20261009103333.2476105-1-qwe.aldo@gmail.com>
 <20261016135516.2957381-1-qwe.aldo@gmail.com>
 <20261016135516.2957381-2-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 14:06:21 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] input: missing EV_FF capability cleanup on failure leads to NULL d=
eref
--

commit 58557bc733a3a68f242cf09872b1a593ec599fc2
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: haptic: reorder try_module_get/get_device before input_ff_create

This commit moves try_module_get() and get_device() before input_ff_create()
in hid_haptic_init() to acquire references early. It adjusts the error
handling to jump to stop_buffer_free directly on failure, removing the need
to restore handlers or call input_ff_destroy().

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 8760eeb08b2cd..592b44e020d6b 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c

[ ... ]

> @@ -499,11 +499,23 @@ int hid_haptic_init(struct hid_device *hdev,
> =20
>  	input_set_capability(dev, EV_FF, FF_HAPTIC);
> =20
> -	flush =3D dev->flush;
> -	event =3D dev->event;
> +	if (!try_module_get(THIS_MODULE)) {
> +		dev_err(&hdev->dev, "Failed to increase module count.\n");
> +		ret =3D -ENODEV;
> +		goto stop_buffer_free;
> +	}

[Severity: High]
Does this error path leave the EV_FF capability set on the input device?

Before this change, the failure paths for try_module_get() and get_device()
jumped to input_free, which called input_ff_destroy(dev).

By jumping to stop_buffer_free instead, the EV_FF capability remains set on
the device, but dev->ff is never initialized.

If hid_haptic_init() returns an error that is ignored by its caller, the
partially initialized input device could be registered.

When a userspace application opens the input event node and issues a force
feedback ioctl, could the input core's input_ff_upload() dereference a null
pointer?

For example, in drivers/input/ff-core.c:input_ff_upload():

        if (!test_bit(effect->type, ff->ffbit)) {

Because test_bit(EV_FF, dev->evbit) is true, the input core might assume
dev->ff is valid (where ff aliases dev->ff) and cause a kernel panic.

> +	if (!get_device(&hdev->dev)) {
> +		dev_err(&hdev->dev, "Failed to get hdev device.\n");
> +		ret =3D -ENODEV;
> +		module_put(THIS_MODULE);
> +		goto stop_buffer_free;
> +	}
> +
>  	ret =3D input_ff_create(dev, FF_MAX_EFFECTS);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016135516.2957=
381-1-qwe.aldo@gmail.com?part=3D1
