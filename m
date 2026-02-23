Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FA3EBF20
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867041; cv=none; b=CqfeXKYeY+PvoYbc7gEHEgDr33zUQKjbE/0BXMr8iiCnV0jH6TRc7r4cMnJs0oQLvFn5sCsmS+jWOJ0gHrt2CqLt/DDKe0X8eeaLF2/++yyNbOHXU8PdtXIsL4WUo8eGjfKDCLxYU/y9/N4ciy2jBCfmxbgXY3pKXv5nCmUN508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867041; c=relaxed/simple;
	bh=vJOr9ewXibzfb3H7LhY3fT3XdYMp+tyABiqtgW4H+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtHpSfmtjoCMACZSERkAwL/oT1GVoD6g5Ti+OFoN2rWGOOWk3grsdJLWTSxkofaCNwRbyrY1QgHbb8ddjRtgQCfX6BrQN6fly1qul78wcbxIJ2iWKl4i2qmIG+oXh/ieYUaC+UVnErVYLJN6vX0hwZVzLu8/gGYWUaFE5IIbqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQCdL8TH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQCdL8TH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4362507f0feso2846389f8f.0
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867039; x=1772471839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jf6/GdPMgEPudu5Ub5QM0YH/lbZT9UmvVkra65sIm8=;
        b=LQCdL8THtSx20n8arg5+THT/3yXUfYGFN36M5mv1CHRiBfcBnnBjKsWzt4KZ/l8hEl
         JUBVirKsXyYSKp1S+8qa/+evoRTaUkN4/w2zRwmt1aNHsD246HV8cayjJgc4XNX0KNeM
         y1lpNSa4kI5Yr4j3/hE/ASnQ3nTp1WYeh1PSxnPEaYoTPZPXtToJhZitCw1Ltok0ptbf
         ZmyU3EBdFzgF4plaEDrPss3CLBfGUwmqsAbA0DsAkFHdQLIu5Q/Ok3XYb7kojUNY72w/
         yof8bTbhrUDAwOgb0tu2mLVhpWxPx0ek/jALUw50aOCBSlziykHhiwsGb/mUtU7U7d8E
         xaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867039; x=1772471839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jf6/GdPMgEPudu5Ub5QM0YH/lbZT9UmvVkra65sIm8=;
        b=gM57y+sR9Sspw5wtWmb9EYZR64a11dQsWMPzjlWQXweDuTUyym/TYSDlWQWlylMi/r
         i/kPmePfD76+IDedsIjBNSWDTselW9Dnsq5CQXSBPqBNlpUD7R6svRrXxTSljKsCcjqY
         cfrI1HM00QCFL2Uf4e3GWsYyQiH96WC4rufwxH5B+P6Pw18Mb22m2qL8Bw1q/muJuiLx
         96HS2fJ9oN13fIJ9F4yfEfX+RZTxScZ8qZAsjghtRUC+IIebv3bOmhL1OcsbWrA0n/fF
         bDew9sEPwGRpg9wiApfZJgdqo3FXJk25Po2bCcyBNztB067En2TFjV0zxyu3Fdtg2gAn
         5PFA==
X-Forwarded-Encrypted: i=1; AJvYcCXspQSNbchKpznLTrEyPKrnKfOMNtbRZAEnYRd+bsd3x70NJyVXHtpMTQbnmSHE5nQ/HSh28osR6FeMDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0e7nhRRsAEYNcQds0NSGhsiVHpnHLgZMpNCTJDxOH/7HuLZV
	L3PZcHSBmVU2H2oZA5SLxvaE4hjuPs7ZCNfaaheznUYePTkwg32Lkf0H
X-Gm-Gg: ATEYQzxCtd0AVNqXlE6KrazskWUkCbV33IQvZt1PZMXX/9ikg2hTD6zcRrVhLGJHIsC
	uuOc5Cs5K235/WhmAo3GV89vOwv8YdziCnLevF5iq0lYCnr8ePiFScdZNodJN+TYRJyOXQy+1+V
	cxcu6mJadzVBZo8Iq1D0nSMvA5+Ar+vNOU6Eq4HKmwWc+dhcux/gAsF26mtXT9Bhk53MHVZYJBw
	XwsCs4JQNGsDLRn7WUh1sTbUksPBawY8/7sfCjxgycwJ0lw61dN78rirGtWKo+7dFQrCOrx1Vp5
	TIXmOyZR0VryIkcNw0o1AeFKlK0Q/vLaMkqLOkKML6Y0GX1YgLN30wPdxbWIYxbNFcjjUoBjnPY
	hUS9lNwzBeSPlNOroawpCfZqZTANh8TYcGNe0482A4XRe03Usj9l19e1rlT2JPmTG0wwBxDGPmj
	e5Py2rN7p4dGyKrelFyo7t3mJTkqewug==
X-Received: by 2002:a05:6000:604:b0:435:97f6:4f44 with SMTP id ffacd0b85a97d-4396f1a97fcmr18768298f8f.56.1771867038655;
        Mon, 23 Feb 2026 09:17:18 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:18 -0800 (PST)
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
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date: Mon, 23 Feb 2026 17:12:40 +0000
Message-ID: <c5ce038359583c5318c2d5ee341287c213aef880.1771865015.git.l.scorcia@gmail.com>
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

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10f..5f422d311d4d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt6328
           - mediatek,mt6358
           - mediatek,mt6359
+          - mediatek,mt6392
           - mediatek,mt6397
       - items:
           - enum:
@@ -67,6 +68,7 @@ properties:
               - mediatek,mt6323-rtc
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
+              - mediatek,mt6392-rtc
               - mediatek,mt6397-rtc
           - items:
               - enum:
-- 
2.43.0

