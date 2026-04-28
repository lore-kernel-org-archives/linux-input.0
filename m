Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C92324B1F;
	Tue, 28 Apr 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393820; cv=none; b=Tt+xkexYT786j/rKcUrx38pEURk0ZR7aIweT0SEx+dQQ623yHZsQN9mA90SET/qSL6gFW12aU+/XugTBsZT/9tWE/rnVnsJsq1YmFK77hqTAUhN0YE6XBANoOrwSp/N/VhKjkJ4MfoSUBZXclB7oCF1hcmUj5S7JE4RW+7tEhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393820; c=relaxed/simple;
	bh=wZ5QhLelTfJlNm1sk4g4BlXwbUEDtPA6set7gVqycOI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iZhAlMdkusaXLD4Ft9l6oaKQICBCfy8x4vDPOen8QCBJbuoOMIgukJrxWZhTt+uMTIqT3LJ3le7t6nqUglBT9HM5uWtOvDgkLC0rl912IN2YaVXWR05Y8kfo+8TPeXthaLEpuA/jQXAHxA1dFUMJ7178JjBA9lHa8bXRfqw66Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogEIGMlp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogEIGMlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD3CC2BCAF;
	Tue, 28 Apr 2026 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393819;
	bh=wZ5QhLelTfJlNm1sk4g4BlXwbUEDtPA6set7gVqycOI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ogEIGMlptK4gyhLCEMu3gyDIdI1tbyD9NPKF/LUeMt+AUYdfg7MDtwkHx4p1mZDI5
	 UzhXANDiiwKpzAy+s2TZ/w3mmv3t/gcdilSFxi2KZkLz97sxjWh/f8eKrCaSvyrwj7
	 qvsw2fyMJMCfS3sSzB5Cihe7IMzTFJCwh9HMGiscZnLIXa11Br0FyNBBEeaD6OfXY1
	 Te1X+YhEvy6gWX6qgEEMtVRcMSejoFLA2o6koOzpzC6D1fZv5zpwSQ6aCwonVaU0K+
	 1BojaForpnjVTFX6T63nYXl44emqNB1qkmD0xxhwZCKYrfXPTnse56zwRaK6by7/YE
	 noMbpt7HiL7yw==
Date: Tue, 28 Apr 2026 18:30:17 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Damien Dejean <damiendejean@google.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    =?ISO-8859-2?Q?Kornel_Dul=EAba?= <korneld@google.com>
Subject: Re: [PATCH] HID: elan: Add support for ELAN SB974D touchpad
In-Reply-To: <20260414133858.3992799-1-damiendejean@google.com>
Message-ID: <sq0oo917-n6r1-5s80-6nq6-4prqs78q219r@xreary.bet>
References: <20260414133858.3992799-1-damiendejean@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Apr 2026, Damien Dejean wrote:

> Elan SB974D touchpad uses ELAN_MT_I2C format to send HID reports. Add an
> entry to match for the device and parse its vendor specific format.
>=20
> Signed-off-by: Damien Dejean <damiendejean@google.com>
> Signed-off-by: Kornel Dul=C4=99ba <korneld@google.com>
> ---
>  drivers/hid/hid-elan.c | 1 +
>  drivers/hid/hid-ids.h  | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
> index 76d93fc48f6a..0190ad567ce4 100644
> --- a/drivers/hid/hid-elan.c
> +++ b/drivers/hid/hid-elan.c
> @@ -513,6 +513,7 @@ static const struct hid_device_id elan_devices[] =3D =
{
>  =09{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_HP_X2_10_COVER),
>  =09  .driver_data =3D ELAN_HAS_LED },
>  =09{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_TOSHIBA_CLICK_L9W)=
 },
> +=09{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_SB974D) },
>  =09{ }
>  };
>  MODULE_DEVICE_TABLE(hid, elan_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0cf63742315b..8cfec7dced66 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -455,6 +455,7 @@
>  #define USB_DEVICE_ID_EDIFIER_QR30=090xa101=09/* EDIFIER Hal0 2.0 SE */
> =20
>  #define USB_VENDOR_ID_ELAN=09=090x04f3
> +#define USB_DEVICE_ID_SB974D            0x0400
>  #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W=090x0401
>  #define USB_DEVICE_ID_HP_X2=09=090x074d
>  #define USB_DEVICE_ID_HP_X2_10_COVER=090x0755

Applied to hid.git#for-7.1/upstream-fixes, thanks.

--=20
Jiri Kosina
SUSE Labs

