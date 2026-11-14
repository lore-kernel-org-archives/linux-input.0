Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794698498;
	b=nr3nyTwC8UNM1zZB0lwfdNsJST0bV2y2dYsc82Yu+sdYFKVWmUN+jyZu+INbwydB4WS0
	 hMkDpW9IL2bATnrhEdOlJww1T+tlHQlgMCce6noev3fBbhaQmjnKzeWoAutH100BEo1E5
	 NwlZbalQ1LGh6Myg4wzru5VSnDuy2HotEpUs5DV7e/dBbwNZ0V0x2SmqIpBdgfVSirgJJ
	 4wCbR+SNvYLcXbOc7D4kHWMb7wlLYO/Xews91HaKibfex5kb9whVAafwc+u68Vek4lcPf
	 hh+9H3uiryxXoLY6+sjUVjt10NIZ7qMPAotcTcGOwc1BwemgxSpAxEwdVkgbftDBJgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698498;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=df5aXYJ0jLlgu50iZ/o6v+mxuaUy15Ywwa+T+uQ3xFw=;
	b=Y0V5dboZo2mOX25f4ex54mbMu2PyK9X0oE9L/J+35h3ghobVjwrmHPiQ+IRkSQ9bYZin
	 Q7+lzGENkpamNoIiqygZNCvNXOVrLCfunaqrdrkKimfJZKwjkXhivJc/SX5q6nEHKt0WG
	 BEiNMfXU6aov0phrCgW15/v44A7IxjeyoG6oZepS3SQlVLhQWhdMLokBKZJhf4xz7OZpu
	 PxAJ+3/7zhRv5c+lvXcdAkaGbjj4CU0NKVP4m2PwMdkCywC25i6g2LDlYOJTX6kqri36k
	 CCWG2g+XJ0kOPzTPtHq4j/4GkCr+s9qt8bkVbmYdxS3K5WF7jQmMIgSTVlmgggE+ClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4ht3wBG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC7606A327;
	Sat, 14 Nov 2026 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4ht3wBG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F191F000C4;
	Sat, 14 Nov 2026 23:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794698498;
	bh=df5aXYJ0jLlgu50iZ/o6v+mxuaUy15Ywwa+T+uQ3xFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g4ht3wBGXeMDSc0Q3TNJL3GyLbPsaPNCPa/bKzf5dynUaUQCYHPSk40MYBOpZkEmM
	 93K2Eo44CSemhg8BRuHyALt9xVeYIrVCIe9HJpiydE4XvMC4xQX3RlyqqnSdViiKS2
	 iMpgOYQfX30+Gc+vQjCbaYY6LhrlFsWMpBAlQvLFsedi4kB8SULAYF05nyXmcovK0H
	 hy1ahi6ZgejGyDJ9OYN/S/P2MtQACznDVjywHWe2rLZ1olQ8Uq4qteTlt7wUzOAtGP
	 G+l7OlJiWy1U260ifRYcTC+RiJvMaTl61JDWSFOUGKtSvYWbaguDfiwVD3gZl/roii
	 p/+vB4aoKznqw==
Message-ID: <sashiko-outbox-215102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/16] HID: ft260: use lock guards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114230800.1344401-17-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
 <20261114230800.1344401-17-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:21:37 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: ft260: mixing guard(mutex) with goto cleanup in xfer
  functions
--

commit 27addf69822143f9d183be5b9b500ff0df6b356b
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: use lock guards

This commit converts mutex_lock() and mutex_unlock() pairs in hid-ft260 to
guard(mutex) and scoped_guard(mutex, ...).

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 53321c8d70fd0..716b37cead7dc 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -1034,12 +1031,11 @@ static int ft260_i2c_xfer(struct i2c_adapter *ada=
pter, struct i2c_msg *msgs,
>  	struct ft260_device *dev =3D i2c_get_adapdata(adapter);
>  	struct hid_device *hdev =3D dev->hdev;
> =20
> -	mutex_lock(&dev->lock);
> +	guard(mutex)(&dev->lock);
> =20
>  	ret =3D hid_hw_power(hdev, PM_HINT_FULLON);
>  	if (ret < 0) {
>  		hid_err(hdev, "failed to enter FULLON power mode: %d\n", ret);
> -		mutex_unlock(&dev->lock);
>  		return ret;
>  	}
> =20
> @@ -1063,7 +1059,6 @@ static int ft260_i2c_xfer(struct i2c_adapter *adapt=
er, struct i2c_msg *msgs,
>  	ret =3D num;
>  i2c_exit:
>  	hid_hw_power(hdev, PM_HINT_NORMAL);
> -	mutex_unlock(&dev->lock);
>  	return ret;
>  }
> =20
> @@ -1077,12 +1072,11 @@ static int ft260_smbus_xfer(struct i2c_adapter *a=
dapter, u16 addr, u16 flags,
> =20
>  	ft260_dbg("smbus size %d\n", size);
> =20
> -	mutex_lock(&dev->lock);
> +	guard(mutex)(&dev->lock);
> =20
>  	ret =3D hid_hw_power(hdev, PM_HINT_FULLON);
>  	if (ret < 0) {
>  		hid_err(hdev, "power management error: %d\n", ret);
> -		mutex_unlock(&dev->lock);
>  		return ret;
>  	}
> =20
> @@ -1190,7 +1184,6 @@ static int ft260_smbus_xfer(struct i2c_adapter *ada=
pter, u16 addr, u16 flags,
> =20
>  smbus_exit:
>  	hid_hw_power(hdev, PM_HINT_NORMAL);
> -	mutex_unlock(&dev->lock);
>  	return ret;
>  }

[Severity: Low]
This isn't a bug, but ft260_i2c_xfer() and ft260_smbus_xfer() now mix
guard(mutex) with goto-based cleanup at the i2c_exit and smbus_exit labels,
contrary to the cleanup.h convention of not mixing scope-based cleanup with
goto unwinding in the same function.

In ft260_i2c_xfer(), the i2c_exit label can be dropped by calling
hid_hw_power(hdev, PM_HINT_NORMAL) after the if/else block and returning
ret < 0 ? ret : num, while ft260_smbus_xfer() could either factor the
transfer switch into a helper or keep explicit mutex_lock() and
mutex_unlock() alongside smbus_exit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114230800.1344=
401-1-michael.zaidman@gmail.com?part=3D16
