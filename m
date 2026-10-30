Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338038;
	b=zY9wb0lE7566sHCQBtlMx944WyfRcEUBCCr5nMMBlij6THnmZgfWvy5F7I6OEvwXXw7Y
	 6jMgd4CB3PfWDtMPWqt4Wi4pMF2vtGj9m5ZAKMNf1BAl8l6vXzIWBqxOhTExy59iS+NKk
	 eYo6KD7gx68TaljlMccY/CmB2w1lO91AOReJRXZHX5VxJ/YQabaTRNtqWgNT2GD7jGPNx
	 +dn3g8J356bKdYfK2E+8VbLhiFhcBPtg+83/PdjSUVf0yJeVkkjqxx6jD1O1RcPVZAe3q
	 /pcwk9WLjpc7yJd/zBvVeewfGQRj2Ex7GIVklUQa+4lIqxPezs1bW4yU9meCSXytjAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338038;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eRlwcNfvDKd1mRWFF0W7ijP4nXr2Q3+Wk2/EB7O7DRw=;
	b=I/9oKdnIX7kTBl4OurEXFWZ/Hmdbv2ZIFf/FHbUeH44Ft9nWEmHBz88Sn0OJqn9WvvNN
	 SLkoe8pZgutd2uSiC8Rv4Boko8f8voRuRrOtPx0pb4TBpK3Y9IRqV7/F3115YOe0t8NNX
	 UHoCIYXM79eq0Ic8HkQsE6OiPBhkO3COI2i00jq0X/Jv8cKoL4yTC7HvWnRmF3vlKBgil
	 05grRCLEyZsQHvg2/i3mEDAS/4VpywO5MYWcWyormC/SYVVK4w1QQMOHP5W6+Jj7Opwtr
	 IdPM34mAARr9b2od+oQsMbYIRHgcWJ+8k6b2nvZV+Zp8L4qh08kcgsVlu4XQ19WXuxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=A34qUxwI;
	arc=none smtp.remote-ip=109.224.244.18
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65637606A33C
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 05:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65637606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=A34qUxwI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793338030; x=1793597230;
	bh=eRlwcNfvDKd1mRWFF0W7ijP4nXr2Q3+Wk2/EB7O7DRw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A34qUxwIgBqB/T4qStwJMUOzoNX19bqYtt8mO9T8jloOODfh9ejGjY5sOmh63UBSg
	 yX0L0fDzunGi3WprTTmJw0cppc/mTqihl0zpUGzOLrqKnMd7oOss2qLlJMT9vYF+EU
	 qvljCYT0QNTiZIvIQ0TYFbf6fQibPrqBWqDL3BvkLJMnqaKLlaYTU8rpN7XGAbjM0v
	 rGSiOr21Tmf8Ohfihn+izkTJx/sZvUYaHLNbzb5a8qxsFevXYxUB+rth7/Ul2PLRl0
	 pNAz+3aj/I9sRV26mBUAg3rZlSkA7h9Tsa0qCMt33mXBJPT8KnMR9ry/cElw3OEgAb
	 oQ4K+6/0xLDFg==
Date: Fri, 30 Oct 2026 05:27:07 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH 0/2] Input: add support for the FocalTech FT3683G touchscreen
Message-ID: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: aaba0d66cd2c899477298838f60b007c5a292e08
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series adds a binding and driver for the FocalTech FT3683G, a
capacitive touchscreen controller connected over SPI, found in the
Nothing Phone (3a).

The driver skeleton was written by hand, following existing in-tree
touchscreen drivers (goodix_berlin, himax_hx83112b, etc), with the SPI
transport ported from FocalTech's downstream driver. An LLM assistant
was then used for cleanup and best practices.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Alexander Koskovich (2):
      dt-bindings: input: touchscreen: Document FocalTech FT3683G
      Input: add FocalTech FT3683G touchscreen driver

 .../input/touchscreen/focaltech,ft3683g.yaml       |  74 +++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/focaltech_ft3683g.c      | 365 +++++++++++++++++=
++++
 5 files changed, 459 insertions(+)
---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261030-focaltech-ft3683g-dbe5c2a7af93

Best regards,
-- =20
Alexander Koskovich <akoskovich@pm.me>


