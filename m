Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673133D4FB;
	Thu, 28 May 2026 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954505; cv=none; b=u3+L3RmHnsnVrbfaNJxVU5hX51aeZHe4y2YpCWDtkUG216CYJpOYmO7WZwamCgiG625dovGMu/ydiMg46NnpCfJK+ORXni1VSR08/pdVv2+dGK0ua9HQVACakCeckPrud7IR33rqy4pLP2mW3bo9rpEoXWFRbIVXUrdb5ACoKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954505; c=relaxed/simple;
	bh=yBErcd1w2sLY3Pj7k60XMxya/r5kYyxP4AlAQq/uEYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJLJiNVtzvNsfXxK7a8aBsNRGq9+ibeJTBhCV4Sjk6l6XI7fMmO/8rBKGhScfGPkV2fAuBWCuJrVb3yIjnabALjxvJj8drwrlRqOs/IIXj7PcyTlSfvrbUP+cn+KLaSZxFANDTBQtPUzqYTAcPJ/v2fPVo5llzxuwwUOc+OdzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b=UKmZcxqR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=hendrik-noack@gmx.de header.b="UKmZcxqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779954502; x=1780559302; i=hendrik-noack@gmx.de;
	bh=NtJwyLq+7H04oC+A29jbPR+8EwklJhqRBSAq1t+TQNY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UKmZcxqRBkBZAByx6sUBhbCjj8JW9JRCPhAIssCrON1boNAVcgJukdmxDUXWWuhk
	 2GiEQMiH9VrgPmnwENzvcYKDM73LMoo1LVxRY2bUBe3TAf/rDOPp0XGrNn/4e2o7J
	 7mPWzKIzHNSgsheUE/oKplakWEQaZPVZELaR/Hg7WQVRfGPWKbsldIjC2iDVfPs+a
	 peiniiKO8PLs1jl2nd4Zh3VK5UW/ha3D8hBmi9XgCTIMqPogTqIm731P6ZMRUwxdK
	 QqKEYCMr11t5Q7XDMbfX/FEeonrpOTOeLWnlq0UJmXQnyCKSNcETAGygoE0q4OneQ
	 bPDcLbM86H8kAoY6og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1wjlDA3yID-00OSZ3; Thu, 28
 May 2026 09:48:22 +0200
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
Subject: [PATCH v8 1/2] dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
Date: Thu, 28 May 2026 09:48:17 +0200
Message-ID: <20260528074818.12151-2-hendrik-noack@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528074818.12151-1-hendrik-noack@gmx.de>
References: <20260528074818.12151-1-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ls/dvJ4Uig7hCeA5yVNhK3yO3hSM2s5MRcK3zo1c77DLL/jY8Ew
 jK8At2CvLt8Zcctq1kbQGXFYHXXM1qKlgK7pHhokPTs3a/ZgupfhCxnuPj9PLvuFeobAyjI
 V0+UOoNBP3XxmCsn3yWFFq3xJmEZs1rCo35juBcYne9evHLFiqiAD1GZMkRjeDL50+3tI4E
 D9IA3JkNZCnk69D5H3ZzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YnTkXP5MQEU=;aUTcztpb7Ba5AwwtYfySKKK8lgh
 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
 WHQiR//TQ=

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

