Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F0455631
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359923; cv=none; b=hPQidzhm3Ceg07FOISAsdns7U1WMjtkCCIcDQ4YV/BT63+5zhiz4fbotgWzfU/c/TYSeG4Ab5ABq6umuVLFUFDwzwKwmtIOeKCKa3uUVxbpz2B1ZoR34l9hc0r8t0wD7lGrdggp+ZALve3MC8O25Up3k831taEJBdqu38zdyEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359923; c=relaxed/simple;
	bh=nR/UqZIVkClgG5xPLBRLa9t0lmUSTCTn2ry30l3+m6g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RyAryAUVt96DTHQDsjY6EXRpFAUbBave7INDbC9WtRU5LLw2Og/asThR/tDTd35gFatNdCSTD49xWRgKvgC73ifC3qrq0Bfaaj3NP7DS5ti/XADtSgbabCxcjcbMbXkYIv9ef6RUyEDRbh7ZTo5l0Dqx6lDo/wBWH9PlKV99Z2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFM48MKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFM48MKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7A1F000C4;
	Sun, 18 Oct 2026 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792359922;
	bh=ETDOQemPd6ssJwsavPtLmVe+eu6xZx3ohkYSYvHaTKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFM48MKLYNk5/yBxG5x6T5ba6/VwpcJGEbmYSHhAoq/J3RC4XYKPEbzhLAmjBFMRb
	 vp72YS0K7LgTF37fnklZZ/x2IdT9b++DBcLZOQ/epcqZQWJ8r9jofhC16U+FIdzobs
	 wCFeExdWvfUzBcgCngha7jXAQR5IT0WoJNc1eUo95Slqs01ZdeVWFPVTAGi6JWLLKL
	 p+oyAKxA43iIjdET+BLHKqh0JtoMl7goSsQcWOJ78u/8XLcZEkeNDvnEG/5kUTaFx4
	 VaOzMUEAQJ435xFvMUw6AZ9HMi44PMYDQlfkbF6sYX2IILfvZ7Hjd5Cq4iexF+Utgf
	 jcGv4uWDsMjUA==
Message-ID: <sashiko-outbox-176412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] HID: alps: validate report size in raw_event
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018213754.1951187-3-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
 <20261018213754.1951187-3-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 21:45:22 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: alps: off-by-two report size check in u1_raw_event()
--

commit 5284d6e143901f92388237eea63f898c2ce83a7f
Author: Tristan Madani <tristan@talencesecurity.com>

HID: alps: validate report size in raw_event callbacks

This commit adds report buffer size validation to t4_raw_event() and
u1_raw_event() before accessing report fields.

> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index 0556cb5645ebb..dee7d44d6f912 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c
[ ... ]
> @@ -370,6 +378,8 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *d=
ata, int size)
>  		break;
>  	case U1_ABSOLUTE_REPORT_ID:
>  	case U1_ABSOLUTE_REPORT_ID_SECD:
> +		if (size < hdata->max_fingers * 5 + 5)
> +			return 0;
>  		for (i =3D 0; i < hdata->max_fingers; i++) {
>  			u8 *contact =3D &data[i * 5];

[Severity: Medium]
Does this check in u1_raw_event() reject valid 28-byte 5-finger touchpad
reports when receiving U1_ABSOLUTE_REPORT_ID or U1_ABSOLUTE_REPORT_ID_SECD?

Inside the loop, contact is set to &data[i * 5] and the code reads:

	for (i =3D 0; i < hdata->max_fingers; i++) {
		u8 *contact =3D &data[i * 5];

		x =3D get_unaligned_le16(contact + 3);
		y =3D get_unaligned_le16(contact + 5);
		z =3D contact[7] & 0x7F;

The report has a 3-byte header (data[0] report ID, data[1] buttons, data[2]
finger count) followed by hdata->max_fingers 5-byte contact entries starting
at data[3]. On the final iteration (i =3D hdata->max_fingers - 1), the last
byte accessed is contact[7], which is at index:

	(hdata->max_fingers - 1) * 5 + 7 =3D hdata->max_fingers * 5 + 2

For a 5-finger touchpad (hdata->max_fingers =3D=3D 5), the last byte is dat=
a[27]
(matching the Packet Format table in Documentation/hid/hid-alps.rst), so the
report is 28 bytes long. Requiring hdata->max_fingers * 5 + 5 demands 30
bytes. Should the bound be hdata->max_fingers * 5 + 3 instead?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018213754.1951=
187-1-tristmd@gmail.com?part=3D2
