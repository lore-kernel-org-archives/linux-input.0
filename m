Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663E4B04BA
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621686; cv=none; b=CQg2ezmqVCZbMz3pFmt6xGaQFVhlo60uDbyDQfS3xJVS05QVcBiuLhjTxXzpwlTkrZPeUQB0KOLlfnTPSGJfTwqxRgRBbQzbTOKIigskeMgM7RhXgGOvTtEaJqtH5stXT3rrf7kMxPAnTBNuOMWCcBLczCoJiD+mTJBQ9hEgYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621686; c=relaxed/simple;
	bh=eXG5r4mV6mtliuq56rwsHZv1ZiQbQWPta1t7fNcCzjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJ7JH+gB1Dbi+zn2MmF5DOvv3kAsbKbrTNPtOB41Ma5Jg9ouXRNsHLO4mr5H4kx3lUdKKM4G2cElAaDxCut+50f1EIoyzt/4k2JWs5UQGz6waXanGWlf+ZpSoUFqBBtdE64hdpqd16XLOc1GPTJaLIvJoos/94/g1iwNQKT+ijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKwDBaR+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKwDBaR+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so18117955e9.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621679; x=1789226479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=KKwDBaR+xVoJNuPew2OPxzm00SvEId9Hgpcslag6yAa1f+7i34VUFHTw5Z5mpCZYF2
         00KfOp+vgRP5EYe/z6D4Myq+2L2nZAWMygqyMpDtcMMDUaqZ/rjDsQg2xTyRV7OwzplS
         EL140uDju05eBMwgpSzR5x4sqtSDz/kxs282bJX1sUWzdt/Z1t0oHjy3AHOsDZiF+GjS
         QzQe4t0iW/YjAwBQm3zoEDNIEaO9B8LFs3uSLVKq9aQtZ1zr0WkYNz5jYdONYF+BkkAZ
         SuxVrZZSE9yvdy4zeudQ+xYJxtSlhu8pqC3bjoh16ZiZ1YNSlYswHhHQkydbdi8NmiiC
         lGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621679; x=1789226479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=hU1dAM1jQN8txHBqRjeDb6M1ly/KuEDQPFXGQtyyedRVbs5eQ0skR9I9U0ZG+2VRGa
         Qr/6/QdNa6E96x+jT+kFuyenPWRzMt3WZ6jc0UFH0bZLQ9lFGnC2XG5Sp6C5K4MOS4ig
         8Hxk3f+9wlS+5vVX4ukIa9cGig8F8XcsQ6UEvPksfRxeMOYnG8576O2QAotfY9tSvRne
         aGElswBEpr6c6ketEDaFN8rnozPjIjPZNEKJmInR2jeB5MIMJr+JcShy0HMpMeNjWJrp
         pKVNUlomxFMJzt2DrUqoMdm2aIxDgKz8Az2xHjuRbyEfQNVamjTzEu5F1Hb58VeKPZ+z
         J8ng==
X-Forwarded-Encrypted: i=1; AKwUvBybpN+qB0TuoUl8SBCHnC7H6jsnEgrcJuHAl2/x7cPp9K8wXlat0y/PztG+k91PO/zXK0Y+zlUtzWUSqg==@vger.kernel.org
X-Gm-Message-State: AFuF++kAtUVv76x9SlRkz4a8O77A7cxiTGEDBcNdhW7dFPA7eU9DXVlG
	79NSKYFOYVLR487Cjp81AWOg97Sn/bXjMh/MbLSLeyC3cXF+QcOlAZED
X-Gm-Gg: AYBFou1wMaTpHkgN2tVdkGaoNBZk7R9Uz/rOtmQFsrTp0zFYXVkaWfQgK2dkK/F9RO0
	ir2mSKM+KVzCfeeLK+zdZKalEsepsBxDnt9IJQR5nHMjjLLKpMvSSQM+vznu9vPlw2AtYXymyvx
	FZXXv4vGljHlX/0dCfG2bpks4Pwfc4f6HSLCBmctlsFaWSvPQMEhjJNgXZGYV0fbjIxyaGUrpac
	dwdtlLXM9FQl/fcaROAaL5+JOJUQUO3o6tEDN6piNZcnaF0X8q7pH8O1OKbyUPwurzm9VtM6Bjh
	XwYh8J3PX7VLbl91x8HOZ6C6RwNqZGKu/uADGEIE3KyPTNQiX4JcfcyL3VmApkLusJJ77VUmJ2/
	2oq8ARgtf99y7vQ+uD8Wt7C5DR4XziJfPDhMkswLLngmVR0XTJDpSk/OFmbqBBtEZ211tirDdh+
	gpQfcM9mJypD2Q3wJFeSo4h4Z1nqWtUfR+ONhwrTjK+LxxxkOc/4JOsxGxbgKnxSPvPwTWqkKVG
	ldQ1Ju3MxxCcLN58o4tOBtubSlSvGMGxHWelceyXf/A8B8AfPFs72egD6VbrnLFOEocDUrgNkXL
	G4eFZPDmqq+ZQ7dg8Us8j9ELyNtE34ytkvAUgrpy3weWNfRsywzQknRqSsG5f9yoHHw=
X-Received: by 2002:a05:600c:64c8:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49cf81f692bmr245105885e9.7.1788621678914;
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering input device
Date: Sat,  5 Sep 2026 17:20:58 +0200
Message-Id: <20260905152059.89560-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtinput_remove() unregisters the input device before resetting the
virtio device. virtinput_recv_events() drops vi->lock around input_event(),
so clearing vi->ready does not stop a callback that passed the entry check.
It can still use vi->idev, requeue buffers and kick the queue.

Reset first, as virtinput_freeze() already does. With the preceding core
change, reset waits for callbacks before input_unregister_device() can
free vi->idev. Recheck vi->ready after taking the lock again: keep draining
completed events so an input packet is not truncated, but stop requeueing
buffers and kicking the queue.

With evdev attached, input_unregister_handle() currently waits for an RCU
grace period, which also waits out IRQ callbacks. This masks the lifetime
bug on PCI and MMIO, but does not protect sleepable callbacks on other
transports.

Fixes: 271c865161c5 ("Add virtio-input driver.")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_input.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..7b654af0a42c 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
 				    le16_to_cpu(event->code),
 				    le32_to_cpu(event->value));
 			spin_lock_irqsave(&vi->lock, flags);
+			if (!vi->ready)
+				continue;
 			virtinput_queue_evtbuf(vi, event);
 		}
-		virtqueue_kick(vq);
+		if (vi->ready)
+			virtqueue_kick(vq);
 	}
 	spin_unlock_irqrestore(&vi->lock, flags);
 }
@@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
-	input_unregister_device(vi->idev);
+	/* Callbacks use vi->idev. */
 	virtio_reset_device(vdev);
+	input_unregister_device(vi->idev);
 	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
 		kfree(buf);
 	vdev->config->del_vqs(vdev);
-- 
2.39.5 (Apple Git-154)
