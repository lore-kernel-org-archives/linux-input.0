Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBD27A92E
	for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806895; cv=none; b=SzAqClxDPrfsh5vQ/Hk82786/i2AcZ1owJQxDR5bqnwtiLeoBvwHUEG1XnOgVGkPt+hwxNvOzsKaVS91iGt51nsC/bfKAu2egsfHWebV4hv5X1oH+7Oed//LdjLVEuqT7GijLegSvZAvg56Bi1Gs9SprVsqlrF/Zrm8yIeN/MqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806895; c=relaxed/simple;
	bh=iqZX0/TRSHfgUjulIdxb4Pd+WpIveqARBNv2GxyOCAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aD5A67OnxXCAecUzCH8r1zg5KSwcj4U/ZbhQ7JjvP5oZrrX7AaVlFgtADGE2SKLVy8khpfLJ/YvXNCrs8XBGxwj6nlR8YEvGo/JGmmWbZGXbMJg2qYHgKVRPX5wwdvDRj3y4/L6oe7yJV0IU1Q/rQsxRIp12JThmoNuZ1jnl3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsX2Wjgj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsX2Wjgj"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cd9d0eceaso1318198b3a.3
        for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775806894; x=1776411694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BemY7WRMa1cIfLN6axREvNehDlvntpxNYlDaVMWv8XU=;
        b=BsX2WjgjThwsAc9Y2l/KZ7tywfdM1pydvnASz/8WmVVEQmF5hz+SFqwYzRPr8HNb/v
         R8LPF6k+ydWWIB8U2G/WbYoyprpNafR1Prl1vNr1kKfYaHOEWyYmrjVyQca7a+bX92Nq
         hP8xpqFPFyxOsku7TDQ6lVKLw704MTn9KGEn7a6HVCPlM4GYZ5K61fafW419hfhQ1C7/
         t4P4XaeEoLstXS33bRqPBdFGqMtomTe2npa71hsDd9Q9sPclEB9TmrDDf/+Zx/ewg5MK
         UG7JWQ4qIetsJXakF4whx451HfOY14xIoAUgdUrHKDOONvBKNwp7HBSF1zItqjr+nQ6N
         yceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806894; x=1776411694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BemY7WRMa1cIfLN6axREvNehDlvntpxNYlDaVMWv8XU=;
        b=jugP+oWmc8aM0HGIY6Q5kVz49+e9XKd8PrLnIxnJ/iISrPZxrjQyflAdLDMUu5faZ0
         b089GIRbnmVFlrrJyLqH6vJiTxewr4cEhuBCmykPerlmJKF1ZYlcfWUDwAndjDF9jhOY
         5wYtO+nf5k5c64aArh7iBDrrZVzzjhcK52YfWcwtuSklavADNPUV7mltvHHzQAYyj8Ne
         kxQqmC/2q2ULhdsMBvD3Q1nZFbq9lOoRWRXWx93EUZL6bqS0FrM8cpsOwwSsN+tKaWiK
         mXObBfhQGYNZgYOmy6hVusCSbytNFWOrILb8wuyBaOrcSkMAN82BWXuYKDHUGzeYpanq
         mKZA==
X-Forwarded-Encrypted: i=1; AJvYcCVOEIr6Cj3x/C1n+dG4To1Ewbq1BBX0MNJD6ea8PjeFvGi1v5O6tf3jDwi5h+OgDLKRICcTcz4HGO6QPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+iSly9GS+40QEAWnShfX+PpkjIYGFzxkMT5/QHKbeC9qaLd0
	Nsjttdp+kXCt4sYqXzEC3ZuIaK14CefOJxMlX4WCN+KZMSMlK7l9T1bn
X-Gm-Gg: AeBDieu7o2asCObwCx/OsSt4yswvSxhsP1h8CGWpGV0b2HDfepYI8OO+HXVg0tmwV9r
	Js3fNL/lw+f9RG9q2MwZzj33dWkaGD1xuMBsZ9u02cBgxIl5RqQ5olprp2ymg1+xLTBVFURSDkY
	aiv+k3pvi+XSN8IjLBXe+n7nU79q/KukK9DGcZ8QpjM7JVttmAFCmXIBZUTQM9sp1yuBAUKstgI
	Ma/kjj9AOSBsDRGVBCQuZHiP1h14FKHFvy3eTcXAPJMBr00DFeTqxG9nKxCkoWvLKU9BTc8xpFb
	BYAI+Oc6SD+T0IJSiLChio1XsW+kOIAvBfzHsvw0nOcfLydKeMxesd5sqYaAOJgPo0UCmgpsxH6
	GMQcKepvvPxu8DrXAjXX/qvx1sK8dRDDHAWGvt0hnkN2ooFdcGuzH3UPGEVbmXJAJm2+8Vf39qC
	5anl35WknjbbQIacD0jaS3YPvLAc1nOo1Yz/z2KBUvovvr/r+dvzvYyZNmIjmwqshVq0DXSH0iD
	m3zt71KgNypHVUwH+CbQ+AxiD1k5WhE
X-Received: by 2002:a05:6a00:1d96:b0:82c:7335:4f71 with SMTP id d2e1a72fcca58-82f0c2c86f4mr2402293b3a.36.1775806893747;
        Fri, 10 Apr 2026 00:41:33 -0700 (PDT)
Received: from isd22-5290.dc-ishida.ishida.co.jp (softbank126249023098.biz.bbtec.net. [126.249.23.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50d874sm1805294b3a.59.2026.04.10.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 00:41:33 -0700 (PDT)
From: Yuki Horii <yuuki198708@gmail.com>
X-Google-Original-From: Yuki Horii <horiiyuk@ishida.co.jp>
To: dmitry.torokhov@gmail.com
Cc: clamor95@gmail.com,
	johannes.kirchmair@skidata.com,
	linux-input@vger.kernel.org,
	yuuki198708@gmail.com
Subject: [PATCH] Input: touchscreen: tsc2007: Reduce I2C transactions for Z2 read
Date: Fri, 10 Apr 2026 16:41:00 +0900
Message-ID: <20260410074100.1660-1-horiiyuk@ishida.co.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuki Horii <yuuki198708@gmail.com>

The current implementation sends a separate power-down command
after reading the Z2 value, resulting in an extra I2C
transaction per measurement cycle.

The TSC2007 command byte contains a 2-bit power-down mode
selection field. By selecting the power-down state in the Z2
measurement command, the device powers down after the Z2 A/D
conversion completes, eliminating the subsequent power-down
transaction.

This reduces the number of I2C transactions by one per touch
measurement cycle, decreasing I2C bus overhead and improving
touch sampling performance.

Signed-off-by: Yuki Horii <yuuki198708@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 948935de894b..ff60245baa96 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -61,10 +61,8 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
 
 	/* turn y+ off, x- on; we'll use formula #1 */
 	tc->z1 = tsc2007_xfer(tsc, READ_Z1);
-	tc->z2 = tsc2007_xfer(tsc, READ_Z2);
-
-	/* Prepare for next touch reading - power down ADC, enable PENIRQ */
-	tsc2007_xfer(tsc, PWRDOWN);
+	/* Read Z2 and power down ADC after A/D conversion, enable PENIRQ */
+	tc->z2 = tsc2007_xfer(tsc, (TSC2007_POWER_OFF_IRQ_EN | TSC2007_MEASURE_Z2));
 }
 
 u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)
-- 
2.51.0

