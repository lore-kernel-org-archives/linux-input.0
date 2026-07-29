Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA01C3F31
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286203; cv=none; b=iSuReHMP2aa6MXP8Ray1HF+gdNUYPOOdX/yjPYXr68IPvAuMg3VNZ/gZ21J2rRNA9b+J0aICFBwliWXnurkMPJ6zSgyKUw2vitMlz7Q7KHahKYSUGhHtjL4kejccKAJ0JpMg/R/0TeiMXwYRu00JCYm4RPReN8Aknotizkx4C9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286203; c=relaxed/simple;
	bh=sJUZyxGvvFX/qYT2yX5RuK/jdFjqeFiNnLhHYvicXnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zad+T8daNnTpIrHzC2WW3bv0yEUVISkZp9M+hOWfoGQgyNkDna+xPniPRNA/m4K6r+dsldT5tAwOb5oZJMA/fOJC2aLfMesg7sUPim9y/cdtskxkawLvEo/T82icVNxuDR9i4XD4K7SAofWZ+RF+PIzf1zjaJTFDRs11UL0A7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgeJ0o8C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgeJ0o8C"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so5845815ad.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286201; x=1785891001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sJUZyxGvvFX/qYT2yX5RuK/jdFjqeFiNnLhHYvicXnU=;
        b=SgeJ0o8CWSv6K7YOt2c3q3jaP5/Ymxaz9HK5Rkj1ps0onadK/TRikWa8ecN9MrlvaP
         SjDDM9Tu6c42nzX2N6aVLpJ6pu1FW3/HuIW/buSnBBhZOCrRY6efHZ5kjQUE7Vufic1G
         zCjt00tIc5+J4oylQQclajcZyQ/SsMk6DIzkqOE7Ay43kxGLlLAIBhC/B+qKorYwuJdc
         /5DyniIfxYBxwNilDj7smCHXUNEg1FbiEOmy8dgpHzEHtaj9CFPPHz0em+h2llPy+QOh
         p72DxSz5BxySSOfHvO3H1Rdg0DG6szDDEaHxWKAvfd7AUIdzOLy+nKBVSsjAkFS8eSMQ
         2z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286201; x=1785891001;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJUZyxGvvFX/qYT2yX5RuK/jdFjqeFiNnLhHYvicXnU=;
        b=T4pUwPZoj2NZn6TNyPzDM3WwyyJaidTPXxoourGfGwZN86P/koePQpNd05PoxMWZuv
         +32yVsXcfIm7PFIrUSW3Gj3O0jjWB/FkRuMJtVGXq+Ot3WFHF0ljNhNbCxMpj9XCcDWX
         qUE0aN6SjZFXfm0dvXYc9AOojQRc3FysLcoaq2RgCTFj9O69OtEwuwZncXrDQHeXAgV4
         RkpJJfB1A8geUbadn3ex6dVeX2vGgxydXvHtmPjsqEwGN6AUrPzEGJvmMPrbkQCWs+5S
         CYZh+D5r5Qx66ap1a23ARNnAPby1sPdUvDwN8FuCosIqSvcENzzDXFoQwf+xuRXwnHND
         6aAA==
X-Forwarded-Encrypted: i=1; AHgh+RoW6OFgA3ZHfITWPj8tw++AIAjOm26ZSaJdT2J7IV18aa2+QQ3Reu0bUuF56YBQG3XrLEyuRQcb0e4etQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6wMFDQD1X0c6xyHycqZx3Eh0K5UqXRaMWV7bgrtPM+Ajd+YJ
	+0DS0I7UlgbWT8UHd8+hdOVs4EC4qZqP/uyNgRHkzCWHgtL6IgJCLu67
X-Gm-Gg: AR+sD12Z8gcL6E+yGMOO0/JcasyM1I6W+Iqo+cNXRXI9u7snuchTQ5lhq2E5RM513/w
	bU98+xkLPMV9NoDqU+h9emDbwRZ7jvEaFDCNynX2MwYjBUb87LbX+ttxjyOJzrjua8mOS4A7KBm
	W3CjmOar3oChco9uX03BicqVSRtJvhTNYF1lxw2XK2+kwwnSbUI/1szeaZk4VBOq/lXghnIpY9J
	V9IUAuW9e6B6Ky0bCuOcR7Rg468JGNSLpzxlM0++Ui2FblIdzBpCv7rdxrEnWszx5DTP2za/xgM
	SrU9AAxISYp1cIAFGWgWJpmMGV+wWAvkHzRCSnpXaafxlBOv+Ry1kznV0rPAjsTYVmONaF5lAJ2
	B5jQcunx5elmlVONrnd9YNmvQji56YRKMLAZJ/t9uzwhsl3GK03DeKoVRd1Sx31SbW5ws9BDm9w
	YUz0hm2ehycVbyaDPuKFoFT5NVQO2afwgCxmPsMnWLDJw/ZAM2iVKZJefP0u5bMwr03tl3tSoMY
	yke0aH1wNWak9yR7Wc7XQ+iy0XXwK+bAw7Q/64jnO7YdA==
X-Received: by 2002:a17:902:d2c8:b0:2ce:6d4a:5b8a with SMTP id d9443c01a7336-2d015db675emr49101285ad.38.1785286200935;
        Tue, 28 Jul 2026 17:50:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dab0f3sm2984550eec.27.2026.07.28.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:50:00 -0700 (PDT)
Message-ID: <40af4f2e3833d5ed3a73e6436c4262db21ea3fe7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] resolve_btfids: Keep collected kfuncs
 in a rbtree
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:49:58 -0700
In-Reply-To: <20260722233518.778854-4-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-4-ihor.solodrai@linux.dev>
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
> Store collected kfuncs in a rbtree keyed by BTF ID instead of a
> dynamically grown array. This allows for efficient deduplication for
> kfuncs declared in multiple sets, which is needed for subsequent
> patches [1].
>=20
> [1] https://lore.kernel.org/bpf/CAEf4BzaLzX3mXvQzxv+gbmZOh84XvYofLjMSWFYg=
hNjS-ohEZg@mail.gmail.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
