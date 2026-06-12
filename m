Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535EB3DDDAA
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249042; cv=none; b=h+9gxepwMyRVtGQ/NMF8h0cYc7f+4HDw+52X9El851t6mxFLFaTwqHGrqZjUIaH7isdoTgN2W8qm0OeFBJAx7PUo+r4ao217VzpNTkMJ/EZn6LWo1xAwLxv5zpcRWVMs+QPKMF3y+SJGrbJWOMMQosVE4nrs0DPwnENQTdVpma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249042; c=relaxed/simple;
	bh=2r1POua5Uak1EMM86PHnU2yGF0SZxOkEsj2Qssr0YtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eethd7+SUd1+WCRnXr2Vt/2ukbUvbdE7yURKKufA+Rz/QrrsKfsoIOKaGRLufzgiqTu+IPMABij9EFBT1b/dHNVAeOB954SEwyKAed5vRYsj1YzX7USHtVsTihUB7rNGCSUQQYeJBKtcYEdPhWK7ccsu0Gs/9gk8M47Yizyk4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPuO/0BL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPuO/0BL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a76757e5so4281515e9.2
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249040; x=1781853840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdrbtOKOy43UIR4Cul3JyowdVOGtAQchKw9DmBdAo9Y=;
        b=aPuO/0BL2CtgndKk6i+LsyHYv+KgwI15ilnnxG0IZgwcz1EPLAHBHLlQs3gBXMv6ta
         A6kjMf8NE3rJ4C3W0J56Cw+vpsSRNrHD0d+TlvPps6mjZjbHkaD9K0KyMhbRJ39HvOfX
         6abugkSg8CPAaDrAhWNn7/1mUU6HDoHVZ+s36wCOCvMIYFcZ3XjPAGOFGUudRsE7Tmiq
         4eG588Bu8ezgEeI2e60qInORpu+EvvIRwCYqxaQJX6BWyW1DexvDCs3itrNNRM5OTGQA
         IW3tKmnAylPSGjUXmymU62D/mchOeS8tJ0oxaHlc7kht+X5a0QX1sUE91VcG5UtAilYt
         mRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249040; x=1781853840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdrbtOKOy43UIR4Cul3JyowdVOGtAQchKw9DmBdAo9Y=;
        b=WtSF7nqTXkWRTHb6FbdPfAgNl2JWDwSYO8WPSvkUyxkUAvVSivrbfe73A3Vg9a+iIT
         YElsyIbV/hlsAUtNMg5dCSkrlAdvSbXh+X5f+AelMC/CT4te8XcSrKj7THF5Lk8dhxqL
         SmJHYbs+CfNLbom/5J2LUwbDuB499y++w/xI5Ev3icqwk12ntJhqimi1lQtojVHSQwAI
         9T6103iREjohf1HCgwgvkrlEHAVRYyLzRtEht4Qy0Sd5DK+ebmXDj7FApUQtDt2BEueh
         nE6oEWIrByYoGIjMKP95phooTX1h67c4QP/wE/U0kKR2+9ovVdKRVQsjlcdHK1040iSQ
         lWGA==
X-Forwarded-Encrypted: i=1; AFNElJ+0YUWS6zSaScjmkipWGl0kfRCwhNezRgOfLPTXamw64+OdyhI4/c+iXJYQfENpmSy4lx6HUjo5EKK8NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPinXQI250seum8akg5SWXwQCfZbEqBWzjCT2fXTjQ8xy0chf
	hudKYYu22UakW10liN4fDE0OqL3KxffXbC2YCafC+FEVfthisdb+68eQ
X-Gm-Gg: Acq92OGBujQbeW/hAPWBOyFa7BjnI7vGQ5a8Kwgcb998PEfDfPgnloY6gTD98lFtLHg
	UXpy9JVHlPXKt6ZxV2lHXW2EesLbo4hpuXS4COGgqk0t4Z2MDtZSIgN3l4Pg7o/BIiSWnQxpUk+
	LejjnLWk6UwIhJ7pLnU1QHE+eZt4HJWupkSnVHbjih7UqEFB5wlWdcv6URHskon57uAnbeK/kaJ
	ha6FBar6IXpV+lJi2gvKBFRiwgm9OUrhPSsaTpIeklJhVWhR6YF6Xbi0tE7WZwkinFj2oEuuMJ4
	E5Z8xDWYwtUJpK3I1L0Jmh+ZQDvzfC26+Ywm8lTi1HTbAlZZxyLOWVLJ0/kMzp4W3g15JvTJxWZ
	/CZKL9y/9SidVvl/KrkgMUFkk3+VVnUGLIjskFOgHr0Klwlf+1cXLJxaJ1c/s+drV8iKgAvHNQ9
	FGxHstHXxVKNz2lYvr7aZNq0CplXoC7kyFg17/9kc=
X-Received: by 2002:a05:600c:8b13:b0:490:b724:dbd6 with SMTP id 5b1f17b1804b1-490ec4b8ec8mr18729605e9.6.1781249039726;
        Fri, 12 Jun 2026 00:23:59 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm28715245e9.2.2026.06.12.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:23:59 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] dt-bindings: input: microchip,cap11xx: Add CAP1114 support
Date: Fri, 12 Jun 2026 15:22:14 +0800
Message-ID: <20260612072237.1177304-9-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
References: <20260612072237.1177304-1-jerrysteve1101@gmail.com>
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
---
 .../bindings/input/microchip,cap11xx.yaml     | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 778ec6d659a8..0e9a1a8a3f3e 100644
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
@@ -122,6 +124,8 @@ properties:
       is required for a touch to be registered, making the touch sensor less
       sensitive.
       The number of entries must correspond to the number of channels.
+      CAP1114 is an exception where channels 8~14 reuse the eighth entry's
+      threshold, so counts differ.
 
   microchip,calib-sensitivity:
     $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -149,7 +153,7 @@ patternProperties:
       reg:
         description: LED channel number
         minimum: 0
-        maximum: 7
+        maximum: 10
 
       label: true
 
@@ -178,6 +182,18 @@ allOf:
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
+          maxItems: 14
+
   - if:
       properties:
         compatible:
@@ -205,12 +221,26 @@ allOf:
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

