Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761D37DE8D;
	Fri, 21 Aug 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347845; cv=none; b=JaqPNY4ohV5xfng6ySMGke0dU0cs39usbYinvn+6MsZ2dLjqz0ABY62DI00klLtCutNPPfdWwzCs/fPTLu27GY14AimC6ONAUjPDfYJA/4nSja+32Wdr2Kk5KT7q3fw6daihLBvthP+b93JHwxxACXtBi4pyr98S6JlmN0FyCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347845; c=relaxed/simple;
	bh=D2WiEeFJgdwBgx9vAcBPOVfTaJ4IumBKUU8pUzV5LT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+UJoehQTy2JsWAZytvXF92XxH3x9TI+9ebd5wGjFbzws6QeeiKLk1ecoCeAbBzfr9Xg+TvO20aJ7AmZ/kwqcRVBIuPNvMBrXd2W1fYXzQC+bOIM9Qj8pXOyhiOTIvQagY7Yvi9360bq34zuO0jwupVL4cjUSuzXPEf40CJ6ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUP3X90D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUP3X90D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E53CEC19425;
	Fri, 21 Aug 2026 21:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787347845;
	bh=D2WiEeFJgdwBgx9vAcBPOVfTaJ4IumBKUU8pUzV5LT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OUP3X90Dg1/npWVr/jTdZ5XOU0JYkizsr/xbG62FiAORr2+/2kxVr36dj4vQpVMjj
	 72QolOpgIaPqgr4uXR4HyW00Z1FNboCwg/LMaM1DO+RZIvpmQBwI2Yn0MjKrc3aASU
	 QIUqyANvJzXekurQr0sMUgNulgsKzGu9TiAZEWg87fWJAFqRrZcXB0/tg/3nD3F8zF
	 7XL/H8JzAQ2vR9ise/ESY8Pc05Sa4xYO3c/sGFuUCmDLujw+eL8kq55QIXyQgM75Fy
	 6Uk5bieZaIwWG5uz03HcheCBPxzLfrooffV6+gQyHKixo98DGVfso2DxfnSZ6TGlze
	 z24VAG5AKrcIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52FDC5DF8C;
	Fri, 21 Aug 2026 21:30:44 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Sat, 22 Aug 2026 00:30:13 +0300
Subject: [PATCH 1/5] dt-bindings: input: touchscreen: imagis: add
 compatible for IST4050
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-imagis-40xx-v1-1-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
In-Reply-To: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787347843; l=1341;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=ahOo7S90s3tZfiW1uCTczaPqe2x3GvRSghoncYd1BfU=;
 b=vij2L/ojde48sCdrTdTqRx9Vk5WGLeJURfP5sA9sTzQU9NVGMgvd4KKIYi24vqjcwuXf3bRHr
 ZawcK2b2VMlB9AkTk/VqlAkWfnGQqgDJ9CSz7rRHYf4eUv8RRpac0As
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

The IST4050 is a touchscreen IC of the Imagis IST40xx family. It shares
the register interface with IST3038C, but uses a different, event-based
touch reporting format and does not have touch keys.

The binding no longer covers only the IST30XXC family, so generalize its
title as well.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
index dfaffbc398d3..a4f3e2f0cf45 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Imagis IST30XXC family touchscreen controller
+title: Imagis touchscreen controller
 
 maintainers:
   - Markuss Broks <markuss.broks@gmail.com>
@@ -20,6 +20,7 @@ properties:
       - imagis,ist3038b
       - imagis,ist3038c
       - imagis,ist3038h
+      - imagis,ist4050
 
   reg:
     maxItems: 1

-- 
2.55.0


