Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF585402BB1
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977598; cv=none; b=mFAsXvkc8kLC32XhUUz7fREpVVqmGRvQFYNS2OB4Znqr9DY5arurRUEIh+8Wh7hgadDh8jBk9Vy+D6TM/U7cLOiGvduun4F0rR7gWF+vxAMPfBMfbvEcY473wVZm7RKS1aAxcWjMQZsipz7iBO6int7owsSj6EBe0tqH/gbd4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977598; c=relaxed/simple;
	bh=5R6SFlz/bfx5XQ7wxa5PSrekDt/yAtW9RF4cfWCQgyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaI719/LOv4JvOnaPNas/Fk4qDTNhzLbId9z5fJ6C0e2boAF+tsDXJCBeGEpP+4DlqO1xsBmLGa5/riq/vSh+lBLn97mNHkw+qU/JnnBQJNYp+OszgsjSCSRiENYDwz71jjm/lQpBJ89Ch0D+WVKtVAXokpnQlbyCyytUzKuC3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWZc6OTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWZc6OTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BD7C2BCF7
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977598;
	bh=5R6SFlz/bfx5XQ7wxa5PSrekDt/yAtW9RF4cfWCQgyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fWZc6OToKu/yoYoTf5W9dTK/aDelutXzPYtDe5gXWl4ry0PiqtmviIVeOZnP379VG
	 QpbzGXSdl+YeH1mvQ8lSd8MufHcpG5ij7uyILbrlskt5SDh2j9w85cf3Y4YUzR+Rqu
	 FdCY3iZdB29qYZxOxy+KN985LCUHEWHxBJzqFe3Tj7D8NwW2WWU/zmBYCr5MqAAHrJ
	 TD5EQZ8zybb7DqsIMl/PVaZXg21c8ooizyBeq6wr3E8SLOlYrRx44kr1/RRjiXr4jQ
	 jtPV1IUO1BQcbyvBJIWZnGE0dr+/M+ArI/varG+j1QKaDCIDESY4LZUaDRt6MEiiZa
	 ohM0mc2ZIeCLA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso51312461fa.3
        for <linux-input@vger.kernel.org>; Tue, 05 May 2026 03:39:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9HyJxg7cRcYY6saEGxD+kS2r/1pG/Y6rrTM1dEUlA+DVniVceCYwacpGd4cmZTC2zXXRHG1MhbOZ675w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3UA+R4x/0gexFz41ZaEVemfQLPqQDltcWXg15+nV35uB1xeh
	SJvjfOn/L82C0k2Qwjtf0cZvNYOI+AexMv6kjRYArxh2CqWiYTiIL7vkN2MgANcPfCNVjiI1IKQ
	JGB2gilBeVVsiQigosvdscohIJ2B35z0=
X-Received: by 2002:a05:6512:68f:b0:5a8:73c3:f270 with SMTP id
 2adb3069b0e04-5a873c3f40dmr2568123e87.8.1777977597130; Tue, 05 May 2026
 03:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428114308.113253-1-clamor95@gmail.com> <20260428114308.113253-3-clamor95@gmail.com>
 <CAD++jLkU-G38xtzzfAV_otiYuM2G5NHdCdtjFjsy2AjpG22_rg@mail.gmail.com> <CAPVz0n3h+zWi-b-ZTLqwXR-9JNGcUgVodUgo+ywhBfK-UDQJAw@mail.gmail.com>
In-Reply-To: <CAPVz0n3h+zWi-b-ZTLqwXR-9JNGcUgVodUgo+ywhBfK-UDQJAw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 12:39:45 +0200
X-Gmail-Original-Message-ID: <CAD++jLk_SojErY4gxjixzwEF3sfSownH=jBYaoPD2LeoxibhWw@mail.gmail.com>
X-Gm-Features: AVHnY4KHuhdjhUS5hnVh3matnEBusZqUnHj1GhrxmfNfdL0iJx6VhTo5biYlmW0
Message-ID: <CAD++jLk_SojErY4gxjixzwEF3sfSownH=jBYaoPD2LeoxibhWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:46=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
> =D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12=
:22 Linus Walleij <linusw@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:

> In you original code
> /*
> * This is done in the vendor tree with the commment
> * "Duty 0x64 =3D=3D nForce 90", and no force feedback happens
> * unless we do this.
> */
> if (isa->clk)
> regmap_write(isa->map, ISA1200_HCTRL5, 0x64);
>
> 0x64 is actually some conversion of duty cycle, you got this accurately.

I wonder if 0x64 =3D 100 is simply 100% duty cycle?
So the value in this register can only be 0..100.

Yours,
Linus Walleij
