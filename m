Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459A42E41C;
	Sun, 11 Oct 2026 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722888; cv=none; b=olNsi2zXI/rBhB9Ok758cdfZSDyNG8zjYx9sE+QOTjgsV8VSSSMOvLbT0BAPZlY6+SEqp/onVNFm1OO4hqpNYW2R189kTXx2Ram8ODdil0DSuqvlnR1TbGdLByxb3MfB3QLQWLrlSKzX3v+4Keq2tJKyQ8Msv+FPs+kAzd9cVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722888; c=relaxed/simple;
	bh=FVagz9OeBj8j4XmlhD4l08rm4xxXZfmZ76F8m5aoKe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DENMPf9IBX5unMXq9z2y58SzM8hojfTBFtVBGwTrfIOqKEi6EtQSGeiY+wOmAj2xWEhRqDl665LEVaYwOVx08M0DMRTN4sq2fRiZEG7VaSn78fRwMKuZHea0xIMKfpikxrHRY4MgBGCIjSjLS8oG3qIQeC0YHyxZDJSCY3vycxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=cC2j9Uq8; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="cC2j9Uq8"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j2gPG5wGFzMlV4;
	Sun, 11 Oct 2026 14:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1791722882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tc4V+xIZtbnNtu5VuNlUkSpZOtINy4fiu5ZiuvxwfGA=;
	b=cC2j9Uq8R4rOsCP5BCh3EOSK1t1KiZFkMhQa2xOCAQTXCvZKr/QIQ/IM8kvsjRs7hJPwpG
	8NrLkgK8+R7ZN/SnudOBnx9RaefUl7j9mUCSGlbKC98rIZ/PY/0b5kPeJGVBdXGB6l2Rpn
	cEb/akNRy4CLhptt4xJid1pM34bHJVF9RQPXCg9kyfQSxu/9ElOMaxJvWWcNPpkF4LQIX2
	7XxdSwPNYIlUGK+T3xAjfztysKSc2u3qDv3ecF6M0y+PWvWfjPGoithBiXrKulJ1AxvEvj
	sXUGtyvT8F0m+y4TpaYAM0p6BvwN6egM5+BGwhUkFIIgZspybLayVjR3JmNEnA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Date: Sun, 11 Oct 2026 14:45:00 +0200
Subject: [PATCH 5/7] arm64: dts: exynos: gs101-pixel-common: add labels for
 touchscreen supplies
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-lat3st-google-raven-touch-upstream-v1-5-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
To: Lukas Timmermann <foss@timmermann.space>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4j2gPG5wGFzMlV4

The Pixel 6 boards use different touchscreen controllers. Label the
touchscreen supplies so board files can reference them.

Signed-off-by: Lukas Timmermann <foss@timmermann.space>
---
 arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
index a12f2b88d72d..92b1640c0612 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pixel-common.dtsi
@@ -399,14 +399,14 @@ s2mpg10_ldo22m: ldo22m {
 
 			/* ldo23m & ldo24m are unused */
 
-			ldo25m {
+			s2mpg10_ldo25m: ldo25m {
 				/* touch */
 				regulator-name = "dvdd_tsp";
 				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <1950000>;
 			};
 
-			ldo26m {
+			s2mpg10_ldo26m: ldo26m {
 				/* touch */
 				regulator-name = "avdd_ts";
 				regulator-min-microvolt = <2500000>;

-- 
2.56.0

