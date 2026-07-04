Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596538F252
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144685; cv=none; b=gW0vlKwvYV9na+XTyAi8uehMVpFhYaPIEMyxQjk/ll/ZrYHZO3mOMWhcknfTvZ1+6dwVTdcj3TuzerVV59qmby1wih79NVr3E3ErJmNb4rEAnQSsnvtIvZ69OMSBiUWIncyTUkFvT1ovB/pzMA7NoEwyiwlFzXskNko1yN/HXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144685; c=relaxed/simple;
	bh=V7CkaRPOt1AB4wPWz8UHYq4OEut/rxvDywdfYXf8K4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqqMZTNGDgTdECAk0hMKVdAmXaPl9fjuR4F3hgs/mIrZBbwLRwrWRIJzqpFjuj0EeT9nsNxpeuZQL2zbigEYYb0+Tm0LzozLBKovYg4H5YJVAICaA4KaA7QTNjXiRTbFqlZXvscYCLDX2r2y8INyP1LgTNVYvMb26agbge/dEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2DIkKEn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2DIkKEn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3804e42ad5fso1432054a91.2
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144683; x=1783749483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVPHekxxTvV9T4JJnXvyVv5aZspg0AcEDMfkFw+e5yg=;
        b=Z2DIkKEnmWmQdPCZy4SOgXji9aGF8gMC5wfYdELsK2ltymvfgvplRed4ohbVuV1w5Z
         xj9FXhsUyZF3fSrErQ2bfwvmmJVni/hz6+OLWX42Qs4xphe0Y2O6cNgFVIrv1L2FlYIv
         8lNojS+YcyQa5Rm6mvehFyGdnqlSJCIimWpaGHHeNVpZgEfsrTXv0BD6EIu09720ngDv
         of7sSvrauL0SG5csBAbsLmxp9JHMCERZO/yOh1KzNqNtOejkwD8oPn/Cs/PTlfRR7fJT
         L1FXfazCUnxtR1Cr7efG8NOtoVueqbsUjCcNMBhl5I+Br4pnbr2kxisany3cNGQSuDFv
         eZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144683; x=1783749483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVPHekxxTvV9T4JJnXvyVv5aZspg0AcEDMfkFw+e5yg=;
        b=Veqgr4jLJXMyVruRiqThhNhi9sZzrw2dyuSuZxahGQW2cJ4ETIgMe4vEleil4gBhUG
         GBxEdbCUGZ7bU5UbHsbAdey5zjoEEXuLCP8Q/1NLtJdg7qwh3HSm3u6ZIoRsq0uYq0fR
         6Siv1XEdCoBOFmJH8KfOeAPEJKSpZOy41N9FuttsfdsOKTbCpnxYoeNAmH/GPLHug6sV
         qZDZD6ePIuIhMApgq8H7yiQLm3sl+dYvEtNhl+SVTsL2YEbwlC23fLVNYt2HbnuZq1cn
         J4amujJYFxCEEtUIt/b5ZvULxwyMBdMQA30yEHGjeje+50EoTox57ikl2g1CrPSYSyRk
         YkHw==
X-Forwarded-Encrypted: i=1; AHgh+RpsoD+MKVLtJzYlGWsGgx625AQme1L9YMaG40sOLNnNIX22hsqRZJJLaYeMzJv6MIvhzBHLYqXV8onxTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFsh88bmHIW2HIgOp1YHZDhyfr1Z5pYlVOEDgMAXP7gUvfWYQ
	eIzLHIFe6jK5k2y56l2OLoTqdbzJacQ8BGVxuXDYxMitnH7payaqGL69
X-Gm-Gg: AfdE7cmbcLzbeRme174Cf2RuwV52SE3ZESTLLoWBZnadZlp8gJXav/eVKuatNKsCbpQ
	vnNVtJEfDwXoa+iQUbJplgx0BG7GQ2zGk/Tq5/WIxuu+UPAjgt47DsZ8/mgtrTKMHkwSSGKHrSX
	AN28jRiKAJ20BPvGnB+0y/tZJ8bohntDgp75n+mVfVvwredZKQyCTDnwA86D9Rsi7y5SHUp0ARr
	qOPbVicSrlz8/1bf2n/LWepkrsutQOr0vxHIXDap2m9THRXAt9T/AKJqIDiMrYN762PN2CvyxuX
	fD0RcUHS+wmw3YvBkd93VEmtIi0aoqTUFwCjYSTabalazM0ytGzcktfVi2aildzG5TSG0sxYUZi
	TjzOIW6/1I906GX6LrbnZZRN8X8SpZrRHmfDyJTAQX6RfHvWVYeyamoVocCMJGgXbjw5Q7hQ6bX
	AOlwbDka141Wq1v7tVQl/HHzs45WcNTUQWSldO3qPWtWsVT+Eoj1tUt2ly238HJUt2gEvzwV2qh
	C6Nf4XtvbE1pw==
X-Received: by 2002:a17:90b:224d:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-3829eb1d7a8mr2296385a91.16.1783144682891;
        Fri, 03 Jul 2026 22:58:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:01 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:41 -0700
Subject: [PATCH 18/26] sh: maple: introduce callback_mutex in maple_device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

The Maple bus core invokes client callbacks asynchronously from a
workqueue (maple_dma_handler). If a device is removed (or closed) while
a callback is in flight, it can lead to UAF bugs if the driver's private
data is freed.

Introduce callback_mutex in struct maple_device to synchronize
callback registration/modification and callback invocation.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/sh/maple/maple.c | 9 +++++++--
 include/linux/maple.h    | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index c0715e3ace6f..7c82b7a8a280 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -121,6 +121,7 @@ void maple_getcond_callback(struct maple_device *dev,
 			void (*callback) (struct mapleq *mq),
 			unsigned long interval, unsigned long function)
 {
+	guard(mutex)(&dev->callback_mutex);
 	dev->callback = callback;
 	dev->interval = interval;
 	dev->function = cpu_to_be32(function);
@@ -230,11 +231,13 @@ static struct maple_device *maple_alloc_dev(int port, int unit)
 	mdev->dev.bus = &maple_bus_type;
 	mdev->dev.parent = &maple_bus;
 	init_waitqueue_head(&mdev->maple_wait);
+	mutex_init(&mdev->callback_mutex);
 	return mdev;
 }
 
 static void maple_free_dev(struct maple_device *mdev)
 {
+	mutex_destroy(&mdev->callback_mutex);
 	kmem_cache_free(maple_queue_cache, mdev->mq->recvbuf);
 	kfree(mdev->mq);
 	kfree(mdev);
@@ -655,8 +658,10 @@ static void maple_dma_handler(struct work_struct *work)
 				break;
 
 			case MAPLE_RESPONSE_DATATRF:
-				if (mdev->callback)
-					mdev->callback(mq);
+				scoped_guard(mutex, &mdev->callback_mutex) {
+					if (mdev->callback)
+						mdev->callback(mq);
+				}
 				atomic_set(&mdev->busy, 0);
 				wake_up(&mdev->maple_wait);
 				break;
diff --git a/include/linux/maple.h b/include/linux/maple.h
index 641cf3330409..48ed7558b8ab 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -3,6 +3,7 @@
 #define __LINUX_MAPLE_H
 
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <mach/maple.h>
 
 /* Maple Bus command and response codes */
@@ -75,6 +76,7 @@ struct maple_device {
 	char product_licence[64];
 	atomic_t busy;
 	wait_queue_head_t maple_wait;
+	struct mutex callback_mutex;
 	struct device dev;
 };
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

