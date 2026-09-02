Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158423939D7
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377682; cv=none; b=Xf2UKK3NaGm2T5W9UxzgPU78JxqKYfJneArUZnNXnLrJaw71/U+hOzYsCC/MKwbi7RhPdVBTspXPDmM9r8pzmbzDUvcxHvfv+CjF6CV6z8q0ysJBhRaL2ZeJnADgqrc1oGOYzZLv2DEa+Rew26CRgAcfzxxcWcyZmHZgkZsUoxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377682; c=relaxed/simple;
	bh=dCN4MSGnNu9qg2o82cMQqSPCzo+02NG8UMe2Xwsmd1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8c5FwOYmka4Z2/h/PAlDAmPPGGDargxywkinrS3lM7u4BZvW2r68tPga9GpJCNHFxV/aBd37FRWdPTaTtqgrZVm6SDugOCieJoC3DlW+6/G2hgTfQcXlYGkuHnr8pMbGfAe8oQtqZrhm0GWGlFYDOfVc6aitxR7cUX2zS8Xgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru+rMLAj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru+rMLAj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482fc3327fdso1002051f8f.2
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2026 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377669; x=1788982469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=caCex+BmvEH7ghZImY6FVecBuOi80GskXDf2a1gswus=;
        b=ru+rMLAjiINO7EaHjU814dGHl+ynYGkwqDSOqR2J6F7nxjMDgXiN63Ulp40yzY6SBP
         /8onhapFUKnQcpemxMjb3P6iJJtZvG/05JX6hGiHhwlid31rId401GjRmELfEOjntnax
         Jh5h2LvMYSD/h43tttfJ4mMpSUD2S/9VKA38qZPZLde8uQkihvnMNkCZsAsykdBbTnz5
         GspW2VD64CvwT852vtSrumyjAlwLUaH7vqieCgDh2lhzMDhITet3oFSNCSYn9y+9V3HR
         tra8l9W+vOip+RCwFKVuF3C18qW+dechV7mTQsaUzZAKIjWSV9DG8j1pzzEFvogODY58
         wfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377669; x=1788982469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=caCex+BmvEH7ghZImY6FVecBuOi80GskXDf2a1gswus=;
        b=FVDOLEyAEfr38RZ19OAG1dyDS7LNxbBWcmJx/t03r0/anvjlPkmy50ifXy1+rZlG6e
         dmiBWikZKj/DWy3CTLs7kd7uLEK9a8xRwzvxzJ/PFdKNI5cOA0fTvLMrqFGKuEPNF0b5
         rtZ519Ll4fk0AvGQGSRF9IJKMFHX9XlY/uoS5XpHzwT7L4IKFGXWQIzgwk8uYvOaD/5a
         5kR7EkU7u8p4K4Rg7ZVrniE6E/69z4r+Dqt2GPznIxAfCC84sobUUxtnnSpwxKeRy5MJ
         7/Ipm3yu4QWHO9DlDhZgNUBmtrPXD3kMcR/ej+6vt8gxW9Q+gEhaRbhhpOL4YNdMP4+O
         a4Bw==
X-Forwarded-Encrypted: i=1; AKwUvByiPCO2V55XfQZwnXecG9tYWFr3DMPiIwSBQev8w625ZUVsosti/J4V6h+uEAac21Nj7aaMG+EumSW/3g==@vger.kernel.org
X-Gm-Message-State: AFuF++kNRY+ecSbiz+nHui912k5Fj0FJLjrN5gMttWevFuxsoLIEE+jj
	i6xjm0cEXY23ZydgIEa9e9YcpnOcOSCHHQ8+GIorIWPrd44Vo5i4rhkn
X-Gm-Gg: AYBFou0dr5L0RZQr2qD8OeQFfso26YjEXZI4mse71iuzLxSt5c2CaeoNdWNjPKuxQEY
	IN6asqEOFgzI2HdMgdTcOdd9PYwKUCnTajhQs441R3U+my2OaUg9Yjv6yFeadQSD6+FGHog0/p+
	MullTKf2JrJGp+/MyHL0OGjAD7T9LP/nP6oAVIO/vCEkQNygyCfidBr1AeA7lC8EoeYKDsbZWKl
	nwQKyb5Hvnaaehu7s84zlihM9zB2L/jTWWanx6C+Oq4tXA//O35VAKJTpnfKV5JJJKRPj+MRCof
	kUjNH7/QirirL65QIcnRhFKM7IK2+zhI8ox6693KqVhCQU/4nv9SqTQuNSROt5diSrhB2829Qbo
	ffrDHWcDtuqZVzSsQLyO38rs70d6fNMgmDwM8dBR8hwTtfuRpKE+YAMJd2aGprZFoN7M1Npbo2G
	aV6z/tca70Lb60hEOCDuh7tNTWW3ZhRxUjGM1GXhuZ7BUgNAYFT7x8+R8y
X-Received: by 2002:a05:6000:4819:b0:47f:e748:3ae3 with SMTP id ffacd0b85a97d-48488deedc7mr13797916f8f.3.1788377668785;
        Wed, 02 Sep 2026 12:34:28 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:28 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>,
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
Subject: [PATCH v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Wed,  2 Sep 2026 21:25:37 +0200
Message-ID: <20260902193351.185771-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
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
Previous version of this patch had the PMIC device declared with a
fallback compatible to "mediatek,mt6323". Sashiko pointed out in [1]
that it would have been wrong as the fallback device is not really
compatible with the new PMIC.

Since the change is significant I have not included the Reviewed-by tag
that Krzysztof Kozlowski kindly provided in v9 of this patch, I hope
this is the right thing. I really want to get the bindings right as they
are harder to fix in later commits if the need arises.

[1] https://sashiko.dev/#/message/20260820125850.3B34D1F000E9%40smtp.kernel.org

 .../bindings/mfd/mediatek,mt6397.yaml         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..06e93c545e3b 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt6328
           - mediatek,mt6358
           - mediatek,mt6359
+          - mediatek,mt6392
           - mediatek,mt6397
       - items:
           - enum:
@@ -72,6 +73,10 @@ properties:
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
@@ -99,6 +104,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
@@ -663,3 +669,69 @@ examples:
             compatible = "mediatek,mt6397-rtc";
         };
     };
+
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        compatible = "mediatek,mt6392";
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

