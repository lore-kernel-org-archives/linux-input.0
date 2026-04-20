Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA9383C68
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720995; cv=none; b=R/3gVdczttRUPyAuaWDJSv9tiRg7RWNJ3nT8Maz4LXQyTWkBVYellqFZEQcMHDPmyI+FVwiOMSY5OXnrz/nUeUu8XbaZEUI5JrvpCtO5tHOx8JbwsnzhrGpFROnXgaReCkutxjWx3pJX3kxiWREb63mwSwdVamIoMgX7T1IqTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720995; c=relaxed/simple;
	bh=EKvdaIKyTKvcKJGyia+SK7d+HUNcnLjmavHs+qnlEDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF/ZOfap0tx+J6s9t0K7UohlVeOMtn7tfC+tJY5fNJCRdXmlt3YAbNjfWAhtlSHl0b6B3wAjieBGtawv/aEv3VwAk+8VZKatUYqfs6TSbZKfuvRYKH/xm2QjtxLZfCYk+ejdLpTkjhAYIV1sqSxEWZbOG/yYohnWG+ez0FDgx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxyA3F3r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxyA3F3r"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso30261225e9.3
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776720992; x=1777325792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeDXgOZ2fJAOAlM2C3zm9hiJl6sDVNOXzlY1iVGrLts=;
        b=JxyA3F3ra4LE3ND+V8+JSqnBRDB2tlPE2Flnz/ivNKfjbfH9/rrwBEFRuMQwKzWW5A
         EGOmQJB6MEyMHgfMLGMqddDFkjBjciugY5BFnL9JdcMomFOnGZdgwWYpps5Ybmm2MUrN
         Ad2J1qddjha+2HOC9hf6T3IOity3ZRYCi+uX1P4h6Uw3TJlp17n+RGVIG8miACN9JDJ7
         kmUEEXtwRTUy3VqWRqMLXvnh+E60xXOvtGAUhCwr95rxAAkU12E9DZ6dMmciORPXXlbJ
         RRziC8tuXHv9YnEuTUU1guytduNpPRQgTMJAWwiT8FUdl5/kde5Q0fyxP1RC/PO4e9AC
         BMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720992; x=1777325792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PeDXgOZ2fJAOAlM2C3zm9hiJl6sDVNOXzlY1iVGrLts=;
        b=HWNXjVWFMLnaFERXdQPNcEI5rEQR6YXDdftDiMMVnYMwVVLcyyX5/xZcupRE3RiEHJ
         m2jqDolOyc7feA44huDHqJhiBoGvDyoLWfuJY2O4+FNdAP0awut/g1nIfQvTS8CQxdkW
         uOqHq+XlWRVihzS4c7FopswKARkP+PKtdIotVWrU2fh5kk0GI9RuIQXB3hZ6FhKy3DpH
         VFcnDxpNfq44FeW8xcRQRCTicelmE7f9gaUrGon0Fa5z406waeU5A7mqBvVwSazUBMu/
         MxTR4SNQ6WgucicPFpzOp4VJ6m28qT22TD6+XpkR4nAY8JQIvXQtNZj0Afpu240h+UmA
         FJTw==
X-Forwarded-Encrypted: i=1; AFNElJ89Tn0IQmMZS89bRzxzRzUk4wcsFHM7+2UJyTJmOonKt1OWqPoxly/mdd4z49/B8O54Z/HUHm2zcdyT0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb36YCiqrqrzmGoVEF3snrChOq/lSqxjfzdJuE7Q3dLM8V43j3
	/2wZK1+o8yzznkZpPYCv4ZFdopmio1tg8mr57pRmyrWBQGUrPy5SnukN
X-Gm-Gg: AeBDiev0cfp/oSmLRubeXMiqLBPZ0uaosY9ns1uHoUkGWZXg2hzW11V0605hWEddNNR
	2C6RQ20crb65rYKpw2GmxbPY1AI7qsd8u/0o4bHOXdtaL9weLEvjRYxTbUhZZwZRmUchZSFqM9Y
	OxdFuSr+ZerZlUEUKXL/OSLUq6Y5EupjkDHmYhOPW32aJPJ9wrhulAARqXF2kIFxt0S8oJTPJBs
	tHX+Yten3Fk87HHN2z9w/QnPYFzgK9Z57wtU56LcHTkvaTUw/SxgIO8TJzNOqsokYe8AuToKhNd
	1PjV8BiUOMeZTp9VEMh96+5ayzccI9Fyyjz5sfwZhUkAgRhWQ4736HpCFaQFe2IbRt7SzsXfMt9
	iki8eaXS94MJW37ifNkG1VSKg5+wJm7xK2cm8iVBkSnIEe9BdUHDDysz+i/SXR4fLCdGNLpsQl0
	0ekIh/nsOiydY3opnwe3RaG6eWS9ZQGQ==
X-Received: by 2002:a05:600c:1907:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-489201cdf13mr58952175e9.12.1776720992169;
        Mon, 20 Apr 2026 14:36:32 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:36:31 -0700 (PDT)
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
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v5 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Mon, 20 Apr 2026 22:30:00 +0100
Message-ID: <20260420213529.1645560-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420213529.1645560-1-l.scorcia@gmail.com>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the currently supported bindings for the MT6392 PMIC. Its MFD driver
does not use the compatible property to bind the regulator driver, so
don't mark it as required.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../bindings/mfd/mediatek,mt6397.yaml         | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 05c121b0cb3d..2866e95e338b 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -40,6 +40,10 @@ properties:
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6392
+          - const: mediatek,mt6323
       - items:
           - enum:
               - mediatek,mt6366
@@ -68,6 +72,10 @@ properties:
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
               - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6323-rtc
           - items:
               - enum:
                   - mediatek,mt6366-rtc
@@ -99,9 +107,6 @@ properties:
                   - mediatek,mt6366-regulator
               - const: mediatek,mt6358-regulator
 
-    required:
-      - compatible
-
   adc:
     type: object
     $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
@@ -231,6 +236,22 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6392
+    then:
+      properties:
+        regulators:
+          $ref: /schemas/regulator/mediatek,mt6392-regulator.yaml
+    else:
+      properties:
+        regulators:
+          required:
+            - compatible
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.43.0

