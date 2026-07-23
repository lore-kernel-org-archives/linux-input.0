Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5593AEF46;
	Thu, 23 Jul 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834695; cv=none; b=c8oCu5O2fTO4o8L/5HmfDNl7wo+X9VwRLRSTqErBw53RE4kgwLMREh2wCKxk9jtYyQFdLT2d222IcMh0j/Ub8Ncwpu78qnidRcRxYEjmXcLz56QAVrVV0Pn4YwvUjZGcfl7SEm29qOgEkvSTeEPA5UpfoWpryWSIvMw0YIUBcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834695; c=relaxed/simple;
	bh=oP/7/X7LVlKSo31gPcRHpIls0+Y5eEnnq2IMVb1d09A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZtIse6r20tomQ+QZyUxF4VEz4B0H+j16ZO7bFqRcPiumzs8nxmqkPW+2SWEuXc3RN4tY334J1sMTVXtI0/egThfn7R1szA+6XY+Vr6rWEmH3vs9f5vk8duVfmESjS1ACGPGyw4kA+6dGZEL22QTkzvnzM0cluDZxDOaUBEdKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cJX8wSix; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cJX8wSix"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BB82586176;
	Thu, 23 Jul 2026 21:24:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kx9-QDcAPgB7; Thu, 23 Jul 2026 21:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784834692; bh=oP/7/X7LVlKSo31gPcRHpIls0+Y5eEnnq2IMVb1d09A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cJX8wSixDcZlYpafzz1Ajks9wZevumryo+7OSeGV8H+BHiUtZrk1ioDb5lePCUcZv
	 27jaZTXPeKF4c2L+9uWympNTpInMLNT4j3HeXCey192y4EHuU1bkRU0jW7b+uEXIoc
	 quv5pX5h8lX80Z3ib5rhGuMx9E9Xnal/T3Pnh4EhbHSweX5ge9wwMrwvCh2T5RnTmv
	 rDCG3t2iGd4f8RvLLz/WKyEl6EVLimHiTsJSHgRmQ1ymc/8/uE2SXHIi7EeMLBjkzb
	 eN58TVDBLMSyZh5o9I3FrTZHq+qWrzc3aiqOGKDcBS2yHOzLtOEuqICFmnm7V1FQTf
	 qHd34NCs+xp8g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Jul 2026 00:54:06 +0530
Subject: [PATCH 4/5] dt-bindings: input/ts/zinitix: document mode 0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-zinitix-modes-v1-4-f6df7d86a878@disroot.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
In-Reply-To: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
 Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

Zinitix touchscreens support three modes, numbered 0 to 2. These modes
differ based on their event report schema.

The devicetree schema does not mention mode 0, thus does not consider it
as a valid state. Add it.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../devicetree/bindings/input/touchscreen/zinitix,bt400.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
index f1ce837b16df..9b51212ea9b9 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/zinitix,bt400.yaml
@@ -76,9 +76,9 @@ properties:
   zinitix,mode:
     description: Mode of reporting touch points. Some modes may not work
       with a particular ts firmware for unknown reasons. Available modes are
-      1 and 2. Mode 2 is the default and preferred.
+      0, 1, and 2. Mode 2 is the default and preferred.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [1, 2]
+    enum: [0, 1, 2]
 
   linux,keycodes:
     description:

-- 
2.54.0

