Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0882D94B5;
	Sun, 11 Oct 2026 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722880; cv=none; b=HKVtNoKSZab5CIrl9Is8zF8ChlllTJH8AF2Y8D18JTji1pMPPx7KUchNvGpUMIsOgCNkyyWz7MqmtLEhRkCs1RNJLq8yhHgdoTVoHevZ5ESwdD7VPP7YgfQgtEiZkZ5QqTN54nB5fsUV5jDSF2bkyBn48YNqyPQrhZ7V/nTMytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722880; c=relaxed/simple;
	bh=TRdeWDTm1yWoJSWC2wPXsspK0A5+GjSCi2V7gRfZvKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXDQ/RO6uMA23w5HdtMe4k7AkP32xGJZ1iQuUyeusHXVrYlEf4lNVVcN5Vdw0mHJi+rr2JESqS1q8IV7lE4mZWb0NvEcWDMyXWLUGvG0MdlE7/MlTt1rj67RNG8E510n6vFgla651FvILqICyCQBW/TdYaGEb8MauceS1AWHBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=bkQz9x/i; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="bkQz9x/i"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j2gP56cd8zMlNY;
	Sun, 11 Oct 2026 14:47:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1791722873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eghuKpBut0MXoAv1pNveI/JSNHbMX7rDeXfcFbvW4Ls=;
	b=bkQz9x/iQi6C4Rgf+IoSdL4wlzM937HaiN5RO2H97yy3M+wQwxSTpIc/M7bonM4R2tKtFn
	m4Vjh1D+/crzb2pX33AeFzl5FQIffgCSM2q4LWamqiQb/jf5gcM8tNQBup/dVxOZuItAME
	GTNZQKcim9K/wouqbjqgevzQey/3QJjzo41+MI/VmzjQbfZRgoAXyJyyvWOclYImQO13ha
	Wgrey1ATawgeofY6dE4DXExCKLgks+KAfYR4rMr0jOcA3bGvzGJ6ttV0qHJTBsyJeXEnu4
	rQAmsHqXczVDwF/TPyrvUMgBM/4ZwTIBPxvn+Xl4md5HqePsiIB5UcUIC22cjg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Date: Sun, 11 Oct 2026 14:44:56 +0200
Subject: [PATCH 1/7] dt-bindings: input: touchscreen: samsung,s6sy761: Add
 S6SY791 and reset GPIO
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-lat3st-google-raven-touch-upstream-v1-1-2a9f55159b9e@timmermann.space>
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
X-Rspamd-Queue-Id: 4j2gP56cd8zMlNY

S6SY791 is the SPI-based counterpart of S6SY761. The register map and
commands are identical for the subset the kernel currently implements.
Therefore add S6SY791 as a related touch controller.

Optionally, the reset line can be controlled on some boards,
such as the Google Pixel 6 Pro (raven).

Also reference spi-peripheral-props for the SPI bus properties.

Signed-off-by: Lukas Timmermann <foss@timmermann.space>
---
 .../input/touchscreen/samsung,s6sy761.yaml         | 37 +++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
index 1ffd17af3c53..d24f35038934 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
@@ -8,13 +8,17 @@ title: Samsung S6SY761 touchscreen controller
 
 maintainers:
   - Andi Shyti <andi.shyti@kernel.org>
+  - Lukas Timmermann <foss@timmermann.space>
 
 allOf:
   - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
-    const: samsung,s6sy761
+    enum:
+      - samsung,s6sy761
+      - samsung,s6sy791
 
   reg:
     maxItems: 1
@@ -22,9 +26,19 @@ properties:
   interrupts:
     maxItems: 1
 
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to the reset pin of the controller
+
   avdd-supply: true
   vdd-supply: true
 
+  spi-max-frequency: true
+
+  spi-cpha: true
+
+  spi-cpol: true
+
 unevaluatedProperties: false
 
 required:
@@ -52,3 +66,24 @@ examples:
             touchscreen-size-y = <4096>;
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@0 {
+            compatible = "samsung,s6sy791";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpa9>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&gpp26 0 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&ldo26_reg>;
+            vdd-supply = <&ldo25_reg>;
+        };
+    };

-- 
2.56.0

