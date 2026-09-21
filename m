Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B4485927;
	Mon, 21 Sep 2026 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016267; cv=none; b=HBfimwSQ8O0Sg2y3DVkMEidiOIo8E+0FpNxzNnO4BCe4La/tp/fVA/eSC8dBjnV8HpJp19k+w1xVdYKrfPLARIir5xsxVewdGnzyodrONIvr1Gd+ShY328GX55B4eXl90PewKzJmqtkYh/5zRWxco/nYHKQKs6bLCmXp6lNKJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016267; c=relaxed/simple;
	bh=Brk3K24u0/lPXan924zoDImNVkSErDdrsyqHIFP4Ro4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZJZmtrzd3rXdyXsI71+PYjQL5YticbEYJ54z21uBqblS3FE86YqC3WMD+eC6Le9Cc5fT+Ummc0DfwB8922XDIsX4Qq/+Wi+Q00uKSpiTfMMmzstL2Cw4aFVIVSF/HzKj+pEurb08D+nSTIRDEwShND/K0tVGBJes25xN7AZ1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn+Rqw8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn+Rqw8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAFE1F000FF;
	Mon, 21 Sep 2026 18:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790016265;
	bh=Brk3K24u0/lPXan924zoDImNVkSErDdrsyqHIFP4Ro4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gn+Rqw8JQ3a0QF5Okxp6vDUI5BzFxeeoQwPCaKnfgN5bK5A4Q3Yj1gf3bupACALYh
	 WoVHTlGUmrNcW0Ua+9GtLVP+V/sptKP0sKA7WN/txtxbTi/beyFN6WEK/zAn0m2pj1
	 2XExFSl6tOpyqpOhFwt2TOWVAPWflugI8FKu+X/GBqz/oa3TPfQuL2uaSOQlevW2D6
	 v164IzAE5+nij4GIR3Xv7yUfF27dbVNm3nBZROGlNmGcuQI8nm8PPbmgNncPKuEyYc
	 9c4dAkdcf5UClfttmAlc8H6if3VhczOpX21ERbIvRJrboTmCsA6fJNGBw1h1s018pZ
	 YFWeGAViP/SOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, lee@kernel.org, robh@kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-2-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:44:24 +0000
Message-Id: <20260921184424.EFAFE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> This driver provides clocks, resets and power domains needed for various
> components of the MSM8952.
>=20
> Some downstreams merge MSM8952 to MSM8917 and MSM8937. But upstreamed
> GCC driver for 8917 series has different pll structure and ported from
> different GCC driver.
>=20
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver, with
> some parts added from existing other GCC drivers.
>=20
> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android=
-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D2

