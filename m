Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6502C11E6
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 01:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239682; cv=none; b=t+f9tmKCx3MRMgxR/ZhTsMW8ocMGBsewpFfkIuC3ioyvTZW5uT/oHw88MtRzYOUFxBherttzeIXETEjuf8pIK1gJiAjkliIezpBXqdubTDN33DcG5AUHBocf/rE3BOvk6QUaz33T+/FoyXDzmP/WgFY5qwuXpX6xhtwPejQUSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239682; c=relaxed/simple;
	bh=j27X20+k1+3zqPtxgjlGPNDFQo375VSvArldSCCa5kI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f7kfrGvH6+CTmWLhgJk3TXMgvLHCYEfelBBpYYZ4V8IO0K7RcobpAgCv3/FLdK2PZyNnCh6hEdxFFHhZkceo17Ysl4q1ED3EbjUqPQPbSGnir7wQaHyG81R18GOpP3Wvw/EjDJC7CtAR71psRy1W9SuddpInZJPrd2KRWW0dFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm6puuCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm6puuCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C901F000E9;
	Wed, 20 May 2026 01:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779239680;
	bh=ln8AzMvIkgUain67WERU5auckfULM5qlC/1wXqT92RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lm6puuCWnUVtqb++TNrRxnfTSj5MFSt9JLzGu4/nGZUrHTVY0FFyMZNP6Gey6GZ5W
	 UqE3bYP0sn4fzv1OEMJPiB3M856qs2Wt1dSqfeYcNcwXzzH2h9T//8RsM1MOqcdro6
	 c+Y0ea74MzykKvhhBfycrXDxA66akgUZu58hZfsncQTEqFg+vpPUE1OURyj3Gbb3rq
	 RQ2CZOKS2LsEDWiRsaV9zUYj/OyRb5fC3XKx7lfledZRuostH49o/foHxP+jHysWVM
	 ZNsw4NMUrbRE/0iwcIvRaMuT39S43VsqIfBYJE7eih1Lw/zxTM3MkFXfw2QRh1ywif
	 +NkyqAIFQgDaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] iio: pressure: HID: hid-sensor-press: Refactor
 channel initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TmF0w6FsaWEgU2FsdmlubyBBbmRyw6k=?= <natalia.andre@ime.usp.br>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260519234752.23911-7-natalia.andre@ime.usp.br>
References: <20260519234752.23911-7-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 01:14:40 +0000
Message-Id: <20260520011440.C8C901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit introduces a compilation error by using the incorrect fi=
eld name `.format` instead of `.sign` when initializing `struct iio_scan_ty=
pe`.
--

commit 8d524ba8c95e026dee3af23dc0139fc49731c194
Author: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>

iio: pressure: HID: hid-sensor-press: Refactor channel initialization

This commit replaces the local press_adjust_channel_bit_mask() function wit=
h a
compound literal for scan_type initialization to improve code readability.

> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressu=
re/hid-sensor-press.c
> index 5f1d6abda3e40..a039b99d9851d 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c

[ ... ]

> @@ -225,8 +215,11 @@ static int press_parse_report(struct platform_device=
 *pdev,
>  			&st->press_attr);
>  	if (ret < 0)
>  		return ret;
> -	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
> -					st->press_attr.size);
> +	channels[CHANNEL_SCAN_INDEX_PRESSURE].scan_type =3D (struct iio_scan_ty=
pe) {
> +		.format =3D 's',

[Severity: Low]
Does this introduce a build failure?

Looking at struct iio_scan_type defined in include/linux/iio/iio.h, the
member used to indicate the sign of the sample is named sign, rather than
format. The original code being removed correctly assigned to scan_type.sig=
n.

> +		.realbits =3D BYTES_TO_BITS(st->press_attr.size),
> +		.storagebits =3D BITS_PER_TYPE(u32),
> +	};
> =20
>  	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
>  			st->press_attr.report_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519234752.2391=
1-1-natalia.andre@ime.usp.br?part=3D6
