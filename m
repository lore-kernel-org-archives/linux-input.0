Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5EF47D956;
	Mon, 21 Sep 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033264; cv=none; b=Y5ckIE1H2A8+gdCf+/Twi4p1+PGnRrAq3wjkjGOSY2VRShOagAHDDWlNQM+3ork75RzT+NPhnMFV8NbxpQ/5NAbYGyWS3ZKPlzr+msCmfrxFvm2S8vsFliizKSuTb0C3xjq61xZr0mRTiQgxnSph6xhPrgsVi6qnf4jRhhomknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033264; c=relaxed/simple;
	bh=cZVfAN3q8+dQM4azitDaaJMBpyKvo98W60GfnOjb8WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MO1gxXalNG3MbSqtmNAWvSN20nx024IWhB4bwCYJW7DJVq5M+VIb2TM5TkfCLTSTUfXpZ4uGhjlIqxw9TTKl37UsTOtbvL06nCMKLECkDp2Vx0xJeAlO+MXqewr/0dNRQpO9X7oLloqFyFjEm5FHoXCgoi9joetR6GtUaxuVv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv1fii39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv1fii39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FD21F00893;
	Mon, 21 Sep 2026 23:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033255;
	bh=9QiXw3H6nByfGSGSvTxUuKGVVaopNAoqADLQ5tT5deU=;
	h=From:To:Cc:Subject:Date;
	b=Bv1fii3948R3ovtfdNJhzdQOibYqcL66iS7Pv2btl1zSCTHjmULMBkCpgw3pAZ1R8
	 o1pUbew2Gj+wLBzoak9zB58H34tpNO7SSG1VjoXtxJ9bK+e/O8CYY/i9/xem3g8Oir
	 C/R+PAHV1gvd+j1QNzTV1u3UBZG/14wqbJXrXYevhv5nF138+QnEhXP5aOGfZsqmot
	 1lu5oUOBYJ2kX2uLC1dZRPT07iG93S1VHh/1iUtRDh/EHKGs36K6U6Wxer4riF465K
	 mO1Bjj2Bd4ZcE2OY9JKDF3y+KgJgwxggQ+df845C68VylXQ/OkKLC22sqG5/FLcArt
	 srnSHWYbjslYw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: Add AD7147 CapTouch schema
Date: Mon, 21 Sep 2026 18:27:30 -0500
Message-ID: <20260921232731.3134965-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a schema for the Analog Devices AD7147 CapTouch controller used by
the Microsoft Lumia 950 and Lumia 950 XL device trees. Document its I2C
address, interrupt, and optional vcc supply.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/input/adi,ad714x.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adi,ad714x.yaml

diff --git a/Documentation/devicetree/bindings/input/adi,ad714x.yaml b/Documentation/devicetree/bindings/input/adi,ad714x.yaml
new file mode 100644
index 000000000000..8351c28147ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adi,ad714x.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/adi,ad714x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7147 CapTouch Programmable Controller
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+properties:
+  compatible:
+    const: adi,ad7147_captouch
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vcc-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touch@2c {
+            compatible = "adi,ad7147_captouch";
+            reg = <0x2c>;
+            interrupt-parent = <&tlmm>;
+            interrupts = <96 IRQ_TYPE_EDGE_FALLING>;
+            vcc-supply = <&vreg_l18a_2p85>;
+        };
+    };
+
+...
-- 
2.53.0

