Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1C372ED7
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993997; cv=none; b=RWkTS95Htw8G8jC4dGg4DfmBEgwzeRRFiT8kZSr0DeEMUhUvZqItgczdaT1+H69ROLJGDu5s2m6uNc6Rh1+ycn0+wQvW8KZB1yPINmhgsBB2H5iGvbgMVBVlF5Ht3HOgbrNUtKRILACAjRbHc7Fgf0Pyy6023rO8ORdXXIVcPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993997; c=relaxed/simple;
	bh=BQV2isQeWmOHBG9JtW9rkBtCJnyflqFH0lQUb5vqZcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOqF26W+WKLz4DLM9GJl5SSxWrQhJ7rrxZRB6x79OaMN/HeX0P4FCmn/u/z0DffGclkTI0GzfhhyMRqFbZCT1wxX9hzMu6it7FqyB48t2YjsmSNY0p5QVrC9HRRsTT58HrH9Rqq7SkC0TESsHGd/T9dQbUIcRQWw0Q6z+z8fayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGJqkwTz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGJqkwTz"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c999f162c9aso2211383a12.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783993995; x=1784598795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NU09qqK3E5d/dyVFD1BvZ34uRQWXYNDglzAsIYs/t6o=;
        b=WGJqkwTzdXJfJj5+AjS71jSkUu9peLONYwApQ4W19u4SqQB9FaTB6hg3fRgTMvj6Cz
         BVujwPlW+Cg57hYKZinZ8RbeT3roo9bCP51xc/D+wqU1FUCoPytSIHjG7Nh8NCUan9q6
         ZI375kEQvwQznNBXQSnUCJy8isn0KdWIPww1iAf9w9Rm7tOpuUHtKYgofgUVA34pEfEY
         KBdny6I8+9U8E4Q9f/2SorZLPdtdl5eZK0E81vF/ZUE0u7PORpv+coYDtsO71Y0evDjA
         kCUi9RI3TzgZa8Q9ZMDzmq0jJyoQWc9N0MszDyW2yY+BAh+H9XRf8NX67//XiUBOUm5W
         +Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783993995; x=1784598795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NU09qqK3E5d/dyVFD1BvZ34uRQWXYNDglzAsIYs/t6o=;
        b=nNfPb9R09kbaRPAvodYS79pU9Kz3fQiTpv7eSG8lsa8d5L+ypHnRJAchITEQYEs+Oc
         gdqTuXtxVeTLlEErqMdFKGfIaUIo2/VvNYWZv4oytfeeO3bK+buRC9QG7pr2ZKcGRvYQ
         +3NQRp0SjLYuPb/1NWQI20y2TIXA2LwO5RrwjJurWd9tRkdSdbQtKA2YIrfVDlRi47RM
         uuAuXAsdPxxSMUgCWeLscKZbhtyfComMsAIRtKKucpdUpuz8aUymwQtWWj0jxNfVtbbY
         43RnWX6O0tyrUgAG+ZKpwKiImLqMYJzlyeHLVe5M4v7HbvEosEkkfzY/wEWUb0dgpuoo
         12SQ==
X-Gm-Message-State: AOJu0YzEjWXux5CoHpRzDJh5yF5stoHTYaJA07CXjfqyJ0+OR5jinwGg
	8gucP9epkLUNbkUPAnudad8Qo/yhYVLOmeuQZw/+ZVayAkO5IkTA+Z1zMst00w==
X-Gm-Gg: AfdE7ckBU8za58VjopQHm932+iYzeB3ioc/fxM+9Ewku2qZI30ewKWUyChPFy9jmwrz
	rnKGc7WSskv6+npGTgDScBYfJY9IvLTBOYKljXtYhV76Hqgfuf902cTwgErLyp9P3VyGM4TMBPE
	RuCSco9NepilfF96PSIkcKM5/rrg+pwbfUBH8kEjUtkPu7VWL1wpvyUavcdwbf/3r0H1qhM3OzC
	0GCWVPMSFCYOoUBAnbgDH0bnRezytylwQy+E/2jhg4e0xWr/OOANKsFdHUR5xx9HK6QSRwrfXhT
	YAzSmGqVmxK7zUlfZT/2xWv9mhWEmaZXvDkOB7aXscrHnzJefTLU57YyEm/565gh3iuqm2Ubl6q
	xIMLGcZU9jtY+EQJhSi+sc7Sr9cL5zAfb0SO362GbTQFE/o9aI+M3UDosr2r8utGvGcpCNqAJgy
	ehQrEWIQCWI7IGnqTcKuzKrU/8b/vNx3cqDj/veJdkUFiql8n1ZJ6VeC/Wkm0zz5lrGPBC8cepW
	Uyf
X-Received: by 2002:a05:6a21:6d92:b0:3c0:9c1a:8941 with SMTP id adf61e73a8af0-3c34d8d920emr1840645637.73.1783993995402;
        Mon, 13 Jul 2026 18:53:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm22503093c88.15.2026.07.13.18.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 18:53:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: samsung-keypad - use pm_runtime_active guard
Date: Mon, 13 Jul 2026 18:53:07 -0700
Message-ID: <20260714015309.2140694-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260714015309.2140694-1-dmitry.torokhov@gmail.com>
References: <20260714015309.2140694-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the driver by using the block-scope guard(pm_runtime_active)
instead of manually invoking pm_runtime_get_sync() and
pm_runtime_put().

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 88e733c1eabe..5f6535b49761 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -142,7 +142,7 @@ static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 	unsigned int row_state[SAMSUNG_MAX_COLS];
 	bool key_down;
 
-	pm_runtime_get_sync(&keypad->pdev->dev);
+	guard(pm_runtime_active)(&keypad->pdev->dev);
 
 	do {
 		readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
@@ -158,8 +158,6 @@ static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 
 	} while (key_down && !keypad->stopped);
 
-	pm_runtime_put(&keypad->pdev->dev);
-
 	return IRQ_HANDLED;
 }
 
@@ -167,7 +165,7 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 {
 	unsigned int val;
 
-	pm_runtime_get_sync(&keypad->pdev->dev);
+	guard(pm_runtime_active)(&keypad->pdev->dev);
 
 	/* Tell IRQ thread that it may poll the device. */
 	keypad->stopped = false;
@@ -182,8 +180,6 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 	/* KEYIFCOL reg clear. */
 	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
 
-	pm_runtime_put(&keypad->pdev->dev);
-
 	enable_irq(keypad->irq);
 }
 
@@ -191,7 +187,7 @@ static void samsung_keypad_stop(struct samsung_keypad *keypad)
 {
 	unsigned int val;
 
-	pm_runtime_get_sync(&keypad->pdev->dev);
+	guard(pm_runtime_active)(&keypad->pdev->dev);
 
 	/* Signal IRQ thread to stop polling and disable the handler. */
 	keypad->stopped = true;
@@ -207,8 +203,6 @@ static void samsung_keypad_stop(struct samsung_keypad *keypad)
 	writel(val, keypad->base + SAMSUNG_KEYIFCON);
 
 	clk_disable(keypad->clk);
-
-	pm_runtime_put(&keypad->pdev->dev);
 }
 
 static int samsung_keypad_open(struct input_dev *input_dev)
-- 
2.55.0.795.g602f6c329a-goog

