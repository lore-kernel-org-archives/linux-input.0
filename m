Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE03D75BC
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650687; cv=none; b=hoFxkTVouKjCM2u9h0NIiDbIozNplD6+/EaDTX9dBAysq0QSc0WxKq850zUiWIlJ7YDl6xeRK+hVCLYZlpDJmPw2YBc9qMccVNZaUWwqeQHGkNFvav2hvKpw+EQEpakqaIwS7ubkkYGUqu1jn/eJBoU7oxRx9Znw+v9HjB8tkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650687; c=relaxed/simple;
	bh=Um/z68zG3N61niZpCEIqJtffZwPNsXI2dku/W5e1n1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBpCD75fXcf+Hb9kYcYo+BnZt369YAMSlqZMiGB2ZP80yJlGyQT2Lv6eYYm5Z0rtENLLo/YfPpsC5BEgnmwHRtgHaSYxhMkXHRG10MXaz5aCpOzp+H0NbQhou/aj0D2/d1FPKdDpUo0ikinLXTmrIs2ScN4kFcR+S/C3I+DEdKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSoWYr20; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSoWYr20"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-389fad34e2eso118649261fa.3
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650684; x=1773255484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X0ubJBSyO/B3iU+P8TQmYBYVQdgv6gVa1x95cmnAWM=;
        b=BSoWYr20bcI3o3JCa9seNp57s083V2y+QhavjlJ3GtJNXMtupOBHmoSXXKFOxT35IB
         fpyDzpUq+Dw9a8juhD86IzkpVG+dVVD6AgCzBs0ClWxJqdzSpnLTcPetrZ+G/NonGKDH
         Y6DGANEVtgOL0NIKIWc14Qq1+3RtWW6IRHzRVHmpq8kv52G8YigIbgdTsqKDAKUxnuSR
         XCTROFJ4hxjEKxEKXavX0RnEZUPUhST7ROb5J9VHsOOY6vayoLe06U5teHkvp46m6yjV
         RywDnGo7q/9BnWOC7k5WiS+0rAMYjCRWXVZ6sHWHTezB1KMwqOifymCuJsVcTNkHxgF6
         s9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650684; x=1773255484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+X0ubJBSyO/B3iU+P8TQmYBYVQdgv6gVa1x95cmnAWM=;
        b=Lr1aaua78lCrCCJo7LhuiMYkhV0rkW0dNdK0PqL6eD073+VzmcYQRbkj/U6u9zluHd
         ra1zUzG/IkgrDau1OOXnCzhPsynns+1m8AV1zDuMxX4U2mn9SZK8MTtcp5/wgE9BFvuh
         fjcO/L7dA1F7x6mCQH8G8Tt1kH4gOTpvLnSO5CKp4UVqGFWUyPi0zXwBn8yZC58fUVsi
         rDhcR594NS7+1XlWR/7ytcearaRCa89P6bW4TApiB5Ac3iZw/VGMLr6pr1IhQWtEiIho
         MlUaObGgwvuitMTKCJWh4sTPXxNZvdwqexiORiwBSM4hUZN7bSqMSUNlg8nzYhx75sJR
         Y1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/BCPz7NijyaWL9z0eknH9VnPZORe/wNyJazpSm4TcebtX5q9uSom4CVcgVR5NBQSePi0uPPKY5bt22Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMA3TsrFZFop9kVg2aN4JxvTqZQYtqH9bkgESPkajYwQomeDh4
	Oqg5LQV/lHERX+mc6Ri3ssmg9kXbDEG2s0Ifvfvfv8KZBnRtfW2q5vG1Q5RCOQ==
X-Gm-Gg: ATEYQzzQ/t6bkf44STxCxwg1oVv8032SMdnLZuruH8u1lk0ggX3aGpWdM6MCAa71qPF
	r10jQlLfi8mrrdq+i4iZbBx+DEtyYw5gZueO83YTmAxp/IqnG90mzd/49oIjuhEG2KIpTpL+/wX
	jicWyQlex/uMHr8zWP64KqIcsi9OcmkJhfP/eEqs/IafM52GB6gh5bLRKzeRUfvNy/avWh6/X/q
	YAwbMnfMpO9U36HEfpNvtuhCULaE5dBngKdxGT7re9gZbIwbLQeJ3UP3uH+jTou4yqkXdN/5VaQ
	3tEx2B4Tp8c+Da0g1eBH0JHJg6M3CBxhq0sHtKW/rb4AF+nGFRhcYc/tinOMqRQwqv7woifYIJ3
	HHOxu8BSYDNYzw+eKxzuAH+wJ9di16aww/Tf0lnqZln4WWk0PsfVNmdUFYl6lV/cG6BjArccblp
	EUvL9B9xqToaE2
X-Received: by 2002:a2e:9e11:0:b0:386:1ce2:1192 with SMTP id 38308e7fff4ca-38a2c5b25cemr17005641fa.20.1772650683643;
        Wed, 04 Mar 2026 10:58:03 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:03 -0800 (PST)
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
Subject: [PATCH v5 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Wed,  4 Mar 2026 20:57:45 +0200
Message-ID: <20260304185751.83494-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304185751.83494-1-clamor95@gmail.com>
References: <20260304185751.83494-1-clamor95@gmail.com>
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
 .../asus,tf201-ec-pad.yaml                    | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
new file mode 100644
index 000000000000..60b6375864aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
@@ -0,0 +1,119 @@
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
+          - asus,tf600t-ec-dock
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
+              - asus,tf701t-ec-dock
+          - const: asus,tf600t-ec-dock
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
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: asus,tf600t-ec-dock
+    then:
+      required:
+        - interrupts
+        - request-gpios
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

