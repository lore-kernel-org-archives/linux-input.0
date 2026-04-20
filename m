Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652C38F235
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721074; cv=none; b=YTEzozE4gT9L/wKgGyal+tVrEZJmQdIaFIS6XrxN3qw30VyCM6mEaWN2cKvLd8uwcl4INK7g46B11OdjW5YlUFwPuNZS6QYvdKNEpHnjMTsvFAnDSNZswNTUw4ncNFhxabH8QryHjiaxmeL9Q9nfj9NG/Bdgx3MIWuvYstEx0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721074; c=relaxed/simple;
	bh=ONzx1TVLssQ2quIYxWPdg1+c0cg1jkFrd/S0xZj62AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNtGGpIdxtQme6AW7I2hyNeLSL0lXY97XKZSJYQJ2VaSVP5qRIGCaTOlAv3RPzo+o4+8/BNPIchaqVP11zwp57iWbyWNJL+gjNDJs2rMePm6AX7ljKC3MPpAZPsfRzDPLTu/fcTjKes6d+Sri8tYEu5dCL/2laPReAp/opL2ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgJXUVJ+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgJXUVJ+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so31274025e9.0
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776721070; x=1777325870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkjylHhPY5Zp4sZf/mKL22KMI1gZWywJJ0iSsDcvxlg=;
        b=AgJXUVJ+fQmuigUW1WebP5+JaMMx3d4aUe08m8Doio5aOt6APm25qQce6HDe0zARmY
         LqVqjfYsainkg/8xwx65gRR8sT9iF2tMkIrjCp//0gFm6MAjkQS/k9KmYdSTBq23Pev6
         +m7+MOMHzXVOmwfUYWT1amQYoNJj/X/K2DNrbbnVnWikGEV/MNDiEjW7KXw/JFlqiDQ+
         5hbJ+SgcCr0jv+Znf3Pq0NlfkcxJi07VUkTq6BD6lC5i8vY0n5UfGjD3daLm8nK9rIAo
         ipfdJ/aqXuQX+YDdm1obiaNrBZY4uLJwj1yi7FyBstyGmkI3y48dCCZrG25uvReFt5n7
         UPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721070; x=1777325870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkjylHhPY5Zp4sZf/mKL22KMI1gZWywJJ0iSsDcvxlg=;
        b=QZIz1zTd340SF0H7FAyvRTFSjVDHiir6SDMpP5jSo7kk5FFbgFlPH2YytK1QiiRH/K
         DeJwwT2BUmMgfxIuvrHzo6PWnkg0YrVeq5Js/yU9e+GUg4Eev3J8qDSWSy58iJ5y3wmo
         vvveqSHFhYCYDmw3z5leG9/NgOYDcvjRcu5e1kh1x4WJ+LiEjQ/plQoQo9FrreHKZRnf
         bwNTqt7nTd0aRZ7vmuVGDPxfi3bCh2cbD1wJ6pDK5RZl/ntb/2zMLZCiEyoqkLyIEdDY
         LMMCNBWzccnnsC3vioZSLDdvv3dUR5bwIFreEvDSSh442HcdJkz1yGbp5QWE+JBfXIRK
         IL/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8tggsT7NA/b85+3YrWYGDv7SXiIapTOvuxR7FGCJCTcYAZaXK45FCXsO4HMNJAkpKSzcuxYyEfRqG87w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiq6ajlDbapBB1grKDV4XJ6wdva6lbXsyIKKcsOzvTZR4BG2d
	TqaOLcRhvABuj+XFqYoFdwg8k5mEsbxduLsERu2yDLotpUCRLKQU/U6F
X-Gm-Gg: AeBDieujKdVoXDC/3bRm6jkEmmXFciX++hE9pPAKuJ0+2gUetopaE9oFeMhxbc6dGTK
	Im1UzQS+FJq4IuH94YPFUveXhk1B6rT97SvTFoSBHJTcIM3Kr3Fpe8wTCXkMzgxa+QOzYJQhlxF
	gaOmA6IeVHY+akekR//VjdoqWPWAHJSbivrRqKdOfr7TijnnzOtlrmUHDrtQGCDE5VUqE1MHA6O
	iPRgv+HZQ8Kzfl+Py0lKk+VJJpzi7PLC/r9ZH80iKxiYJHRzdhoRwtykxMLqZzdum+EcgrovS/V
	oaP23Hs1/PcgtkR5A7GBKbRpQovn10ONSEOtv8sG8UBkHIwOut6wTH8sC4JrI3Qj8O+kk/mwysF
	0ZwVGe+Mfk91rGQsgJkSBFM9eLesNqJQZrm1fn5FPjGwVVcS3sR8loFLyP6o2ONGAVJpCGxdZUp
	ntXw40DX9/YkvT15tSnGD1hNx9jadZrg==
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr178338515e9.21.1776721070421;
        Mon, 20 Apr 2026 14:37:50 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:37:50 -0700 (PDT)
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v5 4/9] dt-bindings: pinctrl: mediatek,mt65xx: Add MT6392 pinctrl
Date: Mon, 20 Apr 2026 22:30:03 +0100
Message-ID: <20260420213529.1645560-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420213529.1645560-1-l.scorcia@gmail.com>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
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

