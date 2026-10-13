Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC14BE457
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912934; cv=none; b=RvpwsB6ub2pevQ0CKiPnu4hkyyBDDaVzhT7EKnRWNQig31ZXnfHEuT2q9jSwwmdDg2VP3fVBu98jn4djrVSf/rRwzoJji6rrBO9N/VhZVpUg/QnAd2S0TmKHyjTDV+nGMur6D4vCrZgncg8Y56JNkDToEUfSc5cFmAnHH4l+Nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912934; c=relaxed/simple;
	bh=0ir6EEm9FNQCLp9OUbkjQzJH24SRp6mnaINdn/CT2yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeZjKHpiI9BOtAzO5z4PAcNc6sOofKh0wznTbE5ywbFHCAJsMOztP5bHWji6K0gVaR9g2q/BJ/oF+sFis23qu++DrTKhTAGbR4UtaKXFP6gKwZjXNpmqnApzd/YFtR99D/aPvGWTnM+Y3XhCbA/ZjZ6F6Bo8saWySBe78TkBfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVt2NfHt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVt2NfHt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso23227845e9.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912931; x=1792517731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=aVt2NfHtP6jHB+WKrB7b+cZ/rrzgNrGpYjHqoGs1BQdg+0mXKgJRpf2ACXyyN7JJwh
         kvYeG6XV+LGF7LcVFJOKLcGzhyHLPd2kSt5CDFD0g/s2IFv6kwuffltnZxln9wHPo+jf
         x75omabmofoH9f/bkENX4SnegJE76RWNkbZiksRtMWV8OJQy8Q2gzkMkyja7MbQvKu3/
         HHrjRbFQKhRcm7ilBZz9vptGa5+6Bd7VWDx6PzIJe1/aLZQpyIUWAcHm2/ib8VEpElI0
         ozbZXnZ2rzWjDJSiCWttNmyGw8R1+SC+0hDj/wNe1EklyBjZsQkrucWR84Z4RS3kmQBj
         roiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912931; x=1792517731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y460qay5LS+R/33REWXsFlmhxRCfcVfcAqdFzdNEv44=;
        b=Sr1qacg5OzsqZZ3fSPiFQ9cOCqQ7OMRUZxOZYkyk2ldfHh+G4ExRutAxs/56WyZLpT
         R8PjPoJ9VymZUJtXXwl08a3AVbMow0P9yT/pSUwbzdqOip897tTU3N2/6KtD4NRME+RF
         lDRbj55UNYqWdMRsBxVImdSG9SUgrBn/hwWisi0p/xnwV9PBJngrexjfRIOWguANIQEm
         z7vqv6T521vUyJxfa8VF39NkmtBAIrKQBEbH1I7UfrFpXBxVrEEUw9EKXzYFmXkRZcL7
         tocNArGHUgSucWTU+fLY3vQ/DJHvaqONtPzrPPmisK1XqRFm+ISm8kfLt1fQsakhwmMW
         Q3aQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDYEkUxz9YZrrrz4CI4py7+1jaRo3fvDK2KxZ8aHKi2O8yRz5Q0T46dl2qsWjzaNtDszZ1HAyTub/UjA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIQZghY1vippQfxbbklznnJg2CysbwLRmwvYREfJfhv/YJXFfea
	HeRkcABvaDCRojrYHxybW5WgIVOcOL3koJQx63QgBfW6TF/n1o4Tjnop
X-Gm-Gg: AYBFou0+QFGAaOsmg/mcvC7cI3E6ztS9p5WtapUalwSu1oOKn58TFqSbpNguAsfz3Gy
	GoAMGeeNj/mhe94IiaYL4Zdvhquc4QiZJR2E5IpStjjdvVq2DCfC94bliCG93V6ES30NNfuSqMy
	chIVo4BYWoRNlpHivho5wfoEawR+WIxeBGihBU0mDIZqYIWJ/7MHh1oCkoBNqSfXXzaaySrd2U4
	fKD/a7gUYyzvTZTNWmb5Am2zp7xo9/tsd67j4YKJOeW1PHRydS7ds9PQWMbj1AKBXz76prWAN+7
	74pm4v4fcxQZZPD8vrguH6DouWk6KOciHDe7OijsRIzRQ8pelBnb/6L8TKvCovZ9JQunrxfgUfU
	W2O2o2909Q+uQ5J5b3tR1wlDAhMP88nklSqVeTbBujVHX4rcDg7ml5vy+Yt+oByb+YKmtgbdETu
	6pMCKBeQQDpOD2x/TqCpOmZb1vqXQbRxwOQ7rthtGZcYtPJGiFb6Eq7ii4K4ESF6ZUdxddDDJDU
	zgAaXg5ItmbHieuUWmOxzTs3DLABw==
X-Received: by 2002:a05:600c:64c8:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-4a18e4c41b0mr240687655e9.21.1791912930626;
        Tue, 13 Oct 2026 10:35:30 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm284127195e9.4.2026.10.13.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:35:30 -0700 (PDT)
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
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Tue, 13 Oct 2026 20:34:57 +0300
Message-ID: <20261013173504.451391-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013173504.451391-1-clamor95@gmail.com>
References: <20261013173504.451391-1-clamor95@gmail.com>
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

