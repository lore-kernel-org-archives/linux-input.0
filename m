Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794922006;
	b=f4Qx8b+AVQ/7A7QuCc+xLuVu3bPnI2orQTBfLS+1PBjOjq/gsUaU+3UEcWeHzWta07uu
	 lbve3rKkKXwUzJc6GgFjSUm5YF5nUpfIst/eDfCZ3YtAMlE7rSDXYgs0p1eJPthUnbVxk
	 JDxL5NBH9D6kL5p4TKH6zhWKx8zz5+UjQmcTJlsBe3gNM+l3O3IoAhEpVGrlCogBg5/Mj
	 He8eRhpT4Sv26oStUCuzs56ANCbw7uvh6kPFWj8y5S7B0Drxr7dIm/Zr6khhekZvUDnm6
	 5h1WAxpzezDPHmRkJpX8J9e1w1GxayrORif61g4YODFoTBpnk7m+PIZDu4GgbphbRZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922006;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=i+REedDVBSFwJecTIqRWJ1YL7pNWyE73P76MFVGjx6g=;
	b=ul5zbpDyJcnfoyKK/tofbiJauMaVU8hp0us+c7mw9CNUez46BSRGCrhBce8+r08D3I11
	 x18dbkt719WHrc1AxyUcQiyC0CAkVEPnoz4l7daRhV+nAOtZvb1vOGF8lSPCsiwhoH+p+
	 z+uKRHU1i23DEKebW698fecR9APMrw+Rhe5I67JJPuS2tTRDo7SO6JkcyYnBdZ2XyFyVQ
	 rSBmizP1t0/m7R//79i+Jf1LAYBCjPQ577BikQFaV6/tYv96Epo1z8HND3K6YEuN9ewLl
	 R1Oc15M88mhGaclTnQSUhO/aNvL1MkHDFdVYUp6y6AceevHGL4zwXLRg2usgIMZhdlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=ommer.net;
	spf=fail smtp.mailfrom=ommer.net;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ba9t0Szw;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=QhUjXnTY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6600606A334;
	Tue, 17 Nov 2026 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6600606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ommer.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ommer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ba9t0Szw;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=QhUjXnTY
ARC-Seal: i=1; a=rsa-sha256; t=1794921998; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=h2+8d5I5r9sSn27fsz0/v9AHMXGW6nffYkAF/Mee5MwgixKwMm6N4jBvXu0qZQj02z
    mIvpQed42+CYQ8vBW++ZJnpylbNU0KLhogTJaEU/ZzA9x1ztqAB/+skjuL5Rv9kgZgdG
    7z/tvLQJRPv3sm/r/ItbFywtP691EnzqNuH5FSvSkZ276TwjVOa+XvOhA0uZeFH94ZLG
    lTaxcVi/rMCf1LhynJLF7h5pSLHCEqYVHYsusT6Ohl9vXTBO+GMr/9GZTEpvC6mGvZes
    DA/oDphPuSAvc+Sntx7dnZCs7l76N+dtHQeOW1y2q1VP/Zpes4rnuedtnhIqqv5k7jgn
    jHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921998;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=i+REedDVBSFwJecTIqRWJ1YL7pNWyE73P76MFVGjx6g=;
    b=gzZ4T0C9hFcCaMi3UtAb9QgPxduJb0m96KyKo1yXDSfRTQ6Sk2/+zF4Lqmhc8pL/+J
    wEJxJO88BML1SjjoOzg/67kHCDT1iE93DNkM/6n9TSJmvS1dB1LmCmbrWAMBBP/PSFEi
    erpzAr/ajpheDqzQMXST/DlVHotiiOwvT5rfwH6SGPXaKgSdUSdc9qRpfBfppD/GTtdq
    UkCT3Io6L+RelO9Fh0FBIYS96NdwQTKZY08YGbviSxn1Qfmax3ALMI5p0268YyB6sm7P
    QDoCa88u/mwwCJHxdBBUrwalhW2HXPXmrkJxv5aisw6EG01QbI7kQsBVztIQ7crhZMd4
    zuMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921998;
    s=strato-dkim-0002; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=i+REedDVBSFwJecTIqRWJ1YL7pNWyE73P76MFVGjx6g=;
    b=ba9t0SzwEwrw4wvlzjtKPopXImjsf3pHLTEnVWefsxJU6Ce1j4hAOIGSbD0bV3XAAQ
    G/USqfFY9SDkDwm5KnH1rxwc7O+cwKBex6Fe4UtSpTNlhrqwA5iQQ3QUOWHnb1mp3LCZ
    KtMLHyupQ8B7ki2zXn75TzpQPoIsiCHZBZ+jRYGmWRcV9MAs9oE0q4IDTYZxkdgxZ8SO
    XE/Y8Sh1ke7n94zVUgFm5m6BqRpfu2fSEI2mtkcd4xgHqrwhLXJK1PfpsuUU42aeWiuR
    z0gOyMK3oAFBF5G3ECNKUEKMup6WSr+uTjWeK3LbDE2GAcHi9wHirOGIeq4RRWTHAyYf
    bk+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794921998;
    s=strato-dkim-0003; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=i+REedDVBSFwJecTIqRWJ1YL7pNWyE73P76MFVGjx6g=;
    b=QhUjXnTYIoa/fr7bDkDA+NdMxvszhEY/5Q9x3PFQBbn5XArOjkIggt4yODDrrwPPm0
    t1g3BL7tv47gMToITeCw==
X-RZG-AUTH: ":JGkKZ0mIdPJLfj3rk5MOrv6kH/tvwFubxUqMvsWOyVXJkOABZnPqvKUstHY8FQgnq3rT6NoXCyjULwIut1Tf8meVypGj6A=="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id n2f42d2AHDQcvue
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 14:26:38 +0100 (CET)
From: Henri Ommer <henri@ommer.net>
To: job@noorman.info,
	dmitry.torokhov@gmail.com
Cc: phone-devel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri@ommer.net>
Subject: [PATCH v2 3/3] dt-bindings: touchscreen: trivial-touch: Add hx83102d
Date: Tue, 17 Nov 2026 14:26:36 +0100
Message-ID: <20261117132636.12232-1-henri@ommer.net>
X-Mailer: git-send-email 2.56.0
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
Content-Type: text/plain; charset="us-ascii"

Adds the Himax hx83102d touchscreen controller compatible string.
The hx83102d is software-compatible with the hx83112b.

Signed-off-by: Henri Ommer <henri@ommer.net>
---
 .../devicetree/bindings/input/touchscreen/trivial-touch.yaml  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml b/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
index 6316a8d32f39..d0ee79ba096d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml
@@ -16,9 +16,9 @@ properties:
       - azoteq,iqs550
       - azoteq,iqs572
       - azoteq,iqs525
-      # Himax hx83100a touchscreen controller
+      # The Himax hx83100a, hx83102d and hx83112b touchscreen controllers
       - himax,hx83100a
-      # Himax hx83112b touchscreen controller
+      - himax,hx83102d
       - himax,hx83112b
       # Hynitron cstxxx series touchscreen controller
       - hynitron,cst340
-- 
2.56.0

