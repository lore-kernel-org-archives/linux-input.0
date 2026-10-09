Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539AE35C6B6
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516167; cv=none; b=kNZadW5A6wCbwRVffuky/N3hZCQvJyNM5EuDUQQNBzlH02MaOy7YaValjjF9r6DZl22ORXoPK0EIcNoFNYvjItEt80kYJkLvQm476EZKdnEB5Wl5y4PQzSjUExJ3x0Z1hcS+05Mn75on4aYCYsmpucQ7mlABTkOS4xXOHiMy8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516167; c=relaxed/simple;
	bh=7R/2vN9/Cc9Z7g3Yn6adz3n/erGVN+VtI/Ic1p8WVAs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HVvSwaH+3TD/SMqzAtoQzmIp4CNzgOpRmJr9VSAphjuh5ABWSPQOS4BDRX04fRcZXnZYlEl1/WsjyD77ShVbf+H8Ju46TSMUD28l1M7Vqw7kssENUqbDZH0K29zR6uwdcBrFX6CkrPGno9df3W/mcOF8VeJFZqjpnyk4k9b1UIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFiy7XTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFiy7XTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7100C1F00893;
	Fri,  9 Oct 2026 03:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791516154;
	bh=nKg1BBIPd8tI2Fw+17JtfVt7jnxykhNxKxqlgMXuSxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFiy7XTMGNZHRgYSvokFTRl9GUjmDdmtc/aFVe2E4A+koRkzTnnxnNVJGG1NIDdlJ
	 BSfzN9ICsjJPYOfEXaUiOHi0wJyJ/Jel+C+iSuTF01KR3RAf4j7XCebkm0KxzzF30k
	 9UwdKyqOjIAef1WQy8nD27HFmxEenMZdqVyss3hTW62cEvHws+A0KrvEJUruXZDqGu
	 zG3GMaKzqFw6LVOwsaekGwDBZQGY/D+t/FWKRVusnAgb+o5cinq5xr+1VExHcd6m2P
	 8RAWHtlaBimYAQ7sO8wI6unMvhPBzCnUmkKyza7A0y770baxwNiyXXqIGPYmcXVcey
	 BpFI6LnZVCzYg==
Message-ID: <sashiko-outbox-164756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: haptic: fix use-after-free of devm haptic data in
 hid_haptic_destroy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009031203.3127352-1-qwe.aldo@gmail.com>
References: <20261009031203.3127352-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:22:33 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] input: guaranteed double free of haptic structure in hid_haptic_de=
stroy()
- [High] hid: double free of td->haptic on mt_probe() error paths
- [Medium] hid: memory leak of td->haptic for non-touchpad devices with pre=
ssure
--

commit 9428ea91bd775df855a2be1ddad3deee003770fa
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: haptic: fix use-after-free of devm haptic data in hid_haptic_destroy()

This commit changes td->haptic allocation from devm_kzalloc() to kzalloc()=
=20
to prevent a use-after-free when the HID device is unbound while evdev is=20
still open. It also adds explicit kfree() calls in the destruction callback
and error paths to manage the memory manually.

> diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
> index 8760eeb08b2cd..6c365dbf0b9cf 100644
> --- a/drivers/hid/hid-haptic.c
> +++ b/drivers/hid/hid-haptic.c
[ ... ]
> @@ -406,6 +406,8 @@ static void hid_haptic_destroy(struct ff_device *ff)
>  	haptic->hid_usage_map =3D NULL;
> =20
>  	module_put(THIS_MODULE);
> +
> +	kfree(haptic);

[Severity: High]
Does this code introduce a double free?

This function is registered as the ff->destroy callback for the
force-feedback device in hid_haptic_init(). The input core's
input_ff_destroy() function unconditionally calls kfree(ff->private)
immediately after executing the ff->destroy callback.

Since haptic and ff->private point to the exact same memory, it looks
like this will result in a double-free whenever the force-feedback device
is destroyed.

>  }
> =20
>  int hid_haptic_init(struct hid_device *hdev,
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 4e19a0c4d2381..4f7b97cd4baa5 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
[ ... ]
> @@ -2196,7 +2198,7 @@ static int mt_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
> =20
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  	if (ret)
> -		return ret;
> +		goto err_free_haptic;
> =20
>  	ret =3D sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
>  	if (ret)
> @@ -2206,9 +2208,13 @@ static int mt_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
>  	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
> =20
>  	if (!td->is_haptic_touchpad)
> -		devm_kfree(&hdev->dev, td->haptic);
> +		kfree(td->haptic);

[Severity: Medium]
Will this leak td->haptic for non-touchpad devices reporting pressure?

If the device reports pressure, mt_input_mapping() sets=20
td->is_haptic_touchpad =3D true. Then in mt_input_configured(), if the
device application is not a touchpad (e.g. a touchscreen),=20
hid_haptic_input_configured() immediately returns -1.

Because -1 is not 0, mt_input_configured() fails to reset=20
td->is_haptic_touchpad to false.

The haptic setup is aborted, so the memory is never attached to the input
core. Later, mt_probe() sees td->is_haptic_touchpad as true and bypasses
this kfree(), leaking the memory since it is no longer devm-managed.

> =20
>  	return 0;
> +
> +err_free_haptic:
> +	kfree(td->haptic);

[Severity: High]
Can this kfree() result in a double-free during partial initialization
failures?

If hid_hw_start() successfully sets up the haptic device via=20
hid_haptic_init(), ownership of td->haptic is transferred to the input core=
=20
as ff->private.

If a subsequent initialization step inside hid_hw_start() fails (like=20
registering a secondary input interface), the HID core unwinds by=20
destroying registered input devices. This calls input_ff_destroy() and=20
frees ff->private.

When hid_hw_start() returns an error code, mt_probe() jumps here to=20
err_free_haptic and explicitly executes kfree(td->haptic), freeing the
same memory again.

> +	return ret;
>  }
> =20
>  static int mt_suspend(struct hid_device *hdev, pm_message_t state)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009031203.3127=
352-1-qwe.aldo@gmail.com?part=3D1
