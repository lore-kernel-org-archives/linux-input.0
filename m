Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79448096F;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338177; cv=none; b=OLtUWCFEY1e5BjGt79zxhCIXwcsX8WoPunOvbloy03BODGifkCrlA/cbyFkTPL7+iZUvcbuKdc64AI/h8eTQW3DUQKx24D5tu59jT6eu9N8ae59UWVsjOavIQ7t5Uiet2n+9y08Px4TkJwD5F7WTl369skZIM1MbFu0GEqGO0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338177; c=relaxed/simple;
	bh=mPr8eypr7/ZF27F1660g6HWO3U/ChQKMfpG/3X10W7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQTWHssnFG08hweHplP0NPiQCJsjHIgtXZC+7+0/yDfMPptwSYmyvhbxAKCn5qNWDvtZC5FmXqUVo0Ch3X1j1EG4Um9R+g7sMr0fDurnXv8nrM8IsWLBFo7ye0K0rxvg2HycoE5obJUQBsstdPTzo3MFoWIgCY5DFMBeyN78e7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMnTKY2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMnTKY2C"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D7CAC32781;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790338177;
	bh=mPr8eypr7/ZF27F1660g6HWO3U/ChQKMfpG/3X10W7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EMnTKY2CkgxUj43ttUrjCEh+2W3iyq5NqgFQoYOjLhsayOSkRSGB97C0Od7Lamivn
	 k+ivamY3/kyj1NVf+1u2VZLGp4b5dLjAG9+zRuQyDD0dC8E4GMC8VxxjZVzsdpAUiM
	 4iLRqzQCRxH9WaZOcxI0uQln/M1PmOpE7UlD6b+rHLm4R7o78uzdpcfKJnctviWR0U
	 7BK9g/ZhNFKNVN982LbsqhnIbDU6Hy0XXRCZMvBZcwRWHZu8SfXkCIT3o4PWDbvGDl
	 bkhn3evDY1uLAHNWQOIfHgsjEZmGRWv3yfwKuMdCP+3GQT+Z6xNVLTebXdl+Tyj3K5
	 shM5E5gRoDVkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597DFC98324;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 22:09:31 +1000
Subject: [PATCH v4 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-mtp-keyboard-final-v4-4-304c267518f4@gmail.com>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790338174; l=4464;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=mSZ4QRMDwaJZt7aJipMqL1qQcslyR5m0xONcJA13ang=;
 b=qxlBYodEGX1FuCVKyL9KmpVmDcGv0lDTiOX3Gims0dcMtJDw2PyzBx8x3BQt8S7/uquOx0F4k
 7435a0etJDYDeoqu0nzvmEagXvoK1PT22r0fONF9dtO5f1YXumYDZBs
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

Apple internal keyboards and trackpads behind MTP are exposed through a
DockChannel HID transport.

Describe the transport's mailboxes, DART and HID child interfaces. An
optional STM child supplies shared device identifiers and serial numbers;
the keyboard child can specify its HID country code for layout selection.

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


