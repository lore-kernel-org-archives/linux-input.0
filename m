Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878837D121
	for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773152; cv=none; b=WbS12nDH9iTXhUR1VjKtWn8DFbvfhzoSZ1FaGqo7LNPILrSYNSaPVKk8xym2Q86aXsMTjj8xQUnsdSun7rErtgz1Zq8SyUz7ns8KsrN15vM/Ffz1xYK18XzXXh3LzPV1/vtkvkheN4mmsJK6UoOS9jvB4ZYHaXrL6RbmbeXAiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773152; c=relaxed/simple;
	bh=q8iNQRclNimcvTVMz/xp0ANElWweIprPYt8rET1d6u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeVqwVrN1n0Q3zQMVBaizXj8HdqCXuk3EYh3QtIfKmSDRg9L1ru2R4LIq1JlKFXHNmbyUkorXEcyJY0BFqWs3wOXNuQ9R6/zJhAeOdURIouLdhv/BSWHGYJ++4s+ur9Lu+3G0CCb6QZ7ZrZQ47bcgTj6v8IUF+8ZM0+10Kxqv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq/XaBfW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq/XaBfW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso55163685e9.2
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773149; x=1774377949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=Zq/XaBfWQVvF5NbK0pKEYbQgj18PCCJvmQZjlZi4bsBXlf8GfR9mowFsgZWsMOgkp+
         Zav70swWAdTCzizZWJaS472IaKZ3nynQi/pCAO8sWT+qjE5gybdm2WF7KCIkdRRyWWX4
         dRIXOgN5EisbsCtUu9zRj5oU+MfkEDo5hqNbhDzENmLq67ow8DOyUVdL36qNUQJmOwFs
         rtqdEu8PWQUYpzVkrUjl4/0+qd2/Ijnjuz9Yio1F9d9oZosnGtMBTz7P21Y5isLVnq99
         9a3Un61QzYs6/3snZ0MVLTvRfB5NL7GOyG6h2QnQrLvLotYzBqHntbbpdf0bwqYMnQgW
         I1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773149; x=1774377949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=rakB+iyY5VDhdbs/L51CZq/aFqcR6KLxTsPvUIDi0QaCOmyfEnyY2FZHgpSLfLy+p8
         7hsANt9pHX7X7cuUViiEK2HBumNcBPi4gbTszpAj5sc1X+HTv83RgInJOpKaVjTu2LY9
         A21RalPbJLEEsHG0BzZdQAHpGC1SL0ptSAc9EsxfMpot9mix/LKI85xzVAY5RbCK5H+o
         1+Q7nogLK4XcODQ9Xhh77mT35FbSs5qzR2Pwhlu4HGATqqHFbQ5I4oYtrgZG5t3JFEzR
         wDwXRgZb6wH8Qoprhrz/7Gc+KDomrr5YO/4lB8ZaNPqkz4WffXU5ZyhH+omvkjtoTruh
         6k7g==
X-Forwarded-Encrypted: i=1; AJvYcCXXqxXJEvBap1YjJSQvGPx+o+AFNlL2UHETCENE+LVqe48uIi3ruGkugC6oOsDB/lWYFZymEkiJxBYszg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxQcQHRcxzvR40zEd/7fZZtjPzg17M15CISd7VOg6lpK2TAx8
	21I3MhUL+6aWseIXSke8f807z/+/zhdgnd1X8Ydc+hD52W8oNUcegdw3
X-Gm-Gg: ATEYQzyw6ck1E03Vn+cK/gt1XB4zjc1WZu0r+gdogoGKTwb3wpXxfpvyuf3oBEVSxBp
	lsYFA4gFFqA4WFZlxjKT9BsDq+f+kPFUcFScvohK23TIn9OJlTmvK+FnvTr/2gs4UqZM+/ehewg
	qtmSa399wXipNajdz3AzrqcMFERhGtXZlXHXWVMaI6cyG2XoU9JEfO1mKiEwtQg3YxSUz7gXy3c
	ZgkdX8lI9KfuVITzrYNNOIcnMq8cBdj2D3H8PizSdloEYrqoeNdR7a2+SHemoZG0DShVbj0AA1o
	yabVRpETcZ9HosgXDjYpHoaLW3hP0O7Zz0yYYuSSQOerlY6bYtD0BlMfrB4jV14SGBDyx20hqqq
	0sZKei2AaBLhgd+KpT/pSoaPykajeRUKkIk47QqXxRkUQL0ox66IV8ABYcy05BuBQ3QZM4eI/Ui
	5hKKCGRSBkSIJfQH4rThmi5ulL7Mn5LQ==
X-Received: by 2002:a05:600c:1f93:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-486f4463591mr10143505e9.26.1773773148893;
        Tue, 17 Mar 2026 11:45:48 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba760esm102725e9.24.2026.03.17.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:45:48 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 2/9] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Tue, 17 Mar 2026 18:43:05 +0000
Message-ID: <20260317184507.523060-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317184507.523060-1-l.scorcia@gmail.com>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
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

