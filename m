Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793504266;
	b=RO/VJASb3exxiCPT46vyCUF0tNtpBv0UkmJ4qsNywI3IgfT2nNJ9lxLhcbGLl7egnrm4
	 O21kY20NObGc+yQRqVrXKzZGh49DGrlKoUSeI58MihtR0WIs2Vh9fDtI134Cw97hgY8JP
	 qjmpldrie35mJxNyGiUpX/Y6fsWJHnvjmg/IrqPFt5DYUNX1fi+d0tfM+RK+klevl9JqU
	 SoPGgbGPDTzaeAi6ZUB8KMpQtJAiTSVCrWhv2TDHj7KKiZsWu4n2q1uQJ9f6UihJ8zV4c
	 6bUREv5rvumDP+IqLhlBDrcsnzZbRJ2J5QeFAX1HF/+7HCdLa8py2u1gTnsVZLxSyng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793504266;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CuLpQP3tJdYbac4mzK5XgcCvQDNF7znqOKkjorpQFLM=;
	b=S8AC2e9jkCq8hH2eMSNpwjSrJh89cHKse2E3YeQ4TfHANYMHcNKNiN/LLMafFIUDZEdH
	 /3TyY68xbJm+MkRfIb4/s1cA0+5ejAg3ehxQCQ4OVZYuxzzD8lx/SPYQDXTGgNkBqLbd0
	 UgfSO1Cp59F2X9Dlywb893BOJqbTUABoAixGNgZNgYRlbNY4VWCG/euM6hV4PLa9Lgsbz
	 UasjdPMM6J//bj2ly8LTLhQHDiYkmMZGOsU6VNQ54Z+ml1acQCTcU+5GPyQQFTadIUT4D
	 HWepfjVe/Jyvu88RfCxvz9q9iYO412wuee6mnk6/YgpWN4e442HtIEMlfge/K+Oft8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOmEag9j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B00606A325;
	Sun,  1 Nov 2026 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOmEag9j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C751F000C1;
	Sun,  1 Nov 2026 03:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793504265;
	bh=CuLpQP3tJdYbac4mzK5XgcCvQDNF7znqOKkjorpQFLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XOmEag9jSHXWLR84xw/yjGsa6YpgkCdu1c4/X4ScLwkjOnEGEDbvF8HPMK2iQZ5kh
	 aVUQ2jYBBRaxpRrvIEGruaC1ZVdH+uWhvPxeDPtWVNK0imS+CIJ71JKAy+VExBPe21
	 sbw89wV8HTFz1E462O/I6TqIkxc/MkiMfoT+lguJ7lU6PsPYsYs30YK1S/sdCkcKBC
	 OCDPnWbdhkszDwrR3hU1cTKZA7UipzISCQlTXm/16/PHQjDgnBCaR6ucDApmvv+ZGf
	 lqHCgnlnjVJVo0t+hQ40dqskXXtpohlMezAKsNeN8lA0L8ZheQkJJ0AU+dUmJaK9jW
	 d1CRAReERyQ+A==
Date: Sun, 1 Nov 2026 03:37:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Schaefer via B4 Relay <devnull+dhs.frame.work@kernel.org>
Cc: dhs@frame.work, Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, srinivas pandruvada
 <srinivas.pandruvada@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sven
 =?UTF-8?B?VmFpbmvDvGxh?= <sven@xn--vainkla-r2a.ee>
Subject: Re: [PATCH] iio: light: hid-sensor-als: Don't read past the end of
 short fields
Message-ID: <20261101033737.6c613263@jic23-hlaptop>
In-Reply-To: <20261027-iio-als-overread-v1-1-e47e2706368b@frame.work>
References: <20261027-iio-als-overread-v1-1-e47e2706368b@frame.work>
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

On Tue, 27 Oct 2026 18:58:39 +0800
Daniel Schaefer via B4 Relay <devnull+dhs.frame.work@kernel.org> wrote:

> From: Daniel Schaefer <dhs@frame.work>
>=20
> Reports are not guaranteed to be 4 bytes.
> On color ALS sensors there are fields that can be shorter than 4 bytes:
> 16-bit illuminance, color temperature and chromaticity x/y.
>=20
> I don't have such a sensor right now, but I have emulated one in
> firmware. With this patch, no garbage data is read from the next report:
>=20
>   before: 05dc02bc 05dc02bc 190005dc 0ce41900 00000ce4
>   after:  000002bc 000002bc 000005dc 00001900 00000ce4
>=20
> Same fix as commit ad02ca57e44e ("iio: hid-sensor-prox: Add support for
> 16-bit report size").
>=20
> Fixes: ed5514c925a0 ("iio: hid-sensors: Added ALS")
> Signed-off-by: Daniel Schaefer <dhs@frame.work>
Hi Daniel,

Seems in line with the referenced commit and to make sense to me.
So I'll pick this up now - however still time for more reviews as
I'll need to rebase on rc1 anyway in the next few days.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
> Tested on an emulated sensor with 2 byte reports that is correctly recogn=
ized
> by Windows.
>=20
> Cc: Sven Vaink=C3=BCla <sven@xn--vainkla-r2a.ee>
> ---
>  drivers/iio/light/hid-sensor-als.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index 929343e42d83..00dfc2037c19 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -267,7 +267,21 @@ static int als_capture_sample(struct hid_sensor_hub_=
device *hsdev,
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
>  	struct als_state *als_state =3D iio_priv(indio_dev);
>  	int ret =3D -EINVAL;
> -	u32 sample_data =3D *(u32 *)raw_data;
> +	u32 sample_data;
> +
> +	switch (raw_len) {
> +	case 1:
> +		sample_data =3D *(u8 *)raw_data;
> +		break;
> +	case 2:
> +		sample_data =3D *(u16 *)raw_data;
> +		break;
> +	default:
> +		if (raw_len < sizeof(u32))
> +			return -EINVAL;
> +		sample_data =3D *(u32 *)raw_data;
> +		break;
> +	}
> =20
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_LIGHT_ILLUM:
>=20
> ---
> base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
> change-id: 20261027-iio-als-overread-c9e538fa61fa
>=20
> Best regards,

