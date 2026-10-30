Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338036;
	b=EPCzseR6RLwjkPxfIbyNdxCocXL/G0BLBQ2XMLVCblT2AofBfCQbFxNoan0LvZYm5oAc
	 0po/vJPys74bFjs4/WvzS1gTg2lFP7X34OLDfuoPAvAL/LMyuoWzEHvdBwm11FCBBKozy
	 qUig7izzZwM3urviJtkVJGk+F6FyB9pOvBhEYPnwrZEgNUcRAyN3orkSWD1dQ1qLo4RHZ
	 vVdAg16Xpb8nKYAmmiZgKuBYc/Q3ZS04PQVTuTk/PriXW36W2GQMUcpeQLSEQl+8gFYBn
	 WmPI895cNPmCm05rtaYMtm4pbyfWI9qoPojZFNtwPEWfSKFGL8/rcaopRxPjUV7Dwcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338036;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=jSr5HyDvC3WoGaGfZcGRkl5oTLgv/2y9TB1MkXL5qGc=;
	b=uBmQYnf5zkoYEgKIKVpkGw81TFy6G3humm29NSwJnC+Qfd6V+PsjWrBHxa9FQo1LbdVi
	 GSDeW2cKcci9BaqGhjcrlUVBul4ocl6v1FqfxSpHoQdm5PCGQZJEyhyRE78E2wKLxhOBY
	 kUrBUP3Ma8GYWRKQgvJ6/KDxKTPOcEYydqbfTTIhIp4wUgc/l+nhDlpJqJ8LbidQ7qc5z
	 4Ks5ZZSpxJWaZXpadTm6wWGCX0secQD8oND5IU0qj7W8GencVzwc1+CEV1G7a0PjfOqOb
	 90dqAZZ1Yeqf7h9iTSxF5HsPjv/Wo3GD65KEeHVBP0SqpgBB5LmzBSXD4QMgjGZlkwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=KvMW6qVP;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9794606A320
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 05:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9794606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=KvMW6qVP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793338034; x=1793597234;
	bh=jSr5HyDvC3WoGaGfZcGRkl5oTLgv/2y9TB1MkXL5qGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KvMW6qVPiRal8DQ0NJBddoS1bxBepyMwi5oGY8v/MVznQT2tDZ9Bc0LkSX5LPatMP
	 ZkatZbi27wseaW+KEzMpzqnOk9tomL6c2hXqAZGBTn8anjmD8Kz2Y/rxcD2hKv1dc3
	 OQF4KdbCsDzc9dJfSSjlGazKQciXULDL0a52Z89xauLoU/FDrYY7xwiU/1Vw74Za+u
	 mv95+3g747drIUW/K5+yzHz+54XRVSw4Y7+IUmTHLyBZPXO1AakesioiUIHYuWywbH
	 j1ZH/EKcV2vdBW7mD9I3FBXPgsM9DpoYeqgQqikIvoQTSMsFIIS2wr57Pg/4M/Y66H
	 XNyR+wmeZ7ZcA==
Date: Fri, 30 Oct 2026 05:27:11 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: Document FocalTech FT3683G
Message-ID: <20261030-focaltech-ft3683g-v1-1-38b2f941b039@pm.me>
In-Reply-To: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me>
References: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 2842cd93d996aa4cde4a173129da21aab4dbe07d
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Document the FocalTech FT3683G, a capacitive touchscreen controller
connected over SPI.

It is not compatible with the FocalTech controllers described in
edt-ft5x06.yaml, as it uses a different bus and touch report format.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 .../input/touchscreen/focaltech,ft3683g.yaml       | 74 ++++++++++++++++++=
++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/focaltech,=
ft3683g.yaml b/Documentation/devicetree/bindings/input/touchscreen/focaltec=
h,ft3683g.yaml
new file mode 100644
index 000000000000..9e491a5824d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/focaltech,ft3683g=
.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/focaltech,ft3683g.yam=
l#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FocalTech FT3683G touchscreen controller
+
+maintainers:
+  - Alexander Koskovich <akoskovich@pm.me>
+
+properties:
+  compatible:
+    const: focaltech,ft3683g
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
+  vci-supply:
+    description: Analog power supply
+
+  vddio-supply:
+    description: Digital I/O power supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vci-supply
+  - vddio-supply
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        touchscreen@0 {
+            compatible =3D "focaltech,ft3683g";
+            reg =3D <0>;
+
+            vci-supply =3D <&vreg_l22b>;
+            vddio-supply =3D <&vreg_l11b>;
+
+            reset-gpios =3D <&tlmm 20 GPIO_ACTIVE_LOW>;
+
+            interrupt-parent =3D <&tlmm>;
+            interrupts =3D <19 IRQ_TYPE_EDGE_FALLING>;
+            spi-max-frequency =3D <12000000>;
+
+            touchscreen-size-x =3D <1080>;
+            touchscreen-size-y =3D <2392>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 75ef3d1aa9d6..68efbf580964 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10498,6 +10498,12 @@ L:=09linux-input@vger.kernel.org
 S:=09Maintained
 F:=09drivers/input/joystick/fsia6b.c
=20
+FOCALTECH FT3683G TOUCHSCREEN DRIVER
+M:=09Alexander Koskovich <akoskovich@pm.me>
+L:=09linux-input@vger.kernel.org
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/input/touchscreen/focaltech,ft3683g=
.yaml
+
 FOCUSRITE CONTROL PROTOCOL/SCARLETT2 MIXER DRIVERS (Scarlett Gen 2+, Clare=
tt, and Vocaster)
 M:=09Geoffrey D. Bennett <g@b4.vu>
 L:=09linux-sound@vger.kernel.org

--=20
2.55.0


