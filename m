Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E364F68A4;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738120; cv=none; b=Cd8OY6k8O6xVeqw/HnlKjNQeNHMYLdi99IlbNGqRnpSvYtblmP7rJ8x9b/fzH20sLmn1AEEJeQux5TdFph7OVVOQsQfHNQNtF5jMxbzwef5HLey741ptnrGH98P2i5sgQs+PYiW3oJ3WGAmpRwV8iTLTSSt6ZP/NONND+Xx17mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738120; c=relaxed/simple;
	bh=RauQ/I1IkRSuYgsTU1p3RctiiX1Uc5/3p9HxZZgiji0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJqwr0Zt0SZtxLhFP0b/tLJAl6R2UKcfzKZwmnisnP1tCgDwZQS3C6sE3FRfXIk715tS0n+vQUDZxC5MkduMXE8rvs5v3O5q1c7gZ/C0ZFZC6OkglYTgoIwnxNGh+dKxQqHm1R3OwEiFKqRc43Rh68hdwFXzs68/GMtwdmBalr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxf+Ewoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxf+Ewoj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 333E8C2BCFF;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789738120;
	bh=RauQ/I1IkRSuYgsTU1p3RctiiX1Uc5/3p9HxZZgiji0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rxf+EwojSjBLDHhU2hKEd6r+z/7cUu6VWPAmkzPebkpc+jibiNJ60D2EEpCks3pXx
	 A6KBxGCf7DYSZj96w9EZTDooOo1BFl7NiDjjbXcclZlAjWpN+CxcQxJgPiNsR8aG+P
	 jbuyLrYFm7r12QWIzeK6oGvWr7T8P98IlMpfpOaFwnwlpEsR7vgKk0OoTNI4f0pyse
	 5I3GlpHbcactEmkCiQP4ijOIBqg7zJ8XqfpraBY1VM2XBy+eJVtzNh7wnCGlY3ismc
	 jO0SFgT8SJUjT91nVcIloODYgaBK1owKAWfFWt+77KOyBIOxbM57EB9lgUeMwkiilJ
	 /BbmG8j2J7XWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F55FC982E2;
	Fri, 18 Sep 2026 13:28:40 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 18 Sep 2026 23:28:34 +1000
Subject: [PATCH v3 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-apple-mtp-keyboard-final-v3-4-e356464e454b@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
In-Reply-To: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789738118; l=4567;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=V1jYsSN5PQjfbShoIWh4p5vyghr3NpPiAnZkrcqg0fY=;
 b=0zS63V5NrTNPXHkAjHPkgrEaDH6iEBlSkRmsMJymKwO/AIY8JlkLjCYD6tjqmbnLqbjgbkPqn
 elmMGbGRrJtA0q7eO1pM3D0fdOvYna0n/XWiRXxsUu3z+0KzZZzPfRY
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

Apple internal keyboards and trackpads behind MTP are exposed through a
DockChannel HID transport.

Add the client binding tying together the RTKit ASC mailbox,
DockChannel mailbox, and MTP DART. The keyboard child can provide the
HID country code used by hid-apple to distinguish layout variants.

Describe the optional STM child, which supplies the device identifiers
and serial number shared by the HID interfaces.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>

---
Conor's v1 Reviewed-by is not carried forward because v2 adds the STM binding.
---
 .../input/apple,t8112-dockchannel-hid.yaml         | 104 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 105 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
new file mode 100644
index 000000000..c25e072b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/apple,t8112-dockchannel-hid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple DockChannel HID Transport
+
+maintainers:
+  - Michael Reeves <michael.reeves077@gmail.com>
+
+description:
+  HID transport for keyboard and trackpad devices connected via the
+  DockChannel FIFO mailbox on Apple Silicon SoCs. The endpoint includes a
+  small RTKit coprocessor called MTP which must be booted before the HID
+  transport becomes available.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: apple,t8112-dockchannel-hid
+      - items:
+          - enum:
+              - apple,t6020-dockchannel-hid
+              - apple,t6030-dockchannel-hid
+              - apple,t6031-dockchannel-hid
+              - apple,t8122-dockchannel-hid
+          - const: apple,t8112-dockchannel-hid
+
+  reg:
+    items:
+      - description: Coprocessor ASC registers
+      - description: Coprocessor SRAM/mailbox registers
+
+  reg-names:
+    items:
+      - const: coproc-asc
+      - const: coproc-sram
+
+  mboxes:
+    items:
+      - description: ASC mailbox used for RTKit control
+      - description: DockChannel FIFO mailbox used for HID packets
+
+  mbox-names:
+    items:
+      - const: asc
+      - const: dockchannel
+
+  iommus:
+    maxItems: 1
+
+  stm:
+    type: object
+    description:
+      STM interface providing the vendor, product and version identifiers
+      and serial number shared by the HID devices. When present, the host
+      must query this interface before registering the keyboard.
+    additionalProperties: false
+
+  keyboard:
+    type: object
+    properties:
+      hid-country-code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          HID country code for the keyboard layout variant.
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - mboxes
+  - mbox-names
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        hid@24e400000 {
+            compatible = "apple,t8112-dockchannel-hid";
+            reg = <0x2 0x4e400000 0x0 0x4000>,
+                  <0x2 0x4ec00000 0x0 0x100000>;
+            reg-names = "coproc-asc", "coproc-sram";
+            mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+            mbox-names = "asc", "dockchannel";
+            iommus = <&mtp_dart 1>;
+
+            stm {
+            };
+
+            keyboard {
+                hid-country-code = <0>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0183c3e1c..7fe2ebb5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2637,6 +2637,7 @@ F:	Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
 F:	Documentation/devicetree/bindings/gpu/apple,agx.yaml
 F:	Documentation/devicetree/bindings/hwmon/apple,smc-hwmon.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+F:	Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
 F:	Documentation/devicetree/bindings/input/touchscreen/apple,z2-multitouch.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml

-- 
2.55.0


