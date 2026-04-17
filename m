Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111A33F8C5
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409898; cv=none; b=iecasDkE5QklxbofXsK23XAVRQ6FPbS5IO7xkvOvq7BliiOArCRcYhCpoCazMjFe60lKvsV9wPNmsl6S4nZ+m5Pe6IcXYFJHg80lHSMp+gFbZAxMukVByDkIuLKP7mOMcpsTKne3nPkFP4mM22lKL2x8qYMYqJzufwGCDy219Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409898; c=relaxed/simple;
	bh=gqngTd4MHiV3D5QcORWGXlDKp1XsVNvEDILzzthOEwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbpKB7dMA/qfUBp/U4MGkEAQgdlx1j8l5wzm/OWLFAhdjD/oOtljgHF7wTUBVzENK1/jMdRL1ToCrsHrjzOB2aydtndsvRnzQoFDXeiHWzOMY2pg0T1Ni/AVsAhfEA7nbBDUijQjgw4YtUEMLjW6lMdQHSyPQ2xDLfC33bjwi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=espvJQ4K; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="espvJQ4K"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e9653b580so3412811fa.2
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776409895; x=1777014695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UojtAg/yVrt1TCj/dA87iY3tTJuq7q4q7W75tUN9wMM=;
        b=espvJQ4Kr93ZaOeYve87ZnHLkMpny3NDSKe3/XpPswLdx2sjrB0KfQA617qUf+gpdG
         M/bifbRRv9vM6UdSWCbz2xiA1GA78SHrOULXJNnCodBnzbA7FyqrjT22jaEoXUBPAmsl
         2Jvto/3eIK8jQPXrEIEuyjS50jWU9U73gnDm0J1nQBapfgZCf6u3LUeUPRw1irqSgLkL
         3kBhg9Ss0PkR4nSUJBEIqVEuA/VuitJBCjZLsHh/Ez/QReKyDc83MVtWnFuKNMwQkfNG
         CQ04PIx5LRTOaQvrAwF12Srx5R0MkbBfUT2f8eujKoVJ6DfC9hZGvfrvh64ZP8iG5Q06
         X42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776409895; x=1777014695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UojtAg/yVrt1TCj/dA87iY3tTJuq7q4q7W75tUN9wMM=;
        b=RB3X5ADRSVQJo7e6PhgfpLiXE2hNVfs+uVXvJyl7SxnkvmUrpmsO8csfqdMpCVNINC
         fOynQWQ3f53Na0JEGjG7txsSyFON0P0jCyECgDGuOwadYRVtW7pqzPKXAS/3YtxkYXVc
         CrsYYi9NusxooOWp22mCyyq+xJ6FSCGIpSKU7+6EtkialO/fd5rQSxC1yEr1IxKGrpU3
         I4DXpIeLI1JTHy0Kpo1m2hkFhhjPmD1rawVhMbC5Vcb22NW3esTZL9/hK0M78VALhwt7
         Bno4s+Mxms3Pil4sJx1br5wXOjwcIxJK5Kqp+BzZ8z9LhmwsUhZkIo3nc34S09zbwuTI
         I+8w==
X-Gm-Message-State: AOJu0YwynuakL/Oh7Dk1h2gHAxAc7dLY3MzPCBAf8WHFmllL81fixKRE
	qfzFo9Fb88gWHmm3/KShH5UCHH62pPp3W4FTDbp4x4afYVkaQ74jTkNg
X-Gm-Gg: AeBDieu0KP5ylwLzoip1wyjAojs3tU2b/kMBe/zJDs4D37i73SiHJqnxBRb2P5kxThS
	6pzUOc0JXEhDJahfSX2MEJbV6axvmNBOOaVoCF6YelVzHM/i1ewsXAShVV837AhtySdwLuzah7f
	clY48G/sgv5xlkKb8bo4a1ibeOSv4DCZNUY+F8EqmU5tgp7FAXEUWUW6qde4zzz4MVgGKSRYdFq
	6fiTSI2CmGLLfrecJQxDcX8blfInOa8l3+uAPvNBZIwAg9n5loUr1MKAKhPGx88k01FN+IsiXiD
	IHoLU8FWfPHHTaPH7BPmH9oVkf4kcoT9SHOHb7YU4+N0FOzRNE+GqSwmCC/nV3GKLBut4vsSQGD
	PpuTBGUfb07+12mSI6C4/8eTqP+PrMIXrE0yzCwPNNOBcvnySbbF9mZE+PQoJpeHW6JsVMLr0jZ
	I2KYZeG4fzw2G4Sn6Ls5Y7jgQ=
X-Received: by 2002:a05:6512:3196:b0:5a4:56:aa88 with SMTP id 2adb3069b0e04-5a4172e7bd3mr495747e87.27.1776409895107;
        Fri, 17 Apr 2026 00:11:35 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc240sm162772e87.23.2026.04.17.00.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 00:11:34 -0700 (PDT)
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
Subject: [PATCH v4 4/6] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Fri, 17 Apr 2026 10:11:04 +0300
Message-ID: <20260417071106.21984-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417071106.21984-1-clamor95@gmail.com>
References: <20260417071106.21984-1-clamor95@gmail.com>
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
index eea5b2efa80c..487e5456864b 100644
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

