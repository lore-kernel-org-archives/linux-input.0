Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE33624C1;
	Fri, 13 Feb 2026 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002879; cv=none; b=huRl1WB90tycWVCEj5oBT6eMr5neQnjjaEsdOmB9JOudqGIDu7TcVAtJ1rtpiwpn8cDNsg2Gq9G92PYQnzrQMG6StbFBKx26p1AJigr1EyM/NC8b+6F1A1PFm85jIFLYs8Z9l85amUVQA+ZzYDpw4W4PTQ8dS/op6LrXvXgFTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002879; c=relaxed/simple;
	bh=Wv+4y1tAcGqJOTyA1fZuV0d60O1SZSd4XH11J7U9Juk=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=gIqgQRU766oChMkjVKx5NXknFoXaqUBhtDTDy4XMeAaQ+TyeFHhFoOz13YNvNacz6sYZEUROOsVwZ/e8y4pQeJoqN+ft19+XjzxdxB5aNcGJL6b3tQT4IGnolTNoLOd5EM/AIOzZKQYhZ0rlLLpakY9Y9vUade4H6P+z/98biFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=StOhYP7f; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="StOhYP7f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=+Y2RgLXDgNIKLMeOTPhP2GoKWeQQcPvO3uERG8Kvy84=; b=StOhYP7fdjobizygYrXN8MxU79
	3exp+6jYDioO5V743jIeSpVSwZSxwmITbjUt4U2ny5jCa1cmibaROhxqAwXLGNVykYLQvGumciI9r
	sk+wX3EWvEqGO6CHMNBTrFFr5oeATfL2iDO+efmWEv014CBZtWiWrI2iMAA0B+X4/ksc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49782 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vqwkV-0007VX-NE; Fri, 13 Feb 2026 12:14:36 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hugo@hugovil.com
Date: Fri, 13 Feb 2026 12:14:25 -0500
Message-ID: <20260213171431.2228814-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213171431.2228814-1-hugo@hugovil.com>
References: <20260213171431.2228814-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v2 1/2] dt-bindings: input: add GPIO charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add DT bindings for GPIO charlieplex keypad.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../input/gpio-charlieplex-keypad.yaml        | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
new file mode 100644
index 0000000000000..1672491a75a85
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/input/gpio-charlieplex-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO charlieplex keypad
+
+maintainers:
+  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
+
+description:
+  The charlieplex keypad supports N^2)-N different key combinations (where N is
+  the number of lines). Key presses and releases are detected by configuring
+  only one line as output at a time, and reading other line states. This process
+  is repeated for each line.
+  This mechanism doesn't allow to detect simultaneous key presses.
+
+allOf:
+  - $ref: input.yaml#
+  - $ref: /schemas/input/matrix-keymap.yaml#
+
+properties:
+  compatible:
+    const: gpio-charlieplex-keypad
+
+  autorepeat: true
+
+  line-scan-delay-us:
+    description:
+      Delay, measured in microseconds, that is needed
+      before we can scan keypad after activating one line.
+    default: 0
+
+  line-gpios:
+    description:
+      List of GPIOs used as lines. The gpio specifier for this property
+      depends on the gpio controller to which these lines are connected.
+
+  linux,keymap: true
+
+  debounce-delay-ms:
+    description: Debounce interval in milliseconds.
+    default: 5
+
+  poll-interval: true
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - line-gpios
+  - linux,keymap
+  - poll-interval
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+
+    charlieplex-keypad {
+        compatible = "gpio-charlieplex-keypad";
+        debounce-delay-ms = <20>;
+        poll-interval = <5>;
+        line-scan-delay-us = <2>;
+
+        line-gpios = <&gpio2 25 0
+                      &gpio2 26 0
+                      &gpio2 27 0>;
+
+        /* MATRIX_KEY(output, input, key-code) */
+        linux,keymap = <
+            MATRIX_KEY(0, 1, KEY_F1)
+            MATRIX_KEY(0, 2, KEY_F2)
+            MATRIX_KEY(1, 0, KEY_F3)
+            MATRIX_KEY(1, 2, KEY_F4)
+            MATRIX_KEY(2, 0, KEY_F5)
+            MATRIX_KEY(2, 1, KEY_F6)
+        >;
+    };
-- 
2.47.3

