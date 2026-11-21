Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303574;
	b=btCnuAlTKVaCuUfWuqNjx4WQz1DFsF0DajlnYOLAgYvY4gc0lGqTHM3RPV8APIiJY1Kb
	 ZB7xuNtfGt4AlrFpJrA4QErdEJ7VUZp9EndG/bAozNMVPepeKqoWHOk4FUwV3/WTVAFw4
	 TyoDl0G9vJVk7to7otaJn6B85A/clqN/UKchseRaeFb01Dgj2Xz/xa2mlX477MnEKP7AU
	 iDTWcqixicWJtPaiWeFG7DGlsGPcY3sXtGJrSC2WgrmJIhXodzIIbf9dFSELjQqWRuDo0
	 //6fzvRwQJYHhuFcAR6kc53xoY6PIXYfC/Cp2qjQwNNpkw6Ba9/wPBk1tvM5q1svpGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303574;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2h4+akabm+ASDuNc49m//l2gEtofBDGQhNVDAgqwlrc=;
	b=0jdvs6iwNieG3YKieOIqeBi6j2HgwbCPNKN1PK9NGDzqD3h5Dceko2sknBjepxSsOnsH
	 VmLv3MsDm1EyRDRwVwXZ1UzozxP4AADNI79egGMAcftLgI/qzS2y5k12dKryl4wKGr+gJ
	 jY+ILsNlKNl8w4/4seGMyGI81k217TK8czgVt8khQy4se0aYlH0Vmru0NyTKyGeysI4ef
	 iyIfesYGuA96Y/FdsFaPjTQRiI7uuWFrCYLI6I6HoyFsam6qcJngiKpLDmRU+NWosDI0F
	 z6UMkfcMV/RmDGz2uJ2N7LZAWeqvB3raJhemEJTsTSTBRyNOmX4vC8brbMAZJgoXESg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSNF+Svo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865C606A320;
	Sat, 21 Nov 2026 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSNF+Svo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3331F000C0;
	Sat, 21 Nov 2026 23:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795303574;
	bh=2h4+akabm+ASDuNc49m//l2gEtofBDGQhNVDAgqwlrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SSNF+Svo84NBPncASHi9V59JsViurOpH0gFsQx6euuEZv2XH4nHqdIVwQXgA9pnaA
	 sVZ3HnO0u9wGQCbyy/OBzPeGzBaZF5DsOH0Hi1i1m57FeOt78FKSELat5um/eWbdy8
	 AVqxc9kQD0RTLJJpU0dYcQzVuN9vUE7FzpN84WxrSJZoe6ShUH399dIldVr54pi/FV
	 Cwi5ScBL4yypo6qIdmK2H1wWtMuzhnHuQRk8iYEOuDFsCukhXnm3blopvO8991KEn3
	 nFEDf8DpVunU0VRte3PFEgqG7+I4r0f+l/04NosjUjl9VFOvNzlCZGFMaS8y3+OKWd
	 6n5tnhgKOMUcw==
Date: Sat, 21 Nov 2026 23:26:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/4] mfd: mxs-lradc: Convert to
 devm_clk_get_enabled()
Message-ID: <20261121232609.65a3be18@jic23-hlaptop>
In-Reply-To: <20261119134041.16611-4-festevam@gmail.com>
References: <20261119134041.16611-1-festevam@gmail.com>
	<20261119134041.16611-4-festevam@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 10:40:41 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> The LRADC clock is acquired with a managed helper but enabled and
> disabled manually.
> 
> Acquire the LRADC clock with devm_clk_get_enabled() instead of a bare
> devm_clk_get() followed by a manual clk_prepare_enable(), so it is
> prepared/enabled for the device lifetime and released on unbind.
> 
> This conversion makes the code simpler.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
I don't mind if you get to the dev_err_probe() now or later

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
