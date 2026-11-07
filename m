Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082571;
	b=sbxxFFOpqYcNFpiVMO1QJ2ErYfNL8bdG/dwVb48Cw9IumZ+oil1PS0u3LUBpQPbOWvvx
	 wZG+SB3FlwRMVaqPJK3H9WJU6tb/MclkNKwUeeLtqhX9kVR2MaZt5tCu9pqjR+IX9wBM2
	 GFuqiiz8Sd9JSIV4kMskOrelW63+0pH9VwkoZUQlO9pAI0/bI/siMvBlQrJjDpB4DqrHi
	 nLL4QloiOR88dHhT2pPOT+VgFjcz+Fg9FXUGGETErMoUd6biceGamLi41ZJrCqPUGolcL
	 ZU2BnJMfwZRyYfwLuwKx6F2EapnQ02aCeDzC0nXE8uOph6p2xP6H55dq2R1StKNFXYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082571;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FJ6uIHCg/Nv3UfSn+KtMNeOWaSMTeRzKLIHEwClVtTk=;
	b=Ho6xC/qEVUPO2ekwAlFO9pR2h9B4Ok8dhvsYZIfVc6z7hSNNSMiuBNLSUA71f07C5EEB
	 RlN/QPVy78G1Uhl4iGpdwr7OKW+fBWbVCyFchPzbh+LpM+69h7/lmaLjlKDErA84zupTq
	 n968o8lCJGZn6+bLlVbXkN+zEqnnnzanmC2MnAbqDixkwKSElQwMPzD6MnQ+jnrwpRKUn
	 KuObUz4O2nElON6N8mvBq6PwUCFJPM2YnhPldNWsn0GS66wUu5LpCjQCHWG/TFZd19gNr
	 aZtdWZUQmAJomADR0C0mEW7B2pyoL0waqW7E8jFaYM7/ACJ8vLtxzMjpbw971n45pgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QELX8uWM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C4606A32F;
	Sat,  7 Nov 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QELX8uWM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5241F0089F;
	Sat,  7 Nov 2026 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082570;
	bh=FJ6uIHCg/Nv3UfSn+KtMNeOWaSMTeRzKLIHEwClVtTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QELX8uWMXEX56NX2jthu56daLO/ojSTqfXaeHYuRnszElirpFRDSBfRFF0fGy8Vt8
	 SmXsMoAseLiGGqyOc9cyzHwNxZct6yuTmkbv59Oqk378JzqAgNrJGugJJX04obsUO3
	 +z51GA9srCRx9C6AJswM9jBRbIwrSm7hBkWr6r/5pBTfGv2Gxdhc2UrlA/LqeF+lPO
	 0QRjMp+9entkNETSvVTc97mJnNN+YlsYOBnPLPHo1J3u9jjcmL8q7qEOSPgi5+Sjbr
	 bFX4ksF6hXMxxGI6crv9a2PYfXc3+g5Q5TQElJoxZNsA1Fcoftp339Kcq2m9e8J00B
	 yKkBLYJZV7v1g==
Date: Sat, 7 Nov 2026 20:16:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 simeon@maryasin.name, lixu.zhang@intel.com, crofts@kernel.org
Subject: Re: [PATCH v2 6/7] HID: sensor: custom: Register enable attribute
 after misc device
Message-ID: <20261107201601.7d5aa69f@jic23-hlaptop>
In-Reply-To: <20261104201403.2039921-7-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
	<20261104201403.2039921-7-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  4 Nov 2026 12:14:02 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Register the enable_sensor sysfs group only after misc-device setup
> succeeds. This prevents userspace from opening the sensor hub while
> probe can still fail, which would otherwise leave the hub open reference
> unbalanced on unwind.
>=20
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3D=
eUdbPthG2xrLqwQQ@mail.gmail.com/
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
You probably already saw it, but sashiko had more feedback.
https://sashiko.dev/#/patchset/20261104201403.2039921-1-srinivas.pandruvada=
%40linux.intel.com

I haven't looked closely at it though so might be either wrong
or material for a future patch.

One rather odd looking thing in here though.


> ---
>  drivers/hid/hid-sensor-custom.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index 4f824cadd370..990e653995e1 100644
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

If my eyes are tricking me, isn't this going to the next line?

>  err_remove_attributes:
>  	hid_sensor_custom_remove_attributes(sensor_inst);
>  err_remove_callback:

