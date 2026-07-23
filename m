Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6641A922;
	Thu, 23 Jul 2026 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834702; cv=none; b=YTSGmbLd5i2VAcFcHyiGs1/MH1Cq3qS5xDBvHq96TGt5Deo7b2Exy/8nnLlGVnP3VuKW+DMpaMj+oR0pqKZxQIhPoiLcsEekIO7NcBz+3unm9Y10Bl7U+VVdS2005D1tlsVD0Mz6VYYsTPqchJn4bThbehIoTeR0+xCxCTbORM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834702; c=relaxed/simple;
	bh=DmJPtAysp709Y2CnVk1sHYjZws6rXevfNZSuuVeapIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEQW9CfdIy5QeV+pEbaCqyd79Z1JYZ1Hcwr2luOg9drSQeHNVnk5dID4Yq7TQBBQ+PWIzKOZNMtQit+wAzaT31iEuE1zJemqp0yEj3HapWzuVrajP/8yXYd096v4oNPSowylGCpGuUIateRpaByiHrgpr5GbLtWNZEXpwZWpx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OMArMF+Y; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OMArMF+Y"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 587388005E;
	Thu, 23 Jul 2026 21:24:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jwqy4N3yN4_h; Thu, 23 Jul 2026 21:24:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784834698; bh=DmJPtAysp709Y2CnVk1sHYjZws6rXevfNZSuuVeapIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OMArMF+Y0VidHl1WBfhFAOGK2iB01e/08BE/oT0emnrLGJxLYSlyn+gRUEMeUWKgA
	 HWqAQeyUdYMaemT8A2XY6qOzpI1ojPZilyKv1SX06HJUF0crwZqhkJBvsBqNSbFkEl
	 kCh7sE/9TeNrOKSdJ0y4aTXjBJm528X5AF9bGVbJlGVuuLdbHQTi2HPpEXphPEq+/7
	 vLdvEMgYGFdc2zXRf+hZUrf3A87sltZEqhSxLo3Jes3i7lPm48IqVoQY9RhGDAHkYq
	 1uFAn5P7uYxGX76JxbEEKzjLamHKiLyTIcH175nnHwz59vFy/A8w+3Gyj89Ez+H81q
	 QOxJ5GBdpdSjg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Jul 2026 00:54:07 +0530
Subject: [PATCH 5/5] arm64: dts: exynos7870-j6lte: set mode 0 as default
 for zinitix touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-zinitix-modes-v1-5-f6df7d86a878@disroot.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
In-Reply-To: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
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

