Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89253246788;
	Sat,  4 Jul 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183293; cv=none; b=A/GJN1MkDLsT0TSgDt9GL2iGzShbQFhOm9J1ofNdMvLhiHfnSjwJxSaPVX99EEyUpC/8dSsf4homHmVF7dOCKgHz4mNNZmOK+aifIVviI3wNTvwcja98Y77jePnQChlKjpjJkkrG0L22T0wspnwopvpUYatlMqQ4ZGXUJ5mSf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183293; c=relaxed/simple;
	bh=JAnqXpiymMagepe418gUewTa+aRsMqZ+n3v1Mu9hvWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bzphh89gyliMKJ0v/xma01E0wj7rgD81oilyHj43M/zJ/f+NEBRquhlHgd0jf6dLCt7exclvT4/unEe1lLINBUBpuV81OXwRvMnHrCaOBFNi9UmTmUvepMmXm+T4Ov15s+E+zKIRH+Ky+0lO5sf/SsIKMD+yG/4LMrirtn4UvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGX9v9pZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGX9v9pZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E664B1F00A3E;
	Sat,  4 Jul 2026 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783183290;
	bh=d8Y9RZWt39sd9f3P87GWbZJYkP+XpRH6IPq9RUBbeUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IGX9v9pZbx3fJEwOJMoeFkxrg+bLQnz0rrolUFaaW6e6u/9UQ955S3XkgZ1nIpBd+
	 FRbdUBwuM+3q+umhkIJxGnu/F0sO71Q3BmQWYeDfIAY2hb8Rt3zSFUzhXWZkWz9uyt
	 3QisvZL3KWBsi+F/dbGYzgALKESl15DpzPTrOyHskIiz/L35V1VbohwdV82AO5/zQ0
	 buZgmLG3EkNrHFHPFiUV4H0uTdw1VXA8CVFwUDv+F9OzJotfj1E+ig+/OBnNPzNAVA
	 WhAoiIjuJTklIPKK0ADZNm2D6ge/pzqLjEE488Zi4DeuwvoGRNld/ItchpsfhDrkWr
	 07XjKzNMKqCNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: bpf: Fix signedness bug in hid_bpf_hw_request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dmitry.torokhov@gmail.com, bpf@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260704160703.156298-1-lgs201920130244@gmail.com>
References: <20260704160703.156298-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 16:41:29 +0000
Message-Id: <20260704164129.E664B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer overflow in hid_bpf_get_data on 32-bit platforms leads=
 to out-of-bounds pointer return.
- [Critical] Missing bounds check on `size` in `dispatch_hid_bpf_device_eve=
nt` leads to a kernel heap buffer overflow.
- [High] Dereference of ZERO_SIZE_PTR when processing a 0-length HID report=
 in hid_bpf_hw_request.
--

commit 8a657f92f1d0d08c3cf3bdf8cdaf0b05c7deec72
Author: Guangshuo Li <lgs201920130244@gmail.com>
Subject: HID: bpf: Fix signedness bug in hid_bpf_hw_request

This patch clamps positive return values from hid_hw_raw_request() to the
size of the caller-supplied buffer. It preserves negative error codes while
preventing oversized successful returns from overflowing the buffer.

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d0130658091b0..b13f911e5944a 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -446,7 +446,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf=
, size_t buf__sz,
>  					      (u64)(long)ctx,
>  					      true); /* prevent infinite recursions */
> =20

[Severity: High]
This is a pre-existing issue, but does this code safely handle 0-length HID
reports?

In __hid_bpf_hw_check_params(), the size can be capped to 0. This causes the
subsequent kmemdup() to return ZERO_SIZE_PTR. The dma_data pointer is then
unconditionally dereferenced in hid_hw_raw_request() when accessing
dma_data[0], which could cause a crash.

> -	if (ret > size)
> +	if (ret > 0 && ret > size)
>  		ret =3D size;
>  	if (ret > 0)
>  		memcpy(buf, dma_data, ret);

[Severity: Critical]
This is a pre-existing issue, but can the bounds check in hid_bpf_get_data()
overflow on 32-bit platforms?

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_get_data() {
    [ ... ]
    if (rdwr_buf_size + offset > ctx->allocated_size)
        return NULL;

    return ctx_kern->data + offset;
}

The addition of rdwr_buf_size and offset could wrap around, bypassing the
bounds check and potentially returning an out-of-bounds pointer.

[Severity: Critical]
This is a pre-existing issue, but is there a missing bounds check on size in
dispatch_hid_bpf_device_event()?

drivers/hid/bpf/hid_bpf_dispatch.c:dispatch_hid_bpf_device_event() {
    [ ... ]
    memset(ctx_kern.data, 0, hdev->bpf.allocated_data);
    memcpy(ctx_kern.data, data, *size);
    [ ... ]
}

The memcpy() uses the provided size without validating it against
hdev->bpf.allocated_data. This could lead to a heap buffer overflow if a
larger size is provided, such as through a UHID_INPUT event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704160703.1562=
98-1-lgs201920130244@gmail.com?part=3D1
