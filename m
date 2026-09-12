Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1D418A5B;
	Sat, 12 Sep 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202614; cv=none; b=DKJ97zXqEeuGoyLwkxtBYMXE9awMPeXSmYxmvosEVslXhF+SmpV6x+9OiKcHwylpo5XbBCoNUOxk4JupCmrXhQxSuD4Zoii4/dxk/jYWTMRHvpCYPvJuSUj8VwMn1HQuC3ohkL5s6X9sTKlcGRVovxaGebHFcoayLivNeZ6wqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202614; c=relaxed/simple;
	bh=6W93l0LA+Wr92moPYXHt5bMfk3oNvleu26sDIfzvBFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3RlrFraC50oNrl1BU/QjlxtUrSk/zSv78pnOoKNY6ZjwgeGeeSdxqKjVQq1ZJ1JvziMQCW0zj4zXeHG8r0KP8z6X/l7pmkgg53DlQpAcqhXYhm8dgrnmxRj247oOGbWCfHTFWELs5EgI1cyARznB+veI7eEnBry+WpmFJ9WfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDyzL3gn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDyzL3gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900331F00893;
	Sat, 12 Sep 2026 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202613;
	bh=6W93l0LA+Wr92moPYXHt5bMfk3oNvleu26sDIfzvBFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDyzL3gnqPxzfgvqLitoNBrQk0Ia3+TwUKwoF4IwJBPOdwZZtz+TnXen1iOjdFcUw
	 LUc8e2otYd4eAAB5tD3s2NrO9O9b/xgU7QiBvLlao7S34kBr/5iSfuy2tC/83YUwOk
	 UCPcv2uuANJWdyJqtE1pV8Ce/g8XztorgzoTaxjd2DUeXygFgFEOF70onERKqKApKN
	 qg0h1/Vh06gcTSBhDIG0Pa4+AtDYh66LRAEiU7D+iZ3Nuz3l7IfcWfrYnJg7uchHc5
	 B0PEWczNcduX8IKTKrdF8KyLN+3t+XQdFXA+BAAnfdpzGZ8w8euHWnOI76DCH553Hm
	 55jIRp1sOi1cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/20] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev, conor+dt@kernel.org, linux-clk@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-msm8952-initial-support-v1-5-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-5-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:43:32 +0000
Message-Id: <20260912084332.900331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the compatible string for the SDHCI controller on the
> msm8952 platform.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D5

