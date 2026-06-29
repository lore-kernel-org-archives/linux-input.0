Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24C419308;
	Mon, 29 Jun 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738756; cv=none; b=W+Lj14MKu6s2AVaTsJWbJm+0ArSinhs1CtR8f8oFlsnPkecIF/h/OPgK2x9BkdGDuBU7unv4WeiynD+WWAdBmvrVydd0QQCfOM5DSvd5+fNiS7qDYvRL4Z9CpSuvRP/CeLHJT8ZMaZekPBTxSxvQtdI1PlXoUa2E8014pkLIWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738756; c=relaxed/simple;
	bh=IaAnCU43ti7ZTrUnwH0bkWQiPqQ177g5PV6Evlo5nVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UjwdLueXOHwOLOPwONbV0skmXxWqwwVW02stjaQ9ypLb4iXpASWdVAiadDVOQm86mMMb/eiAjAvkTmk//j1ZyrooRUvQNgobLj4WFzTNyHO+p4lppGAjDVQD7AC2hjAUEySew1kZXFMY5Wj+r4ZwEl2E7NyQ1ScG6ejmrT3yl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu631/hY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu631/hY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DBB1F01566;
	Mon, 29 Jun 2026 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738753;
	bh=IaAnCU43ti7ZTrUnwH0bkWQiPqQ177g5PV6Evlo5nVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bu631/hYdVRmkjeBChVU99EhqgMH1taUKZUCCAOI2TEqBX1OUQAOsXT6dZz5Mu1T3
	 CLIJpi5V0tRovLCwDkKeK3A9TflbAUjGhkElmsP28gsviYRE2DfTYhOLD/kkUhfdd9
	 ivwF91Ke0vr14wNoVIBWC1ZIMMBMCDnBGLSU5R3hfvJZ628+Oezj5zb+aM1AnKmFhx
	 c+ZxNrxf1ipSFms8HpENIPJ/lskTVcdEUoI6HKT1Fx5c2pPyEo5KC9oMvQSre6pVml
	 JutwZNhjRftunUK3aqJwKcPPaCw0GuzWqf2xghmOpCC8yxhsy9GQc8jWZjxKRN2X20
	 nZeAEMHV0YXZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] [v5] sh: select legacy gpiolib interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260629130329.1291953-2-arnd@kernel.org>
References: <20260629130329.1291953-1-arnd@kernel.org>
 <20260629130329.1291953-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:12:32 +0000
Message-Id: <20260629131233.32DBB1F01566@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Many board files on sh reference the legacy gpiolib interfaces that
> are becoming optional. To ensure the boards can keep building, select
> CONFIG_GPIOLIB_LEGACY on each of the boards that have one of the
> hardcoded calls.
>=20
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629130329.1291=
953-1-arnd@kernel.org?part=3D1

