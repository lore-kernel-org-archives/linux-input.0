Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B642E8FE;
	Mon, 13 Jul 2026 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949890; cv=none; b=AXWSrjntrpogusUqvMH5HhZnaCFT7LOAYFVeH4Ebeh5KUsU3zczNRNbbEthKN0qkCfAcSYwaEJlnGAh1gvpKZVXbaOd/7+MpJCsIMHwpDPWgOe8eueH+EbStrAXGK4xn8kZ5+9abgkQC6v/JrYiLMUQuLB6/ImQlHN8YHDge2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949890; c=relaxed/simple;
	bh=EtyGZtHz3NM7uG/cLWjok1yRzsiR/w6RcYUhXA7b4Fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ogJTk1bHRUMx8p8AGQlulhQzbxCTjoWH1UxXiGFDdmOpbX33+gjq88i5xacy9VMKK76jJywgd5xYjASbpdaJA3vTpNVIFpttZrGwcm44pvFlrO06oljREoPhMStW264swgvDvyzYNdhVmuDqILjJNQ/j1p/dUG0hZhjn5/tOXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFRrO646; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFRrO646"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D7B1F00A3D;
	Mon, 13 Jul 2026 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949889;
	bh=km3DIPPUOU6emqytYWVwHP6iS0ehJn6mupgsnwIR514=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aFRrO646yipSOYlK63QAN5VLzM4ETQc7GtF9Z7aBeYjnG84vVF8OaO5Oua7bD7cj+
	 fhMylHDUl9ahiOD26ToH3D8MNP2Kd2fdahZstYkfnAShM+dpvi/9u/gSi3QGVuWKB7
	 WicurzgLoqKVWo82AlT4UdFiZeHVJMm6yvhk9fN1P2gHtcNeVPwY+Ejq5yeGgDhKBk
	 HJcrrmPgyb5rZl6DY/BkOVabwhbOCHzH9lryDTTP/PGKpmIvtrd95pdQa0dlwIWpoL
	 1mG31PD3lzpnTap3X56weVbcma21dmUbVY/64djUSh1V+wYFdShoxD9TlDMQO/YK63
	 g/mQW+Xqt6MBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: bpf: Fix signedness bug in hid_bpf_hw_request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260713132608.1265541-1-lgs201920130244@gmail.com>
References: <20260713132608.1265541-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:38:08 +0000
Message-Id: <20260713133808.F0D7B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dereferencing ZERO_SIZE_PTR in hid_bpf_hw_request() when report le=
ngth is 0, causing a kernel panic.
--

--- Patch [1]: [PATCH v2] HID: bpf: Fix signedness bug in hid_bpf_hw_reques=
t ---
commit 87da4183dd7e20066daec7a3b7c00194ac025c96
Author: Guangshuo Li <lgs201920130244@gmail.com>

HID: bpf: Fix signedness bug in hid_bpf_hw_request

This commit fixes a bug in hid_bpf_hw_request() where a negative return
value from hid_hw_raw_request() was improperly compared to an unsigned size,
causing the function to treat the failure as a successful transfer and
copy stale data back to the caller.

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d0130658091b0..520b8f56a5146 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -445,12 +445,14 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *b=
uf, size_t buf__sz,
>  					      reqtype,
>  					      (u64)(long)ctx,
>  					      true); /* prevent infinite recursions */

[Severity: High]
This is a pre-existing issue, but can this dereference ZERO_SIZE_PTR and ca=
use
a kernel panic?

If hid_bpf_hw_request() is called with a buffer of size >=3D 1 for a HID de=
vice
report that has a report_len of 0, __hid_bpf_hw_check_params() will clamp
the size to 0:

drivers/hid/bpf/hid_bpf_dispatch.c:__hid_bpf_hw_check_params() {
    ...
	if (*buf__sz > report_len)
		*buf__sz =3D report_len;
    ...
}

When size is clamped to 0, kmemdup(buf, 0, GFP_KERNEL) allocates 0 bytes and
returns ZERO_SIZE_PTR (0x10). The check for !dma_data passes because
ZERO_SIZE_PTR is not NULL.

The code then evaluates dma_data[0] to pass the report ID to
hid_hw_raw_request(), which will dereference ZERO_SIZE_PTR at memory address
0x10 and crash the kernel. Should we add a check for size =3D=3D 0 before c=
alling
kmemdup()?

> -
> +	if (ret < 0)
> +		goto done;
>  	if (ret > size)
>  		ret =3D size;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713132608.1265=
541-1-lgs201920130244@gmail.com?part=3D1
