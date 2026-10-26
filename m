Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973179;
	b=PZeA7zaJUX6B2zwu8pYMPD+jJwvJPs+K4LLmwgf884pHkEZXvfEnyEP8L77635Itxf4V
	 tzMtZ9sikUb3jssHbJnl+zw3Wpo5Z9G/IpUQnBOIUFbYmGYadOnLmvV/QZuZXQZ0aZhMm
	 STChtFuDfBu6lJmGriPE+JVBBIHKYQHf/FaodYQoGpsCIXYer9QcON1XYxab4pnXn4cSU
	 iIFYDUoOpC9pII7xYKcITjnPz4u452/5pp59XOQfIXUWrWhfB0Pb1mThXWTTTIK+Pm6xo
	 uVPnfR+99IdChGdv0kV8VY027wLnxNcXjk9e1e/y/8OsGe6AI+hT5ZyVa7l/2O8r48A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973179;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D7wI+CKbUnVG9D+j9/AyhRpqUYzvtWxRXZuP4LAQvF4=;
	b=wcdqzXC7U+3jVMfkZVTDirY65Jqhn+QiSbL10uMo88v3IhV3AOh5rYuB1JeEPxRZ1ULD
	 dBUsPdRHDJj1+5N+XqaIOwrK4B/+2D6Ik5jEx2BkhyYFWX7zlENzAiiLxpBHHX47t7/k4
	 0oMLnP4lvnf6baovE76yn/sHLpKD8239Dyq1NNg8HzViqDiu7YW5O9Q12X/YOXoRViOii
	 t+o9gmmE7JFL2KITiz1CwCJkg3lLUSZGVp5C5gO4Ker/Rz3kPM31Q0guRSqB19wu6et6b
	 iwnFG9F44Ym68a5/ZQdMPWHkUgYKueO9SSdXXHZ22KgKMjhgrSkeXWjOd4kYoWeYzRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwxuTIjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75891606A31D
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwxuTIjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CB81F031E0;
	Mon, 26 Oct 2026 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973179;
	bh=D7wI+CKbUnVG9D+j9/AyhRpqUYzvtWxRXZuP4LAQvF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LwxuTIjrCnT9LMzAN/7YZrkXjUv27CBaP86ojVk7Z4BLBGvtJlqIWgb/+UmzAr8/X
	 nhORG1EdSc7UQwnrja16ihde0vk6YyaYcU/aONuPoPsQaBWKEtC6Dl2Eew4fKek9PI
	 Gwdp21ji2A7fDlAHsqvDEdeegGN4YLovzkL7GVCMXSF1dBrEMdTueTNjgPsZ9xj7I3
	 wgv99nBUY/I4VxolGnaf1IOxBtWtRNJtcVzOT24ZnzKiT/3OUi5TlAQ14dQ2sgKJMf
	 QVN8Wo+JGRGXvOrOFUsteDpkBnMzIvHGvbJ61um58GZvOcJe0e36xhUvvEk8A4n8Kt
	 9xsJgzBLyyelA==
Message-ID: <sashiko-outbox-184550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/18] HID: asus: size feature reports from the HID
 report descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-13-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-13-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:06:18 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: asus: slab out-of-bounds read in asus_kbd_get_functions()
--

commit c08fc8186d8cfc7d33787c731647d924103580c9
Author: Denis Benato <benato.denis96@gmail.com>

HID: asus: size feature reports from the HID report descriptor

This commit derives feature report transfer lengths dynamically from the
device's HID report descriptor instead of using hardcoded sizes. It adds
asus_report_len() and asus_kbd_get_report(), updates asus_kbd_set_report() =
to
zero-pad short payloads to the report length, and converts callers to size
their buffers per report.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index ea27495c3df66..fe2a326ccd861 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -5426,7 +5521,7 @@ static int asus_kbd_get_functions(struct hid_device=
 *hdev,
>  				  u8 report_id)
>  {
>  	const u8 buf[] =3D { report_id, 0x05, 0x20, 0x31, 0x00, 0x08 };
> -	u8 *readbuf;
> +	size_t hw_len =3D asus_report_len(hdev, report_id);
>  	int ret;
> =20
>  	ret =3D asus_kbd_set_report(hdev, buf, sizeof(buf));
> @@ -5435,23 +5530,22 @@ static int asus_kbd_get_functions(struct hid_devi=
ce *hdev,
>  		return ret;
>  	}
> =20
> -	readbuf =3D kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);
> +	if (!hw_len)
> +		return -EINVAL;
> +
> +	u8 *readbuf __free(kfree) =3D kzalloc(hw_len, GFP_KERNEL);
>  	if (!readbuf)
>  		return -ENOMEM;
> =20
> -	ret =3D hid_hw_raw_request(hdev, report_id, readbuf,
> -				 FEATURE_KBD_REPORT_SIZE, HID_FEATURE_REPORT,
> -				 HID_REQ_GET_REPORT);
> +	ret =3D asus_kbd_get_report(hdev, report_id, readbuf, hw_len);
>  	if (ret < 0) {
>  		hid_err(hdev, "Asus failed to request functions: %d\n", ret);
> -		kfree(readbuf);
>  		return ret;
>  	}
> =20
>  	*kbd_func =3D readbuf[6];

[Severity: High]
Can this read past the end of readbuf[] when a device descriptor declares a
6-byte feature report for report_id?

Previously, asus_kbd_get_functions() in drivers/hid/hid-asus.c allocated
readbuf with FEATURE_KBD_REPORT_SIZE (64 bytes). With this change, readbuf =
is
allocated with size hw_len.

In asus_kbd_get_functions(), sizeof(buf) is 6, so asus_kbd_set_report()
accepts hw_len =3D=3D 6 via:

    if (!hw_len || buf_size > hw_len)
        return -EINVAL;

asus_kbd_get_functions() then only checks !hw_len before allocating readbuf=
 of
6 bytes and reading readbuf[6] (the 7th byte), resulting in a 1-byte slab
out-of-bounds read during probe via
asus_probe()->asus_kbd_register_leds()->asus_kbd_get_functions().

Should asus_kbd_get_functions() check that hw_len is at least 7 (or
hw_len <=3D 6) before allocating readbuf and indexing readbuf[6]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D12
