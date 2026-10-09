Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2087B509F05
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584813; cv=none; b=I+KY416+vISB/Ad0FQ/1o8TTDrGerii5kg6HTv6OSUQlvvl6eMEaAQp8Vkc0rAg3+G9ik6mSdeQy1UnvhpqCwcVBlI1C2DR5JcrGKacuOr3i0VX1RXA9wjsd02+eZ/ivOFwVutN/ca/2ZlkSv5TcRvWG554NFatX5/sHDChAUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584813; c=relaxed/simple;
	bh=72Nm2xPACBMza4dpmAjiF+9Mji7R6ngQlpvq8pPnER4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEmDc7kkGfbDcm0oZo3bgzNXVAVm1UxcRYmFZ18KPTp75bXOWQWCRK92ITTtra2TOwqkNLc39SpeviBz9tayyTJgQsF2rA7YKPqRstVB6UeySqwdol9ZFWix8KHw5PnJd67rfZw6JA3KARucxyH9pj7IewObEl5ObIlpBD8bKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BtGj9MVI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BtGj9MVI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so967485ad.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584805; x=1792189605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PBu3xWQl0zj63Pw/WrczlkLjQSRA1otgNmqx45WtYLU=;
        b=BtGj9MVI65pUQpo0bBT4GquTh6PQF5U5JBMtgv79jVkAf+iQvZC2D6OJlhd19vRbRO
         FBz60UDUX0GwJqbuR+oMqwG1LEt2cZ7bNy+OlePCapySx2UpZMou2fJ4A3j3r0eWB2lb
         /T6a6y2/PZSf53ZuHjMfGIzrT+HbmTgczlhTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584805; x=1792189605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBu3xWQl0zj63Pw/WrczlkLjQSRA1otgNmqx45WtYLU=;
        b=VD1KAxD/+j0/VeRgbnozECfQRhtB2R4HhWwRqsBQncNMQL1+DGXrRmw78SaDeYj0E5
         hZj1CQW2y0hlH5WV2hB6I/m0dSA2Q+qHpmbDT0ah7QNEi/85SFWDEC62jTU7AxAvazvj
         02pxnpN6rrs4qcPLR6kQvjmdLicvrMVqV8Vij6x8pRaTJgaerV1DNKHUFRaEuBUri42E
         BOJ4Sx81sRhZugNye+mLPCmJpMHWpuTRs3kKj4ZNSWL/UV0Ke6kDfCQ0tfmPxcxC/QWT
         jXjfFKZIIBj783DeRnGapVoazDHZcvzrtOjxYxjWUJsBZL4BIfo+dg8RK1KhEHL7zUqK
         4tKw==
X-Gm-Message-State: AFq9FYKHoVynHypJz1t7KTXYTS+rLV0otMLm/SbPGkhDfgaSbZMWGw0B
	DcmDuKPEpfAdA6IcrC08g+56WrbNj9PzwtyvB8sU5YeKu6ab/adVVErdAa7HQ346vg==
X-Gm-Gg: AYBFou3G88M3oxjMjPJv7+9sElaveTcVrkXDsa3q01/DdA7O+JuBCRI4z/QPlPTNRO+
	3I5p0FKWMk9ql5qND5u6i8s925NyWkwMlN+4m9bKAeK+MJceHyyF94Wg/F0AOsGcEMcl5pzzdvB
	8CbZZXU0cW6BrvJZcN6UEIaq8czzRtoCcnCxBJDrroW68WmJfvKAPvDQKHiHjaMrE5xtpHT6CjG
	vAU4Lj1lE9sOu7RCVsftlJUoYdEg7YxbWXEVVbccCWDhdtVcae/H+PBl1QK4TGbzGUVswFAZuhi
	wwbUChJgvDg/R6r7Md+yKJv8kafC/bSENkCIju/9VwuL140/Ljg7+hFioR2naySNS4EEF4FReKW
	+c0zDmHXFzFkbe3CZZb1ir9mN4Ryyli9FO4VFSmgnxUCwNQA+98cPJGuqhpLSF2XTHqFExxWZc+
	pwfeNsTFnfEhoKvZUGMhr1jzXINuj1GfAQK4iyunTfyZvesgHBz6NdUvJu7jUP/SoXHsr8XLrf0
	DkTaGvc/tA0PGtw5qZcMw3sbxUdsrpSSvIhx2rY+s96F+3UKYI+IyaWRFz967KTMbwcRWME4wV+
X-Received: by 2002:a17:903:1585:b0:2dd:c100:9433 with SMTP id d9443c01a7336-2e842cd0d8dmr30724495ad.49.1791584805029;
        Fri, 09 Oct 2026 15:26:45 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:44 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:34 +0000
Subject: [PATCH v5 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-9-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=5021;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=72Nm2xPACBMza4dpmAjiF+9Mji7R6ngQlpvq8pPnER4=;
 b=XESZK185fOwWrPZ4glwRC6/Im76uCbwmPk+s0WAzP8HshRks8rpkdjeNqdiN4VhlVHpQ/yP9Z
 cSXImZpNeakDSGJtVH0n9pQLrL2+dFpcOYiDwHaQZJIqm4gvbyyQoaP
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

The properties are common to HID over SPI.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 .../devicetree/bindings/input/hid-over-spi.yaml    | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..2a5fa0868a09
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,130 @@
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
+  - Jingyuan Liang <jingyliang@chromium.org>
+
+description: |+
+  HID over SPI provides support for various Human Interface Devices over the
+  SPI bus. These devices can be for example touchpads, keyboards, touch screens
+  or sensors.
+
+  The specification has been written by Microsoft and is currently available
+  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
+
+  The HID over SPI specification does not define fixed values for the
+  read/write opcodes and the input/output report addresses. The host
+  retrieves them from platform firmware (ACPI _DSM), and they differ
+  between devices. These properties provide the same values on Device
+  Tree systems, so devices that fully comply with the specification work
+  with the "hid-over-spi" fallback compatible.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microsoft,g6-touch-digitizer
+      - const: hid-over-spi
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
+      GPIO specifier for the device's reset line. The HID over SPI
+      specification requires a dedicated, host-driven, active-low reset
+      line. The line must be flagged with GPIO_ACTIVE_LOW.
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
+      Value to be used in Output Report packets. 1 byte.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - input-report-header-address
+  - input-report-body-address
+  - output-report-address
+  - read-opcode
+  - write-opcode
+
+unevaluatedProperties: false
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
2.56.0.385.gd3acb90ef8-goog

