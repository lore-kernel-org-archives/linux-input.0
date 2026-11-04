Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795188;
	b=haaAVp8rtGRNAZ1ZblKCciZQIS9T1XVXx1WJq+FVaiCXtqfWBx4bVgK77e0jA0FuVsnp
	 R0hJkzw6KRxAg+JBe8e0kdNPazmszp3aI7ssUI80qzkWGT586s2IKBfxoERMp7Y5qr8Yk
	 QhD8NzmzORpeMO/GQ2z+NCL7YZE3YRDUi04SF1PPuybK6sqz3b3fR18DI/g5j3pn6Du/C
	 bsZmYHR5PLSwAN0gyWsz3NCa42DcSUKRQb1NthvOPQBZm/kvgIQNhiYVdsSZR4cOP3IS6
	 /wrUFi42MpP/jLmuHzk7m3+ZdWrwx+AzyVcVMRE6nW7gwqymSB8on/6EW8GcvgyCEfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
	b=EAq4U49eRFoAY2gtovjZTgUFWFjf2p7K6cGNX5jUzkZriaQQ5kMMLDETMVefsQpEkJPg
	 TbbedNncAbceil0o6LbO/u41fdOEQXgiV77TubH3oXWYxgrcjR10YZTWCFDHQXbjcYLp9
	 z2VBJOkteP5l8mciLTXMgzu6FnYfYNcKOFmPWVY1ma6FHAJli2itsYfpk6TRH7SdXbIla
	 GxG/gmC4UqBjQM5FwmL3YcZpc4SLyqYCO7WJBcgJ/SpUdtHWw+ZucN1spFKl3BcKZZ5Y6
	 XEWywD5LXo4t1dqw8mdRKd/mQSISFjA1vF+OFUziOTU+sQZqaA8vJ0BKQR6OstVTkDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqxTgXZC;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5A606D80E
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 12:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F5A606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqxTgXZC
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so5072375e9.0
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 04:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795186; x=1794399986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=zqxTgXZCedl88xAPuNpOKy5fkDuI/WY5HEZHcMrLocsOyvu65KxpiKziAlKb5ah9B1
         yCl288vMVkvMdiPl5/3Vui4txDSN1utH1vfyc20VNcH/IWtCoFQIjxg/mozXyD4ZhAUs
         Ac8bgLWYI9wAwDxNzSLAtJjWYxxRByaEWfNF/23IFcyXQ2pCnNy/N6B2dE0A4Q8Fa89C
         hBSxJY/4RN5a22kyLdZf4HkmUM9EfC9uu4b9PdkPZ7o0EIvsezP3JiDCy3ccXu6pqYG7
         qCXsNU5nf2+jLQP4XxE8fNz4dp3tGW8L+d+0qRj4W/3AT/+tHGAZOz72gv0JUCErPrqA
         Ehkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795186; x=1794399986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=xyu5Pyle/uicQYVm/6Ex9EgvBgVCB+aQxK8NyMHkNSlIlHD0ePTp0TpVDMZ4F1jvla
         +qNgcPNBkTy23SjDfmNBV/TrOO6t2hl3EA6mmEeqgY/avTmwnbsddrjTAW7ttKqiGet5
         f/GH9DHNVHckpLLopb9D00YdT3cVYGZbQ9nnRy3Fy1NXgs0chmGOQhh13JqLf1otHU9R
         AZFpraXp72WboTJKn7lUwxhhAI3VC+lan8yBpKi+ezAPzA8SHovspjnCkytKIu1Yo2HW
         2rb6HA32dVJmde+FLf7VzlfZyPvVJfXLAMcryHkh1QAzPL37fKdYnz+Rpb5o64E9hZJ0
         NBQw==
X-Forwarded-Encrypted: i=1; AKwUvBymWgGMllLNKSIzfNby+/mpzDsYKjxIBXvYh8ghhWN5VVAVZ9mjSJRwFkH0C9PZL0lrGbhmjoEYMtRvww==@vger.kernel.org
X-Gm-Message-State: APuU4Z++WcU2uJk7s9aRYeXxqSo37a/A7UglQl93UqY7bpsJyG7zXdq3
	Qomj2Vl0bHMEqwR1HlDhvkfp8OUS/jN6t/sojsP/Y46x3UF1dTVdk6P2
X-Gm-Gg: AYBFou1eA30Ykp/Gct86zGP35uwIYP1Csl1ef6ZxyQ4f6M85u4YJEr0jWO88JirqfYg
	Z9nTJ79w7MODOjPlJPHgn4SnYd8ZBxj01SmkftUcLMU0EpIcmdKAvbhsXqb4Ie0e2VRdcq4XZcy
	6rz1ku1PJAAxYk7mRfNG7wPHvWKsAdeJKfo7e0T0AMAgtUiOychbPOTyrZNj2JJr6NUVmpGjala
	Fg1NgYs5sTtjAdthNYUUAmM8ULO+ALKd8UcEgFJXXJ1AKTVpvz8kHsSgvD3q7SF9ZbJ8GasCLf3
	Mh2D9iad97UqYxXrKdw1eeccl8qDudwsBBSIfRNkrShdSQ0U+rhOr2ES8ngKHNMFN8T6m/FAEPk
	nS5bAYhEr1ymnGhVQjktZa7BQql0UkItWPpmYiLHAFDMcYNdGjIolqSh0JAIfZCbMwji6TLf5dd
	k9VO+G3Jf3qQPhkhhtlQejYL8y1gqmyxjtGrgrzKiuLooFivrIElOkreEaj8+SvbE5AHdkQdUhy
	eZ45BsLxPjwggoluItQg5DLjR/gifvo5b9PUHfpx8qVNUFKOfr8pjK0d+seB2D48kQD3hNLBIDk
	UQ2o3tw6xtbQKotd5Z0OdCH99n3MipopkbU8PzTB9c6e0ys6NQ==
X-Received: by 2002:a05:600c:698d:b0:4a1:d97e:cd60 with SMTP id 5b1f17b1804b1-4ac185bd1e2mr362326075e9.16.1793795186366;
        Wed, 04 Nov 2026 04:26:26 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v13 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Wed,  4 Nov 2026 14:26:00 +0200
Message-ID: <20261104122606.215629-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
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

Document embedded controller used in ASUS Transformer device series.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../asus,tf201-ec-pad.yaml                    | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
new file mode 100644
index 0000000000000..60b6375864aaf
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
2.53.0

