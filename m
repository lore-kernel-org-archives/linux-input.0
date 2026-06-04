Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54E2D63F8
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565960; cv=none; b=GY6o2w/6pqxzICr8qhiY+LvBz0dfuTaS2P9nlQaWZkME0whYKbVmvl682o17fj6tW6qT4e2uDCFQIpY100DoNuQK51+dSI6PJTC1b1rPbklycAzz/FE/H7RRoaSGMD5DkuxFAu274nFtVOGNbfHth5QzQ2/8eJwQySxZMChFfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565960; c=relaxed/simple;
	bh=gHHuAXTeIMsSjiOQefn0/trNbeiL25p955Qx95zMcSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KOWfkkF/D4QKbycfk/2wNQDVbXGBvqdgK1ijohVxlNR+PS8URqsIX2JzRXXz/hJNvyioR9E+P/AOQgp1nhyI1H5p2J7Pk+B3zkwB9SILIPwkLTQqJ8lcs1YfYKI001Qy5aUqkOfPF+edLT4A2+XnRdvrYef+9beUb/nKwCzVpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkkVfV6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkkVfV6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05231F00893;
	Thu,  4 Jun 2026 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780565959;
	bh=gwrmx/SSw1OeBveN4TUFlJAPrQtalSsEyZojy0GUSrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkkVfV6UVL6pGGQPx2h4EZ+eQCz25rRISeAcjmrVY0gTK5J7yuCorzoR0q0hxVJ4y
	 R/hhOswAkalla1adQlP5JB1McjHCzw1liinaakwmM7uGDBwEqLq5VTgDUHOszxAHfh
	 Mo8lWK8ymfZUSrdSi/IKzLZAEeqwaHWfEuONgzXBBTf7QB+gJgd8TJETdIr+22RMbe
	 Lha1kSX0HektDYKdU6jKgswAwrz9Bl5A6XNX4YI5dMzwiZrBVMCXHiZfchPvrxeQ9a
	 94xQecCBZ1vV/foPktcxtNe2MiZ9SffMtP8FS66Td6tGjp4hXSg2HmgLb9GAH0ZgG7
	 RrIvQenXvNCDg==
From: sashiko-bot@kernel.org
Subject: Re: [linux-5.15.y 2/3] HID: pass the buffer size to
 hid_report_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260604092659.3953067-2-lee@kernel.org>
References: <20260604092659.3953067-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 09:39:18 +0000
Message-Id: <20260604093918.C05231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The patch fails to resolve the short report rejection regression f=
or most HID devices because `hid_input_report()` unconditionally sets `bufs=
ize =3D size`.
- [High] Incorrect `bufsize` argument in `wacom_wac_queue_flush` defeats th=
e mitigation for short reports.
- [Low] Format string mismatch for `size_t` variable `bsize` causes compile=
r warnings and potential build failures on 32-bit platforms.
--

commit 410a0d731bb14f8c3685faa86ca65503898cc6f0
Author: Benjamin Tissoires <bentiss@kernel.org>

HID: pass the buffer size to hid_report_raw_event

This commit passes the buffer size along with the data size to
hid_report_raw_event() to make a better decision on whether to reject the
buffer or safely memset it to 0 and pass it to the rest of the stack.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 4fb573ee31b2c..a8d4673c7b8e1 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1775,8 +1775,8 @@ int __hid_request(struct hid_device *hid, struct hi=
d_report *report,
>  }
>  EXPORT_SYMBOL_GPL(__hid_request);
> =20
> -int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32=
 size,
> -		int interrupt)
> +int hid_report_raw_event(struct hid_device *hid, int type, u8 *data,
> +			 size_t bufsize, u32 size, int interrupt)
>  {
>  	struct hid_report_enum *report_enum =3D hid->report_enum + type;
>  	struct hid_report *report;
> @@ -1784,16 +1784,24 @@ int hid_report_raw_event(struct hid_device *hid, =
int type, u8 *data, u32 size,
>  	int max_buffer_size =3D HID_MAX_BUFFER_SIZE;
>  	unsigned int a;
>  	u32 rsize, csize =3D size;
> +	size_t bsize =3D bufsize;
>  	u8 *cdata =3D data;
>  	int ret =3D 0;
> =20
>  	report =3D hid_get_report(report_enum, data);
>  	if (!report)
> -		goto out;
> +		return 0;
> +
> +	if (unlikely(bsize < csize)) {
> +		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d v=
s %ld)\n",
> +				     report->id, csize, bsize);

[Severity: Low]
Does this cause a compiler warning on 32-bit platforms? bsize is a size_t,
but is being printed with the %ld format specifier, which might trigger a
-Wformat warning since size_t is usually an unsigned int on those
architectures. Should this use %zu instead?

> +		return -EINVAL;
> +	}
> =20
>  	if (report_enum->numbered) {
>  		cdata++;
>  		csize--;
> +		bsize--;
>  	}
> =20
>  	rsize =3D hid_compute_report_size(report);
> @@ -1806,9 +1814,15 @@ int hid_report_raw_event(struct hid_device *hid, i=
nt type, u8 *data, u32 size,
>  	else if (rsize > max_buffer_size)
>  		rsize =3D max_buffer_size;
> =20
> +	if (bsize < rsize) {
> +		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d =
vs %ld)\n",
> +				     report->id, rsize, bsize);

[Severity: Low]
This isn't a bug, but there's another instance here where bsize is printed
with %ld instead of %zu.

> +		return -EINVAL;
> +	}
> +
>  	if (csize < rsize) {
>  		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
> -				csize, rsize);
> +			csize, rsize);
>  		memset(cdata + csize, 0, rsize - csize);
>  	}

[ ... ]

> @@ -1851,6 +1865,7 @@ int hid_input_report(struct hid_device *hid, int ty=
pe, u8 *data, u32 size, int i
>  	struct hid_report_enum *report_enum;
>  	struct hid_driver *hdrv;
>  	struct hid_report *report;
> +	size_t bufsize =3D size;
>  	int ret =3D 0;
> =20
>  	if (!hid)
> @@ -1889,7 +1904,7 @@ int hid_input_report(struct hid_device *hid, int ty=
pe, u8 *data, u32 size, int i
>  			goto unlock;
>  	}
> =20
> -	ret =3D hid_report_raw_event(hid, type, data, size, interrupt);
> +	ret =3D hid_report_raw_event(hid, type, data, bufsize, size, interrupt);

[Severity: High]
Does this defeat the short report mitigation for most devices?

Since hid_input_report() is the primary entry point for HID transport
drivers and lacks a bufsize argument, it sets bufsize equal to size (the
payload length). When a short report is received, this guarantees that
bsize < rsize evaluates to true in hid_report_raw_event().

Will this incorrectly drop valid short reports for most HID devices by
triggering the -EINVAL rejection path?

> =20
>  unlock:
>  	up(&hid->driver_input_lock);

[ ... ]

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index c8a8daedff3d0..1b130ac45acad 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -79,7 +79,7 @@ static void wacom_wac_queue_flush(struct hid_device *hd=
ev,
>  		int err;
> =20
>  		size =3D kfifo_out(fifo, buf, sizeof(buf));
> -		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, false);
> +		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, =
false);

[Severity: High]
Should the bufsize argument here be sizeof(buf) instead of size?

Because bufsize is being passed as the short data length rather than the
true allocated buffer size, hid_report_raw_event() will evaluate
bsize < rsize as true and incorrectly reject valid short wacom reports
with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604092659.3953=
067-2-lee@kernel.org?part=3D1
