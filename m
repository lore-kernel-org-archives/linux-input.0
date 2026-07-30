Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F63A3E8B;
	Thu, 30 Jul 2026 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440973; cv=none; b=MKlnOiJAG5QVAp7yJWzcMfDfE5I0mxeU4ocPD+sMhq1kP5RDNfwjIiDe0YiMQlyQumpg7uniYClZRd9j75hqZbXjSCxa1OJqDPfX+g0ah8QORESgTU5DoCdWJo/fTpU8Q5cMNwcOED68cFBWZNK8rZZo3NmtPoLwJ+V3l3grBwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440973; c=relaxed/simple;
	bh=oP/7/X7LVlKSo31gPcRHpIls0+Y5eEnnq2IMVb1d09A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iM4ZX72R4p72pjNqwOQcPYNnzac4osOdQqvPTYxuYSiC02O5YeKyMgzb/oVZkXrNuxkLQpUx79dkWtzexE2ZKFeH3wetMIY4eyewt3RBj4OoYuMVOFCyQEhXscf+V8M2I/+0JdVg11tH2XC0JHAe1w1vxV9M0ywM9QDk+DHY8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Sl32IOQS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Sl32IOQS"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0EA0041C2A;
	Thu, 30 Jul 2026 21:49:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNCcvnCjca7V; Thu, 30 Jul 2026 21:49:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785440958; bh=oP/7/X7LVlKSo31gPcRHpIls0+Y5eEnnq2IMVb1d09A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Sl32IOQSC/xf6N1g6abR1McJhAS/b2Apha3UnUcWE6b6sRDBCt3bonIbT/9vLSZHW
	 b9njLQFBlRjgXggegm/XOSB21mxda8DC+PJosT/9ZUUMrbf96KoKKTqDxsMeVxQbU4
	 wlILa+jQY2kd9SihS/km07euRpUa33HRSI0dr7vZqzkst/RlBh01T7mSG+58ceK4dR
	 m97ni6SI/ujQVLaZCNyKaFOR6eolwa2EfHjTe+3QbHVe3vkraE7rUzes39ZZ3WOAaM
	 wJxFn6HrNRjzZvGxEMGaHL1b4ZTqCtOrsnL0gn+lrzvUfGg2YIPwikLEHZ6aOFFxK2
	 ZY7bx+KIm9kbw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:18:24 +0530
Subject: [PATCH v2 4/5] dt-bindings: input/ts/zinitix: document mode 0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-zinitix-modes-v2-4-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
In-Reply-To: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
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

