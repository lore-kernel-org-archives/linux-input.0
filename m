Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B6188005;
	Sat,  3 Oct 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791038120; cv=none; b=n8pUJgw9VPanD93+m5QXTeAKYLloV3POvQ3+mT1SP/ElJhFPLkkUNM6VefrhW5T8aWcIi5gbe3ODQaXWQXuDxZ0laQzQdmdHqdqIaV4cRKgFLI/M6kqsR/eE9NT6ipu0pBS2NfWVEBFDeNHn7v37VgP5u/VfuPBzgX07BPo1MEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791038120; c=relaxed/simple;
	bh=YnjFiWZTU25P96SOM/113XT29lqqu2NedPamohQPT3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dn8HZVyFLBKNZ6bKRjvCy+nNZgnO+YEfNqOrPHm1RJeJBOtYZBitE53/M5qgXKhRnLzPbSZeaqsnsU+7XISYnMBzxDUvkxzLtbTnBWYyhD9c1CWoOdrTp+D/t0URrJNQJOMKYrZf4pEC4IpvqkxCf0EimZ5DYrF35RSknV/m7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=OCqZvUmv; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="OCqZvUmv"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791037667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHtRCUPvWXQ2yKooMmNb9exSBswbRUWe3oTXiQdMuLc=;
	b=OCqZvUmvM9XDHFgAv769vRfqlJvRSjZQZ9Kws/01r9BMoy6Wj6qR3pkdDrV+lYAOTmeQb7
	DlHDxfVmO5ZMvUvsmh26gsXRIO5vg9otO76Ze+vai0cpFgOmD6og18VTLzM6g8SNabw1p9
	5np73+NOsj5GJRyNJX8Z2vyCo7+hYI/c36sRbVwdr3bEYvCe1Rnh9hjWFDa97k9Z+sX8Sa
	bPDdSykGsQbam/rPTZKvFTf6gL201GSRF4yiBPfMDHPsgjASV31YKKvLJfpWTwH8gKoKEN
	eaZo6DqnuGIHMrDBF5bVPjMmBa/3nm3o6xM64suXh7BSwBETDS/tk8ta7SmoFw==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Allen Lin <allencl_lin@hotmail.com>,
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
	Felix Kaechele <felix@kaechele.ca>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v5 1/6] dt-bindings: input: Add Himax HX83102J touchscreen
Date: Sat,  3 Oct 2026 16:27:36 +0200
Message-ID: <20261003142741.48634-2-michal@nozomi.space>
In-Reply-To: <20261003142741.48634-1-michal@nozomi.space>
References: <20261003142741.48634-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Allen_Lin <allencl_lin@hotmail.com>

Add the binding for the touch function of the Himax HX83102J, a touch
and display driver integrated (TDDI) controller. The touch function is
connected over SPI and shares the analog supplies and the reset of the
display function, so it is powered and reset together with the panel
and has to follow it.

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
[michal@nozomi.space: rename ddreset-gpios to display-reset-gpios,
 describe the shared supplies and the display reset, take over
 maintainership, drop Rob's Reviewed-by because of these changes]
Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 .../input/touchscreen/himax,hx83102j.yaml     | 98 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
new file mode 100644
index 0000000000000..c9f229bf9ca7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/himax,hx83102j.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax hx83102j touchscreen
+
+maintainers:
+  - Michał Kopeć <michal@nozomi.space>
+
+description:
+  The Himax HX83102J is a touch and display driver integrated (TDDI)
+  controller. Its touch function is connected over SPI and reports HID
+  packets. The display and touch functions share the analog supplies and
+  the display reset, so the touch function is powered and reset together
+  with the panel it is part of.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: himax,hx83102j
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vccd-supply:
+    description: Digital I/O supply of the touch function.
+
+  vsn-supply:
+    description: Negative analog supply, shared with the display function.
+
+  vsp-supply:
+    description: Positive analog supply, shared with the display function.
+
+  display-reset-gpios:
+    maxItems: 1
+    description:
+      Reset of the display function, usually driven by the panel. Asserting
+      it also resets the touch function.
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency: true
+
+  panel: true
+
+  firmware-name:
+    description: Specify the file name for firmware loading.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - panel
+  - vccd-supply
+  - vsn-supply
+  - vsp-supply
+  - display-reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ap_ts: touchscreen@0 {
+        compatible = "himax,hx83102j";
+        reg = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&touch_int0 &touch_reset>;
+        reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+        spi-cpha;
+        spi-cpol;
+        interrupt-parent = <&gpio1>;
+        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+        panel = <&panel>;
+        vccd-supply = <&regulator>;
+        vsn-supply = <&regulator>;
+        vsp-supply = <&regulator>;
+        display-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 72294ddfa5b75..e209f0d44fa73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11729,6 +11729,12 @@ W:	http://www.highpoint-tech.com
 F:	Documentation/scsi/hptiop.rst
 F:	drivers/scsi/hptiop.c
 
+HIMAX HID TOUCHSCREEN
+M:	Michał Kopeć <michal@nozomi.space>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
+
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
-- 
2.55.0

