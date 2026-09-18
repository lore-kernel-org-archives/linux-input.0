Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87314A99DE
	for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719849; cv=none; b=sI8xpdgxj9tycDDgQzeNHc7gmp+5tpyaOAUAOGxRE1iKAA5dvO0u97+1hmRyOr/OXLcS7q6tSDgG7/qwyBHjcOqOvsfsd0wfrjv7w73M9xDThqwQ9pV34cyFszMCbwpdgT9PJ9PW1NVndAgVFj84fzvzA/dn8BP5a/562J6/FYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719849; c=relaxed/simple;
	bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0TbBVNStekREDm5TwIXFbT6BczN6rBUuVTDwja7/gRi+44Yo+nHe+2fAL4GkXcrYlDmblVX38qaPcWBKWHKpm+RoNss3eBJYogeT2Ab2iU+Obhy4o2erJGODYLS+T3JUJxUqlXFB4RmoIu5FnhE/yaU94m9Fme4GJrJvSISl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r5dN5UKT; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5dN5UKT"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so77554766b.0
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789719846; x=1790324646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
        b=r5dN5UKT5wfIItQgqltovZCKdP6Usucx4w7xOge6GyKE1gyKIanLqslLmo+QYJGN5X
         3toO7A6j1iBDwk1wOzoaucVHVP2c4OH6bSqnZ5RQwySz89ev0tu8c5kzrcKtt/6jL0C5
         yp+AyhidBLMOJE/V8rTQ3DI+pZPXUizTfHiLmFBI4vC1V6V/WFh9jSIFWuPbMPo+5e45
         1FtScQH+giAYlCVU8PRqHBwNNEQotbaNdPab0hoD6r+jlHJB/iz7baVIfGSiVi5qMIb3
         FazHilzpnzSXPDlV3sDUoSBzhl27hLC8feqNgyc0Jf0zLiQX5X7KcLYAVhyy7HMT18D/
         Dl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719846; x=1790324646;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
        b=sWM0KJHJLx9BEg8YMf++HP90cVrA6SC/l7bugtqqBi0lhA+va9jnbOGWeNU5e/Ac5M
         2OlAP6Mu5VqTJSsj4JLZLnaOG5GVFu0W6Vt5yM/eroKxyE6osLr0EjhhxzFCKGoj3JsD
         +dHrsXCoaeyZR7pnRrewgKJUXn0WZVQVn5fUIfxR4GSKsFrmdw+gzejKjMtPkRdDSrm+
         SV5k0ebe3njnalwfISP7nAa+RAHTSG13A8Ztzkod+1YmgMezgCuZ+dlwoH4XJz5buxSn
         kpbWcSrCiingzbtAYM6GX0Wr1RpFiF8eW+wlu98ZRR/H/efU/ykcEqdpAwh4esGeVVWA
         W61g==
X-Forwarded-Encrypted: i=1; AKwUvBzEvf2u41oAGwxArgp/y3F+VAnPGXiRSiT72ihfj3MHnlFU9Px5l++9GuVfp/lBKfhiBqpTwWbRY9sktw==@vger.kernel.org
X-Gm-Message-State: AFuF++laLQ4PXvT70th7N4ETzE3FaNYb7FnswptlEWFL0qf/hF9cfW88
	2muW2CViVeW2uy4cqxPtb1uCe5gCjM+qZEk9Jjdq5dxPA+4avb609tqs1M3ZbxjJ99M=
X-Gm-Gg: AYBFou0ns1XyyzaJyg5SsP6oVbnU1sqhFeZiYdv71clJhMAAwOk+igsm4acPXy3xq2C
	Ucch3Uuuy7VjsAM/UzBRdTlgrWGIbwr/M3SSfdGcqEjcOWnJWTpoTPw9iyEujgfpFTDHe+iphhN
	NdgTyFFFc0lj1SADIQgSeF8deZaL5vjJEnFckl1W/Dzby/CSYjWd2JlnIU8u6Owqd5Ejvlbg+c2
	iOiHf7d4MS+YWXK3F0xHf55cEmUQCi2dx6Sdwa46a0rb/Wsdg+d9hfsZTaSUmd8UmJ50FhB+rNP
	WOYNZLxmabYTy2/63Kpcb6VwBg/yuQJMVolehhCe9J5/Z8MkDsvzP0iukRefFSN5qGtSxd6fDaW
	FqJWDPh6Q1u0jbCk/Aqo0BS15zcjnrMqPZoecAfSAVdUlKD+DKun9i+ECOUfZbzAZPdbDorb7qc
	hS4NE1mY9NJVHXsOzsne292B/46J8F/bfuETT7KSRhK20Mf85bXifjsbYiUWoOAb6dlPFoME5RB
	KU=
X-Received: by 2002:a17:907:72c7:b0:c26:3190:296b with SMTP id a640c23a62f3a-c2a15e7df89mr192409366b.48.1789719845848;
        Fri, 18 Sep 2026 01:24:05 -0700 (PDT)
Received: from draszik.lan ([109.255.181.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6aafsm33384266b.51.2026.09.18.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:24:05 -0700 (PDT)
Message-ID: <b567cb05cf1508be7474e2874d267d8e8a09e49c.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Daniel Matyas <matyasdaniel006@gmail.com>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Liang Yang <liang.yang@amlogic.com>, Miquel
 Raynal	 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman	 <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller"	 <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Bjorn Helgaas	 <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Ray Jui	
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,  Vinod Koul
 <vkoul@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, Jonathan
 Hunter	 <jonathanh@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown	 <broonie@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>, Ray Jui <ray.jui@broadcom.com>, Scott
 Branden <scott.branden@broadcom.com>, Atish Patra <atishp@rivosinc.com>,
 Shawn Guo	 <shawn.guo@linaro.org>, Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding	 <thierry.reding@gmail.com>, Ibrahim Tilki
 <Ibrahim.Tilki@analog.com>, Okan Sahin <Okan.Sahin@analog.com>,
 devicetree@vger.kernel.org, Paul Walmsley	 <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley	 <conor@kernel.org>,
 linux-rtc@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>, 
	patches@opensource.cirrus.com, Lukas Wunner <lukas@wunner.de>, Chunfeng Yun
	 <chunfeng.yun@mediatek.com>, Eugen Hristev <ehristev@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux@analog.com, linux-input@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-riscv@lists.infradead.org
Date: Fri, 18 Sep 2026 09:25:27 +0100
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-17 at 17:40 +0300, Daniel Matyas wrote:
> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-string=
s)
>=20
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.
>=20
> Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>
> ---

Acked-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
