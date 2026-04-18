Received: from sonic316-8.consmr.mail.gq1.yahoo.com (sonic316-8.consmr.mail.gq1.yahoo.com [98.137.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DE33AD8B
	for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776493388; cv=none; b=CKYeDUlafbAgdxKphDd/AXA6BbMqgRRkf8FCDac6l0CPH8C/tbxyvH1DkFHxe6UwMo3LshZYcXspn4Qh3Is8YBDkieyio79ejcnW1mVEN12jJV91QYiAO9XBQPfmaqY22IdXNvWeianjA1tz61X6HMmQDLPexdThcWkrM6UJn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776493388; c=relaxed/simple;
	bh=tJ38sPBE44u7cfCEI1L+UkQrsZMnWslKX35E8jdDMMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmgCPvOlswSb80TVWH9KzyTW9PlX1kLE40A3pKUnfe6cf9JPOy6BMxDn23RccVFMU8CUJvmyxTbakAcwFrVtQdFj3PIuEhrvdAudje3GThk+TH47xN6K7VH2B58bVxrS4txvK/3Z8vOJcODQierveap+gfA2qazBZypbRZDyzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=geJGM2Mx; arc=none smtp.client-ip=98.137.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="geJGM2Mx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776493380; bh=16Ijfd48/GJzocvRwiaCCBgeCnMlll5aL3qExpRPjkY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=geJGM2MxExChTDZO71Ox6hfJz5SCZi20X2n37WqlpXW0SzHsA1nXSepeeWh2w9v3tEiiDuasLTFB45I8mJXYULlcyNL/e/I9v3FbpcznsBYrJ4I92NguPAEgcbnX1AnUcjAOLRZ2r4sTatiHMnND2768pUMnp4AkJslSFNoAlr1oad/Gll717rsmNB8gvJfgo+IDfDVp3S6/as3XBRjyBZg6tReptxPk58hjBlUUofbZYJ44z4RcdTJtc2GiEnDXARO1rVe/wZHR/QiYTfdDvxODuUz/370ZGnHsvkDW/5+YbdM1L0VUeEx0b4SJMnD3j0TcaXKVzdJ0qNKcuaPkjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776493380; bh=nSkS3+2Xny0PR0E4ff086TXsNobctPMxP0zTdCh4nq1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=msXF2hqby9X2RIJrFFWXXXCX+rOLjwcWStHAVXduib6uujsdyAvaL8KBFVtcEhqhgmftRL+lAQlUM0MHmKhbrmFiPapdyVpCeucltWH7esgk2Ok63CJz78i17Yxl/FzjwsJFERdb7v5N0ocAXyHRe1ILe1LTXytc4OY9TkIlDgemwfcyW2l/CJQN0Ia0SgP67T1B184wjYXjqCtFw9yL1nI+zZndrX4+7PRDhGH959HkNVo6NCLAE5Clgm0z8l7GOsajASF6rm0jwPmB5m9OdDpHTH1fwE/QSNv9Nv2k9PVCDkikHGkgtv6BO6pdknSWSYzELHROb0Ajnncbm498vQ==
X-YMail-OSG: LDI9BA4VM1nXKl_F1akmFxZmvws1PaShMAhVoccmiTc3HJGa7bSSNS99ZfzKhRa
 6kJs0i5Ue5u7zJYbPSKfGgPk_eOP0qOMf9.4kRjUQYEQgTtD4.BHu7X7WR.ZJELGlSaXTctfa9Cc
 4KDzAlzbzpu6z95nrqvjfTX_d7lAvcGnepXZytwlJpilSzxmpPG1u6wDObuzRV4A3kV1GK5Gz1kg
 GGnWcS48JYHyMsFGuTdeg5eiQ0boFeKrAH.HfzwUYfaFKbjpHYK4o8XQhsKE1ncE78N64LXzcFsp
 Eky4D8dYkPjRQeoqlsImaFfvgEEot3aRGPuH29kILcggsfI5laShMX78x528FNYXQEAa9dVKhqlM
 z5RkQkf6atOECXUZVZ07TYN7XZc2nrEt_N4.9V1gCQyLYa7L9we5NQ1yb3VRExkFlqxeBW5fpXgz
 qHnbeylaal1HsKHC3D6Or8S7aGCswoXlrFaBLGHucwVYFLNwT56eE8hwgh85mnmEjBB_PeUXckkH
 .9gqf40GG4zt47XesBELkmaErcwtMxB3qUGluqdXfd728oE6HuNVfZeer8O2eH_Lpi7qpS7wd75i
 sSL8vXVHB_nLV1EY9m3ZKDjMqjw3heHQnk0Yyt8cVP0.sw9QtzPbViEyh9ufs8vheG3FKOObettf
 Asa1sIw1sCVs87bNuL1y2_Rd6OG1gT14LklcXssg_b2abKr4SUruPtANRF4f264o4unGvDBtTQ_h
 4s9ZfLULOvcGaylTe1Fuxbnr7Up8VX_nRfiDrEFC8oLcVtqyR55GbRtuhHIuRhXPZXt25E0Yrdwy
 1G7eoQMDCD9wXRuy8OwxZp1HWlTziNXSprxKKLroIUG_nCSPTg1N0xmNFPqMWrkDyfAvvBYXQO.1
 pUdlok408SoR.Dq.BJpzS3yjz.QXDnTH3LV9v6r3LBXKDZYG.A.p0QRFuDzJR4FrrbWgiVf.ZPFT
 nNl78ry2wEDBxVxFFP_atubBaSX8a7kyIXKBhSKJgsV0ASuMThIgkMDnB4IpdeuzdvKPlaPC4Bri
 wUMBf.dfAyq2AbR_OgppEGsGNvQZACXBBPhzubweYWYDgR7QYTauWVQ_Z7fCubWl.V6lAHwOoX7P
 omod9ruFNxouWm_9V9pvYAqYcOmvmQBNaRcQxNaxcl7YYMnujboHtdjIrJ3JEiCKYys.h.Tj8HZZ
 PPHcbt.NYBbJuWxF7q5YfaqBlBl.bfJswWqe6lK4yLG3ty8x7.ZUgDOPi0ETmj7fmVqZnADRcFLJ
 mZZuAYy6golhQ.IZoubx.35Q1G5Ix1.1i.dAFp6iT.YXyYa7aYzemkb1imzTFM35TQFiWY0NuBj5
 8FOWGAhc5b4qvK8fYNzSlBaVthFW_Icjy54jdu1ngkApud0SX6LxC1UI9h_cRk2CKfz5A8BDicsB
 kkU65LmxLvVyan5hONKjaI1_WOajzfLyWBLyg4CBb9DvQje4esmAE9NJ2N.WJj6ucZJ94bKHrE90
 8dyDy3MnRgieMLLjBCHXxMVtz_Ms.rZIW3UxeGHpk3lPgQLRhIL2s7jr2nP4d3wHoruTjhtkhGWR
 nJGeuDjQoDhN1gtyNN1H95T_PZlr4t_lo5c9nblijwBK5XMKAoBYQBkIORm_Ag2X4.nqMMMNDn1u
 YuIz2l7A.ZwmrVUz2kB_ppdPeT.K0dXd3ToX19eZ8SRWmLXC3lUmmkp5mv8cjAMVSiSF4zRqsJbE
 mjKP3AXhv9fL2J8xNXGzg7JWC_Ptcw7_j2vu1s5YawMpa8gN4n4aI8pQC91Kku3OvnEj9hlrE6It
 pRTlfktcZVPwLLDtgjJ5YGIBj8mNYrpxs68LJZtz..jGrld9DsYg8aH6JRDwzfvTUl7_e1dwNJvL
 DDQzNiU.mv0W1czxKMbpYjpwhcfOT5abtunfUgkfJxAHrwKsgGLiWnxru2p0sefjyL.SiFHtAdGO
 Cm.PydPnj0LulBzo5O0z0h8ntKFtfpZs1r6T8bsJqOoKar0475bQTk9bfX51NiqcqHhuh4CX9xCb
 12N8EKcEmHlaKnFSGajb1E3wJDEjA9N7.foSij2VgoAwR7ChVRi7c6YbGBweCgFQAaqfzEuzzFKZ
 3olKd8Yf7eFaKColn2fUojIuXTfj_IIscoNDiDT6slGOdK.1DrRspJuqYixf_vAr6t46nVXHrENR
 ZonKtawvx9xnghtccj_jKVTy6AKHN5FeccatTyzR4DooYpRAz.edB1r2Dtzq1654ZZTOu3HmsxrZ
 78NohXAhQXLZILvCsOaIwy53MeUmOHsGKfoELcJoAZPE0fJ4ilb0Aw.TgFmb0LAyKmTv_It_epOr
 R9sU-
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: 46d901d5-3c57-4e52-8f99-ef2646a429b8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 18 Apr 2026 06:23:00 +0000
Received: by hermes--production-ne1-555c74f9db-s8l8v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b432dcc2b987fc70763d717a7e8da0f3;
          Sat, 18 Apr 2026 06:22:54 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: Rob Herring <robh@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: input: Add PixArt PAJ7620 gesture sensor
Date: Sat, 18 Apr 2026 02:22:32 -0400
Message-ID: <20260418062241.104697-2-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418062241.104697-1-sainiharpreet29@yahoo.com>
References: <20260418062241.104697-1-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree bindings for Pixart PAJ7620 gesture sensor.
The sensor supports 9 hand gestures via I2C interface.

The binding include mandatory power supplies (vdd, vbus, vled)
and optional GPIO controller properties to describe the hardware's
ability to repurpose SPI pins opeating in I2C mode.

Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
---
 .../bindings/input/pixart,paj7620.yaml        | 79 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pixart,paj7620.yaml

diff --git a/Documentation/devicetree/bindings/input/pixart,paj7620.yaml b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
new file mode 100644
index 000000000000..ad051cf641a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pixart,paj7620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PixArt PAJ7620 Gesture Sensor
+
+maintainers:
+  - Harpreet Saini <sainiharpreet29@yahoo.com>
+
+description: |
+  The PixArt PAJ7620 is a gesture recognition sensor with an integrated
+  infrared LED and CMOS array. It communicates over an I2C interface and
+  provides gesture data via a dedicated interrupt pin.
+
+properties:
+  compatible:
+    const: pixart,paj7620
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply.
+
+  vbus-supply:
+    description: I/O and I2C bus power supply.
+
+  vled-supply:
+    description: Power for the integrated IR LED.
+
+  linux,keycodes:
+    minItems: 9
+    maxItems: 9
+    description: |
+      List of keycodes mapping to the 9 supported gestures.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vdd-supply
+  - vbus-supply
+  - vled-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/input.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gesture@73 {
+            compatible = "pixart,paj7620";
+            reg = <0x73>;
+            interrupt-parent = <&gpio>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&reg_3v3>;
+            vbus-supply = <&reg_1v8>;
+            vled-supply = <&reg_3v3>;
+            linux,keycodes = <KEY_UP KEY_DOWN KEY_LEFT KEY_RIGHT
+                             KEY_ENTER KEY_BACK KEY_NEXT KEY_PREVIOUS
+                             KEY_MENU>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..d73a0bf62b62 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1273,6 +1273,8 @@ patternProperties:
     description: Pine64
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.43.0

