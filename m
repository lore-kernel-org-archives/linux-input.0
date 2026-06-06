Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEC37418A
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758361; cv=none; b=ACCXmN7LDo0VHQwzhQ+OzKUf/RI/+rKULgcuTlurpxv9jqnNk74g5qE6CC17ciZ2w0DJDfG13EPSINXFHvK4zZj9hGDKDIS4dow1Czn7uMPSb4DYBfjdtTSRQL7J9oOoS9BWI+69GbxaE79zJSRJvHbwVm2kG240d5y9/41x31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758361; c=relaxed/simple;
	bh=qk6/5zmmg9+asPKWV/NmxyRYbTZHz5EKsgeBfogyMXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPHfDkTkL41FxOJdqMwuKXRTwvF7Of81b1FDiVs7t2kMyQ4VyLI/wVZmre3TVZcgXHCQV5hoUi5+JE5RSx/Jew/GiXh5NW16Wi88RIlDd1TEjL4TdmbCmgNTbqYw31ycrVYeEUqXxaD/rWxJ0w+bmQjl4JAkV4eveYgtlC3kDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX9iU0T7; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX9iU0T7"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-13810b63a1aso2770863c88.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780758359; x=1781363159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1GndHLlQOy8H3OX3ghdSdW3rvI912309T34g52ZxgE=;
        b=NX9iU0T7q6ZRzMEB1nkQ8DJ1lHouOoKSkZj/339RK5gTlSJ7ZKOELqf2vWejuC4qdd
         6pvPJFMVMgWfLSwV8QCZmZlWF1N4mU5ZvObio+qTiCFDbv9o+Po1alYBvsrG8ck9T6xE
         qFFuT3c/MX0TcnuCgUzorFvAlFe0qdsAFpvTpHftEp69IOIvLkTxPcsapyG2NexWnqWs
         bUB6O8KGVKH4jU+DjCEBsTSHmaIafydfo1gMXI2jEgHxJHOmePQPDPR4HhDvmorms8/9
         yq0kXIFzwIHtMmjlIYx9gS6vtPK1zDFll0hBeNBk26+5OfmyAAcxnHftDF3W/4kzzpRE
         7bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758359; x=1781363159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1GndHLlQOy8H3OX3ghdSdW3rvI912309T34g52ZxgE=;
        b=Oz2avZQCjY2IRzoRxW5Jcx5dmecrJq96rrLjvSBuVHMrQ8McPYC1cvIPpxbr+wnxeV
         kkLmZf26gdRA/OlEoCoZ9DGRQrnFHbZx61PncCfp48DGy0KBZj90tDfOK7TmQ7RkndPD
         CJtpV7+7KJ2aZmQQAndLov9Iwcav3/OnouVZC8RsEOwrBJ32XRdTr/u0cg3SD79eWTDI
         TrRYO6xePzsv9CvqwLSPLqn+0/CGHx7NTAiOTddjqAqUEv3V/SI16mF/oY/1sFqjvuBo
         9b38VswRwyaZwu9tRvVBGiGvK+szhjvWAZt1batsBZuMwQFMkVcJ+RPimOQUHgEgS4kr
         zgRg==
X-Forwarded-Encrypted: i=1; AFNElJ/ewFPr/s9f1BU/RKtHJ9v9Nb4cCiH+jmwXUmmA4jd+cNXZYrsFUKwA1at3i+dUB8DgasO8+CNlAKD1PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgb7Ijdn/p6kUrK0qRBtXAL1Gu+oPuFZVoLro8Yit7PWjRSyYN
	3wAc+Q6VJtMbailsOGVfD5f7KbUWPLsh00Ra3lBU+oIhlmCLsDq4G3BY
X-Gm-Gg: Acq92OFjzgCUO5ladxm7LYX5vzxwEc59Ey2vaeqvQNv7yYrrd7hvUw0YaVLL2Qa4E4K
	DhH0NGBenRsmgx0cr+oY12xORWPS1QTtQNDIehO4ZULMaiOUcjy9ePKMR4fv1N1HyzOOCXhWmPd
	/ZpuXGK6cIC4qGNRZ/hOxRYT0gzzFYxPGAChbbkevQbBre0UuTyO1yfKa/Z1dH/daIxsqRao+tH
	/oNzYgBD3fmuN9O7mJVi1pvtxr7GR0pBlN1SCbfD5Fk4l/Emv4FbMKLf6UyOxJOQ3vmAXLV7JJC
	dGXpqYWRYc2JvsAJFTYveTC87882Xv5IYW37V9Ngi+1kM+3VVEfsLFg3xIarJttyEUs0rXerUs5
	ZHbVMMKxHnMr5Sq5+LzmnaCdLndKN9uwYmZ1aB1wewmLvZUgvBj7iIE29Da6XaR9IbQ8Dfe5TyJ
	IZvIm6RI9k+aJ5WjlkSyaacBL5PUmr1HTjC1QjdjmFqPRx1qsvoQ==
X-Received: by 2002:a05:7022:4199:b0:135:3025:be5c with SMTP id a92af1059eb24-1380671673emr4238397c88.27.1780758359342;
        Sat, 06 Jun 2026 08:05:59 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm8415607c88.11.2026.06.06.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:05:58 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] dt-bindings: input: microchip,cap11xx: Add reset-gpios property
Date: Sat,  6 Jun 2026 23:03:57 +0800
Message-ID: <20260606150458.250606-5-jerrysteve1101@gmail.com>
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

Add support for the optional reset-gpios property to describe
the active-high reset pin for CAP1126/CAP1188 devices.
Driving the GPIO high asserts reset and deep sleep, while driving
it low releases reset for normal operation.

Restrict this property to be available only on CAP1126 and CAP1188
chips, as other CAP11xx variants do not have a hardware reset pin.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 99d00f572a2d..e307628350c2 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -49,6 +49,13 @@ properties:
       device's ALERT#/CM_IRQ# pin is connected to.
       The device only has one interrupt source.
 
+  reset-gpios:
+    description: |
+      GPIO connected to the active-high RESET pin of the chip;
+      driving it high asserts reset and deep sleep, while driving
+      it low releases reset for normal operation.
+    maxItems: 1
+
   autorepeat:
     description: |
       Enables the Linux input system's autorepeat feature on the input device.
@@ -151,6 +158,20 @@ patternProperties:
 
 allOf:
   - $ref: input.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1106
+              - microchip,cap1203
+              - microchip,cap1206
+              - microchip,cap1293
+              - microchip,cap1298
+    then:
+      properties:
+        reset-gpios: false
+
   - if:
       properties:
         compatible:
@@ -225,6 +246,8 @@ examples:
                          <109>,	/* KEY_PAGEDOWN */
                          <104>;	/* KEY_PAGEUP */
 
+        reset-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.54.0

