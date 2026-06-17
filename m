Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B943637A
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708669; cv=none; b=me6D1tjtMp/iwo3G5FrVAcQ6JdhtN28IJFlL4U6LDiWGew4Gqfv1xhN1MR/ES/sYHF6I+xp14g261eF15feUKcklSHptb7vpyDf7wJBMyAKpvzoPwUbBy+DdDD1XWENWtvZSv8qItvaYXw/k3Z4gCwOn82FJxC/+G2RifSH83gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708669; c=relaxed/simple;
	bh=e/VCvIPN3xEV8dyOzALNT15BGkRomrKEnAP30XoX0ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHs8KFyLAvZiuhds4CIFvewubb/7E8Ko9mFHNu8AdVjy7b9qHGCC6TkJtz20wNPQFvmEOIHluSsr//JBHHzfdS4DRsWXmG97f7h/ZCvqSmRerHlTldL18937FpfJ4eBbtlLOMEWDB1e2CRkDtaCQ/Rm2yc7f1bqFXv17EdImCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8c00rfF; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8c00rfF"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662ccb916c5so1156389d50.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708667; x=1782313467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATCNUvbIHGzcge3S+9KxpJQvKqQ4MLcIrGCywDLxz7I=;
        b=I8c00rfFYQbcqG+6kYB7EIOjGxopucwZGGDytrciMDBEdVMhel7djs9uSGUQQKZVlW
         ZODiWAzUoXCamC44l3w4gA8143xTQji1d5Y1U8lWNcke20DqezxIY4zG7/uamyDzLoTq
         HOezx6/gJmTnkWkLYxOXwbJv9IoOSFvFQXNtYuBLYkJCInDxqzeKgkd7YLJh/D+GKLMK
         437sQsTW+DV/njGzY4ksH3BlrPU8ez+irUdicIdBYH9pbvT7I0PK5pxICYVIUBR2MZAU
         Z23sKy4vjtmF/KLS7RmgWHKIqbm5g20qRBKyUEFauy8HqGKsGnf0Jk9noYoFhfrXQM73
         r0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708667; x=1782313467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ATCNUvbIHGzcge3S+9KxpJQvKqQ4MLcIrGCywDLxz7I=;
        b=qtIXrOa3Cgo7u9OerOmEqeS7XjhY9z2rpA93o17H3Pcs1073QdsIwAPJnQ7Xebtg0d
         Q/fjQ0Y3M1r0jDP1acqwnCwA0qJJcNuneW7RiRKt2IYscvSSCYIXyUIsOp7hwsyMAPO7
         MadG3rkAzpQKCeNxeMnhGkEnbGC0hnPPQAP7WWO1PtFZfCX8qqTumpz2g405+1FD0O/+
         3PgoglT4KpgsQ+dic4GZgvQjiS6AD7jGfUJPLwYvZgeLvaRjt7j8EVkQQsugDGm4F9GB
         kYMRxVSd0AMxIyHYYp+LhLZe8/mGxQzajn7pv0VXkHnKrVzC2gdBs2UH8Lp1ZTD1LxzP
         +BnA==
X-Forwarded-Encrypted: i=1; AFNElJ8p2d/jeqbue/9l8orWywwfTZ6kt52u+FH2xNLMVnXIUrp3MOveizZKV5tT/1j5Z2vsOswG3qcQUcFeLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dIpNmKsrCDOCirBur//egAyygC2+wppOuvVNrJg4JAJQvGrp
	KkcWjruvl3EpsXWCRTX0SNHr9M8jVyjRInhKw7NhAXkUXFMoDshURnlV
X-Gm-Gg: AfdE7clmn6EDTF814vRVbRfL4IAh3IEiS/oxhU5zrjsnTHzUm/YQFXSnQvyVOedK+gY
	pmW/1uDCjSb0VS7QrhKzs8L7aqpplgXXEJrs7g1HbLLC/ZQgIdKAGGlttBEqEg+/V+EEYhD+TQV
	kCvSUp5u4Wm9nHqIn8ju348vvuN18vLCEtOx/KFmuEvY2QiwN2zPzzJIFxSkGUwAYcjwn6fTIgg
	G4gsSM0gNJVpFQGYxgIRJhGEJbUaJNxEDpxt5M6ZqtdOw5r6+xnqTq1tttSAwNxXXVzeaw2tgAJ
	OFdK4e7CImJ0GsD1r9w5A8yB2PUC2KKDcJt1PtWNpOcCN2/FZOyZqJ/GcwTZRyxo/LwWVKzK+pO
	SygypyduMPJHZS3oeD1YOx7u6sRHGfWrX3DXnTfiq3ZVAWJo45y2lekzdutehEnNh3MqwQP96Wn
	foAB06NJ/Ljg==
X-Received: by 2002:a05:690e:150a:b0:64a:d479:bfbe with SMTP id 956f58d0204a3-662cb8d4500mr3104102d50.11.1781708666886;
        Wed, 17 Jun 2026 08:04:26 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:04:26 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/10] dt-bindings: input: microchip,cap11xx: Add CAP1114 support
Date: Wed, 17 Jun 2026 23:02:48 +0800
Message-ID: <20260617150318.753148-10-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150318.753148-1-jerrysteve1101@gmail.com>
References: <20260617150318.753148-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAP1114 is a 14-channel capacitive touch sensor with 11 LED outputs
and hardware reset support.

Add the compatible string for CAP1114, add its datasheet URL,
update the maximum of LED channel reg, and add constraint for
linux,keycodes.

Previously, the LED reg property had a default maximum of 7 for CAP1188.
With the addition of CAP1114, the default maximum is now 11.
An if-then constraint is added to limit the LED count for CAP1188.

Update description for microchip,input-threshold: CAP1114 only provides
eight threshold entries, which does not match its total channel count.

CAP1114 does not support microchip,signal-guard and
microchip,calib-sensitivity.

Add CAP1114 to the unsupported enum list.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 39 +++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index b97e5b2735f1..2a37ac252c37 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -12,6 +12,7 @@ description: |
 
   For more product information please see the links below:
     CAP1106: https://ww1.microchip.com/downloads/en/DeviceDoc/00001624B.pdf
+    CAP1114: https://ww1.microchip.com/downloads/en/DeviceDoc/00002444A.pdf
     CAP1126: https://ww1.microchip.com/downloads/en/DeviceDoc/00001623B.pdf
     CAP1188: https://ww1.microchip.com/downloads/en/DeviceDoc/00001620C.pdf
     CAP1203: https://ww1.microchip.com/downloads/en/DeviceDoc/00001572B.pdf
@@ -26,6 +27,7 @@ properties:
   compatible:
     enum:
       - microchip,cap1106
+      - microchip,cap1114
       - microchip,cap1126
       - microchip,cap1188
       - microchip,cap1203
@@ -62,7 +64,7 @@ properties:
 
   linux,keycodes:
     minItems: 3
-    maxItems: 8
+    maxItems: 14
     description: |
       Specifies an array of numeric keycode values to
       be used for the channels. If this property is
@@ -122,6 +124,8 @@ properties:
       is required for a touch to be registered, making the touch sensor less
       sensitive.
       The number of entries must correspond to the number of channels.
+      CAP1114 is an exception where channels 8~14 reuse the eighth entry's
+      threshold, so counts differ.
 
   microchip,calib-sensitivity:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -140,7 +144,7 @@ properties:
       The number of entries must correspond to the number of channels.
 
 patternProperties:
-  "^led@[0-7]$":
+  "^led@[0-9a]$":
     type: object
     description: CAP11xx LEDs
     $ref: /schemas/leds/common.yaml#
@@ -149,7 +153,7 @@ patternProperties:
       reg:
         description: LED channel number
         minimum: 0
-        maximum: 7
+        maximum: 10
 
       label: true
 
@@ -178,6 +182,21 @@ allOf:
       properties:
         reset-gpios: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1114
+    then:
+      properties:
+        linux,keycodes:
+          minItems: 14
+    else:
+      properties:
+        linux,keycodes:
+          maxItems: 8
+
   - if:
       properties:
         compatible:
@@ -205,12 +224,26 @@ allOf:
             reg:
               maximum: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1188
+    then:
+      patternProperties:
+        "^led@":
+          properties:
+            reg:
+              maximum: 7
+
   - if:
       properties:
         compatible:
           contains:
             enum:
               - microchip,cap1106
+              - microchip,cap1114
               - microchip,cap1126
               - microchip,cap1188
               - microchip,cap1203
-- 
2.54.0

