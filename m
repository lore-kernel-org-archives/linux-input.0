Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DF21CC5A
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286466; cv=none; b=ZKGUCFxTi7pXzzdSmpc1n2kOGpjuQs+414eS0GzIErXbg1PhLCvgYtwaw1LsuhtqmjwzNQ5Ev3X6YV56/n3kzyID55PDT3jkzU6Xddo3EqZ7PdP+/XvbnfCrEndskzC4rd4BApiZqfoTXJFwTEMX1Ctly1pyi9RQgeXDiEj+UW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286466; c=relaxed/simple;
	bh=5Lr5IjUyDlxwY8dBQ/hmJQBVPhCGetFAfVOSN4wo3ro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sR+mCAvci7Qa/UTQtQN4wFOc4mwguvr92k+5IwY9dC2SUU4DUiI4RaxYnBnIjmMgtT1zBPp++rXBzO3cEhkinJAVcELupLr3Jsbp4knDNKxmkWM9uDyj0i28wfy1ZrWJ3yFaiJwLK9tI/HX0epy7BgpHRfZYGQeDj8Fva6h2vyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeU+3Vqh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeU+3Vqh"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so308339a91.2
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286465; x=1785891265; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZbHvEL7dXUPa0tTQnGqai5VPfxBX3kXlGujGxijLDec=;
        b=UeU+3VqhxSTZSyaKBdD+SYhY0DOXpKLaaNdwAuUxS3z00K7+fbdW38pmH83OlUdybm
         CxYDyj4/VJvq6h9fAjRpwYWfbX9zoNUP8uaidbQIBh5l/ZBneo6O7XoPLKuHVwOLG97A
         JEW7h6sMBIcI7+yOM3q3GO41pIIe9HHMPOVIXksZOej9mxdNPkf1BlmH31Lnib44Lo2R
         xzHkpJszWR2M8XCd3XQlLNBJ4qrVnRX9kLpJzSXApUwQ094LgKO2+00aQRnctmqrOpRf
         74EPzkTvC3bI2qbUug4whR1AVcZ2QR59uDKv3fj5BW9Nx/zEI/STQpDD9y4z00mtQMR3
         KXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286465; x=1785891265;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbHvEL7dXUPa0tTQnGqai5VPfxBX3kXlGujGxijLDec=;
        b=oIHG9GD7+L9wN/chbdX97qkKFz2Ad5m536aTtq9sAJcxddwKvK5rweUHt+ylhmogUl
         c1au7Pk1Mn0uLxEqD6DA6OE+Xmzq0RspZq85Bxf3yh29jn32g30F1uNgCHIr9DJcmAC5
         SAadXWzI7q718mt4J7bRIKrC8zeHl4zWtauXRJNJpJ2bwXOwgi+blVml6yp6N/EKcDTU
         0hFsESPX0+JlMJoRILUGFurmT2LouPAuneNofx3GdU6RXMbzqnImy3SJRhb9CpSUPuAm
         nKDNFyVOmJCVTpk1B9qFzkPbFSuNZJabHFHqe1yncTnkKL3W6GFX4BhFvBBsaeqEej/G
         dkfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8k3L/M2SaYCuCcPdm7Zrg4p+GaPzCb/iiEPRuWwvK3hnKys6rrFg381cGn2ECMWmn+TGqIVdrZl17jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3ZWPf25z8aSXrsLUk1oiwLUXlQg7WxADLN8LqZVhsW0w+qT0
	ZuwH1YQOMDPNmvefjMnFbOWUO9ziSG900ZXRnqoDaUc59O6Mp9pM6DNt
X-Gm-Gg: AR+sD12Yp8Zk2ju5VcffaImGh4sEwtTmVABEvczTOT98z/ri6ULQoBklACgXUhEUoSj
	B4/VqR0vBgf9vgHjnBoI5kXcX9Y0TUkNWAe40wwrJM2gkeNlLPudNjlHpejOis6E26MIfEWpmfj
	0jC0HEQSPbYsWDP6x8JbRK3OvTnjZNm3zxEVQecTPrafYOmaoN7qGGdxmJfDGecHuphPu4wDYL/
	pol1Yi43i2KRbskpk4c04Jge5R2GRffD6WRI97muFd04IvRaWKnU7qd/bsH52sh33E6l+Y2Li+8
	IP+VzPCp0ojfwyr3AInDeKpXl9+9MfAvpQZ5K4QBZT58ZWXwGMKuFn9ZCT+VK5DPzBTzjmSOEdi
	NzT8oHfCSe8KcxG0qHuBtPpNHIt+k6uGLdXk4qfQStsIXu8OBuEVG4D2LD9kGbnXxsNnKUtJt6d
	fwQ+J8aDoI7uCJvv1lD6+VMlZplYuQg/akN9DguVtP9WzJGe1jHIVjj2v5xS5aRjP68rqynYqEy
	3slbD2HUutDovbh6lpGJdgjL7B3E0R5B+Xp6Z2BHV1RpQ==
X-Received: by 2002:a17:90b:4cc6:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-38f6a557bacmr4735473a91.20.1785286465024;
        Tue, 28 Jul 2026 17:54:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7265010esm3407972c88.6.2026.07.28.17.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:54:24 -0700 (PDT)
Message-ID: <e847bd1af74a5b8e5f0bb7741335fd4a5c647bdf.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] libbpf: Export
 btf__find_by_name_kind_own()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:54:22 -0700
In-Reply-To: <20260722233518.778854-5-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-5-ihor.solodrai@linux.dev>
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
> btf__find_by_name_kind() searches the base BTF before the split BTF,
> so in case of a name collision between base and split it always
> returns a base type. Tools that process split BTF may need to restrict
> a lookup to the split's own types.
>=20
> The internal helper btf__find_by_name_kind_own() already does exactly
> that. Make it a public API.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...

> +++ b/tools/lib/bpf/btf.h
> @@ -172,6 +172,8 @@ LIBBPF_API __s32 btf__find_by_name(const struct btf *=
btf,
>  				   const char *type_name);
>  LIBBPF_API __s32 btf__find_by_name_kind(const struct btf *btf,
>  					const char *type_name, __u32 kind);
> +LIBBPF_API __s32 btf__find_by_name_kind_own(const struct btf *btf,
> +					    const char *type_name, __u32 kind);

Nit: please add a docstring.

...
