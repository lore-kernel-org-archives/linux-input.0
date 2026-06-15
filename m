Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1D3FB7E1
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533326; cv=none; b=MwFhwUx+UMX8aGJA4pQFpTskM3RBMrwyKFqbVMNVApaEzLMoy5sM5BYqJ7XVSJ92H6ctzhwLQqLIiyMFRATyyLL+rlVMQBp7qatmdZMZVrIO0Y27IgbyyN8BjP40EC9Msbs6huGq+uf3Ac2zG83a4hV7TBaO+/qmfNn/ECcTORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533326; c=relaxed/simple;
	bh=iHKOwldk5LupYan9G/BOnh3ilsYh8zrKFzR7oq1zynY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0+/6QlM7Lu+gPAjoannJOMll9nUWhh2r+ipOktCrt+flGnTlXS9HQFB0QqSJrg4n0lwaNPsWYTpmdmoGezFCtFpzqCJVkOKbT2hG7y66VrDNymQ8DEoSmT6rafvhTaxwfMZ1SdANpbA/pjBb8CvQN9N18aXiJieRBG/Tlwc060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTh9bO3m; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTh9bO3m"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso2884980a91.3
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533322; x=1782138122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7LpvffETFGATC9Llgg+0YkdwcNx1yrLnN3roKnz6jU=;
        b=RTh9bO3mK1/EGAuw+5R5PXJWuVPc5mmFJVc6yz1phqj5Y1zQo4HNtsKdrinhsF36At
         sbgt8nDAlusgt3IuO92mi5c7eh8BpnlWh3+1UKYbn2GvONr4oWE/YysZ4Z4zR/SapYhY
         szxDIrwh8wYcC9kIwymV4CMPEzWjVduYKW40HMkMUnO5TkihD3i9ip0O+x0pTCBVg5SE
         0/30TByo7MKJzFsd8/3c0TA9Mw0G8mY54QdOQWILguHrsC35Trh7XrFTWYsj9o7olkwB
         +vo6dvFF8++v7VB8ikWTfZqxNG4LMYLLq/qwVmMW+VEpKq4NbveMMkCPBTFERwU3tmEE
         gJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533322; x=1782138122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q7LpvffETFGATC9Llgg+0YkdwcNx1yrLnN3roKnz6jU=;
        b=CuJMTL9T58Kas4Rl85q9Qp4S7f+HnOPANwt9zne5rUOPf8zY0x3gJtdcmcysEgt1EX
         Qhuv31IT1fhgAF406HFG2YZcmRx91e+K0ietCcdfO/ozU5ETk+VcToxqeli4BTuqd6BD
         e5Nfir7bHXGX/zik0tUo0jemunMl5jwYnVwVw0tyvK57peFDjUo2rIa+iXzCiZJLj9SS
         PxiJmPlhyVh5FifqQg3nnzR0iK9LBE2qkhez0wnHV/K8KzRxJP42uu0SU5fHgiXfnJbg
         LIvoel8aDdDANIbqy/RwJPCh3R+ZCf/x+1LTOl6HTaALxEx3a/2Tlb1Fg4TKaSdgeY1W
         bEbg==
X-Forwarded-Encrypted: i=1; AFNElJ+0OlQi7+ZwMlHB3XYeohzUvNFUA9a4qFe7Mhcis2BkcNSTN95FyxIqpJv5+knShRr3UEPBCFtIQHIXWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHMrseFKJCEd5x1ofj1g978fsIPBsHFSXg2umYkFmST+v2NGZ
	tRFRO3snsSZpsFZ0aUs3Cv62gLfqYPZBgVJ5KZZqGXJMq3VeyRIf6/NK
X-Gm-Gg: Acq92OEfxvRCVcNkH+GGyOT5MYhpngvxfuvs9gU3c7E+uzosazTjso1RK8BTyf49CWm
	teIvK6llIPTF+SLQ5F9sOrjzQ6JvJvhxZrT1rEnLBzEKktb70zm8DQ59iilKwT5/glpSS8ja/9R
	dH/iTMI7LRzyT0NOx1olsZNMsBfjKdDAoVkul9hJKCuK5eODsyC5eSflamBLf2AYXiE16CqDkaS
	j3dyzK0rr/EW4tKuQuD9rUS24UKpDpX46kAjsmFJstrwWnj+GoAUfhqHrwyNopv/Iz+dBgf1Hci
	AmZ55i8rpyojFC2uu4i4k+LL+fD7UuODq5oizq+gDbO+wfLV3gn71oLFw15mVekWCnCaQuPLgUz
	gh3SA94kgKJJCioFvy8lNsl+ld1vnG0eDu4MF+DIBMec2oI2TNhEhV9ZEcaiKIjazGupOoULSWR
	k40RcfkeDBzQED8X0dT+jF
X-Received: by 2002:a17:90a:ec85:b0:369:7421:75c3 with SMTP id 98e67ed59e1d1-37a034e4dd5mr14770094a91.16.1781533322146;
        Mon, 15 Jun 2026 07:22:02 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:22:01 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] dt-bindings: input: microchip,cap11xx: Add CAP1114 support
Date: Mon, 15 Jun 2026 22:20:35 +0800
Message-ID: <20260615142103.352163-10-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615142103.352163-1-jerrysteve1101@gmail.com>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
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
 .../bindings/input/microchip,cap11xx.yaml     | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 778ec6d659a8..153099d59d1a 100644
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

