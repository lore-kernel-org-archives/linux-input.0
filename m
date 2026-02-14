Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E9A3033CD
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092621; cv=none; b=FraxFXQQQUczC0uOYCcuyg/FlwQnskw/aY/fq+c8RhiWyJB/90RPHynNEZk0v7wNQ6oEpMlW772wOJgrF7+lw30aocgB5cunfdxkx45IVsxNdB8zsPeaKi5MA3+SJKkef9h5vOIWhgqjOWIYGBBNKbTB1n9LgZYPXUqhoegrKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092621; c=relaxed/simple;
	bh=QZTJEwKYzV2sVRqc06XpTa0kqL6atv45Fiv22ciLWLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqrsXcs64QEKz+vUuwnyg0xD/L0kWxVQSf0zoeMU+wO4o71haJMdt/JdZo3T1UHNGbuWzJLywk7lzeBSS404Uo+RVMrEn1CObF9kyAhDsBbTLhlsyRY5rT35DMLXCuZEJOtynBv9NKwcmgKLfTgGDRWu8gsNfeylQfDgky7s224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODBjkYYD; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODBjkYYD"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso2488210a12.2
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 10:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771092618; x=1771697418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWhSjDBNQ6gvdK4qfNH6bG1uloMhrN0yff4wPN7T5UQ=;
        b=ODBjkYYDEsgb4K3M/ZMvkTV37qtS4lO/SwQOY1Yqp3P2KEo4JxBtRoL3vlVx7ihLmZ
         ejQWJM3xnSeCNxtNTFj4BsxXbMw11quDSoAqKlmXYmoisOaCRoNdHMUvLTvJhVMClfnY
         Zy/o8BNzetho3EQlhNW3iqwIADDNX93B1nwMyFklZfLdzcDEQRzw0dXLfUzNFlK6cKKp
         TsjSxpCsIPl4IdMydx3J+bIVTEIl4YZfUygUVqMUihVfDvIzyXuEuD1phL/p51DTZKwk
         stFDeo5qMSFfrmt7lXlWpOigotIYRbsYmAuP2AyXvOIKqqOZ7lCG25BiHoQCSow1Pxqk
         +3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771092618; x=1771697418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWhSjDBNQ6gvdK4qfNH6bG1uloMhrN0yff4wPN7T5UQ=;
        b=TvaF7sXlkH3FcdM6UHaJSrtEd37RBg0pYFJdCxjqdnpqlgMzvB9p8jzV9SbpZL4+3F
         HFeEai24UT7BwRdOAj6IV8CFXoprGijOBjVgHdvW71jwoQKkjEHWjTdY3jFFTacuXcn1
         MQs8SnXvlxMm0Kh7tHVpF8qZvDsP5J6IblNeoOghieaEriEY/b9646trCWBn9EMiZll5
         lCfWn+hlHuNDoHJFBudbZ3YMA1FfbWysKzb6zgVdL4ZEgZsn/mDAqFYxXcX/O7B0MtYP
         jUtZCwvJWSPkw7kFqARVrmgMV+zDpqWTTfS5yFVs+XQHrma3y3FsJturZrxcWsG1t/wx
         ORfA==
X-Forwarded-Encrypted: i=1; AJvYcCXh6LPur5gQ9uvx90IKcs+TlgTOvHyCBOYhV3a88obSiSniHqz6VTaib2cewJtU6SRmqUKsazmL+Omr0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6wfXbXBlqO+ECgP6muJ6CyLEE2s7XljzJo2wSXd5tCvOw3FC
	7zh2648F4r4pDhuxrPQCOy2JpeZfGdGjqr2v13bPisWbTEY9MNpUB4Lp
X-Gm-Gg: AZuq6aLY6ZIph/HQs+6Ki43dSU6M3wc/eHqO/WeEvsP8IgvUIwpcoiQ638aPDART4J9
	kINaBgNyG3EbfS5mKvi0UyTs42daf2kR1C54B2N0dal64PiiqZXhlpD1f985qmQd7wNXqkS7fRk
	+KvFXE9MoJOQ8G1k7jy+XnL5fRzN5nf0IsdUUhTghFEzQJnrOMCCHtoNEMGLZgOKC8Pl14shQdR
	irzB7VRTiwTFyEdQz7oCCPetngi3T7dtUPyahcp4/XkD1m2cpQviNtWOI5X1Kql27OBX6OO6Gyc
	A/jfaZ3T3XiVJC74dvzWSNkwXgqPY8Pr51K1414LmXIu8mv/wzFA27FM7F9O1gdhwNLs2lde1Sx
	9n/lXeSUFg3M2TmXpR2Ybh/oomn/ITQ+4rYLIHljgAwYSt/1o77Z3Yza/XqP88tfklWs+DS1JXp
	Fw4LT0uGxD89B2CJkQ70zyOyE=
X-Received: by 2002:a17:907:3e8d:b0:b8f:b32e:e1b4 with SMTP id a640c23a62f3a-b8fb44a8219mr338323866b.42.1771092618132;
        Sat, 14 Feb 2026 10:10:18 -0800 (PST)
Received: from xeon ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e506sm88122066b.11.2026.02.14.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:10:17 -0800 (PST)
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
Subject: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS Transformer EC
Date: Sat, 14 Feb 2026 20:09:53 +0200
Message-ID: <20260214180959.30714-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214180959.30714-1-clamor95@gmail.com>
References: <20260214180959.30714-1-clamor95@gmail.com>
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
 .../asus,transformer-ec.yaml                  | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml

diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml b/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
new file mode 100644
index 000000000000..670c4c2d339d
--- /dev/null
+++ b/Documentation/devicetree/bindings/embedded-controller/asus,transformer-ec.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/embedded-controller/asus,transformer-ec.yaml#
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
+    oneOf:
+      - enum:
+          - asus,p1801-t-ec-pad
+          - asus,sl101-ec-dock
+          - asus,tf600t-ec-pad
+          - asus,tf701t-ec-pad
+
+      - items:
+          - enum:
+              - asus,tf101-ec-dock
+              - asus,tf101g-ec-dock
+              - asus,tf201-ec-dock
+              - asus,tf300t-ec-dock
+              - asus,tf300tg-ec-dock
+              - asus,tf300tl-ec-dock
+              - asus,tf700t-ec-dock
+          - const: asus,transformer-ec-dock
+
+      - items:
+          - enum:
+              - asus,tf201-ec-pad
+              - asus,tf300t-ec-pad
+              - asus,tf300tg-ec-pad
+              - asus,tf300tl-ec-pad
+              - asus,tf700t-ec-pad
+          - const: asus,transformer-ec-pad
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
+        compatible = "asus,tf201-ec-dock", "asus,transformer-ec-dock";
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

