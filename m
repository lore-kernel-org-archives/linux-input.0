Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F534137A1;
	Fri, 11 Sep 2026 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117003; cv=none; b=gaEsvZD1GdMrMEWDpMbtcJP1Ed4wb/ZKYwqvKpvLGH8P2Gk+SY4jh4oqbbq2JyGkESeqcPLlkdCOMY4uY/mG44qYzRr7/LAvJNqEGG8bKDFnEUvHtgiXPXNlrl+jofTHQ/9Wqm1lqoKS5SLNw09JZ59M4EAAz1jthZ9XVJpkI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117003; c=relaxed/simple;
	bh=CgA1Xsk4ixk8Enne9s1FJDyGkyhfswytOSbwAT3UYaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GR81kfn0jW0WtuD0iwWvEQ2lAwljVu69HlPWRQLRW/jUDtZaCJTaxoD05riTcEfQKbJnfcEN99TR8wDULf0lea4AiChFfl6aV6QroIvaM021JPj7C13iNk6xgn3K6LXRuYKSUNXXEairqOFonOgnPuH+lDe9XbcgJZtbHFZ0yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QssYDKOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QssYDKOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0380D1F000FF;
	Fri, 11 Sep 2026 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117001;
	bh=CgA1Xsk4ixk8Enne9s1FJDyGkyhfswytOSbwAT3UYaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QssYDKOfAtKgIlx5YkQFsqEdvYJYFdqrqKCwpumo+a+jfd3oNId8LibZwRPDdPG7W
	 5NuFDUVzKwMaAdK7uGxdV2PRJLMerjtrEq5exU6VL8BJnqRxeFXGU5LAXzDHRfzXYN
	 IT48UeWKO+ktVKDqxyyfBm8SjF2GvjgDAUiqmo1d47I38C307g3LKOZ3AFnW+YHIm/
	 Nr0hRb9gCfElIKn48OIe2nUwC89pb6bXMKwQWtvX7nkxJUrmUvFVE0KxrZkFoU0g7e
	 BZVv9N7jz3DI7cHw4qXP9+6eMRV/Zhi3V9g/Xb4n+fXMwqkQUj9wOjLXpFUbmM5EkJ
	 0WuWcaS9RP5qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/10] dt-bindings: backlight: add Kinetic KTD3136
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-1-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-1-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:56:40 +0000
Message-Id: <20260911085641.0380D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>
>=20
> Add devicetree binding documentation for the Kinetic Technologies
> KTD3136 3-channel LED backlight driver using the official "kinetic"
> vendor prefix.
>=20
> The device is controlled over I2C and supports an optional hardware
> enable GPIO line (enable-gpios), supply regulators, and standard
> backlight brightness range properties.
>=20
> Signed-off-by: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D1

