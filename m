Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26693932D5
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031395; cv=none; b=gLcLnenDya42epsRMPpiSMQsGZOr3LiXPbAyJFt8iWL41zHH/I3/6UR1nDM/HkkulVqIdxICwtXuvvD6aAdUfKwmRNwOh3FdCf/SF217sBMTY5eTdVXSSPJssoc574uGiGZ277iWvrGc0tjUJksbu3yeDrG0c19EaGP9eLmDEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031395; c=relaxed/simple;
	bh=wzHE1s+2gX2BTWsN80A15vJGvuGnxkYOLrgZhcQZ1X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xnom0dvUgbnnVrETmcxiFPoeWgwNU3xvhuZ8By0uBnnqxmKwSWNyKA7B3L2JbAmpWQepZnbEWPPu3Li4jiHzsi1CHpEj8bS0w1ZIORb1/73evXkKs4Jnznq0VOQ7O91lRMj3ANyEv/K/h5qsznvFY7iUfMC6q/3g09ud1f77q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1wfPuh-0007oz-Ls; Fri, 03 Jul 2026 00:29:43 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 03 Jul 2026 00:29:26 +0200
Subject: [PATCH v6 2/4] dt-bindings: vendor-prefixes: Add TouchNetix AS
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-v6-10-topic-touchscreen-axiom-v6-2-1aa50ba3bc5a@pengutronix.de>
References: <20260703-v6-10-topic-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de>
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de>
To: andrew.thomas@touchnetix.com, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
 Danilo Krummrich <dakr@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add vendor prefix for TouchNetix AS (https://www.touchnetix.com/products/).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7cf0ca1436713ae44f1950259f006..b8450050d7299cea2b5cf6f57fe71f5ead1140c8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1715,6 +1715,8 @@ patternProperties:
     description: Toradex AG
   "^toshiba,.*":
     description: Toshiba Corporation
+  "^touchnetix,.*":
+    description: TouchNetix AS
   "^toumaz,.*":
     description: Toumaz
   "^tpk,.*":

-- 
2.47.3

