Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60E3451DC
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828293; cv=none; b=V80GxKcKW/1pvGiSQXVvj7nri5yAohvSKJkzJsffyv9MBSbZb27Xsc6sPcAs1G/0tWlduaoIGY57szKZinxbiir88b/6WNtgg+1TWYK8Njev+L86LAF3G7Mt+RMX0ymXtix6fl5snPGlA3P4xEuywPNEO0wEOxHjGwVQLz9+VFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828293; c=relaxed/simple;
	bh=fvsNiW04qW3AIrTi8INmyEkzbGKGRZylVzn1kRv9504=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbraISeeuS3ZayldtTxgXJBqtbTy2CVkeizEfUxGQY+rLfmBhx75RfARV41KialBibQ/dyPhjgQ1a8lnMRO+jbaUYwjQtEoZOhOaYiDfiyjtTPq1s4r12CYssm4XLZbso1KORBjRC0s7JZ5tiEkuQS1lTYb+qSoybQlyEXrzgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exVVAmtN; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exVVAmtN"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-59de66fda55so4406311e87.3
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828289; x=1772433089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baZZ3I83Z7duoBmCyUC4MTXvnHqhUiDCw7gdIgcx7ZU=;
        b=exVVAmtN0qT61Z99T6Ogq1td5k9DMeVl3n24HmPpDe5lOXpofT2UNhmDTzmrg6mQA4
         SsX2Y9ld/dUxZbFoloLiDCh0kaChVRmLdMOyuew5wyr+EYpHfd7RhYmGCkojaaabys8h
         lf1FYGkzUjRjJ4Q7/wilO0toR7DKARkJGD5p6yyzTX64GIQeDuIGKQySFD1gebcnkljq
         LO0SGDv+gBmUJdCzpMFOq3wS7Y6TIqY+fCPQJLCKNZ04HINENuoz1f2X/MGZzAdPqbAh
         MmYMbC7hr+IpgpAOZMWyH6NPD21MMvNg+uUpx3saGtPCxSWqgOyIEMALZvmSBrAFehZf
         qy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828289; x=1772433089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baZZ3I83Z7duoBmCyUC4MTXvnHqhUiDCw7gdIgcx7ZU=;
        b=jdjpw/1HYxj8gO3xQ3arD0E5WnTYYa47qzV1AGdMu+71nvOOVDCC73szYctpAFFPj4
         v/oZq/lqlLdjeeD5Xb9OcuPM305ndE7BcjgNYGEskKGAxjA289EgUvWL7De/yoUmyOnY
         x6INbZp7c5nHtC2yXHTpbWDvoZHLvY6FNx48S0572tsIMoh/8sYf/FG1C1f0eXQNZDPl
         ONue3otQ8kp3VDHJlj663Fo6jpAlEgkiZ8/b2XZBV1J+vcU9Sccr3iUhNULx92Cv4l78
         Q0HrLowQ+RGiZkNL/rlH+MiQscryMyYnoh9Ckx61oXJEo9o6l4DKINaJx7v6n1thsT09
         JVww==
X-Forwarded-Encrypted: i=1; AJvYcCUIyXtvGEVAdQX4BE1lSRBd3qb/VLM/xYM2/VHigsIvhBEBMXjK4ZWx26GcJxc6BmZCVT0+IsgyQMKZjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEh6g+hYXr++3FXW1TQkQ/5QQKJS9LqK8KTBVoOcX67d7461e
	LuDvwj7O7H2qjRfAedjg68Ujrvvjv7dsmB260JQpQcNlQiKwHKKw1TXb
X-Gm-Gg: AZuq6aK1874baeLxBZq1HIsBJ6gFPqw+DqD/RqlEZR9FRXr/3z+tpflX5IldruPtTtn
	/8p0WFYCmX3ZapytwmRIIBPgH+1OYnwnj6SC35YI135S0iV1tij+HZYGH02wCAfGA/ZzIyxtQnJ
	h1wAg6glbrxynf/P4AvVkOvrWYI8c3c/ptDhimUoKVctdOpFOO2gVd6mxBruAbK2rJuMvgmIBQo
	RUASFNHVYa2jUBkjpRx5tsBDnr23arcSPhMDhec9qMk2w4+Er4UJgYLJvZF1VCfEoSTO9Bdx6Mr
	KfzphjBpGP4NmSLrYm2S1FbUCLBMCgLA3YgO0jY0gnkTUxyuKfpTT4wcTwGF+OoHOdbBKOBkVqp
	qvlYLAD/PnRgA9Lq9iF+FHRRlzCIFC5jcczSmEwrOvAD5+N6yieo66CjUq/mwy6i16Xu2RMdrue
	3QnrKJY449g7e+
X-Received: by 2002:a05:6512:4007:b0:59b:6f3a:9c80 with SMTP id 2adb3069b0e04-5a0ed8a5136mr2397079e87.23.1771828289037;
        Sun, 22 Feb 2026 22:31:29 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb14596sm1361320e87.26.2026.02.22.22.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:31:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Mon, 23 Feb 2026 08:30:53 +0200
Message-ID: <20260223063059.11322-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063059.11322-1-clamor95@gmail.com>
References: <20260223063059.11322-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../asus,tf201-ec-pad.yaml                    | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
new file mode 100644
index 000000000000..6a61c88f9046
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/asus,tf201-ec-pad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Transformer's Embedded Controller
+
+description:
+  Several Nuvoton based Embedded Controllers attached to an I2C bus,
+  running a custom ASUS firmware, specific to the ASUS Transformer
+  device series.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    description:
+      The 'pad' suffix is used for the controller within the tablet, while
+      the 'dock' suffix refers to the controller in the mobile dock keyboard.
+    oneOf:
+      - enum:
+          - asus,sl101-ec-dock
+          - asus,tf101-ec-dock
+          - asus,tf201-ec-pad
+          - asus,tf600t-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf101g-ec-dock
+              - asus,tf201-ec-dock
+              - asus,tf300t-ec-dock
+              - asus,tf300tg-ec-dock
+              - asus,tf300tl-ec-dock
+              - asus,tf700t-ec-dock
+          - const: asus,tf101-ec-dock
+
+      - items:
+          - enum:
+              - asus,tf300t-ec-pad
+              - asus,tf300tg-ec-pad
+              - asus,tf300tl-ec-pad
+              - asus,tf700t-ec-pad
+          - const: asus,tf201-ec-pad
+
+      - items:
+          - enum:
+              - asus,p1801-t-ec-pad
+              - asus,tf701t-ec-pad
+          - const: asus,tf600t-ec-pad
+
+  reg:
+    description:
+      The ASUS Transformer EC has a main I2C address and an associated
+      DockRAM device, which provides power-related functions for the
+      embedded controller. Both addresses are required for operation.
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: ec
+      - const: dockram
+
+  interrupts:
+    maxItems: 1
+
+  request-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - request-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@19 {
+        compatible = "asus,tf201-ec-dock", "asus,tf101-ec-dock";
+        reg = <0x19>, <0x1b>;
+        reg-names = "ec", "dockram";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <151 IRQ_TYPE_LEVEL_LOW>;
+
+        request-gpios = <&gpio 134 GPIO_ACTIVE_LOW>;
+
+        monitored-battery = <&dock_battery>;
+      };
+    };
+...
-- 
2.51.0

