Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32D566C4D;
	Wed, 23 Sep 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190969; cv=none; b=P//hsWBhESQAmEdjolq7fzOZVXl/mxUBrIWMi8ll6hgPIs1nRqUPR0yW+8QrjBRchnnbSuu3oqpIehW4vdk8qnZ/6SBVOS/e30cTas8USaSMIgBm6bePHSueb7UjCvzTpJrYITZ9yTCbFl3D71s/Pn0yPZFHMLRCFJhqOs+pfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190969; c=relaxed/simple;
	bh=077eybouFV37F9vBjlevL9sb02DSs61xowZQ35e+DLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PeQ028wmtGWSQHsfMer6VoT9omVBgKKigCoifJWtth5JyLfQQViy6LtQE4GyNieMiZVMt8zBQp/SHb24DHsVJ0J8+iLEsP8JzNZNymAXHEDGr6nPcaN0rfvjWv/szcuT64xsKqfCLLQsklXgWgsPgdii5MduxZdljEOUviyZ858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF92MdXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF92MdXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1251F000FF;
	Wed, 23 Sep 2026 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790190967;
	bh=F+y+zK5SFNQiaXDH2MEFqyv4uJ8kfGPRCevC0ke43Cc=;
	h=From:To:Cc:Subject:Date;
	b=dF92MdXCb+VeYGM0wDZXeJejzV9qyUbrY36/XUIDslcxiBsS77Cs3ipOT0MQMulpt
	 L8QpX2U7TjPqqjiY9NOABBMSUdwrCMJHoPrymUPPpmoDBKqbMd6W+/1joQ/OPGEJfm
	 pNx/Li1gaErDHemo5Hx+LxVF6yPLug8Y1npFLjui0Nf1pG8gXelEN+rVgVade6lrDf
	 1rARBV4nqoMu3j7o4k/EZTC+pHrQwMj4Td8mXb+Ln3fvkwjq2vlhupcql10aaSBsaE
	 taW90GQBmYx4554JWScyBD9aasijby4Sicp1Wpu7xxxLdY/CW9sqbk33iC2uvULy2f
	 oRyXKMc6CQIaQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: input: Add AD7147 CapTouch schema
Date: Wed, 23 Sep 2026 14:16:03 -0500
Message-ID: <20260923191604.2213710-1-robh@kernel.org>
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
v2:
 - Fix filename to match compatible
---
 .../bindings/input/adi,ad7147_captouch.yaml   | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adi,ad7147_captouch.yaml

diff --git a/Documentation/devicetree/bindings/input/adi,ad7147_captouch.yaml b/Documentation/devicetree/bindings/input/adi,ad7147_captouch.yaml
new file mode 100644
index 000000000000..1120b85276a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adi,ad7147_captouch.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/adi,ad7147_captouch.yaml#
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

