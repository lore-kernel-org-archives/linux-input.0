Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F0393DF6
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054079; cv=none; b=QDrSLOkim/HBjxti85lhaSU9NF55s/SchbYSW0Aw7fa2kGiMj+wyw3bg5IMdDc8WjJ9UTPb5h2gGiywLODJq2CUuCpG+IgYSsyYB/Kqb+HIOHEBk/EUqnA11zZHOxYut8fBORrI1d2DM6IDqc58Ri8cZEs+UjyUisnYffbY02Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054079; c=relaxed/simple;
	bh=M4dFRmrmPmhqXhKhFaGDOffAf2JzsWF1o/D8Jy2z8eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVYNdn+8MZLRfQf9kc3ADQbzZAukgpo/FljKIE9Tdb9UeE6DTG8AY/5jyJ/rHJGDiAi5ErSqw53L2CuRTNmTUgbbKo43mlUGm2vjy6yF7ITvct/dWHFdtPw8zctMeREWLHFby5HlFD/te+WuKdorbEuK2bpVcSXSPGeis2dD33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amjMW2xf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amjMW2xf"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35980423087so4081178a91.3
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773054076; x=1773658876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrsLA8b8vlkhz1DvrsNbbbbTjquCC3GRn0AkHrSsHTM=;
        b=amjMW2xfOCp3KzpmNL9W4+Y27T55Fq4Wee5NpsadSenhrmY2i49oYAEmk6ZoNu95h0
         W9F5HMQEyfPcUQcTR0dyqWfUTCXVBqtX7mxH9MOjiYfPmc+eqlqIXnGVBQryWCrG4siP
         PiC5sgPOfgqxEluXuBNs3Mc5EfBeK9701nHa2VW0PV75wotpjZlcFugsEwdyMIgpUz/D
         fhK9R3j+pIK0HqNvfC7YDXw3/re+Pnw+ozGwrPJ8qbOt4LUh+5f2LbWYaQAo75u1k+yE
         NN8UpKxGfnUzswspqGy5+a0ThZ88YyoW7fBEURsJkDnRuWF8P9Ny5DJeX8qhmdN2VvBo
         d5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054076; x=1773658876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrsLA8b8vlkhz1DvrsNbbbbTjquCC3GRn0AkHrSsHTM=;
        b=Isn7uSDatzYavxaWFYUjl3FoRsPLaqgZHy4oVA4i4o51g+Duns9JvRe2iOmSJkMaYw
         ZHuOoNJfwfkKjFSyRMX/Bpg24PG/EkPHUTHAS6GVC/JDbDsPIh6eJFWsBL+72/czM356
         8FIuqZhfsuYmivNbhGba8l9goI0vuokSRnGAHvnUhbI0FqEW1Wsh7WloGCh5/ywmF0I6
         +9mV1B6UgYc9byXNCiabjuJSylPpxYQGj4i7CKbi31auxFKbgcwHoRNlgEdoworJmQp/
         aYrD5Htctii4rOGuHVYg+EFwGi4C+RgVjv4/0x/L+clQ582bYgAclVL5xem0QZEpwsXg
         TJTw==
X-Forwarded-Encrypted: i=1; AJvYcCX3ah6bjZLyGZdcAQZnxCLfbcVWHh7joxi0ecqUUD1aeQPnrw1iLqDkcT0lE+fOhEGnZD4rgnAEevnkmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp6hixQk76bzn9tAqmlj+SUlliUgWogjfRIpO+Ls9UlhodDr0l
	blf79Ul9owMTZgdpqxeKkpKPx2k5eXAwzPFEsUBPIwO2vSE/AXSuspNA
X-Gm-Gg: ATEYQzyPyEDNSgpZwLlyfSBDR3FoRoyohhsmypoqX9QueUK3mbZROIBP5+OYv15Jdur
	9txOx9JVYi5gOPUtZwBnNI0A9SjejptaACUxlwWZ5zL0CzisnLsi3UzNhe+BoHTgpZpCAqYNrwU
	Tlv3v1wo0xT/1qpmLjwj3judsTPX5kb7pPgLla8yxlJPODIkOsSy47CABIu0kJ/X2Ker5EPJWf3
	7oi+7OF5+0eE2yvR80GXiABDycZXDSLxcHFAz88jVRjd8bDrP9kcDxFfQl9Ni2jkQBBjNKe+Kg+
	OYXml6jjhV1xBc7MlJHER01/8v4UoEUztuhf3JJVEpyJL+w7RjfSKQfYwllujtUniTH3RP+hvqr
	q7qlyIoTd7Fz/SsPL1k6tWjQJ4rzrk4qY7l9K9aBwHoPmrSgyIzlj9b9Rowxbp3fuurgF++efsy
	KZn+F0XIchDoseLZaOdo6gQzRNWLVrEHu2XGqhCExHSrjJn1F7TS+/wPBK9w==
X-Received: by 2002:a17:90b:2884:b0:359:87ff:f352 with SMTP id 98e67ed59e1d1-359be250d8emr9942768a91.8.1773054076002;
        Mon, 09 Mar 2026 04:01:16 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bff279f4sm13268296a91.0.2026.03.09.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:01:15 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Michael Welling <mwelling@ieee.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phucduc.bui@gmail.com
Subject: [PATCH 2/2] Input: Touchscreen: tsc200x - delegate wakeup IRQ management to I2C core
Date: Mon,  9 Mar 2026 18:00:44 +0700
Message-ID: <20260309110045.108209-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309110045.108209-1-phucduc.bui@gmail.com>
References: <20260309110045.108209-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The tsc200x driver supports both I2C (tsc2004) and SPI (tsc2005)
 interfaces.
Currently, the driver attempts to manually manage the wakeup interrupt by
calling enable_irq_wake() and disable_irq_wake() during suspend and resume.

However, for I2C devices, the I2C core already automatically handles the
wakeup source initialization and IRQ management if the "wakeup-source"
property is present in the device tree. Manually managing it again in the
driver is redundant and can lead to unbalanced IRQ wake reference counts.

Clean up the wakeup IRQ handling by checking the bus type:
- For I2C (BUS_I2C): Rely entirely on the I2C core for wakeup management.
- For SPI (BUS_SPI): Explicitly call device_init_wakeup() in probe and
  manually manage enable/disable_irq_wake() during suspend/resume.

The ts->wake_irq_enabled flag is also updated accordingly to ensure the
driver accurately tracks the wakeup state across both buses.

Note: This patch is based on code analysis of the I2C subsystem and
has not been verified on actual hardware yet.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/input/touchscreen/tsc200x-core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index eba53613b005..d14d967845c8 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -465,6 +465,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 	ts->idev = input_dev;
 	ts->regmap = regmap;
 	ts->tsc200x_cmd = tsc200x_cmd;
+	ts->bustype = tsc_id->bustype;
 
 	error = device_property_read_u32(dev, "ti,x-plate-ohms", &x_plate_ohm);
 	ts->x_plate_ohm = error ? TSC200X_DEF_RESISTOR : x_plate_ohm;
@@ -547,8 +548,9 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		return error;
 	}
 
-	device_init_wakeup(dev,
-			   device_property_read_bool(dev, "wakeup-source"));
+	if (ts->bustype == BUS_SPI)
+		device_init_wakeup(dev,
+				 device_property_read_bool(dev, "wakeup-source"));
 
 	return 0;
 }
@@ -565,8 +567,13 @@ static int tsc200x_suspend(struct device *dev)
 
 	ts->suspended = true;
 
-	if (device_may_wakeup(dev))
-		ts->wake_irq_enabled = enable_irq_wake(ts->irq) == 0;
+	if (device_may_wakeup(dev)) {
+		if (ts->bustype == BUS_SPI)
+			ts->wake_irq_enabled = enable_irq_wake(ts->irq) == 0;
+		else
+			ts->wake_irq_enabled = true;
+	} else
+		ts->wake_irq_enabled = false;
 
 	return 0;
 }
@@ -578,7 +585,8 @@ static int tsc200x_resume(struct device *dev)
 	guard(mutex)(&ts->mutex);
 
 	if (ts->wake_irq_enabled) {
-		disable_irq_wake(ts->irq);
+		if (ts->bustype == BUS_SPI)
+			disable_irq_wake(ts->irq);
 		ts->wake_irq_enabled = false;
 	}
 
-- 
2.43.0

