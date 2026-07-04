Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A538D3EF
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144883; cv=none; b=bey8Mm4ab8NM0zNvkb9z4C/GElJEOErFwmX2sYWj44aD8OKE2qFq42Dg28PEvw7UOPEIJS2ffNyVbeqsaF+svngOBtYl6ICt0jhUhJpqZx55JJiCKOLql6RziBRuj4ZdkAFVFxb8AQ0bXeWi9IT0ZRy0n65oJ0MIZP6VZxiLetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144883; c=relaxed/simple;
	bh=U7meGQ/yqO5nue3fmIDavhUgJX4jlw+ACCtfxt6efyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6OezK3XOx0pr8kui8Q04eFmh5ntTw2Idctdb5+Gozf02QOKj2s9/mU2oAFbwoGbUE8ZRCHgw+0ioYVYZPjrHQUqQW1pM0wiMpUL9j+DKHNKEKFTNlKpO9I8DB4ovoasPTq7FdPrS1FWEggu2Z41cNrMjezj7USePuCP2D/pHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBoBvSia; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBoBvSia"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38426d04bb4so55108a91.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144881; x=1783749681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgeg1hy/5eCNX45AyPB+pHlq+bl3Mkeu4yKxcFxgJUE=;
        b=dBoBvSiazvtcI9BjWQD2C4QFZOyw4pnWYoCX4Ba28rN/pBcIospsB7FZCGKb6SjppR
         Hr2tWvF7L1JVElFYmWIfEkIx+V4l5Wm0IrYAsTO70wRa0GrK3Spdd1l1FT5udno2pv2p
         H9fNPtkEitDnFedAAUnVXzS3hR5mxImmMR7AITNW+fnZdfscVWkPha7OWz8wSLFBXzfG
         x81uhEvEm8K2k3VLltddq4s/2n2tKmIJVukrsSRl7BGzUaOAbT6baUkJziwwU9K9PsFT
         LIZAVtq8TBD4hL5LhqHPM80c52eHeEdvirtCd692moqsQkUwLLQLQL1Vb6SjIEQ4K9GK
         ChTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144881; x=1783749681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgeg1hy/5eCNX45AyPB+pHlq+bl3Mkeu4yKxcFxgJUE=;
        b=CacXWjQaBaminvsa6SRNGX2JrQqHm1gb/TOrFRfZBGQsuXh1+v1MSqlnE2wMqjdZsK
         BMzyRRjcMyXirLxMi5S33SLBA1jAFWjlteVHaKHdm2yWNpopoVd5yrjPsellwyWh8U9W
         lDEBPvoPXEcqU/3rS2DpwN6nzK02XPo2p2o6wg7zvuOyCb/SkqG6gpoPXuwoMCmS3cxI
         vM+W8QHsYjEioYnQNP5IVCpRlqkjMaGnI4g/G7w9iGhVGbXzpK8PrAKW5+KdAvKqwxtf
         PPXaST+Op5KUPkEBGctReW70uyqKJNMSYA6MJxhRV6KeXDsV+Bayk5NjbCi7uLvZAXIj
         FAEQ==
X-Gm-Message-State: AOJu0YzvegkRJpd420IWYS9hwJAvSkh/mgss9WOlOsoUmgIY6ArT5WtQ
	MQbm6HNrXCu4r7lFxqS7quQmd4rB3mlGzm/MCnwUaa8GNdtGFzzSs2jKZ2L7Uw==
X-Gm-Gg: AfdE7cnyshdN92OstRB0TrYbutE9kpLCIF62ExMipKamjoGY0Le2zsIy+FORPL0hai+
	5FH01VJlMwE7XkgEjBu9xpfGEUXvKV5w+vPIhJz52nEPlwxUKJAG1oJyQVnktGTbJRjHRvp0XG+
	R0M3UaUGzJDDlQCpfLMNDTN79pw9ZUPYYcoJgrEyBvYv1drBNisQa1ojVsES9O+mxx0XXCI539i
	YCInSA3sp5/n4jY1FaOVJ+dl2wApGcoltn59fUNycusGV1oeP6qznxdId4sAsqlA1d/BUW9I6bN
	Dr7TXmKLWQ+3Lt8s9B1HBvfNx4DAmS4g62yv9CbVvx4f1k/DtMFRQ5qDdPNnxSQg5VtqTAzrtKx
	7g82YH9TFLNgZnikGhXczJaP5HRo80Pyc/b7jbMaq0H2nqqf79rWiDOUqBRik3HkxAWS685YjyC
	uyRrCBq4oU3KNTzsTbhP3HvzFsKJh4Xk9ymwxRizGNbO4gPDE7kg+wENGY8JLD3lH8sS1lzPJhP
	eg=
X-Received: by 2002:a17:90b:5251:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38112063c22mr7862238a91.3.1783144880763;
        Fri, 03 Jul 2026 23:01:20 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm25081378eec.11.2026.07.03.23.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:01:19 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH 1/3] Input: mms114 - fix multi-touch slot corruption
Date: Fri,  3 Jul 2026 23:01:12 -0700
Message-ID: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the touchscreen controller reports a touch ID of 0, the driver
calculates the slot ID as touch->id - 1, which underflows to UINT_MAX.
This is passed to input_mt_slot() as -1.

Since the input core ignores negative slot values, the active slot remains
unchanged. The driver then reports the touch coordinates for the previously
active slot, corrupting its state.

Fix this by rejecting touch reports with ID 0.

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 006dded17eb8..23e0283bc6b8 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -248,7 +248,7 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
 	unsigned int x;
 	unsigned int y;
 
-	if (touch->id > MMS114_MAX_TOUCH) {
+	if (touch->id == 0 || touch->id > MMS114_MAX_TOUCH) {
 		dev_err(&client->dev, "Wrong touch id (%d)\n", touch->id);
 		return;
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

