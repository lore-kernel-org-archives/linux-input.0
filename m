Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761639;
	b=qRws/UJCqqGXxtqbkmwAqb8XuQn/S4CTKjJd6M56GuJVj3XNqWa7XVQ3u2jWokxxCc5D
	 Ob/f6jZTRUnOW6kfomxX1xL0Fz26YmlQ4l8bGHANaZP/rkgqDveZlzuq/31+RuWakgQGM
	 GSEwqJ2H+2EbQJOZXVNYR0lz3iP5iInm531FqEcjNNrTEAY6MM9qRZGnB9Wa3iSf3r0cV
	 mVzNiNgD2xj/61CPvKALV+GzSAcgDo6UcSm9A4ubX1NVxV3ACQ433jOQelr1NkM2/hRte
	 z/fhgsDFzzEtfHIZwsPZADSSNxf+GcLTGRTlTMnTxa2X+9syM2iJ6ws4NtYpuYkb+gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761639;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MN18tqzJEFBJrqx2Me4vDHQYkvULP5aZLr3J2JMguuo=;
	b=5Mu7jhej08MTKclx64R3hCFiTiedAtrmb8PywxNJhvRG9hF1NPuD2RYZd4PKN/LVsdie
	 HGCDfmiwLT+zmWqNBCR2FrgtScIyGRvHp4kQ7F/J9fPo84aFqU5YYUMlx3ghqvCssMXV0
	 JyThAYMftZu2f1vGKwSOkVCpticXYp5JQp7b5dO9QixpbhBXym7Eo0OpzLfY+AjGHgZMJ
	 d+waOsNzKGN4MjG7awE5H3T5pzOQKAXo8WeEG6r69XdRoBbVdSru8iD81mmtw7deZxWTq
	 tYdFBlh7AdaUQuSpYiUBCE31yhVUd1GwE3HwzDZJ7JaOPoDn3TJCQtgJ2i5KbZJmFmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=E3Yu1QTs;
	arc=none smtp.remote-ip=115.124.28.147
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073ED606A31B;
	Wed,  4 Nov 2026 03:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073ED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=E3Yu1QTs
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793761629; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MN18tqzJEFBJrqx2Me4vDHQYkvULP5aZLr3J2JMguuo=;
	b=E3Yu1QTsegSwsTeHx2m4kkEAoh21Sygnf+XL70FnlDNv379pSCg46rm9rOCrODh7e86sTWV3IpSN1Ryfo9Uokls5xnxCZbslcSwqpMvQ4OeMmJWdI3vlwiH1wCeMkRG46wFHSLxu/FeE8jVOPJjB4AnQV2mGeAADNeiGdHWy1b4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1784772|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00319118-0.000167641-0.996641;FP=972432408663265008|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jwOT4aA_1793761628;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jwOT4aA_1793761628 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 11:07:09 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com
Subject: [PATCH v2] Input: joydev - avoid an undefined shift in the legacy 0x read
Date: Wed,  4 Nov 2026 11:07:08 +0800
Message-ID: <20261104030708.791730-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <auorp8LgmW8Fr9tY@google.com>
References: <auorp8LgmW8Fr9tY@google.com>
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

The legacy 0.x read path shifts the axis values by the calibration
constants that JS_SET_CAL installs:

        data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
        data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;

JS_CORR is copied straight from userspace as three s32 values and
never validated, so the shift count can be negative or wider than
the type, which is undefined behavior: the shift compiles to
whatever the architecture does with an out-of-range count, and the
compiler is free to assume it cannot happen.

Clamp the shift count to the width of the shifted value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: drop the stable backport request - the shift result is just an
    out-of-range axis value, not a memory safety issue.

 drivers/input/joydev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 32459fd..4740099 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -353,8 +353,8 @@ static ssize_t joydev_0x_read(struct joydev_client *client,
 	for (data.buttons = i = 0; i < 32 && i < joydev->nkey; i++)
 		data.buttons |=
 			test_bit(joydev->keypam[i], input->key) ? (1 << i) : 0;
-	data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
-	data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;
+	data.x = (joydev->abs[0] / 256 + 128) >> clamp(joydev->glue.JS_CORR.x, 0, 31);
+	data.y = (joydev->abs[1] / 256 + 128) >> clamp(joydev->glue.JS_CORR.y, 0, 31);
 
 	/*
 	 * Reset reader's event queue
-- 
2.43.0

