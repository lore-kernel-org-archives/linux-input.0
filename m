Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08B599A2D;
	Thu, 17 Sep 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656236; cv=none; b=EeQOUrUg2RQ/hbXedEpDMnu80ILlO5hoCwb3fDY7CX8BsQ2cGwyVoq1qVQtJItwGVw0YyD6xTEfUyKJ/cLz3OaKyc0UR5rlXb1WSCYQNP9X09WCNxqY2zty09q3VTapX+OHR4I1IG8sb8x6qMy9b22nuz0lPQgQlCNNSE8TKRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656236; c=relaxed/simple;
	bh=QdUZWXsKvcOvHfEy+mtQzWtHJEVn/m76pLn4a3Nx09k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tqqyr8Ybd3r6amzO/ogOC0qYy28MPtfOsYRsVzWhFgOb+x7rdKf619taycHbZFSiHgmzVDFe40NvTy8ZhCvDpVxpPbIQ89LLT/piZO7deIfU+bDY2dMF4A9AwT79UXK6H1lbUCkrxUZwU3nSR1iG86Umj/FV5Uv9QH+DomjZ7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+8Z6gO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+8Z6gO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0926C1F000FF;
	Thu, 17 Sep 2026 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789656226;
	bh=QdUZWXsKvcOvHfEy+mtQzWtHJEVn/m76pLn4a3Nx09k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+8Z6gO2dJhITHSzSnooP8YrNF/EYTaH0m9LMvCgFSkcLafpDujNAiZbxafSX0uWt
	 ih69kFb3+cbwKOOIGpcS+DoiC4ZDWnPJVWIoiK7AWlw+hzTnVDKtm3vws53My45C1Q
	 gjWYDlLm2WkIa7p/1/BxzpvnzZTIPfyhEZvCG3SvdgAwF+gvUHFey8R4sDwZo2GFzx
	 nzyaWDrfqwbR/qQ3vgAIUQIJgpXvPEpv4lWmkyLJrf6UAoF4nQPasn/r5jeBMwg1US
	 jL5MeFuuiBdt7dzIqUsdkjy1rL6oeKQdV3TJc7tL6UBnOS7ZG6vrfUM0ZBeAZ0+3PV
	 GaaOBDFknGGOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Matyas" <matyasdaniel006@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:43:45 +0000
Message-Id: <20260917144346.0926C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917144028.4590=
53-1-matyasdaniel006@gmail.com?part=3D1

