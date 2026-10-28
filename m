Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186352;
	b=tX25AQvqdUGRG8mk6MMB0pIs3J1712KWhTJEso0kQF/ZO92rHPRaCJzZKzbG/5gBPLkj
	 InSFiJIzs5bN0PzGdfLbhDbLNZZ4MO0Lz7aKphPGhCtda2Nmq9GYGL2QgkBUKhIGfdzAz
	 h0t3oXQriRcnRP5awQoFpN11c8ThYc3WxEOF1EVdXwJiAzFMGK+3lwZbdYYQ3NJSzg6dO
	 oEd48jP2vH+KLrC2qZ+Z1KWWsyDZsWlZdAv+y4uUR3BlOWfnBvMt9D8VUklfuse6ugrZI
	 YQ74U3vxDd1CgizOxsWsXsIAHaEoMt2Di4AD0s2jgWMX530QBVZ4wge6O9rRi0ubboA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1I4GJ/t9JYlWVGVqPwODuflgYivcSDfBTv789oiYGeM=;
	b=O8EOeRuAh/B/QbN3zR8spvnLO0lt+2vkbmPE3I+S8c9AmVQujHBNgUj8W7SiYEIyU1iv
	 +sRD0CFtN9XP7mapBhpuDmsJl1iiQVpPpB1+D9ULM8igIwx4XNJFctanM8Dc35z8k3KGL
	 aixUvvUPbo5ye/8VaDT0eVpSz1sGQJxzOXO/9SxL2o/Dgko4yo/bXy1n6fyIy6L/lOIkC
	 ScERXWDgp0gpTIkg6F5SS1jAyw8Lz99AJu1cYjgrW/4U8ApP/GeK4sSGqCY7erCJ9sMQj
	 lCOQ/SAO/bJp1r+HnkCnk3l/JKiQ+tqkLUdoC9IsM9+ZplUE+LcMxEFXk+eSqqgUj4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VZjJdMLh;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3C606A330
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 11:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD3C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VZjJdMLh
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956869750eso5245565e9.2
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 04:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186346; x=1793791146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1I4GJ/t9JYlWVGVqPwODuflgYivcSDfBTv789oiYGeM=;
        b=VZjJdMLhSHjPrNYipDLBUEPscvtSW3G3K+KFGMElwqECKTEU7BLoyN5bjaKkCsi3x0
         ZIAaX8PyflZv6DL0tfgqg0Hg3B2ZcmhpXNhl8kKgzsJ1EZD4lyNgD681a1+jMGXzqMbp
         UhjQmhASeWXsuymqrM5nBnbnlX1EPRJPv3v9djsVfW7Wc70j/YxMB9DIXBjGgJO7+DwC
         0ujnLWiohLvKcci0EDmqisDTIKl4gvmztcEdNQegKjd+AFF/AFYmJT+5XBgMzFSGA7F+
         wVxFpM3OLeyD86UPtVemDt53gMvUWnpR1ECBLUzQj73qfrPS8zgjLDcRjVwkmPdpsQqT
         1cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186346; x=1793791146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1I4GJ/t9JYlWVGVqPwODuflgYivcSDfBTv789oiYGeM=;
        b=Crn+RX2E7M0O13s+VWAOnEz820MdYL5Fu6YKb3Zz2V+pFmY3Sqw7rrUZgMOKtetgmE
         pn++5nOodusy9p/s2DR6qL9bNhcNkWTla5/Q6fWHPO1/KorWMnndI1sb/r51Q/+GYm72
         JxrdSAySeM1Czev03RvkxvSIGQWvWqAk5rnjtXAMo83XZ+ULL5wWHVoZf7BjYlHNImSn
         F2353baIBee2X0QZCir3Tn40tWGMs2dTQ8I27X7ZO6bQq3wdtGnIlFsD8zv1alOU4NFa
         EEr3knh4XjAr9wLpUIUBrabDOVdRkG0jlJ6VGouYvZo7IlnBmISP1uxzAedtPArf3Wz+
         aRhA==
X-Forwarded-Encrypted: i=1; AKwUvBzrWyMY9ZM1ip/BFSXaKSzkkmCpItMprksHWIqkGBqG13N8TDTo2DoGNzxkm/Zpl2cMZQPONcfZ0lSOTA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLecVXDFQOj25qRtVrGsCByWMgExxEBLlG5AN6f4dybctoM2M6R
	HVJwocQzo8ZTSMWQi3dp/T3C+1A+ISoQoYQb7osjWTihPgsiFkMo8RE5
X-Gm-Gg: AYBFou13v9hUVkAO+iR7XOn90bbv4jo5L042ySKNyZni4QOJPLQVEQviY8nJCuaeKw+
	aDKEzVwPIvXlhWyuNQgph0uaC+ZiNJI3+kAOyhbypN/l52BMEbwhkiTJRcZlZc1elHRtPSXQvnZ
	ibNg0Kb1uVrLKNzWT3sLCc/KGg0EXJKn8VXiLK8OFCjSMesiCO1EZ+7fwHmssQP8x+6LYQLlVRB
	F26PxIuFYRVmc1d1OJjtT5pMMHXBzS+cge+Nxr+sqSOnV/WNeXSY5ZDmRshUfop9Hnh+sqoGR+K
	rVMrtWAtOsEoyE4JmGgje+ZMW/bhio/xYLKCmBAzGKN9vSBbhQx9j1RT5aAYfrAi7fde2+lEQaO
	YHCP8qFDDr1qxRdKB0YACXDJEmAYMV3Yl+SCHb0kOhXnw+i58H9SP5/P1zdXJVXMYEOEf9z8X0j
	ytXWd7s/rBvJU2QZOBWhi7dTzQ0iX/3IxsyIR2XXss7kfkwWTyQkB1lfl8fGFveb5YN38VKD98W
	wRbKPU5e/QaAENRGJAOtjSrokqfOBNolyC6YoTFzCjfR3mc71qpw/ceEX5f6jhj3tgtXwkCW5Ac
	55QrqNQY+Xhz1VJiog==
X-Received: by 2002:a05:600c:198d:b0:4a2:1a:a11d with SMTP id 5b1f17b1804b1-4a9610e1028mr42232795e9.0.1793186345891;
        Wed, 28 Oct 2026 04:19:05 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978d57b39sm64197635e9.10.2026.10.28.04.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:19:05 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH 3/3] HID: logitech-hidpp: Replace create_singlethread_workqueue with alloc_ordered_workqueue
Date: Wed, 28 Oct 2026 13:18:53 +0200
Message-ID: <20261028111853.22429-4-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028111853.22429-1-mail@taterr.org>
References: <20261028111853.22429-1-mail@taterr.org>
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

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() for the force feedback sendqueue.

WQ_MEM_RECLAIM is added to ensure hardware events can be processed

under memory pressure.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 27d83b8bbaaf..4efd26450539 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2875,7 +2875,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		error = -ENOMEM;
 		goto err_free_data;
 	}
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	data->wq = alloc_ordered_workqueue("hidpp-ff-sendqueue", WQ_MEM_RECLAIM);
 	if (!data->wq) {
 		error = -ENOMEM;
 		goto err_free_effect_ids;
-- 
2.56.0

