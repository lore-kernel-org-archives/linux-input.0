Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003644;
	b=Qv0m4FMZIXNbco0MD6LSqzwovpzr1L8celc1ndTjh/OIbj+kH8PtOETq0CTXpkWQD2BH
	 XYpLydq7F16HT79vDu+LAfY7bJxW/j1Ylpd8YNHVJxk5BRgKsqa1YeVpIk5cFTdbUJHhp
	 uhp2M7jdvTYg2+iA2QrMSge5oraGt3YuB3MyAJT/GrljkGG7+OoioZOaoc7K/TsdeR2TH
	 eqSEbLzTXIUafqLLI2a6R4A2xsGQdV49pq6sWyHWgEEl9X8Q4+j4NC+Y9qtXqDCcvmhAu
	 6xCgOpGInRYOEhB9WF3QvkIZuSeXF6PzhzNALC69rpLdF2oki/oJCra+ODT3DIgKsNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
	b=EfAsqc5pjEoHhcgQTi9rikALWSso8fiwEL2eBSyQsuPJqNaXc6pWuykxflQU7TUTVvkD
	 7Lr2flxpdA4uHlMh6uM1bmXACxvOlD74mDRJ6Ofb+1cOcAUV8VeDaWSi1mImC3mXFz5Kv
	 feaze+iH/sD9RFpaJwEuBrPIyjAFrY13OOEut6IG0XNCn6veo0c4J0YDGI3/DJmEabk3u
	 c1ZBoCeYBeODPVuki8ebUQmu7cn4w+rftvXV9ASmGgD4CmzyNml1LN9BfFOg99D2Ntand
	 z9+DvUQrmlAlWDf2ccqzifQxGbfUm11e4Um0AHYeInBFtBvhKqnq6WWhYM6DHe1Nz+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3BerShj;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99960A3814
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C99960A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3BerShj
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a42b34e930so641295f8f.2
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003642; x=1795608442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
        b=V3BerShjEcnO6pe46yCvBfsF74qmcI5GXv6i5t2GXlYnum36x79Gj44I4wU+QwRo98
         G31Ub/yYW3mQOO7WABbSJOLZszoXUT+NI7FoVgT0Qdt3ukQWC9WbBYmhcmNjnLnHkTyG
         3kV3336CjyZZdZ+S/1EUWo7anKHT4hqcaxtwJTnrYToIb/suWExTnoaPjWOQ1tQqzILm
         o0NLa767nkp1DqgMu102X4ZZ+YyfcLEZ4QAAvT0TndB3jh02IY4IOtFhPGcHtf/Xj2+q
         dsQXY+OeOTuT+Mz9xF0Hbnko+PpTAr/UeetYn4Vt3fjLBSZ132sCBsWIRST0vkJioAW2
         R7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003642; x=1795608442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
        b=qBvrFJi74mBKU8wVagz1VOy794JBBsnJ/9742YSP/IKn8wsDZO7vVJxEaYGc3KUtue
         D2gQHZ6biDwcNeO5Eynf632633JILS+VuKxfDK6HGVthAGVXJVw4GxWA5ZMVL5/S7rSC
         KwBqvtNj6qMlgcHZOMt4Udedo1wmGbtLyIYWDGBl4fndPZvsW7pD1GoLKMGSRfQOaI1J
         IsHxY6jIQll2BaMOZkg5xgVENMjR4S2FB2hbI78TfFht3LJkoKmJB/vM+xE/axDwhq+k
         uxgoxeMAcy1hoovOsgrYwUGXi3i3X+b30GyaPbzQqY72oIsUjVH0J+d9qppJE1WMhiKL
         3OTg==
X-Forwarded-Encrypted: i=1; AL+hErEmcJQx0a4R+DoFPxpIjx2LNfNs+fc0tCQslEYlED2SxdqImLThAG8VEipmI4pdtjvFuCLkWfWTzzIHdg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8aCQHHUesldvQFeIzWtdgG43uousD4CuixYxR0n6/37/17ikIL
	IuMNCwdb2U54OqDFaVIHAbqLr5qAiDGNmNvTsfOVB+YGjb+Bm2CBtWcr
X-Gm-Gg: AZFdTZeT2rMeEW4SUZlEjl6gvg2H05LEdAD4/j2TWU51Wt/fEWScWfe/3OqB697ncLl
	rbXWGXgpPqN/ej89yBlrEe/GRfraY2FX6lmuGJojIsAMu+Q/1kc9fUhwojPqjb1XSE0zj0I3R6T
	1KEwTFeFF+Xk2fzSBlV1CD/9R7HDdsvir2L9xPT3LJH5fWYhyS6VOVQKazNKEV+08H0smT/x9QD
	t0AA7lA7kebfcszO8FFRgyA0/XZihNbhE3tcNKoTFRBPv1JIvAwGbwkgcGIpR2Z6l4uue2Y47ro
	2VM42oo8FCtDQ3gGXB1KRHNy9sOAeUqFM3Zo8pxK7AgX0t31ce1QttMZZ8PDYk9d8ii4dq8hz6T
	MBpx25yb9wY6s5/SB0gFKFP9T0yxzth3V8PPaZ555IQ+oJVkj2Gjh/Z64up4M7ENDkzSq6e9r8z
	GNPc1+WvIy5EqJ65KkwaT6qTfXU5I0KJ9032BzWXlEMWYzuyvME/T2SxQw57EviXUd2KVUY9V0y
	MGxAhNoiTm8L521+N98OCgFlnWe/WcSzIUhiWan55sA9LJRz3azX0h0MB+sruB82sMlPfjvZoQM
	l8jjM7aAhvRkly4ZCw/EbH9wkx+5m7jMPsDrAlxkRGd2yChcHQ1++Ox5+I5zNa3PyvnlNYpt/hE
	=
X-Received: by 2002:a05:6000:46c7:b0:49c:192f:cf1e with SMTP id ffacd0b85a97d-4a63b13855amr3763095f8f.32.1795003641960;
        Wed, 18 Nov 2026 04:07:21 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:07:21 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ivon Argel <ivonargel13@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v2 05/10] dt-bindings: input: touchscreen: add Silicon Works SW42902
Date: Wed, 18 Nov 2026 13:07:09 +0100
Message-Id: <20261118120714.31505-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Silicon Works SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..c5ec3bf4e545b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Works SW42902 Touchscreen Controller
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description: |
+  The SW42902 is an I2C capacitive touchscreen controller used on the
+  LG V60 (timelm).
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: lg,sw42902
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low hardware reset
+
+  vcl-supply:
+    description: 3.3 V power supply
+
+  vdd-supply:
+    description: 1.8 V power supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-supply
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@48 {
+            compatible = "lg,sw42902";
+            reg = <0x48>;
+
+            interrupt-parent = <&tlmm>;
+            interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-supply = <&reg_ts_vcl>;
+            vdd-supply = <&reg_ts_vdd>;
+
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 28e4aac18d44a..a29019d984393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25835,6 +25835,12 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILICON WORKS SW42902 TOUCHSCREEN DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Frank Li <Frank.Li@nxp.com>
-- 
2.39.5

