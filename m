Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781094;
	b=dci3v7z/fb6FYlvRZrRPEC2r5szcuEJ54dQ2IqHMggPCPdzgdEUknH9EinH85/Zku+tI
	 d6Z56Pk6L3IH6KgRzFXBxHCRcwEfBdFsTgOiD1+YZSte+1gPFTqWAgnTEI3fqLzlP4knP
	 XT7TRjn5u2yQjdXHB+cADvQtJsmmnyBXLZIBnWNfLni7m/RwOQqOXk4TqRsWjPyhg6CYt
	 htF2e4gm5ki2CL7W0XP25n7/JrY4xiujmm/yzm3tKlUFAVYwui1gvj2Mm1gAgxS8UGcgj
	 gHDa1y0mGoRq4q4ALomOfu6BAJXyNiQuO9Gj22nB9b5IL6SKsrOnfXBgBIJ1dMizEMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781094;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xKgha9VxvmSvw9cDdb8uf1ZW6YX/MsofjYkuzeJfmCQ=;
	b=HFSDF4BBZD6h+kYqSYEUYUvyNUmqEju1cgwYMz6IDUQGzQUEZMmV6ZF4UdXRPfzXFKpj
	 XsnXhG/2uZhQt9HE6ANPzlHDr7wcFcZhnC8v1r/5o2BqMjL/uTvP5+hb+HxTBefjRaFr4
	 y3I4/dLLS/4/WzJqSt5EpX49q9xi7+36mRS0F16t4GMUo/Kr5Oqthxsa/M6t6Fvq1Xthp
	 rxCcevO2WyDSJtUOVvF9Q6XQyzA6gCBw14zlgTE7pM7ZBm9rhmorBdVtv/tTwfH8WMa9C
	 RdjndCHpeZYVepRonp2ZKeS2M3XmFzRIfFZRVLo0N1pY/4Vfm2+/MV53P27MPzmeAqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFvckm3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BA606A31B;
	Wed,  4 Nov 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFvckm3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D7C1F000C1;
	Wed,  4 Nov 2026 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793781093;
	bh=xKgha9VxvmSvw9cDdb8uf1ZW6YX/MsofjYkuzeJfmCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jFvckm3ekBn1CkDPeV6q/8xUtgevCcgYCo0W/IbjKLZ78eszlFmsEeDV431hh/pCg
	 inqOhJtuAJcxx+eTdLtQJdSjHVYvGiO8kk0eRl96u3ipBqrUmZ/6pVQ6/I+zSQzBs9
	 +7uM5+HBzCZ2G+V4sEKRn5W7ojLBVmHBpMgBMzexDEtVMdzxmdxy9a9wZXDaNns8QI
	 /wHXz3FMdiWqV5zUOguLJ6f4U3D4eNzE6mRJ6pkgx0QxlBBK28h1/G721mvF8oOURY
	 ocRA56/jPcpbHZEE4/5ex0ipiy0oi3KooLnWlOx02a0pRsUTOn5nN6ismKsBgheaoe
	 2OaNY8OQMu5QA==
Date: Wed, 4 Nov 2026 09:31:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, David Collins <david.collins@oss.qualcomm.com>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH RESEND v7 2/2] input: misc: Add Qualcomm SPMI PMIC
 haptics driver
Message-ID: <20261104-happy-binturong-of-persistence-b38bb2@quoll>
References: <20261103-qcom-spmi-haptics-v7-0-418de67ef84a@oss.qualcomm.com>
 <20261103-qcom-spmi-haptics-v7-2-418de67ef84a@oss.qualcomm.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-qcom-spmi-haptics-v7-2-418de67ef84a@oss.qualcomm.com>

On Tue, Nov 03, 2026 at 08:51:18PM -0800, Fenglin Wu wrote:
> Add an initial driver for the Qualcomm PMIH0108 PMIC haptics module,
> named as HAP530_HV. This module supports several play modes, including
> DIRECT_PLAY, FIFO, PAT_MEM, and SWR, each with distinct data sourcing
> and hardware data handling logic. Currently, the driver provides support
> for two play modes using the input force-feedback framework: FF_CONSTANT
> effect for DIRECT_PLAY mode and FF_PERIODIC effect with FF_CUSTOM
> waveform for FIFO mode.
> 
> Assisted-by: Claude:claude-4-8-opus
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/input/misc/Kconfig             |   11 +
>  drivers/input/misc/Makefile            |    1 +
>  drivers/input/misc/qcom-spmi-haptics.c | 1251 ++++++++++++++++++++++++++++++++

Fails checkpatch, does not apply, Sashiko comments.

Resending buggy code will not make it better.

Best regards,
Krzysztof

