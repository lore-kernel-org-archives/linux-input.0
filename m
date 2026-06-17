Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2F47DD73
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708641; cv=none; b=kQg80v+kO6wrtT2rTPtcZtsprHrSc3htWSOLsKOaBIDUvHOavINqClbUZgfu+OzSP0lLHKdqkrJWd9VU4gisFScDFQTOBpdIj1yHCxQZAsBwyD1BKDztX9BnL/gF+YuqPqFFH0TAjZN1adAO7Ijho0xya7DjmHTdkcfcfvH2wmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708641; c=relaxed/simple;
	bh=6lMpZduYpP5W+klHpWiNc9Xd2BaAFhQOHEyJIaimAgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZoYY0etR80YZibQi2oKUOjxPPWHgtelowa80nPB7sTv5nKYoBkBn+iuilCI2Jvi9yZwyZifoWVfRspgKaLYJ2C2LOVzzyUZchpwt+9eW1HFTiEuNkCrdvQXzHkDOejFQwxf4QbqkuQx7SsQduQd4JJXpcZLMSjNNqh1KbcEH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4yGU6BJ; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4yGU6BJ"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-662dc387b7aso563946d50.3
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708639; x=1782313439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo0xjM5xBhMRhmelvlu84hkHLwYRkl5tNqhsXZBc70g=;
        b=g4yGU6BJzzwlILdIhbmQVzWRven5g/rMpfra9w3jzq8D22J4AfJglXYrQAUvvgf2/c
         SrgZ2jVEAdPnzGAAhWoHks+GLxCgzcd5BbPmkm72TOOr0UszhPBUef4BFS7Q72q8EbCG
         w+/RC5Ravg5CM9q4TLSu2X2xMXYgao56KPkvlRYMYzbkR92wyg9qzyup9OUlagajWq3y
         Q/5sseOvnpmIdTzNBBFAj479NnE54e31SecFdT3+siv7pq7CPt4I3yBqxMJBazSLsM0m
         ++T1loACns0Y0UsaMQBqbof1OAoQUYhYXMylYju5T1D48lRAKjSjzoNVxff1GlVNYzhk
         JBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708639; x=1782313439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eo0xjM5xBhMRhmelvlu84hkHLwYRkl5tNqhsXZBc70g=;
        b=LzH3luyu4pRRw3H+hKjj56UYuXa1Z2uljrNBr5jq1Nbrr4zbU1F85+KvjHfLXSt8r0
         YUGKbEzp0O9KLAXlZO8tlz4tMJTVdj89L0goYw50newThilbCWNDCt1rJOzg6eRWupjY
         6x8nAQ7KW8dE3yIC/7HvtEpR6PWQE96FpzAy/C6MsdMI8MD0/ZPERfBcifhvsUZBFuU4
         0maJ3cywvEHO1i69/V4049NvVXB/G/84uRvHHMd1zQKSykp2jqqPJ3qqvKgrUb5nThVO
         mke0aXcYKl+BupQISgLvWxUqKL21yoB5dtMFcstBCn1vaL6D9uksxTI9hSiQELx5hE2m
         eYXg==
X-Forwarded-Encrypted: i=1; AFNElJ+ZvchM1RUe1DdGI8tpaemUvdTJdfCGOZys7bBB1lGhlnnvMzGYzEGLM005dob43WstUz5qMTKhPy7H7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2edBtG4uBGy5K1vmB8R4vZcrDRdeO640QPSu2+hPAXizvxKH
	Xd05TqlUnMogNkioEtH+rp3JmtJdIkU8OEMkqBXpjDaAHD0p5i7NVQ3zAba3VJy9
X-Gm-Gg: AfdE7ckRqXnl+lhXLV33aasCxZQhEt33QYDaDw1f7p70A4xNIAWLMj5lRfpOq98UWuf
	aApLmSVN64aGsA7d8tEj9J3QEp62PpxhNQ+FeRVvdJmjJM3x8kqY0yp7oIPvn2pS6AzxB9fxMRN
	2XUrp9cMYf+jhgKOGX+IHocvRGFOv+jnZ4xP62s7oaLswurPqLVva06zBffa+j7GCask2yXL/3D
	7qJ33BTAmp5Ab3NuMKJ4anX3xU5xFJo6AQT7K24OiLphqFT+RK1MU9MWCmmRVIwkEP+Lp21dHKp
	WBzjRPx+flkaKdNfaN0h4VvporjfErVSxJNBU7GNVPtFzJ7m3dEVy6At+imEgohqFhJGGoJgN0i
	hKveeQWQELb4aO9/Kb9aZXgdp3r6FkIRGKPQcUPvTFVnAeef9PV0vgVhrQ2nX1MI/UoFmWIUhTM
	fEe92Zzo56bA==
X-Received: by 2002:a53:ee92:0:b0:65e:4b06:f85d with SMTP id 956f58d0204a3-662cba6286fmr2906585d50.33.1781708639346;
        Wed, 17 Jun 2026 08:03:59 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:03:58 -0700 (PDT)
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
Subject: [PATCH v4 05/10] dt-bindings: input: microchip,cap11xx: Add reset-gpios property
Date: Wed, 17 Jun 2026 23:02:44 +0800
Message-ID: <20260617150318.753148-6-jerrysteve1101@gmail.com>
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

Add support for the optional reset-gpios property to describe
the active-high reset pin for CAP1126/CAP1188 devices.
Driving the GPIO high asserts reset and deep sleep, while driving
it low releases reset for normal operation.

Restrict this property to be available only on CAP1126 and CAP1188
chips, as other CAP11xx variants do not have a hardware reset pin.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 798035e942af..b97e5b2735f1 100644
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
@@ -157,6 +164,20 @@ patternProperties:
 
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
@@ -207,6 +228,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -228,6 +251,8 @@ examples:
                          <109>,	/* KEY_PAGEDOWN */
                          <104>;	/* KEY_PAGEUP */
 
+        reset-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.54.0

