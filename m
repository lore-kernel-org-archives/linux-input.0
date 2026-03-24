Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D553C6603
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334421; cv=none; b=GgfMeQp0SkpgU0dGLOXUzaRZYBLM86zu+nIBXvqNCaurlGpCRv2629IeCurP0V8Hf1tiVjpwAORxFvA1D5T5MiGgQ0YUJzA6/6tZ/5jLGIgJBugjhvgHNUaDqDl8kNHVWZzTDu9vr4m5qFlEfRE3GkdS8DNNTgozAO15zSDtXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334421; c=relaxed/simple;
	bh=I0x2CYlsya/0TkxpZg4isJbbaEKJvgNnG/ZcBXcqYso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDNtB6nHl1gGjrDLdtBW+yhp0MBpSnSnRk7HkvjEppafU6C9gXZObvJ7q1xyySP0kia2Am4wyyjfB3/pMS7w3IzlFKd8zPsqDRd5H1jh2ZPTkjACyaOhjIJ01wpCaWJDpWKTytq6WfoiYMBzcICHBuM8m3mav5uWd67PLRuR6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPe6YGcf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPe6YGcf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aecefc7503so37343465ad.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334411; x=1774939211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmfN5FmsExdbcn4DHUdyn65cCMHIcyMfjFNYjbqU8ZE=;
        b=JPe6YGcfmma5p1cUw0WFcKwlKmvj8pYDCH9sodtY7xVmMA3Oqh8rBuk6Rfoe9cvwCC
         LAxHmZapOrOX67nhBrj77UOb/QWaGDsjjiBsoH3pmgsrP/0bp++l+eB2E+5DjmuJkvPl
         Tv9KT33Fo1kmQ+s9AHnqrONUAcQjAYRnKfT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334411; x=1774939211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmfN5FmsExdbcn4DHUdyn65cCMHIcyMfjFNYjbqU8ZE=;
        b=K804fXpnwLIcm8WMtPtFkO0tRrd1bgF5dEca5IIzVSNqNwQUUdTEWn8C4xnLJ2w1VO
         ljPELRx6T1kvYXtvLxTmblKycX2KOUun15ZoNVybPUjyQN+UqqwK3nO1Y+DZo0kJf5O+
         L/BCFrDvYxvbZRI5y/MZ14Ynsf+QsFgSqge+3CgHLPvztRwoKYUOErRKBj+XRJoRBCBY
         Ou7p+RlkZHIqLpJyLsPL0tGGr2oEQVSbtffPoCKKnM6PEdA4/PFh42CP1e7sUA0wqJhk
         kbysCTG1vcCu2iNKtOhGbg0l9U3FkosRa2EI1DeRxrqgbjzQnySwvP9KM8OU3E8/nOeT
         Gssw==
X-Gm-Message-State: AOJu0YzFVDTpmQk0sTMu4JUteufSyUKISu7b+tcum64eg1zFAE0edDM/
	fq7GqyPUJfz9K0Mh+j4sbVYSg0gn70TgFyMIYd++DwQHFm8RUHZEr4WjMVY22jLncg==
X-Gm-Gg: ATEYQzw7GOPp3f1tsq1tSxtVnlMhqeGdgKM2M9LIRfPeyqK6oxJ8bPpGK5WBibf5yNN
	+BOtvrgQL/19IJeEy0nMtaHiWpmzPS7AXhQcMzd0Hb7csq1eApLeauT/J41hDm0x9j+0+PCREwd
	XguQh4+SVrHJRKiKlI7lQw2epMTVjsVU7MH9i4E6sSxaZxUjXF2qabf4A12WGPJtk7DyyFvFDSu
	pl6A5mShrpxE3XkdAo9CYSqa5Bj+V1ltVhg0V14sQOl5rTm1QWrAVystWEG83JEWO3tSWu/G6gj
	8OD//09Er+M7VRmiEgTSR1t6uLOgFLSch4pkEefPbBpQVWcp0VelTVDj/2SRaFo++q5Cg7CnDFt
	Vjv1QC3U9ypFZcc1O95Lgcx+usMQ26Mnu0PiI3+45t8qnrtEvHB3y6iPmJQ7w3Zd9I2t+ckcKnM
	nH7if9A33jnRVv2G4/747gyKw2b8pfJAwsQHDb9tEso/kWxfJOhtyRWlA+YfXOpylx0FQvQAsvV
	2XRMY2AeSQaS0mgDc/nvAen/bdaV465fSawQRfp8uVS
X-Received: by 2002:a17:902:f651:b0:2b0:4d7d:fbc8 with SMTP id d9443c01a7336-2b0825e0b04mr139394415ad.0.1774334410624;
        Mon, 23 Mar 2026 23:40:10 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:10 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:42 +0000
Subject: [PATCH v2 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-9-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=4683;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=I0x2CYlsya/0TkxpZg4isJbbaEKJvgNnG/ZcBXcqYso=;
 b=Wd4UHeJCa7yzoQMx8kpcrdTRh9ZPmUZ2TgcHdNkjZOoJrOu56ULT4r/WjLCmtbtGg/Lffo9HD
 mwgl9wmJhmvBIaFZfYBBF7eQ+TVVS8ocx+e4UQRW6+Wvcw0ow6HtA8N
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

The properties are common to HID over SPI.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 .../devicetree/bindings/input/hid-over-spi.yaml    | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..d1b0a2e26c32
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HID over SPI Devices
+
+maintainers:
+  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
+  - Jiri Kosina <jkosina@suse.cz>
+
+description: |+
+  HID over SPI provides support for various Human Interface Devices over the
+  SPI bus. These devices can be for example touchpads, keyboards, touch screens
+  or sensors.
+
+  The specification has been written by Microsoft and is currently available
+  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
+
+  If this binding is used, the kernel module spi-hid will handle the
+  communication with the device and the generic hid core layer will handle the
+  protocol.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - microsoft,g6-touch-digitizer
+          - const: hid-over-spi
+      - description: Just "hid-over-spi" alone is allowed, but not recommended.
+        const: hid-over-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the digitizer's reset pin (active low). The line must
+      be flagged with GPIO_ACTIVE_LOW.
+
+  vdd-supply:
+    description:
+      Regulator for the VDD supply voltage.
+
+  input-report-header-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report header to be put on the SPI bus. This address has 24
+      bits.
+
+  input-report-body-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report body to be put on the SPI bus. This address has 24 bits.
+
+  output-report-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Output Report sent by the host, listing an
+      address where the output report on the SPI bus is to be written to. This
+      address has 24 bits.
+
+  read-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Read Approval packets. 1 byte.
+
+  write-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Write Approval packets. 1 byte.
+
+required:
+  - compatible
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - input-report-header-address
+  - input-report-body-address
+  - output-report-address
+  - read-opcode
+  - write-opcode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hid@0 {
+        compatible = "microsoft,g6-touch-digitizer", "hid-over-spi";
+        reg = <0x0>;
+        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pm8350c_l3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ts_d6_int_bias>;
+        input-report-header-address = <0x1000>;
+        input-report-body-address = <0x1004>;
+        output-report-address = <0x2000>;
+        read-opcode = /bits/ 8 <0x0b>;
+        write-opcode = /bits/ 8 <0x02>;
+      };
+    };

-- 
2.53.0.983.g0bb29b3bc5-goog

