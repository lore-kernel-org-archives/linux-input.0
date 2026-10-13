Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A88566C68;
	Tue, 13 Oct 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931513; cv=none; b=iLaOeHA8lodOlCRkSBQpnOmWG3YQRHOBi8CIjAMaxq/Suq+ceGEDW8roUPHt8Iix7IUBnCE4kuubX60exmc8V1NAd7pRjvzAIH/cjUV8ZGFMyuvoJGcU7I44gnSj6Yh6fejSrqaEw+kzuPLGOphekPK5KEy/lvqltkKEA8r/yaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931513; c=relaxed/simple;
	bh=3EsJmmFXsxsqIIyuqk1zGpdUk89XWj/Y22U7+gT2mnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ViOZUK+wm9S1wsgUOS4HgEj08YI02qKMN8h335URasdf6n4QzelD3SsvXeWsq+hRwWw46yAjotDOwjW0llT7W6IZE+r26e8Avq9q3nUWun6AC0UXzgc9+h+6YOadndenVfNtxfT+JtvWTd7PpxKbQ4eTxKqzyytu8yOxs5Cj9Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRnOYy9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRnOYy9L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF33CC2BCFB;
	Tue, 13 Oct 2026 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791931513;
	bh=3EsJmmFXsxsqIIyuqk1zGpdUk89XWj/Y22U7+gT2mnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qRnOYy9LuBbnNV3YGKMGo3dyFM3Xhl9OGr5z3aLiKczBDAoH3nbxxG02vCZ6B88cA
	 UmS3yB+0Ztye8HxKhbb2BQSL6WrhGUhSRVvsQlErn25HR6Wf86msiHKeetwDTOiDVi
	 sCvtNqz+jy5pFgPshox9ug3wnGqVSmoBHTjAn/PpANOERZP6umgScwfFWeq1OOI34l
	 qvK3hdaLW8D9jrqlpviTlSqYKkakz7CdPFsWiArKnvGjJze22i1/rirdxDlRntPiK6
	 ZwUYtLo/z3MZyvQygsHhnxkqzmFsv3kKg2y+WTtYcO6Nr21U4ZzX14L2uTYnO/JVSM
	 wtZ9w2Ghs6oMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF430CC6B15;
	Tue, 13 Oct 2026 22:45:12 +0000 (UTC)
From: Mizuno Miotsuki via B4 Relay <devnull+founder.crepuse.com@kernel.org>
Date: Wed, 14 Oct 2026 06:45:10 +0800
Subject: [PATCH v5 2/3] dt-bindings: input: touchscreen: add Nsiway NS2009
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-review-self-ns2009-v4-20261013-v5-2-0851740cd939@crepuse.com>
References: <20261014-review-self-ns2009-v4-20261013-v5-0-0851740cd939@crepuse.com>
In-Reply-To: <20261014-review-self-ns2009-v4-20261013-v5-0-0851740cd939@crepuse.com>
To: dmitry.torokhov@gmail.com
Cc: krzk+dt@kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, icenowy@aosc.io, conor+dt@kernel.org, 
 robh@kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3748;
 i=founder@crepuse.com; s=20261012; h=from:subject:message-id;
 bh=J5Vu4eaGlLH4g1cPvBTxdXuhSAI05sIXWGBXtk2x+To=;
 b=owGbwMvMwCUmds2G2fVJ/hLG02pJDFnntpTVLuk8/L/QVn/JLH7GBTsmpK/TOHODP35/xtZZS
 38UCmwr65jIwiDGxWAppsgyW5S9/FDzimtzJzTZwcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6BjrGDFycAjDVW80YGf4Xrcj29ts0lb3iBNfjV5OOr4vb5V9+5u3miIdyXYKfJBoZ/sppH2l
 t5I7yFPiiumZBgN9E9oqQKy77ClgrNinz3P2SyAkA
X-Developer-Key: i=founder@crepuse.com; a=openpgp;
 fpr=9B150777C283A8D69D90823E16D63C0345E46FA4
X-Endpoint-Received: by B4 Relay for founder@crepuse.com/20261012 with
 auth_id=1166
X-Original-From: Mizuno Miotsuki <founder@crepuse.com>
Reply-To: founder@crepuse.com

From: Mizuno Miotsuki <founder@crepuse.com>

Describe the Nsiway NS2009 four-wire resistive touchscreen controller,
including its pen interrupt, main supply and external reference supply.
Keep vref-supply optional:
differential touch measurements reference the driven panel terminals, and
the 10-pin package does not expose a separate VREF pin.

Allow the common coordinate and touch resistance properties, and describe
the raw Z1 contact threshold separately from calibrated pressure.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>
---
 .../bindings/input/touchscreen/nsiway,ns2009.yaml  | 79 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 85 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml
new file mode 100644
index 000000000000..8ee7ff7156ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/nsiway,ns2009.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nsiway NS2009 resistive touchscreen controller
+
+maintainers:
+  - Mizuno Miotsuki <founder@crepuse.com>
+
+description:
+  Nsiway NS2009 is an I2C four-wire resistive touchscreen controller with
+  a 12-bit ADC, an active-low pen interrupt and touch resistance measurement.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: nsiway,ns2009
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Active-low pen interrupt output. Optional when the signal is not
+      connected.
+
+  wakeup-source:
+    type: boolean
+
+  vdd-supply:
+    description: Main power supply.
+
+  vref-supply:
+    description: External ADC reference voltage supply.
+
+  touchscreen-min-pressure:
+    minimum: 1
+    maximum: 4095
+    default: 80
+    description:
+      Minimum raw Z1 reading considered a touch. This is a contact detection
+      threshold, not a calibrated pressure value. Boards may require a higher
+      empirically determined threshold than the historical driver default.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@48 {
+            compatible = "nsiway,ns2009";
+            reg = <0x48>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            wakeup-source;
+            vdd-supply = <&vdd>;
+            vref-supply = <&vref>;
+            touchscreen-x-plate-ohms = <400>;
+            touchscreen-min-pressure = <150>;
+            touchscreen-max-pressure = <4095>;
+            touchscreen-fuzz-pressure = <16>;
+            touchscreen-inverted-y;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..696f2badc49c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19467,6 +19467,12 @@ S:	Maintained
 F:	Documentation/core-api/symbol-namespaces.rst
 F:	scripts/nsdeps
 
+NSIWAY NS2009 TOUCHSCREEN CONTROLLER
+M:	Mizuno Miotsuki <founder@crepuse.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/nsiway,ns2009.yaml
+
 NTB AMD DRIVER
 M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

-- 
2.56.0


