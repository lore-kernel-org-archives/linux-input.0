Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31A4F85B1;
	Mon, 21 Sep 2026 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014989; cv=none; b=MBxAu7y6AGWZy4b/YXaFnD2VE/EtbHz3T+GFEoGabVlelP4feTTM562HTtYHPrwkS8er96xFSMl75oPqiwOhKGVTLvfAeUwxN/2XX0STWKjeiP91ro7kgh/xgWL9rBJb8kumEnDnEXY1Qwtbl938CAk34MrwZY/LAei9cwhh72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014989; c=relaxed/simple;
	bh=rO/H4zxRJWijL2XrpP2BhtNedFZc7PUyJZ2NzpwnEZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKTMJRCme8MPrMAfJU9ys3Oh6mdnblaZxeozw43O5fZbHwb5Fn9tqu+bSVAmLdozRt91NA1Rnr4i6x60cndfot3eL+lSw21wiT94cHtlQ7tFTDgmOGfTOOemKaN2OdPTEooDG3ObK/PxgDwZqVwfRIsH1vrIOo5jCYd2FYAXwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oaa6RZEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oaa6RZEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF301F000FF;
	Mon, 21 Sep 2026 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790014987;
	bh=rO/H4zxRJWijL2XrpP2BhtNedFZc7PUyJZ2NzpwnEZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oaa6RZEcAW1kIyaqqlyztwaifquTpV30LiSEeq4JQsinKWTFCRc85tV8lkBfZhxpw
	 frs8uBRj1eFJYgi0KBUygfqI0Jqooh2bZCNeT0vvxzT6Av5HYVZQ0LbxzvOsli6pSl
	 NCXESRllMWFjnT+Oyly8Q6ZKAd43FO6UBtvEcutVawcdENogf0H0EjlwQryfSEVDvr
	 zfpviNZyqO5Hc4swvzHlxpedeptt5hzJnKlGmju3b/z5G9ScW2FSdVF44tjHK3iqUX
	 E7S3sfDzoU+XgSIkTPoGQdSpC62/L15vy1iJ8aZfuyfwMnI/Ds2jCMUbSqp+1gw5qR
	 f/GJHtMp6cBXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/19] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, lee@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-4-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:23:06 +0000
Message-Id: <20260921182306.EDF301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the compatible for the rpmpd found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D4

