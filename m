Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEA334C05;
	Mon,  1 Jun 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303808; cv=none; b=AWBFK9kqMlbmGULY9ypdaQLrp63ozwPnASGwcezjYvtIrQ9vsao+EbabUtyf/+i/cR5FU8PF7E/CNMLGJ9XSsaT/DFC7wcO8NkcHww22Zgc8NWR8Ek4kG92M9lictokloRtBgpHTvJgxtguKlo3hVOFu/gUNuEdPe2dEGK+pGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303808; c=relaxed/simple;
	bh=wJewuAA0yHOMFk005BDaHEpaoQdFvaB9GW87xyazg2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=psuJ5kg5tq/9V2zKFGb7li4kzWytVoWeGkr+rpnMxYwZbYClfBAolgScfdpdCIKUTC9wkf6cJZSuixt8sJX1BTgKFr1HRHyb26vfoSWIIIQkU0reTpElIBjS/qcxcCYZCPehGH9TE2n3JHmhT9GbjhbBnwuKj2O640ODlL8H6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM3xh1R7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM3xh1R7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F18B1F00893;
	Mon,  1 Jun 2026 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780303806;
	bh=n1qeLdos2mO/Zv6Z2EbKt8HWwgO9dImP+jeHsNaMsr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fM3xh1R7RsF81+mrdxb9Gcpco4PZ6A+W0O3kp/Bwp/WKVVwXM1fLxGXa/1/xuNCKV
	 BBdPF99oEKxtBD5JMwHT4nNVNRsAFQ2SNwuFNloCrYoWFuLAB3xE7sV0tk3lYlyR44
	 +VLyMWzLq68BJRhywVYDhK6945MNescYCPbWhEZeZ9q8FW0S5IvGezlYNsgARVsMRv
	 49B/g73c9pGT26HMRLx6oDZUg98kGhrDwrFvwFa0NuDyiRxYkxy3jqaz3bm3t8IWM3
	 zFK2L81QlhT0AxPEta5jNo3dFzdkBO7ELLlAZ41+6bWAdGwGm/2dWD5DkoBSpC9IR5
	 /dE8xUdsds34Q==
From: sashiko-bot@kernel.org
Subject: Re: [linux-6.12.y 2/4] HID: pass the buffer size to
 hid_report_raw_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260601083642.908433-2-lee@kernel.org>
References: <20260601083642.908433-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 08:50:06 +0000
Message-Id: <20260601085006.6F18B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch fails to resolve the short-report regression for standar=
d transport drivers because APIs do not propagate the real buffer size, byp=
assing the newly introduced padding logic.
- [Low] Format string mismatch for `size_t` variable.

Pre-existing issues:
- [Critical] Heap buffer overflow in `dispatch_hid_bpf_device_event` when p=
rocessing incoming events.
- [High] A BPF program calling the `bpf_hid_input_report` helper causes unh=
andled re-entrancy that silently corrupts the shared per-device BPF data bu=
ffer.
--

commit e46292c21905a8e10fe2c446a47f211679b0d355
Author: Benjamin Tissoires <bentiss@kernel.org>

HID: pass the buffer size to hid_report_raw_event

This commit attempts to fix an OOB mitigation by passing both the buffer
capacity and the actual data size to hid_report_raw_event(). The goal is
to allow safe zero-padding of short reports if the backing buffer is large
enough, rather than unconditionally rejecting them.

[ Upstream commit 2c85c61d1332e1e16f020d76951baf167dcb6f7a ]
[Lee: Backported to linux-6.12.y and beyond]

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 284861c166d9c..b711d83dfde1d 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -24,7 +24,8 @@ EXPORT_SYMBOL(hid_ops);
> =20
>  u8 *
>  dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_t=
ype type, u8 *data,
> -			      u32 *size, int interrupt, u64 source, bool from_bpf)
> +			      size_t *buf_size, u32 *size, int interrupt, u64 source,
> +			      bool from_bpf)
>  {

[Severity: Critical]
This is a pre-existing issue, but does dispatch_hid_bpf_device_event() lack
bounds checking on the event size?

When a HID event arrives, the function unconditionally copies the data into=
 the
BPF context buffer:

    memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
    memcpy(ctx_kern.data, data, *size);

If a malicious or compromised HID device (or userspace via uhid) sends an
event where *size is larger than hdev->bpf.allocated_data, could this cause=
 a
heap buffer overflow?

[Severity: High]
This is also a pre-existing issue, but does this code suffer from unhandled
re-entrancy corrupting shared state?

If a BPF program injects an input report by calling the bpf_hid_input_repor=
t()
helper, execution re-enters dispatch_hid_bpf_device_event(). The inner call
will unconditionally execute the memset() and memcpy() block shown above on
the exact same shared hdev->bpf.device_data buffer.

If the injected report uses ctx->data as its buffer, the memset wipes the d=
ata
before it can be copied. Will this silently corrupt the execution state of =
the
outer BPF program upon return?

[ ... ]
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 294a25330ed03..ceff91722c3c8 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
[ ... ]
> @@ -2028,9 +2036,15 @@ int hid_report_raw_event(struct hid_device *hid, e=
num hid_report_type type, u8 *
>  	else if (rsize > max_buffer_size)
>  		rsize =3D max_buffer_size;
> =20
> +	if (bsize < rsize) {
> +		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d =
vs %ld)\n",
> +				     report->id, rsize, bsize);

[Severity: Low]
Can we use the %zu format specifier instead of %ld for bsize?

bsize is a size_t, which might trigger a compiler warning on 32-bit platfor=
ms
where size_t is unsigned int.

> +		return -EINVAL;
> +	}
> +
[ ... ]
> @@ -2135,7 +2150,7 @@ static int __hid_input_report(struct hid_device *hi=
d, enum hid_report_type type,
>  int hid_input_report(struct hid_device *hid, enum hid_report_type type, =
u8 *data, u32 size,
>  		     int interrupt)
>  {
> -	return __hid_input_report(hid, type, data, size, interrupt, 0,
> +	return __hid_input_report(hid, type, data, size, size, interrupt, 0,

[Severity: High]
Does this leave the short-report regression unfixed for standard transport
drivers?

By blindly passing the received data size as both the size and bufsize capa=
city
arguments to __hid_input_report(), bsize will always equal size.

If the report is short (size < rsize), the new bsize < rsize condition in
hid_report_raw_event() evaluates to true and the event is dropped, bypassing
the padding logic completely.

>  				  false, /* from_bpf */
>  				  false /* lock_already_taken */);
>  }
[ ... ]
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 1b1112772777c..ffcf65dcf7134 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hd=
ev,
>  		int err;
> =20
>  		size =3D kfifo_out(fifo, buf, sizeof(buf));
> -		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, false);
> +		err =3D hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, =
false);

[Severity: High]
Does passing size instead of sizeof(buf) for the buffer capacity prevent sa=
fe
padding for wacom devices?

Similar to the issue above, because bsize becomes equal to size, any short
report will fail the bsize < rsize check in hid_report_raw_event() and be
rejected instead of zeroes being safely padded to the end of the buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601083642.9084=
33-2-lee@kernel.org?part=3D1
