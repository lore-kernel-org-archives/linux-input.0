Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997D44AB6A;
	Sun, 11 Oct 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722893; cv=none; b=koe6TlZBqOYv367jNN2w0XnAloy/mDKpwSF2gcE5znQOCb9x7lvS2aMy/+V70S2jhu2t1Jg43FVew4YJc2scFGR+0q7VVRwhxFPXbpBjgu+EPDU8uPdGRpAv9ndhXnieC20cT8ELcnCOxVXU9TouIcpreM5t4bs51dqu3mCxsPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722893; c=relaxed/simple;
	bh=gN4UgkLS8QLtEFaYPdNUsR3sVd7C0RD3rHgob5KIHhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTVue2+4nYp45aggmSrdGr8am78Yq9hkhCErZm+mnXTKT8urhtSqX1qvobCNAMz4lADM5vXU3gp8tKNPRxes+qWuYBmtm+0lPfPYuRCUUKJ7GlixNyq3UZFHpF270LBX9R8U1tWXU4kmREgK/H+asx1See5fQDp5yUEtecOBAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space; spf=pass smtp.mailfrom=timmermann.space; dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b=e2HTwqKd; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timmermann.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timmermann.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timmermann.space header.i=@timmermann.space header.b="e2HTwqKd"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j2gPN0KsyzKnW0;
	Sun, 11 Oct 2026 14:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timmermann.space;
	s=MBO0001; t=1791722888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzO6vrA9N4fsDhFNeH4o0N3aibrDbQ4U2XBDQBbfshw=;
	b=e2HTwqKds/FLVAnUTpusFGyWZPzFMRmVtMPD2wB7BdlQtrq4Qjo1YPprCXGQvliebHwbu9
	ipnYthdph7t3SBbUtV0xiUnjXLaHzGhAGpMDEiNwXJL69J4bwp45W0gkBd4fyXSmuFDXi1
	3/mzAJvz42WJjId+FDNoCXYWVoErRlO1MRY5CavYkg5pqFFGnviG8slGPZzljWalkFLDCZ
	yD0T/z7Adpy9ba0tR6HD7KlIfG++f+cQ39TSg/LyKXSqeQyR8WpyCm5Nq9SpvVYCllp88G
	1w8v2pzaeHFHskFCvVQUIgyzTdF4WhwYmbWuUSoFO3lRqqM+dbJznH6STzufZw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of foss@timmermann.space designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=foss@timmermann.space
From: Lukas Timmermann <foss@timmermann.space>
Date: Sun, 11 Oct 2026 14:45:02 +0200
Subject: [PATCH 7/7] MAINTAINERS: add entry for Samsung S6SY761 touchscreen
 driver
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-lat3st-google-raven-touch-upstream-v1-7-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
To: Lukas Timmermann <foss@timmermann.space>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 4j2gPN0KsyzKnW0

Add a MAINTAINERS entry for the S6SY761 driver and its binding, which
currently have no entry.

Signed-off-by: Lukas Timmermann <foss@timmermann.space>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c..9de472b68ea9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24430,6 +24430,13 @@ F:	Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
 F:	Documentation/devicetree/bindings/media/samsung,fimc.yaml
 F:	drivers/media/platform/samsung/exynos4-is/
 
+SAMSUNG S6SY761 TOUCHSCREEN DRIVER
+M:	Lukas Timmermann <foss@timmermann.space>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
+F:	drivers/input/touchscreen/s6sy761*
+
 SAMSUNG SOC CLOCK DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
2.56.0

