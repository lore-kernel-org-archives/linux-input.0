Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823906;
	b=WOB1/3y876fkOdWPVRBK14AYJciQAW2nkF/IPX+mKEO39dutJJjDjizTkuRWWStZLlsV
	 x9YrvvF8GagiKcU9M8wF5gLegwnmYwq6zGEnAZF388DHklXTf3XZdsGLElz3WUag7tzr9
	 dnBt7dQz3brzOKONpuysIuipNK8Dvgw1dL3usL3JP1+iZbSqDzRl6B+hxtFSTuZX18MKn
	 2lufVPr45vefd9/gHWuHoq1jMtkQCMV6BvQyiTIaWUleyXmimdIoflGue6hcSxYsUJ2ez
	 /BlaVPk4bVROWMG3QVOvC1N4Lf7gCbYlVXoYp+MFgAK63j9ABdP4yKAUM82qTxRFHXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oUIVJztEThq3l1jwWRuoQoLomHe7fND0CLjHQ9EisOU=;
	b=vhlsFcyeHSlj/wunhFDsg6QBf+Hp0wo3wfHpJi/NHDH9ynoEzbLUbktGfeSAfZfQBM7R
	 BH+fxfQ81f9SAGezlriOWVYwGMDG5BMk9vGWBAteSkMbzVvXeotZ9OXvEepRlPXlQd+ty
	 +lZdn/m+vltHT5o16ze1dK1OYLNlm30AZj3LZ5M13ukXaJnAmytjTvGd55yEl9SXyh1hf
	 Kqgaxjvxb0670rwPS8Or6sHD3CUhTre7R5gLh8IrHN8b7MNnLikf47IxwqiTvpitW1Y4d
	 FCM/RV+bP/AW5YOKH+tkZhWwBbfgTBlqtWiC3gY18J4VpAGiGkoHLT7tBCj65TYDq9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SS5T9NLm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B91606D804
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SS5T9NLm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3B81F000C1;
	Wed,  4 Nov 2026 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793823905;
	bh=oUIVJztEThq3l1jwWRuoQoLomHe7fND0CLjHQ9EisOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SS5T9NLmRDb4fbONHEdgM2DI8DSz54IT8TYsRcefZ56u2K4EK4IjT52Ur3TaSsApq
	 OYv7y2eAwyKPTLKs+GNnZ7/hRWQHmjIa4lr6xmUNvxVhfIanQ2gVnvSDvAGRr7FJdJ
	 Lo/zYs9V6HmMF4XZbA/eqJMYNyWzLBRGs+wRkFeXOPMaDePHJLuF6cky9F+MMvuRFZ
	 5zC6hJhwu0w77unN8E79xokVxCctD6GquPdyu/8lmTkNZkLa7omujjqaMFf1JQ8Z/x
	 IjvAfrteWxqA4N4+OZtMWxEQWG/sae1b5Loxx/FU2R1hl+ty6vTJoopOWA5EpopY/w
	 BFtKa7Banzifw==
Message-ID: <sashiko-outbox-198009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] HID: sensor: custom: Register enable attribute
 after misc device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104201403.2039921-7-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
 <20261104201403.2039921-7-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:25:05 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] HID: sensor: custom: duplicate callback removal in hid_sensor_custo=
m_probe()
--

commit 3c6fa7005fd38bc50c4da9b69a1182ec5457915f
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

HID: sensor: custom: Register enable attribute after misc device

This commit reorders hid_sensor_custom_probe() so enable_sensor_attr_group =
is
registered after hid_sensor_custom_dev_if_add() succeeds, preventing usersp=
ace
from enabling the sensor hub while probe can still fail.

> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index 4f824cadd370a..990e653995e15 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -1059,20 +1059,21 @@ static int hid_sensor_custom_probe(struct platfor=
m_device *pdev)
>  	if (ret)
>  		goto err_remove_callback;
> =20
> -	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> -				 &enable_sensor_attr_group);
> +	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
>  	if (ret)
>  		goto err_remove_attributes;
> =20
> -	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
> +	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> +				 &enable_sensor_attr_group);
>  	if (ret)
> -		goto err_remove_group;
> +		goto err_remove_dev_if;
> =20
>  	return 0;
> =20
> -err_remove_group:
> -	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> -			   &enable_sensor_attr_group);
> +err_remove_dev_if:
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
> +	hid_sensor_custom_dev_if_remove(sensor_inst);
> +	goto err_remove_attributes;
>  err_remove_attributes:
>  	hid_sensor_custom_remove_attributes(sensor_inst);
>  err_remove_callback:

[Severity: Low]
In hid_sensor_custom_probe() in drivers/hid/hid-sensor-custom.c, when
sysfs_create_group() for enable_sensor_attr_group fails and jumps to
err_remove_dev_if, sensor_hub_remove_callback(hsdev, hsdev->usage) is called
before hid_sensor_custom_remove_attributes(sensor_inst), followed by a goto=
 to
the immediately following err_remove_attributes label and a fallthrough to
err_remove_callback:

err_remove_dev_if:
	sensor_hub_remove_callback(hsdev, hsdev->usage);
	hid_sensor_custom_dev_if_remove(sensor_inst);
	goto err_remove_attributes;
err_remove_attributes:
	hid_sensor_custom_remove_attributes(sensor_inst);
err_remove_callback:
	sensor_hub_remove_callback(hsdev, hsdev->usage);

Because hid_sensor_custom_probe() still holds the initial reference on
sensor_inst until err_free (where kref_put() calls hid_sensor_custom_free()=
 to
free sensor_inst->data_fifo and sensor_inst), removing the callback at
err_remove_dev_if unregisters the callback while the field sysfs attributes=
 are
still exposed, and then calls sensor_hub_remove_callback() a second time at
err_remove_callback.

Should err_remove_dev_if just call hid_sensor_custom_dev_if_remove(sensor_i=
nst)
and fall through to err_remove_attributes and err_remove_callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104201403.2039=
921-1-srinivas.pandruvada@linux.intel.com?part=3D6
