Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460012F1FFE
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164882; cv=none; b=ptYIgDqGMwGiYWoBy73zOSr314DTKiXJV7VO5DounYJhU52/vLHLR38JtVb9vmoz7Wh9//F5RDB+n+btkFEibhs0O3QQ41bpdnhPAzuYGWuapLvYRjokQFynbYPVFo8YHyCZuYIbGXLWycoeX9wROghwweTFgNCHMaHn4BrRUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164882; c=relaxed/simple;
	bh=QvVbKrAD5Wgf21eGUmwt3ypQyzbGgDBdjEHq/9icVbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY9PijibGDkPHKOtEdq0icQJjvwj+HkKxeqVt5+4YKfslb2FKCqw15ijzxm4KjTF1cmap989DUgC82fjeerwKsXslu0UcifmIT5bz/X1PaM5v2JdsoSMQp3oM++nWL5zvghBH0pS3JrGeMGBvLtnW/QTqImYFAQxOYgkzF408f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+kTCt5a; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+kTCt5a"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a3c6f587cso3148859a12.1
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 06:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164880; x=1771769680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8U65lYAphW8i9T2PRB9Y7sr8rY33HwbdHgvZPRhiiQ=;
        b=E+kTCt5a6cO0yw2UossFYrU9u2n6fQS88En7mhPAxPytNn4XTXImKlw6UK3+g4mm80
         0R6H6OuNOL9/NJbSavnC8/gIuHbODH8kQJuvR03iUrKw4NF2Z84YMIsXx4c1Z0WahFdd
         WwOaixTEYXxY9Ja7Hq3PaJYkNQLlQHJ6wYuoorJAlyo7iXzPSxn7BsEqHiOi9jG2jpLU
         EeuOgGDPbRcecmizPkozShxDE+DeERka7P5Jo94DPm6/xj6S2uFB5QcCjCHbRm8qm5W4
         XsWPvPNtYo0ni2j3FEzLMFGSe+pcoRJu4upGQQ9MgnuqkpyYsVg5GzvJIfwK63YwTCxP
         YPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164880; x=1771769680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8U65lYAphW8i9T2PRB9Y7sr8rY33HwbdHgvZPRhiiQ=;
        b=no2q5lItPt8mgh+OQCq5PI+a20+lNWD0O5wH24X8nhCen3DMx20AgseWqmYbCUAlyk
         NcT34u9K8zVdeJPKpxZgpgayTMDiMDUFExqlsbrQSbJot8AtZ+N3Y7BVMJxzFCyNa3xn
         gKkj8I3ReNeAhvTUK6qDCKU5qC6g4cKK3CHAEqQD7pq/1Eftve9HMU0Cmmqq2AK0hxrS
         hZOFu1g0fpjmlX0s5fORzHm36GZutUl91qXq8I0dFnFwAW1sAu4B9KsPJnz6poWSFqa0
         YoZTdebge/kzcHlkPBPgGcSnR8UlgdQsO7vOeZwgIoChqzPNHtYNKhSCRxX/dR1HImp6
         PiUg==
X-Forwarded-Encrypted: i=1; AJvYcCWIsbNAEQP62mlj59gbhVQ3YCHqIaGt91EDXFy2Zv7F9o96qWuzaqh3WXkREu98rr5Y9K8LxQa28fYO+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrf0S4e8PG1Y1g8LFPPiD3+muVdbi1NQtzhEMQy5+/KRv9zAwH
	Jl7LtKdcP7NKcb4by5FhFkCFrOOMlCm3g3f9rJRcvcBY/yYKa1BxxRVP
X-Gm-Gg: AZuq6aIlmqSXKnsNXJH5ltoAe0nVRvrkWHHOw4gnarU85i1uVwLawcw/1wusoMJNTsJ
	Dysas9UJ/ONNnpIqgo7KdzetR3hXtBWbby3adFtlG3au15PoYg9g27Po3gq15Of6E9Puo+6QLX1
	wdSVfgCBS8+Sa1poYB97dsczNMG+uIGjDQ7Xo6NQzfJvpiKWw482ErcuK1engaC3ipf+gJXTFGz
	KcAs9qObPvZC0M6hn1AnRoRMJJtbghKufMZNABMMdHyi5RvNb+loRfiwCKtDdaFVZ0264eDfXcF
	SMiTzZ1TmsPmCpQwqa1Q8T6F8rF41SeFxwCxyg3vzhk61h+jjVFimBhdVtLU3efx08f03NZZ+vE
	FguoW5J1MLUMkupmgq1i6nV5oDlX0mHhUXBNRoK8NPt1QxPOGbwcQZalgIUtImcwSKv4N+/xOPW
	Jwgtln+z38lEL5AA==
X-Received: by 2002:a05:6402:280d:b0:659:3f74:c90d with SMTP id 4fb4d7f45d1cf-65bb10f494fmr4125189a12.3.1771164879665;
        Sun, 15 Feb 2026 06:14:39 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29df12sm1518889a12.14.2026.02.15.06.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:14:39 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 3/5] input: drv260x: Add support for ACPI-enumerated devices
Date: Sun, 15 Feb 2026 16:14:33 +0200
Message-ID: <20260215141435.727872-4-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215141435.727872-1-jekhor@gmail.com>
References: <20260215141435.727872-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI ids and GPIO lookup mapping for drv2604 haptics device.
Found in Lenovo Yoga Book YB1-X91L tablet.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index c352ff2859e2..c4dd410c303e 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -7,6 +7,7 @@
  * Copyright:   (C) 2014 Texas Instruments, Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -606,6 +607,14 @@ static const struct i2c_device_id drv260x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, drv260x_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id drv260x_acpi_match[] = {
+	{ "DRV2604", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, drv260x_acpi_match);
+#endif
+
 static const struct of_device_id drv260x_of_match[] = {
 	{ .compatible = "ti,drv2604", },
 	{ .compatible = "ti,drv2604l", },
@@ -621,6 +630,7 @@ static struct i2c_driver drv260x_driver = {
 		.name	= "drv260x-haptics",
 		.of_match_table = drv260x_of_match,
 		.pm	= pm_sleep_ptr(&drv260x_pm_ops),
+		.acpi_match_table = ACPI_PTR(drv260x_acpi_match),
 	},
 	.id_table = drv260x_id,
 };
-- 
2.51.0

