Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3F2DB780
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814412; cv=none; b=bUExHXUJZIq0YGKS6VAmIQgugVX+NmkAY4CNclRGqrwP7u4K12LzgQaYgabt5u1s3O/0qlvdSr2/Svxyhp7Gu+juxvEkEXYnXrEItnb5t9tM5vYE/quofpCDVHMlIrDqCFlfYDyAfTae9dLt/akOwka0SJbACx7UESH/apW5ZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814412; c=relaxed/simple;
	bh=KDQSMvlMKNB6k2KAiI8uzzMll9qlYlI2fOA1DqoPIEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dXwPdp3OTkno3heC9KZAi6CzJC08lDCQjciaCv0BztsDLPMm00+47AfmEGwbTosPYZBJDkaDpOqpMgncqneDgPtWbcX58llg3iWzpOixNfdkWxjuflU2g+QqgPITGyp3XvslBUsG1t7k2/8FUoZDrvst+t37xsrIiZ5BNmTJ3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMOgoFWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMOgoFWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697631F000E9;
	Tue, 30 Jun 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782814411;
	bh=tmQ87qR7KJkVR5VRrUJfd1L5b44diiKljV3h0W0stcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dMOgoFWA6hBR/HOF3JiCg5v2QdQi2vvX4gBYur7/ihZ9PUACIHdfbfaEKaWos92qC
	 Gy8jlVgUS4E0CaZNDIRmA7jlX4bZ1EAqGAmG1ipeHiBG6Q3FFyZ9YZpQH3ZULIBRX7
	 V6446ZPEQPSwQlC9eQslDNMD94zmfrwnyIFzb0G/XWDGHYzj55ojw4C/S46Es807kx
	 SiHs/y1ZfuFt4IznTmKONnF59wpZNiY7/HAmkodsF7+wEa4mdN5UI6mKSAdcAB2o8w
	 4sTq44gPcbN/o8KajBild5263WpKPSB4LklVeJu+trmCiUgBqzoVIB2k+E90n7vdaH
	 7m0Dxn6sUr6yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
Reply-To: sashiko-reviews@lists.linux.dev
To: DevExalt <exalt.dev.team@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260630094838.50471-1-exalt.dev.team@gmail.com>
References: <20260625080807.74157-1-exalt.dev.team@gmail.com>
 <20260630094838.50471-1-exalt.dev.team@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:13:30 +0000
Message-Id: <20260630101330.697631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-after-destroy of `hidpp->send_mutex` and operations on stopped=
 hardware due to delayed sysfs group removal.
--

commit 55433f57873d505e62b905c239d0015edd306ae5
Author: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>

HID: logitech-hidpp: Add support for HID++ Multi-Platform feature (0x4531)

Add support in the Logitech HID++ driver for the HID++ Multi-Platform
feature (0x4531), which enables HID++ devices to adjust their behavior
based on the host operating system.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 90b0184df777f..33904f3093803 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]
> @@ -4780,6 +4780,26 @@ static void hidpp_multiplatform_init(struct hidpp_=
device *hidpp)
>  {
>  	struct hid_device *hdev =3D hidpp->hid_dev;
>  	u8 feat_index;
>  	int ret;
> =20
>  	ret =3D hidpp_root_get_feature(hidpp, HIDPP_MULTIPLATFORM_FEAT_ID, &fea=
t_index);
>  	if (ret)
>  		return;
> =20
>  	hidpp->multiplatform_feature_index =3D feat_index;
> =20
>  	ret =3D devm_mutex_init(&hdev->dev, &hidpp->multiplatform_lock);
>  	if (ret) {
>  		hid_warn(hdev,
>  			 "Multiplatform: Failed to init mutex (err=3D%d)\n", ret);
>  		hidpp->multiplatform_feature_index =3D 0;
>  		return;
>  	}
> =20
>  	ret =3D devm_device_add_group(&hdev->dev, &multiplatform_attribute_grou=
p);

[Severity: High]
Does this create a use-after-destroy race condition during device unbind?

Because devm_device_add_group() is used, the sysfs group is scheduled for
removal during the devres phase, which runs after the driver's remove callb=
ack
returns.

In hidpp_remove(), the hardware state is explicitly torn down and the mutex=
 is
destroyed:

drivers/hid/hid-logitech-hidpp.c:hidpp_remove() {
	...
	hid_hw_stop(hdev);
	cancel_work_sync(&hidpp->work);
	cancel_work_sync(&hidpp->reset_hi_res_work);
	mutex_destroy(&hidpp->send_mutex);
}

The sysfs attribute remains accessible to userspace during and shortly after
hidpp_remove() runs. A concurrent write to the platform sysfs attribute cou=
ld
trigger platform_store(), which eventually attempts to lock the destroyed
hidpp->send_mutex and perform I/O on stopped hardware.

>  	if (ret) {
>  		hid_warn(hdev,
>  			 "Multiplatform: Failed to create sysfs group (err=3D%d)\n", ret);
>  		hidpp->multiplatform_feature_index =3D 0;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630094838.5047=
1-1-exalt.dev.team@gmail.com?part=3D1
