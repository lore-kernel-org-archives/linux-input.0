Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517822;
	b=h0uMRNb1TN3kVPyMUXI+TMAzCqOuhmQKBtiKHv0v8wU2HxSUka3bx8czexSlasmcu4bD
	 Zccmd6ahQmQS6xoM3WgXWkg2QztXhLHbd/7vjAggYvfg0lqPHuyvV2VdXY9boxoUb4G6v
	 bSoP0KoQsvRwDLEp3srHb9ojtKPTPKCc3EgUiukYEtaScMct+QQ84lFYzDsKVIexmnL/H
	 MmHyLZvRhg9p2jA/3IH6bgKSLlWW7IrZGY1KdyeADbRuCBbebKGfOZ1ZHPa2Zf7K5FRdQ
	 AP7YUe0Um6ZHDIC21niUCWogjPbRdASgclG8LjOVNdHSrnmdB6Ed8tW8I7xtg1cmMFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
	b=e0JBimLMIzyiQDFAgsckXjH5/JFsxg7+eUjxj+ooPeJO9MHtknoZhU1D/BI5SYFQemQm
	 AEdXJ9Y8mqA6Fx3YiGh31mowOhYOOb4NGQiGuREi8QY0hAh5beDkzBeglJw/U4JeuPd50
	 tSL4DS5+F3UwZLoiwM/BIb1IkTSpR3V7xbkudzZE9yONJTTe1Dr6viZP73TVHm0Vd2RJv
	 ytgbc3tSvkPDrY+jn7Z6AeFBTGdNGB8XogKfCX5zRtsJyyI9qsLCpKAjQft9zQTMDaPd5
	 V4NU/8DCW1qewP5dgUiJRztHcG5Cf/X1YmtISlOelnXPxlZmLhAwciI+WiT45khyzpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpAWwkFI;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBB606A322
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16EBB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpAWwkFI
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so18802445e9.2
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517820; x=1793122620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=kpAWwkFIF9xwPv2rF4Urtm/z72bnzw5wHjMRnjnWDZxbuO7568i6CG5x73NUlEKKry
         mx4b3vUHZiLTbrlxfQ6kXksr3dCLRwWiSDnIVvShyL42ACssSuvYZH14lS0Xkl0J7Qnu
         2F/5fMrlzhcFCbD/NgUIr8NegG13j3QAdsulLO9FsOLYpA1zmr/2egF6qSuhdCwptWcK
         AUrr74TZmzZMEFYl7CLnyzFVu58owtm8P87VwPcNzJBtHRujGkGcreuzRRtR6lKn4lKq
         awiJaUyI5dNBLJpkJ5gz4iQMyBDgXVeKhMonvHKjh/ZXQYbUUqlfwxsKRIdOIEohtEcl
         igxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517820; x=1793122620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=Id6R7Dmm/psXxv1/oWK5+dN6leRCWI49xhiIOUU3nFNgXK+6i2svdx7ATb43Ga6IK6
         JZNSAaiKpw4VQRDqqPHuIkJN6V8awzddPWCvbsPxxSk6JIQm8in3WAuL5HQawa3moFny
         OJZ3n+FX3Pp7IlNQTHmqOuZKAdFVo5joHN/TlkBD1dei8qFktdWpteSXGsm/Xh6eAIaV
         h22yK2tlCpKhhSABwU+F+p4xewrPAdiN1GYG3FGFpG2hr8eKpSSpY2EjA5PnmNd8GOzC
         gAp5gvZziMYAql2RNnx5xJ1aVX2TLx2TcrA/rJ4141OTjkbksB7r+drrXVMwJhIMbhcK
         56Cg==
X-Forwarded-Encrypted: i=1; AKwUvBwtTCO1bI+Ztorpu+LR0BaKwGK2OqCx8yix82XYRv87wynY998Kg+ALGOXhoUuSicaB2ZLvwyCJeQ0h8Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJCnY1lc+31aW5sbuDztm7JfQQJAdSmr2c8je3UA+9aL5PeWO6
	j43mHxRP8Lm3w6wCi/UO2cM0VotvyS6QxBrJv/rZkxBGrQY5Tn1YP/wl
X-Gm-Gg: AYBFou2dopBe31bc39pNejAXOIhNYsHl0fOG9nsnWzLvj6pGX/wzgzjsXNfDrQmX9Qz
	yZEpMHv+bTe+w5zqfr0JxkOtxRk3leOWQvQMBl8J9BfNDxiXdf5aIg5It8KLw1Tw7c3M6NEFzpP
	UdknqKeMYgk2Rydrrv6+JUC4aEdgMCWwtPfmZwzgY0oiad/WK1CvC2Tv1VbVwlMYUUwcu+32iVR
	o3/7zgGdbqfE5/4xfPQ1nPCfw5MZjMK/yxMNbngmdMUWuv1iE1oOBinDU8+iV2RrHLhx9TxGemM
	ejvGLk0Kt3S2TYWkjScqh0pNaDDH59QFPD6t9FiQIahCmx8J0sod4RliMCI3cGGUHuqe+C9p7c/
	/I4YBQPnPM6mA1fy4ULj/cIm8ECoxkayqSQB2L6npdPz0uDc3wguiGAPgPPCGtXPCcSXgEuV/Jy
	pLjQJKbXqIa249jYhBSUXUpJssNSqDp8QmxhnqZcKXFvxRWmNROZbX2xYtClG1ZS7E6vw=
X-Received: by 2002:a05:600c:c87:b0:4a1:fae2:a8ab with SMTP id 5b1f17b1804b1-4a1fae2a902mr22956085e9.3.1792517820215;
        Tue, 20 Oct 2026 10:37:00 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:36:59 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH RESEND v10 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Tue, 20 Oct 2026 19:33:23 +0200
Message-ID: <20261020173556.632798-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020173556.632798-1-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
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

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of mtk-pmic-keys for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 140a862ecfbe..ff720588128b 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -31,6 +31,7 @@ properties:
           - mediatek,mt6357-keys
           - mediatek,mt6358-keys
           - mediatek,mt6359-keys
+          - mediatek,mt6392-keys
           - mediatek,mt6397-keys
       - items:
           - enum:
-- 
2.43.0

