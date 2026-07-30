Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DB3BB127;
	Thu, 30 Jul 2026 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442787; cv=none; b=tkMXIVc7PtLpp8PlCsJN53v9wQbtLB0nBoK+Lwza8jznm99lHUgVStFrmH3RFSi7MMknSyVSw4Sj9jPH80CaTsBJWsyMfdAVvuXp76OMbZ/xd2RMyf73/g4RP2FeFEKdYfEhJqm2yg3bnNStk0rzrqvk4yvckrOJgKdVEAQqqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442787; c=relaxed/simple;
	bh=PHhg4NASLAVp09IUcpWPeWdg4j/hYt2r4k+sJeoXjAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sl2RwBFSdSCCVd6xnTLM7nScZM7DdD3SnLrCll4DNBQjerlb+IHesn0xLlSnjGnTQiAcgkdZqdsDINDspYGv+klZYsn4+nEZBKlqSrVa3udNee4QzNSUBlP1WxnnCODqkhGFpB/mrbwPwwGkhSyP7f5e2PHH0bAFVPY6Zznp7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cItL7OfI; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cItL7OfI"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 40CC08468D;
	Thu, 30 Jul 2026 22:19:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RPTeP7d8JI8; Thu, 30 Jul 2026 22:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785442782; bh=PHhg4NASLAVp09IUcpWPeWdg4j/hYt2r4k+sJeoXjAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cItL7OfI6aoZel27BS3cVDgQOPc9T3X0eCQnbv0q9fdYRp54bc0B+x4c4Zx3iQYvw
	 JBV/4h2kzJNa4Vfaq0lavee50pn9kEOCWmNk82afEU5vNyKUFk+L7DexO5soT4AwlJ
	 YYtoRgygx2rXuNAyf5liDbbV9wgzw5QYVRwnQnviYR72pNEanftpW/jQMZ4zdRnq61
	 TXLfMIrDUJNFN1+h18bpHDVoT6LqN8ahpBEQzlm6rb68z5wKmz3Ce14+WF8n8o0pLY
	 roZxoTBmndDTQBAXdryTV1lpu/F+Nyd0byTwsCVOUH7tCrWew4ktWO2fOf/8fCWCIs
	 zyYUEgOOCFzEw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:48:38 +0530
Subject: [PATCH v3 5/5] arm64: dts: exynos7870-j6lte: set mode 0 as default
 for zinitix touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-zinitix-modes-v3-5-2c8de712997a@disroot.org>
References: <20260731-zinitix-modes-v3-0-2c8de712997a@disroot.org>
In-Reply-To: <20260731-zinitix-modes-v3-0-2c8de712997a@disroot.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
 Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

The ZT7548 chip in the Galaxy J6 is actually able to support mode 2 (the
recommended mode) just fine.

However, the downstream kernel driver utilizes mode 0. This creates a
problem in the aftermarket world where fake touch digitizers only
implement the bare minimum functionality, as used by the downstream
driver, to compromise on cost, which leads to such chips implementing
mode 0 only. To ensure touch works on those devices, set the default
mode to 0.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts b/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
index de30d0970336..bd8f798c9810 100644
--- a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
@@ -424,6 +424,8 @@ touchscreen@20 {
 		touchscreen-size-y = <1480>;
 
 		vdd-supply = <&vdd_ldo34>;
+
+		zinitix,mode = <0>;
 	};
 };
 

-- 
2.54.0

