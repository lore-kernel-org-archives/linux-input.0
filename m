Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB82F3C18
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164883; cv=none; b=m3lqzimmHwsdWbB71s9IFpQoancXUhE/bmpeoWG7GRzHGNxf5LprBAToDTrjtV+ZTkYbd4bdz1x7HwY5R1e5a6C+8ho3jjnWqLsPfgh+9YCrzDS4zv1BKl5Kdygy5wz1y2oE98EycHWIJeBfYaEy9GjNNHIt84fiJo1vY7r8Hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164883; c=relaxed/simple;
	bh=tGAAR8BCPGQ6diGbDduc4alU8q3ssqbirz2CiArzelY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UouYQ/cZuffh0CUZwqohjGWWBo0zGPU5MPSwdeBh21BfqfqlDP6gkAFzdU2uuQTRqM+gjFXVdeDqPoX6rfdqwP/6e/2kLKAiB8+1/0QNgjtM5c+FZF/keCfMPW5MRFS8OrqZzNQeJftZgOmCRvdF9paoI4g37E4KbJP74dHuoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmP4Si1N; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmP4Si1N"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so3795372a12.2
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164881; x=1771769681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhCYDBAOVWjwZIBQGZkgvy83Ytz3Sb0ddi7CY5JAu4c=;
        b=MmP4Si1NH3j1HjinSekQYW+ArM4FiqsOyU+YDyUSvRE+dFZJYosFckgyEdscWX0X3Z
         OjVuZXDbxOg1wLoG9L2bzmnG9H6pZiXVXPyIKPQL+qRfmWAMnhbK3oR0dGMPjBEZhltG
         1TMObW4kpKYwfPKJD9mxjo+fleQN5Nad02xUaQDpwEx8hnIUZd9g5/uSO3fFqM5yZNdA
         1k3UElUS7mtZCSaLBwYWVAN8SDhJ4QWcfOk5WBWlJfCzHZeikOHitIYnhL0XxJ+7JXsG
         ceu6nu/aL6JFbhrcg4S6V76wtMqeC6YQXBJzIVopIOi5zkLDGT2WIkAkFtCHAs0vdf1g
         wosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164881; x=1771769681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhCYDBAOVWjwZIBQGZkgvy83Ytz3Sb0ddi7CY5JAu4c=;
        b=vW22kNV5vm22q0nnsb2TGN756puXtg456si18BJbOOMtwN/L/hCmYE1MexCHKR88Sq
         Qsh16pw5TfyHUVMh8symI1dFiY6gYZgPqF8eJGkRCPxu/c87ZokVVG6kJkucgbZwKlsQ
         2i9fdEmIHJ8Dx4GfYMx6zvHGoXXFNzikn27N6wYTWOcLgmSpFG/9Wl2g5OYHA0BC/pK2
         dxE3W2d/OIY8FkydqAAP/eVOXAqJ1S08D/fh9IzOVLl+IDOTRTCSSxv4XPvEqIdZkawG
         hyVIliLP+9/d4jQG39A5qZmc1K7LpBoQUzfCboFp6qW08qG5TkDGtlo3webcp3zDk+yI
         /PiA==
X-Forwarded-Encrypted: i=1; AJvYcCWceaQqbyQ+4uI4qEcQVwcRm4FtQFQP3SKlxHTirE1VYnkKvpnOEGYDZudHjifLNNCo8htBoahr7JOXfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFlxxl994EwtgwMgycMEFrBS/q3akHfcA5glmUqRiH60pgj9n
	d6+Sgu6zVLNcVUTSmcd8fkO9p0Dj2/7C/YkpqWPFB9cDuIF66Mjc8PAGh0/WMg==
X-Gm-Gg: AZuq6aJxKW4EmiMEX4DQT37mrhMgYFVYTSby66BAK2yQJJ7yj6APUVnFTeJ4IZYDiNn
	p9AZbfWI/3339jVDwOBL3m7mLcCXCEpONOcJxFhKaWIgunPK2DFKDy8SK2OCQYkT4He8fEXBzMb
	P30XC+6stpUqI1kGmM2MqpC1Tw5+fhCQOzotD0O3L49B8ZSaqXr1lMnI3WYpE0haOrO6sDmY6LQ
	yTQeaenfx4kg9qlgCyZamB9bMA7wKp6SZCy4B39Keg+cYxcTzckT9rmpxErI8Lav25Idn56Exgu
	N+6Q428euLQvnf+fW3EPSlOrtqUJJy7AW8EjFziQSB7kfnkc+UaXHb7Vk1qdZA6YhrgsnDFLUcL
	VWy800d0BqspxT9COBVW0Y+tj8O35Do0P52+fsXYcGbVBqWku/1Bl62MYbuH7rZLvWqYmojySbL
	3ZvIAmEQs8CaoYzg==
X-Received: by 2002:a05:6402:90a:b0:659:3ed2:13dd with SMTP id 4fb4d7f45d1cf-65bc78549ccmr2529465a12.4.1771164880514;
        Sun, 15 Feb 2026 06:14:40 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29df12sm1518889a12.14.2026.02.15.06.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:14:40 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 4/5] input: drv260x: Fix unbalanced regulator_disable() call
Date: Sun, 15 Feb 2026 16:14:34 +0200
Message-ID: <20260215141435.727872-5-jekhor@gmail.com>
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

The driver acquires the 'vbat' regulator during probing but never enables
it. Consequently, in the suspend method, the driver disables the regulator
without enabling it first, causing an 'Unbalanced regulator_disable()'
error.

Enable the regulator in the probe() method and add the remove() method with
regulator disabling to fix this.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index c4dd410c303e..71fbdabc6589 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -520,19 +520,37 @@ static int drv260x_probe(struct i2c_client *client)
 		return error;
 	}
 
+	error = regulator_enable(haptics->regulator);
+	if (error) {
+		dev_err(dev, "Failed to enable regulator\n");
+		return error;
+	}
+
 	error = drv260x_init(haptics);
 	if (error) {
 		dev_err(dev, "Device init failed: %d\n", error);
-		return error;
+		goto err_regulator_disable;
 	}
 
 	error = input_register_device(haptics->input_dev);
 	if (error) {
 		dev_err(dev, "couldn't register input device: %d\n", error);
-		return error;
+		goto err_regulator_disable;
 	}
 
 	return 0;
+
+err_regulator_disable:
+	regulator_disable(haptics->regulator);
+
+	return error;
+}
+
+static void drv260x_remove(struct i2c_client *client)
+{
+	struct drv260x_data *haptics = i2c_get_clientdata(client);
+
+	regulator_disable(haptics->regulator);
 }
 
 static int drv260x_suspend(struct device *dev)
@@ -626,6 +644,7 @@ MODULE_DEVICE_TABLE(of, drv260x_of_match);
 
 static struct i2c_driver drv260x_driver = {
 	.probe		= drv260x_probe,
+	.remove		= drv260x_remove,
 	.driver		= {
 		.name	= "drv260x-haptics",
 		.of_match_table = drv260x_of_match,
-- 
2.51.0

