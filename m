Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42F3D9058;
	Sun, 11 Oct 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742931; cv=none; b=L4ffM9m8EPG6bVQ92hBzmrnbnLtAwPfaw2ydbMB4v7CQQYW9pzIGamuJSduJKfIekwPjR1EI/2OBtxFkJrAFDG5cgAqV9R5WkQqGzHiRRJ9mSilZcu/9EmE6ybexH2eg5cLQ7kAVjgBJc9MknfuRm9ziff76E1sCmEqAUn2+aWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742931; c=relaxed/simple;
	bh=UB7xWJx1RBBjSwNodonLHLCsWFYVbmM5Cfw9+jQotTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSn1Zi44kRHxgGbK8xplkFMBSg3plHTEh/SnyFDY0TbVHcgFEN+oizaP/NcKmawtdXIyikfYkRbviMtMsFmsFYPSXLFwVDzVqyA64ss3GU1iQNHDK6BxX5rt4z1+iiaKgGRqUo/KFcGWin6FiatxIKsZTBIjWbMwmMHjAVDmeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=OewzcbOM; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="OewzcbOM"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791742597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+ZyLocKTaEdGSy/+OIgE6gDvQVDoIaLeI9kLrTDJqE=;
	b=OewzcbOM1lSj7xGaToXFx+1iDVopWIvnWQfhWuX4uHYlIeWux764/6LKY1U+m4Z5zPSp9N
	JHdbin2NEYjQsdDVJetilVMG+XdvyaeR+k8s9+Uya31mEE1o5dIAo5PKvNDeRD9pcdDhtY
	rhIM/yqSTSVAH2IsQ/r2XRBJj6RqJYc6T5M53k+KFV1DQdfaelWp19WjgRw/+KLNPINUuJ
	f4JIl0FZuZVW3LWoR5uldoGSNaICIGQk3jPX5I4c4i5ybHClA4IsCzK80UJYtw1EraFeiT
	k3LfKlkv0My7UhTWuTl7/Fckzc9VeL8dqQNXWnk0MUWLIc26LGpyFtkynEC6Kg==
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	allencl_lin@hotmail.com,
	tylor_yang@himax.corp-partner.google.com,
	felix@kaechele.ca,
	dianders@chromium.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v6 1/3] dt-bindings: input: Add Himax HX83102J touchscreen
Date: Sun, 11 Oct 2026 20:16:31 +0200
Message-ID: <20261011181633.1778969-2-michal@nozomi.space>
In-Reply-To: <20261011181633.1778969-1-michal@nozomi.space>
References: <20261011181633.1778969-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the binding for the touch function of the Himax HX83102J, a touch
and display driver integrated (TDDI) controller. The touch function is
connected over SPI and shares the analog supplies and the reset of the
display function, so it is powered and reset together with the panel
and has to follow it.

Co-developed-by: Allen Lin <allencl_lin@hotmail.com>
Signed-off-by: Allen Lin <allencl_lin@hotmail.com>
Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 .../input/touchscreen/himax,hx83102j.yaml     | 98 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
new file mode 100644
index 0000000000000..f0aca7a6662c9
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
+    description:
+      Reset of the touch function. Unlike display-reset-gpios, it only
+      resets the touch MCU and leaves the display function running, so the
+      touch function can be reset without disturbing the panel.
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
+unevaluatedProperties: false
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
2.56.0

