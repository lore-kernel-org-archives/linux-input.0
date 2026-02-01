Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B7325700
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942658; cv=none; b=YfX+rvRv0ItA9Ts059yjcLFKg3Y847y/x1saoERomGqNyYvjznzBuYx2xkm60bv/5VSWUxDOF6afv7S8HYnsK/hEeI7jvK2CXQprJkYc2cL0oFQrR+s4+DVUDMt21bXyJ/ambWyYEOSIPUeCOWK5L3bl+sCfdwbgRMI+zK3/X4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942658; c=relaxed/simple;
	bh=0N+pk2TI+JtovuI3l2xhTK/qQ/ayuu1+Gg+HuId26qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxrtdGuL1nmzYo16uICobpQke/khqFjzCg3kUgermfn+CBPwdJlTuMUhotfz9CeUUH5/E5btJW8oDRiuqXu4FE+uhrOHVEytR59KJkr0OnoRMANEfDkIarxjFHa0wAeOR2egZUtRYUNEjFzZvYlLVmn91MXRhk/oVFZdJnurPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcJhkolq; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcJhkolq"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-482f2599980so5541115e9.0
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2026 02:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942654; x=1770547454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIkuCcLFcESeg4evD7K33beEJL3vgA15kSHNr6N6YkQ=;
        b=HcJhkolqx7Nr4774jKrYtvbesalaQ38nWA1bXtBl3+Kwtzvdk0i+0715eFIoH2NrMf
         q6KsdfSU2o/vvgae2N2ysr58FEMvi8nVSWew+S8mckqnkYzh0Ri8KHOqQbdiu4Mxp5XJ
         TTf3vwZJLCQYZxp10xADD6amI731nKONjpm5fnaXDSznJjDf2MVwheHo0Q8hljYuLwG4
         H985BCeSVru6DArpR9Icfi5c2UnToqJfkWku/j5jDcPUZYr6W8nh+ICxCTXVU82Ujh6b
         KO6AwhhmWcLAe1Aw5sW4cWRFmIZDIKyVtkkNdOl1v/FfmHNBh6gvkJXLXBmhEvEbYtab
         wMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942654; x=1770547454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIkuCcLFcESeg4evD7K33beEJL3vgA15kSHNr6N6YkQ=;
        b=XByaBpkCIwg/wircAtyt8BRmHGhfWLzXc/AaXYy0cM6e3rHwEov0+gXhv6/lQNCz3H
         2DZ6QrirzV1iTWyZWk3aWLiSd1UYOpovtORC4RlKBtZ3wI6gvCAgKmCiGMB84EUczPar
         Nk9mkhTSTwpQB4Dy3m/FKatXvv56xnU8zCcODfkuLrRvo4Zq1gQK1qmjRQdBD7Uihzz1
         6dF4ANybu7Rvv0r1qHj7075VzLhigC+TeweKK2zPARdH5f7jAcJlHk7jCC5JkU4B8kuq
         x5HiwrZquVGcITfCO+S6qMNqNXKv1ugW5PRL8FEYdu34haf/WwzMEisZEgE/eS985gf1
         wr4w==
X-Forwarded-Encrypted: i=1; AJvYcCV8XAsKbSXy9HS32VwKXGQHQ+k20/6XJp9dvjPk+Cagnzfhu42Yh+Dx4XUF77Ilpgj2h5ttNy4lwK+J0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgzIRQdg3284ioZOPrm88h1kRO3iMq3/DERrQaJg05FGEZafg
	Lu6GujVUoly2Q1kRLQaeuLQa+O96LPtZTKcdQwqtks99jjtIwrSVV9zq
X-Gm-Gg: AZuq6aLE32/xCpuDZsdMfipgDqAGuQ9QotShnn6WbgiuTuieYnwPMZihUNd+xnyssyv
	a9ojCr7WREbA1QohjjTFPE5OogJqEc64ZpZYF/kWa96LKPE5LIYYUj9tpJN+4bHwHQeZagAXrVw
	bko2qx1R9jAlxMvVb3mMZmpxqjefxyq634Lo/xdpc4SgooGIAc2oq/MX91hO9JGjqPub4drAiwd
	MRKudakaCqOwbuu7K5l1AY09Fj13QYmeJfIV/ChwpQi1s5TxmlMdil1jdkZ8G/N/5XksTLzZhRs
	z9Dh6/dwOWs0d5IHUOMaTzFcN0GyHEANcSHRsdhiySUvk6lUQ5l6RbG818GvsPK+7DwRQ+5bFmS
	a5lEF32uamlhg4q9ETBIHf+zy6buxLSw2QZSZ5u1G+1o+ITubaLh67OU9PqKW4q4nKAZ/wuXSvk
	vC
X-Received: by 2002:a05:600c:3b1d:b0:477:9cdb:e32e with SMTP id 5b1f17b1804b1-482db46014dmr106028315e9.9.1769942654259;
        Sun, 01 Feb 2026 02:44:14 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 3/9] dt-bindings: mfd: document ASUS Transformer EC
Date: Sun,  1 Feb 2026 12:43:37 +0200
Message-ID: <20260201104343.79231-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201104343.79231-1-clamor95@gmail.com>
References: <20260201104343.79231-1-clamor95@gmail.com>
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
 .../devicetree/bindings/mfd/asus,ec.yaml      | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yaml

diff --git a/Documentation/devicetree/bindings/mfd/asus,ec.yaml b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
new file mode 100644
index 000000000000..5c28deebce7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/asus,ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Transformer's Embedded Controller
+
+description:
+  Several Nuvoton based Embedded Controller attached to an I2C bus,
+  running a custom ASUS firmware, specific to the Asus Transformer
+  device series.
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - asus,ec-pad  # Pad part of Asus Transformer
+          - asus,ec-dock # Dock part of Asus Transformer
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  request-gpio:
+    maxItems: 1
+
+  asus,dockram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: I2C device used to access power related functions.
+
+  battery:
+    type: object
+    $ref: /schemas/power/supply/power-supply.yaml
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        const: asus,ec-battery
+
+    required:
+      - compatible
+
+  charger:
+    type: object
+    $ref: /schemas/power/supply/power-supply.yaml
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: asus,ec-charger
+
+      monitored-battery: true
+
+    required:
+      - compatible
+
+  keyboard-ext:
+    type: object
+    description: top row of multimedia keys
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: asus,ec-keys
+
+    required:
+      - compatible
+
+  led:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: asus,ec-led
+
+    required:
+      - compatible
+
+  serio:
+    type: object
+    description: keyboard and touchpad
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: asus,ec-kbc
+
+    required:
+      - compatible
+
+  asus,clear-factory-mode:
+    type: boolean
+    description: clear Factory Mode bit in EC control register
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - request-gpio
+  - asus,dockram
+
+additionalProperties: false
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
+        compatible = "asus,ec-dock";
+        reg = <0x19>;
+
+        interrupt-parent = <&gpio>;
+        interrupts = <151 IRQ_TYPE_LEVEL_LOW>;
+
+        request-gpio = <&gpio 134 GPIO_ACTIVE_LOW>;
+        asus,dockram = <&dockram_ec>;
+
+        battery {
+          compatible = "asus,ec-battery";
+          monitored-battery = <&dock_battery>;
+        };
+
+        charger {
+          compatible = "asus,ec-charger";
+          monitored-battery = <&dock_battery>;
+        };
+
+        keyboard-ext {
+          compatible = "asus,ec-keys";
+        };
+
+        led {
+          compatible = "asus,ec-led";
+        };
+
+        serio {
+          compatible = "asus,ec-kbc";
+        };
+      };
+    };
+...
-- 
2.51.0

