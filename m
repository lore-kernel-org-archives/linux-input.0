Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219343793AC;
	Thu, 10 Sep 2026 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011656; cv=none; b=FMej52wpljOOjUyH+JbEXKv6ivtYIjsO6AhxQN4WhX3+Qi8GPlvUunMGNb19uoUWTHLBdewZXbBg9GLmKI5DJiYA5XZSzLEJi5Z4cr5Y6bk3f/WdMfNEAKW0nywNsoy2/4IIbWxu+2UxqsdPO+SXJUSGPSJKociKmPSs1F5I61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011656; c=relaxed/simple;
	bh=vsxiOMGmzNrns89vxf65T+SGvDFblVioojr5DdEfjC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gBVp0sDgjrO6SBHwyFZFCXWaRA7gqoCNe/d8p0dV5iTNXMC5pUuztilN1NcQBl+RCga6p5rz4Q6P+g4KH5gpie88JKtK6LAKxxAk9oToC9FY6Rdsv27ZuqLAfBRCP4niZV75HlOcnceXX+7ucfoDxxHfRblwyqFwd1pLMulJ7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwfFuOOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwfFuOOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627791F000FF;
	Thu, 10 Sep 2026 03:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011654;
	bh=vsxiOMGmzNrns89vxf65T+SGvDFblVioojr5DdEfjC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwfFuOOCqLz1tVlRQtS46kiKLs15kzU9jE7/r9VNwV6MMIW7ZgAaejmakg9uySoI2
	 FVPOrNtayi8HrGgV+Z3CQIle+j09j7HIMQKPYJ51amcdTBdqRXFbV9KlaKf+N+i+V1
	 cLhcZa5o6XQLQCKsMoTQKfpNWAPEalSiI+HlEO+g5rCGYNwdJeVxt7Rxy8i2oT+fAa
	 bI1qhWEYwBl3gUCoNgKaZ7LT5E8VkoX5vOauMs5/gs4tPt033aqHloArqlHquoc5wU
	 O+qu0RD/y+5Gf1HKmSg/SBn5DBJcSr0ohAsuT2aHpSKsff26dnV38lOYGuwbC0pxaD
	 FXQQSyUfUpa1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] HID: hid-oxp: group declarations and protocol
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260910032115.28669-12-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-12-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:40:53 +0000
Message-Id: <20260910034054.627791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Collect protocol definitions and helper macros at the top of the file,
> place the quirk structure with the other type declarations, and tidy
> configuration field ordering and callback declaration formatting.
>=20
> Keep this cleanup separate from the preceding behavioral fixes and the
> new-controller feature patches.
>=20
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D11

