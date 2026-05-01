Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8803A5428;
	Fri,  1 May 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639279; cv=none; b=pMJ1zgumgV+PP5lf29Ilfqcu00ohQjHtWMoDZFb8W83TTqNJ+x1kedSdtkKCmwhtFsygCTWTHqgsU4x12uYavi9Rr5LuI59vNPCmwTch0J24niVJ66dR4uDisTBjfWwUBP+kWs/dGm6M8jEBPD5TaHjK4bgdJi4nHDJJ0RiE7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639279; c=relaxed/simple;
	bh=yBErcd1w2sLY3Pj7k60XMxya/r5kYyxP4AlAQq/uEYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDogJdn7TbWC4nSx1FN6uGoMaG0vT3octzKLyK/ZTqJrINt5+J559HWtSSSHGhKgJRh85oKbCRoLlo8xiYRXJ+2tQ5e0euOpYzhtuX4ViCGfT6xwGSHE3B9Xrie1EndDvPse0x0Qfd/jwJAA8GFJtj7esulxrv4HrZ/K5ls9Nzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=IBKZ9PGd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="IBKZ9PGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777639276; x=1778244076; i=hendrik-noack@gmx.de;
	bh=NtJwyLq+7H04oC+A29jbPR+8EwklJhqRBSAq1t+TQNY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IBKZ9PGdz2Z664CluoVr1a9Jq/QCFVNcWG+HFqd2HJV3jrXsLwbfv/3+pl/JRMHL
	 g/QadaTZvjOiFtwCbbKX2k8sXag9KBBucIQfxnZkzWLKgMQQkYwvozJljQp/fI7hl
	 9lJ3ExBCN2QnbHTCFD2jedsaRNp5pmDYdKEOz4QYeesWcw3DGwV4dgUsjCBt/tfbA
	 2qr6/UtkxVsRBnX61ixRvePwGwFqeuADVzZyn8kFwGzd8Kx949YBdWeUtwMbboHuI
	 MMaPqAWjc2qKGe0WUCwPoVlM0Mq66H/v1y0ZCSfcTH2mfwmDhHzNTQHvqjGmFWKCf
	 A+jTS39aOCSgEWXT5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1w2Lgt3NCW-00Z2Lz; Fri, 01
 May 2026 14:41:16 +0200
From: Hendrik Noack <hendrik-noack@gmx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Hendrik Noack <hendrik-noack@gmx.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/2] dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
Date: Fri,  1 May 2026 14:40:02 +0200
Message-ID: <20260501124002.132540-3-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501124002.132540-1-hendrik-noack@gmx.de>
References: <20260501124002.132540-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kJAQ6YpqxoGzPwcRfyut9DF7WuQ4lMy9biu13GmH7mUdisBpXHT
 VE5iWX2Q6GlgdYqJ9pHt6CTf+6+riNKolxNArBAWiXHQ61qFxHqiI4Dgrh5IgpQe/Gel8Ar
 FcFRJb9bkHez2tbVG2OSdbWTLWuvCOtrGePRK0KaRzoEvktScPimavZ2vnWymYr/sx8+32j
 kCd5zbjneP1Vdvwmpo/+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wWej+MyFePs=;RNCPGG2llwJyJSoD8P/lI1TeYEu
 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

Add bindings for Wacom W9002 and two Wacom W9007 variants which can be
found in tablets.

W9002, W9007A LT03, and W9007A V1 differ in the length of the return
message containing coordinates, distance, pressure and button status.

Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

