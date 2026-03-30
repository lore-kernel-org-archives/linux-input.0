Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8B39E191
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859702; cv=none; b=gmehzDBprbIdIbne7NK0teKpxayAMWYQw8saqHis+jc8Nfe75WNzDhzC2rQD88zvuP0TbBLRWXUuXu7hscBZEgm4GZqM/2BRNIKH9ttPXwzDF0ay9RbdtyZVCEpSuyzVPrAPftblQiPT4ua+oYZ69s0MzszSMavtb1hfTc1K47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859702; c=relaxed/simple;
	bh=FU2BsRVbMrWT6qiM2syqQWN6DWesWvrlwberUpLr0fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMz2Jp1NgnazigJTJ7rMrpvVs+jB15KUX30Q+/5oZHEW+WMsAq7Z5Zv4WrneR+oL3d0m2j+S0Hn9MgRvCm7OQ7khS7DuM/preHDddnMvCngASeHsy6BuFNzVSA8A2W00DL3h3FQFPUoBK7uHuS55FkkflE0CL8WFnHTd5mewjWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+dgDGln; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+dgDGln"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so40955525e9.3
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859698; x=1775464498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOsQBpsZfzg0bt0W5kexVa5Sj6fg8I/sbfWtcta/yXE=;
        b=Y+dgDGln1750vZomOqURGjyIKmofKaL0nUFwnb3/XqxNvnnSFDk33oEbNEGE+33d1z
         3nCXkHrGWFRVMKEICzBlKBc6g6PY93L+PEK2G11Sb8qd3AxZ8AG4CgT8GFBG9zRmqonz
         AEoL9UlWowIJvlZUSy3rX3uZULl1RRZuOB0g5M1Ko3zKsr5QtIPUIyJ9vfvIg8Jpel3k
         Kw0EHXffbvepmNdk/Oc0PH2BnnVfNa1LqJbMm78vZ8NHlQbqRMa2AslIRo54gYlcd2ip
         PfHBH7Du3Tsk78SzBx2sBJVuzkdCp7dFFnoj1jhakMo+TC0DV83hGZDES8zfw6FFlbnS
         wT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859698; x=1775464498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kOsQBpsZfzg0bt0W5kexVa5Sj6fg8I/sbfWtcta/yXE=;
        b=lueWEZxjLIO3CTy1VNxoHGAYJ/yJ3dFblgvwx2B2KGptXoYBTc5SF7m3ji3uDtvX8v
         pZgH74OqkZQCSRkdFRYlqS3vzgHTsEcVjU043t9fhyy99XpTNhEH01YPpKGaYW3rReOc
         X9yl5up6x0A9IHF7Bv8+uygvyzr/gVJOcgzLntMXW5RRUazAikDtyHss/cVg2MCXbbeI
         htVR13c6VdPKmO4QsDq1DdZMkotFl/n2ZHl6IangK0G5AFKXl1F5hch4TvgEEQLmB/Sb
         4FIwr+fvu4toYgNhZg1dwR3hDTRfWfsg/CgCDs4EAYd5VP3i/pricN8xjzgrRXWSYfjj
         ptNg==
X-Forwarded-Encrypted: i=1; AJvYcCWP9ZVdZykmmFpYOVW4ILZVqdYKPq4+S5N5Q+DMcRzyUe22HIq8FCFwvvFPiezO1c6TR7kmJ3S3hk1OxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKYpGSN6GMlRHHz3QzI866C1HAuJsytQUvnzJvbOOtsm+s2juo
	twqCHmulcwAWZ+nJGOD7RPMRrUBA/4+ZlC3pWpP58dh3eFF+445tSMk1
X-Gm-Gg: ATEYQzz3atWE6gFHCGuusqlXrc9CLA4rTaEf2fK1f4vb27faK4s8rzHh5rbOg2UF3Oi
	8FLisKopyL7b1uVpkvimSoiGCFyZfm+5Gkr4cqQgwSN0LFJBvYugIGtMAlaVdRVgrQjyHWLOii/
	kxh4K85JzpKejs59FTwujLG4G8SrlRqyp1ET1GecwASk2C0eKXeKCnJoZvBQqrnoBvKs+6Uuj/s
	P4iSyd4L4HNMcX42spnzYtySx43m/5+bCAfeisVhXrFNyQfXM0KMtFzcPj7QQur1+fJe403wAXH
	pLTrtKOFVmjQvjRBTd4oQo+YgfwUnd7R3yrJZFB6aa00bdAJhUnakcUwpGa43nNHay5TY6rJoaG
	E8bkt4+TPfAk8FoCyaHTWUiLYukTZYY/b4+mxvjrR2nYfcqH9QeoZRdorFmWV2Hipgd0pyNIHxV
	psWjGtYeEo+Ld5kSZ6OMAwDlKPPCo9DQ==
X-Received: by 2002:a05:600c:a30f:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-48727c81e54mr170906055e9.0.1774859697668;
        Mon, 30 Mar 2026 01:34:57 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm508329995e9.2.2026.03.30.01.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:34:57 -0700 (PDT)
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
Subject: [PATCH v4 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Mon, 30 Mar 2026 09:29:35 +0100
Message-ID: <20260330083429.359819-2-l.scorcia@gmail.com>
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

Add the currently supported bindings for the MT6392 PMIC. Remove the
required constraint for the regulators node compatible property to fix a
dtbs_check error.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 05c121b0cb3d..bfad018cfbf3 100644
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
-- 
2.43.0

