Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC63644AD
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795997; cv=none; b=e7G79NXc8iJodfZGPq9A5m3K8tm+uY6L8Mwjm7KNHtljo8HliyhlKIpcrYhhOLhZyQwm7eQkD9OegUrWhs2GuqX5vjF1GZecHcBq8yYrjRx+wIi32zPqHAPIl113ufI2ANtbodOhaujYq9kRrzPYcSLRA8lUmifZLKyKQ6dlsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795997; c=relaxed/simple;
	bh=V6xmUDir/R+x5NzOf9HEQbv1gktAL/EV06jQVrAxMpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjArkg3Wzci00FThANh7+S5cKmYOsj707BIaoGmHaYGp6KVnDeAebGc3Fftzy7v4+1WsQOnxzJBbiABmXH2iQgiG1tMGaHiHawq7lJITzFNqPFKLFM0uxhasailNtEZtlFhPFsXcdI83TgwBdrTLvdvMkIeGlRsWPs9wZ0Uny3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8rc6HT6; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8rc6HT6"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70b69ced09so2639299a12.2
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772795995; x=1773400795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc6w9WjyVAm0N3akeFsUfvW+uoclYZdQN8UKYjlEZaY=;
        b=K8rc6HT6D/oqkUtV1Lz1Y9vRaNDK69XkPiO+ynVE9jrrWkBy/vqdzq2IxOV/1zQWh1
         4HA0Ur3XVKoQJBMDYtAspP+e/8mPCt4a6elnlf8QF7ifYDZ4Ert1o5V+uDd5bRBt74uY
         m4g+DC22nPUh6toYCM5WdwCc+AGg8tOjDOzvZa2suVxSv6nhyhWQ9vsKx7lzOo0RQM8K
         XHHO1VVHOezgwBfS8GoeKxt61xG7VSYjfksTOJjj7AyT7h9IwvqF/aagxirW4mPd34dK
         9DlSMj0xrBCb+jHxsOQ9jhRMKG6jMUAi7Gk99bMV4UDydUs6x6cdE3aQF06ZmagaNZVI
         pf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772795995; x=1773400795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bc6w9WjyVAm0N3akeFsUfvW+uoclYZdQN8UKYjlEZaY=;
        b=xNAeBKoY9zEYnvnG7Jarg92wMx/pHqWdUjTVwls6T7Hr2JTn8QvQz+rA5WcOJhvknA
         ZXxtIF0C/dQ7ck/0Jusv2S+O4UWdGk5JUEUc0e5ArZnVXNXFNg/8Hmu1AZ1jhXJitlg5
         J+GaE9L3nPI8v/xBBDI4B5guVz13XEZRB57uKPR+WwWanMxW5I7b5YwTVkZsWGLJJ6rb
         sdrMDu9PkAsvJZs5cwrB5ru9nVxozamUkzvRJzucmpLjEZoa4qabYUJXoaYallaO8N+t
         pPDZL4N3dJAbH1wlEGztDIkzPz48iV1uIGAFwDSK0/68pmm1j28hrDHO/9WMwQ49/1Dc
         E2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpOU+T/lgYzjIMDwCCCryHYUN8gsGbLNNuf3zoLOiJt6gG9Kr/Cj4tleWDAl8sU5NYHgOFLd3uzKZV5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYYlZH1Q4Wpi1hs6Bjqnda9v08kuw//MbuVc6ytnw1GKTVn3F
	n+vTULJXzbYz8qWDbZWMhfXN1mnL/fmsrEsL9lYi4cHxencMHVB9f48Q
X-Gm-Gg: ATEYQzy9MuD/RHvcmbhX+AFX7oi5ymcMl5UTemsNDeZ+k7PQONaETrdxf54nxDD6BSm
	OisrRfj5ihB7/bYlgCCkKbMkYeQ52lHcDxkvpfndhw5W8YspVKaIcp+cx2MA/qY2w7SJ8JS14ZT
	hBFM6WYUNC9JWj/5Pvqg+PyejVwPhYAIEKNVAXp+qjSQ43rTeKV6H0CapCFSPciJWcAOdwls7NB
	ZoQSPvO0F0yKZLUpJvXaAZXwCGkO8LddNsl5EE/EmLiR7dhfCwRGGfiEW84S/PhSCFQZHqhoYHA
	PUr1QfBX+0AvxutZqczb5SkYi0fs+NIX9DOjfiX4prA2awkimvaS4R3sXftNfmB5T8ic8Q/M1dr
	MRMQnTW9Q54pw3FU4HCZT6P9PkulHOe6w9tvh6yqRl/8whJDtyiTWmvuNtUnK5ZXRhA8XgxATbs
	yCAz+DThFTMW8lavEfpqz5vulgieKNOp5q2rHDOw18l4dWNbtWXACKczC5ow==
X-Received: by 2002:a05:6a20:db95:b0:38b:e68f:4645 with SMTP id adf61e73a8af0-39858fda379mr2232375637.24.1772795995243;
        Fri, 06 Mar 2026 03:19:55 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636cfbsm1475973b3a.13.2026.03.06.03.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:19:54 -0800 (PST)
From: phucduc.bui@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jeff LaBundy <jeff@labundy.com>,
	Bastian Hecht <hechtb@gmail.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v3 3/3] input: touchscreen: st1232: add system wakeup support
Date: Fri,  6 Mar 2026 18:19:12 +0700
Message-ID: <20260306111912.58388-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306111912.58388-1-phucduc.bui@gmail.com>
References: <20260306104025.43970-1-phucduc.bui@gmail.com>
 <20260306111912.58388-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The ST1232 touchscreen controller can generate an interrupt when the
panel is touched, which may be used as a wakeup source for the system.

Add support for system wakeup by initializing the device wakeup
capability in probe() based on the "wakeup-source" device property.
When wakeup is enabled, the driver enables IRQ wake during suspend
so that touch events can wake the system.

If wakeup is not enabled, the driver retains the existing behavior of
disabling the IRQ and powering down the controller during suspend.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
Changes in v3:
 - Remove debug dev_info() messages to clean up the code and comply with
   upstream coding standards.

 drivers/input/touchscreen/st1232.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 9b3901eec0a5..8fce17d8bdc0 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -183,6 +183,9 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 	int count;
 	int error;
 
+	if (device_may_wakeup(&ts->client->dev))
+		pm_wakeup_event(&ts->client->dev, 0);
+
 	error = st1232_ts_read_data(ts, REG_XY_COORDINATES, ts->read_buf_len);
 	if (error)
 		goto out;
@@ -356,6 +359,9 @@ static int st1232_ts_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, ts);
 
+	device_init_wakeup(&client->dev,
+			device_property_read_bool(&client->dev, "wakeup-source"));
+
 	return 0;
 }
 
@@ -364,10 +370,12 @@ static int st1232_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
-	disable_irq(client->irq);
-
-	if (!device_may_wakeup(&client->dev))
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(client->irq);
+	} else {
+		disable_irq(client->irq);
 		st1232_ts_power(ts, false);
+	}
 
 	return 0;
 }
@@ -377,10 +385,12 @@ static int st1232_ts_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
-	if (!device_may_wakeup(&client->dev))
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(client->irq);
+	} else {
 		st1232_ts_power(ts, true);
-
-	enable_irq(client->irq);
+		enable_irq(client->irq);
+	}
 
 	return 0;
 }
-- 
2.43.0

