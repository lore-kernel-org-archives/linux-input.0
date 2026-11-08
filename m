Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794122714;
	b=VjKGR1uKfuahnjKHCzqkowi/pbmOBp2PIvdBICGhl0x1bIV/1VCgeHop/4l2ASvh8+IW
	 nqlwZtpjqQM5RvGbaG99n62qalfUMEBtVHbIJ2zOKD/lPeuEvzyIH0o7LmkFFYMm+mJD8
	 S4esAhmZM2pZOBghLIvPmvwlsCZxEn0aFHhHKIuclIzRCO4twO7LdjlfenrjZd5DNNtRU
	 vXw8SyEDpC8aHoS+H3ywbp1yd3wWhTNmXyh3dr/IMy7wlvBlYih1hxSiXVV1YAVPXMf1e
	 /ZMlJWu3Ld6NZxNt1E27KsO1CKSZKCQ9stmq0qSWTwt5hj9LikQhZaIRv78uddFan5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122714;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CMJPYHCR3UWFcu4EK4LpYSERF3fcb1Y5+7uAUBqJvYc=;
	b=Bpg9gQzDoWF+Nb6G2oaf4qLKKewrW7eljLRyAWdeTIxgY6muUISxbzlRh2rCVP9YnPBZ
	 z4O3EMJANBCYE/d5Pm7gqI6efyQ4pynLIo6V7OWrm9BaSqM6I0b6a0axCkivjIM06Ym4R
	 jvc2I41gGAiFZDGw6KauCpAHZXcI+e22gHuowsarSR89mv97H9xBml9kJ2McnbRN3Tb32
	 6GaIZeSm8hpvTYkooD6JZmuN/l1XEWB7ns2a0IvPVh3sF8oAOvj+dTbr9PrJhL2pMkmhv
	 Krmj7Nop47Rb2G5WSzCbGLGkWibOg9NsYgZc18DofAzXgYEMMB+/Udp+YcaUyiC05hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8i9txHT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782E606A336;
	Sun,  8 Nov 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8i9txHT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794122713;
	b=TllsEtyi6wTlyO2xU/Rg+T8p5Frk330uUX6AV1YpiAEZW8zNln9ObcFkb76VgjR20e80
	 3ern6ACToGW05aGg5uIGxpeTlVA9T8EcHhOPATkYqIN1HkTtGVPs1CscuDV0yS+Z0TgsH
	 PqF+sMTDAicFaw/cxQ2ZceQPgBsu5AmOO6511e/Ij/WE0yO62Zm8/JoYYkGSpZRxxMhJf
	 PqhFXu1i3VfpuchMS+hxo4H4O3KVM20rqOwLb7uW0xaIcOLINZgAwsbuL/5mAEuYqppXl
	 r1cun1Wk4xvIAMIBle3oTDfFXmlkzbOmY0UBGlnDJB9vIEQqFDkNgJxOr99XNvTO8TQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122713;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CMJPYHCR3UWFcu4EK4LpYSERF3fcb1Y5+7uAUBqJvYc=;
	b=HpBrenB3GcPfBPGQaYFg30g1zfHGv9G4pyRH2sfwk9HdvYHF7HLJ2YiniyWqJ34kKigg
	 H2mn6kuZifLHjXlGuv0f2klZdnMEpzbw4jNgwfIm6JMErPLzkB6Zva+SNzh41O5DGEtYp
	 vgIasgG6qYb65K7h5mttNFuEUugcp2Qk54GYoWvFg47/Il/uNbdQ304KfJfCC572InytQ
	 +3xvpCFQBZPg5pXJOvuV3kPmJUhGqImQiApKSf9sYR0a300Bl9EnAjvYhJGG+H/eJu5ZB
	 hVUR4OMsxcAhfmTR1egNwskFI7hqmCSZT+akDQpoFoexN3PcrOcq2BWJRjWZuxmhwfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A72DC1F0089F;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122713;
	bh=CMJPYHCR3UWFcu4EK4LpYSERF3fcb1Y5+7uAUBqJvYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k8i9txHT0H7aeOvmB33vcR6VTjnDep0IXOm9BretlbSHqoEsw4pCloo5vRyK5UcA3
	 BmVFnLvdJ+NKmQIhT5b6QwoJ6dkaJ74YJWjnv59S4geS0EYAbdMibXVmiWx4jYfCg0
	 m48aTV3sDYXfU3tGLXmhfzpkuPh69zg+8QbVnbCMLq+1cCJN2m+COWDB76YyHs29Lh
	 efHQ4Lj4ZAx3IuvWUJ5vUzvYw1rZi+4Q4TMakjB35Edmemv5pJsUh0b3hAwukTcfh+
	 QvBEZ+oZmIv+t6GWwd36o0futTbvqia3zD0eoNmSNHxMFOgcCD/j1Ea6TCn1U92+tp
	 oXT28l43rkMog==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2098647E25;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 07:25:06 +0000
Subject: [PATCH v5 1/8] dt-bindings: mailbox: apple: Add DockChannel
 mailbox
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-b4-apple-mtp-keyboard-v5-1-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794122710; l=4117;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=q8ZQCkixKuefi/vxbk7igJsaOCC31V/LgDgV4zCFnzo=;
 b=G/y6CarAnTtn4Yzb866F46SzwZVdrqfl5xBLJ2vYkbpRTmqPgF9IlhFYb330CUU31rNQgWyIZ
 rKtFg11n9TCBOWGJyUm5ZzzGc+XNe+y/LU7X3HFVJDv0UhKLCMAZyYu
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
Content-Transfer-Encoding: 7bit

From: Michael Reeves <michael.reeves077@gmail.com>

DockChannel is a FIFO and interrupt block used by Apple coprocessors
to exchange byte-stream traffic with the AP.

Describe it as a mailbox provider for HID and serial clients. The FIFO
interrupt pair is configurable because MTP and DebugUSB use different
pairs.

Suggested-by: Yureka Lilian <yureka@cyberchaos.dev>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 .../bindings/mailbox/apple,t8112-dockchannel.yaml  | 88 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,t8112-dockchannel.yaml b/Documentation/devicetree/bindings/mailbox/apple,t8112-dockchannel.yaml
new file mode 100644
index 000000000000..9afd58613074
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/apple,t8112-dockchannel.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/apple,t8112-dockchannel.yaml#
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
+              - apple,t6030-dockchannel
+              - apple,t6031-dockchannel
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
+  apple,irq-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    default: 1
+    description: |
+      Index of the FIFO interrupt pair in the interrupt control registers.
+      TX uses bit (2 * index) and RX uses bit (2 * index + 1). The configuration
+      and data register resources must describe the corresponding FIFO.
+      If absent, pair 1 is used for compatibility with older keyboard nodes.
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
+            apple,irq-index = <1>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b2eaee98852f..0c1963150f04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2720,6 +2720,7 @@ F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/leds/backlight/apple,dwi-bl.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/mailbox/apple,t8112-dockchannel.yaml
 F:	Documentation/devicetree/bindings/mfd/apple,smc.yaml
 F:	Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
 F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml

-- 
2.56.0


