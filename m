Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F42EA754
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446025; cv=none; b=KhPgPq2TWXm2OuPLdCeH2E2GKMnfzLPWKxCsFUD2cUFh3FDB9wUxXcd8IcKes13DyhFEu41BGbqlO/jl3XUl1+lNMhNiCeWjOOSBdO1PX64I7pyEoQJw/2MaAVhD0X+nYfjirAax/VqO93oa4fpHgjDhAeh1Il/KGxOJAMrAaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446025; c=relaxed/simple;
	bh=zinu8D1Entf9CPxgRYXsDGGxxzhvdWcNWCHKdM56Oec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTYuNDQ0kshwbKfAoPWhdpM3gwIggCzQ+Ku7Heh7oQkINeRh3kqS4XoXohZh4qETcZxKVPxrPeNcZOLhJURZxXX2CE3TS+CUJDwiV22QOqNhljJ9VJaP+oWIqNmptB77AAYQxxI3sx2dvdSiEKuwUao6HYlVep/El+oIIcwxzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Ke7yRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Ke7yRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3C21F000FF;
	Tue, 15 Sep 2026 04:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789446024;
	bh=eLKvc23oh0hr15kRsC40NFeUMqlkUKj9IjZere0UlyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8Ke7yRqBLW7l4G74L/p8p5jrpokC+EKKV0/zjt2NVtksKT8DQXVmkAICjgWFQygI
	 bsXaGwUIKEsFWIohFdbVkNF/+egWSEmI5KLU7BZLYyHWsFs5G7Mf4rvckUnLIFsQ4n
	 Chby2zKKzQbq8EwlBQAqy99SPyzzNoS7gwK+d0NkFIh8O3xN2IEEtcX5tBdFFmqj0Q
	 IWm8fUuqJ42YkQGMS/miyDHooyDPu7E3ZvKaOfKv8hUFLgD3VXj7LALohAQuheMqoH
	 PqdIXh6kpivlT4WiIUBtBUu40sKTIL/loLGnMxUAAErLIC+1tUy3vzUOuArQ/MLpKN
	 rbF1mOh/N9D5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: validate battery range before scaling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260915041248.2432629-1-qwe.aldo@gmail.com>
References: <20260915041248.2432629-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 04:20:23 +0000
Message-Id: <20260915042023.CC3C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: wacom: battery updates and initialization skipped on out-of=
-range values
--

commit 2de6d44ab126bd3e2386ea0695c8fb70e0ec0e11
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

    HID: wacom: validate battery range before scaling
   =20
    Battery events divide by the difference between the logical maximum
    and minimum without validating the range.  A malformed HID descriptor
    with equal limits can therefore trigger a divide-by-zero exception.
   =20
    Move percentage conversion to a helper that widens the arithmetic,
    rejects non-positive ranges and out-of-range results, and accounts for
    a nonzero logical minimum.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8feb8027be95e..1d6a72320a6e1 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c

[ ... ]

> @@ -1952,6 +1953,24 @@ static void wacom_wac_battery_usage_mapping(struct=
 hid_device *hdev,
>  	return;
>  }
> =20
> +static bool wacom_wac_battery_percentage(struct hid_field *field, __s32 =
value,
> +					 __s32 *percentage)
> +{
> +	s64 range =3D (s64)field->logical_maximum - field->logical_minimum;
> +	s64 result;
> +
> +	if (range <=3D 0)
> +		return false;
> +
> +	result =3D div64_s64(((s64)value - field->logical_minimum) * 100,
> +			   range);
> +	if (result < 0 || result > 100)
> +		return false;

[Severity: Medium]
Will this aggressively drop events when a hardware ADC reports a raw value
slightly out of bounds (such as when fully charged or discharged)?=20

Should this clamp the percentage to [0, 100] instead of returning false so
we don't drop the event entirely?

> +
> +	*percentage =3D result;
> +	return true;
> +}
> +
>  static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_=
field *field,
>  		struct hid_usage *usage, __s32 value)
>  {
> @@ -1965,7 +1984,8 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>  			wacom_wac->hid_data.bat_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
>  		}
>  		else {
> -			value =3D value * 100 / (field->logical_maximum - field->logical_mini=
mum);
> +			if (!wacom_wac_battery_percentage(field, value, &value))
> +				return;

[Severity: Medium]
If the very first report is slightly out of bounds, could this early return
in wacom_wac_battery_event() skip setting the WACOM_QUIRK_BATTERY quirk bel=
ow,
preventing the battery power supply from being registered at all?

>  			wacom_wac->hid_data.battery_capacity =3D value;
>  			wacom_wac->hid_data.bat_connected =3D 1;
>  			wacom_wac->hid_data.bat_status =3D WACOM_POWER_SUPPLY_STATUS_AUTO;
> @@ -1973,7 +1993,8 @@ static void wacom_wac_battery_event(struct hid_devi=
ce *hdev, struct hid_field *f
>  		wacom_wac->features.quirks |=3D WACOM_QUIRK_BATTERY;
>  		break;
>  	case WACOM_HID_WD_BATTERY_LEVEL:
> -		value =3D value * 100 / (field->logical_maximum - field->logical_minim=
um);
> +		if (!wacom_wac_battery_percentage(field, value, &value))
> +			return;
>  		wacom_wac->hid_data.battery_capacity =3D value;
>  		wacom_wac->hid_data.bat_connected =3D 1;
>  		wacom_wac->hid_data.bat_status =3D WACOM_POWER_SUPPLY_STATUS_AUTO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915041248.2432=
629-1-qwe.aldo@gmail.com?part=3D1
