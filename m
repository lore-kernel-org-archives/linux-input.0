Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05A37E31E
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778411320; cv=none; b=gKSw58Xse1YWPN0XMDMyBHdYY9gGj1afAMbTiPkalBz9qJtTQC0ckfYZl0ZbBSb4sKzBc/+XKUqnc1IhH70rjtBwqlWj8t+x+AeVZU6nhO4JVrlyndv9FJ7rEDX5PvzvfAwD4ePf+LemiUM9ymQNcBaMlNCRTBBJUMOWI6/X5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778411320; c=relaxed/simple;
	bh=0gEwZwS/FYqnGRZ59VSyvYE3yvqWMDCYZCh5Jh3+mCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AncBJ5NKr22C2FdIia6jk3JSDweSIYeKZ3RUvYqxnH8gTGujxlwQoMcq1I2KWsv/Il0N7ht07zo7I6cGOP7XDmVM7um9DQziaVd7FnEKLLHJNx/mns/iz9ZiVbl+nCt6GUCMN4q4HpXuvy2b0gtPok9+u1HsIjwoY+Gon+uF4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO+irBu1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO+irBu1"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bc2a455fd55so475923666b.2
        for <linux-input@vger.kernel.org>; Sun, 10 May 2026 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778411316; x=1779016116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Ch5JjZSDRX/44ND7WHKAD/uEQw2ql3s+wN8Su8rG0=;
        b=RO+irBu1+Op4h8XLB/uOeezErvpufWhbhQfHy5rZJlMQKm6cBxFxaLi+wzVGkDDaUa
         20vdiA9Ab795fNmJAxIS5Dp/pW5NrhOwM7oi3E/yBw/PCmFh8OKSLslX/K/3/6PsgTwp
         u4TP9tsq7C3guBfhlfXBbahXQeDTv1G2VEtZT4QXUn4Qd60rt8KfrzzsXFmIiin8BoZV
         2nipEWSmt6WcN4/mv7GRHMxd5dLZcnHzz+1OpC33hli3p/6anmquhc50lkztT0biggxz
         k2zoqWW+2IMQvOtFrdsIoFHb4jKFLItvK3n0xb5N2xVX3jRdt7MTRPc+1J80Oi7+DZMf
         1ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778411316; x=1779016116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l4Ch5JjZSDRX/44ND7WHKAD/uEQw2ql3s+wN8Su8rG0=;
        b=p33q8GeBWSgB4Kdt5kfot1REQ+X/ukZJDu3BQ+K8uYaDiQOl1HXE6pnhu+WuvymzE3
         i5hDZOzP0JTx+XM4i86Vw7D1XRyLNz/cVph+8+yk06c/skoK4XliU0iArx4To9pzD64R
         NIudBhmYRCAu/8MF5pqxZ5Pi4VlepxzEkfwrljNwdMw4UDHCUxaP4tcF1vX5pHpoOC+M
         XyY0fRrJz7m+aEzIKPMhCXBXLJKinCIth/rKw8N1EtOeevgvkotwIbtccUM9RY4yVLpR
         uQZgHGl8dZ+4BUTX4X/83lio4rlJhVSutUpHPV7cwYOCKAEEfgwiWmkppZlhzpItqs/4
         DH2A==
X-Gm-Message-State: AOJu0YwTRs73YzLWPjvZ6ylf60TTr+cVIDOKY/KweCSG6fj7n42ywXut
	PkkaJzaolxE42CX6K2KyaDh8dDY9ACc7Pepk4HtkfY3t5cR3VCMVpgmQ
X-Gm-Gg: Acq92OHvWrO20GT3l1SzL5GKh+2kipFC0SQLgdnF8JakfMnEFQWJ6tdTs8Zndtwm9VM
	oUPcbABbfzGlp2/cDSHbtd4CqOqMqJ/vbOm07KcTSnmnoqQ19CxERW6uCbimhuYxs8eJ2smbkDm
	xkyUBFID0ozLt/pv7BgvRKDyc2hrzCd9CQaQWWA3HTptShWT2XqEI9ztrXbV+EyDmxOZUFcMS7B
	Lth2GOlOfFDEc+mHPlOAFPBf+AGrHtN5jbGpXOVFQ4NcnPjSPnN+bPHJV+NiP6HAjLq9ZQPBTql
	QED7vtE29axvPGqurY4nmNsNY4vesSxApjWUsvTmA+z0OqrQuhx7InPW+R72mrsMIYLYc1S8TK6
	SVhy/gNw6s97GettwhbUhXAUkQ6fz1QjCSYWCQn6UNv5+gi1RSLQyGhsbL0paZsRSkmqk1JCtnO
	FQjELQCgqre1sNx6MmGj96nsM=
X-Received: by 2002:a17:907:3d89:b0:bcb:e626:523a with SMTP id a640c23a62f3a-bcc14b9b4camr232992066b.40.1778411315731;
        Sun, 10 May 2026 04:08:35 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bce7a3fcb57sm68146866b.60.2026.05.10.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 04:08:35 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v5 4/6] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Sun, 10 May 2026 14:08:02 +0300
Message-ID: <20260510110804.33045-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260510110804.33045-1-clamor95@gmail.com>
References: <20260510110804.33045-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
variations cannot use st,6556002 fallback since they may be based on
different controllers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/motorola,cpcap.yaml       | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
index 7f257f3a1a5a..542d149d2b39 100644
--- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
+++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: motorola,cpcap
-      - const: st,6556002
+    oneOf:
+      - enum:
+          - motorola,mapphone-cpcap
+          - motorola,mot-cpcap
+
+      - items:
+          - const: motorola,cpcap
+          - const: st,6556002
 
   reg:
     maxItems: 1
-- 
2.51.0

