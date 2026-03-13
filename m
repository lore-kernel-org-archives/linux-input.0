Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43172218ACC;
	Fri, 13 Mar 2026 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430453; cv=none; b=Y9Ti8dk4XeFn9D8UJjaH5IBHzHalhGlCwGTJWzbyYuLj3L3cmnvD5eEmYAjDWUFFxXA40Vvv8sLTivUKnLYyCM9BGUD2cY//OrHJy8vvpgd+cx0gIO1nE7MBozuPndRIe3G8yUU5V4HtRUIaUyazsvghkxXN4MsBwt2l3lY9J60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430453; c=relaxed/simple;
	bh=ruWuiHP6e8Pg/aqY9avsDVPT5k3lwjtf/rtJGs9XN5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1wuxyMHfEnM28rPi9c0cMhWrs2sjSJLRHd541DtPCakIhuGk4BBJV5+Dpk+Ggon3O3XhkbA6hILqE9hGMKZmP9q8fC8ni1seYFU7SI5yv4ZWkeF+kdzwL5qCWWD0PoHQc9mHTaJQrOGl5K0GnmlRwy1Gim8crc5xTwO9+MxJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oxISchqJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=erf4220P; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oxISchqJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="erf4220P"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fXZRk1lQKz9tk3;
	Fri, 13 Mar 2026 20:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1773430450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=40VUxoS5o3Aar/wuOcMdG6/+K5PJ2XzNyVo8xag5hlE=;
	b=oxISchqJUHlflJyo2d0bhzKKP8KmKYGZqg/F8wxMGW4CCT36FvJaw1ozGZQRVukh3/t+4l
	SBCbvL/Ot81oXNmZoXkr5T1SVhskk5Px7i35FcGFPlg8uYorobTCBriCAX1LJA1OpiNO48
	2hmnYjjvKqsm251lVQWNC1r5AhaRXQ5xRUs1v6zw50D0sFic3dUEOEoVwhpDIwJwNQxY2I
	XcaBhj6c+QKIT+OrBQ+fFMky6ilAu6+8weeh4ZbQRsASX7KsbleTX5TWM37u4sAY1hllI3
	f6873U0pxk6x6kigTgL2CNlvg13+/wLgZgodmo/Gs9mu4srvewIkL6D5rentbw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1773430448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=40VUxoS5o3Aar/wuOcMdG6/+K5PJ2XzNyVo8xag5hlE=;
	b=erf4220P0CrcPPqIRqYbdHcfQtzEA4Yd3QRHOq9+XAT7ZArGduvYnW7/9PWVvPhLtU554m
	2LGMl6II2clFUhxGQbx3e5KUeS6oZtRzL/mtBvakpHSqVOeVqFBQ8vFwVh4BuepXGKD0o8
	E2cfVoNpKl0aycyoptHdq6Zuk/7os2qSTfCVb9RidWibx7xhiEh0JU6KWZOZReEz1c2JGt
	1vDxpBKPlu4iYvaUPXboPz0FqTxiEaIKzgl80BY+smSSf2BV057lYIGWOsUlzCk/QlWjxU
	AXW16waEE/4NkW7tNzSMbvtvaH4IA2IydE2wIctT37tiPQlssNlqQWPjQDn+Zg==
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Job Noorman <job@noorman.info>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-input@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: touchscreen: trivial-touch: Move allOf: after required:
Date: Fri, 13 Mar 2026 20:33:41 +0100
Message-ID: <20260313193403.118617-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0be02d3c2c070a2a9a4
X-MBO-RS-META: fhd1dsfjtrcd7eboredi1bhf8k3y1wks

Majority of schemas place 'allOf:' after 'required:' . Documentation
"Documentation/devicetree/bindings/writing-schema.rst" also hints at
this ordering. Trivially update this schema. No functional change.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
NOTE: This comes from https://lore.kernel.org/all/20260117-grinning-heavy-crab-11f245@quoll/
      where krzk comments "allOf: should be placed after required: block."
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Job Noorman <job@noorman.info>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Fix up the nits from Frank
    - Add RB from Frank
    - Add AB from Conor
---
 .../bindings/input/touchscreen/trivial-touch.yaml           | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml b/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
index 6441d21223caf..6316a8d32f39b 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
@@ -53,14 +53,14 @@ properties:
 
   wakeup-source: true
 
-allOf:
-  - $ref: touchscreen.yaml
-
 required:
   - compatible
   - reg
   - interrupts
 
+allOf:
+  - $ref: touchscreen.yaml
+
 unevaluatedProperties: false
 
 examples:
-- 
2.51.0

