Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E02D94B5
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527036; cv=none; b=XMJKS6VLCL12R5nm9G2vYxnUGZjRpbbtTW73Ixg7T2n174ZgAtRC+B0LYLIf9WIx43wUtoLSYUyNGzhcfrm4moVvMZDcJSYBorj5ZEEJwT8v/AyarjtwJEcgL5rMQiisnZ2pUtFg7ZBCi5xBqSAsgng8UCv9OTdNQhmwY8R0HQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527036; c=relaxed/simple;
	bh=uVVGYY2tf+HpBqiu5cQopOfw2Nlgybc2hHDqXkMvkYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ofpYps4WMVsBjicJ+irYwgwYE40uCZdG8bhfbLIl7hvyYjyvOE9ViW+DDAevPUobNWUlbg6LJ/6l69yVl7BEKP1aT0BJ82hPhpvGIhHhu+EDiUZtWZIKg01EnJxLEzsLC0tGc43gGZKRftTxkTj8k0kmRkWOLoJciQr6MpA++ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aME/qjb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aME/qjb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79471F00A3D;
	Fri,  4 Sep 2026 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527034;
	bh=RId/i8FOGb713RgJQ6i59ph5f7vRw4bd67Nm0YBMYjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aME/qjb7eFXiIvd//b6HwzlivHJXNgB6NhMLebugdbnNlWxaHtLi9azenUQtHy/Pf
	 8OYmfvISdDxtqjei0hgx2AcU+iZ/o9IdZX7Ddsu7/zQW11Gshpu597hQz8AOJCq/7h
	 3/btT+J7ZUckFITbUbbvd4YWx9iP7jh28fzd4W18JjaHVbjYKDj8uk+hq/tti6+JJA
	 rMWb7Lem8tFJx+NVf07U4E9FdbI92tUemA5O4aq2dqdbf8LL2up2drwaP+wkMUiXCF
	 2gMzSmBOO7INAVMafZUtYNXPn0xRnq6SWmhSHoNgEBUAG0Wk/SmQ8Wp4FBRtw8ZiJr
	 mlEm/I0kf/x/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] HID: bpf: fix __hid_bpf_hw_check_params report
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Tissoires" <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904-wip-bpf-check_report-v1-2-efe9a2a1ed28@kernel.org>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
 <20260904-wip-bpf-check_report-v1-2-efe9a2a1ed28@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:03:54 +0000
Message-Id: <20260904130354.A79471F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The logic to reserve an extra byte for the report ID incorrectly=
 checks `report_enum->numbered =3D=3D 0` instead of `report->id =3D=3D 0`, =
leading to buffer truncation for unnumbered reports on devices that also de=
clare numbered reports.

Pre-existing issues:
- [High] An integer sign mismatch in `hid_bpf_hw_request` causes negative e=
rror codes returned by the transport driver to be cast to `size_t` and eval=
uated as large positive values, incorrectly converting hardware errors into=
 a 'success' return value.
--

commit 2abe2f741986f5f3130a3dadda6bf82df9cbea21
Author: Benjamin Tissoires <bentiss@kernel.org>

HID: bpf: fix __hid_bpf_hw_check_params report length
   =20
This patch modifies __hid_bpf_hw_check_params to reserve an extra byte for
the report ID during hardware requests on unnumbered reports. This ensures
transport drivers do not strip the first byte of the payload and reject the
request due to insufficient buffer size.

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 536f6d01fd14c..b1de1dd0f21d0 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
[ ... ]
> @@ -388,6 +388,10 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, _=
_u8 *buf, size_t *buf__sz,
> =20
>  	report_len =3D hid_report_len(report);
> =20
> +	/* unnumbered reports need to have a report ID reserved in the first by=
te */
> +	if (hw_request && report_enum->numbered =3D=3D 0)
> +		report_len +=3D 1;
> +

[Severity: Medium]
Does this correctly handle devices that declare both unnumbered and numbered
reports?

If a non-compliant HID device declares an unnumbered report where the report
ID is 0, but also declares other numbered reports, report_enum->numbered
will be set to 1.

When a BPF program attempts a hardware request for the unnumbered report on
such a device, the report_enum->numbered =3D=3D 0 check will evaluate to fa=
lse
and skip the +1 padding. The BPF-provided buffer size is then clamped, but
the transport driver will still strip the first byte before transmission,
leading to buffer truncation.

Would it be safer to check if report->id =3D=3D 0 instead?

>  	if (*buf__sz > report_len)
>  		*buf__sz =3D report_len;
> =20
[ ... ]
> @@ -420,7 +424,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf=
, size_t buf__sz,
>  		return -EDEADLOCK;
> =20
>  	/* check arguments */
> -	ret =3D __hid_bpf_hw_check_params(ctx, buf, &size, rtype);
> +	ret =3D __hid_bpf_hw_check_params(ctx, buf, &size, rtype, true);
>  	if (ret)
>  		return ret;
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential integer sign mismat=
ch
in hid_bpf_hw_request involving the size variable passed here.

In hid_bpf_hw_request, size is defined as a size_t, while ret is an int.
Later in the function, after hid_hw_raw_request returns its status into ret,
the code checks:

    if (ret > size)
        ret =3D size;
    if (ret > 0)
        memcpy(buf, dma_data, ret);

If a transport driver encounters a hardware error and returns a negative
error code such as -EPIPE, ret is implicitly promoted to size_t when compar=
ed
against size. This causes the negative error code to evaluate as a large
positive number, making the (ret > size) condition true.

This silently converts the hardware error into a success return value and
copies the unmodified buffer back, which could leave BPF programs operating
on uninitialized or stale data.

Can this be addressed by casting size to an ssize_t during the comparison, =
or
by handling negative values in ret before the comparison?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-wip-bpf-ch=
eck_report-v1-0-efe9a2a1ed28@kernel.org?part=3D2
