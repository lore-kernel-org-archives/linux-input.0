Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6429B781;
	Thu,  5 Mar 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738478; cv=none; b=d3DKYTGMB5ls5Cl24xtbzoPMkWwwKYh/6SQM+8PfYoB4S+EPqFQCAzr7d3zmrDUgiJOEAtFXKbPtTSmiR0n0NBgq3JorvoNB9nrUw6mEgsjykQWsi4fbPmbcgEohVsDP1K+SS/jH+oAfrO/ZzCOcxqpppYIDAW8UCjdJJz5yTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738478; c=relaxed/simple;
	bh=ORwyYTCOsc7lt/iMUSpfiVMYFKvNw4aWDK0L+edCsu8=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=pIEnIiJRvqUO+KkxoIiN313bk61YmPHZxLcvPNN+N6nJyisuhjSZdxHwsRWQlg1t9/DhPVquCnZRUYDYqf+LSHmNrsADlCeM3bLcy8izhTLKJk/fk+51z8L2RncW+LlxxZxK7WbipVRI37Tp6GaebeuKXL94/HitPkoiv/Vxjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=KJkog6T+; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="KJkog6T+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=ZTjX1NIUMBoYUB+DFaJvTxmvlS7C8JUOH2s4Ng6ToTE=; b=KJkog6T+gwUF+zASbYF1C5zO6W
	2MkxJL9dmu+FbxrdyGTBKfk+gyY69JaAQsLaihej8xXs8yrb2p3BL/fBvgwIqmcv3k56YcfMhrSao
	cEacROUtHCIB5QileQC+vFSOMX05rHFXiuI4kHX8GduQnfjKqsc+WQKPXfnLhaA6D9ug=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42592 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vyEFx-0002na-46; Thu, 05 Mar 2026 14:21:09 -0500
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
Date: Thu,  5 Mar 2026 14:20:47 -0500
Message-ID: <20260305192101.2125660-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305192101.2125660-1-hugo@hugovil.com>
References: <20260305192101.2125660-1-hugo@hugovil.com>
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
Subject: [PATCH v4 1/4] dt-bindings: input: add debounce-delay-ms common property
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
index b90eec2077b4b..c46a2471f8b10 100644
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
index a0d2460c55ab6..25b8b29c87d70 100644
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
index ebfff9e42a365..69df24a5ae701 100644
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
index 94f7942189e8c..502e0b7eb500a 100644
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
index e365413732e7b..914dd3283df33 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -10,6 +10,7 @@ maintainers:
   - Mattijs Korpershoek <mkorpershoek@kernel.org>
 
 allOf:
+  - $ref: input.yaml#
   - $ref: /schemas/input/matrix-keymap.yaml#
 
 description: |
diff --git a/Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml b/Documentation/devicetree/bindings/mfd/fsl,mc13xxx.yaml
index d2886f2686a8d..542ba51144243 100644
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

