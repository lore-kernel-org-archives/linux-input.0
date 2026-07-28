Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08630E835
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207996; cv=none; b=YP98tczF1DHtZy2Q+0aDGRNBZu00h11WsoPVSotE+TO3cFo22btB3E85KWT2XfIBLxkkixGis66mm5i0gNXclMmSrYd0wJYzCSwmbiVvbU306PwJ03CaNZrgtbrOIztW9l6XDMaJUOhtSgfnQCowfv/+pQKaNdGlJYV2Z3fb8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207996; c=relaxed/simple;
	bh=dNR0SuGGfp1B2LwwpYKJaq5AKm5wcndtMt99kviJXKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QdLnqqpqF2XCor6QqWhyMJn5ANy1J6psLa/+B8+jsCtmBnPUybIimREojUHOKftzcf+N+sfsycUok1XoBGPi7Qr4huEMueQDGQSKWRsWBam9zpImQbHo5RGxZJfFDse41z+lKnTTrXuNm7jN3fIU3qswiGPhYZidmmzVP9G6SfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxz7u08c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxz7u08c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C51F000E9;
	Tue, 28 Jul 2026 03:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785207995;
	bh=YCUxzNMHu8ibvjMHv1/5wMo2KiXbEdj7suU7OLghw2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hxz7u08cyzJ5e2I/5+ekLPcS+JpPTaQX6ovOUCeqLX2cEt6FA7C3kJPB6bXl7ds45
	 9ATHxRqrDGm6MH4Si/Bg7e7bopNjw4jQmnP5RqPVUKoWu8nM8VyUMd6MWtwxuYUqgg
	 DdE4CeD/MkeKz5oHgnWzIOZWEgZzJUMmwFyY2ldFX29rLXDrWtXgjPd1YM+M6RDAkr
	 VBVP+PAH5gVniQJJ+57/5zPwV8B7UpsrKKgQzf9XbNtZEo8xCqkRnYJ1teklQ26L9o
	 4KtyvnZHR6QQmxCj9d+MXk/VDoMBsq2Krk8QUKUwxLd5XOeVXSxlljtwczWdH96o7C
	 E4setWx/AjIaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: picolcd: Use min() macro to simplify code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260728025750.48249-4-chenchangcheng@kylinos.cn>
References: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
 <20260728025750.48249-4-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:06:34 +0000
Message-Id: <20260728030635.1C5C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read in `picolcd_debug_eeprom_read` leaking kernel h=
eap memory to userspace.
--

--- Patch [3]: [PATCH 3/4] HID: picolcd: Use min() macro to simplify code -=
--
commit 1474980d788a9366218f25c39b115f1aca750b68
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

HID: picolcd: Use min() macro to simplify code

This commit replaces an open-coded minimum check with the standard min()
macro in hid-picolcd_debugfs.c. It simplifies the logic for limiting the
read size for EEPROM data.

> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_=
debugfs.c
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c
> @@ -86,7 +86,7 @@ static ssize_t picolcd_debug_eeprom_read(struct file *f=
, char __user *u,
>  	/* prepare buffer with info about what we want to read (addr & len) */
>  	raw_data[0] =3D *off & 0xff;
>  	raw_data[1] =3D (*off >> 8) & 0xff;
> -	raw_data[2] =3D s < 20 ? s : 20;
> +	raw_data[2] =3D min(s, 20);

[ ... ]

> 	if (resp->in_report && resp->in_report->id =3D=3D REPORT_EE_DATA) {
> 		/* successful read :) */
> 		ret =3D resp->raw_data[2];
> 		if (ret > s)
> 			ret =3D s;
> 		if (copy_to_user(u, resp->raw_data+3, ret))

[Severity: High]
This is a pre-existing issue, but while reviewing this function, can a
malicious or buggy USB device cause an out-of-bounds read here?

If a user reads from the eeprom file with a large size, for example=20
s =3D 256, and a malicious device responds with a REPORT_EE_DATA containing
a large embedded length field in resp->raw_data[2] up to 255, ret will take
that device-controlled value.

Since ret (255) would not be greater than s (256), this copy_to_user()
call could attempt to copy up to 255 bytes.=20

Given that resp->raw_data is a fixed 64-byte array, does this allow reading
past the end of the struct picolcd_pending heap allocation and leaking
adjacent kernel heap memory to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728025750.4824=
9-1-chenchangcheng@kylinos.cn?part=3D3
