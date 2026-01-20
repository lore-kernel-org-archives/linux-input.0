Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE24418C5
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937782; cv=none; b=uRuiXocqAeXIdujotgClAoPxQ1RbIElhfWn2RuOABRkK6oIUuaMkrgDTCfj1e6Xd5yhzp8hkGKhb5zUXK//naFucblhLTI/UfOu8WjVq/L0nVEaRYG/95FT4z3mZMzsGoUAKyFjiAGfWzz6aKgy8ypOa7eq7Szm9hKeBI9AXazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937782; c=relaxed/simple;
	bh=GZnPKOTa1HqnzuYZeMPLeyCydNQCmNfziboE4iAektc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPuOh2dv0KJl5rdbSHajYEXDI/ErQWCieiNIWB9ZXDQSoS7m9Wburpe43YpNVqPUPlbDqsjYBUL7UU8MYZM8ocAPTO45vCo8iR0iGXy+D5YHf6wCNmmAlIsY8YFfnxAaBelC7DnWnuFnXlmnNouxLmI0a5DZ2wlJOo7/EtFAL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQSENjA+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQSENjA+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee974e230so46053885e9.2
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 11:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768937779; x=1769542579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOzxOEsKJTSa9ITustjB7WD7pn8Z4/rVt4c+7xkqZK8=;
        b=GQSENjA+ZUH5tlixi87eivg6cWm1atHKswGmEn41QDA0iweVGuN8xM1Z8TAY0ZFTNf
         3AHLN+4l/fgRVC5uT7npxKsQY+O11MFhVi4/CBuXheJO8c8AWdmfT4n4fSqGdERKQVOZ
         T83Su9zQ6jZYcpYV0dnGVjkhl+CC3cpgtvPFpp449lKzL93zm/w52DvvFbPD7ZA0U12K
         wjKvx0d3KNlNlNHJW7Vs/wtGwPAcZ56qtnfwJCp5de6U2SDho6XHKSNrGP3nTr5Y77tp
         PBAaW1DKg+yymy3dhjFfPzQKtnbUjp2E3qlGNz3pjJciUWxZ8FdDSKZnpk/4hZLsbrlx
         65Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768937779; x=1769542579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOzxOEsKJTSa9ITustjB7WD7pn8Z4/rVt4c+7xkqZK8=;
        b=NthS+K+BqL3bWx9gPPSvwugvvbG/JMiNyDWgw3bniMI2kiYq2mHTiJt1ZS9RhcVGJj
         WkXMArSt7pVFH5pw+v6IoEkEQ3OV8MTP7DBfMNPwe+oPFOiHlaQoXbOxVlw37oW3pjkJ
         xRY+a4t5YQiu8iI5m+/uZOMpijBkbATOiWyD6DSV1Epoj0Vfe1VX/DZo3EUJfv0xpava
         HnMa5SeayOoCj6W28/GrS5yyHk9LZEZ/C497iLYFdCBLgTryIYNPIALSP9i1bKGZcaeP
         QdYg4Jqj6jqMiqPFdN/2saFseTzSrgNlfwbThAemp/UBxZmRUl0PYOeImEU/i4T+ohZm
         +dYA==
X-Forwarded-Encrypted: i=1; AJvYcCW/nhTi64ffNESQXNYMFzZkWg8U35EuBgOoZaJZ4WrHe4o9zoX3VK0CtF8J/6WDhMmc4+sLYSgArP0T6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCKkKCf0GXylpzBa2/AP5somgMvsQLDqsQmXZSZiu1aIcViA0
	WzL3XZSw2YF2PeSr4gaoFALL9RUJdtnut7p281DrrkYbFLEShY1NSmfS
X-Gm-Gg: AY/fxX7V/K20Gq2gatyTp4hBdToFhlInAuEFzznA0ddk0EtFdWbAeq4zbQR6BUk3I9j
	/FhZNPUZ3b3zMioyODYm5pOme0TdZ8UOQr8ekTXLCjTPmueq2mdusF88GGxHzdueDmWjqs+nbbk
	gdQB2Mpt61ONAV7Ev87L8nzOm7QOJNE2DktDVu+P/mjk8emmFvLpwU7Tmiagc7F9d4VHGUlpxh9
	d5ylJ8FiLv33VYAjbxADoADWmioxreElRLC65D0V+WybeUbjiEVmjnRsGzSlL5qoyUkgHA4ymNd
	+/DJmf880uaQbcxxWbsAq0o1gKTbojvW6Ao0ER2ue73gYyYwDd/AOPUxm8tqcYy/bbHNd5vB3+k
	oTDjQPOvzF2vRaHkj06KR38cso+Re7Ox4twwTqePcmZiDW4DMleT12U6ixQy+xdxpPM52gZC7Uk
	h76PZUJFXn0e7HT8Qd723g
X-Received: by 2002:a05:600c:3e0d:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4803e803c1amr46907605e9.36.1768937778769;
        Tue, 20 Jan 2026 11:36:18 -0800 (PST)
Received: from unknown.zextras.com ([78.208.157.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4801e8795f1sm265081185e9.6.2026.01.20.11.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:36:18 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: hansg@kernel.org
Cc: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 1/2] dt-bindings: input: novatek,nvt-ts: Add nt36672a-e7t-ts compatible
Date: Tue, 20 Jan 2026 20:35:59 +0100
Message-ID: <20260120193600.1089458-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for the Novatek NT36672A e7t touchscreen variant
found on the Xiaomi Redmi Note 6 Pro (tulip).

This variant uses different chip parameters compared to the standard
NT36672A, specifically a different wake_type value.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
index bd6a60486d1f..aaa9976bd65e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - novatek,nt11205-ts
       - novatek,nt36672a-ts
+      - novatek,nt36672a-e7t-ts
 
   reg:
     maxItems: 1
-- 
2.52.0

