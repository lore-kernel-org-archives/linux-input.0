Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD334F7CA4;
	Mon, 21 Sep 2026 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014956; cv=none; b=fiGsC7VFRePJ5wkMyMvc08b0JMFksmE/7MOn4ndgZ4VwO2QQwN5cVs8/LOPqpcVVGbX+tT4NzRTGnrBWFUM4wDRQ+nPo/f8SEHbgSb3z9IHT6F0NlL7q31CZR13qerzfewLS6JyXwgmSxI0JcG4x7eTcH33rJZE1jQHWVpysuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014956; c=relaxed/simple;
	bh=8z0Khtr9SLyyYYCR3JHm6j0Y3dIZ4BkGyb5xmji4O5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxLQsnHPAdN6ydlkcwZ0GaIhp5WoT6Jh5zhEZRltYdBY8X0kquVAM5jq4Anzc5XKuElvaLqRMqzmI8u5QPiJ5aoi5kYbJvJxP9q7usRRuhlKuMroh9VDp/KyAvC7D3KqPAn0zH+ZU82COFjWUAbrKSk1OqdTpuejhJMHTZgK9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sugr0xNE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sugr0xNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8A1F000FF;
	Mon, 21 Sep 2026 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014955;
	bh=8z0Khtr9SLyyYYCR3JHm6j0Y3dIZ4BkGyb5xmji4O5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sugr0xNEps7tfVMvLPzGhgdMHBPEH0nb/d474o65souoSfKUQQ3bWlQeAqsjeTRrj
	 xVgAKBIo02dhF0ycc1SzboJVvJ5kWPHZYVomkPM1V6NyOJ4fgc+iRxNL0z4BPOOPJq
	 sxlsqglzjkVwOHaDFR4b50gM8gUtbvO+8jZlONBewG3oteC7ZvqQ1mhWPDU3U6ZifI
	 yq23OziXjrcJ2nlvwMe52EjuQWFLc5zaVuZCGQxrvpomvgKmHLidcKDceBA631ejbD
	 CRCOc9Tc6FYv0cz6tXtpS4GPFe4C0efNBTMMWjH2aoe/NilBWENiP6QBN/ijJj3ds8
	 tsEHTBoGDf+6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, robh@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:22:34 +0000
Message-Id: <20260921182234.B2C8A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D14

