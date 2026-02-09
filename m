Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6B369964
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633872; cv=none; b=uKBil/Gr2l/V4AGaI19ugV1EgtPDvf6UZH5udEnM2Sq9B/pn3Cv32wzwOVWV3ig4qvpQaUjSPVHisaSqRfIqwQyMjf841bzRJUyRzO3keYRwj0LjGQqLHegJpspqNcY9IvvEurFEluUX0iPa0xKC4jxRNZNikVOG5/PjPbV00UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633872; c=relaxed/simple;
	bh=LrlW5n+TfvOTYQQ1oHM2HINQqXlrDDVoUzaHz6OuCwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0wuTY0dw/CMe3i9z8FHbLbh820OOJX77WtGjaSkSou7eNT1nV0nc4hcOt4SOl1CVlqtyfsJkfSeZb11MXYmDhMf6xe6Nl5yVApUEqLdciLm250/GNgrzCkAaQBHtL0Q70fF+aHg8wYdBPYRhjo/aLCFbvHQLiBrd2f9EXoxsJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndko//IB; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndko//IB"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso3938101e87.3
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633871; x=1771238671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRcfAUL2ICmQKvT/5ZV8//xYR9dZpc5jMuyeuAnPWmA=;
        b=Ndko//IB84vUxt8p5uDSr+MrGTrXRXofr0gO4O3a03KH6hQGLMIZKqV2HzU0Pj7P4O
         cKCaSDF4wXfDU4GB1lI7pwWxG4UxPf6ZrzP7oy1MlmjyGdS2ukbzhXNdrZHlwjt3iFqe
         mo1T0i//yefXghYxDk8x0OUGs0AcjCbHLJO3IVT9Bu1PIsDYgNwvNXDxzNYNqFyqFj3s
         aeiga+4Ss4EWtElO1ZGP7Yp6B8U081CKSa7158T2ZdpLqDV1Itbe54C4OxLrAISC9A7X
         9x56CUU4rJWaH55YdWE6tqHZGMh853AB7+cohF6A8hRmqGIJqBPBVCeTiy0VyaohTBrc
         aByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633871; x=1771238671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRcfAUL2ICmQKvT/5ZV8//xYR9dZpc5jMuyeuAnPWmA=;
        b=OV8oDORZvqw7QtPpN1fYLSf+3a6fXsmG8MxqIUuKu7zA9swZv4LdyQI5l0UXXiC+BM
         uePz/7bZZ9/NzsVHL3D2XocW03XsBwSOuiWMOIEeFHDZx6r4TtNiUXoz8vkv+sb09kSD
         87GZIrrw3XLhdJly0rqbTzvWq27IJOWlhAQebXuTIqxyPSOTZVj3lEHbUbCb5YSEstN9
         lEjbkw5bAPgx94NjR+QbG0/Z/EJWvb8K6N+j+RDizjRiBXew7KhQ14xwgmwKEGXd/Kdi
         jIVtZdV+w5beB36431YkvDWVahU7oRBtJbk78Pio5xFp46E2YwJBxuPD6VYzlKHlcNlC
         vghg==
X-Forwarded-Encrypted: i=1; AJvYcCVewBxcGqGpk7S80wM5szW9mDPJpTw/1fEvTb15RDpn5BeGdGF5W2rx/4cuEkKKnjIQEnniRu0DWrmuVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxx+S+pCPEUh2NMY02sMO5QIV3aakrmyY7yRaCh5RAheGQEjB1
	J9rYRQs23AfxzFfguA6DI7DFb8nddSsBQELvm7U+ixWlXgXEzAM6EAO4
X-Gm-Gg: AZuq6aJZseMBN2+lgpAhPULMyOruT6Y9MnjXl2+bHD2P/qygwVQCC/2pVtUXVJ9QEEB
	oeK1hrRM0bvKrWIEt3jlxfjsP2cixCuL/FRXtRYUZ+MZFfG9sGqgZZjHAjO+nicj/e/aqEwPs+g
	96X6vyX0UfPZv5HQ3ErvPOHIj/NH2W/TmGEQB2jmcTbEZA5GiZf4/WaAHhxLGho3JODAZXx2SDY
	69toxSZeHCKpTbWFlc5Kj/9rc/gcvNY7UW49Ag3IfzeX/PXKk6QyyafB3ZXL1afE5REMUH4UQa+
	fZcnBekbi7ouTBrIwRdM+pEDaU6Vsrk8LxWFfQzHwrCfZzDHN+3RLlBTzi53AV2bhd46eXkdoSY
	HYZF5/vc3plJ+mzjFPy6uLieUVpV0Y8kP1sPvgPmwsKFgAoc1ECckxUlsIjZeeIRjiQCOkHz0Nl
	0Y
X-Received: by 2002:a05:6512:3088:b0:59e:4a0:ac5e with SMTP id 2adb3069b0e04-59e451733demr3569115e87.35.1770633870507;
        Mon, 09 Feb 2026 02:44:30 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:30 -0800 (PST)
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
Subject: [PATCH v2 3/9] dt-bindings: mfd: document ASUS Transformer EC
Date: Mon,  9 Feb 2026 12:44:01 +0200
Message-ID: <20260209104407.116426-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209104407.116426-1-clamor95@gmail.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
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
 .../devicetree/bindings/mfd/asus,ec.yaml      | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/asus,ec.yaml

diff --git a/Documentation/devicetree/bindings/mfd/asus,ec.yaml b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
new file mode 100644
index 000000000000..1d1a62761b71
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/asus,ec.yaml
@@ -0,0 +1,152 @@
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
+  asus,clear-factory-mode:
+    type: boolean
+    description: clear Factory Mode bit in EC control register
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

