Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6B2641FC
	for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029830; cv=none; b=tbGIzVhWxK36WZxibKmIpv6Cg4in3KRqfIDzGhneEqHAjS27Ux7wrDrC8x9S2SaLIbLpCIFqRZq0d7EwKjvwQrUkyHhIpKAeoDZEREBe/E4p4trcNRE22qUOPFKbA4Yxeb9lPKWB+/WfAsHr1ZldnxyAW7yW3ApsKOD5Qv2o3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029830; c=relaxed/simple;
	bh=sTYWyhrbRxDuU248Vbf8GOxIJr3Ex6NE3P/1VQewdNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRoBp4CFv0MLlD50Mh2WwEAt/o36iQghSQiGTS9cZLx1prVua5Z6KsCz7UinMP/G4rBx7zgHNfaIZ+DGHjBN8VMBxiGlrV7D32kbEw5ADao5JJj9nNkf4CdlTHEs5t4fve9hVKDtpWTCMGEOX/nH+BA1xfa9B+KXLpyRleOve0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSQkeJZG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSQkeJZG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so25448485e9.3
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2026 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029827; x=1782634627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FtRNx41kTzSfvca25trEUrc2fj2TZslpJ/VXb0q1qg=;
        b=QSQkeJZGYd2PUVx6OhB0gS7PhoM/ID7JC+FWnjACDIs4qibPsqlpcT0CNI2JK/86u3
         rCTvsw4jvpON3qJUwZ+UGXpQ9or3l79yD23knsx6XVeUuahA0+Y2qBMG/1zo2wqzodju
         U/a2x3fHU7GrkwttrfLWXTsJAf9SWpaD1gaMVp1DjAgpkl6SIW4ZbIF+4XefZDgQCn21
         xAwydbrOmiB04KYVwbnXsEB3bXNVWqj7iiKRyV+jdcPIB6BgQXJ7FYfHGYLK4f0BX5At
         S3VPLOisDlu4knB820Xx7Pi/ecwsCZPUZdPWQ/NZoOWPBSC56nqpqHEuk9INBOImdmpk
         F0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029827; x=1782634627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FtRNx41kTzSfvca25trEUrc2fj2TZslpJ/VXb0q1qg=;
        b=BTXtTIlPgEXzee2NaTJzY/3hPq2DW6EcvgVxVdJKqAlChM41Ps3OYNE9F5MoYTC0QL
         A5D1QibtWGs06DjMG3IHzHudDUzhlercyn3/JxvisZUrwBsST18x8KGCyMU7VfIF1QWE
         +diuWV762EKKa3kXLjEeio38kuKzvErmtCsE1X8x11LhXR1R8twA04cbIvHUYEtAv37o
         TZ4ctqJuRdzv3maYuDQzWP4aHpg/fH9WFeh/462i5+cdv+d+54TDxpUaItYPXdVw9WKp
         tzcVci8TXOwXK/WLC9mnNgKj+7+694Qu/OKWE7GMkFYhDfHXUchZ2tXqaDYW10F4LIJO
         cQEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E9abI4JpKBwDtx9vnRtLOQzFZZeahLZIy59W/MEsUbPwEaeJ4zRvqel43BVldRscHwffCzas5v0sl6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlduQPXPFqlEIHN96Yo6/b+qMd6bhJlQ9EwL8TcRI8o1STSF+
	AdM+mUMOndahXlJrMdSskiXMNmXLgOe7JXfc1eq1d8toiUBcTm8xErLp
X-Gm-Gg: AfdE7clx9jfxRXawkLPaSbd3g45x+j5ts2G138WzxA9X3yv5454g0L1ZLH+txSAta/z
	dFwSzTvNvc8NlmPN5ZlANBJltiFWYzw5zgp8CtCPnY2bc8aEcvWE+L2QjjOr6Sq1skFxTMxMtO9
	ptqVsVGBlyzrrD4GFKQbn+01FFapI3uWTRjIWHHtRXJUaCu0RGyW7l58ZPXCvcwH+06gf26DdgR
	4mvxY8xSY075OGvcbPHToE8njh0+lXLJSuRb6OK5fDRHbr32RJQNXudgjmehRjXf4R1s2k5GZml
	mz/bxEZH40CcACul/SZ5DPYNfVxbKTpIIdPQ/myxIii6QDnKiGMtIxkmeoTUj43bQmYWvu21b5j
	iQEaBTQvWWfX9P/cGpvo/HjxiTKjfY06kWMoyMXBkORu8rRsYnmp9cK9JbbCZN06cVSC5aNPzkU
	IzB2t8pA==
X-Received: by 2002:a05:600c:468c:b0:492:3c7e:57aa with SMTP id 5b1f17b1804b1-4923eeb494emr165616195e9.0.1782029826761;
        Sun, 21 Jun 2026 01:17:06 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm194100445e9.10.2026.06.21.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 01:17:05 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
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
Subject: [PATCH v9 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Sun, 21 Jun 2026 10:13:26 +0200
Message-ID: <20260621081634.467858-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621081634.467858-1-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../bindings/mfd/mediatek,mt6397.yaml         | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..fd4b41bd3716 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -40,6 +40,10 @@ properties:
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6392
+          - const: mediatek,mt6323
       - items:
           - enum:
               - mediatek,mt6366
@@ -72,6 +76,10 @@ properties:
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
               - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6323-rtc
           - items:
               - enum:
                   - mediatek,mt6359-rtc
@@ -99,6 +107,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
@@ -663,3 +672,69 @@ examples:
             compatible = "mediatek,mt6397-rtc";
         };
     };
+
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        compatible = "mediatek,mt6392", "mediatek,mt6323";
+
+        interrupts-extended = <&pio 28 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        keys {
+          compatible = "mediatek,mt6392-keys";
+
+          key-power {
+            linux,keycodes = <KEY_POWER>;
+            wakeup-source;
+          };
+
+          key-home {
+            linux,keycodes = <KEY_HOME>;
+            wakeup-source;
+          };
+        };
+
+        pinctrl {
+          compatible = "mediatek,mt6392-pinctrl";
+
+          gpio-controller;
+          #gpio-cells = <2>;
+        };
+
+        regulators {
+          compatible = "mediatek,mt6392-regulator";
+
+          vproc {
+            regulator-allowed-modes = <0 1>;
+            regulator-initial-mode = <0>;
+            regulator-min-microvolt = < 700000>;
+            regulator-max-microvolt = <1350000>;
+            regulator-always-on;
+            regulator-boot-on;
+          };
+
+          // ...
+
+          vadc18 {
+            regulator-allowed-modes = <0 2>;
+            regulator-initial-mode = <0>;
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          vefuse {
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <2000000>;
+          };
+        };
+
+        rtc {
+          compatible = "mediatek,mt6392-rtc", "mediatek,mt6323-rtc";
+        };
+    };
-- 
2.43.0

