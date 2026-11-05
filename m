Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906586;
	b=Cv21rvyrN1qQEnE10VASij7e4xJfdGxOEsc427bxLr1GSUlf3xRdNBHz3uJNvoALJcRB
	 9oOZALEqjb229ekEzZmeQGvMitSgEVqbdF7YHhiY3YrvPy5jkbCVZP+QOxR8anPVB2UoJ
	 eV5wV2W4fKWq7sNnxkOKfcQ0z0KZOPJliJ7BzUWyc30YNm/3D2tfkq45+5uYdLCo5n2UT
	 cT5LYlvwsZd63ccb63FSqJJ+FcTRy0vAMNwXDWgSDdqIApvR/3uIhqBXI2Tfs+cSDNe1q
	 XFws4OnDZe3MAg/63JOhqA/KNmfna4L1ycL4SZgrNogFjMcShDn5xJtX0P/IfIaQlgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906586;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=cUiAAzp7g7L96rQmg3eJA59kYzOq2QF3OGciXBltc5w=;
	b=mK1ceUPJBNDZig1iMSx232ZZAaXLAB008P0d5wXDRD6yG7Iwmxf1RcRxO+tPpz7Y2od3
	 73Kxj2eTrCaWvEtqFgOOGonZh5xUz9KKktk0WJAO/LpZLTUImBasgS730hkOI90H2NVxi
	 GwHJu/ZqiZ16Drv4mmkxAkp8lFfKVPJkf/+CwhAaP6PmNfMacIGdZFikx+kutMp9WclRb
	 n88qStp4vVEYjJv4QwrVn2Mp0Jh79MldSNufLG/Ao59l3Rq4QMk9v33FfjXvQst/4CZiD
	 gBd3MKA1dZGQbmdzv5OV1I5A4kITqDwLN2QIcFkMgbrgTNdAOua4qZ2eNVM5OrPeF1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=DyiT8qBV;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=Et5Fkoqb;
	arc=none smtp.remote-ip=23.251.234.57
Received: from e234-57.smtp-out.ap-northeast-1.amazonses.com (e234-57.smtp-out.ap-northeast-1.amazonses.com [23.251.234.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABC8606D810;
	Thu,  5 Nov 2026 19:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ABC8606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=DyiT8qBV;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=Et5Fkoqb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906585;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=QMAw3v00ul2mdeBNCyVHXFACtQTxGcioilnanO3wF+c=;
	b=DyiT8qBV66tysQFwpSODI+Ob/QGNrpmmOLRY4UcQRPTYDoxbosiu8xhWlUUBkaVA
	H0ypr+ZwnK75ydBp4GZNDyjMI6MXP+wCqKey7RSDhPB5ME3MPyauUJ2BQlqHeveOmft
	OOJ9AXyqA5jpHEsyJb9K+5kz6I9vPbSZBALtUkc4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906585;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=QMAw3v00ul2mdeBNCyVHXFACtQTxGcioilnanO3wF+c=;
	b=Et5Fkoqbg9Ag0+OC2QuAU3hthkW7RE3+7qYOVPKAFcd99PbkSK0/C+eZRLqkELsR
	29dpB2UV/K1whgwJGqdna2dyXAn4RLWknxzb662OQvn6f1LnRKup8MlJiWwDB/9E7k0
	b9EXQ4fo6eyOVjpa4BiG5KrVVKds20Cy2KA0uHqE=
In-Reply-To:
 <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v3 4/5] dt-bindings: input: hid-over-spi: add the
 Surface Laptop 7 touchpad
Message-ID: <010601a1ad2a2dba-85a8b4dd-f21b-4dbf-afae-9a40b533338d-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:23:05 +0000
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
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.11.05-23.251.234.57

The Surface Laptop 7 13.8-inch (Romulus13) touchpad uses HID-over-SPI
with quad address/data transfers. Add its compatible to the common
binding, with both bus widths fixed to four and a 20 MHz clock limit.
The existing supply and active-low reset properties cover this device.

Keep the G6 digitizer constraints unchanged. Pinctrl properties are
already permitted by the common schemas and need no local definitions.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 ...=
/bindings/input/hid-over-spi.yaml          | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bi=
ndings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hi=
d-over-spi.yaml
index bed0746f00..ec8c72493d 100644
--- a/Documentation/devicetree/bindings/input/hid-over-spi.yaml
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -22,11 +22,30 @@ description: |+
 allOf:
   - $ref: =
/schemas/input/touchscreen/touchscreen.yaml#
   - $ref: =
/schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microsoft,=
romulus13-touchpad
+    then:
+      properties:
+        =
spi-max-frequency:
+          maximum: 20000000
+        spi-rx-bus-width:
+          items:
+            - const: 4
+        spi-tx-bus-width:
+          items:
+            - const: 4
+      required:
+        - spi-rx-bus-width
+        - spi-tx-bus-width
=20
 properties:
   compatible:
     enum:
       - microsoft,g6-touch-digitizer
+      - microsoft,romulus13-touchpad
=20
   reg:
     maxItems: 1
@@ -73,3 +92,24 @@ examples:
         pinctrl-0 =3D <&ts_d6_int_bias>;
       };
     };
+  - |
+    #include <dt-bindings/interrupt-controller/ir=
q.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      touchpad@0 {
+        compatible =3D "microsoft,romulus13-touchpad";
+        reg =3D <0>;
+        spi-max-frequency =3D <20000000>;
+        spi-rx-bus-width =3D <4>;
+        spi-tx-bus-width =3D <4>;
+        interrupts-extended =3D <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+        vdd-supply =3D <&vreg_ts_5p0>;
+        reset-gpios =3D <&tlmm 120=
 GPIO_ACTIVE_LOW>;
+        pinctrl-0 =3D <&touchpad_reset>;
+        pinctrl-names =3D "default";
+      };
+    };
