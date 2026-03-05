Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32722EC0B4
	for <linux-input@vger.kernel.org>; Thu,  5 Mar 2026 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710575; cv=none; b=PabyARhAnw8aB3LxxmNhBpG/XV6nBwB6JXld23DSfoKrLbJbIb9EzIZ/bqsdUlPVWNxfoStrgQjhWCE44mG/7angRng/JRen5Sf3Xo/YBHFnJR9MXRSb6hAG1GLKY+Cic3pZqHMPMt0i8WY/07zodLyhBVtTOf9MjnsVWdZ/Wis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710575; c=relaxed/simple;
	bh=XK0nFFbH4MiZSG9fcS0a36y+AVa1RacKkH9tV8iO6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HamZEpIAubDy3Su0PLkrno3QRyYaBF3rkUgFcTcFf6tbpcLVr+4bGca1myCEVQX8LFFUDpwKumbVqy1LdlZ89QflT8VWXWtV1I7RxawqIp6BQ3RDLjrbpLCxwxXAA24L7bYvVb9lo1P6QeKBP2Jj7Kw2/7UnzDs05XCwERqL6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6wH4MLk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6wH4MLk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso19797705ad.3
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 03:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772710573; x=1773315373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPpOKLGSNmmq39HFqiUGhDOWmdkSAdiRJ6UaDmbkiH0=;
        b=V6wH4MLkt4xWUBGWqX/1ieEIBgl0z8wwJLoP426+M4D/avg7VDd7u+C8mPzg9+2H09
         u0jo+GbDfSHSsXYRT7kL4nTrfUcNxXJavdBjR7d6fRLnyzkojlpzQBtzlNoGPGtzCkX9
         4HEaAJGLgtQJOZi3OYgn7MfLH33YTtqXFMic+vAKV7qvj7OQQXCpEvU0hjanRLArOFxd
         xpe9/QiT53ZaVJyxCjDxpQdJVB6i7a/zSgc69ben0qpWHhXUFVceWdmosUb4L0fnzOPB
         zlkBgnZ19iM8R/nLU5iX5LwTmtJKccnIYGfFvtyqa91x0kNn7g+aNYgTgYlOgMODAVZp
         IcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710573; x=1773315373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DPpOKLGSNmmq39HFqiUGhDOWmdkSAdiRJ6UaDmbkiH0=;
        b=BwZG8F2E4UMhvFEVYlN09X9m3S3v2N6I2fhQo6SSz4Vyn1R+S4wT6fKEUWHrWTPdx+
         QDq8Og/ly8gTUY9cKayQa4ONECmbh0OCo1tVCAzJswby5TD56i7FlXqXBQtwP2RXm0kE
         qUOo2JHQHQF1A2LfCb+crY9E0rR/NKHLVsk8kvQiRjuxVK4SCeYHsYiYQiuMQgBWme/T
         /4/G+vgVUsxN+sTRE8sC7ep+sEI1PkpMJ4Kt/dDLJkv3GnOL62s1nZxRWCah2g1uKXhF
         GkGSiGgshzFApF9uWt+Cz3xSOYnnEPMDX7VN4osnpscFXP8Wb4IjTCTzDySTN43GWdJb
         MvQw==
X-Forwarded-Encrypted: i=1; AJvYcCXzWD5AHzE/xI87vg+OqBzTgPOHgcGRVBrlb8urNNlEfTwgiETm5X8hS4O+2zZA8FaHa7vKElGS6GV3cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhAyXFUCZXAkuSwDtrXDgCvGt0IC+ceLosZdkSX57nDpe52Z8c
	JLlWH6KhYZsarEKrneps0OCrIsbKubzfXyP6WX2+jNTRceDJahW1agE3
X-Gm-Gg: ATEYQzzIgAP3GR+LKSsCYSueLeOVQXj4zeZzJsMJteQQtKgN8mRIwyjzS/pGdOrVEKt
	z8grQ5As7tkQrdPNgscF9tmfwdPl2ncnrZEtycUofwFuQgpLsTvn5MOIPq2Wsmwq7vgDM+Ags4V
	fM4bioMnigctIrcfORneGaF27dWLF716a6Ou5sYX8sk8HXBjBq6KBIGvIPmVpd3UC323NsbPV1C
	mch+ASerILN95DVntMxNHblKMjekbX+eqURHkJNzswI5if0QlJep7CIH/69A7q7ULN4v+u6t225
	n1wkU6XmJG5fPyjxBiHQ1s0Wh1fKarfzuHuxJX2iFP1t9SKRYHQC6tm8m4c0ngZ0EiMAA6r5lp5
	k338y0+OrL4hh2I4mREfYGAjnrNlYTdM4DwL2qD7q6aoq3YdCx9XHr428J8u3I+LzGMUveJEjJT
	VwYnWy2vQ4ASQ8jPsHSF77y3nV80R/JflwjGLQAs9Kbb8yUoUdABkCe72frgxg4kTdFSFT
X-Received: by 2002:a17:902:d583:b0:2a7:62d6:d049 with SMTP id d9443c01a7336-2ae6aa04ce1mr59119905ad.8.1772710573331;
        Thu, 05 Mar 2026 03:36:13 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5e1699c9sm78796995ad.10.2026.03.05.03.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:36:12 -0800 (PST)
From: phucduc.bui@gmail.com
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: javier.carrasco@wolfvision.net,
	hechtb@gmail.com,
	wsa+renesas@sang-engineering.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phucduc.bui@gmail.com
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
Date: Thu,  5 Mar 2026 18:35:11 +0700
Message-ID: <20260305113512.227269-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305113512.227269-1-phucduc.bui@gmail.com>
References: <20260305113512.227269-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Document the 'wakeup-source' property for Sitronix ST1232 touchscreen
controllers to allow the device to wake the system from suspend.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 .../bindings/input/touchscreen/sitronix,st1232.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 978afaa4fcef..672544e5a26e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -32,6 +32,10 @@ properties:
     description: A phandle to the reset GPIO
     maxItems: 1
 
+  wakeup-source:
+    description: Device can be used as a wakeup source.
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -51,6 +55,7 @@ examples:
                     reg = <0x55>;
                     interrupts = <2 0>;
                     gpios = <&gpio1 166 0>;
+                    wakeup-source;
 
                     touch-overlay {
                             segment-0 {
-- 
2.43.0

