Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6238F931;
	Wed, 25 Feb 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034865; cv=none; b=hS4VvBzmM0foC5cBciYU2+++a0tLnYJFKoo3uriPnl4X8w4BZLocwz760NqlW+L7MGnr+GfhC5WBpZ/DW1wmTufCcYsHrBzHbPWj1bEqZRjL455gwqgn9gweg6j8n1FRjF+1VWaWWHFHaPnjAmHXMxFKI1r/qmW2jO5B9IQ5EOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034865; c=relaxed/simple;
	bh=xwieGuFpW5SNyjYgVjLUefXyKWf3Y5DCc1CeIBqFKLo=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=pWTCC52GL/jYFSKOo5THWqcIYDjLcLbLgw1LojC6ERTfV23KiWRCckYrgcp+e72QH5iShe7hLxP4quLEGDyrp3JeDUkZP0KyxnoHwE/jDbc/SJIGkuSo8Qnb4kW+kR2fSManEeUkoDLe/POcLMTQV12V7Xz4XQtQuXVjJNUZ+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=iOswTt2q; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="iOswTt2q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=faZvFWUwi+UVcnr0qhwBPMqLzuXN/R2EuHLgNgE03ZM=; b=iOswTt2qCd6EYVkX/pC+ZJ+iZY
	uklpL5zkz+rK4OGrrArqhWj8a38G1nu2Lg5vm7ksvj3NRYGqArl8gzkF05depzuH7I68SHtIi8RpT
	jLZ0/2iNZWDv9BR8LkfG3vwApds22n9SA9dm06yQggZamSWOgCbVz/0u8g4UT6od5kTM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47746 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vvHDJ-0005uT-OB; Wed, 25 Feb 2026 10:54:14 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robin@protonic.nl,
	andy@kernel.org,
	geert@linux-m68k.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	hvilleneuve@dimonoff.com,
	mkorpershoek@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	alexander.sverdlin@gmail.com,
	marek.vasut@gmail.com,
	akurz@blala.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	hugo@hugovil.com
Date: Wed, 25 Feb 2026 10:53:58 -0500
Message-ID: <20260225155409.612478-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225155409.612478-1-hugo@hugovil.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
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
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
Subject: [PATCH v3 1/4] dt-bindings: input: add debounce-delay-ms common property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

A few bindings are already defining a debounce-delay-ms property, so
add it to the input binding to reduce redundant redefines.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml    | 5 ++---
 .../devicetree/bindings/input/cirrus,ep9307-keypad.yaml   | 7 +++----
 .../devicetree/bindings/input/gpio-matrix-keypad.yaml     | 5 ++---
 Documentation/devicetree/bindings/input/input.yaml        | 8 ++++++++
 .../devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
 Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml    | 2 --
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
index b90eec2077b4..c46a2471f8b1 100644
--- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Robin van der Gracht <robin@protonic.nl>
 
 allOf:
+  - $ref: /schemas/input/input.yaml#
   - $ref: /schemas/input/matrix-keymap.yaml#
 
 properties:
@@ -33,9 +34,7 @@ properties:
   interrupts:
     maxItems: 1
 
-  debounce-delay-ms:
-    maxItems: 1
-    description: Debouncing interval time in milliseconds
+  debounce-delay-ms: true
 
   linux,keymap: true
 
diff --git a/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
index a0d2460c55ab..25b8b29c87d7 100644
--- a/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/cirrus,ep9307-keypad.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Alexander Sverdlin <alexander.sverdlin@gmail.com>
 
 allOf:
+  - $ref: input.yaml#
   - $ref: /schemas/input/matrix-keymap.yaml#
 
 description:
@@ -37,10 +38,8 @@ properties:
   clocks:
     maxItems: 1
 
-  debounce-delay-ms:
-    description: |
-          Time in microseconds that key must be pressed or
-          released for state change interrupt to trigger.
+  # Time for state change interrupt to trigger
+  debounce-delay-ms: true
 
   cirrus,prescale:
     description: row/column counter pre-scaler load value
diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
index ebfff9e42a36..69df24a5ae70 100644
--- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.yaml
@@ -18,6 +18,7 @@ description:
   report the event using GPIO interrupts to the cpu.
 
 allOf:
+  - $ref: input.yaml#
   - $ref: /schemas/input/matrix-keymap.yaml#
 
 properties:
@@ -46,9 +47,7 @@ properties:
       Force GPIO polarity to active low.
       In the absence of this property GPIOs are treated as active high.
 
-  debounce-delay-ms:
-    description: Debounce interval in milliseconds.
-    default: 0
+  debounce-delay-ms: true
 
   col-scan-delay-us:
     description:
diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index 94f7942189e8..502e0b7eb500 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -14,6 +14,14 @@ properties:
     description: Enable autorepeat when key is pressed and held down.
     type: boolean
 
+  debounce-delay-ms:
+    description:
+      Debounce delay in milliseconds. This is the time during which the key
+      press or release signal must remain stable before it is considered valid.
+    minimum: 0
+    maximum: 999
+    default: 0
+
   linux,keycodes:
     description:
       Specifies an array of numeric keycode values to be used for reporting
diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index e365413732e7..914dd3283df3 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Mattijs Korpershoek <mkorpershoek@kernel.org>
 
 allOf:
+  - $ref: input.yaml#
   - $ref: /schemas/input/matrix-keymap.yaml#
 
 description: |
diff --git a/Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml b/Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml
index d2886f2686a8..542ba5114424 100644
--- a/Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml
+++ b/Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml
@@ -76,8 +76,6 @@ properties:
           debounce-delay-ms:
             enum: [0, 30, 150, 750]
             default: 30
-            description:
-              Sets the debouncing delay in milliseconds.
 
           active-low:
             description: Set active when pin is pulled low.
-- 
2.47.3

