Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E0381EAB
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845994; cv=none; b=qIDsC2W/Gu6+pTIZuApAAYKbWdPTmePzwdBqnbInUttZ2keAd5jNsO3Th47L4sN8Xt8MHPC/FvGCboSkv9l3OGbxP//7aZqznUSQejla5evZbixenLGs0Oz0LVDa3zIK8iTHOldoBAcbPzSwtp7y2kFrhT7WB+BhbAJ8Au+0RnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845994; c=relaxed/simple;
	bh=Z1mqy3qNtdRxgKwEWqMkljOG1k4ekHUKiS2/6Ca17Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJyOx2OwQTsHHrQ+7X8hICTOcyseKhsmbYbsDsWk9Cb6Q5X7GaAOtwV+0XviX8taKc/S2UKHaBgoTSiT/2phMGEodTkv64+HLPsYyiUxoYawdqBTpznvehVZj0yJHxSKbZSGTQ6R/FqOP2YEJNpxYRM93c2/lUYuzDhmFLvHa+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmjpCI8s; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmjpCI8s"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso40940865e9.0
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845988; x=1789450788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0UrpxibHZnDBNXE1bN5qrJqc7sTw2Bd+aGpZLtd0Ug=;
        b=UmjpCI8s7t3E+4yRhKMceIDOKBrqYNOKBZjVaryoL+Wx8/5meM4sQ9XpZurZfH3zlS
         fm9dPFfnx8NWhVMpEnO10cGpwzMYuIbKyGY2YuHQfXYqFDhg6uepkDSAbaDSU9HEDtlu
         MwjTnuF26Niwb9CNviqGtmx4WwjStW+BJ1nPjnxMHE5c1ZoVPpi7WYhT0dm2ReieAxbi
         CEV1OpQOMg3cbWpcFghWbSrBG5sOmvQMxBpbpHBVK0haUEZzsGRlCb+OqTdIr9oBGio4
         6sDz2wkoyVcw+4UAETBV79kQRFAvgWv6+QUPewowi4qDn3CuhbBW78rMGb81BCHJCwo1
         IlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845988; x=1789450788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l0UrpxibHZnDBNXE1bN5qrJqc7sTw2Bd+aGpZLtd0Ug=;
        b=p0d3RjXHh55TMi6L1p97l6WGqoxh6N6fZwOhwN646mOsqroJY6NkIsPTuKNhTycAmN
         r4bQZ7dClV/Yq4KpJgwDoCKbWbGqPh2Q2T/S6INGZ48lHtAn2Zj404a4FEQcG44PmiX5
         hzw3ccKAmfb6wvWD/HPSI0xzBpfTKWXQHxwPvVRLGoL0kCXEv9WCkmp7EffifMdyjV0b
         cYwt6zuAbiy4mLsLAxP3gfdCI6AfcPHHDRogD3sRT0jWST706yB0jegkYkaL3xJ1eVKy
         nfJd/KYTiiAT4HTMk/4NA2er7hBBVxK037/I6VTwHrxxnmif1dm9i9QXKHdTLZMo02Xh
         t+Fw==
X-Forwarded-Encrypted: i=1; AKwUvBzVTzu8sKQj8idCLx1fbyhkP6ODGo+OPNANJB4pvJyJIUcKDSBmyXitZNH5YLl26DpjEbVrV49TRsGOdQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mCPdeh/KAZKKKdy8CzNJlInk58XDaqi2vBgS8bHdQmU43WYlik
	Zfvwk3pX/PETqkrrLRIZ1DgaEf21SX2r8RURGdtWwHz7gfqOpYu4khjV
X-Gm-Gg: AYBFou3U5x/16pE1XDoGtiD5nXXzDYaxzissM2bwDaAJmmvfw1y08tmRG7HbnvAie8x
	prWmgBlkAsm0fXGaJgD0AkIEZlCapiNoK38m6gOxcj0N/bUkQU9aWH8CJ8mZHSnKyXU6QOKJLPX
	KNUVH208go7DD7j8yFAi5c6UGUVrcU4KNZUuPKQAPK1gd6eZiSsqHWG9c3ASxIJtPV44EDGkRbo
	BF1Ym9u/sgvAG9Y3WC6Pu4nspRJISpJu26+XwG8qMrzuoApESQ+C/P5J3Zq+mZrCXcSRjDJIUPK
	cUdSR1kZ654WSs7uxo1oSbNnbblrog1gzNEpc6coemwC1cafbRcywJCvocsgjX67uX2PuiK5SHI
	4wQKnanfVknawYwdv1ziS2bLxycLA5NWg8Vg0t5NkqqMGp5fCRlP9fE9qTgHJlcUESJKZK1Zdco
	Ex37TWB4d02WxxoSdo1JO5J9MTERnRMWu1tknumgcZuJIYLoLAoyeWI8Jowqb1GdCjcmpMaw6QY
	9VE269R/E/1vmFrFM4S/z0mOVe0YIRCE8nIVWzrT0MIEMzF2sInwQmv8+Fe/preSQNffVPNsh8C
	O1sywKT8nXLHzWPmNxLA+IK6K8uQqkI=
X-Received: by 2002:a05:600c:3587:b0:49d:17d8:abec with SMTP id 5b1f17b1804b1-49d17d8abf5mr31972855e9.21.1788845987998;
        Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 6/6] virtio_vdpa: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:17 +0200
Message-Id: <20260908053817.26065-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_vdpa relies on the core's synchronize_rcu() fallback for callback
synchronization. That covers IRQ handlers and sections with interrupts,
preemption or bottom halves disabled. virtio_vdpa does not enforce any
of those contexts when a vDPA driver invokes a callback.

Add an SRCU domain per device and enter it around the virtqueue and
config callbacks. Implement synchronize_cbs() with synchronize_srcu()
so it covers the callbacks regardless of the calling context.

SRCU uses per-CPU reader accounting, avoiding a single callback lock
shared by all queues. Cover the config callback too, as virtio-pci
does for its config vector.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_vdpa.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 6bcf4567a929..f9559b6b2e0b 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 #include <linux/uuid.h>
 #include <linux/group_cpus.h>
 #include <linux/virtio.h>
@@ -27,6 +28,7 @@
 struct virtio_vdpa_device {
 	struct virtio_device vdev;
 	struct vdpa_device *vdpa;
+	struct srcu_struct cb_srcu;
 	u64 features;
 };
 
@@ -114,8 +116,11 @@ static bool virtio_vdpa_notify_with_data(struct virtqueue *vq)
 static irqreturn_t virtio_vdpa_config_cb(void *private)
 {
 	struct virtio_vdpa_device *vd_dev = private;
+	int idx;
 
+	idx = srcu_read_lock(&vd_dev->cb_srcu);
 	virtio_config_changed(&vd_dev->vdev);
+	srcu_read_unlock(&vd_dev->cb_srcu, idx);
 
 	return IRQ_HANDLED;
 }
@@ -123,8 +128,22 @@ static irqreturn_t virtio_vdpa_config_cb(void *private)
 static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 {
 	struct virtqueue *vq = private;
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
+	irqreturn_t ret;
+	int idx;
+
+	idx = srcu_read_lock(&vd_dev->cb_srcu);
+	ret = vring_interrupt(0, vq);
+	srcu_read_unlock(&vd_dev->cb_srcu, idx);
+
+	return ret;
+}
+
+static void virtio_vdpa_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 
-	return vring_interrupt(0, vq);
+	synchronize_srcu(&vd_dev->cb_srcu);
 }
 
 static struct virtqueue *
@@ -440,6 +459,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.reset		= virtio_vdpa_reset,
 	.find_vqs	= virtio_vdpa_find_vqs,
 	.del_vqs	= virtio_vdpa_del_vqs,
+	.synchronize_cbs = virtio_vdpa_synchronize_cbs,
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
 	.bus_name	= virtio_vdpa_bus_name,
@@ -454,6 +474,7 @@ static void virtio_vdpa_release_dev(struct device *_d)
 	struct virtio_vdpa_device *vd_dev =
 	       container_of(vdev, struct virtio_vdpa_device, vdev);
 
+	cleanup_srcu_struct(&vd_dev->cb_srcu);
 	kfree(vd_dev);
 }
 
@@ -467,6 +488,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	if (!vd_dev)
 		return -ENOMEM;
 
+	if (init_srcu_struct(&vd_dev->cb_srcu)) {
+		kfree(vd_dev);
+		return -ENOMEM;
+	}
+
 	vd_dev->vdev.dev.parent = vdpa->map ? &vdpa->dev :
 				  vdpa_get_map(vdpa).dma_dev;
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
@@ -489,10 +515,12 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	return 0;
 
 err:
-	if (reg_dev)
+	if (reg_dev) {
 		put_device(&vd_dev->vdev.dev);
-	else
+	} else {
+		cleanup_srcu_struct(&vd_dev->cb_srcu);
 		kfree(vd_dev);
+	}
 	return ret;
 }
 
-- 
2.39.5 (Apple Git-154)
