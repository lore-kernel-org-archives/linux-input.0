Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E53F58C9
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533301; cv=none; b=RVx/eDYJwyN4PEvLiIWw7dvz4B/4Rxdgnu/iJZq1Xgh43ScJzpAu+/8Gj9BU6Plo049+OmNELgzLK7n/MLYBQntvrRKBOTlZAAx3/4sJc613zsT/sYSpXHQ8U0kRSc5sPxgKW5monQUSnT+fIB0T0pPzY9EMEqM95nSFGemeIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533301; c=relaxed/simple;
	bh=sni3Vfc+Eo1D4ZxHj4qZfEnv6EajkjCp775AqH7GGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx0WQaveg9CQ27OojQhfmVnpyj3UP+RF7l+EcxAY8HT20Fz298iw2jJIiFtEg7DCFHnTuMXPo32zReBibt3Cw8Sf6LbrASVzb9m+Ewll0H27ztFZPbd/ws7d+8wamdzo6Hks8qi6fXt4xn8mMId41H9h+OpcxvGA6MZYugy+Drc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbtgh73h; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbtgh73h"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so2160338a91.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781533294; x=1782138094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzuJ81oGZTf4ZC4Q8t/Gu5IOv8ZAbUAnAwamVat/tXw=;
        b=Dbtgh73hqTOwLwHbbfKnZDDiezFrOgI+pCKO/TJHDLD/yXxwX3CayQAhjjutpoIS4G
         zECf1iZS7MkFGQarccQ7hKtIgGQsEW7ZqhFHKonhlfXJaoH5li1v/P8TbC2Y+8Q7ZfW0
         Jcbn9aW5iBKhjkvAjUtLcOtTw5hX3JTDJgHEZO2yQmN3muFx8+sAcbtK+tuLn1L7DZgK
         YxeceuuV7OgLD0vRdCza5L7gjpb0v1iq3FPl5FzmsxAEYe9G/Fl1KUuT056xit2N4YsU
         SVtDQ5izxLcSp7o4c2ZI5K0wBNTyS13+qOL7QJEga5JDDMZ7pOdGBJ8T/5vApn5/vgKd
         RkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533294; x=1782138094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzuJ81oGZTf4ZC4Q8t/Gu5IOv8ZAbUAnAwamVat/tXw=;
        b=LGXAdnnavOXxPdeI5Z7szYTxIF/s/At8UzZInDm8b0pmcbs2idqiYebe56DjMokOFC
         OxhEyHtyJHCh3cBnPvlXd0D3t2rXr9KVxO77pIZLx1IhIHxwXL/RthDpkgVH4XNtlTO0
         LbDa+X1RONMmEFSA5+5QHWsMu7+JF93C1/aAIkWNWni1CAN7hVV0itXcqZzsaFM2J/pi
         O6Gp8iPBFJOHm+JRA/JsC34NJ9Iw8eUZm41tiH84WW+g+Iko37Qnz07RYZ1ybYltcYBs
         Ie8h57bEciZtfL2FXhllriF6ZFl+noGtGbaL/+Z4p42mkd+1jbNZnioqOIP43C+MeIYO
         w9Iw==
X-Forwarded-Encrypted: i=1; AFNElJ/BAvwz1khHainlvZWiyFXkRsLKZSiUajCJDQ4V8pv9a7kQvd0cEi8vAlBICC2TzMJgNu0kUiYakRezLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUgNBJGPhzeheOgAIfL2VZRTub7zsKGjiSfXxklZ3pTt9IPMKY
	i1N8u3Cy69b7/eKyJsfnA5xXcp5dkAP9vcfvqIMStJHQvQVuBPa6eZko
X-Gm-Gg: Acq92OGRaoEj8/uvH4pjBFN3wI0OPJmp/n67+cRJl+yPu5VNZexV+RGfyzdJilY68XF
	eINEq01bMXYav4dZChVPUeVZNaSiVjqEReUnETjYYWUc5LLJR/FzbbnqoSljdR9l1pngsXzHOH8
	26CWY2fRnTFhZn8l9ldF5q6U8bBLPW85tP2Ax6x+8L0JpYLRWfdhzAPgDIww2PmbaPspUty9WS7
	up3x5kS0FFVTudZDbRmWPvzF+W4dz7rjrOXV/ZLljhtXfEY6jiprOVDBTXiVfQfOlIHDFHSh/fo
	9EowBO9TPiKexJYON+QrXGsBuGmAPRq/zT6liGphyfeV+GTUmqN2RpyIMECyYbrP8b3z9tO4Y9X
	DrO/CHWtFeDJbZmdvbJiUgl42T+RnuQvq1EUf9/R7sfdSuuwxttYGwRuvnIJiMZatjCI9AwTywC
	fwG0KQmxmtY4Nhh/sXByKvlbHG6nNfzFs=
X-Received: by 2002:a17:90b:48d1:b0:367:b8ad:f0e9 with SMTP id 98e67ed59e1d1-37a032e6361mr14073248a91.16.1781533293728;
        Mon, 15 Jun 2026 07:21:33 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7178233a91.2.2026.06.15.07.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:21:33 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/10] dt-bindings: input: microchip,cap11xx: Update datasheet URL and LED reg range
Date: Mon, 15 Jun 2026 22:20:29 +0800
Message-ID: <20260615142103.352163-4-jerrysteve1101@gmail.com>
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

- Add datasheet links for all supported CAP11xx variants.
- Update LED node regex and replace enum constraints with minimum/maximum
  for LED reg ranges in preparation for CAP1114 support.

CAP1114 has 11 LED channels. minimum/maximum constraints are easier to
maintain than long enum lists when expanding channel count later.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 .../bindings/input/microchip,cap11xx.yaml       | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 7ade03f1b32b..9578c7c206a2 100644
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
 
@@ -124,14 +133,16 @@ properties:
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
+        description: LED channel number
+        minimum: 0
+        maximum: 7
 
       label: true
 
@@ -158,7 +169,7 @@ allOf:
               - microchip,cap1298
     then:
       patternProperties:
-        "^led@[0-7]$": false
+        "^led@": false
 
   - if:
       properties:
-- 
2.54.0

