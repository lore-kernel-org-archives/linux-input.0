Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DB24E4A1
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785286553; cv=none; b=Ee+DbWWfjdcqpSGCPFj5piF73/Hg47AJYLMEVemZKzhhxYGaiec55qv0OrLKUJnyaR2a0euXBUwQW7pxelMz27g1zMdyD7A7/WqwWWnANMNqwzRPrDMtce5GILh3V5xm/zXfBO3KGeHHRSstGVfySZEq+/mYzv9qnb7bSk6se0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785286553; c=relaxed/simple;
	bh=7Iv+GFGwZ/GK6yGpCIeJlgsRTg0wQ6eBXuiN9TaFpVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uuDC9IBf9jAYHpeysAUfhvFjG8+21eKhRruH/DK/mMJePU/HfsOXrcXaWVgIqR/Ychtc3HwLAkiZ3JgJxaSLCk7UiThAOjJOXfFhJeeb1wU63YwIBSFJ1BnlUDP0cYABv7P50fqvsI/YY5DUNTU05nokxT9hJCEuvJXbIVIm5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdNwPieU; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdNwPieU"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb85186d43so157659a12.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 17:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785286551; x=1785891351; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7Iv+GFGwZ/GK6yGpCIeJlgsRTg0wQ6eBXuiN9TaFpVk=;
        b=QdNwPieUiv4lmAYiQSjTNAWXQ8qPiCkpVSnrlVOYNk5n8dAK7+p17cMFdXdE9p7u1P
         3mWe50L+Adga4zZhOF9yqTrtN0Ee0Vs8ezhcqBa5uDMXlJdPCbGaSYjNEShKGxE/gThy
         Sg9zIj9bbnuekA/RbAa8/hU0JHwYMP3AyeD11nWI2A3/s4SOsRiPNiAlCWR5GHMOW9lS
         2LN6/u4FNCQ1P2u84rwfiGnw48UWauYDZQJMId1xvBkMnoXal7YR6+p67zsln2J7WMjE
         nfWacolv79ER1+qTjSS9y2vAmrYe7EpspXUP1NssglRgJQJdkI8hhz2uvTBGzIVsdUz7
         BoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785286551; x=1785891351;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Iv+GFGwZ/GK6yGpCIeJlgsRTg0wQ6eBXuiN9TaFpVk=;
        b=r2846xlxjPXCYp+No5eo+V499op69ZnvDAQ+o+TdYQyQJui3b2SYIlCkRvKo7xpOv8
         6gmia3DOmnsBFlgIl3QoUfGx5zxck0As4zmalqWkgo0/iJWrEQDkmGDGWtEo4kVOX/q0
         Q3fB2SHkAF1WOraFhLxgLNoWb3CXzuTYlrhPPLQV3EjWFrgDVdfh75+tBPb4BH2r5JBr
         suAVTKniMgfaRP7EtQk8/hfqvXdxSLvCSG/mhlL4MoOq9fLfarbS+VJ7NP2AlXyQMnsw
         8kRnqDbd/ZJyC8AbmjhpOg76H3lzJs3Ik0bCSuMqXAZGRBCdt71QLSLFlWcCtrc+QRtB
         UwjA==
X-Forwarded-Encrypted: i=1; AHgh+RpnEUR6h+nL/l+vlP8FaS+GIRvPvTEgqnUCjoxcGV9S7wEsS5cwvQJs0/j8CBJOE+yfh7OLCzY1s7X+AQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOO+AYWuCyTGWaUlm1mAz6kraNGs0Do7e7z6c3LdrH4YvutD8I
	sMOZwgko0Rb4tu9Qg68NODl2+ZKNAMUGDkFTpL7JqGF905/h8y3ssPxM
X-Gm-Gg: AR+sD12k2wGjSh7fnQG3q8aR4dywupahS4TNxYHWeh6ak/qQ23D5daqdqHwx0b7ZtY6
	bK73mx5HtXpwmzGqqJw+x9bBcT1G9F0tP2AmlX9c3zc1h9MsVvjvgvO/d3ZHVaZd2zuQ947gUhb
	PidWz8aSEFYYaT1QamrXK+/x4Y8+V2PMaUW9ADAaJ6j/COwamdn9k+FqeFWfJAPvlV66y+AjvJS
	OxS9U/oXkWDp9T217L+aoy4nD1R8fIic30Lyqbc+jYBmnUZnae3YQFIRfCDgq/P/Nsdr9PmcRM7
	K0Z35OD8tYwnVoFl3lzp/IELowsBP/r8xCezCDQHem2U7wEnTZ2mrgHTGmhw29PqduS0AJ1I2S8
	a00RMZgVcMQwBHEVIcMKTGBkYT6fE/gFtW88C4+cG5/fi6X6mlJPdBSDz6hjNlZsgdHqiNXSUqx
	7QRtXA/3xpTNtf5CAMHQ1JPJ/xJaQcoxm/ilHD0paqhTVLrXswC4WO2xOl6dlOXVfhD/Pjkn1v1
	zUfe3Z9mRFeTeLjAI4r7Fr6zyWXLtBDNIWA4f8jq9AegQ==
X-Received: by 2002:a05:6a21:6e91:b0:3bf:6c07:b2f0 with SMTP id adf61e73a8af0-3c8ba6132f8mr5806787637.51.1785286551493;
        Tue, 28 Jul 2026 17:55:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a4d1:33fd:cfd0:d646? ([2620:10d:c090:500::7:3a0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm5610706eec.22.2026.07.28.17.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:55:51 -0700 (PDT)
Message-ID: <b4a41c7b549bb96af669bf56a89da6f4a7e6e7d7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] resolve_btfids: Fix the _impl lookup
 for module BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-input@vger.kernel.org, kernel-team@meta.com
Date: Tue, 28 Jul 2026 17:55:49 -0700
In-Reply-To: <20260722233518.778854-6-ihor.solodrai@linux.dev>
References: <20260722233518.778854-1-ihor.solodrai@linux.dev>
	 <20260722233518.778854-6-ihor.solodrai@linux.dev>
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
> process_kfunc_with_implicit_args() skips generating <name>_impl
> function when one already exists for backwards compatibility.
>=20
> It uses btf__find_by_name_kind(), which searches the base BTF before
> the split BTF. When resolve_btfids processes a module, a same-named
> _impl in vmlinux would be found and the module's own counterpart would
> not be created.
>=20
> Fix by using btf__find_by_name_kind_own() for the lookup.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
