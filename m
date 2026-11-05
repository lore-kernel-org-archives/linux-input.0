Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907923;
	b=uiSxz1T4ORE5E0OEA6PGEsjt8xTGbGFoqrft5D0Cgy++L0o2T7ZTczrwHNqV2QkSVZk6
	 5GJJFCs2qUdASb94hMgXDSSa1ZIK7Kt7V2t2vXpamEj23qFgTHgdd8I1tIhGB6pXK+Fvw
	 nEJCcofGTb2TflX5NvENvgIBnNlJgZEblsl6eI3T4V4AbKdCj3MB5NDMsbMJYTbdGHtqf
	 Pv0KwuzqSK/V5gC6UyY1PzbVyAt+sk1TYgFR8KnMXkn9Sbpio13ujJZi8xeVJ04rqooT1
	 NNHbrkTJWf63ajnyzH0ntMvDZHI5rqMMnp+svZoSyccHLsbtZFOhpeOvGICeHdx0t/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
	b=ZXeS1YrOcynuZuzKLVvEHE4DDg+UQ3z6AyNDQO/13VzsgEpVwzwOB80CdTmlCjohNNs+
	 yeXcQ9uNYNVIFwI0fqd34eI4YG+GsXDJfHpqG29W2KPR2JZ28UWEedxBv+sxSdClelqk0
	 aSldHjwiKOKTmol0KA3EjIQN9ZZBrk/32XiqF4UnN9l9CJ6mlcxzFgi5odQPrwGs/Npfx
	 WqziiPKvuMPG1EJ6YiX9iEYWtMhSXZzuAU/1Of3cEYfoQikRAw1Vj5hy9JlxdTqPSxnFq
	 jvGkgNNHycN9P0mHfBxH6telqdvzAtkaMj6KKCo8Oe9POO5Mh2NTbhA4fxwEF4n6tvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RrX5BTtZ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE16079565
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AE16079565
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RrX5BTtZ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso17628945e9.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907922; x=1794512722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=RrX5BTtZ25KAkyVDqIgIjSieI0yowwfSr8T6mwymv0DBFz5APBPsQ60BLti2G0x05q
         6boqmc8T+fJnxWSpzn8kJusKUm60NFwdJju/vVYZ3iqkbGQzDtfFvv/qi3tNuErvjFQe
         11nINNWnhw0ATZ5Z0jI9ua9qp/9M4BXOQh8gsE8HOJjK9+JEh2ZyMaKOxeec2cZVtpKK
         k8HMWcB67/FgMv553KebZ8rp0aOtZ37D8ZbsTaxepxk5+SsWn0SA5ZeuI9H04WfA/VaL
         WJq5E68OZ+r+EbYxT3Ff7TSgkCiF45epeHQoZdEWx7D/vK7+0qaxziCcKWwcGhlSdQT+
         Ybnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907922; x=1794512722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=Vtuc1xtGwR+ApNEcNAIdUnh1T2HqYU96dpnTd6WEdPIXyHX9A/QgEKL4JXqKpmWAQC
         jAImZ8hx3/HP6ND6qf6IivUTx9slnpABNOkCkuByT2DeihRrBOMwPbNou9sPLihDvkj1
         7+hZgsMKSf+ixBg3EyNRs0z8pfx8gz+axMUlhOxWxdmRJIYEahtpn+zwrQL9jMcdVMpG
         JBulz89NmPhjiiKccUI9Rf90JCoJQc0nUgMKpFjiEVlJ7p4uP5/gMwJnLs6xkmvv57Ww
         hhOeQcdZyePFXKgSkrw9j/8qYW4tKiXYjdnidkUyE2ajVSdqc5d8RSM69Xe7FMr0eBFs
         fODw==
X-Forwarded-Encrypted: i=1; AKwUvBxAE463hm5tIndm/KiaEtEbvsOfxRaBepn/0eaG0clQH83oDKlucfL6LaKkWZheBleIfkyKyj+352twLQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/80gcFjVsQK4yNT8hCg9zyGfKVKGQRFFmir8kuBJQZCNr2bbmW
	0uQWHHxFxJw83SKiDyg1+FIijIg8TBxzObehqpnqkhKN7g+D8XZvxH+g
X-Gm-Gg: AYBFou3GRbhcSIHnVF8IJR30kMmi4z7sVQ2/En6QYWJE7Bvkxjzhl0aA8ntGlODy/2c
	Oh8cz2yjmJpjwqSt0PHULBOcNunBqDnSxuhZGRCtj1rjWuJQUdhCHQ8dIk0tmM7ZDByr279J2UB
	DbV5xlde1wC9xBvA4Hbg6Jhe4ho8ls36FDX8YMyfhuYngD60ki+WA2wPiu8+cM77L8vPLtobJ46
	fqkkCRsnHGU6J+cedIqS7u/tbIBnmzYdkx9pi6yEpnzZ9SblBmblbMruRJ9rMk+C5y3qPWKhRhP
	f+KP/mXBWDul1Lf9gVXlIMChSh6zsZoWXO7gj4BPPEzDin9YEwZkMwWouAoOQ575/BOxq9ku1Or
	JLME780HMJkDo7dqDK8K/DJo/GDZZN2tX21geijyQAjqKPjZAGFUqUVth4d88VEeF82ppc6B/3u
	pwQrCWDrNO+GbGbKuunRpOF28HaNfgL45RFd85z5sIs5t3ryb67Txce/VoH768H5Kwkicl6yLCX
	3Vw8NBSUL2bPvDdB0nQ2UC1QocTHqyBgsYXAuXMht6bwLuAqgnkchUrWf13dlNBqf10aRa0NSFb
	Qx913Rf3nLmP9VLBKdgtHxun
X-Received: by 2002:a05:600c:5285:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4b6db4a9a2emr3123275e9.2.1793907921887;
        Thu, 05 Nov 2026 11:45:21 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6df5eaabbsm4204265e9.2.2026.11.05.11.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:45:21 -0800 (PST)
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
Subject: [PATCH v12 2/8] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Thu,  5 Nov 2026 20:41:33 +0100
Message-ID: <20261105194426.1113050-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105194426.1113050-1-l.scorcia@gmail.com>
References: <20261105194426.1113050-1-l.scorcia@gmail.com>
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

