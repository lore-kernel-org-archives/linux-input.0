Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155F47ECFE
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708628; cv=none; b=nq1mUPeSJoofL3MmZK4PuJ5bfS7VQQHVNz/SB8wWfhX4CngIWMSlU8hobH7TMQEItwneNR02I35+iSi/Nt3HO5+UlZ+b18Ry6cFeqzjnGUh6gVe57luMeEynWt94Az2LpgQpCXC22BeUz5hR2UNSpASJ8TwWM/bQuhyhr/JPH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708628; c=relaxed/simple;
	bh=ByBa3DUMMmsAqDPHY9GN8y9L8dL3v17I0RL8QNLS9zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ+6grpxmA/rqeqsurJwNd/P6xK48zEpP6ff9CgXg2Ut51Dk9HdCJg9jFz+sx6oG8E+Tmvi1rlhTAxjLPTLR/F98RveSazEbBMsNm+te/Cfsavj8mGjjq4J4D08t/HrX/usAHyKwOiFcWjarvdMJwOJiJ+f0KD643pWJxVATT+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUEY28jU; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUEY28jU"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-662bb8b1f93so1716097d50.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708626; x=1782313426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpqJy4+Omr/p2TKo1zUjalm52kTRBfgDV2CGB6DKgQk=;
        b=PUEY28jUuA78ufnOa6VcZZePvZObgRhg4SleQtNCx5LeTlq8RMvftkj6QCOxM4L3iS
         x2PXpq2fULb2oGtM5Ph5P34FD+Aph8cY12nvCRFavpBr5W+Mlp7xF3xZQRfOiGa9xQpM
         yiDl9BUx2v0/jv8nKIbpcOKRrLTChnn3CmfFjmWEZzAcjQA9cZqmLb4CIjr5OtphNSk4
         EJLlX12DvwkDB+JxXzVIx4vd1ywXdFIxe7on6XLR+X5W1K2RMoLH4+1m0gaX5+xl+pBa
         HfiDMQoAQP3sBF4eOpqRWfAZiG76C41nNSOp3pFhJg38UjIzXKDEFSPdAaapI1Y2G1An
         mc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708626; x=1782313426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QpqJy4+Omr/p2TKo1zUjalm52kTRBfgDV2CGB6DKgQk=;
        b=UvOO5NpbDHzquO0TfCU1//MyNqEz3QwbgWtdT7fxCweFBGEMJw9L+gUbGutxdJ6saF
         JyTNYWaA2qdGMOAxwdLnG4vqlnc+CYayvZJcGC3s/QfGBRqlKQ/MNaClGPvLx5NjXsxJ
         vY2x+k9Z5mnAtfbkI8Cs4PKg1i7KqhSrik7F2urwct8QPXc03upqn1Sqdw5sMyS1ha0T
         AN8OFErUC69j5hI6T7w2CdtqDK3gRTNvjaomZQ+6m4WlrT/jwtCqfCZS9Ro+OeHmdv0b
         O1FDQSlIqKMPHaRfeUFoUlQNucdtg64VRqoEGW/QA1HP8jnNFdiuPHSHckVzWK3uJEoi
         oChA==
X-Forwarded-Encrypted: i=1; AFNElJ9+qskzoiqsAIcdo4MPsBEChvDXIy9XuQpkw3q0wLi6goeHqaFqK4PcKtEk6Q5wXV3Imf+Sye8Cz0keaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgM+EzZZsmHbbaQoyF41/Q30CXHxNR1+dmKEBffl+AUdjlYOa
	YhI7xK7RuR1JkdoTSiA+/C0YJmE2i/AQ+WOTIMerpNwU6ihinVDHSws2
X-Gm-Gg: AfdE7cnCHRASmYB+UlmioWVKa+6MrJdF86GNqfoKeifzgTe64owrwSoWv17fveq7rZJ
	EZrMXX0L1iFoPj38BMazBnURaN/O0iywybF92KeWDX2Y4JWuMOTQIekqETTwmU/vFTwkWrq60JM
	n/1wSXnosPSbzL6ybLa63IwbQVRZFBaZPn6G4OnZaB/Mnur0u9hepi5iPIUjGgc0mkOgKKgfCeK
	l1I2HA3ATYUCKS+gHPls3MHa+v6hDX8DpnAgKFcGe8aZASICWFcmmDvdkXlTJtKDxN6ph3fB73N
	KYLixG1nDHYgq/Hc0xdvscyI5C7ch/ZfLTZ/N0+EzamihDp9p+3/+yf+RkcjoSSzJSpGluXGnBo
	n19oBQncunSedjDHpwwJVGqRgD+xJfnO69FAp/gp2ww2iZ/A0SrW78ufgdU7HlUKmLC4U4hJ3iW
	mx+7m1zy9HGg==
X-Received: by 2002:a05:690e:1c0d:b0:662:c2b3:8e93 with SMTP id 956f58d0204a3-662cd9f9e28mr3072886d50.60.1781708625919;
        Wed, 17 Jun 2026 08:03:45 -0700 (PDT)
Received: from arch.localdomain ([2409:8a28:a52:c491::1002])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-662b976e47csm4387677d50.20.2026.06.17.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:03:45 -0700 (PDT)
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
Subject: [PATCH v4 03/10] dt-bindings: input: microchip,cap11xx: Update datasheet URL and LED reg range
Date: Wed, 17 Jun 2026 23:02:42 +0800
Message-ID: <20260617150318.753148-4-jerrysteve1101@gmail.com>
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

- Add datasheet links for all supported CAP11xx variants.
- Update LED node regex and replace enum constraints with minimum/maximum
  for LED reg ranges in preparation for CAP1114 support.

CAP1114 has 11 LED channels. minimum/maximum constraints are easier to
maintain than long enum lists when expanding channel count later.

Drop unnecessary led unit-address pattern.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/input/microchip,cap11xx.yaml         | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 7ade03f1b32b..eabf06a1163e 100644
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
 
@@ -131,7 +140,9 @@ patternProperties:
 
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

