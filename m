Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0649382397
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518438; cv=none; b=CGTjgKQEfuN1PvfN5fQE5loUuW6Ag9dnTCAZxJnZhTPQxw3xaWDW0IfKjLeLFAOCwyiEtxeqlw3tvSjBYd7WqyO088v2xTZopCrIWgr+0D0/+ZPygQP6ym7gT8POIp+hqqgHiixW+XVIjYCjkUj4PbME5kruHbB90963/tsdv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518438; c=relaxed/simple;
	bh=HKsF8s2CN39ptYXnUpAjllMxDvOrGH7BmQr/pDNdroM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAVbX4oC0SueXVNSJMTS60h/Sb7Qcnuev5UhFXVFGP3RrLdJz4UTiWC0Rt+TCeKuQTr7vZJwwR8AfIMFHhHsha6P2M5VqzXJizrsIevbsVhfTgySELuXUXklvcWgM9JZS0cHjH4HccKvHfGuPEv1S0ictgfUyKX/eka0co3bi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YnaJKba/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YnaJKba/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae43042ea7so26433145ad.0
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 22:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518434; x=1773123234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zbYunSd9SIDIr6FUrKkB2zIIm+2n+JbdlctTH55ffY=;
        b=YnaJKba/CUPhw6WwK6kd5nrN5VX9i36RPXyzclk5PLwufyN7lcKbfUO4l8c/CSHPcT
         nMY06euorAc+J+0Jv6l2JaF3u+TrHniCG11W5hN3kKgRQ6iSsSyz1v/zUy3VH2mu4toi
         pKNA9nsVj+zL8Nw3CEqskl0bMs8cC8mQGB1Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518434; x=1773123234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1zbYunSd9SIDIr6FUrKkB2zIIm+2n+JbdlctTH55ffY=;
        b=guNeFWjrYm4JonfnHgqdkLjYa+fXP1DbmnT7YpWV51yIR79tatlD1MMQNsVOe0V9O6
         F3ASG41YOXbB0Qq/5oK54YsXa5CGS9lEXNL6XlX/Nyh1vcA7sPQZv6fEhDZc/O39gRIF
         NmGWUTMia3mUzIpDtFVjjxUfoe5K2lXHfVQGBFpawyFeSIIG+s5HOmLcoFLj5QsRrDRP
         YRAWYwCWK7vOkOzPlKOcoTFflTFTwewkw+DfiHHnQTs0/iTiWECcWzDqko1EHmCzSP7n
         mf2AkVYhIrG/arBPLuEILnoa5PwXWS/MSRe70yid71CG7ASf7abx5CbBuxGzlivmP/UD
         9WcQ==
X-Gm-Message-State: AOJu0YzWptFIwe9ofTTj0y7suYshn1MgfguILAX/AdHreEBe+1SkPrX2
	knFv/VjouK1SkJB0lczHAFCMjAgh8ee2h4nYpck34cXIGr6ojiX7COcoTECFI6ECUA==
X-Gm-Gg: ATEYQzyUbCCxyXQNfCIa8SqGFodciontbQo2V6pSZveH12VtuXeRZq1wrMg4r7upLnH
	B9ocPYqNbkfPVwgZxVd+Luo4VJVlgBEK4rkssYs6wwNSW6Yjv+a6rk1iuUqgDtl2tKLw8JMM8Z6
	ilPtM6d1RWyLqtoAk/5dccPUT5KILyqVWB1myDf7FjI7QniH9xoVXKI3t/CpfyEymprVYknJXyW
	wx0QaK3ii1MHJTwVpboUkiwK5s8ZK0/cZv8dmropR1MKXWlOm7/68bar11xU3Am7R/NW9bUq8Kj
	5HiQza8rq+kLVBwb1NWL1NgXsgzxXZ51km9K6dxaToHyRaGYi1aUVwnQsJ1s2NxKXVa+g8WKdot
	U3glc6VM7G8pvkIofFXULaS7Kaznuqt/LBCXEqMD8RzCsO2VZ6wBoWvVAxHtr2LtRXfEdYHeATi
	OF5TvqGUlaQPmTnONscGLkYgQHsM0asMuwIN0SWnXS35Da24NxheqRpapoTVx139f59WlKDe1BW
	cUBs/cqmepWyEgNDFtzw6YweEcz7l2Aqg==
X-Received: by 2002:a17:903:1786:b0:2aa:e817:1bcf with SMTP id d9443c01a7336-2ae2e4d7a3bmr137864645ad.51.1772518433772;
        Mon, 02 Mar 2026 22:13:53 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:53 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:13:01 +0000
Subject: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=5693;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=HKsF8s2CN39ptYXnUpAjllMxDvOrGH7BmQr/pDNdroM=;
 b=3yauzbUstrOGl5qDbA/zaXfBs8F8XvC7hZJ8BVjAu9S340VlZ8h1r6uNBWzD+nBmeke1laoEl
 KMLb+MDQtJyB1u7HQFp7CyBh7fKvz7M3Cislqv92CB/53/zJ5KRua02
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
 .../devicetree/bindings/input/hid-over-spi.yaml    | 153 +++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..b623629ed9d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,153 @@
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
+  The specification has been written by Microsoft and is currently available here:
+  https://www.microsoft.com/en-us/download/details.aspx?id=103325
+
+  If this binding is used, the kernel module spi-hid will handle the communication
+  with the device and the generic hid core layer will handle the protocol.
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
+     A value to be included in the Read Approval packet, listing an address of
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
+  post-power-on-delay-ms:
+    description:
+      Optional time in ms required by the device after enabling its regulators
+      or powering it on, before it is ready for communication.
+
+  minimal-reset-delay-ms:
+    description:
+      Optional minimum amount of time in ms that device needs to be in reset
+      state for the reset to take effect.
+
+  read-opcode:
+  $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Read Approval packets. 1 byte.
+
+  write-opcode:
+  $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Write Approval packets. 1 byte.
+
+  hid-over-spi-flags:
+  $ref: /schemas/types.yaml#/definitions/uint16
+    description:
+      16 bits.
+      Bits 0-12 - Reserved (must be 0)
+      Bit 13 - SPI Write Mode. Possible values -
+        * 0b0- Writes are carried out in Single-SPI mode
+        * 0b1- Writes are carried out in the Multi-SPI mode specified by bits
+               14-15
+      Bits 14-15 - Multi-SPI Mode. Possible values -
+        * 0b00- Single SPI
+        * 0b01- Dual SPI
+        * 0b10- Quad SPI
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
+  - hid-over-spi-flags
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
+        compatible = "hid-over-spi";
+        reg = <0x0>;
+        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pm8350c_l3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ts_d6_reset_assert &ts_d6_int_bias>;
+        input-report-header-address = <0x1000>;
+        input-report-body-address = <0x1004>;
+        output-report-address = <0x2000>;
+        read-opcode = <0x0b>;
+        write-opcode = <0x02>;
+        hid-over-spi-flags = <0x0000>;
+        post-power-on-delay-ms = <5>;
+        minimal-reset-delay-ms = <5>;
+      };
+    };
\ No newline at end of file

-- 
2.53.0.473.g4a7958ca14-goog

