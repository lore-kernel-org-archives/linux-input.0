Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552342ECEB9
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135001; cv=none; b=hDbLKXRA9GwKMRYW4OxOkb+pHEWXeV8ZXtFM/Ileaj2BpBoYMGyxsi2hlr/Zs6arrzNf5N2/ZcPI4ZKesWdyU6H5HQRP4jy+M5DBRfWrGXPeAlfqPoXXt0LXCOeVaiK9MAQVp9GjdwEC+WAEmUJA0I3ExN6hldcra4xz6XBAap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135001; c=relaxed/simple;
	bh=m0plmlj3d1J2UBtw3XgLI4RKcLU6t27w+3YXVPol3+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sJp70sBfyd6YU6FKhlimAjgLhlIYOEA3o88NgxzUTRzIjiTbOqmirtW2PyJ7VLv4F9iHgvqkeXYIF48PKp37cpvr513aXiQ7AvfZxdSV++p2Lao6Aoe6zATw+2NrVqPbiKzKB9FgoBShLjtiqJc7Jb583hoRMuEMoYnkpJv6cSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HobY0SDx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HobY0SDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD71C2BCB7;
	Mon, 18 May 2026 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135000;
	bh=m0plmlj3d1J2UBtw3XgLI4RKcLU6t27w+3YXVPol3+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HobY0SDx1V4635LSWNThQTj+AU5VFyZ5J0xzeDZQhjgUcF85XXemEc9cYbjeTwJgj
	 a8JIlDngMgwetZMy9tLw5f8+A+ur2E8Ye/wMfpmJ6VKGfxXhpahULSukgqp4SJogUE
	 lhLwAii6DN8L+WLd09Rl4gbz227zz+Bv+7L1qMNOeD8hCRNCcMAOCKisEg5ZqBf1uz
	 X+x3f1FrUDjr0gsmvXe6+A8OKAK7PTYDNuNo7e5UrWlLI8x3wAZY7LcffjoBfnpsvX
	 D9Ms7+c2idndKCP2FVVKBneXrgyBlnz3oSzA4xjhxNFG+rDyU8YtCaKNuvIH+Bu0n/
	 QupvpzhnFfsow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: sync wheel multiplier on wheel
 mode changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lauri Saurus" <saurla@saurla.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260518192649.245691-1-saurla@saurla.com>
References: <20260518192649.245691-1-saurla@saurla.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 20:10:00 +0000
Message-Id: <20260518201000.BBD71C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The logic incorrectly assumes that the device's response to the `C=
MD_HIRES_WHEEL_SET_WHEEL_MODE` command will echo the requested mode in its =
payload (`data[4]`), violating HID++ 2.0 protocol behavior.
- [Medium] The function `hidpp20_hires_wheel_raw_event` strictly checks for=
 `REPORT_ID_HIDPP_LONG` (0x11), completely ignoring responses sent via Very=
 Long (0x12) reports.
- [Low] Data race on `wheel_multiplier` and `hires_wheel_multiplier` due to=
 unprotected concurrent accesses across interrupt and process contexts.
--

commit 83eeb25697adad15bd7ac874fb7119dc29516cf1
Author: Lauri Saurus <saurla@saurla.com>

HID: logitech-hidpp: sync wheel multiplier on wheel mode changes
   =20
The hid-logitech-hidpp driver enables high resolution scrolling on
device connect for capable HID++ 2.0 devices. Driver also reads the
wheel capability and caches the returned high resolution wheel scroll
multiplier, that is used for scroll scaling when handling wheel scroll
events.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index b1330d23bd2d0..3afd8caf02911 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> +static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
> +						u8 *data, int size)
> +{
> +	if (hidpp->hires_wheel_feature_index =3D=3D 0xff)
> +		return 0;
> +
> +	if (size < 5)
> +		return 0;
> +
> +	if (data[0] !=3D REPORT_ID_HIDPP_LONG ||
> +	    data[2] !=3D hidpp->hires_wheel_feature_index)
> +		return 0;

Does this code need to handle VERY_LONG reports as well?

Userspace tools or newer devices might transmit FAP commands using
REPORT_ID_HIDPP_VERY_LONG (0x12). If the request is a VERY_LONG report, the
response will also be VERY_LONG, and this check would drop it, failing to
update the multiplier.

> +
> +	if ((data[3] & 0xf0) =3D=3D CMD_HIRES_WHEEL_SET_WHEEL_MODE) {
> +		u8 mode =3D data[4];
> +		bool hires =3D (mode & 0x02) !=3D 0;

Does the HID++ 2.0 protocol guarantee that SET command responses will echo
the requested mode in the payload?

In the FAP protocol, responses to SET commands often return an empty
(zero-filled) payload. If the device returns a zero payload, data[4] would
be 0x00. The code would then evaluate hires =3D false and forcefully set the
multiplier to 1, even if high-resolution mode was successfully requested.

> +		int new_multiplier =3D (hires && hidpp->hires_wheel_multiplier > 0)
> +			? hidpp->hires_wheel_multiplier : 1;
> +		hidpp->vertical_wheel_counter.wheel_multiplier =3D new_multiplier;

Is there a potential data race on wheel_multiplier and
hires_wheel_multiplier here?

Looking at hi_res_scroll_enable(), it writes to these variables from
process context via the workqueue. Concurrently, this event handler reads
and writes to them from the HID raw event delivery path in interrupt contex=
t.
There does not appear to be any synchronization protecting these shared
variables across contexts.

> +		return 1;
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518192649.2456=
91-1-saurla@saurla.com?part=3D1
