Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB953B7B8E
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914624; cv=none; b=ghNISEvrM1QqNhKBtxTmmtrQwy7xQ3j6DSWnWK0koljhpAFuJ4N49OMsCriJTW6jzu10L1QCXbFq9/76hPTUFcMp7Wej3OhAqxg4l0alRIUNAXpTHDkoEPxrX4T9Wroqzt1KkIQl1bRfAmcYUy4/PBrsQsduUGjL4A3xniZWqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914624; c=relaxed/simple;
	bh=gdBgLZjEDaZ9A/8soNi2cgYvrCLvrT5HCwnHJkQl154=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dGyGpoZYHoOokcyU7pEbRE4xZBRPyEenznl5ISfR7yqqg51Yp4J39GiyEWqkhG/o8Z/CEe93UsqEIrwn03ZC9yCF8qtE7BcxTnT+YrBsKLX+UEtyNQ+npuyr64Y5s6c1NfRLmRVej0mSlJbxP4VRfWp0w6uhNg5nfcxFzt/zyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEp/vslF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEp/vslF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C41F00893;
	Mon,  8 Jun 2026 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780914622;
	bh=0RRfszK7QYllV4TRfOh7nzgPR7iz4kgqR6aggooB+tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEp/vslFlGg2tT6o8OuzP1qI0nmVK/ro/SpV1/UCi/py/KvXNvcB20KhJatDMsfIh
	 MnFKFWwV+oDoDxyAUUl5hEnmhEPCcSm5SkJCfzYBJY3speaPgAUIbw15wy0hZP/Bgj
	 S/vM2DZF7rXKaHen/FXWqEKMOHp1OyB1sOcdRVV0DsHqLrFd2e3VUkw03ISHjeNtjr
	 nU32+q0s+cEGcX1kLuVTXOtFL1A5wKr98Jz6xGZbh8yf+jGr3hJNtWvrSGrn4ruJ/k
	 2n/wFbS7ZzhX+RSu8Y/46igcMCa6qHHKrhTbYxxY5t2r0a4u1w0oqZsF32q24VK4f7
	 c5wyGRxJDBOEQ==
From: sashiko-bot@kernel.org
Subject: Re: [linux-5.10.y 2/3] HID: pass the buffer size to
 hid_report_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260608100236.2781796-2-lee@kernel.org>
References: <20260608100236.2781796-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 10:30:21 +0000
Message-Id: <20260608103022.1C6C41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch introduces `bufsize` to `hid_report_raw_event` to allow =
safe zero-padding of short reports. However, it passes `size` (the received=
 data length) instead of the actual buffer capacity in key call sites. Most=
 notably, in `wacom_wac_queue_flush()`, the buffer has a fixed capacity (`u=
8 buf[WACOM_PKGLEN_MAX]`), but `size` is incorrectly passed as `bufsize`. I=
n `hid_input_report()`, `bufsize` is hardcoded to `size`. This guarantees t=
hat `bsize =3D=3D csize`, meaning any short report (`csize < rsize`) will u=
nconditionally trigger the `if (bsize < rsize)` error check and be dropped =
with `-EINVAL`. The intended zero-padding mitigation (`memset`) is therefor=
e completely unreachable for these paths.
- [Low] Format specifier mismatch in error logs: `bsize` is of type `size_t=
` but is printed using `%ld` instead of `%zu`. Additionally, unsigned 32-bi=
t variables (`report->id`, `csize`, `rsize`) are printed using the signed `=
%d` specifier instead of `%u`.
--

commit acf01e17656800b6ab94002473e3b03a8259b323
Author: Benjamin Tissoires <bentiss@kernel.org>

HID: pass the buffer size to hid_report_raw_event

This commit updates hid_report_raw_event to accept both the buffer size and
the data size. This allows the function to make a better decision about
whether to reject a buffer to prevent an overflow, or to safely pad it with
zeroes.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index aa9ae6ccb28a8..c73f4ac16fdf2 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
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
This isn't a bug, but could the format specifiers cause compiler warnings on
32-bit architectures? bsize is a size_t and csize and report->id are unsign=
ed,
so should they use %zu and %u instead of %ld and %d?

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
Similarly here, should this use %u for report->id and rsize, and %zu for
bsize instead of %d and %ld?

> +		return -EINVAL;
> +	}

[Severity: High]
If callers pass the incoming data length as both the size and bufsize
arguments, does this mean bsize will equal csize?

If bsize =3D=3D csize, and we receive a short report where csize < rsize,
wouldn't the bsize < rsize check just above this evaluate to true and return
-EINVAL? Does this make the memset padding logic unreachable for those path=
s?

> +
>  	if (csize < rsize) {
>  		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
> -				csize, rsize);
> +			csize, rsize);
>  		memset(cdata + csize, 0, rsize - csize);
>  	}
> =20
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
Does setting bufsize directly to size here defeat the padding mitigation?

This hardcodes bufsize to the received payload length, which propagates the
drop behavior to all transport drivers relying on hid_input_report().

[ ... ]

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index abbfb53bb7dc9..09b513812fff1 100644
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
Could we pass sizeof(buf) here instead of size?

Since buf has a fixed capacity of WACOM_PKGLEN_MAX, passing size for
bufsize prevents the core from safely padding short reports and will
instead cause them to be dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608100236.2781=
796-2-lee@kernel.org?part=3D1
