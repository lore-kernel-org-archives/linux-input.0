Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B34F5E0
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289267; cv=none; b=vE/79C1AeawHybFNwIjZQf0UNJ05PShesmaIiliRkYKkr0GZJfDK2oM6IsE/hk/un/jOShIxMUKfeOC2HpH4cCT76ZXWMaS89j+knK+XeLIUxFs9CgJ95V7F8gJy1oKoNu5azzxAj02PEo6Spv0pFv/XB/6KseNhcSwRGEJAu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289267; c=relaxed/simple;
	bh=4C2QnvxvaRO2l9zCru75rbjXH21xX9Xdq14ne3kNWgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3jWho2K4ljUyxcUsYzpaoqvIBtW04pUnTTENyZ7nvX9z6YFlC8p+DYUA7ob8I9IYs/Tc9yufrN2LLKEJcHCXfVej3Y3TYt8mcl8p/0RcJk5i81i1EYVSGBB9ocAEE+Ia1AZDPrKezXPIDp/Fej7IOTNSh07S++V/mYW5zXtg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0peHaNK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0peHaNK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so359300b3a.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785289266; x=1785894066; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4C2QnvxvaRO2l9zCru75rbjXH21xX9Xdq14ne3kNWgM=;
        b=M0peHaNK/ZNhGUX1doLvXtKm3p8TaE+EA/7qkBjJr4f83+r1+i8pEbHKL4uLWZBGlp
         BEIf7QD1DVTSLkwy1kU7H49YLlmRUoXXIrKpkz+224w9GHUCy0tEdLDS1rRQ7zansPPa
         eT73YaVu8KSPWjr1RzvmHspETgGqTVMbeWaM4LLiyeO1Rz2WnToXf1K+H3+3YhFSUjhc
         ElBJyDzOd7BGFItD5Ox2Cb2oty7XB07lkw4LWFVOCQgBst4B5iA6HvPTfY25Z/dmnYeF
         Fkk7WyOODPuKbSf0xZTq8adObUMSMEG6Cl+nblxk98ok39wOtswMVCX3usSGfTFkE9Pd
         QQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785289266; x=1785894066;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4C2QnvxvaRO2l9zCru75rbjXH21xX9Xdq14ne3kNWgM=;
        b=kIUIjqbMOcffp33wk8CmhPnxp1YoTmwINEC2u5+tSmtXj8L/Rgw6S+gJ9buq8qdGkf
         OHMAH4cD0LRpmwkvckpGxHeNTAIR6sn5RmIuYM1+rPX1fO4yVsWPzeYaJ7jf2sndTspf
         Ao6aO+ySjyfl6cDk6cJVgJwR4KZglBrPo6upVetbnhkvJfQ+dibJgcZewJyU/xowNDdU
         3SJdJ3aY3zoiARpZOIQM78WW5/keCyfI34ymOcs35oKIwiGobnndcMC5pqC+SXxLLUH5
         fYKwqM32Mecu9iBklP77O4vxI4zqoPZApMm/5JtSQuGODjACd/Sx3sJc+JhjMwetuUa5
         g4dw==
X-Forwarded-Encrypted: i=1; AHgh+Rpoexpl19welAkD+HjM1PiNegyQJw6x5pV+/CzkUXqbfV7ahaEew/xkoAPuNoqAAUoXZCers4ugYg0Mqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yycbhj8ChzPzYL+6GjuXF5f4T+3sBumfBlaSxxAnLlSztRWU42L
	jSpPMQjeo2ggu+HJfWVpyrjSOp6tlOrmMt50KH1GqJNFhLcHIZol8+IF
X-Gm-Gg: AR+sD12T1nWYDz8hTxEcCIzDSf3pr0DkCjuGmiPyJq7M0ZnV1G1dXaOoSjKyL3U3bEv
	b8uYv7fwLBHBMk71QDLlwwR6wFAHYbMfPxHPC2nSo0M07CePSYQj2qSt64MrKmkCWyX2Af2+b21
	zuzA4fw/CMT9p5PZjoQqeoTCEZssV/8X0D+0Llgns2JjgerSzBlHRN16yfHE7ukt1isFzO9aQFj
	R1mk9wIPjHpqiOlYwISokGzva2f24JoZW1mrQ4fFD/N/45AfgJEPd80mFFpxNjrObYPeMfW6pMR
	Z4oFWx21uHrXqf0i1s8+YoWFUfaaV35196Tc2wfdhzrWstpX+Mh4J0iq6dkX7f52gagIMUGlQbh
	yJsmdlPdPMhiYjFeKRPd/px0759Aw+B9e1bFD4NOaHlcJy5zmKbrvoVX0RvLuBKrhQnAT+8/c30
	gxzhVr+eJ2CziBXvQeK3LSoQp0oW8B7bjpO5goapglcX8taoCc59XSE8pZxXS3OFDTdR5gs3iGb
	RhDI+sJSSRInL82cOOlx1rsZAsedU26UDG/CfZawSSsOMGJ2SdYnZaxj/OpRl0=
X-Received: by 2002:a05:6a00:178b:b0:848:42a7:1854 with SMTP id d2e1a72fcca58-84e93256a18mr4906859b3a.39.1785289265641;
        Tue, 28 Jul 2026 18:41:05 -0700 (PDT)
Received: from ?IPv6:2605:8d80:58a5:c474:f5cf:239:70ad:a743? ([2605:8d80:58a5:c474:f5cf:239:70ad:a743])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm194328a12.21.2026.07.28.18.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:41:05 -0700 (PDT)
Message-ID: <c35c87fadd24aa77d107fa2213f4455448b619a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 8/8] resolve_btfids: Enforce consistent
 kfunc flags across BTF ID sets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org,  linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 18:40:46 -0700
In-Reply-To: <20260722233518.778854-9-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-9-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

eOn Wed, 2026-07-22 at 16:35 -0700, Ihor Solodrai wrote:
> A kfunc may be listed in several BTF ID sets, which is expected
> because different kfuncs are available to BPF programs depending on
> their type.
>=20
> However kfunc flags across different BTF ID sets must be consistent [1].
> The flags should be considered a part of the kfunc declaration,
> because they influence its BTF representation and verifier handling.
>=20
> Enforce the kfunc flag consistency in resolve_btifds by hard failing
> on error and blocking kernel (or module) build.
>=20
> [1] https://lore.kernel.org/bpf/9b2196dd-443b-4632-ae11-030cdbdc59b4@linu=
x.dev/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
