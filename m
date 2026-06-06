Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D637B415
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748831; cv=none; b=PWvSDc4SNpI50EY9BEi4kQXDddeBKh4lnHfF8Q6QtTCyXB1UQoFRl8L2Li/4pjP3gJgpCAOC/+mZWLL/b6Tsn9tVaziyow2ImseA+i5aPWbQVeVG4L5rmQKvEU1f36rLKWbQ+CZQqGMPb7M1tXdKh76GO53nR6guHSDyKJi1d5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748831; c=relaxed/simple;
	bh=uG79U5xyrKm+USlTJeuwJG9MwTVCcTgl6iJEDzY2bGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d3Ez9BtPaWqUdgOXxGpXbBHLxcX+P7atcFV9TAHqgUUP+Giu+b2Rv9OjiHh4LRgFL1qsIJP1U7EHfNH7SyMmAhv8R+H4id50HGMQbKRwvBdYHPV/vt9TET7xKNQtcSt7YDcojkxCAq3vJ1KMrUa5FvX09sDIpUaJ3yyZEi9Yu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjtBd57z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjtBd57z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6106B1F00898;
	Sat,  6 Jun 2026 12:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748830;
	bh=Nm5RLmGWmavVx+VIceX3JCgKuam/gjsLWlswscGBjes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WjtBd57zGs0qG3C5Sc4ICkGPNeXtRVZY/tmQv7WLa2+lwv62Iar95/kpCc9CMVQZE
	 Uf8kC7f3Fonb0X4hzuO8mkJhRrUUS4O6G+s9onKMPi9SCvs50teivjeRQ4MkfPktPH
	 uIJh6fS9lZ8M0287Ub+/YCc6IHTyY/ekb5lEwzHkQgsVeUiVrswGGsDNQgNubf+uD5
	 VMHKmzz3PxLs9B88cl1a/JaHcFxBTfrSLL2kKkghJ71Wi8Fjv32/E1sFTqC0/zjzsA
	 LZhTAPqk76wKCD5I0Trip7cfbA7CGmUmbcL5T4Ir7yUI9YGlnc7l3/I4fQ6vkfFNpM
	 RY0QnesDljXTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] iio: light: hid-sensor-prox: use u32 instead of
 unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-4-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-4-dd4a6820b674@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:27:10 +0000
Message-Id: <20260606122710.6106B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Direct casting of the raw HID byte stream pointer (`raw_data`) to =
`u16 *` and `u32 *` causes unaligned memory accesses and misinterprets litt=
le-endian HID data on big-endian architectures.
--

commit e810e65c50acb8fcba7f1cd54ed67e25dac1f409
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-prox: use u32 instead of unsigned

This patch updates the usage_id parameter to use u32 instead of a bare
unsigned type. This improves code clarity and consistency with standard
kernel style.

> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-=
sensor-prox.c
> index edc9274a2c076..9059f00f0cedf 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
[ ... ]
> @@ -183,7 +183,7 @@ static int prox_proc_event(struct hid_sensor_hub_devi=
ce *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is a pre-existing issue, but since you are updating types in this
function, could we also address how the raw_data pointer is accessed?

Further down in prox_capture_sample(), the raw HID byte stream is directly
cast to u16 and u32 pointers:

	switch (raw_len) {
	case 1:
		prox_state->human_presence[chan] =3D *(u8 *)raw_data * multiplier;
		return 0;
	case 2:
		prox_state->human_presence[chan] =3D *(u16 *)raw_data * multiplier;
		return 0;
	case 4:
		prox_state->human_presence[chan] =3D *(u32 *)raw_data * multiplier;
		return 0;
	}

Can this sequence cause unaligned memory accesses or endianness issues?

Because HID fields are tightly packed and can have arbitrary lengths, the
raw_data pointer is not guaranteed to be 2-byte or 4-byte aligned.
Dereferencing it directly could trigger unaligned access traps on
architectures that do not natively support them.

Additionally, HID reports are transmitted in little-endian format over the
wire. Reading them via a direct cast evaluates them in host byte-order,
which could yield corrupted data on big-endian architectures.

Would it be better to use get_unaligned_le16() and get_unaligned_le32()
here to safely extract the payload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-6-june-hid=
-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com?part=3D4
