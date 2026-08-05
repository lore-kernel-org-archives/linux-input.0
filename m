Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540643749FD
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948684; cv=none; b=r+P+aenJ1NkF2R3iJPRsVeTvEsyQcrn3zinEycQhgzv1QK5ITIExMQrPG92Li+0lr+0fH8vTLg+pSVmkUO39418lsdvNpP/fIIiQaEkIHVgQUXfIht3xprdaQIupLbVJBPtPbIEM1fr4RG7z2b+OEtZiR1GIgwc6JD80Y0uDLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948684; c=relaxed/simple;
	bh=zgfUE1BalYVnLJEGhKVwjUqRJDb6zHZSKGnsUf3eYIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QlGC8SkkDDW7bivigozNR6CDIXi0ECWwprgdWYU+dz6z9HesFH7n1VeUDl2LIUUeCL5CCA2BLoNEtc3pGaDOYIa8X9Mcbpb1G3i1O57iv1jOK007EmQeb+gbCWyvyrz4/7FA5AOELl5pYB362EhG8vtOFKnanq3psnNJDOazbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMVsCqQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMVsCqQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77E31F000E9;
	Wed,  5 Aug 2026 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948683;
	bh=rvl50VucpBVpWJETInG3ZSUfTAjA4wCki1wstf8bK4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMVsCqQy7Dsy+6d3R80hoWl7vUgVb/Cbl3Ewt0a281bPs92ynApgT6WOG0ySdne/E
	 g5OMDAGA8VuC+hek0TT3BnZaMyhC04K7KHVEijwbTFg4G784NVMo0wW7XVZSPsWfmJ
	 /Wm+Lua3C1dODVEJP50DG7hliTaQQ/aOOe8V+UOt/dsFbOq6QtM53L529+f5oxCVVj
	 /SEqMkePyU4JUhkTTgPvwCUALABoGL2Clrvw3CMh7j4BXDZQczQSB/U6EBk479ia6f
	 h2BwVMowflzU5yN5EpiLSzX3OHBsBmzLfdHwDf7lkCUKWaeweyAh2cGR4TDaSSgu2r
	 ZTiaEVMsq4Uhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: sensor-hub: fix out-of-bounds access in
 sensor_hub_get_feature()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806-hid-sensor-hub-oob-v1-1-f8e210e7eafe@cherr.cc>
References: <20260806-hid-sensor-hub-oob-v1-1-f8e210e7eafe@cherr.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:51:22 +0000
Message-Id: <20260805165122.C77E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The introduced bounds check allows reading adjacent independent it=
ems into a single item's buffer space when `report_size > 32`.
- [High] Byte-wise `memcpy` from native-endian `s32` array copies padding b=
ytes on Big-Endian architectures for fields smaller than 32 bits.
- [High] Fields smaller than 8 bits are silently dropped due to integer div=
ision by 8.
--

--- Patch [1]: [PATCH] HID: sensor-hub: fix out-of-bounds access in sensor_=
hub_get_feature() ---
commit b3260de30fa032d167e378c546af0b283ff6ce04
Author: Shengzhuo Wei <me@cherr.cc>

HID: sensor-hub: fix out-of-bounds access in sensor_hub_get_feature()

This commit addresses an out-of-bounds access issue in
sensor_hub_get_feature() by bounding the per-iteration copy size. It restri=
cts
the copy size to the minimum of the report size, remaining source buffer, a=
nd
remaining destination buffer.

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 90666ff629def..7e97ca98a3883 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -270,11 +270,18 @@ int sensor_hub_get_feature(struct hid_sensor_hub_de=
vice *hsdev, u32 report_id,
> =20
>  	val_ptr =3D (u8 *)report->field[field_index]->value;
>  	for (i =3D 0; i < report->field[field_index]->report_count; ++i) {
> +		int copy =3D report->field[field_index]->report_size / 8;

[Severity: High]
This is a pre-existing issue, but does this silently drop fields smaller
than 8 bits?

When sensor_hub_get_feature() is called for a sub-byte field (like a 4-bit
flag), the integer division by 8 evaluates to 0. This causes memcpy to copy
0 bytes, leaving the caller's buffer unpopulated even though the HID core
correctly parsed the value into the field->value array.

> +		int src_remaining =3D (report->field[field_index]->report_count - i) *
> +				    sizeof(__s32);
> +
>  		if (buffer_index >=3D ret)
>  			break;
> =20
> -		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
> -		       report->field[field_index]->report_size / 8);
> +		if (copy > src_remaining)
> +			copy =3D src_remaining;

[Severity: High]
This isn't a bug introduced by this patch, but does this bounds check still
allow reading adjacent independent items into a single item's buffer space?

The HID core truncates and stores each field item in a single 4-byte __s32
element. By bounding the copy size to src_remaining (the remaining size of
the entire field->value array) instead of a single element (sizeof(__s32)),
if the report size is greater than 32 bits, the copy size will exceed
4 bytes.

Could this cause memcpy to incorrectly read the next independent value
element from the array and append it to the current item?

> +		if (copy > buffer_size - buffer_index)
> +			copy =3D buffer_size - buffer_index;
> +		memcpy(&((u8 *)buffer)[buffer_index], val_ptr, copy);

[Severity: High]
This is a pre-existing issue, but does this byte-wise memcpy from a
native-endian s32 array copy padding bytes on big-endian architectures for
fields smaller than 32 bits?

The function extracts fields that the HID core has parsed into native-endian
32-bit integers. For a 16-bit field on a big-endian system, the valid data
resides at byte offsets 2 and 3, but memcpy copies from the lowest memory
address.

Could this result in returning zeroes by copying the most significant
padding bytes instead of the actual data?

>  		val_ptr +=3D sizeof(__s32);
>  		buffer_index +=3D (report->field[field_index]->report_size / 8);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-hid-sensor=
-hub-oob-v1-1-f8e210e7eafe@cherr.cc?part=3D1
