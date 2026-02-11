Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614C35770A
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854351; cv=none; b=H+DISj45v9w+wHU5fjcBlJAYZk+gd8zxh5pXAohGN/DQpPERYO6QfyM/GVvVisC5DfbdqELK7u/sU1CgP1PqwcsEwuoeQ1sCAgeSTNnSGLKZuowTDF6fIv1kK4DEmcppo7Zdz7b18odX0Kb4LLo5q6wp1n2bwNMqAr0ggwSJFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854351; c=relaxed/simple;
	bh=3XeYvg0yD9eAI9rnarFcQbWdNAPXqphE0tHqiyPUNIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFBYZQTnXh478l7B1Vdq8r/9+z6F4BbeNdnkRHlGoHeaabUEIxnxTXA4olZYEhEV66kqqvh+4tmLVpSsLfvVQz0ExzPQ9toD+5/2Eo3/uGOiHLVSZgqBfRs+kEcPG4LW8t+4wcHOIGxwN2HzCrnKhwOWX+B5vz+PL0XhlERLYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEF3pJSH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEF3pJSH"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so374286066b.2
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 15:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770854348; x=1771459148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjPrzEGlEG8pNjTnVxylr4XLvPoRq/OKYW6EWcfUcmU=;
        b=gEF3pJSHMYHdWzJj7Lqg9ROhoymD+u+w0Zlrhz9RbPr7DMkQclW0zEZiYzqrwI1uzB
         XzyPiWE8R8ON2BsxO1gppaQwzVuE/7HywEVbI+C6fRnNDuZ7i7wH8TJSePIsusy3bM8s
         GuyDmucQHU6c2jdiu2CZq61347qZhyazYUPailBXsw7tVkQgjT3YCISehFrYYoWfEB1R
         kspZNif60B7PhLDZinsxYxGFrjel/fcsfyeQbMwe1Sr7JEdK8kyWkkwDGQbKdw+23oqY
         bskyQ2upyA/Tr+xjvK20/amfryGNk+s+PU3Lt+fousOM83XgXoEeFcssTL5DnZ9wu302
         1W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770854348; x=1771459148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjPrzEGlEG8pNjTnVxylr4XLvPoRq/OKYW6EWcfUcmU=;
        b=ue3CQO8a4UcDzdZqpJMQl9wIhDfaBPXf7MBo07cVVI2sZOEzdzR8bMWm//jRSE5GTp
         QnHKmI2tecQPoN4NByB29igTYG4tz1y2pXi33NhvBm4cO61JZI8/9Ttbzs0OrXJL9yuO
         jVz9r+tWQ3fo7nVGCc6EAx/qKtaL7twhmdK+L/WKSmdZQlb31r04FTAg7JsMFqSbzytp
         C2Bbkv2XSIA3ifZYNoa/49ul2pJVK9HkqINUm6DwLM9TTkZDrJWmrhZ30FbHWN2x/Rgv
         xHd588DyjEXmrhrU2yZoxxdlAk8wfK+nuXvbbxb5oeuuMijBgJIcUdWYR0IjPaj8Tf6l
         RYdA==
X-Forwarded-Encrypted: i=1; AJvYcCUrIroBwyWpQPtxJziFguu+3nFoo/VqikF1xhtU6VWQ9Ag5cO3ERiapDwKe8z91fey1ksTrPa3kTJsQrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOiHEEYqkJQod2EVaqMHwdoTGd0TlN/aNPWh5apxwIzi1yXpU6
	pov9SDrMoDoQA53GYmg5H6IjQFX8c3WAhvlr2q67JpbKlAFDItvAoP8V
X-Gm-Gg: AZuq6aLLWnIVfxWYX7ePDyaUlPj4ifKu/t4ohMcmgfBMtmygeiKTto8gqmnqRJfaXkc
	t4fjeUmh8Ss6/qbbTjV4yBIjzlXOXNFjFlI6BlViSO76kqyScHPiGQDHuXBccWdv22q8T5cmbtR
	axf69IvkjEnJWMLQ8LiQSoMiMUcFgAm5b8EUz7oSPd4iptq7xhQ4b0PF9NZyc+su6iTqSPwhLZm
	1elZH4iSxmJ0UbaRhW1jPCE9SAHvkoQ5lOQoATGW+wrScvJnKiUyB3oQU0XViqdtLgMrBToqLZ+
	ZsFV9cYKPFJxD3jxTXu/2AP3KZ5buvN3oI/dLNMT2pRhC3rRSQR01dOe4RQnPp+G0ZjxzaZPbo/
	IQN8ACcW2AIZv+VCMTm0xv6NF/m4DTs/L/WFGglUuHkkEEP9Sm4HSeY4DS3akWAVfgA1nFffqBK
	Xg0e2yaD4KYazcVQ==
X-Received: by 2002:a17:907:7202:b0:b88:6309:c300 with SMTP id a640c23a62f3a-b8f92bbb18cmr16564266b.39.1770854348063;
        Wed, 11 Feb 2026 15:59:08 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f9561f722sm1593466b.10.2026.02.11.15.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:59:07 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 1/5] input: drv260x: Add I2C IDs for all device variants
Date: Thu, 12 Feb 2026 01:46:51 +0200
Message-ID: <20260211235902.4156624-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211235902.4156624-1-jekhor@gmail.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drv2604(L) and drv2605 to the list of supported I2C device IDs
for clarity.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 96cd6a078c8a..18360bdfe877 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -598,6 +598,9 @@ static int drv260x_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
 
 static const struct i2c_device_id drv260x_id[] = {
+	{ "drv2604" },
+	{ "drv2604l" },
+	{ "drv2605" },
 	{ "drv2605l" },
 	{ }
 };
-- 
2.51.0

