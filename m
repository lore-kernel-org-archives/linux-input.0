Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA42E7376
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572788; cv=none; b=H3Ey5dcl/CVH+h0TQ1PwtoBNFv8KVhkZjkUWGlB9IxcCVcqH8TQENrbZ/qs2kwLcT3pgN775n0I2ymhEvXM6xbjppbfejrf4vF1pVZCwlBnEi0Z6mX16YwIJOJ9Ng2Q/7trwoGhLXsEb9NDWzf0qRxeGNbBrYMRmiv+QCgS5bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572788; c=relaxed/simple;
	bh=IzA8rReWtoTvbgvPeZqmsULd7KQqqwFSSfde8Qmik8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCzEDruR/U++HiaIazMGXSjMynLDjCaLTyOoKfMFeEF+AcfYPNDtsXqdX8SPwyyPcRI+27PiiclZULSpIeboaxpDE6EDak5fSGoWhFx47xCoYI8SyEceEbnlT6sda5Hvy/ONzkLzK/55gQfO4ZIaG4g7oPuzhsj4iml0Wuytwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6SooBR7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6SooBR7"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8482074a000so1210120b3a.0
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 21:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783572787; x=1784177587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awUJTEIa7g3yBed2Klo/gvRsPy9nUmrKXk19wqIJEdQ=;
        b=Y6SooBR79NTF6+R0A1RqXgftVYT6OEvX5ypg6uwJ5VuQWGe9/W283vg3PtPt9ZcsG2
         FnpBVPz8pv/PxYI9czc7w+rZ7W9hiIFOfpujMnrSQsrBJOd+uE1bbxXueI7PQyU8amIk
         O9R8KzfaoZuSqqvrJSIe6IyBzGnkdMUPEvcTTr0OOQzmn8w9Guwt40cjz93OsKTo9uVT
         xUGZmBj3Xu6qpF2op5h37Eipu8IDq6H99Yl3Sf62JM6wzGBHBN1o85hea/wi9eCbpzUD
         6Os9uobtBKdBKvv+xcNTOL05+5J3t96W2uk3Km68L/eAkp1Fd/yqgUI9Jbdm8y6OjzJW
         EhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783572787; x=1784177587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awUJTEIa7g3yBed2Klo/gvRsPy9nUmrKXk19wqIJEdQ=;
        b=dilibLJ0A+I5PD8bqKWH1uR/m/sOhkV/z1h2RyyqRuxCmVaAUiSojn9HYyLDOt+PpY
         u4BVgUyy+Jw+j2DxUe7R5pWkHjVaaFbHhkS72ZYEqD6NAOEcus86B3Q/yGoqKAU12MZD
         IgvS1b7ogVWHoJC4oaREFbdJOvXFheuUrdA5KCQ29tAnA7CpAqS+PLi754mlrCSeHse2
         h7NW+mxo199+B9zxxj8ys9GKriM8quaYrJxKGUxUDvi7lYngRz9AJfMJb9gU55ZctcZG
         MrOuZ+5+Y3N1eQwScxsfrCTFrB3v+52B5gPtGdIDCQVCTysO2NWFhkluKgI5/Ij/LrbB
         DpkA==
X-Forwarded-Encrypted: i=1; AHgh+RrngqnUN6XUrhyqvahFJt0QxYniVvNAla4GgAzIw9l26EAb1seyVgOFDqydNNzSQSmsu7SIT6R7gRY/rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+Tep3uZeP1W+IEoo5Jzh58VEfJErqrpiG+MeyD12jaUvbzis
	oKl7kQuuQCdfNA6Gw7CPtkHMmPPj/IUOjeZnj9dIK4pwefkg81vpSqMw
X-Gm-Gg: AfdE7cnBTpYeaBSK76DB732Mw264q/62xE1850T+3jJ6Eov5dl6bkHann7Q3F+E+i98
	/AKYADi030vBa25SofmUC63PcFVL+BS5wwTyRoupH8q3fkXtbL1/pBhfFc80T2Jzo5fWM0KC8sc
	IJvuQXynUfD0C47nUDRdYmursOr5tjw4fTyUTRjbUCg9y1DZf5itxT3TM36vuEXcOEtkLkWT3LD
	DnLVyNookBuWJ7ym/X0Pj/zqkqtiHs3ZDaBRz4NDZMTLv2ADVCzl/yvEkfpFSkwXkCOa+XzcpOx
	jJtKCmT+ybzEMDeFbjeAwB/GKOTN1OEkFMfiq6sIwfWYYIYARS3Si+XT+egKT7FTQAmOdaU2WhL
	YtU3GZX6fc1tWb0gRFBiEuE/ppvto4wLgY6lONof7Tv/WbiH+rax7txoGIFzrshQGsuv5Gariza
	4SgpcKu9ySs7KmaIGpq2TPNO5RW4+pIfvyqnUhSThPFC/MFlWKJ8jE8i3QL2h8JaebTomXMQtmt
	ciQ
X-Received: by 2002:a05:6300:2213:b0:3c0:b766:750c with SMTP id adf61e73a8af0-3c0bcc1a69bmr6988432637.58.1783572786880;
        Wed, 08 Jul 2026 21:53:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e229:88c8:fd09:9a39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm26559252c88.0.2026.07.08.21.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:53:06 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 08 Jul 2026 21:52:59 -0700
Subject: [PATCH v2 01/11] dt-bindings: input: samsung,s3c6410-keypad:
 introduce compact binding
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-samsung-kp-v2-1-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
In-Reply-To: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 patches@opensource.cirrus.com
X-Mailer: b4 0.16-dev-b242f

The binding with a sub-node per each key is very verbose and is hard to
use with static device properties. Allow standard matrix keymap binding
in addition to the verbose one.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/samsung,s3c6410-keypad.yaml     | 53 ++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml b/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
index a53569aa0ee7..2498c62444a1 100644
--- a/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/samsung,s3c6410-keypad.yaml
@@ -37,6 +37,10 @@ properties:
 
   wakeup-source: true
 
+  keypad,num-columns: true
+  keypad,num-rows: true
+  linux,keymap: true
+
   linux,input-no-autorepeat:
     type: boolean
     description:
@@ -81,12 +85,33 @@ patternProperties:
       - keypad,row
       - linux,code
 
+dependencies:
+  linux,keymap: [ "keypad,num-columns", "keypad,num-rows" ]
+
 required:
   - compatible
   - reg
   - interrupts
-  - samsung,keypad-num-columns
-  - samsung,keypad-num-rows
+
+allOf:
+  - $ref: input.yaml#
+  - $ref: matrix-keymap.yaml#
+  - if:
+      required:
+        - linux,keymap
+    then:
+      properties:
+        samsung,keypad-num-columns: false
+        samsung,keypad-num-rows: false
+      patternProperties:
+        '^key-[0-9a-z]+$': false
+    else:
+      properties:
+        keypad,num-columns: false
+        keypad,num-rows: false
+      required:
+        - samsung,keypad-num-columns
+        - samsung,keypad-num-rows
 
 additionalProperties: false
 
@@ -94,8 +119,9 @@ examples:
   - |
     #include <dt-bindings/clock/exynos4.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/input/input.h>
 
-    keypad@100a0000 {
+    keypad1@100a0000 {
         compatible = "samsung,s5pv210-keypad";
         reg = <0x100a0000 0x100>;
         interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
@@ -119,3 +145,24 @@ examples:
             linux,code = <3>;
         };
     };
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/input/input.h>
+
+    keypad2@100a0000 {
+        compatible = "samsung,s5pv210-keypad";
+        reg = <0x100a0000 0x100>;
+        interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clock CLK_KEYIF>;
+        clock-names = "keypad";
+
+        keypad,num-rows = <2>;
+        keypad,num-columns = <8>;
+        linux,keymap = <
+          MATRIX_KEY(0, 3, 2)
+          MATRIX_KEY(0, 4, 3)
+        >;
+        linux,input-no-autorepeat;
+        wakeup-source;
+    };

-- 
2.55.0.795.g602f6c329a-goog

