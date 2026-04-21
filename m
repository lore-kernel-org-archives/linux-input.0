Received: from sonic308-8.consmr.mail.gq1.yahoo.com (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166E2236E3
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 04:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776744933; cv=none; b=Z9HLbWsdsua1jWOpGDms6YAQDa34YGY0I/Rh6OyVq5iV0qOIDt0bNBjFGjUlsOXoqs3mbK/Cx+rftai0Glnh+pSxF/mM9tXBV1EVSDGKMLgNT/SeJzmDhm0QjBIFwgRukJqzPDKw1HaLXh81GEJSezTfLvtV40ei5yorlwYwE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776744933; c=relaxed/simple;
	bh=KcMHyACHfGkgYbFEIxlOJCPbm0eAYUGs8Zjr48vkHhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uge3kn7pvXFWA6ItZsYseEMYTUMERfzUyi3muDSctZtQTSsaCSANsKuHRqCg63YTtQv3vhrpBn+muoGHOQnrHYcAgP60pqHjUjKS8RLHvJZ/fK/zWndLrT48sItYe2QLE/U6CcgvEdqNEBofsd0Hb+lchIVuxB/f7pneDGbo/PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oomKo/WP; arc=none smtp.client-ip=98.137.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oomKo/WP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776744925; bh=5goy8acUoTLqV/UD/nEEaQFJlL5NbfV1oAh+nVpwYP4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oomKo/WPLvR6/hLpzcavSFQHmZnGJ0Wy7lZs51hz4DdK2F76Vnc2qW8NQ9rCdM0zfuVWWQtj1iBLkgXauL1SQz2YsPg7dJcofq+ThNCfkAq2yh6u52843YuOR8bHB9pgVuTF8oROid1gdmx+Jar/OLsM4Lf1ZkF14LlVOvXLgqY/zGmOZGGErw7e52Y1NsDcKMjIL4KYlk8h5COHMjvybLD/fCTVJjKt3jOeE2ZwU7pcXb6QzqSxydwsNLOzGIQib9T4+eEOmKSv4QM3jJMEiZsFKhB0q1AIfc3vdRy4hVYc/tlkC7segLoQVFyH9b/G1KsDTbRKYYzodS3IevfPmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776744925; bh=7NVT1AeOz20GSbIOSCU54eFzBbityvyTlUVI1VaokZ2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VlJZlbTK0XDKWbxLYV+l5OqmE40zg1RFNEA1WPYSuL+kO9PJps4TXeNcwTNnEseHQc0/oF/jvvmUNFIjzq1OBGzn+7ooMVmCjPpjxTmV/4p9+ESASDCbYIasWHoM5nyq3fUBstWFya5x6OA27/YK58Hlc8fS17dGFE7s9vtmLtqR0q5GhbbELTBtPSgxbk0A2Vap0QCQnahl5h2Hp7IN5PMNbTX8XMZMJOf+VCvO+Y/Dtu6ycHo+1zeW6UR1EoOn+bzBnjOsVcPor8tJwK9YsMfS94RZoLPKBL5pTSUjwftwNEEX6fXLq7pfowgeKXJk5NxGn1COkWfyQrQmLcvQFw==
X-YMail-OSG: z4p59iMVM1muHMIEu.BdCuEH9YUOt67LOMT2KrPSBOsOrrIOg83wExghLb3mkyF
 qwJhh3VjoV7Ftyxa1Yx86qZTVNlhVBnylOzcGx0hy6FXITJdm6w1mzfyHiIUtKq6w8w6hwcnqz_t
 pxxg5qTXqMcEAsg7DJLxzxJiqHIGFVSziUzPoPG0XNJjFHx4Fy5DoLEYa17SEHBE0ZSqoDZj67XT
 F19nQNCg7iCN74yh4g7Xt.LW2DfIFDmp7ce60.QlmF27BmoJd4oUso0HY_8aES4rNWS1b_nRyDoG
 v.EYqmQdiPVBdEiT7cnHJVJ7SdWxR1N3tfMpjCXztKgM597Ppo365MEgrB2GJKvXI2XM4QxtTYAl
 CW6KCw_WL6WDzXEuLje93tyo.35pmTTDhUzoelKAwS3LJTgOjS6uKhzo2PSciNF0_LNCdR1rRAQA
 n5R4osmwbVPFcubsMXdjeQDSxr7XZUifDF1I9chDkDjYPNduAK9QI8qAm4l6s848zi9UbBKnypV4
 H9_NhQo3i.ch0__SuOT0el2d7ADvVFldQPK6znL.k8jml4KJh1cig9KVZAcwug84_WA.q1V9ELtA
 WkCSCmxOZZqWnP.6ktZUBEbLqdMi0DAJZXg8MF5er950uqBGsNXDg_4MW4REc2dn3gw6kWI5D8nt
 iN2MBn0hk.PJJ14oy1VibLiQv5oDKT1W9Uu.uM5h705.VqBLax32QhZvOiteTZXsByuG5pq9uB1l
 BMS.mdMIXsiTn6qysR1NUHRSl5zWi9rpZPp2h60_7lcVH4Wx1NkGspJm6BZcsF0wk1c1UFC2MlqL
 tVvR59z_ClkdHqYYE6Gto03xMFmK3.caNcR2vWeCHEWb0WB_n4mjHCv44LOUM0OQW3L8L12DvAD0
 E3gTCPvBD8QuCSqny9338AMiNS8euWdBdKwI7PFkOZWK.9S57vUHY4hjN2FyOooZ_wSLF7NkJ4vj
 FgVRFpi4K6.mRX7jf0ll8B6aoFsAY2WjmfZzXahnJ3_a5cK6YDui.NR64V.BflHXfs.ZfElx4w2D
 lpH_AVqy6vV2iqBnvvawdySCmhCPMHkNBF7oxXSwWqsPegrw6TAQDVCGb.OrrRfUOEDPyklchrw3
 YLlQotG1Lac_cStqiuIEBeMjTsc_7I0jMIK9YGmz3ciOJgjMq1VdY5B2l7z3NS2B94HrtSJDNdP2
 rlilAEzn7XzzYOzP.YALzZxJrZZzhSw8hWLhCfZ2BzAaYBLdDyV1yqQhmhJc1rCE9hq8Iuplhy4Q
 kW8FG2nbW4WzwsVkGGYRYCXyHF_9Uxi.s5_nNdn9.zGJwQkhZLsPM0JKCk19c6ihOmfSORFm14C1
 Vj7rxiF9TceXcjAY8CwUeDzOaNjESTXxCTncyhQqitJUwEqzIPYUgdrDejKP56ZPI41Rh_a6mwml
 zdCjKEkHIIyEOeyKepE.2HRJLb3wc3OlWGSYuMhe2d_F2efyQ4TixfhFjjSt_gRBbCoSGYfi1Jnm
 DAQvtLOVOJKOzMxOqJl6X_McQXOc5Oqni8IKOoQjVXCA8cZXJ3Y.DvBBlNekajzd.4CfhC8UeIDg
 UuIlYOZuo895_oo46r_iwtEAdhj5EhEai5QcwXJfKMlcw1zlluyCYcYjc.9qWbIV39kJHTva3IS2
 zNF7U9Ch9b2vhu.RawVOtpUMWcBDKMchvjNLUbeVrMzzdw.1jTbzngvt8ZtbsavqWcjE7lWW5OeC
 UW3MQkPpshIP9Fidhp_pLj3gx6RHajwzeGJyxc7Scge6CHrQ4apXFuJ19NJd3tP8HpEgHBHz25Tr
 EMLbmAvBzffj9iFCV1mdonGCpvJxnYsJBSbGdkAzqwohLNlJO.S6hvAlcNJ1vehFZopk41Grzov9
 K3xIw7vhPLi_OO.32fMdlJ_.mTmEPNgwIOjjIk19Lq.CjVPuvkVL1la_ETmaaxO9gmmMyo.pdl.F
 MXFSb7KpUk3DilY5h7eVH0JT.9Ah4i5CJbHGf.D7xH9jVhZn02jp.jSzu9c6cYbQgVjMXbpsH3Qz
 1S_nQx.n6NPuUfT_eo8P3B4HTfDfjs1dF45gDEIsWypKVq6td126y4G8BZrPfvaumF2cJzoQGPza
 IYGw4uoK_IN6N7xdbtg7mm6FrJjCdWPFCKF37VAUwR9EJLcTbjfoDRdXHpgQlY_fH7flRGatGi.a
 C5.yK4lQrdoWmsqeGOb6VeOrwcqWZf68pYNPxXveHKnyKcbSglUPDHdt.ILv5Mj23OIaP0sZwohm
 QPiwI8uQLcFDt.EewVAlM1KDrUe1gYZoltrea3vbf2aTfSZElt0kfQIy0SopNybsV5YpxrLFnlhx
 ons3IfQ--
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: 9ba6305f-4170-4523-8b4a-bc259471a973
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 21 Apr 2026 04:15:25 +0000
Received: by hermes--production-ne1-555c74f9db-f7qzw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 547ad8995a07852cebd76e2cafb43ebc;
          Tue, 21 Apr 2026 04:15:20 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marek Vasut <marex@nabladev.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"Kael D'Alcamo" <dev@kael-k.io>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: input: Add PixArt PAJ7620 gesture sensor
Date: Tue, 21 Apr 2026 00:12:39 -0400
Message-ID: <20260421041505.4548-2-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421041505.4548-1-sainiharpreet29@yahoo.com>
References: <20260421041505.4548-1-sainiharpreet29@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree bindings for Pixart PAJ7620 gesture sensor.
The sensor supports 9 hand gestures via I2C interface.

The GPIO controller properties are included to describe the
hardware's ability to repurpose SPI pins as GPIOs when the
sensor is used in I2C mode.

Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
---
 .../bindings/input/pixart,paj7620.yaml        | 84 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pixart,paj7620.yaml

diff --git a/Documentation/devicetree/bindings/input/pixart,paj7620.yaml b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
new file mode 100644
index 000000000000..089e864e82ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pixart,paj7620.yaml
@@ -0,0 +1,84 @@
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
+description:
+  The PixArt PAJ7620 is a gesture recognition sensor with an integrated
+  infrared LED and CMOS array. It communicates over an I2C interface and
+  provides gesture data via a dedicated interrupt pin. When operating in
+  I2C mode, the unused SPI pins can be repurposed as GPIOs.
+
+allOf:
+  - $ref: input.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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
+    description:
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
+unevaluatedProperties: false
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

