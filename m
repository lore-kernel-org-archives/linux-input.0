Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBE2AEE1
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029253; cv=none; b=Y99cm+Pj8mnonsEi++m9jqceNcffbTg8p5TletMo3rjB0jvdoN3tPmr2Cfm1LDyo3UDibUcl2FbUsSVwmkRQbWY8GjbyeJnUwMpsMB06HtpUKqMPYaVRGYezodBWMvkhZaCLNTaQiWis/Knzdl6+a+dLsoVvG0qMFfYuZrPEzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029253; c=relaxed/simple;
	bh=5niFuhaxXfBK0qeGafoQwzja6YSMqYFni8n5iRoWces=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gxtw+K/lO7kNex3wZS5DF48GS/TdRQYG6uwLSArDtw9RPW3oCywMgePz0MhRUEo7URsAdR30D9MJz4LEqPzhiEKg5eUs5xvUaNU3eWy0n7hH+CR6+SXCMOG9xaz9jFQnuCRDeqswzFXO7FKhlT8jFQK1vQmX0MweOMYOPICbH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boQzm2Cl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boQzm2Cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E080C2BCB0;
	Sun, 17 May 2026 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779029253;
	bh=5niFuhaxXfBK0qeGafoQwzja6YSMqYFni8n5iRoWces=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=boQzm2Cl7a0pX6VJpYXcSqsb+uNYzUcHi5r7AtALXHU5p1TghpFQAB1jSl7w64/xT
	 1MOiSqQdttfK/IyTXNYuImbMLnVzcfMD/Wwr4jBdSjrATHfke5qTzXQeknNIj6UUtF
	 yKXz+WbHzvSV4G8uJAhilw0GNf6MrRSx0dO3sS3/91XXXr5BTLOjN77spzjrZOtwfx
	 NihtSROav0EzmvHb4PGDEGrlXjwzbnU9eDAqaTYPsmLK7ipnj1fY1s+4QPEMT9ajgY
	 Ilzfjw5UIpst6LwObtuHTiqVFQzy9jlrUZ28qR56krT8DV0iuMJo7/i5aq+F8MYIvD
	 fOMDsPLeoNXWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] HID: wacom: validate report length for DTU handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260517135215.2220117-3-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-3-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 14:47:32 +0000
Message-Id: <20260517144733.4E080C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete fix for slab-out-of-bounds read vulnerability. The patc=
h correctly validates the buffer length for the DTU device handler, but lea=
ves numerous other device handlers in the same function completely unpatche=
d and vulnerable to the identical attack vector.
--

commit 873407ec5964c67c8e302293e3be453a56be7e51
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: validate report length for DTU handler

wacom_dtu_irq() accesses fixed offsets up to data[7] in the raw HID
report buffer without validating the buffer length. This commit adds
a minimum length check in wacom_wac_irq() before dispatching to
wacom_dtu_irq() to prevent slab-out-of-bounds reads.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 6d06842b64080..873d58a6d5a3b 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3472,6 +3472,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, siz=
e_t len)
>  		break;
> =20
>  	case DTU:
> +		if (len < 8)
> +			return;
>  		sync =3D wacom_dtu_irq(wacom_wac);
>  		break;

Could this same regression occur in the other device handlers called
from wacom_wac_irq()?

For example, cases like PENPARTNER, GRAPHIRE, and INTUOS also dispatch
to their respective handlers without checking len:

	switch (wacom_wac->features.type) {
	case PENPARTNER:
		sync =3D wacom_penpartner_irq(wacom_wac);
		break;
	[ ... ]
	case GRAPHIRE:
	[ ... ]
		sync =3D wacom_graphire_irq(wacom_wac);
		break;
	[ ... ]
	case INTUOS:
	[ ... ]
		sync =3D wacom_intuos_irq(wacom_wac);
		break;

Since these sub-handlers do not receive the len parameter, an attacker
spoofing the VID/PID of a PENPARTNER or INTUOS device might be able to
send a short report and trigger a similar out-of-bounds read regression.

Should length validations be added for the remaining device types to
ensure all handlers are protected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517135215.2220=
117-1-jinmo44.yang@gmail.com?part=3D2
