Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6B3CF1FD
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025889; cv=none; b=gztfqdHWwO2TjePFvwU2LL10j6SFrwVBNG5zBK4aAYjVMnfnMkryD2yec6M3/ZPL2EVZvRcb4om3OZ+kKeeh1YCw28GEcsZj5zJLVwo1urB6r0QuEWd/mLBfHnWgSRqPND+FXr+LiKuTyIn32z/GZQEvSHB1VTCG51tikSlKFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025889; c=relaxed/simple;
	bh=l69W+EZyKcniq5PZsld8TXXYYTWhjdq7srB119n5Ffo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fmh5LFlqNP3qxXLgS1/evrGDWa/oe5orrWz4k+OAt7Cj45pIOSC9k7f2oUA/JFPNDcpV22kvhYbiSXNPWLBdRET5zj01G19eQoCh9NWKbow/5SIFamEzb92zcgc4gQg51Qf3poRm8lf4SGJORnmhEhTjlpsWZ0ZAdnRFkWl9mkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqbikHTY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqbikHTY"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so3387505f8f.1
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787025886; x=1787630686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nn7G0bTuEpDi1wZUhidIQw3y0bqpyr7xiuj0he1hLQY=;
        b=hqbikHTYoujTPzs24hPAHr8lGi6h/1Vad2FXbSdQfRfsQ2JANtF8+hF2sXvA0nKse9
         WqTyrWukdqof5mefU4UyoXpN13JRX7WzXFAjAH3cvaLl05UY8tmZlaS9M8Q3IUb5iqU1
         vI/bl6CCcXOPbcu2MBNUmULQlfmX8VhaazRM/bjVn16sm14CLptprrNA7sJBOqzVHSTP
         ZlaWk92P+j1GkBbjEPRzWTL2/CGxjaqJVwI3GR8OyUUV9gAoCPz1z0uM1nQ1ylg41gXE
         wc/KEuCQo7uiXTKzsomfMkOkclQcuofqGScPtP7D5fV8MnUokEr9dyyqLv7T7qebl86x
         0L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787025886; x=1787630686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nn7G0bTuEpDi1wZUhidIQw3y0bqpyr7xiuj0he1hLQY=;
        b=O1Y7iUSP994NHNSnpUHui9VNkRVZY6aFOY94wJisjHDCsb5qJoo4pDDwoZvOwCVZyu
         UAfABxaR2zIAd6Kx7bI6GAfBjeKJmrmNgKH3fFKEz1Db2y/6w/LjuqChz0DVRYCV1O02
         YWG2NXWyCjS+lrxotY0kuJEYYARRYNphKxDvS0mEqd7k5dpAMifi2lcqBx4OTdjfLp7y
         WlBFMEcQgNixxdXf1OtR5qVy+DAqTkHbzQCbrw/r+P34oXRBaYn4MAF0Lr/z7KNuIUMo
         7/gQrANoKjlBwmOfkRpiU1oNoET5MafpeWUBv2Nf8KldFfK/dfURTtGTiGFb68nUyEZb
         INEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2NleTP+vXKzYv2UUA2zaKNFr6q1H9wnP9GjdxSQZi+0gb02gWW3kOwuPpfCJWnsLkLYEdKQW1IB8uHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rXQmiGD7I82/6X9i28dIWq8ug590mIKW2Cm57GmP8wQm7DFk
	FFCTWxyV/MZuAXar6zeYj4tos+dIorWwI4DSz7VeVzj/leX7swmk6Nu7
X-Gm-Gg: AR+sD11fquskA8xWZ7pmekcix2Cm+1wZih0lWKAt0VlkqovGok/SGCA8fYHYebC0B13
	3THQoNtrhMI3OBlea+vUimCe+Nft9EqfvFx3fbFRm9oSOCLE6VLdplMsd0CWSusHVkGi7g73gSd
	C4SEv27TBRX1TVUy01mNRPHJzMVBbcMgWMj6H/NVwDMKXlvlISAOd/DMFVQLwPyvgPN3l4CpLzI
	iFBnyKTly8yQ0f91ghS1hGZyubZjhVVVxn3Lb8JLrHvVSr65SnFEST9ZPn866O0rxnYTyoGwqGf
	tsbadba1JMCVvyOt/BnSIU+HvGQiCtac2gR3ZYQUhFq4oNazOGUbBAaXtk/g4o5nta0GZniMuUB
	LCzc46hc5BOVEI+jNwy9yJ1gsH2f9GnN0URe4eRMCZW7jL82SXi0MF5HyQzdu/pKPLVXiRf1zXq
	WLz0sI3si3zHp2DzfR821typ15PRuSUAZdd6eShaOiIOkiVNUG5l7RfjMJ3WSd4YQZEy9mI6Vcb
	y4f3kT93ftQ34CUQcm1I5Jse9TUtpKyOezJsgmNhA/AlDPqiEBkI+xML6aQKym0D7WobqEA4OOC
	qFQHoZeotFKvf6rbXBTtRyNK+tq1W7CfLUXbo47xNv2IXwpFBfgXteRXsMp3YOxJ2727y7TlgP6
	MzEDQzhA/
X-Received: by 2002:a05:6000:601:b0:47f:e721:1f77 with SMTP id ffacd0b85a97d-4816075ebdbmr48326885f8f.13.1787025886196;
        Mon, 17 Aug 2026 21:04:46 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a88f-5701-94a8-6746-801e-fa61.310.pool.telefonica.de. [2a02:3100:a88f:5701:94a8:6746:801e:fa61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm9030108f8f.32.2026.08.17.21.04.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 21:04:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virtio-mmio: synchronize callbacks during device reset
Date: Tue, 18 Aug 2026 06:04:32 +0200
Message-Id: <20260818040433.66986-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260818040433.66986-1-kmehltretter@gmail.com>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_reset_device() promises that vq callbacks are not in progress
once it returns, but vm_reset() only writes 0 to the status register.
A callback that has already entered vring_interrupt() keeps running
while the driver tears down the state it uses.

Wait for a status read to return 0, so the device has stopped raising
interrupts, then synchronize_irq() as vp_reset() does with
vp_synchronize_vectors().

Fixes: edfd52e63672 ("virtio: Add platform bus driver for memory mapped virtio device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_mmio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 510b7c4efdff8..a2ca03dbe803d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -55,6 +55,7 @@
 #define pr_fmt(fmt) "virtio-mmio: " fmt
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
@@ -254,6 +255,11 @@ static void vm_reset(struct virtio_device *vdev)
 
 	/* 0 status means a reset. */
 	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
+
+	/* Wait for reset completion before flushing callbacks. */
+	while (vm_get_status(vdev))
+		fsleep(1000);
+	synchronize_irq(platform_get_irq(vm_dev->pdev, 0));
 }
 
 
-- 
2.53.0

