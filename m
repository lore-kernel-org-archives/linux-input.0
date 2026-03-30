Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393F3ACEEC
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859712; cv=none; b=NMQPQlreEvPWDG14eTdfE1JcxSbUg5ZCu98SHA3ApYv3O9F5TNJiuBgYX+XnPheirx8EvvIyyzd7aLP7CUc0Ss5JwDHkLE9higViZaATsn2MeTrSb2fW5dp4L6Q0+Z/CdYcV2Fy5y0nkqqTYpui6lQFUDmM2YgBIsW4HyqO6ECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859712; c=relaxed/simple;
	bh=8avPzjkVf9V7xqsFuREDbJnx4rKI5nF9UCQknqLhMxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/plqZ0FThYPXOdNbfsJC83rWrqE+Gz57l43R17l1V+K0ofR0G4wJ1nW1BTQKFNTbRB/kRnqLgr6tVUDRTDqfnzsErr0WCFyCzNF+C3z9REkXE1QptleH2avRumLmskhQIo2QpQBpiTBZFznPMC9lDt4bjPPfeR3BfuVJvC21Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIaSqxg4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIaSqxg4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb112c09so40899745e9.1
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859709; x=1775464509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vndNgbOdyTJpKLwuHM5pad07Ye98EZiTxW8ph85Wc58=;
        b=WIaSqxg4D1Oy6yLpeYwIm0I1o3tDCGmXsgjaNsi4JRYSIvt7J+topVNX9tx2HjYzpf
         NFVeknH+H6J2cdzolTmelBCMzy1Cgb7PUV7YdPinBVbGoLShNUfbeL8GJi0o/Hp6umf2
         NhiD42iomO0CoDv0geDBgSY4io7+VlKDal7LQMDcNkh0zhbN5U7dQRwTgGUnQYQlRp+r
         sfggePAy8NxMuqDg0Qv1BZiG13HAzsjAf+KxKufxfhWRxMGgpFeIXvXwfPrra/98kF+k
         wokUcjs2bCy/Wh6d97rAfZhXMO1lRbshZRKFHCEg0XJkFy0dgsn4uAxMsFSsoc0tgJJL
         SoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859709; x=1775464509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vndNgbOdyTJpKLwuHM5pad07Ye98EZiTxW8ph85Wc58=;
        b=ifJ+Iqv1Qg2GVM/52upzUDmJSpic1kiNdyw/h/lWk9E8FZOB7dWvNTfqpNNdPPcCxx
         ccylVVhEi9S2Wk9InAQP6BO8Ccbw8ZQwB8mWffUEbkwNh4bQqby0rVQCcaNmpx/HtbuZ
         g5tM+3gO4FoH4MvvVCJeUq4wRsQ4kW+fwEAZfZpxnvHvNhSB60eZXk9A2WKqbMGDKUz2
         oagwVmJQfX3Yl/xtWoyLN5XGd6kHpQeJpJPlRTNE0iQCFNcJqMIqGFKU7uIOt+EJ6bnF
         9nEsoedMZAx1IF8+XlJvGv+dJPHbySaY01q/d+2gcnvTp/OACCFQtcrEnLV1Ao95t2wO
         LeHA==
X-Forwarded-Encrypted: i=1; AJvYcCXeiV+xLWxQePjsFbbvdBPcjX94Q5bJJgvCgv6ySw5vUUr45ptIHDziaqM02IHBxUPnZk+LKF7jL7n/vA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3EFKBCMFSIPfb9El+N9U7Jhnbvc5zfsHseBD7rVg7OFyqaCX
	modtcBS10SE6Uj6/+pMF6wSP/00u1Ylec/ymyNizIFJj4/5dCsM7tpNm
X-Gm-Gg: ATEYQzy07yVl7/0WVNazQkZzw8W0onTgh1GGKTfsUeTc5IDvJfVyrxthMMLXHpuIBrh
	DrEbl2JJawokdpVKmKqhDbooBsp2oDu4DX9yp1PGNSJGxOOFqo6o/peXcU7Rb3hwES0k+K+3E13
	JuV+Fa1JnUKCV3isThDLFpU0cc5X1L2T1v+yv85QM1kBtn+ePvrmVx2g2sPc7GN48rwZMRu2tUA
	MGk9Htsv+JQU4pei+eVxjJFZeTaYXXoKKOUFjaeWx3HxCn1i91eel/vWkls/jNhxjXFoqiF3Fe9
	lLsT7C40ih+Wj+2EAsx/EIrQd7YPVscZeGSeSHgIi+8Zofh5KAJ85TcUcZJ2nT/R4pSHzbuLz2T
	H+hK/YUQEo0U825EUpFAGgRn91NagYZUrrc3qCzMy4x6ges+IPfYP8VfJLPmbTzVCh8DvIYfZuw
	AAFyoz7JcNfNeA+La3M+U=
X-Received: by 2002:a05:600c:a10a:b0:486:fbc8:8dfd with SMTP id 5b1f17b1804b1-48727f80089mr170085445e9.23.1774859709303;
        Mon, 30 Mar 2026 01:35:09 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm508329995e9.2.2026.03.30.01.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:35:08 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Mon, 30 Mar 2026 09:29:36 +0100
Message-ID: <20260330083429.359819-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330083429.359819-1-l.scorcia@gmail.com>
References: <20260330083429.359819-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
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

