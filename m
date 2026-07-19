Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6628274B5F
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468284; cv=none; b=MdKYbLuNAjZ1uOR/sDOXHD3oA5MMm3BhWGhbAoxJnRxPCkkla/RnnkzdUl/QYepUc0eBEvgxA6zMmEJyfFYDL0abGtabGM/xy9AD4mYn0opnPeXSfl49KvX6RbBnV5NqYDQJSLNDNBHObQRqm3d3E8ZC9PRSgZJ8sqoCLh8QOUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468284; c=relaxed/simple;
	bh=/O3+ndtGNpRqsFMhBUN5/uIG0FG38qsIlDe1l7WBD4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pP8N+PD+GFKAMz5zavWJdvdQxsSufODiDeQkbg/+f7eHsflzX5LRkyZWfayPnAEKZ8mK3d1stZe04yHFoiwbC+H8DmAkOS7dMTG5Dsve3y7Ehk4xFaupNe6xyCeAGSrseTvJsT580SSAtl1JwDNVD3ehs80QlCzNMq1pesq2tOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOZ+6Zx1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOZ+6Zx1"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so5429243f8f.1
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784468281; x=1785073081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1a8IU4oZNpjbRSTqawhDwH5UJx4Zty6Y9NRCDB79bc=;
        b=sOZ+6Zx1YfefeW1TllXqMGJPMtjY2+Qqns1A24j5D1yC0TNSJOLVqqb25HIG/A/680
         1PdDwO17BBQcac8hjc8D4MfxMNP9ZorTyPVbMp2gUpCTWUKxOI57hC6YIEpVgFrXzbDg
         O+2XRk2F9H+nUURG69fx81VHmcNYVJ8YBT7AEFQqIX2kA9s5ImjtXXrUpg9zEQIbLImZ
         cUOL0vKTS+VJphk8/JNj6kvtn9PzgJ3xdGNnxIvugVqLiRJob0t6YByjkQ0ers+GroOJ
         +WlnMxxIkhRpmd7stR78e5DgON3k1751irFQEzObuoK/m4jPWx8cO6jEuYqg7A74xrBD
         3+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468281; x=1785073081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y1a8IU4oZNpjbRSTqawhDwH5UJx4Zty6Y9NRCDB79bc=;
        b=HSmR4VV+jeCV3UFn/8OSzj7mBrYZzKOHwNz9MaejDon75qlMt55oYlZ1xfALVeuzMh
         CqdFKgtF77DoSGKW80cfSWLyhwA6KknoPu0kCPysOWPcQXxwbUnyWjlJKL+Fypv4Hijq
         7RjAVsAAcQN0gg6CTUqL3Gw0VVEeTBWbpJfOiMZH/QFNl9TI/e7dRvhAfsiJZrwzwhhR
         73I7VTwQSM3JRJJCAqaeYBC7e0zd2ZSRTQ6zLZSfSqy5bo6LOCONcHB8wwSKTLooSdNJ
         sEka/weiT3D5DT7FTS87rw02wo8pak50SrhfWod1xFRpZUleyMrc2Pb/Fl+SOTZSLT2/
         bi/w==
X-Forwarded-Encrypted: i=1; AHgh+RpBLaqOcZ4bP5XlsX2zHsyPYkHWViN5JipViyiPcPzvWNfRdHOnE38/aIMCbvGbzKGzHpQpApXENbMDQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+DUExQD/+TXJBq/6vHzZ99nVTZ8mHAkBJhvIZ78lDHFXHvPC
	/r0t6Fs4CULaLVuUW6gcKu5CkoQOQaQ1boxgVL/VROxx1rgDYAzlUI2O
X-Gm-Gg: AfdE7cmVNd+s1OW0EgB7un2/LTJwbAZWLDhSNEnSQie+kgHJ4Mi5dTUfQ2FcDEvt1N2
	dsodZ66it6M6Mz8aa+YIu4/G93BqIQONqKXr1tIQICGbj2lFPTH1SL8It0hjtzmlCRslTVRIlGK
	WvXgQS5T4rjzzeHnSKe3dDBd7baI2cO8zsNWueddYTsNZ2O3nAiBqG9mb9oFanVecsLMf/H2mT6
	8PeQAyRjPQJ9Ag7lbm0Ix/l7b9zhEHkJT2juMsl3dgG7xJjdwKvmDegD4NcESUlFUzty5BrwGxN
	Ypql9VzWaEdAdQ18HUVGTa2zLEQzvv3/RT9hXsx4I1GDd69Z1Khtt9ZlowEMOaHA6zgkHit11Go
	WNlTXDUXlB7K1PFd+k+bmrbr8MfWVElvjsGQaaM7FRKq+wXJPlcthlUCMchXh0YX5lNXO6y3+/i
	D67Kubtm5kgOBGpTz9w7BhWRmyaiGUB+seGLd8oIvQwOrd1sg1ulO413Y=
X-Received: by 2002:a05:6000:22ca:b0:461:a16c:a5f4 with SMTP id ffacd0b85a97d-47f62318b75mr12127661f8f.33.1784468280802;
        Sun, 19 Jul 2026 06:38:00 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63edda9bsm21807179f8f.31.2026.07.19.06.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:38:00 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 1/2] dt-bindings: input: Convert TI Keypad Controller to DT schema
Date: Sun, 19 Jul 2026 13:37:29 +0000
Message-ID: <20260719133730.3551691-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719133730.3551691-1-egbostina@gmail.com>
References: <20260719133730.3551691-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments Keypad Controller bindings
to DT schema.

During the conversion, the following updates were made:
- Corrected the documented property 'linux,keypad-no-autorepeat'
  to 'linux,input-no-autorepeat'. The old text binding documented
  the property incorrectly. The standard input subsystem property is
  'linux,input-no-autorepeat', which is actively used in device
  trees and parsed by the kernel.
- Added the 'reg-names' property ("mpu"), which was omitted from
  the original text binding but is actively used in device trees.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../devicetree/bindings/input/omap-keypad.txt | 28 ---------
 .../bindings/input/ti,omap4-keypad.yaml       | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/omap-keypad.txt b/Documentation/devicetree/bindings/input/omap-keypad.txt
deleted file mode 100644
index 34ed1c60ff95..000000000000
--- a/Documentation/devicetree/bindings/input/omap-keypad.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* TI's Keypad Controller device tree bindings
-
-TI's Keypad controller is used to interface a SoC with a matrix-type
-keypad device. The keypad controller supports multiple row and column lines.
-A key can be placed at each intersection of a unique row and a unique column.
-The keypad controller can sense a key-press and key-release and report the
-event using a interrupt to the cpu.
-
-This binding is based on the matrix-keymap binding with the following
-changes:
-
-keypad,num-rows and keypad,num-columns are required.
-
-Required SoC Specific Properties:
-- compatible: should be one of the following
-   - "ti,omap4-keypad": For controllers compatible with omap4 keypad
-      controller.
-
-Optional Properties specific to linux:
-- linux,keypad-no-autorepeat: do no enable autorepeat feature.
-
-Example:
-	keypad@4ae1c000{
-		compatible = "ti,omap4-keypad";
-		keypad,num-rows = <2>;
-		keypad,num-columns = <8>;
-		linux,keypad-no-autorepeat;
-	};
diff --git a/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml b/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
new file mode 100644
index 000000000000..5e0c101f9ba0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,omap4-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Keypad Controller
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description:
+  TI's Keypad controller is used to interface a SoC with a matrix-type
+  keypad device. The keypad controller supports multiple row and column lines.
+  A key can be placed at each intersection of a unique row and a unique column.
+  The keypad controller can sense a key-press and key-release and report the
+  event using a interrupt to the cpu.
+
+allOf:
+  - $ref: /schemas/input/matrix-keymap.yaml#
+
+properties:
+  compatible:
+    const: ti,omap4-keypad
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    const: mpu
+
+  interrupts:
+    maxItems: 1
+
+  linux,input-no-autorepeat:
+    type: boolean
+    description: Do not enable autorepeat feature.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - keypad,num-rows
+  - keypad,num-columns
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    keypad@4ae1c000 {
+        compatible = "ti,omap4-keypad";
+        reg = <0x4ae1c000 0x400>;
+        reg-names = "mpu";
+        interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+        keypad,num-rows = <2>;
+        keypad,num-columns = <8>;
+        linux,keymap = <0x00000011   /* KEY_W */
+                        0x0001001f>; /* KEY_S */
+        linux,input-no-autorepeat;
+    };
-- 
2.43.0

