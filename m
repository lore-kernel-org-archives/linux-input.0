Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5636C9CB
	for <linux-input@vger.kernel.org>; Sat,  2 May 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725679; cv=none; b=mIISGICObTwURC7FJkuvtOUfkQZhzQ4IjA90fffoFZld+fL4OeH6II8youm1nl/g6NnOzIk+IrjXmcI2vgG1WBqyjV95/r3qjEVZ2HInlZgi8YvlVhMCHVe+8TJPzX3+EQ1ildJzdBDHMtrzcK3Lyfk+xHTzRK9SgLwI9VUzdi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725679; c=relaxed/simple;
	bh=or+EJ07SOsHtoyrRm94X5M8kiBqJd626zfaT/m/MjG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkA09+SFyPpIXA4uaMVuZyWAtpUhSr26xZXqiP3jeLkqsIMt/vy3vPEdcbl8xNHa+Y559il0YCRglJO4nUb7TxEsPsBLvUH18PeWqREhzcxBP1r8wF3amLuG67RLUP5GS8LKkojyFZOiWHfFIzM1GqBk6BiOku/zSQDhsnzdSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHfA0+pL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHfA0+pL"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so3496330a12.0
        for <linux-input@vger.kernel.org>; Sat, 02 May 2026 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777725676; x=1778330476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=ZHfA0+pLz+WXqOpHFmZzji/uxrI6Zwgz5zek+JZ0XVlKGVPVvnvraFpWcm5kI6x6AZ
         /y4SG8RuyNSuK/noEvqzG3i0vgerbOHeLPuBF8Bw+n9n0PyD1uVzPyRbUj9BdG7zgR+l
         EaR/AvTZl0rnBkII4yiF53q3RzEdNdl59Ro5eI/ef3lSACAlPLvpqZvpe3+NwhnEuLEo
         jbo3MVbPLRtIa6MJREf9N903J3DtkXf/AFQdmPRLDvvda76KAuMoH5N6RUXKaSFO9qC2
         Bvhq0UXaK+k3HTrjm47+Zwum4/RShfON8H85gWXtEqpP1Y3cU1o45zwPx3zoBuSGmge4
         51tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725676; x=1778330476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=LAxgWRxZjoxvkxoaApqWcZNKhEViWvBCiUJBdJaAWc9rgGyR0Nc881yf/tVtiFkpwR
         i6RNVb9QrpUtSNa+UOoJe7tDoHaHnOTaAFku14xk3qTNSKlMBIJ/7MsL248WY/X7iuxu
         ziylhp+7MMgLSLMOX5kraksgiIPcaTxvKzZwG0aCBB0EaloE1h7kKq903s2jUryLUfqI
         9n52fEGugW+pk5aljokSYebIzpT7obfKIkrAF9tS8IaSfr/LeiTeYkB1LtnTfQ9FZTlS
         1tZyTbVYzOQY3TpkwVC0QjuGqz6I5lx/PeHDJtLNakt9hKLYSf7LC39YftuBHFI4DB5O
         UBOA==
X-Forwarded-Encrypted: i=1; AFNElJ/pB6svzPv3lejo6GNo0Mz60mBjHfcjy+irb/I+v4lMMbIh233g9iTE+HgjERjCROOwGx2Xk3hGHJakRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPwHe8Sf8s8/AgMxkHXA2irTk2lsKhoLPWJLkYPqeIUiBwlSI
	WW8sa5YoZ1hHJ5DZlwHbFpV3GBMfmJwEK1kLaze8/QytliH9FEEI90f4
X-Gm-Gg: AeBDievTytlmVKS6RUgEPeN8UUzWHJezO2JjYuCoRqWym6T4raEa9pD53o50+CWRtSt
	rM0dKIHt/f0dTTKFEf32XbNOySfHWtH7mfUdlxOyfkuvhHkTpxSfUPUFV68S2C5U9JhAfyyA3Il
	gpnP0+WH4NrWDCHcrLYPsq/0DT6pu79S1PU6x4yAuxfRRSc7UddCx/W/ExBKegshqN+cbjGgL5S
	RDKyNXcKxnd5Mlv/qQ+UuW3jps03ajtam5Kw4iW/aNG6DF6ZlUanvAEH/Ezk+QJG+vf8pnVbZxm
	1s7/E0EKJBXMNwvq9JNOdZzH4ttzcucZiUX47Aceel6PzYgl4pKHHW6tGyM7xhYZpZL5PFcEZ9F
	cIXW59pnRhvJR6yfywJQeJEKbBSoYuBpGa+gi+dJVnUUp8ZsQ0VTUVOdjbSDgcxLk9wAXUM0RJr
	Tc8SlwRjCU6reCn5d+/7F7SJk=
X-Received: by 2002:aa7:d1d2:0:b0:670:8d90:e861 with SMTP id 4fb4d7f45d1cf-67c18ac5421mr955797a12.6.1777725675575;
        Sat, 02 May 2026 05:41:15 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e281cdsm1649649a12.3.2026.05.02.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 05:41:15 -0700 (PDT)
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
Subject: [PATCH v6 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Sat,  2 May 2026 15:40:49 +0300
Message-ID: <20260502124055.22475-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260502124055.22475-1-clamor95@gmail.com>
References: <20260502124055.22475-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

