Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C23ACF11
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859735; cv=none; b=k6OYJOQyWg7rbN4aUA717e9CqKmPunJBwYOcDfb/LlnyHNJaS0vVyzb7O+w0NzHo7oG+h59e+rIsw6LO6q/xGwasutg/Tisl2yghBV9rQRlLYuMY4ASezg6ebRq4c7QAb1Au5TX7nD0V3dkYDjSnGHk5Yy3x/99y77bTK7Isunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859735; c=relaxed/simple;
	bh=ONzx1TVLssQ2quIYxWPdg1+c0cg1jkFrd/S0xZj62AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZu8SwdtrRLlxD4lofjz3xqMfY4SvajLFbGpvCI64PW1+P44dK+oz4TUhx73L8y3kXFMl76LRc2zV4oqt6n7zgF2yfs0WFCR+7XpGsXW1LK/JF7y8DDggT56yZwYmGNKzOTzUJImLyYRWFgAnAv1BgzsZ+xvdtu6SgI/3pLm47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbIEsTDZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbIEsTDZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso41804015e9.3
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859732; x=1775464532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkjylHhPY5Zp4sZf/mKL22KMI1gZWywJJ0iSsDcvxlg=;
        b=BbIEsTDZAtVb73SWB6Nkqu4a0ZA+v3kvpheaZRxCTN4Po9yd814MppkCEN+rfO6zDf
         ezrUMYG2tyDzeL2GfFE+nepIoDWy9OyKxFYOAeP5q+GBkyirc3SYhaNQl9/fneZ3wpgU
         Q5mYSlG6oP+ijVVmRHvGNIk0oBplpKeUbvfUSrXr5aiwmTT2Ma+82d0DL4tWuI2w23u0
         s87CDDTNBrL5A/j9WlSguwj4oavylv8SVhM09/6Fde1OLqiRt2rAYkYwHfvXNJr6YKp1
         wmThaHLOjqUIlZaMVCoNab2HxJ5wc93nDls5B6aLU2FrW6f8DmzPuqB+mN1KG7k1kW1B
         Zp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859732; x=1775464532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkjylHhPY5Zp4sZf/mKL22KMI1gZWywJJ0iSsDcvxlg=;
        b=EkJ7IH14D9WFHVfFTiMs8yhu3dR6d02FTjP4eKTl2FE2Bge/Nz9Ua+m1Pn/3iVMGme
         l+dX7p6Z9kUaw7Zr+j/eNLF0J7GRcpNP9NbLaXUrjfPt6hriBEaEp4P2MaWomx4H3Zql
         EFAa4uBw0Dvff+jFXW5nwmqbXdE3j7S+fw3Fd2ShnZj+Z76riGqCeMsHvXfk9o+Mjysx
         /esGCHaPCrA9mmLTggksPwq9l08k2JO6wprlSW2m16K3ZgrjI0epI1zlzOflMPmwip9B
         fTweqFkpKzOs1E0vTd0BWTlitq9odaybi0+aY28lbi4JpxGU5RTC24xGqgHFQTRGrb1L
         2hhw==
X-Forwarded-Encrypted: i=1; AJvYcCX8BGdX7e3uXi+uj5F3+eNiPqkzHnMUo+SWfeWjGvrxr8Xa+DF2g/TQm3H0mH+8hx0oeFN4gAM+k8cePA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOohwAaO3+/zm47RzmSAgZWHcKfTZdXONwXpMXJkq3U+fcquRV
	O0wAkUJwgwk87Z+XfXufnDkWHUNX1Flxj6pBJNXoCNCblmuwogu3+1UE
X-Gm-Gg: ATEYQzwRZ5aUwK6RSy+PvzMXr6FW2sxPB8n/dqTT/NFAZq3hk9LOnI/ALIM4Lo1EAbg
	79mWIuD9eXz0zSvpWe0iSclw7T/WkMRF41xxB3I5fAIRRrZ+FXURFi8NjRrV6ZAHpU56wCso2nt
	FP+EDrnJok7dQGQKCVynTz3ALuG2hF77ww/2jonUp91Pt9WF9YW3Wc7h6kFMVlzBwE9TycsovIh
	+mKhpHB7a2Agizeh4DDzJ2+JiHHYDjWDMn+UWuP619qPGrUFuS4KsommTbB+cG5pgTJoiEg4+iI
	NqrX4LR59jJixxoH/xxS+S2cAdPz0JVzkC3V5Ibk/VmefDrI4FYLC6KYzhkIX1tFYrdMi8CLF+C
	+wFhLekKJCMeTGjYiqqyDrFYMsntHADhXbXt/i34d2hH6T6f+dlnWczMNkM3kNKNYLMgJrzXhQc
	fvO+mF0GhSsxrlVfSL3qY=
X-Received: by 2002:a05:600c:4744:b0:485:2a4b:7bc3 with SMTP id 5b1f17b1804b1-48727d5d6femr189659945e9.4.1774859732245;
        Mon, 30 Mar 2026 01:35:32 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm508329995e9.2.2026.03.30.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:35:31 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Val Packett <val@packett.cool>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 4/9] dt-bindings: pinctrl: mediatek,mt65xx: Add MT6392 pinctrl
Date: Mon, 30 Mar 2026 09:29:38 +0100
Message-ID: <20260330083429.359819-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330083429.359819-1-l.scorcia@gmail.com>
References: <20260330083429.359819-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the pinctrl device of the MT6392 PMIC, a variant of
the already supported MT6397.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |  1 +
 .../pinctrl/mediatek,mt6392-pinfunc.h         | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index aa71398cf522..1468c6f87cfa 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - mediatek,mt2701-pinctrl
       - mediatek,mt2712-pinctrl
+      - mediatek,mt6392-pinctrl
       - mediatek,mt6397-pinctrl
       - mediatek,mt7623-pinctrl
       - mediatek,mt8127-pinctrl
diff --git a/include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h b/include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h
new file mode 100644
index 000000000000..c65278c8103d
--- /dev/null
+++ b/include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef __DTS_MT6392_PINFUNC_H
+#define __DTS_MT6392_PINFUNC_H
+
+#include <dt-bindings/pinctrl/mt65xx.h>
+
+#define MT6392_PIN_0_INT__FUNC_GPIO0 (MTK_PIN_NO(0) | 0)
+#define MT6392_PIN_0_INT__FUNC_INT (MTK_PIN_NO(0) | 1)
+#define MT6392_PIN_0_INT__FUNC_TEST_CK2 (MTK_PIN_NO(0) | 5)
+#define MT6392_PIN_0_INT__FUNC_TEST_IN1 (MTK_PIN_NO(0) | 6)
+#define MT6392_PIN_0_INT__FUNC_TEST_OUT1 (MTK_PIN_NO(0) | 7)
+
+#define MT6392_PIN_1_SRCLKEN__FUNC_GPIO1 (MTK_PIN_NO(1) | 0)
+#define MT6392_PIN_1_SRCLKEN__FUNC_SRCLKEN (MTK_PIN_NO(1) | 1)
+#define MT6392_PIN_1_SRCLKEN__FUNC_TEST_CK0 (MTK_PIN_NO(1) | 5)
+#define MT6392_PIN_1_SRCLKEN__FUNC_TEST_IN2 (MTK_PIN_NO(1) | 6)
+#define MT6392_PIN_1_SRCLKEN__FUNC_TEST_OUT2 (MTK_PIN_NO(1) | 7)
+
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_GPIO2 (MTK_PIN_NO(2) | 0)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_RTC_32K1V8 (MTK_PIN_NO(2) | 1)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_TEST_CK1 (MTK_PIN_NO(2) | 5)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_TEST_IN3 (MTK_PIN_NO(2) | 6)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_TEST_OUT3 (MTK_PIN_NO(2) | 7)
+
+#define MT6392_PIN_3_SPI_CLK__FUNC_GPIO3 (MTK_PIN_NO(3) | 0)
+#define MT6392_PIN_3_SPI_CLK__FUNC_SPI_CLK (MTK_PIN_NO(3) | 1)
+
+#define MT6392_PIN_4_SPI_CSN__FUNC_GPIO4 (MTK_PIN_NO(4) | 0)
+#define MT6392_PIN_4_SPI_CSN__FUNC_SPI_CSN (MTK_PIN_NO(4) | 1)
+
+#define MT6392_PIN_5_SPI_MOSI__FUNC_GPIO5 (MTK_PIN_NO(5) | 0)
+#define MT6392_PIN_5_SPI_MOSI__FUNC_SPI_MOSI (MTK_PIN_NO(5) | 1)
+
+#define MT6392_PIN_6_SPI_MISO__FUNC_GPIO6 (MTK_PIN_NO(6) | 0)
+#define MT6392_PIN_6_SPI_MISO__FUNC_SPI_MISO (MTK_PIN_NO(6) | 1)
+#define MT6392_PIN_6_SPI_MISO__FUNC_TEST_IN4 (MTK_PIN_NO(6) | 6)
+#define MT6392_PIN_6_SPI_MISO__FUNC_TEST_OUT4 (MTK_PIN_NO(6) | 7)
+
+#endif /* __DTS_MT6392_PINFUNC_H */
-- 
2.43.0

