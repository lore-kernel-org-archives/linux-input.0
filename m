Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A4B326928;
	Thu, 12 Mar 2026 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355781; cv=none; b=vEhCdmeN+I3UKlqrO25YJPXkR4DRVymMwUCAXf2gGeyBjL2/cWcHbOVbhRsPcUTK642T8CxOzsod5URsoknZMg2BFGGgBbEdEcQIE3owOZaHtxvlgj+YIu4jWZrgfiLXQzNq0yc4IVMTsBgieXhrFeQ+vql0GL26o+4ypUKy/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355781; c=relaxed/simple;
	bh=SPYlkGlzcRTZp+SchLjy4dTRJNBK6DMGNOC3k3ofL5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfuxSLGBRL1weYgKs+B7Le587+jtDhUVSaLx9B0jxt1OqelccK3Rls3ESyVANAFrAtPesJUOvexPgHuFBnco7bpGcYh0t3fnDNdIOA6HX7q1vyN01AfOfiWnvw16wn3FaFqcR8WeOgLKll5vM0gdLDhcC5poJfGADCaVnADfm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hU2e/Jlu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=tR7big1g; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hU2e/Jlu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tR7big1g"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fX2qZ4M9Zz9sjG;
	Thu, 12 Mar 2026 23:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1773355770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BrMJ1rwOOlJZeWOhtfl5114396LYytDQ1D6kbadPMDM=;
	b=hU2e/Jlu1IYttT88I8Rd3IXPx9GUoIX5HmRFj6/MyOWuFMG6dC3mDTDI+7tZ/AdIToZ1iX
	sK7JMxaKcylLa63HnqDN0PZ/VUgwUW7tiaU2gAXZXY2Ehc1U4/u9IduvhNqQoQFvWFL2Kb
	X9qMQlASg4Ez7ojcLL7iWwIXFW7+DK5p340hQF4WiTkQqyUC8VsdDjVcvRHsclx1AHcUou
	oAM2Yzseq8e5fL03kUIepmZCOoSdi9NdF2TIK3hB7vXLFL2fa+inHMzKAdKKqlaF8FCy6k
	kyo6iZymAQeyfdiPNvEShK0AJZp6tEeTktykoqA6T+98wEUAnKWFEM9/ny1Pfg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=tR7big1g;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1773355768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BrMJ1rwOOlJZeWOhtfl5114396LYytDQ1D6kbadPMDM=;
	b=tR7big1g2fylDeqiS5oZPnRl8V09dC3kK4LStT5pJXVncakUeHr5xvvWheoo/FCGMjYRVG
	y1uXSxZ/SaIAqsqH8IUjIcpqUhPPJObfhYtZTAlie4eQhLTltBE1rXNNu7M+XiI8Nb0Fcx
	XTWoENBh1JFYCP+UPfAQBErfLAT/uIlWy73EbvqmV8ttlzbX7Ws4zMrewCvCx8sUMbxX5H
	7Yrx9R7Ce3cyeNaOoOE3lRwf0BMaaGcJrE2OaSDK0r6aG/oyiwKyeMSOavHspBW543hwq+
	DMYqukrQkDLsmwOg5dmUMKARzNnAin/oTuF4VghD2tnca0HJieHjAxzy7H45Bg==
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Job Noorman <job@noorman.info>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-input@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: touchscreen: trivial-touch: Move allOf: after required:
Date: Thu, 12 Mar 2026 23:49:01 +0100
Message-ID: <20260312224925.186077-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g8inqgxx61bp6qgxh48fr6dhjsusrk41
X-MBO-RS-ID: 8ad9291e0188dee46cc
X-Rspamd-Queue-Id: 4fX2qZ4M9Zz9sjG

Majority of schemas place allOf: after required: . Documentation
Documentation/devicetree/bindings/writing-schema.rst also hints at
this ordering. Trivially update this schema. No functional change.

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

