Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755350;
	b=KijqN3MwOVkOK8o2kpAkJw5UukS1BUfmLVLn7T8/DsEFpt7i9No+NO44+i9PrcS49bwg
	 1km4CL/IuXi5baEdBX+XQwu82xm1Uxr6oU3dRTIGxfYGgXj09v7oSXtLCZAKr2fweT8aP
	 RRBNox+TQsphbs5YJsaxiaF80IuUsufU3En7xS3gYHKskGcViH7DlKohTJ1fUIdrKTLxy
	 ermudO2cuvU988YKATYWfTDOWI0lEh/NhEAen9FiLq7z4aq5pH1pp1RGH94ygUC4STaGp
	 4eb5mZUXy724sssqzkxKQlw/r6FLJDtCDT6AadFO+ywAh7PvB1v9jOKEYTRpSXlZgIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Xq7qc4BRfu5FJGRN78qOqsOjPTIEKnXdGiz34GlzHCY=;
	b=BWGnzTUObZKi5mpSViZ/Y7bBr9YcQvCKcan0lEDTW+Ks4kDh4yyDt5s4POmj0KPhW6FK
	 +YYh6sJ5xEQX3S1fWJCmpVRezrKQghMOwI1idLmOSHoajI0/WJ4Dzt0HESAuU8yZRqLma
	 MCUBng4nCP/cZ6GRlsTh7D8w3fR8e0sxC/9DiTIVtwY8k4FBRf6jgoM6NoRisDeIfGvKy
	 AylfWtMcePN0nle/tRtuz1Xh6v1D2ly/AywCmBo1cYjlLfhHGzGNd7Hx3eOG6FR+pRmwo
	 bkylmo810LRoD4KKiITQgC0Z5vonkP1ow7pNa/8QfhridTztmwF8R8Af5DhmJqKUYRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCxSEUxa;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0989606A31E
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 15:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0989606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCxSEUxa
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so19484465e9.1
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 07:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794755348; x=1795360148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xq7qc4BRfu5FJGRN78qOqsOjPTIEKnXdGiz34GlzHCY=;
        b=rCxSEUxavVoPw8oHQzwRacIkVgUNBvJQUSqMxPRJSGadPZx+kvjG97Tq8oMhiUdQh7
         oDHwczu5d0A4jGiPN3y6Hs1F9V/svsg6VMBvWIZKTsmeJdMZUdMZK7yTO5Ki2DsXH8xM
         17535pnAFg99xAYjTAsQcch1Blj+CJL6WBUH77Vv8P/D4UJEO0ZwiaV54U8t0T5GpcbH
         2qm9Mr4N0EDIxPiMmEkU1cXzLlwGkV0JGWefB9apLM1DFkoZTTK64ren5W8XCgtkXli0
         sABfA8KbDe1gE+sDwhTIzMNJjmt7ISexoRKDBcU3EhUjBz/wZAPHtMh0qtOaLj4KFoKz
         njQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794755348; x=1795360148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xq7qc4BRfu5FJGRN78qOqsOjPTIEKnXdGiz34GlzHCY=;
        b=y9goS4khz7nU6biPKq9HyWryLe/YFIHDCDfdhFgy++TbI6HvnMoz53jlxW/LL/NQ6K
         tHeHWEeL02rYvIK/VLd7JElRHXAMpKKsUugr1259kTfr2J8cfg73ihM+POLOBwzawQux
         kkJHIrGB7XKcrqzhT31ByNp3PBgRhEXhOozTpgxXyznUpNOdkJB7efZb7vtus5ImRjKf
         8dFNVkZ5nT5bKEzxt8R6QuanTGWihhN74CYu2ChkP7ImxxSvUO5U1hSzDUr9nxtFd9V6
         dRCRoTdlopE7zNCs8ouihIc8vosEboZhizPUGT1ZiyQhF2DoS6KF6Lp5kNeIO5fsXUUF
         3muw==
X-Gm-Message-State: APuU4Z8FBXXy+lBWS0K8wPbbfRzitqpmVukAPYO5FaaLf2GC4hgdRXuI
	H3KBTVKSuhRWCuWgGG8tLspUPEnfqu1CN/ag5vhk/LZaxY4hpodviQ3S
X-Gm-Gg: AYBFou3EMP91qjZwSG2WC4pvQES4P9lOB32OSbxT1yuLLvRQ+9w6PNR91/HPWfeQvUM
	/Xj//3ccjeNIrSy9TnIo7Lzed9n7DRH3w2vUz4qNqLYFHNdwT55e5+l6nKxAztxwyVYEDJauhsw
	DjnXsikex1hlMkSC9UDkdWaTeGqoKWzrwk1ysSMrjWverGsMfo5OAIjhvZKoUST8U16Oz+z0aB7
	BUVd+uyqZaj+4sPIFBYEZjhZmmHqaJFj3zNA6P2yl9AYs6wb2QakiElE2sBPrqlR4ugGZ7OToQ2
	Mnr2bIS6tT1U7Tr1lyKpBJaRpW+eYMxWaiONWfMlLuQo3C/ab+/PriWjag2z8GZRX+cd7K2P1dN
	F1Se4668tEDERy7B4USdKGRayoqhUu6a7KEnXggaY6jYlQg88x/H+mLHyQd2GKOEhX+4Tqsd/d3
	6ueHhOfuBwTIleDc7B6pPN5WmNnKltnOnLi8YEXJ/E0chV7F02YOht289qqSuk8StzSpkRGB/kO
	ZFYwuWSOqTV7xZl75kM3sICTr7F6/28cbfVqCP3aA6Twpxn2UdPaETFbqiEmWTxzx4RogviFgti
	S5oFwerlM1E5Ek21TB1WKoj6qOvRTfIEu+CbLexC+RTHwlBO/PWK10ker3BEdRuE4qLEN/xlZOq
	IbQKn3ySE9UIhWFV4R13I2vTFF6cYKR90nzKmgWBOFzoW+VQ8HQWulNC+vf5TPVe/WC4zWmnGJk
	CpIhnnmIV3jB4rce85ahuaY2YDtmcvcW741pMrTzYWQuTy4hlOnPTVATy0CnYMSeqV17E1AP3UN
	53KDVFySD4oPw==
X-Received: by 2002:a05:600c:34d6:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb5599801dmr172843665e9.0.1794755348206;
        Sun, 15 Nov 2026 07:09:08 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571d7e87sm150114515e9.3.2026.11.15.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:09:07 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] Input: axp20x-pek - support the AXP313A power key
Date: Sun, 15 Nov 2026 16:09:03 +0100
Message-ID: <20261115150903.16855-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
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

The AXP313A MFD cell is registered as "axp313a-pek", which this driver
doesn't match, so the power key doesn't work on boards with this PMIC.

Match it as well. The AXP313A has no AXP20X_PEK_KEY register, so hide
the startup and shutdown attributes on PMICs without timing tables.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/input/misc/axp20x-pek.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index c34e002258ee..d7e696dd7c09 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -85,6 +85,9 @@ static const struct axp20x_info axp221_info = {
 	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
+/* The AXP313A has no AXP20X_PEK_KEY register, so no timing controls. */
+static const struct axp20x_info axp313a_info = { };
+
 static ssize_t axp20x_show_attr(struct device *dev,
 				const struct axp20x_time *time,
 				unsigned int mask, char *buf)
@@ -193,7 +196,26 @@ static struct attribute *axp20x_attrs[] = {
 	&dev_attr_shutdown.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(axp20x);
+
+static umode_t axp20x_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(kobj_to_dev(kobj));
+
+	if (attr == &dev_attr_startup.attr && !axp20x_pek->info->startup_time)
+		return 0;
+
+	if (attr == &dev_attr_shutdown.attr && !axp20x_pek->info->shutdown_time)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group axp20x_group = {
+	.attrs = axp20x_attrs,
+	.is_visible = axp20x_attr_is_visible,
+};
+__ATTRIBUTE_GROUPS(axp20x);
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
@@ -392,6 +414,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		.name = "axp313a-pek",
+		.driver_data = (kernel_ulong_t)&axp313a_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

