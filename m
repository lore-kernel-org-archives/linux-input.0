Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B24FC331;
	Mon, 21 Sep 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014866; cv=none; b=IC+5AOTiw0T6W9H/ykBxa1/g4h9UBvNGaHhuW9FvMgIwMhFFim9CPOuU8uA/iMC7nsiouIGLVuR3vSaULRJUIg7rmHhFDBleZm0dVGtAOq4IlLivBT+GpskkTzifGAmLu6tHO4yHiQLdY/iq1weY1Pn2b73+nfFiNbyoZ0CCsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014866; c=relaxed/simple;
	bh=F0jb/M4H+otVLuMrx9aq5D4ceQrwhN6iSrOceq7sh5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pH/nfn2IrMPw6XQ1j7T4bFOPUJ3Z1o15xZL7S9piVSola9LF7mRbIALcby67iGnUy99O2KRwtdlznKlBO85NPxczu54iH9iodSIMKFe8KrK/27nEBmMpsLUhIkfryAn7FA61X4GkvsROCNpbW4Ag6lxeLKjLiDshG9X6hdgWOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkiVZtvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkiVZtvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F761F000FF;
	Mon, 21 Sep 2026 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014864;
	bh=F0jb/M4H+otVLuMrx9aq5D4ceQrwhN6iSrOceq7sh5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkiVZtvIeXwUTFzO273peMhE0R8TCCgOipJu9uAQBh5syNFOlm6WSa1WCxT6NgNVr
	 TR1aYmJ1hd/ID06dnQY0BGbF2dFfv8uRfMeEm7b1GG2ZfxYEEySPM2hbYCb2om8hdA
	 RTaFQLDufj553hRg6NQUFFmoCLmDpGZfcM1LdsnWkWJjWmhnwhsKHT7sL/96wFQ+ax
	 fG/xxgCGW1EThMGbaHlMCCaopsx0PSQjBxBjdZulS3LkM55LZIcRrqOKN7sCXwO5pN
	 x6GATEN3kZA5pGkgyOtHml5CPJpSW4xw0evtxaXjAcuK9HZB3l0C8Usp+Iz7HYpLyl
	 YJ5h7btUASaHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/19] dt-bindings: vendor-prefixes: Add General
 Mobile
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-6-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-6-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:21:03 +0000
Message-Id: <20260921182104.13F761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add vendor prefix for General Mobile.
> Link: https://www.generalmobile.com
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D6

