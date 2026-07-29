Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D84369A
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284506; cv=none; b=oKSAigsLwb43fMuUQIO8WdfJ0VU/ydZhrKZ6vGeSitwFJH0CRVnrGC6/32UYtFseZNr7UunVPQCYVcp1jxpidEvw+U5xfH6KgblNxGuybnlEbJnlMd3W5ui43aiwFeGbseJpHVrJuwVegQB0p9/gaXwB6ESpJcOtKt9BKl6PYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284506; c=relaxed/simple;
	bh=79SpWJ9+Brrg4kAk5IM7v00+4qs18CV8xYCgdn+qa+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpNu+9WWkYISgc8LiDDW6l8kzoFgKgPz529rdzUbxAR/aCmZ+hvIM3hFSV1PiTWiREDwkIEN4I3AcrCrKU+iLsaMbqnJ5FngwV6Hw13E4gRYsBnX1NdSTKv82kgZOQEDy+qiu1IbjxT3m9jriL0pSnZwmp7LuzFShYhm8yt8ryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5UyGjed; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5UyGjed"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccf2360620so3856865ad.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 17:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785284504; x=1785889304; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=79SpWJ9+Brrg4kAk5IM7v00+4qs18CV8xYCgdn+qa+0=;
        b=W5UyGjedXsu68Yvb9J4uCSZfFudTkhcucH5Bpjf8qkekIpp0YR5+v4C1DIXqX7pMw9
         aTJ9GGm3bq9RMgKaEgjFlyXMPqokcIuFTwU4g9fDdwzeyxrZFFljL1mWK/uSMvoXObHU
         BUREbej3UYPB/hcqPJsUFOxiqBSFheuhUhoHmuGq5yfDMHI22n/w3Q3OeDBhz7g70pyh
         lb3VUzo7yHKivHLBz5Jl+McLT4S3yNGAwm02y1hEJVCkBpq0G6SHDO2JbvlfrMe89ZZG
         l02ottAeHxG9dlNtq7SjNRdWKRRWzB49DLcp0uyxPnTwoGMFzpm3W3YQ5qDMCc2ERJGh
         RhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785284504; x=1785889304;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79SpWJ9+Brrg4kAk5IM7v00+4qs18CV8xYCgdn+qa+0=;
        b=WIOXnOcnoPkcRJvYn1k0FQiwkKa8MnFROW0N/bqujJVNpNop0wAI3nUnAwET/5XSnm
         vSiPOSMPiokxnhigZWbWMmswSxVtMUgEMQI3V9fHq5URXto3yzn8BLCEZuFKAAPnGXE0
         QSWiQhWl2AkUQn75ur/cbQ8F0Qvcy1L/hWm6Lr36HhGh2fhanhuLt1HQmjLJvi+bzfxY
         P13/YTzBdlru82+7k0GY64kWi6Bx4BN9HFbM/46Xcgotet54S2Ttn8SeG/IPQD9k0CkU
         WTNX2cq8GObrWP2EuxaXYOj1V5lKMk/PcO9oQa5PbIsA2y8eCDG2zB6dTjD4SesoIi+f
         l92w==
X-Forwarded-Encrypted: i=1; AHgh+RqlTx6yaQ5C210cv04b60CRpx0ghyJuEnLAZ2utr9c6F/WQNKwKMdu91ycTwtoXOOVQxIyZwFP+cJIAoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+vec7rPk7Va4JtDniRKuGb/6deWDB7epO2zqRMeIrk1+KCKQ
	rMqnlLrXc+zzoSP1nJwVipzVAgbN5jbodA2NvltD+7Tf12OQzQV7uT44
X-Gm-Gg: AR+sD11Z/BXE0qVqATfLnIqvi2u5PiRVUDoWHCa6kdY+qZXkvKQDoFXiBx0ZBRVY3Xt
	RsSd4MT8O87yw7ERCX0UmXunEoHycJSfFRRaJau8Yy2VmR+2JbYJe/Ni3V4NAKVvdpmc94LMgUS
	rXObP5vIsHYJD07CMLn0KyryVbAQkyhvou0bS7mAEIkVmYJGTx5cMeFUBfj0StaSYCU3hJFyEUn
	KuVpRS/+ISJXEroggBuv6d0Uy7dS9GHSeZOKW8cMZ+nApKfveURpVV8kTQvrCAjqbTv+MWeF09g
	SClz+RBdiD7MzhLfDZ41RK4CzCq8/voCBXmKn/toGhpbaGFrRMVbco1Lts30hBXUMzy3PxrCftJ
	I4o0ZGnvM3R78u5i7F09m9xMTOUYjaREBVEh7EmBvQyDHZ/6uwh5j+lESWYFdzB1p+Q42/Lf0Yj
	RXIrI9kMxj8B7RyaJmPNfswrBkDi7dy18guCafPDQ7/IUtT1OPmzpPKVgtPeYAqmiq1U9e8yrru
	/mq1NXdvsaLk3vPxSofZRbZc9H3L38POwywX81MeI5wdA==
X-Received: by 2002:a17:902:e54b:b0:2c1:ee75:56bb with SMTP id d9443c01a7336-2d015ae7bebmr52117405ad.20.1785284503953;
        Tue, 28 Jul 2026 17:21:43 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dab0f3sm2841581eec.27.2026.07.28.17.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:21:43 -0700 (PDT)
Message-ID: <d1744acd96926b27985fb40c61a2bc3640c0d0e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] resolve_btfids: Index BTF ID symbols by
 address
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:21:41 -0700
In-Reply-To: <20260722233518.778854-3-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-3-ihor.solodrai@linux.dev>
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
> Keep an address-sorted index of parsed .BTF_ids symbols so that the
> original BTF_ID symbol name can be recovered from an entry address.
>=20
> Use the index in find_kfunc_flags() to scan BTF_SET8_KFUNCS entries
> directly and match each entry back to the requested kfunc.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
