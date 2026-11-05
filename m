Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793872639;
	b=cECelNd73zDzgxsBjeRG6i8/e1oqbNMviJKlWZRCH+1QOVXZNf16Aeec/xK1MpExfJdQ
	 qgmsizQ7gGtgTe3INHNFTlq4yLpt9X9ZI3Ff7nmBvAxzt+zcJ32UbMNz6QMszdB+hujdr
	 ND0qf+f8zdbJH5/SCV+pJP22Gaobu3gOwjheK1olczPEgl/3uBl+m6ibi/Wk5moTCpsaq
	 cdjv41osRW2/dJWBgIwVYRju4VhFUykL7X/fVoTk+12weGLp/FQM+KyuU8TxaQN2by9K0
	 rarj1sxTQcmMzAWQw4SnZy9UulCAWxhncrnbvy4pmn6dKP6mPm70XuXZD5amC61U2cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872639;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zznxmV7bl7CPlqJg9FJ1mO6UvyKXvVTzktwHEOuILeA=;
	b=BBoIR1sF2nHgHb8/fhK7z5nRCYgjIHv4R4H2PkOk4UCcweE8DIvdbJfKtjj/B3B6y8NY
	 2mkbAO03c2uTlSYbmac+zAGtpxV1bB0eJvCsQS11CyCIZ1rWfpTD+k6W9wpqQoKlCEXo2
	 O231upLJt48isyvafufeSxy3eKqOGbSjgbtoz3ljSH9eMaPTtGpoT0KnwDC2weV2830He
	 TqTsx2Mn7+Go4KpThGZEdn1usmypU8k229n/ucMyw4yQMzPTjr0QN/5yZjf8NDkYH/h2A
	 7xBFwHhtLFh/8L5vtit4ZaVTDKPMMwcvmyeV3siHY+bTtab+kHsEaIUffxHLjhJhcgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmqDX68j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664ED606A330;
	Thu,  5 Nov 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmqDX68j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793872639;
	b=lLYtc7kpfF2DFajYp5XZlXb5K3owqxzbtK7sjFlSdCtLR4Xswbi2P+xs5n8Q8E95fmJN
	 JFE94Df3wm8nqbVI87WBed4IU6hybBWzc3acip+p4wUfphky0rIW73h88usJZPOSuaJAR
	 jFQoTrFuJbBkMqvELvNGU4l0pDxzvKvILN44eE+rTf8QRzcWScsiTBmlp+4wy49UWE8nv
	 CIN81DVdeuL/h35XcsU7j3JQlCosg7FaJq1dRSBgXmCP7iKj8mMGx5xw1OgD4zDgdOYwA
	 EzXvojWRoqN0c4fpeNkkw+i/1GOgrR6lLLykRbGvLKsXbkScnSne4PmAce2ByvOQXpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793872639;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zznxmV7bl7CPlqJg9FJ1mO6UvyKXvVTzktwHEOuILeA=;
	b=nvSKmIOrZe/eJwu4MPJnwV4F/6fUd4swhK5JSMPvPUI5iykl+0frqu+JK1MwxgVkAv3L
	 W8U+Z+07JKHgyqtAQeo/np46QxpBXHlUMQk2rNKFhubGx2oj12L7MrKF3ilR9Qs/Xdl8r
	 c5WCYw/ohwHhI5q/a3jBuEGV83e3ZiPc3lE7p0jyVFtfK6+XsJwYtsOIZkejqKcCiwez6
	 /OrvFRow/tKIlVF96rbIIraSP+4HmedW5wgD0D8C1BcnevcwFNOl2E2WFZZqrtcf2VdPK
	 YGQvj9AuAOQjiELMqpSZ8eVMMUtTXoI2OFy3kjEWTrS4WmdIIfVSqJ+5tBgywoPoRaQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 953B21F00919;
	Thu,  5 Nov 2026 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872638;
	bh=zznxmV7bl7CPlqJg9FJ1mO6UvyKXvVTzktwHEOuILeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KmqDX68jv1ipBcIgXiYww16jeOCajaTDH34454igGL+gG06uSMkTtKqPzLSFhan3R
	 70+j4Px7zuT7DHHuL4tjOaAAIIR1jC2yz/oTBU+SHofKKZWBvkvHi6xxRtBVZsV8oh
	 CeWwmrFVWpSA55nS+humpY7MRZ6m9NxGwcgbnNWifChCet6VEfo44DQOJAt2kR+nWP
	 LKW5FfqFpfD68ckWHaKg/7RcEz2pRhQr0y9Lt5g0AzC1NAWc1YXm3E6xLb4uzZNjf7
	 hmEztQTOoV2EPZmHP+KJUHAQw746vQxKYb/M4n+GuH8FJz0qu0q46xjXh6RZ2FBLuj
	 pv3nahzSXG9Jg==
Date: Thu, 5 Nov 2026 10:57:14 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, simeon@maryasin.name, lixu.zhang@intel.com
Subject: Re: [PATCH v2 2/7] HID: sensor: custom: Set owner for misc device
Message-ID: <20261105105714.0000307e@kernel.org>
In-Reply-To: <20261104201403.2039921-3-srinivas.pandruvada@linux.intel.com>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
	<20261104201403.2039921-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Wed,  4 Nov 2026 12:13:58 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Set .owner in the misc-device file operations so open file descriptors
> keep the module loaded until their release callbacks have completed.
>=20
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
> Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> Closes: https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3D=
eUdbPthG2xrLqwQQ@mail.gmail.com/
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/hid-sensor-custom.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index c2b425afd951..72e5639cb1d9 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -719,6 +719,7 @@ static __poll_t hid_sensor_custom_poll(struct file *f=
ile,
>  }
> =20
>  static const struct file_operations hid_sensor_custom_fops =3D {
> +	.owner =3D THIS_MODULE,
>  	.open =3D  hid_sensor_custom_open,
>  	.read =3D  hid_sensor_custom_read,
>  	.release =3D hid_sensor_custom_release,

Reviewed-by: Joshua Crofts <crofts@kernel.org>

--=20
Kind regards,
Joshua Crofts
