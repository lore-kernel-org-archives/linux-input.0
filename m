Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545905;
	b=MuE+9YhIuI5tRRUTHVxAc8NghCFEZyy4Rw2K2jXk3bXWrLwlwJ3Ln4GQIMBSDQSbN6/a
	 akJHjMToZzkWeSQ7QmIdyyt4wFkyrNKd8Hlrpi343LuubEjeY5u/Os3hpDQmYJ0+bjOEp
	 QLzYWCB9Al+V0mXwmtbPh8Sjvd2SX9ZEALYACOuAjfZkdVubCS/TZV6vi1yPqEifWBpFO
	 nVz/X6Y8pk9W+y92z4flBSsXAs/u2rtWtctjh0t38p1B3dwcTGx4qrrLuaE7fDZ4OOxJi
	 Faupvn7UJMkpiZspq/riPyGOezDbqX4how9ZUgv4PH8O/MVE1qn0fcndlTXUA/uj76w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/xyvAEwvMN0iiP6Jlc/d5ZkSXrVRKQJEBJk/cfnUL3M=;
	b=BFm0qE7V4QXSKfKm2Xa+rsDZcyU2HbNO0w4owY2Pq6TpAXAXL9DxxlorfMJvPYy6TPXd
	 4DTGX77LJ2duYKarIlhXRJ+KyYcGRohlDm7EAZ879jSKX22x0/MC1KVxTphDCY3nRQpUv
	 OiHxMa68EPcO9eZEeRKVbyzIJv+tgqJUmIxJf8Y8MX59qnwT0HvoIYobtNkv12YwisrJ2
	 txxbezNCPr1doN5TE1UcMdcyr/kKx26wv4grkwqRxznNW190oNtrPmiKdqQYDGgyB8w0B
	 nostXpWw1okZ7qekmx0jUOlfm4N4lqkzsKynISPfAweqeCOdWnyC7A0zFHVHMF2Gmqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tYt5ilcq;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AB606A32D
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 18:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A0AB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tYt5ilcq
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e30c26a4so1147223266b.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795545903; x=1796150703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/xyvAEwvMN0iiP6Jlc/d5ZkSXrVRKQJEBJk/cfnUL3M=;
        b=tYt5ilcqg//wnIk3FJLq4clqUBGR/FEshho30X05PLJvVCYQCMqEjUvJGCJ4EB3CCu
         2ukkOVkZTWHFIYfEpzH3H7vjhHjhIU1asLCEpZSaJONvo1cxRlmlCpTUUlgVFALHVCY+
         ags4lxK5QAKhGaeOHJWJ9cRhAJshDkOFvLh2zojX23DeUrspiqid9PyEj2dZB/gusHsm
         ttpsFRO3aBbHURubGja6g7cnOSLeVSwjLcLFzCyDnmzXmkZHJnjcZxEo3ECvGaxmbjAP
         rvb0o8Pp5S9NTJqf3/xdLpeNc0HaTUL05rNY73s0LcUULOibbIKaJxR9T16984D5pKp3
         ofiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795545903; x=1796150703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xyvAEwvMN0iiP6Jlc/d5ZkSXrVRKQJEBJk/cfnUL3M=;
        b=iup6UkoGF4MQkxEFPoZ+XkkFJZTL3ynCdi+xXZNLpPVpH2g1X+ivxB0SD/SwOyVffT
         NELV6C8pbQ2qsZdoqDi7KWSsNpzJ9xVfulV7tsFElFmyktohKwtWeyX2M82h8MAnFods
         xahVYWOIgEUKIREgY4giZz0kjRgP7O7Q3Ue6oc38cmMNHY61c52s0SV3WTQgVLrFEkn2
         /WXIkz7/uXPrbP1XjofmBhkSUY+9dm++5A3kru8R6u4LraGseA5LYsuhhq8VV45kOGCq
         FvStGudnlQxPXTPAZuFmnSNUgyKgCcTTWsrrbgnCncYnKZYLZkVkDXTihaVT3jCIMsBq
         3GNw==
X-Gm-Message-State: APuU4Z+sdM92EebuGvNqsnRWOn9Rj9rE4S866RB6giAdXgA7/KtrXsVh
	KzmSXn2BjIJi9+CWDtLG8MTjhSZmUMG4RfFNICMX8vgDXKI91mvrldt07csW+zUg
X-Gm-Gg: AZFdTZeWgQi+cEhKDO/RrqhiZHyw5hp9byRBrRPttrwPuVB5SLYr90bTBnRGVEi+PdR
	kOgnfpWz0MK39h2qp0bcAKX+cqSifyjPrFX9k/x4wJFLKQfM0D9yFaik0kaXxXN17KdpNiAmlpa
	LTdawqLHoGI2vvQVE9ViZbR7NPpeIn99bq4ALj+scGaxPO8Do2RfezJJsPitbarylUo/oRjJ7DK
	n1t8rfqo9jxzBJMHzNzDQsDEijB2eJFW9d5chjEBIoyHMSPmOqM0gOOrf0ZMfJiEftWD6EgLI7M
	UHIfUtqqUCQ0wjAj1H33+YUtNy6plAQg70s9YclgxLbDzfMh3ChqvBKkPRKg7hSH/sPU0U0wFjO
	FPa8GVsPa5asC7N5qZyQBl5Z7yCnJKpY+0p6gUtpbE3oZhI2QLSejIkcHerbiLatjcy/7kKGCjL
	sRcox1buJdDrUAi56uOiaI5y/7h7oyCTV5Qoi8gAey2FoTV0IROGe40B1lIiRT16YQC7qHiTvS3
	OVWjRVcSU6FjixZhkCm0UXK55vqlUhJ3+lurrkUo/DCYsprKQrFgKdcHeG97utNC2n5JuLDCevs
	rUniS0CIzqi/yBvjxlrynQcSZSjoFA7eUt4zdcleLP5EO/youBDGlYojtZTJ5Oyk+ZQCtJHNaR3
	d1J4d1o7KkPZqXTxsGMeltsKtJ2bnfXnjIh8TV950M8c=
X-Received: by 2002:a17:907:3dac:b0:c51:9b3f:454 with SMTP id a640c23a62f3a-c519b3f096bmr163841566b.18.1795545902780;
        Tue, 24 Nov 2026 10:45:02 -0800 (PST)
Received: from localhost.localdomain (78-82-127-150.customers.ownit.se. [78.82.127.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01b0bsm546812066b.10.2026.11.24.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:45:02 -0800 (PST)
From: Pooyan Azad <pooyan.azadparvar@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	robh@kernel.org,
	jeffrey.lin@rad-ic.com
Subject: [PATCH] Input: raydium_i2c_ts - preserve bootloader mode after firmware update
Date: Tue, 24 Nov 2026 19:41:58 +0100
Message-Id: <20261124184158.50142-1-pooyan.azadparvar@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialization can succeed in bootloader mode. The firmware update
path then forces main mode and reports success, so the IRQ handler
can try to process touch reports without valid report parameters.
Devices that first probed in bootloader mode still have a zero contact
size in this case.

Keep the mode detected during initialization. If the controller is
still in bootloader mode, return -EIO so userspace sees the update
failure and the device remains available for recovery.

Fixes: 48a2b783483b ("Input: add Raydium I2C touchscreen driver")
Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/3e575d6e2eb90d4a3707319d37134c1a@gmail.com/
Signed-off-by: Pooyan Azad <pooyan.azadparvar@gmail.com>
---
Codex helped implement the post-update mode check and draft the
changelog. The driver object built with W=1 on x86-64 with this patch
applied on its own. A userspace test with mocked I2C and the buffer
patch also applied verified that a controller remaining in bootloader
mode causes the update to return -EIO and skips touch report reads.
Hardware testing is pending.

 drivers/input/touchscreen/raydium_i2c_ts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 6d6db1395bad..c50fe4aa058f 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -844,11 +844,12 @@ static int raydium_i2c_fw_update(struct raydium_data *ts)
 			"failed to initialize device after firmware update: %d\n",
 			error);
 		ts->boot_mode = RAYDIUM_TS_BLDR;
-		goto out_enable_irq;
+	} else if (ts->boot_mode != RAYDIUM_TS_MAIN) {
+		dev_err(&client->dev,
+			"device is still in bootloader mode after firmware update\n");
+		error = -EIO;
 	}
 
-	ts->boot_mode = RAYDIUM_TS_MAIN;
-
 out_enable_irq:
 	enable_irq(client->irq);
 	msleep(100);

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.34.1

