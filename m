Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9A36A352
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164957; cv=none; b=GuXXwQ9JKmdyuYailj2k89eIpjSq6A8/g4m/j9G82Hy+s7x87hSsMPeJ6aazemXf162xkHHDmmpsKvzrZo33wGQnc9A1TJZVWP4/AgyQIzRf3vxnRmUVGoYzoI1leRr+JfBH3evzpY8OUKbPvCUtjB26jBLZZadB4flefGdohoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164957; c=relaxed/simple;
	bh=6XsxztwN1x91g6bOImii6xc5RjuGS9wo8O4xG4jrbNE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FZLDTXQJYmh01aN2NdK38nGcw5YdfkmeOPj3Lv51v+n4XIIDBu8Udcyz5jT76Mcp7izroKUS+uzt/HQQONQYKx9xQ0D7h4BJIl+RIeHG7m1B1yfApntPVeKtpLZNV0YydXCtJjGNBRCtTG73CcbweOmYTzVFumEBG8juiXBxbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp+ORg8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp+ORg8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E251F000C4;
	Fri, 16 Oct 2026 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164956;
	bh=Yjgtq1bgazEgZwnaFqpGI189x5fs5fyDTJsV+2uGiME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fp+ORg8Gmr9YDMqD5dRF53ebldBPXFvMaEtj6vyHzpqmPM8oXjptmlpHHQYqpA0Ya
	 XQSW3tBYZh3M0/5b/KK+OCA1c+rT9wr2Gpk9vCAgyfec5Ga5WdiZvA3DVcSpIwu6P+
	 J/ZJ0q9vgggsjf5Oyq0jOx4VyKCXbvGTGqgzjn1d7Rat5MkbsBNp4q6Z+0odkiIESi
	 VBtelo9My7fQ1qL/seFt7z6dnjPygASzVsPLjypB8Qr9m6jn62KCaRRKM0E/+INciR
	 /zfpjii5FuvqKSaPNPU7l0UNnUhmM0tc8EjoXcWj5XCjJuugm3Wa/6IoRzs+rHK+iC
	 OuwyBHHUVNpGg==
Message-ID: <sashiko-outbox-174569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] HID: haptic: reorder try_module_get/get_device
 before input_ff_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016151343.3120300-2-qwe.aldo@gmail.com>
References: <20261016135516.2957381-1-qwe.aldo@gmail.com>
 <20261016151343.3120300-1-qwe.aldo@gmail.com>
 <20261016151343.3120300-2-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 15:35:55 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] input: NULL pointer dereference in evdev on EVIOCGEFFECTS when hid=
_haptic_init fails
--

commit 2755afe0061688f07b774dbe02464fb532ab3852
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: haptic: reorder try_module_get/get_device before input_ff_create

This commit moves try_module_get() and get_device() calls before
input_ff_create() to fix a dangling pointer and uninitialized return value
in the error path of hid_haptic_init().

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 8760eeb08b2cd..592b44e020d6b 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
> @@ -501,11 +499,23 @@ int hid_haptic_init(struct hid_device *hdev,
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
> +	if (!get_device(&hdev->dev)) {
> +		dev_err(&hdev->dev, "Failed to get hdev device.\n");
> +		ret =3D -ENODEV;
> +		module_put(THIS_MODULE);
> +		goto stop_buffer_free;
> +	}
> +
>  	ret =3D input_ff_create(dev, FF_MAX_EFFECTS);
>  	if (ret) {
>  		dev_err(&hdev->dev, "Failed to create ff device.\n");
> +		put_device(&hdev->dev);
> +		module_put(THIS_MODULE);
>  		goto stop_buffer_free;
>  	}

[Severity: High]
Can this cause a NULL pointer dereference in evdev if try_module_get() or
get_device() fails?

By setting EV_FF on the device unconditionally via input_set_capability()
before these checks, if we hit the stop_buffer_free error path, EV_FF
remains set but dev->ff is never initialized.

Because the caller hid_haptic_input_configured() masks the error:

drivers/hid/hid-haptic.c:hid_haptic_input_configured() {
    ...
	error =3D hid_haptic_init(hdev, haptic, hi->input);
	if (error) {
		dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
			 hdev->name);
		return 0;
	}
    ...
}

The input device will still be successfully registered with the EV_FF
capability. When userspace subsequently issues an EVIOCGEFFECTS ioctl,
evdev_do_ioctl() checks EV_FF and blindly dereferences dev->ff:

drivers/input/evdev.c:evdev_do_ioctl() {
    ...
	case EVIOCGEFFECTS:
		i =3D test_bit(EV_FF, dev->evbit) ?
				dev->ff->max_effects : 0;
    ...
}

Since dev->ff is NULL, this will cause a kernel panic. Should the EV_FF
capability be cleared in the stop_buffer_free error path, or only set
after these checks succeed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016151343.3120=
300-1-qwe.aldo@gmail.com?part=3D1
