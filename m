Received: from e234-60.smtp-out.ap-northeast-1.amazonses.com (e234-60.smtp-out.ap-northeast-1.amazonses.com [23.251.234.60])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523543E3163;
	Tue, 13 Oct 2026 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862123; cv=none; b=l+AxhghwfI+Wr4Yjgz5B6JOM7aiB59YE8i4b6a+YGmyp9vzOPV9WrheV14eHrpmZl++fTuqS8KtnriNE9U4wznJ1VrNoKAgSQA8OPM+Aby4qEngeTGrmZuX2NM73gANpCTOtRuCL6uZEBfWI4Mp6++g7XvylqArr2dGKKTETho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862123; c=relaxed/simple;
	bh=hcD8VZXEH9+9YcnltfOKM4C0AmHYnM0bAAMtPmjWBZY=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=F093sjPUjFCGro7H82zVVUSKzOrzKWg86GqoKgdqL4k7Cwv+WOqv7Bd9YbCEbe9/CeIpYGk4aWvdR9WYEf56/F5mk4d81xm6cwiJcWvpzUUCeayD0kRrwja3ixp2REt1QgiuImAurqWNcdq/2WYyWYevxdAEeH0d7DD3rO2fAmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=3PgVdL/2; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=R7mCEcTt; arc=none smtp.client-ip=23.251.234.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="3PgVdL/2";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="R7mCEcTt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791862121;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=hcD8VZXEH9+9YcnltfOKM4C0AmHYnM0bAAMtPmjWBZY=;
	b=3PgVdL/2eLUGVF0vXIEnN0Usz1so0Bglm8JG1hZqohGViUikZnuKb7T86OmaXw8r
	SApSA5WJkWwJJGM0Ug2o3BlCmOQyvQVle741TSeC6pQw1YQ2GllSlkoC2qS6Nb8Kefk
	rEx6/iwb6UKFozGY2/zN0chzKR6Ia8JApBJ56jpI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791862121;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=hcD8VZXEH9+9YcnltfOKM4C0AmHYnM0bAAMtPmjWBZY=;
	b=R7mCEcTtCHvPuawWjMG8O2VMUKd1U3OokGrYE9TO1o2+WxuvPxiVOabgm1+scXBw
	9B8jQW3YAqEDdh5MIO6NqCaRlOjhkEOFpoXhjsnjcv215bkHYV1zjKeV0GkePKvfrpy
	BaRgJSgtQ7ng2DwUA6CqmU2dCWoFeNv1J4YdFd1s=
In-Reply-To:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v2 4/6] dt-bindings: input: describe the Romulus13 QSPI
 touchpad
Message-ID: <010601a1334e2298-73816c42-ca83-40fe-9c7a-e771c466a4e6-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:28:41 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.60

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
--=20
2.53.0

