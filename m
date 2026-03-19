Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2643603E7;
	Thu, 19 Mar 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914017; cv=none; b=SzE9X2mUdNX+XjzESd5oi6JzXar//u6yqJQ2RRsei8Qyg24YdwG8zhpR4bV6jXyLhzOH5zCrG3hq2Vz9NoRC1IkeQ22GHPYKqo1gxisJbmV9vrHNqfWWm8wG5zXNhA36by9IOHkQOClSboFDhkMiSA7IaCVzAtQoPBWgjWuXz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914017; c=relaxed/simple;
	bh=CbqyDgvRP4tYTIb/44hsL3KP087krqobixGsiqYiJQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/Txhi5Xa3qQJ4m04l2rej9DrmDF5sN2h2Ogh+1+vHagUPT2Mmrnu46XOavsD8ET2qe0AiJfXFlx9WN8NTkiIMsC2QSOr8YwSE5JPsuimYjHi8HN65Pop+J5WDQiQ5RNIruYKatSMh1cSdFBcFstzT4emy9kZfU5r9i5lL0rd78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=Vty7meaF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="Vty7meaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773914013; x=1774518813; i=hendrik-noack@gmx.de;
	bh=DfLxfLhxNfcpcEVLuzdC4EkPYSKEDFNRlBO+1QZ2DFY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vty7meaFmvq6z0fnlYUT1FTbponaDcm5bjOwKHF+nbKzf7HA+zYCm4l/B8Ga3TNc
	 iE3KIBmC9ryXzUsPeSw6laIaZF3kcEn0zKTbHmFRnvFwhNRK2MoPtUMAoPhJALziW
	 NPUlbPXZ8oXH/60fZxX+5pYkq4n8s8UrzvQeFP0ESvJirnioDphnLZdoVyM4ycluE
	 4Zbwz/ci4cJEHHQ5h3HoQVP59TPUmMTBELaUjD3/Qcl5e1FKpRKS9lwv0JOle6vaO
	 MhCNn0aJtx9umKefptJo1LEIy2zk6WQz+se+YkIf6SfDlkX5yniRWh3g2dgWQoE0T
	 M0bJGCNSVCS4YWH/xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1wBvWn13UO-00MBTR; Thu, 19
 Mar 2026 10:53:33 +0100
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
Date: Thu, 19 Mar 2026 10:53:02 +0100
Message-ID: <20260319095303.19927-2-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319095303.19927-1-hendrik-noack@gmx.de>
References: <20260319095303.19927-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EHWG38fJ40pW/QwzBKygYaulumNpd2zPs1N3bRp3FwgfAUDAISV
 Pzm88nGzOVggbWzsCjNvQK2K34NCuqvAvxrqcqpAekBcCos7QB/lwTKdbA96t9JGjfhU2nQ
 M6rLuqKwLTXxqD1wKsL9w//lcJOtr7dWes//CNLWdoBLf94f3/ZpZhMRo5pfkwBSTX4pAEl
 G3TTXRzP1faLgi/Q5yA1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p99i45gJ+GU=;8dhS8eJgoXot8IqtJIX2AVaza5I
 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
 61PBViyns5k+qNQ==

Add bindings for Wacom W9002 and two Wacom W9007 variants which can be
found in tablets.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 .../input/touchscreen/wacom,w9007a-lt03.yaml  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wa=
com,w9007a-lt03.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/wacom,w90=
07a-lt03.yaml b/Documentation/devicetree/bindings/input/touchscreen/wacom,=
w9007a-lt03.yaml
new file mode 100644
index 000000000000..6d1da6a435d3
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt0=
3.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/wacom,w9007a-lt03.ya=
ml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wacom W9000-series penabled I2C touchscreen
+
+maintainers:
+  - Hendrik Noack <hendrik-noack@gmx.de>
+
+description: |
+  The W9000-series are penabled touchscreen controllers by Wacom.
+
+  The firmware of controllers in different devices may differ. This can a=
lso
+  affect the controller's behavior.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - wacom,w9002
+      - wacom,w9007a-lt03
+      - wacom,w9007a-v1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  flash-mode-gpios:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        digitizer@56 {
+            compatible =3D "wacom,w9007a-lt03";
+            reg =3D <0x56>;
+            interrupt-parent =3D <&gpd1>;
+            interrupts =3D <1 IRQ_TYPE_EDGE_RISING>;
+
+            vdd-supply =3D <&stylus_reg>;
+
+            flash-mode-gpios =3D <&gpd1 3 GPIO_ACTIVE_HIGH>;
+            reset-gpios =3D <&gpx0 1 GPIO_ACTIVE_LOW>;
+
+            touchscreen-x-mm =3D <216>;
+            touchscreen-y-mm =3D <135>;
+            touchscreen-inverted-x;
+        };
+    };
=2D-=20
2.43.0

