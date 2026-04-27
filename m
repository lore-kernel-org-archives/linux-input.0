Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E8286D4D;
	Mon, 27 Apr 2026 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777265225; cv=none; b=NLGNuX7tiL+mz88pwFBDpFdNwSUNqXr66tcfumfg+3b5G4w4CFXWA4DzJGuI/vGERReXZgJA7CwPWteGEMHf/ndsz3oxo1yjMWNiORZSx9wLVcg9RKkjPzqvTLKtRSCwICX0bRt3BTS3T8+IkRJduWB1Tg0Vi3VEtOk0/VOcFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777265225; c=relaxed/simple;
	bh=vj4lGOnuMauUDY6y8oGjCiXJfacmhk1x7ZU6bLMUDxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg3kv/QfIsggBDu9dWdpSmNOfxpRN+yzC+vXbw8O3a8Q9u6A6aCIhtmFPzgs8vWe6SNzw451acmqA9vrP7v9LXDl8U4LAKSMar49ZAORrjPS3kI/SmDE3wksVA/OP1tfEBHzLkoKohJn1vPipoFt+WYLBKiVYYvRT8Vkj3t4yLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVEG3PIH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVEG3PIH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16BD3C2BCB7;
	Mon, 27 Apr 2026 04:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777265225;
	bh=vj4lGOnuMauUDY6y8oGjCiXJfacmhk1x7ZU6bLMUDxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EVEG3PIH8s3d/zPdejKC8a2LxnASTxCIbosAJwxA6BS3tXRnKq7q0BBuNmtoi37oX
	 91hGLWhggdXQgDnh4aMVYIJWfPQp/GYXYGQaTTy7v04+xvj/VuFJgwDKVMHTCddo/L
	 wNmfwckOuTNFfIKJFjIq0agWJc+jbkAfwpV5ePeRVQQHxydX0B2W5NzZ2FBQsIB5Ir
	 7oxY6R5iyj7ugbQkUCicgImYTx6v1OHcy6k+SlnQTcGvej94jh4fQkY46KHFE/ePQp
	 43xYiVIDqWcemUpW0yHhSrhMlF8n1pocoQKBny9t7O7bH62CBktiMnotvACqeXdVsa
	 k6/fzQnKzRGlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750CFF8850;
	Mon, 27 Apr 2026 04:47:05 +0000 (UTC)
From: Harpreet Saini via B4 Relay <devnull+sainiharpreet29.yahoo.com@kernel.org>
Date: Mon, 27 Apr 2026 00:46:53 -0400
Subject: [PATCH v5 1/2] dt-bindings: input: Add PixArt PAJ7620 gesture
 sensor
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-paj7620-v5-v5-1-6f9bbe7b4ce3@yahoo.com>
References: <20260427-paj7620-v5-v5-0-6f9bbe7b4ce3@yahoo.com>
In-Reply-To: <20260427-paj7620-v5-v5-0-6f9bbe7b4ce3@yahoo.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Harpreet Saini <sainiharpreet29@yahoo.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777265221; l=3632;
 i=sainiharpreet29@yahoo.com; s=20260427; h=from:subject:message-id;
 bh=ZvENQ6/JadZnjlGXWa5Ps7cylg37z6EcwIcl+Se1DuE=;
 b=blzvXiksAhu/u+yp4Y4duHPBPxxo7+WfYYpl98WUpyC1nOSzv7QcaNU1xFwArybRK+0FnoKsl
 ol/frT1mSojD7lPaEgdUceMNt1UQS12jHbqMkGDdWiE9UNP2Arowao5
X-Developer-Key: i=sainiharpreet29@yahoo.com; a=ed25519;
 pk=xht+vKyGRLShWSTBYoH2qBaDzKUL90zr77TVwj1ra9s=
X-Endpoint-Received: by B4 Relay for sainiharpreet29@yahoo.com/20260427
 with auth_id=754
X-Original-From: Harpreet Saini <sainiharpreet29@yahoo.com>
Reply-To: sainiharpreet29@yahoo.com

From: Harpreet Saini <sainiharpreet29@yahoo.com>

Add Device Tree bindings for Pixart PAJ7620 gesture sensor.
The sensor supports 9 hand gestures via I2C interface.

The GPIO controller properties are included to describe the
hardware's ability to repurpose SPI pins as GPIOs when the
sensor is used in I2C mode.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
---
 .../devicetree/bindings/input/pixart,paj7620.yaml  | 84 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
 2 files changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pixart,paj7620.yaml b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
new file mode 100644
index 000000000000..089e864e82ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pixart,paj7620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PixArt PAJ7620 Gesture Sensor
+
+maintainers:
+  - Harpreet Saini <sainiharpreet29@yahoo.com>
+
+description:
+  The PixArt PAJ7620 is a gesture recognition sensor with an integrated
+  infrared LED and CMOS array. It communicates over an I2C interface and
+  provides gesture data via a dedicated interrupt pin. When operating in
+  I2C mode, the unused SPI pins can be repurposed as GPIOs.
+
+allOf:
+  - $ref: input.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: pixart,paj7620
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply.
+
+  vbus-supply:
+    description: I/O and I2C bus power supply.
+
+  vled-supply:
+    description: Power for the integrated IR LED.
+
+  linux,keycodes:
+    minItems: 9
+    maxItems: 9
+    description:
+      List of keycodes mapping to the 9 supported gestures.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - vbus-supply
+  - vled-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/input.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gesture@73 {
+            compatible = "pixart,paj7620";
+            reg = <0x73>;
+            interrupt-parent = <&gpio>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&reg_3v3>;
+            vbus-supply = <&reg_1v8>;
+            vled-supply = <&reg_3v3>;
+            linux,keycodes = <KEY_UP KEY_DOWN KEY_LEFT KEY_RIGHT
+                             KEY_ENTER KEY_BACK KEY_NEXT KEY_PREVIOUS
+                             KEY_MENU>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..d73a0bf62b62 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1273,6 +1273,8 @@ patternProperties:
     description: Pine64
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":

-- 
2.43.0


