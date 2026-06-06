Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996A38239F
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758351; cv=none; b=enVgfgX8MlbVh7jKuWlg6Qqa8hwwBLOINJsC/atKoZ/FHwheeL4jxnGm5vldOd/gji5kjcM6JSmq2287saTYfujllSfhRa8ceEvRij4e9n1V1szOqaI4iHThTkciGUvCbieqdNehh3ttn35+Hc6gUL1AwfvW5Mikp+yEdPWBSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758351; c=relaxed/simple;
	bh=B/E42DH9L0OsbjnEU8trNPtTAk1YF5VphsZ/yuA524s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiiyOIM0Wyhbey5/j7BnFOnR0s8y5AAMXbBRaDj9OQrR0zhzTPOyPB/5x5m/nT97nVFIZa9pg4d4Aw+IyHq20gm49oJRQ3pzuZDpIZ2K5hlFpNH8S5zEjzhBpPX06iAVNdtKktwi3k4fYTVyRzfTgMl2kZLyAHjh5hX48YDdJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0MO7IhL; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0MO7IhL"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1370417c01cso3998840c88.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780758350; x=1781363150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mfLlaOvP8Xr5tMlVdxU7GEA4dRW3fNbCN8mq/+hgMc=;
        b=Z0MO7IhLKpBya3udjny2xbfnbZHptm3NNpISUacoXcUc2q6EnpR320TEIWLljASZP3
         B56xwSd4jArhpV1nfQW/9dQlGKHjh5v0EFn65MYD5PrRPHzu+UYXmyRtN6ckrjyUYHdP
         T1SmiNW00XMvBm854/zqkcfSBuQZHiivDF+8XpEkAZyTBhBbOpwyTbq3b5iY6b8n9z3p
         10p86Dv2tQB4fdcsLu34d8asWioJ9iG8icVgnodrNaVzwluJR91MZV2ceD5256pWiOVI
         d/5LfN+w11firD+MDgEy7mQc2It5LX9vlD3Mf/UtUPhN0reDs13TgXEw7jBHhsw5+ttP
         K0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758350; x=1781363150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mfLlaOvP8Xr5tMlVdxU7GEA4dRW3fNbCN8mq/+hgMc=;
        b=M1rTY0+8ZxoTP3LyFjaPOeeiA8QDVhff52qMaJhqhJhDFX060Wb0tzvUiCpOyYaeEp
         QfZUU1mruXG0BJCeI6FiRVPlQrXBO9GACs5MmS3QkjobGpKVPmbJgD7PG6vX4nOF8QPF
         JNPeLyKjheFAMASJryfcC8FjmVV12suD49MM3ZbOuXNn2WbsLDI2KkptVeNTT6gEeZwS
         nP9i3ohh1w/GuORinZF5thewVjrBVOduoM0KOYWPI3VXko8kTsMcGn2SzEFrpm1N1dJL
         v3jHCjrIdJFYL3/7STBQLrSd52wpwWZPyWHeBNB7SXwfZTbvla/IszIwDMHiyjv7tXPH
         MKfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YOQciOUME5H0xrTfOZao2jWVSjAvsrmN/O9xHHHFPWyCSqDnbcSfaQophqT08EwYJcjmZxpawgPMqVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3K9Hu+BlBU4XcazpbhdisETF5ot/yQfhy54lyp1+W7b6rr7a3
	Q2xTRW1qpPqzFtcTqxwh4CyvqMiYNaREwmN5ZSt0uhxQ2XraDsdsqXyb
X-Gm-Gg: Acq92OFKjjan6Vro7R6m/sQJl7TlETlz095B6Hwc1WcGZdYddYQ0iXmUzi8Vy1Reex4
	ye6rnWntmL02Gks2fGf+ZZ+N1ylSsGnsOStR9xlwhL06hajbvao1/Bs7nyazQZEKlzDGjJkks2R
	nPnEcoD8hUjekdu6z0RiirYzq6zRx74XHHXChr6mayRSVS1hqiX/QSMl67E6vutAVT/Y18VXg7X
	0xxGyjGX78Q+woAUtBt/zq4FkRezLy4KmpWaVbzgvkgOC8orp/WxdG5sUfV1uanxLUu4PpjbcjW
	uGtnwd2uqRJmdzzI4n2S68+vYjRwJ6BKaaJj0UkFBgjGCfndHWlPAVWsO/GpXOZJEP4p0Vkvf0f
	RvCPMSn6IBlPwmjUjti1C/ePb+4HS6wjLqM6i+sZXHErmuRw+fp7EhH8kvCuHZ2MeXo53HmTWEh
	PrudS1vIRfYthgVSBETrP6KPBQLSW+At8vjWZxj/Ky/iJZGCpXOhaimgH3hLZ8
X-Received: by 2002:a05:7022:603:b0:137:eceb:6f44 with SMTP id a92af1059eb24-138066dff52mr4328792c88.22.1780758349745;
        Sat, 06 Jun 2026 08:05:49 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm8415607c88.11.2026.06.06.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:05:49 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: input: microchip,cap11xx: Cleanup and refine LED constraints
Date: Sat,  6 Jun 2026 23:03:56 +0800
Message-ID: <20260606150458.250606-4-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606150458.250606-1-jerrysteve1101@gmail.com>
References: <20260606150458.250606-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add detailed datasheet links for all supported CAP11xx devices.

Unify LED node pattern to support all chip variants in preparation
for CAP1114 support.

Remove redundant LED properties inherited from common.yaml

Apply per-chip LED channel limits:
- CAP1126: max 2 channels (0-1)
- CAP1188: max 8 channels (0-7)
- CAP1106, CAP12xx: no LED support

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 51 ++++++++++++++-----
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 7ade03f1b32b..99d00f572a2d 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -10,6 +10,15 @@ description: |
   The Microchip CAP1xxx Family of RightTouchTM multiple-channel capacitive
   touch controllers and LED drivers. The device communication via I2C only.
 
+  For more product information please see the links below:
+    CAP1106: https://ww1.microchip.com/downloads/en/DeviceDoc/00001624B.pdf
+    CAP1126: https://ww1.microchip.com/downloads/en/DeviceDoc/00001623B.pdf
+    CAP1188: https://ww1.microchip.com/downloads/en/DeviceDoc/00001620C.pdf
+    CAP1203: https://ww1.microchip.com/downloads/en/DeviceDoc/00001572B.pdf
+    CAP1206: https://ww1.microchip.com/downloads/en/DeviceDoc/00001567B.pdf
+    CAP1293: https://ww1.microchip.com/downloads/en/DeviceDoc/00001566B.pdf
+    CAP1298: https://ww1.microchip.com/downloads/en/DeviceDoc/00001571B.pdf
+
 maintainers:
   - Rob Herring <robh@kernel.org>
 
@@ -124,25 +133,21 @@ properties:
       The number of entries must correspond to the number of channels.
 
 patternProperties:
-  "^led@[0-7]$":
+  "^led@[0-9a-f]$":
     type: object
     description: CAP11xx LEDs
     $ref: /schemas/leds/common.yaml#
 
     properties:
       reg:
-        enum: [0, 1, 2, 3, 4, 5, 6, 7]
-
-      label: true
-
-      linux,default-trigger: true
-
-      default-state: true
+        description: LED channel number
+        minimum: 0
+        maximum: 7
 
     required:
       - reg
 
-    additionalProperties: false
+    unevaluatedProperties: false
 
 allOf:
   - $ref: input.yaml
@@ -158,7 +163,20 @@ allOf:
               - microchip,cap1298
     then:
       patternProperties:
-        "^led@[0-7]$": false
+        "^led@": false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1126
+    then:
+      patternProperties:
+        "^led@":
+          properties:
+            reg:
+              maximum: 1
 
   - if:
       properties:
@@ -183,6 +201,9 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -208,19 +229,21 @@ examples:
         #size-cells = <0>;
 
         led@0 {
-                label = "cap11xx:green:usr0";
                 reg = <0>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_GREEN>;
         };
 
         led@1 {
-                label = "cap11xx:green:usr1";
                 reg = <1>;
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_GREEN>;
         };
 
         led@2 {
-                label = "cap11xx:green:alive";
                 reg = <2>;
-                linux,default-trigger = "heartbeat";
+                function = LED_FUNCTION_INDICATOR;
+                color = <LED_COLOR_ID_GREEN>;
         };
       };
     };
-- 
2.54.0

