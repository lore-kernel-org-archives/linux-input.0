Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445541E515
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867063; cv=none; b=b8RUbEkH4ln13p0on4fac+qxmB67j2VwomOhPk4JkRLyMYZANC5NwFUD0dpJQbLE2uHzdqhcWX2BuG/qrub3ynddSv1zP8V7D88SO33qCDn+Ohp41WbnLhe8T3VYCgTDb3+NArC79Tm53ncL3HEimcsQFR78ojCZawiRGBmlUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867063; c=relaxed/simple;
	bh=xZzzDOkgKbTZ66GRV3Ylmkt1TVDNGKrjwzmFpeTjMtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PELmXZthRRSlXCjIpQ0nt7Jur9e7MEhq3GlO8nOTXueIGNrHGaDaoJcJJGkNqzeg1oqj/m89lcC6xiSKfO43LYVgtGI3XQCNwtS7ZgGc3mcjt+16nbth0lJFOLpY3kGChu6hOFcJ7xeyn5htdiNqP9PCWwoHo53hUhb9FxvsQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLWZmXbq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLWZmXbq"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4376acce52eso2865830f8f.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867060; x=1772471860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM6wk4ilnVR3AWYXU6RXXbe1DzogOfIUTZwC0wgcO4g=;
        b=bLWZmXbqp88H2k8jp4QSQwQRi2vI0f/1Bq0gcFqMzcnIMaHRdkRUNvHEt0ZI6FBYgF
         3iWQ691o2Id0G/+XyKWeS2UeI4v/1Vdvq2iKWpq9XarKBXh64g8Kgru0ofkrbk+iPBEU
         MVU67wwols2XShMQ2hNcXE2N2kN0y8JEi64b4QGHR/1XXhKLeuFzRSWwVYk6SkxsV+C/
         Nf9kc4HhYfVmr9wk4ni8SL2cz+EJqcWXfW2IU4sQOWi3RhytoysGkZPgpqQrtZI1D9rr
         GctbvxDUsmgCwf+XPZ1fAEBzwVD0SngLMAQTEOVEbnu9mmcSTcbM1mP9IC4X7kciWYvN
         8KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867060; x=1772471860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uM6wk4ilnVR3AWYXU6RXXbe1DzogOfIUTZwC0wgcO4g=;
        b=L+Pdr7sZLrQjXc/D1tvh+QPv0JrxStYSAzmEyh5tACejFAQ5Ynjj4PGPsP+740lApc
         embIFLCEyjrTMF390ShyaI8tS09zXJPn+IxMCoZ2miG5pdGuEStuuM6pUim5ok0DoQy/
         Hr1dXYNhMoQFKqzvoPhdcglhGChd6pfuo7Yd3J6u3M9s6+tVXcTguWTl+JY3aH+urv02
         mkLD51L/0/gzke/7yDdOi9D7wGlNpDidO9Vgu5lXzbc8EKrFmgnJ4t9gbSIisb7k/QPk
         5koHv7TI7IZBjHGxdICUu6juG7B/kbuNXBJ+jYcS/rGSiz7+TgztvhAOxETlGWF2ZBBw
         a4ng==
X-Forwarded-Encrypted: i=1; AJvYcCVyULyWZhe7kHJDJ2Z6U7Lv2jaB5LOWhJ6wz5LR0JYwwtJ96Q9J66XAqdcWnEiOWy1lQAiIuStHHxU3bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8YPWPZ+Lo7geUIvOv3gboRKPP/+2Cq2QdTbiItlSC0ybhuQ/
	LkqeCRjaaXiYZY2+xLyyMfyItWOcI2aMUo81zZL39sVSTwabYxLqQEtW
X-Gm-Gg: AZuq6aL69Y/gVU1AK8W7QHdWJOS8L903PhAjDz0k7meJPdqgL4yGNTGTpwd/BYf2wDl
	Q6rvMKf65ttsjdJ8w+sXX9iZ684y6mFPJWMuflaxmldU3gSoo2/6+r0bGa75IgdvyBYB9jQ2Smh
	F2OLDe1M33nKxrpW4+KMMicPZLvhQpDsk5UWXJjuBJMEmdq5S5mNOVVlyzDXWQvbVvfLs9ciyqM
	/IWTlBnqOdMK7qnIbUkgz+90iVNdTEAETD4JtwmdjL7M7VAm1DQrlSEl/l0r9A63X89iavENMzO
	41gcLXbkc/NKVot+/pQ3ZvbXeSCBHkKQqDm7TN2t5PeRsXxJwso91bzek2amSl/6dxNdzJAOTvf
	8aqRhtCL2BgnWhlKpZ/uk2na+5SP1Kvwc5wbUQMXy+7PJmZPKpAdmIdasNhxZj1+D21e4rYTxJX
	q0ej74+wnJtjvH8+uHykI=
X-Received: by 2002:a05:600c:4589:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483a95dea3emr196855965e9.16.1771867059590;
        Mon, 23 Feb 2026 09:17:39 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:38 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 3/9] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Mon, 23 Feb 2026 17:12:42 +0000
Message-ID: <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index b95435bd6a9b..2d3c4161a7f8 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -30,6 +30,7 @@ properties:
       - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6359-keys
+      - mediatek,mt6392-keys
       - mediatek,mt6397-keys
 
   power-off-time-sec: true
-- 
2.43.0

