Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D073D5C23
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785960721; cv=none; b=b8qYdTvtmJA8rVkewNwkQG0dPrCkjP8Ui1dNVXqZVo2f14ufL4OJ/tvP9V98m4p9YkkEwhKmRYpUQDsJWJjK5vMqHWNON2ImZQoQiRmWGcGO03pA3IKY4z4ERs3MWA/dcz778Z/v452A3Nn2J9wAy14vpwlYR4DNX1zOHhdEGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785960721; c=relaxed/simple;
	bh=PcK9/rtSbT+UxKdle10FoN9QCS3ec6i6Mk9aOu7hnl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VuGCuUsTMHSFKCmiGm9fjxiLmSbU8On0sykaKkvLrPP6opROs2re2vSOd8byTxTv/GKkw+7k6sYLrPzTQc/dC8cZ4a/J3+ltj6DSdSgTUDN4+0jxKBIB8DmIhgvEH9rNEHJRc3iPtEr3XxJSrEwKLUaNQorUzefzyBg4oqzSjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knOhINJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knOhINJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F261F000E9;
	Wed,  5 Aug 2026 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785960719;
	bh=KK6ioGSOXMq+8+4QGrYC+oCj1B6+2a7YqyhQNHTWyFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=knOhINJeNrepxOWWP03DnpyhDdL54Nh63tkwwtsBiDrPHaGGoK3y3AeNOlrUBzT1I
	 D9dnnsXRyGCuoaRcaKKDRayWUdBm2s8jtvP89DGV4k8TlYzYOEWHY9vahNqh0r1LZE
	 uYva17iFsGTepOtJ5ccLKA+ie7NApkgtwXHrqPm0zpjEYF/jWNmq0y1yDpWK5741+F
	 IBFqYRglxg5nLbSlrDCqpp8sFMBozd3S1eEYpd5xBmPUHPUSjN+SDe/VKbOEhzUFqj
	 UzCD/MhYHhiAtqxVRk7C+dVfAy/8sjQuPnkphXU+Xlzcz0EMYNxGjFfaEFnJekHDp2
	 GLLygsV6Y50JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 RESEND] HID: sensor-hub: Fix out-of-bounds write in
 sensor_hub_get_feature
Reply-To: sashiko-reviews@lists.linux.dev
To: bakabaka9 <baka9@bakabaka9.tech>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260805185753.3069-1-baka9@bakabaka9.tech>
References: <20260805185753.3069-1-baka9@bakabaka9.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:11:58 +0000
Message-Id: <20260805201159.63F261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Both `sensor_hub_get_feature` and `sensor_hub_set_feature` imprope=
rly handle endianness, causing silent data corruption when interfacing with=
 sensor hubs on Big-Endian architectures.
--

--- Patch [1]: [PATCH v2 RESEND] HID: sensor-hub: Fix out-of-bounds write i=
n sensor_hub_get_feature ---
commit 75b1fca160b481a6f3fa0937e0916de1a229cdf0
Author: Xingrui Li <baka9@bakabaka9.tech>

HID: sensor-hub: Fix out-of-bounds write in sensor_hub_get_feature

This commit resolves an out-of-bounds write vulnerability in
sensor_hub_get_feature() by validating the feature field size and clamping
the per-value copy to the remaining capacity of the caller-supplied buffer.

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 90666ff629def..9bbda38ded968 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c

[ ... ]

> @@ -258,26 +263,29 @@ int sensor_hub_get_feature(struct hid_sensor_hub_de=
vice *hsdev, u32 report_id,
>  	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
>  	hid_hw_wait(hsdev->hdev);
> =20
> +	field =3D report->field[field_index];
> +
>  	/* calculate number of bytes required to read this field */
> -	report_size =3D DIV_ROUND_UP(report->field[field_index]->report_size,
> -				   8) *
> -				   report->field[field_index]->report_count;
> -	if (!report_size) {
> +	field_size =3D DIV_ROUND_UP(field->report_size, 8);
> +	/* HID core stores each parsed report value in a __s32 slot. */
> +	if (!field_size || field_size > sizeof(field->value[0])) {
> +		ret =3D -EINVAL;
> +		goto done_proc;
> +	}
> +	if (field->report_count > SIZE_MAX / field_size) {
>  		ret =3D -EINVAL;
>  		goto done_proc;
>  	}
> -	ret =3D min(report_size, buffer_size);
> =20
> -	val_ptr =3D (u8 *)report->field[field_index]->value;
> -	for (i =3D 0; i < report->field[field_index]->report_count; ++i) {
> -		if (buffer_index >=3D ret)
> -			break;
> +	report_size =3D field_size * field->report_count;
> +	report_size =3D min_t(size_t, report_size, buffer_size);
> =20
> -		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
> -		       report->field[field_index]->report_size / 8);
> -		val_ptr +=3D sizeof(__s32);
> -		buffer_index +=3D (report->field[field_index]->report_size / 8);
> +	for (i =3D 0; i < field->report_count && copied < report_size; ++i) {
> +		to_copy =3D min(field_size, report_size - copied);
> +		memcpy(&((u8 *)buffer)[copied], &field->value[i], to_copy);

[Severity: High]
This is a pre-existing issue, but does this memcpy() cause silent data=20
corruption on Big-Endian architectures?

HID core extracts report bits into a native CPU-endian __s32 format, but
this memcpy() fetches the lowest-addressed bytes. On Big-Endian platforms,
the lowest memory address of the native integer contains the most significa=
nt
bits, which are zero-padding for fields smaller than 32 bits. Will this copy
padding bytes instead of the actual data?

Similarly, in sensor_hub_set_feature():

drivers/hid/hid-sensor-hub.c:sensor_hub_set_feature() {
	...
	ret =3D hid_set_field(report->field[field_index], i,
			    (__force __s32)cpu_to_le32(*buf32));
	...
}

Does converting the native integer to Little-Endian before passing it to
hid_set_field() break Big-Endian architectures? It looks like HID core
expects a native CPU-endian value to correctly extract the least significant
bits to populate the little-endian HID report byte stream.

> +		copied +=3D to_copy;
>  	}
> +	ret =3D copied;
> =20
>  done_proc:
>  	mutex_unlock(&data->mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805185753.3069=
-1-baka9@bakabaka9.tech?part=3D1
