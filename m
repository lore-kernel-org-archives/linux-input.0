Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514835B12B
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793679; cv=none; b=PxB16eLE0PIvkFBF6lxs8+T9v4zSRdBK0lGM6qC5MPNXL2D7XNpNXCjhIy5qq/t7dj6JhQGJQpRaFYACc2nIT2UIMbow8bscudSpSRpndtVmrmuRvMVMFZpkFNFDjIfk4YHjXj6J6h9bNa2cCdXFKNCIRlot0W2XD7jSQx4vGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793679; c=relaxed/simple;
	bh=j89JCgy6of4V0fq9wi2FeaIYUxjh/hwtijKH+XS9D/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gW71ZsMCvL1oJpSb3u2CRA7hOCdxmGktU8KZ08ZflElqv31+kmvg8e+cNncfC6SCphL+c2X56BeCe33jDCSvGrwlIiWHIf8aX/Tvs8yzDiASCEnJevchr1yZbtnc9pZ0BiHhpPmmhWoQcdoYlRabXBN1GL06sY/qhsE7hngN1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLgPePDX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLgPePDX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae5636ab04so55324685ad.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772793678; x=1773398478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofKRD1G9zZU7DDlNqf7frnTT5WNqLPVC7ZVN1jMSp0g=;
        b=BLgPePDXuKu37KhR8u6XOcnIyL1ATgnpl2Ws//xghr0k3x9qSn0JB2C8TBnkTa+7D3
         Lncf6uG3nqjDut5TrynrpB/dP0zdot6EBW6a+bbnSXI204ocWfDa/bI9PRnPsdorZ7ER
         /tilVGqhd4Q34fR18eunXjhY7AIUvSFSE+XB6WDobED0jA6HkDE72Up+ok068kD3DZoB
         yZeC0g5ZtjNS1boTpD/t1FgqTTVRG69Es6ET7FJaw0aSKp6O6Nf6pStbTGRUDrFMTM2y
         Gk3yxD2arhGhTqOqjvNTxu4P7W7tPcH9LtdXJgYMtqIcta4OXB86lm21F/Fn2duVIVKV
         ZtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772793678; x=1773398478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofKRD1G9zZU7DDlNqf7frnTT5WNqLPVC7ZVN1jMSp0g=;
        b=v8hlPpQwJ7S790SnxpOZFHrImknms9u+/87hPAmtlfymDU9DqUpwoE+9qvxP9EdxhW
         uGqsqoDqlVyL+E55RrCwmqiickP8olVwcPhG+T03aVDWqgZrtxl5k4MT0kYx3EdtsbOF
         ubzXXic7qQflIpcR1zVJrR/aicGC9l++ZnZxbaUsXO8BhyaG4DuUtQhze5VhIFElN1l+
         c4arBz9QM3ZnekJV4zGXfvQ02UxEMEHj0iZVt+NAoHAuy2H5G8L2o3rDs4RWOMCtbADe
         fXuJ+AwMNjDBuNpdo8yJfYk/Wfae1vm5QpnOnfAjs/gFiF7jE8AcSntG8YftG3fSeQAx
         4XoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2MsUw/W/C6tDJT7CIvS8qrvrCjn2QUm50GJE4teKyTSFcg2b5rmLZv8hlTU3ylZfScdN2TwlzRocGVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKuM6H0FsXc/dTJtzM0fm2miealgYUlePVNZSmuBaj2ngsSCR
	4ox/GCjtWAh3VwTPrIIDtr0FJbp/uUlT8tJZMp5oMDTrNJJ0NUggQnqv
X-Gm-Gg: ATEYQzwlXt1nqZ1SdKK3cJA5TPZTwMcnMEMXV7pL5JsRmsR9jZ791mNwc0YBAPtIgdJ
	a+CJhJZ3gn4uO5QXgbk5gAk7GLIp0Y44nenc7NYx75RIDHB3A4YW53OYZ2XTqRev8mkssTYN8T0
	vu+RnLPzwK7xpUVrX5e7LgzfX6b5c2ccj9WVHyrzhGwNr/H67lMHBxQbINSwQCk+H81x6P+Q2lU
	N6qJvcqAI+xpJlLl+EdeBnKIcnQ6LECvNZ+cZ7CPJuzwSrXo/R3YAOdNtQ2sH5FrmyJrRJXyMXH
	qymFQxbDZPnQxCYSwY5wSNMBOtce9mmLZq4HSIoDinsAZeeMZodAKLLp8M3lS8Fsc0jgvrA/nkW
	/Wm7Z2SEzXFohDpTfD18i1IUulBBBibdogOnBD/iEyy64g5yBaZj/hVGdWa1T5/f2bhZiJMxPVz
	eVp2HpsQ9lZ1JAiU5L3KI5+k0SGdpaWoRLYi3f0+0OZoXe0/ktSqmOug4goA==
X-Received: by 2002:a17:902:c401:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2ae82443f7cmr19874155ad.30.1772793677800;
        Fri, 06 Mar 2026 02:41:17 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa2fa5sm16107775ad.70.2026.03.06.02.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:41:17 -0800 (PST)
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
Subject: [PATCH v2 3/3] input: touchscreen: st1232: add system wakeup support
Date: Fri,  6 Mar 2026 17:40:25 +0700
Message-ID: <20260306104025.43970-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306104025.43970-1-phucduc.bui@gmail.com>
References: <20260305113512.227269-1-phucduc.bui@gmail.com>
 <20260306104025.43970-1-phucduc.bui@gmail.com>
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

Additionally, report wakeup events from the interrupt handler when
the device is allowed to wake the system. This allows the PM core to
track touch-generated wakeup events and helps avoid potential races
with system suspend.

If wakeup is not enabled, the driver retains the existing behavior of
disabling the IRQ and powering down the controller during suspend.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/input/touchscreen/st1232.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 9b3901eec0a5..2bab06cf099b 100644
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
 
@@ -363,11 +369,20 @@ static int st1232_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
+	int ret;
 
-	disable_irq(client->irq);
+	dev_info(dev, "st1232: suspend called\n");
+	dev_info(dev, "st1232: irq=%d wakeup=%d\n", client->irq, device_may_wakeup(dev));
 
-	if (!device_may_wakeup(&client->dev))
+	if (device_may_wakeup(dev)) {
+		ret = enable_irq_wake(client->irq);
+		dev_info(dev, "st1232: Supend use wakeup\n");
+		dev_info(dev, "enable_irq_wake ret=%d\n", ret);
+	} else {
+		dev_info(dev, "st1232: Suspend Don't use wakeup\n");
+		disable_irq(client->irq);
 		st1232_ts_power(ts, false);
+	}
 
 	return 0;
 }
@@ -377,10 +392,12 @@ static int st1232_ts_resume(struct device *dev)
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

