Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794082914;
	b=5QXpFoi5aAC5eCMzXpWqHtsTxH4srYguO+A/k/Lq43eloDYiIf8SfuLfB6SIJQ9LJVW3
	 2e1p2tCMbQYQG9RLg7KRSbuPidk/5pixmEwbzt02Tt868WhBSFsT6uElKsJxcYkGfcOBb
	 3Z/tfVtOhGIq+8xk9d9vmy1mdG4gOjZP24f9awtKZ9G5qczB07YNxpd8teGnZYi32Tll+
	 J1Q6xdqs5p9aFfTvivW16CdITKowgYLI9e/kJ8e4jr/gaPhGUu/IxFx8DNGrOtt8nuZ3Y
	 eUn28KkmqkCNC7peY1E5SAMEXaVXQeH5ta6CD0xpPJUEASLz06JeHZ/GAafv7eWxjrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082914;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iOwit2Ku4CCe/YVLF5K+4NP4fyPujtIn150tHCKWHxk=;
	b=ODYPRZP1jx76Xrn1mbgrdhAURpZefgBwWL2YAMpBMLqZQ9fwtbQn43ovr1PlFW7JdfSx
	 BFTUp8K3+nwfbPxC3nSCRhKx380S8PAzVRhPeiHIwkdWSiWsjPL2sRGx1nPFvpE899z+E
	 CAqUfzWq//nUMq2dH2nX0F5K4FLH6FkdrxiU/qYGSl1uyiIovdbjprcpt4qV2bE7zHJEI
	 ONqaKKnTubyl/vUABKCB32h3dRrCKGPS3KDi6cl+cGEtioPETdOjC35M8TAWC1cIxp67s
	 nozXJ/SB8TN7pq2AI6I5l0X0kyq9L6Eq/G4cA5tBny6MWub3V4XVdpsDxYXT1WnggcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kmhoz4B/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22721606A32C;
	Sat,  7 Nov 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmhoz4B/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DAF1F0089F;
	Sat,  7 Nov 2026 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794082913;
	bh=iOwit2Ku4CCe/YVLF5K+4NP4fyPujtIn150tHCKWHxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kmhoz4B/0b2Xv7nnG6Swq1Pzb0a/Bud/bYmZr826wW3aB83Yi7EVOd9c/4DKQYRMm
	 RXC6v0mnJsPbn38aoM3wUDwPko+FNPzaldyAoAlXif4EOnxGayt2JjcO1XfWysIlYi
	 c9wXovv6QqksWbsTvVX17pMNrMlw4c+D+gaCMbTd1mmKtzEZ+nJO1ORywKh/O4tVxH
	 RVbEEQhvY68libjvp1g9WMSZZQerDzaBQDu3ohC/+jOR1t7D7o71BM/TOhq56h6uuR
	 pWqBsZkd2CqexTHFYaSnGXhEFFygZc0pfFXrt3GYgELKeA/+yJl71i+8CXyekmvTdg
	 JvRSvTdpXKudw==
Date: Sat, 7 Nov 2026 20:21:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 simeon@maryasin.name, lixu.zhang@intel.com, crofts@kernel.org
Subject: Re: [PATCH v2 4/7] HID: sensor: custom: Fix state lifetime during
 removal
Message-ID: <20261107202145.0348a033@jic23-hlaptop>
In-Reply-To: <20261104201403.2039921-5-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
	<20261104201403.2039921-5-srinivas.pandruvada@linux.intel.com>
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

On Wed,  4 Nov 2026 12:14:00 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Open misc device files can outlive platform-device removal. Since the
> devm-allocated state can be freed while a reader is queued on its wait
> queue, subsequent file operations may access freed memory.
>=20
> Allocate the state independently of devres and give every open
> file a reference to keep the FIFO and state alive after removal.
>=20
> On removal, mark the device as disconnected and wake readers; make reads
> return -ENODEV and polls report hangup and error. Free the FIFO and state
> when the final reference is released. Unregister the sensor hub callback
> before tearing down the interface so in-flight raw-event processing
> finishes before the sensor state can be freed.
>=20
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3D=
eUdbPthG2xrLqwQQ@mail.gmail.com/
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Looks like fairly standard fix for this style of lifetime issue.

One trivial comment inline.


> =20
>  /*
> @@ -978,8 +1004,7 @@ static int hid_sensor_custom_probe(struct platform_d=
evice *pdev)
>  	int ret;
>  	const struct hid_sensor_custom_match *match;
> =20
> -	sensor_inst =3D devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
> -				   GFP_KERNEL);
> +	sensor_inst =3D kzalloc_obj(*sensor_inst);
>  	if (!sensor_inst)
>  		return -ENOMEM;
> =20
> @@ -989,6 +1014,7 @@ static int hid_sensor_custom_probe(struct platform_d=
evice *pdev)
>  	sensor_inst->hsdev =3D hsdev;
>  	sensor_inst->pdev =3D pdev;
>  	mutex_init(&sensor_inst->mutex);
> +	kref_init(&sensor_inst->ref);
>  	platform_set_drvdata(pdev, sensor_inst);
> =20
>  	ret =3D hid_sensor_custom_get_known(hsdev, &match);
> @@ -1000,7 +1026,7 @@ static int hid_sensor_custom_probe(struct platform_=
device *pdev)
>  		if (ret) {
>  			dev_err(&pdev->dev,
>  				"register_platform_device failed\n");
> -			return ret;
> +			goto err_free;
>  		}
> =20
>  		return 0;
> @@ -1010,7 +1036,7 @@ static int hid_sensor_custom_probe(struct platform_=
device *pdev)
>  					   &sensor_inst->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		return ret;
> +		goto err_free;

Trivial but given it might free I'd all that label err_put

>  	}
> =20
>  	ret =3D hid_sensor_custom_add_attributes(sensor_inst);
> @@ -1035,6 +1061,8 @@ static int hid_sensor_custom_probe(struct platform_=
device *pdev)
>  	hid_sensor_custom_remove_attributes(sensor_inst);
>  err_remove_callback:
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
> +err_free:
> +	kref_put(&sensor_inst->ref, hid_sensor_custom_free);
> =20
>  	return ret;
>  }
> @@ -1046,9 +1074,10 @@ static void hid_sensor_custom_remove(struct platfo=
rm_device *pdev)
> =20
>  	if (sensor_inst->custom_pdev) {
>  		platform_device_unregister(sensor_inst->custom_pdev);
> -		return;
> +		goto out;
>  	}
> =20
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	hid_sensor_custom_dev_if_remove(sensor_inst);
>  	/* Remove enable_sensor first as it uses fields via power_state/report_=
state. */
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> @@ -1061,7 +1090,8 @@ static void hid_sensor_custom_remove(struct platfor=
m_device *pdev)
>  	}
>  	mutex_unlock(&sensor_inst->mutex);
>  	hid_sensor_custom_remove_attributes(sensor_inst);
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
> +out:
> +	kref_put(&sensor_inst->ref, hid_sensor_custom_free);
>  }
> =20
>  static const struct platform_device_id hid_sensor_custom_ids[] =3D {

