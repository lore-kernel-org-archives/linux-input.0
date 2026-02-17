Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E037AA8A;
	Tue, 17 Feb 2026 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372305; cv=none; b=mmYJ3s8nm6Hh3o8cP8pL8+dusVGXZc4VGHJXBNFtGSnmhB2jAMov7fg7RBCcu42dW8b2W93dHRuR55vFgnKsflfva6zGswacOmsOmpb/zob99Zr99FF3rhq7txIoJRb52yR7ihfJYqPZn/E88OMQFzYk635PVIFVoYSVpw761QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372305; c=relaxed/simple;
	bh=hLEJw7NfpeakgWD5ooAEJP4vVxpcsaKGoIj7IO2V05M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=te1ZUzq0H5nGensr+WxfULGH8jrD4yqNabgaIVBmG5nW//eernBW06zXRPEbMVYMFqvtcwAsq+TdTLAn590VW3ObkxVkk+qr1WGW8TMi3Wd2o0Vh3lufVF80/qK9mCVNWUAVLFkfR4za2HPPi297uVpgjyedK9LYMAgm2QIuNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=kq334GCj; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KMpD2/vZ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="kq334GCj";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KMpD2/vZ"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1771372265; bh=d7WI4CCze1zokydljk3Xtok
	4i1TlNCgc0AyutExxLSc=; b=kq334GCjOU+MsIACkLQgGz5OPL0K6Vud03WaQxKKDfpoStgIQA
	LH2GN3wSvNK7NtuiIhgq07YYtUSJQytsJCfqc/cutgoIfSx5kd42ut08VQ8Qxr+FmGfXUDVaDHa
	km76zTooxdDVLM7ocwqWcfxG7IsEPxDd90CLvpahZYt+4UUtQaceYL0+HSlrnlm2aqmA6ZCcyqp
	KslvgQKftZz5K4WhvKCOagdvhk4+u/n/FODwGjXBWJN3jWPenOXh2kLKnvdEokn4+W8Ss/HTbkf
	3i7wWdeLhrUlohH7huUS5X24cm2KqNw+CQJ/bR5/fVl0Sr7fD2RRbC5Z/X3Xqwa9LKg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1771372265; bh=d7WI4CCze1zokydljk3Xtok
	4i1TlNCgc0AyutExxLSc=; b=KMpD2/vZ/3saCz3YDK6ts1g0CeR8GRw/PoBwFpIiNUaY7EWFxF
	8aTHIsrtWUXGDpNhD68vxQS4YpNO9Wnng6Ag==;
From: Aelin Reidel <aelin@mainlining.org>
Date: Wed, 18 Feb 2026 00:50:47 +0100
Subject: [PATCH 1/3] dt-bindings: input: document Goodix GTX8 Touchscreen
 ICs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-gtx8-v1-1-0d575b3dedc5@mainlining.org>
References: <20260218-gtx8-v1-0-0d575b3dedc5@mainlining.org>
In-Reply-To: <20260218-gtx8-v1-0-0d575b3dedc5@mainlining.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@mainlining.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Aelin Reidel <aelin@mainlining.org>
X-Mailer: b4 0.14.2

Document the Goodix GT9886 and GT9896 which are part of the GTX8 series
of Touchscreen controller ICs from Goodix.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Aelin Reidel <aelin@mainlining.org>
---
 .../bindings/input/touchscreen/goodix,gt9886.yaml  | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9886.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9886.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6307495c2746313cfc32cdbb701455d1596be435
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix,gt9886.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/goodix,gt9886.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Goodix GTX8 series touchscreen controller
+
+maintainers:
+  - Aelin Reidel <aelin@mainlining.org>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - goodix,gt9886
+      - goodix,gt9896
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply regulator on AVDD pin
+
+  vddio-supply:
+    description: power supply regulator on VDDIO pin
+
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@5d {
+        compatible = "goodix,gt9886";
+        reg = <0x5d>;
+        interrupt-parent = <&gpio>;
+        interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+        avdd-supply = <&ts_avdd>;
+        touchscreen-size-x = <1080>;
+        touchscreen-size-y = <2340>;
+      };
+    };
+
+...

-- 
2.53.0

