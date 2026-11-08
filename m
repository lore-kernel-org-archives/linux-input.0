Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794122715;
	b=cPI4N6ewzDLT0RQtWqJIQKEdpmwOpVsZxAtpjfazQrceNpQhl2hT+X6Nk6XIwuOmqEkj
	 TGJNfk6D2Y9DypqWdqUOdGBCqYnDY+g1frDJJJ1QNDirepLHbeTPUzmRGQx0S0HnTwqpd
	 OoDqb7bQZusgSWnzpYsBiGS1UJxTFBKkrnqTBRBlTkzVOfY8cLQmR0T6HbWmHW7X0bJpu
	 uy7ocTEjj4AWiUIIcMrw3DrbF6btaMCNt9SMtil5FXTMLg5xs6R43wYI9VvGnvGYrSzk6
	 gIyqqdy9QO86w6ByfE16yGiBqj8Nx/i//SsHEDml52Laz1D9gv/AxFfJmPE2iB4MWzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122715;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NeIpvfaNeRc3eLkGVWPBpuoJTbGDlCPbkgc/6udEcoU=;
	b=HUFjRzpLnIRHZzWZoTftLD4/j9mXmqdm7p4h44KiTi7YOn0+qelPRioLMgaOYVZnCQ5n
	 vOyyLCg/DL3mDupqCE5/QqZhP1KO0SxIu/2BaS/z7kvh6BYU0RqqX0b4Qnv1DHvxy6sL0
	 gco7erUnLdZt9hKLdA5a+slofQvekPi3U3V2hZVYLLLcoUUkGeI9Pijize49zyoGpH9hO
	 gV/VUL2ntd7rho3+sOdN+7OZru1qWrALZ2apjASJFZsXb+XtqO8opvwRN+i91p76aX8xk
	 xKe4oTEbuxvoUZfRG+s6w6EENRcx52mQU+BJZXgAT12PQhZYU6+FH7tXVy3TLJpvMPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Up0Wmk0n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20718606D802;
	Sun,  8 Nov 2026 07:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Up0Wmk0n
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794122715;
	b=ICkLtFBLD/r7Sq05OtBp+7vrgYCdTcHRek0vRep7IIXHhBiCMSNwnLruR21/JiJgDzte
	 CrEesZYNYDeUwV25cFuOBpYoOMkXZ25D0/XuBB8RnoAFzW88XJnO7Pv23SI9ePOvcRSsS
	 o8QVXnhyJZOUcVLqlYq5xRYxa+sWP/oH2yDAHFEaPIwjGrMhj1XZEVl9AB5KdtHtgEtrX
	 zT2SLhqYsXkNstAIPFyRbSh7qYLNes4h1eGbpw2K3PlUqc32aelLTciVY65Je5DcZ/lGp
	 D3Dj+4t4weNCBsDK6k6v/MMlvHGFvJ6uEaDTHhygBpgdF+QBiaBr4205x+x8nShyEmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794122715;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NeIpvfaNeRc3eLkGVWPBpuoJTbGDlCPbkgc/6udEcoU=;
	b=d6M/QJc7U9RlST1MZjwzJLDEo/nctgpY3E3b2+B09ChJN6Z4EMBnrXR8Ym5mzckeZRlA
	 dxGuMoIDt5/hHAP8thzCJtXHNdseKKgJu/cWBscdM+G3pWCffJm719H4eV5F/LCO1MRvF
	 5UvOS4GQf0LHLYjx/sMN2TMC6XzmhxCm/9or+V3x1FYDRuFgD6uhrxxpVt4r2Wn3GLATZ
	 DNRtwbDnhWN/K6xvaq7AZnfr41r4VXuqrf0ewQ9JPddVYNbzFZNWYq4YKWphFoQDokqWb
	 oDACGV12Ify/DKVtTb8r8HJ3+0g6gfDq/0wIUrBuJ/Gf9roWsD1N3pLlONHQBbVylnw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A78CD1F008A2;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794122715;
	bh=NeIpvfaNeRc3eLkGVWPBpuoJTbGDlCPbkgc/6udEcoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Up0Wmk0nJUPoquOLlx0Ej5uPPpkPieijZVZV59oqIA1fpFVqahf+NSgK4SoEBEbEB
	 LfOPAlPJPSLVvNYRYFd6c5NQlJ1v5GhtIZfNXdiJLEfNyj3gWQpkX6/WB5Ttpecj+o
	 TIAwfx8JFPcrgwtrKaDxCZ9gcEo34ikiP6xJ0ITqwGiF1pMy0gKMY6mH4UCuFqUffq
	 218Dm4sFaix4qXzKVa0whh6J5rDj/5H2hM3BRPhnVMW6TRsQOiB/4F3SOR+b0tMt0g
	 9s1tchmrSSziBNEmM+nLZpaZR5Zins8UTN67BGDh2Qxqz4HFQbv4Fm/znYF3WjK82H
	 28itq1LhsbraA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 314D047E5B;
	Sun,  8 Nov 2026 07:25:12 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sun, 08 Nov 2026 07:25:07 +0000
Subject: [PATCH v5 2/8] dt-bindings: input: apple: Add DockChannel HID
 transport
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
Message-Id: <20261108-b4-apple-mtp-keyboard-v5-2-e2c97b82669a@gmail.com>
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
 linux-input@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794122710; l=4202;
 i=michael.reeves077@gmail.com; s=20261107; h=from:subject:message-id;
 bh=mRZFOVFEWZlmTQo/secoMGKBAQBA5BcBUwvtUqnYZBk=;
 b=ITnYdgO+IbIaCMxxcMeaaK554tNgPqysgmMp2QCn84oEvcQuCKtp0H1CWfaB/kb5SC1/oy0TC
 P06AnslxJ+kD+3TfvKznMIqnARnqz/Gl+9azSHX8pz1ffbGDiQMmoym
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=ykwkLcuByJYb/cdLc2UuoYP03pIzwrscEZg30+4tJL8=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20261107
 with auth_id=1442
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com
Content-Transfer-Encoding: 7bit

From: Michael Reeves <michael.reeves077@gmail.com>

Apple internal keyboards and trackpads behind MTP are exposed through a
DockChannel HID transport.

Describe the transport's mailboxes, DART, and input properties. An
optional apple,has-stm property indicates shared device identifiers and
serial numbers are detectable. hid-country-code specifies the keyboard
layout variant, which is filled by the bootloader, and is not prefixed
as it is a generic HID property.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 .../input/apple,t8112-dockchannel-hid.yaml         | 92 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
new file mode 100644
index 000000000000..55732cd59964
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
@@ -0,0 +1,92 @@
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
+      - const: asc
+      - const: sram
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
+  apple,has-stm:
+    type: boolean
+    description:
+      Specifies that the coprocessor provides STM device and serial
+      number query endpoints that must be ready before registering HID devices.
+
+  hid-country-code:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      HID country code for the keyboard layout variant.
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
+            reg-names = "asc", "sram";
+            mboxes = <&mtp_mbox>, <&mtp_dockchannel>;
+            mbox-names = "asc", "dockchannel";
+            iommus = <&mtp_dart 1>;
+            apple,has-stm;
+            hid-country-code = <0>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1963150f04..41b12717c657 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2714,6 +2714,7 @@ F:	Documentation/devicetree/bindings/gpio/apple,smc-gpio.yaml
 F:	Documentation/devicetree/bindings/gpu/apple,agx.yaml
 F:	Documentation/devicetree/bindings/hwmon/apple,smc-hwmon.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+F:	Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid.yaml
 F:	Documentation/devicetree/bindings/input/touchscreen/apple,z2-multitouch.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml

-- 
2.56.0


