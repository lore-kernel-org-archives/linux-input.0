Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A52F0C79
	for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781985662; cv=none; b=Wn0r31PU+7TAZk8n63v4fqb5+sg+FzssKplpleXg7QhBaSVU3XrU31ANMdgUEnzCldI/zTWBkacn13xL6a8xE0yF+K3p3vC3IRx0siNAODccGHENQxLxo8bBjPD9GmGhcBN4udrRzsSG9v0pK5yypVLMrgZYIEWX2GOdgdcrrCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781985662; c=relaxed/simple;
	bh=C2RPz9317K2x8HNeQWBbIdy3Fw2SwyRLehH0arAHRro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZORjFtzPYjQjx8mDPkfcgZp0AF0gEMHNI8/+kSf5uLrraykXBrPEzqf4sueYQD27ic9GKRKwTamt+vNHhkCG86t4+Vo801UgJsxRc2Qqki7+sLBmktJm16QMLi12QyNZf26ZZHiIsGnuiZtPlzuHxJlnyATqAdXuLedhK6iHtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhgNLu2B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhgNLu2B"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ac357c55so32560735e9.1
        for <linux-input@vger.kernel.org>; Sat, 20 Jun 2026 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781985660; x=1782590460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKF7GqpNUTdJMAXxQG18bCaWMljaCNKHwPc7AyjKQ9w=;
        b=fhgNLu2BB+v0nqPRHLSOqMrLTN4Gjb4gwEW0WzLvRTomwPOmTxrasfm0JlHhxuNBT8
         buRrFcfF/ttyiErPpefIpPdpZCet01WtAkojThxa207/fgN5Jrl16J3u13nMuD1q/YA1
         l0TF2jurlK3TxGwS1gRixjiqGUUaPEFOSJX83jpreD9QkjJqY1ZSDiV+0GA0yzbOidIT
         ZdimbDtFrsLE4Gd1Q35piOpEtY9L8S+xA3muSxEgPpqtYARR7cElAnP4IRZzOKvtGSwF
         cENDdwxVU34walbo2WSi9ELMK0JmqFVSYvzubUJ/E4O2HQ68oHhhyiiGQE1BBXRVnOwn
         ieXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781985660; x=1782590460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKF7GqpNUTdJMAXxQG18bCaWMljaCNKHwPc7AyjKQ9w=;
        b=AwhYQVyat6UkTTheMt7/rGQbq06vy1WiTOQWNB98urqjibmdq6urXsmM4m6pCNR0UJ
         3dZ/XPkPE8zE0iezjRlMo7WYaow9pxQt5gMdxyVsAojp1SyejOJoiUX0EdGUd52N7cYF
         PQhrua/NVU2P8y+KEopFoJp84vRtWEyTSiT7cWP2gAMG/5CuM3/Y8KjmF/0HREuAwdqj
         Kk0PUiSFp2J4LwL6iFGCBjODzb5KtFznLO7Aq3VFGIehXLdYjYoV57I5GIb6vS4MxP+E
         o4ROHfJoEVEsbIEX0VXQB5RoNG/S9shRUBMvsbQ0gpSxUYDB/dFtDsNWRo5wHP+i56+f
         LTPw==
X-Forwarded-Encrypted: i=1; AFNElJ+wBFhwYot3kXahsomIvBnjyaa4hPRSlELCFpLAuP/DDsdaYNedsUFbF9veF+GS1GANCtxi+H7IUFM5Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrK/QEQzYx3+PnI2aXmrPDmdINce+dNalKgET7BxjeWN2/C3+
	drEOqRHvndOPTDeuxqiaDPwloPW7lA0js6JbdhZ4lDH4ySLyqOGokVHA
X-Gm-Gg: AfdE7ck7gnu3ost0DSjduKJhXC7dUS7m+xVZofdPtlUgEo0McGVwDeH/E1qzTiwU6mb
	m4K6cCFLej4tu34dEi2EP43uNab6YdnZgbscTN9w9FyTBuQQknCqbEWZc11dIZiTTG6I9D53hD/
	SA/o4u1N670C6g828SKcxoLUSZCZtQZP3/IKdE+CvkoxZYc2c8kuGWtEKFVPKmKQMJqQtyL4KcC
	5L+Vm/KOg6SKjaY6s2XEAWsQy27WAk/oWTGPfRCQ6wo7l9BtyJkNyi2KlG799N1qfc2mcxbm99q
	ZDthb3JYs8x8ITJkIytpyw5K6y3Va5Hto1CjVCFCQSFOwemgOdanEb5hRMD+iAcG6mOvsSSn6di
	7zJG9HdO7gwqOIMv3p/3MCsUKvsSa15SaNJRqKCuMSeStHSZ36JIUgrvaWPrDyNH72PNiJ+RR3M
	YXZdGC6g==
X-Received: by 2002:a05:600c:3112:b0:492:450c:57cf with SMTP id 5b1f17b1804b1-492450c5d26mr106314955e9.31.1781985659503;
        Sat, 20 Jun 2026 13:00:59 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm10708354f8f.23.2026.06.20.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:00:58 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v8 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Sat, 20 Jun 2026 21:56:47 +0200
Message-ID: <20260620200032.334192-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620200032.334192-1-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
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
 .../bindings/mfd/mediatek,mt6397.yaml         | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..927df823d640 100644
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
@@ -663,3 +672,68 @@ examples:
             compatible = "mediatek,mt6397-rtc";
         };
     };
+
+  - |
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

