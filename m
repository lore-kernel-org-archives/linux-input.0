Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C33FC5B5
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533312; cv=none; b=pXk7yhxUG4bP4DTl3RM9w/KmZK+0a3v6H4ZLJ10E3u+CMVPowJKFv/dfBOU3qK5yoedjS0lnKe9yp64kWzpdsOpNJPakf015AVteQkUtTOtdKWQi3vB9pyfSKma/ctdRy1z78DlvC9rlvzBpIMHM65l+LyNe/FHuucRZoN9YLMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533312; c=relaxed/simple;
	bh=nZi0t8cL78YZmxGZD62T2lYOUTFA1HtfINqkrnLD3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ia9STzFm0fOkyXo0ZTrl9IMmd7J9eJgKKvkyl1GVVbYRtijWB33L1VxQUZhiDgcZZKq2kM37lXpWpe8Yni9i3SVBFk7t6o7nHnEiQKX/NB8sGwqwRdq64XXW46ceUeDc2nBG7maNpJ7U+UlS4c/DdlDPwMk/JBs5J0UAZy8Sfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNuDFRTG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNuDFRTG"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso2180351a91.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533303; x=1782138103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLDZVGka1eJnSriA7FyE8scCoa7JYxvPjm4AqcyjUc8=;
        b=QNuDFRTGnFwFB4/zl8I8wenQ3kxA5c2GdweuGWfcJrz6/9dMgSunSaFnQwXH3ZzH98
         tFnxJjyDjKz8g4BjRpMknnmz7VnLrxIGQzn3cKcvu4vOffJ/TYAw4mX6dI+d1iu3a/dD
         N9YBPWikmELPkyhKO5xvRHXxaBtJBknbMck+OoXV0JM30nPEtZIXUTG6NA3KHldhJimj
         rPG+l/kcGoqStcfhvQe4D1cMixRhsZxgXi+VS4u6DFP/bYmngzHuUC4BYNAgHJDln79N
         6sEuaOPU0rKZYnGqlLtew0NnExPSwnZv+Is2yiE2dSwIVEm6VaHXAiWjNCYa5Rox4/0a
         dcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533303; x=1782138103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLDZVGka1eJnSriA7FyE8scCoa7JYxvPjm4AqcyjUc8=;
        b=PvFi0x7Jf9TK9+0pkTBEJIm5tKLiSSnUux4A9hOJ/nCWBm8qn6hy8Q1Tf9K5pN+pQp
         3VntPHbH1DCFHmhU0qGc4LQN1naIIYj6boLaSRsn3kQFMnImZdTjBli8noq0xu0e0nBx
         dQX9MCOHLdWklhnd0bxSfH0DmWY4KVuACO6noG6NuwxZlIHI53cDL8nOHFdhmunNNPkM
         hap/VqVUfgGeg3dD7Gtao4WRVlDObxTb0DE4bxC3X2+l2SZ7AIzHGVC+fzud+YO3P5fE
         GCrgjJN+HraA+oeVoNiXsHb5npfHbHngD6CF1lxcomFo3GL/G+YDhmbbXd0hDoXEIL/U
         mnJQ==
X-Forwarded-Encrypted: i=1; AFNElJ97ynSaKtm2MdCJnohBn53y0Ly/MBuoe1arQbUyP9tPt2TewC/I5E3H5D6Isb6y3kMrAyUb9jfnjqfV4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13m8QARtNpaE+2YRnsxdGzH/ICJs78B58mvldEEvREOf+0Xri
	05UzrAAnAvuZUnj2EcDDWi0tMXUwmweg8AdmmkfWe5Mq8ccC7LKE1+0f
X-Gm-Gg: Acq92OHHwvD4CWesxad0OQSgt5WJOSlhxDD6YyA/Z7VkkOWPYRfo2GDraIo/WJezecV
	iW4G8kL+PUS6o/ZnAysC+BF32DyKsMgsqPmdOgZWXIoXckjvuqwwncowx31AdEWrEGHX5LmCHps
	wvt5oN9IEcxyYgJIAoZEjohhkp6kIdbesPEQsEPJJKaqVmd6N25q3O2LfEnB9UuFKx0msnNv4EG
	KdCM8R4JqLcAjpaztayt94/6fgF53PnVhjnSSgymxZeTEeZKKgXLXAAjy5A02MuDakBqwxq2INn
	Ele67B1xU6yeGd1kzXf2+Q+sAmeE26gKJx7W9deZ4Qc1tzVw8xBPUnPP95nUUjeolRCEwfzd+Qq
	a1i28XvBgbEDC39e1h+ZNfqB3xQRcjhUgN0nAQlCnejpBuhr9nRKj4EcsUj8eK7cHTrsvjy8ZPC
	pKzft6b7rGWIszSpxtzs5G
X-Received: by 2002:a17:90b:5624:b0:36b:ad81:c134 with SMTP id 98e67ed59e1d1-37a01f335a8mr14948582a91.10.1781533303389;
        Mon, 15 Jun 2026 07:21:43 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:43 -0700 (PDT)
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
Subject: [PATCH v3 05/10] dt-bindings: input: microchip,cap11xx: Add reset-gpios property
Date: Mon, 15 Jun 2026 22:20:31 +0800
Message-ID: <20260615142103.352163-6-jerrysteve1101@gmail.com>
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
index 22a292d4a880..778ec6d659a8 100644
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

