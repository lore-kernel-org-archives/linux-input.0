Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F243DB318
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249016; cv=none; b=ugewXCEnSXVh7LolxVBnGsxIRActnVNRmHmoU3wEV5y79IbGHvi4P9hv4DcxJY7brqvdPbtpJnNhk4onBhWvoDXe4FchOXRQu0D8lON3Z7N4s3Iqguo/mTvMS/mnddhRCtXQ/S34bxYdOAq56s9CpE9U0lTYolLxJFtKLDPyyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249016; c=relaxed/simple;
	bh=sni3Vfc+Eo1D4ZxHj4qZfEnv6EajkjCp775AqH7GGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNdSuUlcwIKvJ6iukeJOAfrsggTokCUuTFwSF1pJmZTjPeKPnAifyysH45XYWQnT4zRACxRmPcIBm4kGXIUCQHZxwFE9XuKIB539QxzEgAufLJF6fKMFLVs9MFcpCxQCjJ48syrsRcY8FQTO5F6i6Lah4EeqxFLXiKk4rIlMRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEXFC43Z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEXFC43Z"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso12981515e9.0
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249013; x=1781853813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzuJ81oGZTf4ZC4Q8t/Gu5IOv8ZAbUAnAwamVat/tXw=;
        b=NEXFC43Z/YFyD0gHFlYKPAd7/kor1ZTcOg7uYMzrijBj4SnWDFG71dvUO0+GALLiRR
         OptZxt/JNkscCieqoQooYL9owsrkoShOQ6Ik/ZsvNDZz/de2sFUHRKtMTnCzY9ez6ghq
         p9HywbVY7J8y6V/IAJN5ZaMsCrrXEERMPGL7f/edjViBabnhyHx4VovZWjJ07f515uEb
         T+V45XdotmKoFjIeoMRSTzI+85CxYpz6UDsbPcy34MQ294QJxLplfFqfkskfg9FzycAE
         zJubAEfCTA50q9efLsCef8NbNcohPvevoo/XysSy2fa6AlcBqcwh9gYqoYX8ho/4lCGL
         lIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249013; x=1781853813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzuJ81oGZTf4ZC4Q8t/Gu5IOv8ZAbUAnAwamVat/tXw=;
        b=I6O7n7o7fYh/DBkbEqNgsLAWnWXUWyAvu99/QkPAmek5U9SxckII1al8yQEUIleBpv
         Ky5W8QDkQRMcWz8yeVIR2mb/bekTgDWCx8bZsQdL7SGsyQXb+w9+TOcHJ+ZGGfUqg7Yw
         FGmQnU/z92Iaf+yvjcRGv/z5kRtnuGb0eYHfbB94r28VFZDFT937clETm8EBmXIp78W3
         /JcUBaR7ND8JJ9V+WH4BfXENIucN1vFofe7XburADxf7wZebtMxc2BXySHFCBBMSaFqi
         CJBY4ihQB1IajCasSalAgTj6k9Cuns453WuyXULx9jXtVkHpvYktBsnQUvm3soKVu4Ig
         1QzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gyDrUKu0CbikWXxy5jxXJo1F5vnsHOXB1gWcExsN+tSYvCtJhRxEBQODOZNu74V9f97vjOSP26O5+aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0M0nD2hgWtwg22tvGgeprYvDvE0icHWUnm/vYGob2mjtTSVP
	u47FBKvnLKeYyiIuCtP9mesGMOwBjY70Mq7SblLqSnpbhnY7GDpHZzrP
X-Gm-Gg: Acq92OFBFCThsxc3ta+/bvz6Nj1rmiS0cNR4sad5RM7FjhHKPmKHT8KCew+3zl0ATX4
	4TYZN5A7wSGWhtqFyX21Zd5EjAQG9MdAPbpmNlQwXv2SLW7qHcy+54hzNerijRQ44KtMXuXOqOI
	YHFNZ9AdELybtdC3toXf0XbPZHQFmvF/Wc2hAQIOnv5/xwD0XjBNXv2kMPnVm3LQOj8W/UqD5tf
	7oDVFvZYIFpwb7AyHFpa/mc34qyLCcPzuLyJOieIP18ZGR2OwOpLA4Idep7LMZyyztHaZ7kC4a8
	Ds7zyz8K1pM5umzQ33p9Kb1bXHhe7kpO4vDSt7k+5WbMA2ev+Deq2huM5RlfzzotHYwmoWqkaZ3
	I1WNjKlmKY/+a5dS07BDTCix7xf2zkSwrPInkpKSctCICfGOLsRwbdcOisuy3lsl5Aal6P87mNd
	3Y/E5wGgGq2s5t87QDGDaI2cQjMFluUTwtCwE+TTo=
X-Received: by 2002:a05:600d:8446:20b0:490:c1cb:48f4 with SMTP id 5b1f17b1804b1-490ec4d77afmr8812475e9.12.1781249012588;
        Fri, 12 Jun 2026 00:23:32 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a54:e741:3a5a:3245:d3dc:4b5d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea963cf8sm28715245e9.2.2026.06.12.00.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:23:32 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] dt-bindings: input: microchip,cap11xx: Update datasheet URL and LED reg range
Date: Fri, 12 Jun 2026 15:22:09 +0800
Message-ID: <20260612072237.1177304-4-jerrysteve1101@gmail.com>
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

