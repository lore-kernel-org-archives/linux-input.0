Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A83478E26;
	Tue, 16 Jun 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630283; cv=none; b=O/Qm0y4/KSpKfaSP0gYY3fk3ADRpgKrLa31+sysaafAvLDMLo0NH3T6xhqNtFCtLIpFxLddnRYPZUrXiGR4GuJwfqdqiqVilDpzAmZv12PLhj1aRPu2QirOdgJVmQqqs+nw4zrgn+XpqNjl5VccEw1qCPxxvnLIeSivQRNp/Vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630283; c=relaxed/simple;
	bh=Yu9t08q0QZ+4NB7xEvUGFMKDeGPu82aMJl9C8jONfQA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ofK53Bky3aszwlZaZ3MeB2ncq0K1gtC5yzbcvUaCCufyJy5E+3YO7rEeGGRf+1jtCb0/L9WqqF2co4B2P6yLEchVTgPiafovglDL47JEntBWJWdCgdGmPaKZ9+917C1lBupDhqMr2wrsSGlbiuIYhAhNLnNYHuzZEl0NVeisUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow3jjE1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow3jjE1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A491F00A3A;
	Tue, 16 Jun 2026 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781630282;
	bh=awWNOq8ZwqZkNg/uk1VV3V3qfIhQ6bUIVUTqPS2E3vE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ow3jjE1wRC21kxf605kG4L2JHx/wgA/z9a7kyGqnJmQR2whHzjSKJwBhfsU3Yc/aZ
	 fWQapiMn6Hg2e1CDL+VSruQaYGhZ2/NNdw5TUH8ipo7WLUMpGQU984p1hwIH+LHK1p
	 NS+Tww2rDnXW0B4/r3xliHRf0Lm/w45yHBZYGxZ4GW8RlLH1G2rTXd7IVH49HWG3tF
	 dlu/V1lHwXe/ix821w5wBuDXpm1+h0o0DLHCgMczrxXT6zT3+3sosATwEdtGqs5sTx
	 GJgjO2w2HxvGms9k25swOduviOvRhgGaYxYODcnxx1zabAqw1PJb/6CrjOcfVIUBe/
	 dY2Up38AS7nUg==
Content-Type: multipart/mixed; boundary="===============4017712549315767575=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <509c1ebe734f2319372b2c5f9b02979f07a7ad5dfb44dfc9062501c1440b6633@mail.kernel.org>
In-Reply-To: <783681f27625a11ed58f00221be046643232a2fc.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
References: <783681f27625a11ed58f00221be046643232a2fc.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] HID: bpf: Fix hid_bpf_get_data() range check
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,jikos@kernel.org,bentiss@kernel.org,bpf@vger.kernel.org,linux-input@vger.kernel.org
Cc: chenyy23@mails.tsinghua.edu.cn,shuah@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 17:18:01 +0000 (UTC)

--===============4017712549315767575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 7c433bf4ab2de03b77e22dbd3984e39a386997a2
> Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> Date:   Tue Jun 16 16:35:06 2026 +0000
>
>     HID: bpf: Fix hid_bpf_get_data() range check
>
>     hid_bpf_get_data() returns a pointer into the HID-BPF context data when
>     the caller-provided offset and size fit inside ctx->allocated_size.
>
>     The current check adds rdwr_buf_size and offset before comparing the
>     result against ctx->allocated_size. Since both values are unsigned, a
>     very large size can wrap the sum below ctx->allocated_size and make the
>     helper return a pointer even though the requested range is not contained
>     in the backing buffer.
>
>     Use a non-wrapping range check instead: reject offsets beyond the
>     allocation, then compare the requested size with the remaining bytes
>     after the offset.
>
>     Fixes: 4171954f56fb ("HID: bpf/dispatch: regroup kfuncs definitions")
>     Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

The Fixes tag points to commit 4171954f56fb, but that commit only moved
hid_bpf_get_data() without changing its logic. Its commit message states
"No code change, just move down the hid_bpf_get_data() kfunc definition".

The vulnerable addition pattern 'rdwr_buf_size + offset > ctx->allocated_size'
was actually introduced in commit 658ee5a64fcf ("HID: bpf: allocate data
memory for device_event BPF programs"), which changed the field from ctx->size
to ctx->allocated_size while keeping the same overflow-prone check.

Should the Fixes tag reference the commit that introduced the buggy code:

  Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> index d0130658091b..09b45c40d84f 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -299,7 +299,8 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
>
>  	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
>
> -	if (rdwr_buf_size + offset > ctx->allocated_size)
> +	if (offset > ctx->allocated_size ||
> +	    rdwr_buf_size > ctx->allocated_size - offset)
>  		return NULL;
>
>  	return ctx_kern->data + offset;

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27633665618
--===============4017712549315767575==--
