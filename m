Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F752363089;
	Sun, 26 Apr 2026 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211975; cv=none; b=puhq3HXRes4aqhlwH+VAz6BA9vCOl/zCp7gimI3MvHyms7xKVcEFT8CrwPuA2n1Y4iry6goK16gQ8iJHBJ4wZd/7fxr9DuS+676awYz6hKDd9NZdqdXM1gY40QiJfgf6cmtg1vGQSVMjZDpN68J2e3pgOdkG4XdvGha7Fj7ycHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211975; c=relaxed/simple;
	bh=yBErcd1w2sLY3Pj7k60XMxya/r5kYyxP4AlAQq/uEYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFksVr4DDfhEzMtBS510yrVpPB6Y0kJK3AGxkW87EywokpJj1dpuye9ikAQ7brYE854tKJziaZE63wQL/3lJ+G5YvYDGyYOkxAAhoXVu/5KW6VIVlrzj3FOLXHRjMwwokkFAYtxGngc36xrp4Zoyqad1JxVZg5Nfl/Va1mJ4IrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=Wg1qh8Z/; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="Wg1qh8Z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777211965; x=1777816765; i=hendrik-noack@gmx.de;
	bh=NtJwyLq+7H04oC+A29jbPR+8EwklJhqRBSAq1t+TQNY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wg1qh8Z/GFyH1YVK43UmmTGCqBEFuJ5q2XvTDCGGBp7qd/Efa0Wzfy/AU3GwIfxV
	 YhSQTPiPVrdPck8QIzIJvHLgTSF7VHiwHCurXMj9xMml/vh178XxCNG4WFl3Bf7Bf
	 cbSSKDDVir1hV24Fx9ZC95Nl/p3t9TtGrLhe7D8FkMLBW+wpAkDhL5hEGuBwl9zD2
	 MjZYiADO9k94sSAAQz0JBuDZLlrUIth09YjloP9do6SuCrsR1ZrxSgmsgcWcdlfSO
	 e7DQCALdQEvJ5y2sEWDldOx/+q6wRX/FneM+UMp/29BGMrYckeMbIQzwO1PvvBQPg
	 rwHXzVhIq6CbDk9Vfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1vgI9a3Ys2-00q3JY; Sun, 26
 Apr 2026 15:59:24 +0200
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
Subject: [PATCH v6 1/2] dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
Date: Sun, 26 Apr 2026 15:52:31 +0200
Message-ID: <20260426135232.371272-2-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426135232.371272-1-hendrik-noack@gmx.de>
References: <20260426135232.371272-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wAKHO9j531NwoMmfizIYJqxKXZazmLqGnZHK+nGioNyLuWqansk
 LBNFrPyFgudFZGYftdDWXDerqrWRmuPx0tr0HpU5icDo31Zw3bkHAkE6ytJXzsphaUa1RF4
 gHOjKbpa6ws8vwrLMzVxvvWXSinexqBd2bZ7G9vYN0Uttct1ruxkY6XylA0kNfPZOuLdfg+
 v7KPhyZfeh/wmUNi/CYsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2bm7jVyBRwE=;IlHrRYKWkb6QSgsP9PbL4+AP1Ss
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

