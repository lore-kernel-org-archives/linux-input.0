Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579935;
	b=pfHqTSH5laVmSodMMGxp0YIC9NWN617Vb3a4JV3lk0bsRnCzKHkTdk59MC5Fqf5nou/E
	 bQBQdGMoGhpB4kYimKIgHuzMDFKFRIwECejPUQec+5imqsSpiNKh5EJ0OJHc24tfQJ7ew
	 35oWit5Mgni5QPCqqYYHbEcO0w9a3SHgCGm8GSKwNmXnQFatwgD3sYlxflRc+t7xpPtqs
	 kMaf6YigFiDQyEI/gQYh2irMBnSS3p6YtpVLp6nowZKCymM4mCubRKVPOzMStNLy0Vdkw
	 32tP5etI1d60afsLRKC8yaH9UgNJC26kllSyQyjZbQMsRC0GqDTYOTeqeRCc930izpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
	b=LW9OnL2gEdBi7szJGm5Ya0hkBTyuqwThwJJAurqzMaQfNgOmh3WIsKhO9jSu24VlOCyK
	 AM/LILhBH81zT2ekkYQNfX7TuacCsGMWKTrHKq4rotPrg/Wel/bL48T3sOYpbuN5AJTFy
	 2bISPSV5NfRbb8ovnYYZTkN2ZzMDHgyZvfPsoXRuq3gEciNQcpnPYlwafssBXdJf9H5J1
	 vef2SRZZebTc+5EeD14ZFrIplb5a1nlmQ83/gL1GvNYWXAQwyhPayiQxxiY26IDgNXdyG
	 Wrkw2s4/nRtt+Ehjfhev6Nu1V4TPycd6w5ydinexB8QX4LevVDagc3aKaTsfql4BwIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=baH1H5HU;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB3606A320
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20DB3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=baH1H5HU
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e09aa5264so373734f8f.2
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579933; x=1793184733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=baH1H5HU89i+T118hkko/06VcnYYiJnn4oobqwgCsllxrJMDL6Wk55SvW0p8z2Ag9j
         uQyg5Z4TStPauoAXQupNfY9XZVOYpzLV8q0NQ4Z51+rsYF2nnKLlDslJp7hJwrUXewam
         v5xg2r3ohdM2d2ua+xFgr4tjsEwmr7L6kw0runobEQ4zJwJKwY3Y/7SolXnI0VbNHkyg
         oz0GlPBkxD0y+iTmKgpJOx/yrTWcD08yYWS7A4dg6HtdE96S00B/APkLTb7uGhrmw6aB
         pzFhNeEo/+gJXuj/vZnGZPLL7iv2I/yzPoFFHnLoGBIQNOQp8EXBVm24d54T0WIsOZtJ
         Sxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579933; x=1793184733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=Re5jW3T9ruN/qUxKMI5IEc/NTN6JN9dT9IJGGGq6ovuDRpyyayB3z/D7qWYEsatUKt
         8rD91Z/HhfO/HwgS6Y7L7FOebN6QCPDAbnShvF+nGIurvDPB9Tw4tLC1jo0CBFG6TbsH
         udw2PQDAnuSAJy8EpDP7HRDf9p6C1KVRQ7DAl+FjZXGl3jxRgj3e3QAC14cSMH1aFakn
         zpUGo/s2vtKCIfN1NPNsThiTbyV2yTIR3sJUWYhV1GvwN52DcIcS3nM2jHIsnTmhdM0+
         wqxlSLNBqj5hReH/G4BKXOzfSryoJDk+GM2MX5gHimSAQLq/R1R4lELfivDvJG2SEi69
         3D0w==
X-Forwarded-Encrypted: i=1; AKwUvBy2O0CgyEtLdfwmui4rmEcg9gkUmjoqYMVd8uR5yixF+dtnRSFdZyI7LbQi2F3M8V/zAibRNvRoWghUuA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIQysn3MIi3kR6u2OG2EXQbN5mdvYZEAZdRv7lwGk0ZZ5X79aX1
	Sj8gmnKRWeWuuWkNUj3SlCroZvQg5E90jC+1AcBkNb/H5WvoRWVuncnn
X-Gm-Gg: AYBFou2lryl0IHoWdQXxWY00fe0rGigo7f7MiMaTM2X1DIrUaKcqRj10ugEs/kvSmM1
	z1fJEaCqGl11nNnNeYkZaqYs4OFx4okDn4wSLfzUiPSZ29rbLsZpqCTZKfBq0E0z78WRlNXnRNT
	Jj95iN+PsoY/vm1UY0FedEAtjmmhcF8yxUlz9Kd3SoGvJPvJ4aasLzPpPPQLSCxi9CxyyQr8fJU
	kgMHS9WmUi3bNSkGpdY7ae0t8IcBL8KmGqdSgyy7/tDpNOzBcJUICt4YtzmRaOLMrC5/Rp7aDF8
	Z1tu4kKKe3JmP51Ni4/nC4bBMGz0/K2eyWfZ2P1akckpj6Nwm30hHonJBd1nI0VnZcjoSG9bq4E
	nKxgVeI8XmKEL1guJuLQuyKcrZJqg18mds6GDwtVKl5NAZSdpS3TaMdqjWdUrwk+zt+8gZuHrv/
	JNFEzAxuM2al+qN39MhxBAwRLlQYwnODe0zIlX0Yb3y+lnVRE/WYBwSQkKHUkiflWasP95SluxA
	LMYTMwyONmZINGZR3UXK5A1os7+5IvCpQm5S+rxCgcyCNt5rG5I
X-Received: by 2002:a05:600c:8b0a:b0:4a1:7ed5:99e8 with SMTP id 5b1f17b1804b1-4a1fdd23003mr30749575e9.22.1792579933214;
        Wed, 21 Oct 2026 03:52:13 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:52:12 -0700 (PDT)
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
Subject: [PATCH v11 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Wed, 21 Oct 2026 12:47:20 +0200
Message-ID: <20261021105109.199886-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
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

