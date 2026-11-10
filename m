Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310228;
	b=1r5Cxm+80ndnss4qkRe1QvM3N2x5MpbrrOccoZTj/RoBI6V90JhTLPqsjREQssHiZkPy
	 seeer7f9MGUUsHizEM/ZPwA4bbsQu8pH4NQgYoRe/o5D15Oq0qE/7Z/eGJR8NEJj73Ijm
	 6xzHoRS1roBPiURya/OAMQwNPRqmccuTvTrxQgG57U598pxiMwuwEUhP9DTrJCYITaqi9
	 l/OP1IultSNgrlDZo1N6Uc20Z60FtnuCiRegMGMnm2vJ5d0ikmZuDhaDGvOt3RUtZVz9i
	 krvQBRflgBs+DPheunc99USfp7qp8P6DTWGnPCS8kQ57yzBSrgFzawNQ0BwG02Sl+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310228;
	h=DMARC-Filter:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ASs/Lr5hmw7OvEYrPLAA7r9jMOGHJRvRZ5x+dLjTyLU=;
	b=dTVU/36I1PshPYMeOod4fYel6Sowz1SD5vUHTkUlgGyW1dayabl3wwLiydfBudUbt+7A
	 eegd9zp5ra5EBymRbpFFYcyf7lvvom4nmr6uwcDXzsVjtFa5BT72niv6ieHesRja7IrlE
	 1Ozblpw+s7RNnkEi6B5dS/M538lyoH4lD1csk0A79OcCG7sQHxB4hN2YStz4U612NUp6q
	 PoGirAb6w/BGDew4H48M7ICkOq03dH5OoNaaXnVYglow2EpkwNCay6PYRA8XlMZPa+UqI
	 DbOoirB+avSxz4FJ5sm+lAXFQPpyFPzdxPr+c8CL/RZEYSA/o0GEYXK/aXRHnHuR4pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=LSesk1Na;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1B60A2616;
	Tue, 10 Nov 2026 11:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B1B60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=LSesk1Na
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ASs/Lr5hmw7OvEYrPLAA7r9jMOGHJRvRZ5x+dLjTyLU=; t=1794310227; x=1795519827; 
	b=LSesk1NaCaAmvWZiKWpMOmSsy5xs3IIYTDrWVMhruGYiW6doGf02hwrxXwaEdAm/xwNIRMsn1Mh
	9J5XzXas4Ki+wlBD6TKKbHUOdNlBmGwnmSpMLFdNtlO18OcT+ucAna0puhuZp0QmuBTyqLZEkjOeO
	A7UwuRC4t0OVDF01lxaesz2h/MixmA5dGEWr+Nm4jefMOuDOsFB8nk+NUCRUO7RoUPGQMwDY1RshD
	ynmU7cT+FkG6+Wjp+oakkSwzhNpPbKAsSVak31aPg2gPr5I72ISlUJzxpmBpe2TPFYHbiCG3E0M5c
	qayzojzr3C9+EPBHQl+WHSh/TLqcT8fxE97Q==;
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	mkorpershoek@kernel.org,
	clamor95@gmail.com,
	Frank.Li@nxp.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: touchscreen: tsc2007: allow standard properties
Date: Tue, 10 Nov 2026 12:30:19 +0100
Message-ID: <20261110113019.404706-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver accepts touchscreen standard properties, so allow them.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../devicetree/bindings/input/touchscreen/ti,tsc2007.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
index 5ef38d24d6a97..b8a11631183e1 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2007.yaml
@@ -9,6 +9,9 @@ title: Texas Instruments tsc2007 touchscreen controller
 maintainers:
   - Frank Li <Frank.Li@nxp.com>
 
+allOf:
+  - $ref: touchscreen.yaml#
+
 properties:
   compatible:
     const: ti,tsc2007
@@ -61,7 +64,7 @@ required:
   - reg
   - ti,x-plate-ohms
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.47.3

