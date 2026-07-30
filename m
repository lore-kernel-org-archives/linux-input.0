Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792946D578;
	Thu, 30 Jul 2026 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440978; cv=none; b=RdNL2GIH9Jtsdgl2FRfC4feiJWxcBgrHs5E2HEjM384Aa38b3XpyCX9AXGyilv26DaMFstx6D9Ayv86xmqaiRL4ehmcEwJZiSCn255Exf6r3ktSv66ZpEho/PkZA5ZNWOxB0gReAmFT7hpFSDfsY5qEWgdJeK87Fb2KJC6jlgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440978; c=relaxed/simple;
	bh=DmJPtAysp709Y2CnVk1sHYjZws6rXevfNZSuuVeapIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTj0Y34s2OQBjAwx1spi9yb/KzApXT88SxeSS/mqrHUIeRtIO3OJL8eCTqNb7h9Hsb4TnhTH1eFq6nzs9AdC6My0cckhoy7+5F+GU5EtjX3U7gBlsKJczoSUq+eCzhiT6fdpOriDEqByQ8fmpr5DkqeWdtWOmdTG9mBx1VH6sOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VGt5vaKV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VGt5vaKV"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BFE7141BE1;
	Thu, 30 Jul 2026 21:49:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yS509kLnw0Fy; Thu, 30 Jul 2026 21:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785440968; bh=DmJPtAysp709Y2CnVk1sHYjZws6rXevfNZSuuVeapIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VGt5vaKVGChiNTua3C3ICymzxLmglYa1GdXrhKbaV7swVPez5BoQvFoveKzyYcuiw
	 ja6huk+g8zwtlInhPraunlDr+dfVrCU6weop8sARxYMrCjTQAOi2AtIUuWcg86Q3dD
	 DVcJXpbHKXT6eAjjK9VrD+sEemiTseHENXjF6yoKqFGGRrP7GNoRXOTPEQTZwDQ7NR
	 SV763nkYfmvaCRZGo5MPkrpz0mMlwSQFOCjustUTc+pGoUdwegvo02Oqb++7hFMKR1
	 4w05qJ2V4r4xjTW1oJ+Zvch6p2UefSgqclYcrUgvi9YxxVUCtMswWJ8MCDOliEl/4y
	 LSxa1+Wh6IyWQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:18:25 +0530
Subject: [PATCH v2 5/5] arm64: dts: exynos7870-j6lte: set mode 0 as default
 for zinitix touchscreen
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-zinitix-modes-v2-5-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
In-Reply-To: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
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

