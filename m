Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B750F410D30;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824086; cv=none; b=unmxAd3Ham3FpZZ2qsLS6GD6m2liWZSoQdzF2j+3hQ0IG00v2ScYm0/xJ/6VHzP34erAMCdT9GMTLK1G2nf+yeds6oEyiwI8kIbHyDkWnTl8sh6xPvgMFWSIsiHmHkh9ucloioepLJlgVlLznI9B2O95zVc8vim8ZMwv/uWH998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824086; c=relaxed/simple;
	bh=c7dco5weVexbDAMt6Y4/pHS14uEsNEudzF+M7amuXCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcojWqT+rJMdlV75kD6BVmGZxhGp4UyBGtG+LLqrfM4grkHgdn3nK+Z+7CWH9SEntVgFeCFz0gNIhbJ/g2fQOo7/hQJl9JHcr4iuW/WBJDF/4XYf/s8J78TpCfgTXX/pflhSJHj6RaJKcwlJxOcF7JkxS0EGzAmt2cRWMAZ91eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxOIjHkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxOIjHkM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6984AC2BCC9;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782824086;
	bh=c7dco5weVexbDAMt6Y4/pHS14uEsNEudzF+M7amuXCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DxOIjHkMJwNCvSNa5jocktFvXyl/coEQjHlyHOgPTxCokGyIqT5YAtUCUPNbXW6Px
	 5mDKeiE7+qKtJOwIswlpI9RcabHL2reHHOfifYtELAGg07l03PW79Z5DXR9kyw9DCY
	 VMx6X7Z9GhZio6wnDTZb6AgBU+tL0zBjvXh2LrDYr7RfDA6zYSEpmzdOIo1/MOEsRZ
	 E6wxa4ePMcIbribEFll7bTNTw+BgOFJq3IYjn1Gj3CZAvJl6HVYWlVTwfmHhsM8Pif
	 ZfvmwdvgEgu7D/TYQq+X3fUxVY7m5lOyy/r89vQBbI1J8NKRZwO7p3gn5BNOEXyp2t
	 /czKt0mr44usQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569F0C43638;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Tue, 30 Jun 2026 22:54:30 +1000
Subject: [PATCH 02/10] dt-bindings: mailbox: apple: Add DockChannel mailbox
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-apple-mtp-keyboard-final-v1-2-506d936a1707@gmail.com>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782824083; l=3372;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=qTwrlgJUrpkywdb2F2oQ2ZLa1OFi9nFHKwuUTUdwhbA=;
 b=zhPL7D/L3ecCBBmc/Pkjy4JwKtjBdT8TJvfmlR8jtYbmZ2arPjeKdRCAuUY+I1iR9onA7CUrW
 eNxr+F33BbNBOrA1qnapabIls6hA93fbn8FingnrPKFX0pY2KgefvA7
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

DockChannel is a FIFO and interrupt block used by Apple coprocessors
to exchange byte-stream traffic with the AP.

Describe it as a mailbox provider so HID and future serial clients can
use the common mailbox API.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 .../bindings/mailbox/apple,dockchannel.yaml        | 75 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml b/Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml
new file mode 100644
index 000000000000..4f326d8f3d5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/apple,dockchannel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple DockChannel FIFO Mailbox
+
+maintainers:
+  - Michael Reeves <michael.reeves077@gmail.com>
+
+description:
+  DockChannel is a hardware FIFO and interrupt block used on Apple SoCs for
+  low-latency byte stream communication with co-processors.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: apple,t8112-dockchannel
+      - items:
+          - enum:
+              - apple,t6020-dockchannel
+              - apple,t8122-dockchannel
+          - const: apple,t8112-dockchannel
+
+  reg:
+    items:
+      - description: Interrupt control registers
+      - description: FIFO configuration registers
+      - description: FIFO data registers
+
+  reg-names:
+    items:
+      - const: irq
+      - const: config
+      - const: data
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 0
+
+  nonposted-mmio: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mailbox@24eb14000 {
+            compatible = "apple,t8112-dockchannel";
+            reg = <0x2 0x4eb14000 0x0 0x4000>,
+                  <0x2 0x4eb30000 0x0 0x4000>,
+                  <0x2 0x4eb34000 0x0 0x4000>;
+            reg-names = "irq", "config", "data";
+            interrupt-parent = <&aic>;
+            interrupts = <AIC_IRQ 850 IRQ_TYPE_LEVEL_HIGH>;
+            #mbox-cells = <0>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..741974f0f326 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2594,6 +2594,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/leds/backlight/apple,dwi-bl.yaml
+F:	Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/mfd/apple,smc.yaml
 F:	Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml

-- 
2.51.2


