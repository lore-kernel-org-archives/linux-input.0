Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F85365A14
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098382; cv=none; b=r1hIe4o9NeWiEgg08HV8lZRW09/dP2bXmbuNTxk6E8L8iZtKqrgMSTrApPvpFXQi1t8fu972KZJDX08t0hMzlA5ZPSWJG/mVj7EMgPiSZcO7FiSpU/ZGtJ4ekRs9lUlkDpv4yrEVk2uhdqugkp85VNUb5+BwLtuZX06cPKLAV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098382; c=relaxed/simple;
	bh=or+EJ07SOsHtoyrRm94X5M8kiBqJd626zfaT/m/MjG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCkYqHoRUo+CDmrg7b8ZY1P+UWZssZjHewzT++oIe2zbeIqMcjrT99aEEtAZSaDXgcFfSmQLcmJDVRAKsHqdO6p+gOp3bLOahxvEMrlnN0DODtwI/Eh4Oxi5mutSMV/MacJQTkcVXXXOVnqEx6QwR1hWE26fOJDVe6yFCdcwGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhHlK+PN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhHlK+PN"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1029102f8f.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098375; x=1779703175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=MhHlK+PNKlu/c34xaAOmHYeAhOebNMkpHJQtL2f4SKgGigePk/5RE/Qvhzjs7lRJZi
         VMecwnoXqipnrp7G5nKmNz5lWksaYfqybUWvLUBThrkwAgjxUkZCf9eewGLRciqnw7RO
         1DgJ63ygH4zpTpHpzgTuhZC35LzhCqzqVBxcystfJuyBPzUuDVUsa5KllFvX9SFtjyyy
         mjCOZ7VnTfFlvKZf7Atj+gfkhsx75GztCoVozOyfNY4dCXhDJ/yTNLNPk9eBGX2x7jlh
         DlQh8nOrnYVscQwMfuSlbAuyjMrPEB3w5VrSVtZu6gTn04ieUw59sD3XblsvoFPaguSL
         53gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098375; x=1779703175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CuxBA1Jnwii0AQo0AYAcpS9dZCQZKs+YbA2PPOQhDTM=;
        b=RpwvnmOCF11/lnCKInUFa7DwatD8tPtuKnpo9hE2TTj5DFACkD7zv+ZNFdoCddqzi+
         V/TpQFZvHpyP4IzLpqb3h3UdCLqhqMCRxtDyGqt7qG11QPRhem5sjM13pzprogsPUF2g
         hSjddNycZqsYFPdjNqBop45WBHctCZvryQ8beQUxfMhklKF9Gs7ryephH2I231osFqX7
         KNVuuBGLApiLmQtypdYaVJKHv1n6ZbYPlrNeUiEiyDCqQ1T9iFF5MeVpv/quHrB8YHEk
         S2OBIPgkV5M0wIxrLKDdokdLsoSJm67G2W8ahR64dKKVpH48qqCXfKjU9v3mfqGsLQLS
         hd/w==
X-Forwarded-Encrypted: i=1; AFNElJ8aFYeRRP4fH2m4l6TayYCy16Vlbme1TT9jINQpKrY9DB8sXqnFTJEDl6e3CJR0WhUkywHAIRebMpgRig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFhlcIZETXIuxtmLSHlTfBzcv4DE0wOd+Ds/pWSdnDMKpCZ12
	2U4A0IRuRfxLafdebv64lBofja0Dz8mdmDmFCGwoE+EdSa52nfbdsvKt
X-Gm-Gg: Acq92OEZlNY9T0gM/JOHMndvtNCSgj5tOZqAl+HgrqHEd0HEc/OKU9ZeffMsZItJoR6
	l6nJxXIJOoUfKrl6wEbuhjd4VKz3gxUupnY1d3MJzJyE60ZJgRyvFHNMoHY85NM8O6pOg/YOq0l
	+dq0VT9n8IVgvjTPAJ/PrRLfSf0L9ZR1ApJkLZwq21weZ4cTy5YuDs8JVtsPW4xftF482kGNMR9
	YeC8qbx5nwMyBSbc0BZsZs2yJnmqwuYc2A9BxzOBx/wtCTJXrgk380/kyODBWF6Oou/UE9lynmH
	TC5bszAicnvdinyOwprrUpuVzRARqjV1jlR6bhqtGAchYprdbWAuL1vk1MXH9PkhFAWzktHCb7D
	mLg1t7GJgssN7Q13XHDBcVfxNcsBnRc78+u7CA4BDdDhiJ+5moS7ISfITvd5le30Cw8aG90wIkd
	LIsoQLJgmlYcvs8qvc1dHIjao=
X-Received: by 2002:a05:600c:630a:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-48fe632663emr252629925e9.18.1779098374859;
        Mon, 18 May 2026 02:59:34 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm102995005e9.7.2026.05.18.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:59:34 -0700 (PDT)
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
Subject: [PATCH v7 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Mon, 18 May 2026 12:59:01 +0300
Message-ID: <20260518095907.36158-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260518095907.36158-1-clamor95@gmail.com>
References: <20260518095907.36158-1-clamor95@gmail.com>
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

