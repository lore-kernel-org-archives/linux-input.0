Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C243F0B6
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228754; cv=none; b=uUaG1JSyem4blIe0NHuLPuoOH2zfAG3G8HUMinbFNEy2AswfomFA8Bw1VRZELfTtJMD0IwARhOwI0FLGBq0z5nchHJq0EPVmelOD8uzxHWaHRQlrgKeIrq9ib9y2DQItJOi5hNgm2eQ10bvZq2115gWMc6L+VLHDCINz+6iSBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228754; c=relaxed/simple;
	bh=tfTNd5tjFz9L3yETKktoI1guJcDo130AJeYFbFp3xqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDux4UbXM5K9UUWtSuQTb9nPsIkl34tX4Xrn/kNj/K934iF03AT+Ak+aSdWJQ6kvOofHXy4jdDNrSnxNeKsnJfMOIpP1VIG7GelQ9F8uJQ4y2fdrcsMYI9A35P7A7AknMmWZzDpX/vvqlQwcNe4RF6XYTbWYTYBmNZYpjofQXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgVMhno2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgVMhno2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so14478915e9.3
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228751; x=1787833551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IxgyMnm2Ery9SpdEpzGlw+pytPm84L4YPgJiijvQrI=;
        b=ZgVMhno2QaNMwLTiXdlwRcP/jtOJCaZCd7Iq0fuJE4H6TWjFuU0hVw59yXw7Qdt4Kt
         S45NpwNWnJDNg3FSH4PLkpXXgDanX+lz4MGe58L4pb+heCVmNhYntVPgZvYGJFNMVWGK
         QTMweDWNVXOoTXzS2wXSN2wc9DJNVdZL0qNb1TRoQOzaoS74MjAPYwxrjYZPStCdpLp7
         0nJB3Djw+3YyGt5gszqeKZ2ucxWX4gsJzP9/Debv0W21kQ6f9fXSHeRdjyKxCBfHjhdL
         NCvBrrhEx4hAQ1QPrYn3xAAEXealQwY2WbcbSy/HUA+d7YRUgHonTls1LkOHxQxpLbL+
         4qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228751; x=1787833551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8IxgyMnm2Ery9SpdEpzGlw+pytPm84L4YPgJiijvQrI=;
        b=rT0uVK3URwfkRkcnQqK+9U+AKNLnhCSAatU3Og05RAJ8/aGJ7OtayOri+GFk4AdSZ/
         l3sLXn5gVrQW3lM6sEEAih0X+dmHpl5H/DqrjtfTg7vkp/ii+n0P88MfwmEMUQXvDyLQ
         3HfwpCLQ9qH4PAhYrGQP3HmCBs52NP5QoljzCy2WNnj7+qTVIqRH04Az3UsScmkgzetx
         s78elV71HF7YpOGgOxThsSlwHH0nasGrTBdKoHfLEcu/7wyWkxSie+lblT0RlYM9hKva
         sU74L7p9NW6AMvd5V72zBa2cfZ8ZSDbbCMc/WiLujpqO/8dWuhg3qpBTCmQfRR+vPfIZ
         L6DA==
X-Forwarded-Encrypted: i=1; AHgh+RoJzJt+DrSRKsaOCkGjJs1MiICQCKbFcgUGTKtTWwexAy2dqmiby3ZDbDrR9xZgZvfhPLLGDD0hXK7Jkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy238Vi7czUhz7zLVrs0dcjd/L1CztJ/ign2YUQgYist1DW7WV9
	hja0hp5UbicY4NtuzlhDM+zyIpmx7HHDLOCHWg6ZZQ72mYP/T5akEAHR
X-Gm-Gg: AR+sD11EbYsveF63vpXYARpKXDG6tI3xk95RpFWRwwohCvAclKYeWBsLmpgNbev85Fk
	hL2ngzclWcnKex8UQ6Fu+cOhC7yk5pyWpwkeabi7jtM150NbkYvdZ0C+3fve4eZ7gNaCSyuBFJw
	yDsQHtSYXJjv85AIp/v+Ts+rIwz/Da4ynuXLyzjJ7Z6Sk68sWQMomV8UWzL/0UEknbOGpS9Wqzl
	ZgkJJpkvT+s5E+RefQ906iJ0nhwypYsxOFtaf0I67gfIUvYFeRCsTYgCdKk41xSO59KZrx7SHc1
	zxCkKwhlHOGIChDKARI2yATHKjMEJH+GIu4RIi2d5KPYUk6ARh9VqmmT1ijgptNcnVZ1B4KCn3N
	fN7rH0knBBhtFiF5m2rreL3BjuwLS6QzVq3YpFrgaCY7ho8lcYUWyXk9I2DvvGFxcAOspsDc08C
	C9cfyp+sNzK9m18u8SY9jevaJgUBXUWE5LZJN8rilHaJ++uGoy40TfDQ==
X-Received: by 2002:a05:600c:5288:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-499aa1ea46dmr243508505e9.13.1787228750345;
        Thu, 20 Aug 2026 05:25:50 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:25:49 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v9 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Thu, 20 Aug 2026 14:19:59 +0200
Message-ID: <20260820122242.120039-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

