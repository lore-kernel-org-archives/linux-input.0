Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF581FB1
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286712; cv=none; b=uGC+nJ0n35ORwozArB399dUudPVWlGt6cX2NKkYEjk2bzHvk0qHbSrgkHYAk4PVvyQxgdnIc9bmv9QrIghzhpjPu/CnPlx7jQLHPV2LOibvisg61x8PAAy7O1bHdM8vZ1ja8Ie0lylgA7uU268tW1d/5mo/ZodtDNwaevkwGB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286712; c=relaxed/simple;
	bh=21GnbT6wp81vV9M/ud8/rwHFbXCj/WbHHH5Sw/UppvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVdD9D/VF+1WS8HxaGzSglIAYNfH5BK4N/jLQ00FjSOsJElhN+in516iH+O5BO70qyyMo+0tKZz3ID6jvcQ2bTt3pAU6bJzlmfQJtTZyVOT4WGPnOGm604sPZ7FZNP84qhsMwsOPoOPxfARWDjWqQldcSC+BBuSybEJvZuSV+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVr+Dzwo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVr+Dzwo"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso516132a91.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 17:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286710; x=1785891510; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ylNNNEvZp3+lZiwGGO09XotLrkiLTU61MPCxVFgm8zU=;
        b=GVr+DzwoRM39RAeMDGKBAfqErGWeruXwplJK1B8zaxWY9tiMAx9Lp+0C9rhK0Z/lY8
         bCvP/89LC56/7uxWiDUniwyU6jvgUrs3LIKUO5AlYkREZ7alMpN2KXDcswO5PVv+H6C5
         iojE/L+qjvaWkqxzhNEEOxHjUaquTaYz+t7q1obKBlJBG/wKmzUCF3jb/a39bik6pRcU
         TSvYW6mPHvXKpP8gdxpCYBHt2XVGUItWLVvIvOUPzJC/xRo3dv8CJDR2PmKkByjXhSDH
         cHzW2iZRPIifEkZoTuCEaRJu2ID7eGY0D6w6qD++FXHjdkJB+v6wqqqtbD8DwM8J4k9v
         wK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286710; x=1785891510;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylNNNEvZp3+lZiwGGO09XotLrkiLTU61MPCxVFgm8zU=;
        b=PdcjMpg8m97SOGzagC0jwcOV8vXzrxeOavthnQA6gD/jT2kjlsoIRGp9qBsFxI1kQ7
         xyzfkaDtpuEMWaNc3dpZ+htluK+osEvNRlDalapWeWmz1o/zjQeg+lPAyBlLH+ZcRMvE
         8M+wB1Pph0s0xypqkntAf9zFGBgclJ9UmheqTZikqKr8685sEa2lHcrMIfezi5h6XLgV
         gaxK/uIzjfMCTolcum4fYBx/vJvsyw1Wt8XXabegG7hEeOLX5ip7Kh3GKV4GFcld1YQq
         Um/8AdjQFDKvVlaBYZSGXW4Q+MfCIH0uR7QQ7te/y6UynACUArV5famGFgcUsYvZhyAc
         aaUQ==
X-Forwarded-Encrypted: i=1; AHgh+RokQNY4uZm8RoxSdiYRs2SeOrLB5YplIvzaZEd4FrvLm1UT2yxmtCmi/HGevj2jCwnndajG4OtA0Wtd9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmvp4LaTl022BmHPpzX0lWxEwzyr1TzE8uoYjxSv2080CUylfu
	sQZSIDEIcFcFE6g3dUbPdU4ZcRsf6D1r8E8GGwPaq4w3sCDEmMSHPofg
X-Gm-Gg: AR+sD12jyqm5I1WQGS5NJWZnncbfF3OheEp0egtvbr5dKdlmJaIvvKZBc59FOZw98Pu
	jS7xijoOXE6zJ/ckIUXxY0Kh6cUQ4I7yB4CtY0OLzsV/3DyEfN+Sh55lUUf/9/U3P5XgnoWf+i4
	k94P9KW0GApWcR8UG2aVAtcTJOPIz2qCsCu+0nTEwRbQ8RZSkyY4z+GaY5YYh9ERdkxZR6nNHLo
	fZk2H0WYAaFptPSVnr1TR9VKbMqCTT6Wuill+MRsUcNmqQQRdwhT3lwEi+3r4cbOVVvFchzWSRy
	qvQMh5QzACqIbYuMCTV216GmID3AICrZYFhgztung+O5TRAfqagDD8YRDf+6K1oBSd+i3HP115z
	/OvJTNmnz6e1KPuw+nBHZwTN+kXhFi7Yfz371ye4mTIjq0BX9zOIwI7JHPYpaY588c9+Lt69dzq
	kriW2Olc5Ej4uG5Tpl0tb2T/ZVxQOSuYWqWvFERaxJAHlo+X5oxB1QTkle/qLcZVXIQa0+6ayyO
	9LDS6SQSQQdcaMfrbImCCdzukJhqWTeSqBl1kqXoUmCcA==
X-Received: by 2002:a17:90b:3ccf:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38f6a53f749mr4887035a91.40.1785286710238;
        Tue, 28 Jul 2026 17:58:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm3271397eec.6.2026.07.28.17.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:58:29 -0700 (PDT)
Message-ID: <60ebdc9ad7fe251ba240268d61c2b66dd6153d0f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] HID: bpf: Make syscall kfunc flags
 match the struct_ops set
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 bentiss@kernel.org, jikos@kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:58:27 -0700
In-Reply-To: <20260722233518.778854-7-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> Update kfunc flags for hid_bpf_syscall_kfunc_ids set to exactly match
> hid_bpf_kfunc_ids set by adding KF_SLEEPABLE flag.
>=20
> The syscall set omitted the flag because syscall programs are always
> sleepable (the verifier rejects a non-sleepable syscall program).
>=20
> However the upcoming resolve_btfids change enforces per-kfunc flag
> consistency across BTF ID sets at build time, which is why this change
> is necessary.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Benjamin, Jiri, could you please take a look?

>  drivers/hid/bpf/hid_bpf_dispatch.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 536f6d01fd14..44671dbdeca8 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -590,11 +590,11 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_=
set =3D {
> =20
>  /* for syscall HID-BPF */
>  BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
> -BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
> -BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
> -BTF_ID_FLAGS(func, hid_bpf_hw_request)
> -BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
> -BTF_ID_FLAGS(func, hid_bpf_input_report)
> +BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | =
KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
>  BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
> =20
>  static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set =3D {
