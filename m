Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD03ECBD6
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398952; cv=none; b=YHYjbH6f0JbVxOy9QHvI8OvuCSi4DCnCnjdM+WDZpaboVMFpi84am+UpbxQynyIgnPqUEBQ5CwMWyww7QClB2YJs7BzSRSkvhsJdOOFuh8Bw8NWQLt9f1iizHGdsoDXSHn2KQ8auCvjb93wvx5+DuhA2ZoqDl+EU/If5DsQFTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398952; c=relaxed/simple;
	bh=ZD4nCU1fSikM66x2BzXQDLAPQ/aKlesSciJTloOavOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdiN4ESQlWAPWpm0CUbX/4cVJ3fOpsizgXZg+vgMrry08VHY1sw8xN6p0jloDXKXlN/P+ZDxBwiAidn1ikiwD/KcWjErnxZCOlwTPtHyu2W9cjEd9yhggk0ju5v4ff/t0y6Eb6WkoJ2uUId6tORZKjlqgA7KpUMvMLHzPdbyOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy7D5/aQ; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy7D5/aQ"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4362507f396so1720236f8f.0
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2026 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398951; x=1771003751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldMiDngjdctc31b6FkPkpahyZfqyaKMT07cTU/t7Dek=;
        b=Cy7D5/aQupv5AV5sGVzbXgiWPDUKQdVEG/s08X0cnPsWi+6PDhgG9zrHBYgl08m1MG
         KOpiuSzIX4jbcsIyDOO8KFbF/5YtzOySAKBtIiHWpWpX4XQx4ZrVjNmBsGT2mZdjcbMo
         Bpve2d29FSTOwpJZS652z/r9RF9N00hsitOwKfJQjQe21yW21Fn4vXUIidYGThSWwycP
         r+RMMiuFKJD8OxFgi4IwcW2CeRlIbftsnEjYOgSE9iJU5g7bFooVBz+qGJe+Hd20iyjR
         5EDcxKLc7ycoyJ/sF8ZInPC74bvbsWLl90UbVQv2ynAvtMxjJYD3ivJ4HCABea5H64dp
         2CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398951; x=1771003751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldMiDngjdctc31b6FkPkpahyZfqyaKMT07cTU/t7Dek=;
        b=IcFIcUs1UdC0hUyWQarNwp7nbGq59exDGzOgji1E9hVqOedgBsOJsd+W9uzH8GwR/L
         qtc7f2fyl26EnQCdS+UkwDHOz4hdRLiP4UBUcoEGZNStuWrH48gpI4CeZIvk9RPTL38F
         WlPZjDR8CJ0bRAT3M4uUpeTIs5EOCDj4MySpQMGCXkPykMYylDxi5Kw8ITUg61QQp/sA
         eYBToiiJeZ6zpVE2rtAFKcqFA69tjK6+HHfnEBy5p5K/7g/GKlnYLhBcv382HARjhqN8
         oZfe/IjNHq/CucFvzmdGW/qWBsQ9w32CTxqev56nsdfjLhRfTzDlKbxVNGvYBV7J/n6M
         tiww==
X-Forwarded-Encrypted: i=1; AJvYcCUTcqLrT112N3MLM5eVsSm9ebGgOOW+xJtJUFOUDFJvFiIg8HlDXGiUFkqiNQeZb/OfxolDE6z8oLS15Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKauiFDWDuydX+zefa04oBhSL7MYbRTIeXU3eRVckxaVwA/9a
	BVTAeMd6aqpH7bTsdDjKxy2GrRggdyQI9AlKICvaPNenjZdXtPJQOJVK
X-Gm-Gg: AZuq6aJv0SXKrwhUF4SQM2jBfw/d29CC7jOsKMOrwLloiBZK/i0gude60DZL8JI0rqO
	e3PtJqPLt6kc+PTN0a5G3lr3/eAYnGaQ8VWW/iWrizSyEMe04f79dW9N48EntiyIC8sVDAegMDa
	OzaMfyeBrMCDUpB1CnrmvfgLn+xqatL5+u2JHRKaeip/q9em0lTgoaSTR2I6vNYmOc1gAN3vV34
	tkH5nfNbr+dcPqVUaC8vuaa+0vITR/+9+8Gz27+Qfm2UTA37trxPUL1sUxpp7Jd1TJzPyTq8bVU
	9qQbi5lQFmcZwy0L/xUs8ki7jMHVTloSzrOF3Sx8IT+lWBpSRucvDcVVZt48iqD3m2UmUhmKG85
	mJwqLnGh5EkNbm8rweMohwHETOFVflxwzRoYRrVOrEPSJ5Lsp2528y5M5cSLaORBPVd0IL86TAK
	8Y
X-Received: by 2002:a05:6000:2307:b0:435:a9c9:159 with SMTP id ffacd0b85a97d-436293411e4mr5376216f8f.18.1770398950486;
        Fri, 06 Feb 2026 09:29:10 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 02/11] dt-bindings: regulator: cpcap-regulator: document Mot regulator
Date: Fri,  6 Feb 2026 19:28:36 +0200
Message-ID: <20260206172845.145407-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document regulator composition used by the CPCAP of Tegra20 Mot board,
that is a base for Atrix 4G and Droid X2.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/regulator/motorola,cpcap-regulator.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
index 50bc57f06b51..b73d32a86904 100644
--- a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
@@ -20,6 +20,7 @@ properties:
     enum:
       - motorola,cpcap-regulator
       - motorola,mapphone-cpcap-regulator
+      - motorola,mot-cpcap-regulator
       - motorola,xoom-cpcap-regulator
 
   regulators:
-- 
2.51.0

