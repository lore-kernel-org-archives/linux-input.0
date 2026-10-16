Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72797447250
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792182733; cv=none; b=Npjpe9JBMwtzZtgozmUHTiTw/0sIl2CLsndEzQ48mNbIuIFZhJNFsnR80Njl8DZYWhYXXNNCRnF4ttm212A1zIh/XBCO8QP9uFJR79QD2Io77YkOoy/R1aKY0bRFpxmUvrdHqxbjyTURb7cqmp8TWOlyEVtTbanyqYs6iVdorII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792182733; c=relaxed/simple;
	bh=yoP7TPV3CfSEpC5ggJdNPW/TQcphN1bT3N/Au7vURZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+XYT20qnfd9xNVVEcs1fm7r075inzq5pSKn8Hyncn6xd6lKIDa15FGWn0cCPpO4oerab2dmkw4f9hkyUivgrma+Nr+xGM1Opw3KR9WlH+vRdpOtYOnJQJwu0RT3hTY0rF/34iL42mvXTZU1NwrzK0RfnwgReZbDNm9oNPmoAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjxRRMLI; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjxRRMLI"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30b6dad2382so899199eec.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792182727; x=1792787527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u2QKXRBmpYUkyqYMuIECl7wkBgS4oNFS7MDH6jop3jQ=;
        b=SjxRRMLIm1RtJTMPb+bC0sALCx68fKvL25ciFQaXXd9kCeyrZcwhqoCXFHYeluFB2W
         03f0lxQ9jB03WwzbDE5Hdo7oQdpB2cJFpBSiZnXx0dN+ZxyUNyEFp814yNbTA4VpSwbi
         FKbPXPTk+UDvLfqVhScWo2GNPtf+4HXOMzGJbu3iMkCFrRqqB+z3v5bK7S6ajDtrDVyP
         NWzHeLhWuBcSUzWvi8ujaqz7jyHmMRwMAn0L/Cx6CcDoSo0q3sAstF3/P33CjmgS5u/2
         tw6qQAoXTPCB9piZpQdMbTCJC/HWuU7q/3IDaE1yoAw8IsKTGLwU2ugdaahiUxWvq2aB
         Yj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792182727; x=1792787527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u2QKXRBmpYUkyqYMuIECl7wkBgS4oNFS7MDH6jop3jQ=;
        b=NoVl+d2d45ufV9YueuZuKOeTzQo0rNWTFUv7wQvOdpiO77LuZxd2udEsrOhe0RxASx
         kjQOjlaRAtdCJarz2xVaiu3bIh0/jp+/hjQu0yLbcrzPRZe9p21ZoDhp2YbZnCwSUQ1T
         35rtqpj3UFjbK1m3em2FHWsBAIFPzkttUKze5ORecDnG4519yGZeo7dCkY6BoSL/l3nq
         Y3UDuuNpIcPWZPQAp89BQP6jppqDbGYjEs5mK3aGmvZgh0PNxtdM3m7xhybVtUrRN0Px
         twnHFsDsmJUJQ/bY/+ffOlvZFadtSEHaniTTXfEdZjlYWxp+yU06CyukGyNWS9cH1H9S
         MSTg==
X-Forwarded-Encrypted: i=1; AKwUvBxCY5pjooP+nkj0PlzztHZTugnbS0MKnauTJ8yV2kEXTH2pxJYY+oADKbLreK5480g+rmFsYGqgXKehCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIMjnZPV7qhEpS4WVIaCXxoAPT1hGjYC9SqalzCHK4ONHnLBgFe
	zd21qNSuhfucgkY2GAed/KLTXnVh0y7H+pALfHhz50UL0lFh7XChauHEYndtBw==
X-Gm-Gg: AYBFou3uRyoLvyXRNVg6sa0WmKc626V/DWY4/kSaOve/tzDrbZR2T22ZrZRbls+MIV2
	0RcHJiQXUIgf9vPAYJVZtSI4ZlsDuxC5hRCZSuDXsFquVjvoru2WNOhDuZ19fwZIo+pVdHdSy5d
	CE5do4U7f1MV4dEVzUYzaBr4xbwtm4UqPpJa4755K+/zObmHPvX/LRBCE3N92pXFQd/rpIGb9HO
	7IH2QJbiCX5zgNwtAheWeVqKyx+IPMeYc/7Kd+fBX6LrV0sXPWxKPc0AvX4wO69LQxHyRNfJKP3
	rrGtKiey10oE3FNIfZNYYPH2vsfaUudnHGp8swjISMJveMSCWF3U8kpTmnnKuFQeqzAaZ5av+pr
	4T5y6V0CQ/k4mwFXVRBYudP6q53MOtzVJIcPR39JUqrDYXNQjtivvb/UOgIVG7/9RvmrlVCYsSg
	qgCHfVHMMRh33+dx6/Mvnf81W1BYdflluEFapFvY86mWF74gbFkEKShj6P5Sjs2qlT+QHnvysMr
	cB/OAoHwzghRB0h9CiEE5X5IDolDbH6qUvq0HGr+ZCezKQk
X-Received: by 2002:a05:7301:2710:b0:360:b8b4:840a with SMTP id 5a478bee46e88-361a2747820mr1223282eec.39.1792182726979;
        Fri, 16 Oct 2026 13:32:06 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a801:42fc:16d8:d66b:d6c1:caeb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm8351620eec.26.2026.10.16.13.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 13:32:06 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: input: ti,ads7843: Allow SPI clock polarity
Date: Fri, 16 Oct 2026 17:31:31 -0300
Message-ID: <20261016203131.454640-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx27-eukrea-mbimxsd27-baseboard passes 'spi-cpol' in the ads7846
touchscreen node, which causes the following dt-schema warning:

  imx27-eukrea-mbimxsd27-baseboard.dtb: ads7846@0 (ti,ads7846):
    Unevaluated properties are not allowed (spi-cpol was unexpected)

Allow spi-cpol so the binding describes the existing configuration
without changing its SPI mode.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/ti,ads7843.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
index 1b58fc263dce..24172d206d6d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,ads7843.yaml
@@ -32,6 +32,8 @@ properties:
     description:
       GPIO handle describing the pin the !PENIRQ line is connected to.
 
+  spi-cpol: true
+
   vcc-supply:
     description:
       A regulator node for the supply voltage.
-- 
2.43.0

