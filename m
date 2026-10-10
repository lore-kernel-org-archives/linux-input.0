Received: from e234-56.smtp-out.ap-northeast-1.amazonses.com (e234-56.smtp-out.ap-northeast-1.amazonses.com [23.251.234.56])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC083BE163;
	Sat, 10 Oct 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651472; cv=none; b=EHpnwi5vMEsCHM+BhPt1KJrPWK7JzqhWuDBLRdwwIQSWmUfQOGc/r1zIpQzyNUk9eGlaw80EfwfsyCpY65MauNFnGBZmCky12HdgkkOlmZGiGRpLnaziRvObgy4SzPp6lowTLnvM2hF0jLOlB8GLHVc7AiOrpcGyj0QeshzIBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651472; c=relaxed/simple;
	bh=kXbIf5/9xYmnmT6dcocndnvXtyd4N64Gcj+PHJdrnls=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=ZQbpfQejFjMHaE1mpqaLkRPZwNTcdjAvc/Mhifw9MW8A1xtm/37PuNY7keJpSVik5sZbxrWEiYeTMjhhlbhT7XPc1T3sat5OMttLrC+Yjgg/G8LVBvcc7y5yVJlbgr6ies2TupQtzAY6OJyXYhtqfkOq2gOkku76bjZoV/ceAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=gQvWL9OO; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=FJ8W8NYh; arc=none smtp.client-ip=23.251.234.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="gQvWL9OO";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FJ8W8NYh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791651470;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=kXbIf5/9xYmnmT6dcocndnvXtyd4N64Gcj+PHJdrnls=;
	b=gQvWL9OOAB2qh/hHv9D+NjSzchNmhUajfCHbmmSk03Tl8yySkdzK9bwYDWGDAx5L
	a3kNZJd3jBa8YNvid5x2snqtGaB8noXHMONFo532vJGapFH4q5+vWHpDBg65zOld3KS
	HnmFHckK8ZI2g6YI/TIMtx3jF6PjAcwvAjiBTcAg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791651470;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=kXbIf5/9xYmnmT6dcocndnvXtyd4N64Gcj+PHJdrnls=;
	b=FJ8W8NYhpZZXwS04P/XZVs/BOq40ZznP2NW3qexJBhUq/2F2WBNVi0djwWI8Up1x
	xduIY/NKJf8W3NVJ25JVthlrwP5BhUKRuIeV4sK+se363V/tKXcgrOuXrz4OKvyaB2W
	5cdnERYVBDfMEvSJlQr8T3JwOhlMaK/vjMGb5YJ0=
In-Reply-To: <20261010165732.43465-1-fqwqf@fqwqf.xyz>
X-Mailer: git-send-email 2.53.0
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Subject: [RFC PATCH 4/6] dt-bindings: input: describe the Romulus13 QSPI
 touchpad
Message-ID: <010601a126bfdb39-6c28068c-cb45-4a6f-873f-99f26b812505-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:57:50 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.10-23.251.234.56

Describe the fixed-address HID-over-SPI touchpad on Surface Laptop 7
13.8-inch, with quad address/data transfers, an active-low reset and a 5
V supply.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 .../input/microsoft,romulus13-touchpad.yaml   | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 =
Documentation/devicetree/bindings/input/microsoft,romulus13-touchpad.yaml

diff --git a/Documentation/devicetree/bindings/input/microsoft,=
romulus13-touchpad.yaml b/Documentation/devicetree/bindings/input/microsoft=
,romulus13-touchpad.yaml
new file mode 100644
index =
0000000000000000000000000000000000000000..88e4664c56e7fb1c3f9f5949a3ded2f9d=
7070604
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/microso=
ft,romulus13-touchpad.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: =
(GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.=
org/schemas/input/microsoft,romulus13-touchpad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft Surface Laptop 7 13.8-inch QSPI touchpad
+
+maintainers:
+  - Jizhou Tong <fqwqf@fqwqf.xyz>
+
+description:
+  The touchpad on the =
13.8-inch Surface Laptop 7 uses the HID SPI v3
+  protocol over a quad SPI =
connection. Its supply and board reset states
+  must be controlled during =
initialization and recovery.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripher=
al-props.yaml#
+
+properties:
+  compatible:
+    const: microsoft,=
romulus13-touchpad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Touchpad 5 V supply.
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  spi-rx-bus-width:
+    items:
+      - const: 4
+
+  spi-tx-bus-width:
+    items:
+      - const: 4
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low touchpad reset.
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    items:
+      - const: default
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - spi-rx-bus-width
+  - spi-tx-bus-width
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include =
<dt-bindings/interrupt-controller/irq.h>
+    #include =
<dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        touchpad@0 {
+            compatible =3D "microsoft,romulus13-touchpad";
+            reg =3D <0>;
+            spi-max-frequency =3D <20000000>;
+            spi-rx-bus-width =3D <4>;
+            spi-tx-bus-width =3D =
<4>;
+            interrupts-extended =3D <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply =3D <&vreg_ts_5p0>;
+            reset-gpios =3D =
<&tlmm 120 GPIO_ACTIVE_LOW>;
+            pinctrl-0 =3D <&touchpad_reset>;
+            pinctrl-names =3D "default";
+        };
+    };
