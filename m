Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702013D638;
	Sat,  7 Mar 2026 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907419; cv=none; b=eJo6A1/8o/UwCKTPZVuUQAxix5d03MicYdAeyGq+Vo2EncD2ctH22LydTEbVeXh4DIjRp0ZKLra8b9T/rboXdFLGWg2ZT+DtRFIbunLweRfAm7WmPAWXyCiyoDJ1MjrdKeJdP/YszjJGC+BrCRATdqFlQTRxBYGQI5IxXFrU+a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907419; c=relaxed/simple;
	bh=GVllW7IKMZEDcydEyViUkOUdDpmYUvDV2lnVQmmx0yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My13eJCE7dtkk+6GZ02HMQapa8ua9P2hudfiAUJoDnNmDtFa6B3Ukd6dMDEMG2UH+H6w4B6weK09uUYGqEUbFRHanl2jsQLdUXC1dHHhoc2p4BPFApWks3mq4jc++Osq33Xm53Y0abCUcGxkOHLl2OeMEmbomK6ynMMRRKC+xso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=BIiu/ADt; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="BIiu/ADt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772907409; x=1773512209; i=hendrik-noack@gmx.de;
	bh=0YOWXRUmic541tBlBXnm9+qCqdeYvi/GQ2vzSPN0YFM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BIiu/ADt0iKoq/CVlfNh3tT6CF/nt8plEE4iFiqwujtp/X3AkCOvhPKUJo6RKixJ
	 0mvqEUfvllbsocwlfR2AXhr8fkaapcGHiFLvkvVVpWMjmddE5TIiFJeSd2L+NevVr
	 aIV10K/1EuGnf1MqNcBGFrkeT8zeTx/A0MoQN5IwCM9GpM3P9uepvEQ7mIh7ieMuB
	 9rlDUHd8+CzAxtAvdn19K60R7lIue7j7GZQUmcOsoJRHc9C3NqRAbxve+yuMpoAOJ
	 yMWr/uGm2CL2AZQ44K6vW24uxjq1rqX5emAuw7AGRvigKu6LDt27VzX97raSvtWxQ
	 M2MBSmpN3syyWK06pQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1vWdgk1RZB-00vxy8; Sat, 07
 Mar 2026 19:16:47 +0100
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
Subject: [PATCH v4 1/2] dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
Date: Sat,  7 Mar 2026 19:15:32 +0100
Message-ID: <20260307181557.66927-2-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307181557.66927-1-hendrik-noack@gmx.de>
References: <20260307181557.66927-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NsY5dqT6WJcb1YG9fWRa0vTHGjBGRuVpoFya3SxK0rlfJlTOXhy
 8rCv5bIYLh9TEhfJYBIfkUvLKJguzfT97ZWvMqIJaVwOZ2EjPWRCMfdD4q+/Os9Dt291zXk
 lUJr6x0N4LYyX4hSWn26NLBtiNTSeoVJ36ZybK3s6VqsSbAVn5Ujj2mbd7XcaPuih2SukJe
 6KaaafkYJDS6VRyEFx+AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xjhdcdwWqXc=;KtTtWGUHLJVgTgoIJbY4tuXu8ua
 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

Add bindings for Wacom W9002 and two Wacom W9007 variants which can be
found in tablets.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
=2D--
 .../input/touchscreen/wacom,w9007a-lt03.yaml  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wa=
com,w9007a-lt03.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/wacom,w90=
07a-lt03.yaml b/Documentation/devicetree/bindings/input/touchscreen/wacom,=
w9007a-lt03.yaml
new file mode 100644
index 000000000000..feb87f5db39d
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt0=
3.yaml
@@ -0,0 +1,86 @@
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
+  The firmware of chips between devices can differ and with it also
+  how the chips behaves.
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
+  vdd-supply:
+    description:
+      Optional regulator for the VDD digital voltage.
+
+  flash-mode-gpios:
+    maxItems: 1
+    description:
+      Optional GPIO specifier for the touchscreen's flash-mode pin.
+
+  pen-inserted-gpios:
+    maxItems: 1
+    description:
+      Optional GPIO specifier for the touchscreen's pen-insert pin.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Optional GPIO specifier for the touchscreen's reset pin.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
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
+            pen-inserted-gpios =3D <&gpx0 0 GPIO_ACTIVE_LOW>;
+            reset-gpios =3D <&gpx0 1 GPIO_ACTIVE_LOW>;
+
+            touchscreen-x-mm =3D <216>;
+            touchscreen-y-mm =3D <135>;
+            touchscreen-inverted-x;
+        };
+    };
=2D-=20
2.43.0

