Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F884377ABF
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845989; cv=none; b=ZSrI+5fP+aFFfph1FJ7ZTFFpe2JoNjFghYMKbjYh5fabzvIedPqmcEn8rBuje74bo8TPicniDCPzWuXw3nAwyzgEVsMpsWcIj0RsJDxSIkjZANQjWBYqqdjZfgGgDmCJmCwqpFxiIOKwfulgdWaJKTBYYDnEofbgdniISFqC3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845989; c=relaxed/simple;
	bh=PkogetTRkUDafLifysmf44FPwJ2N6pmK+olIC+Y8gdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aW/JYNCBT2r+9zwS4l8PHIGwQHAOgDRgs/n+MT5J0i3rGXxIqV14U3QGGJoW0iAZHU3iFaAdBRmC3tjbCrbWnxBcFIktnpi1cFp/OUoxMc/AhEqOZXaC9Z/4Z5fimB2XQVT2uRhEc4jmti/MyHivxkHjwzKBhejYO9yZNW8TuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPxUVUoq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPxUVUoq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49557167508so50739115e9.1
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845983; x=1789450783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0xn/sQ1syzuU4VFJfjc1woEjzltXnI10QEuTRC1ag8=;
        b=aPxUVUoqrsoMXcgBoItTO2U9EeEn6I7bwayIUsMdkXCXsSLbjN9RqwmRId5rBPBRux
         7QMCDsPgp3eeQGvDt9uQdbAHLa1hi9RFxQhRC5D6mZ28XC6fdpTr6TCsMAp/TMBlXaz5
         BGPqRepNqeBbMHt4IFH8Ea5EbZLEurpA96ib54YHVvYpEc3iPzqmCuzMMxa1m05mgGU1
         lHYbgmaG+6L6PuFoFHx8DC2rGb7Uf49K5qv39oPEB3IEy3WmqggeIhXLSVcctBiGLJps
         eeQ8aaHRgm+NNKJ9VfKkEVhfKkYvSuVO6LWmhNXUp9yOeTTEUjkV/GyyYSgZdBmy/KF5
         DHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845983; x=1789450783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0xn/sQ1syzuU4VFJfjc1woEjzltXnI10QEuTRC1ag8=;
        b=LCSHYcYXA2BtHVsUtLVh09xYKMa1s/ljMgXZdZ4KeZG1DihRWiGN8vR1+6+f01wDqQ
         FoGBpgznttlaZqLuEbQu97aLzixnw8GiBI+ucQtvyMwX8/d9XJBRqb5hbFClN/hXyakj
         TZSIysWvCE4n7auIQSe2IeKBOCoKckJItasvPnVp25kibwYS921dgBuglVJGg8TWT/sm
         V31rmuw0ovqcmt8/9wgP/kNRScsuiw3XBjcq70Kt3Qs2g2qVQQvj1pTAUhHoCZD/TEHd
         RdyRzpCtmrgMKKxYpNtRxng4KGoHd3aNE2wl384eu3twpdfIeIIDTxsupcBtX+y7xJU3
         gvGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxahPtjkb1Vmhi5i39ZxxPvA/MclG/FzQ0YoKuYjKHzRTGs2lB0W1PsjTXSdcTOVn8Y1S1aGOG6B+sgbw==@vger.kernel.org
X-Gm-Message-State: AFuF++m80wUK/DVZRlpIYwT/0Q4nbQ3WICjKEevwUa2ufWOZudQXwdd+
	JtcrQ5SWo5QbriArC45DyFC4NuwYpaxLo9TwqbViil27gmr7jeNSAiar
X-Gm-Gg: AYBFou0PWXjq0VzUZjRaKXTm1IwZSWHeCKavzKSKPgjGhd+Qvywg8G9yc/APRpdaM3E
	hiYoBt5afPmWpVtiimRLdzY4hu8RP4xzgV7WHAwr8Iw8/sOR4EOpF/oaySMZilus9S6Z3LVzZPh
	/nWUdeHeHhVIYDbY+frIS16//1t0ps/Z1MfUrB0zojXviU8XK37DU7h1EYWktd5AKpWf9+jpdLD
	t79eLu5nbCPTJE1LlpoE1jfJBaXycAu8SufT02CdFs7dZJa2/igluYUoYcUCqJASvjJQ+LpjTTZ
	0DDzOdP1VrPbkt5xMfuwPw4ZkEt3VqW5iKirm1PySUlw/N76LuxIZPn6pIH17wF2iRQ0hd7zLtG
	0mO+139wt4sB690Y9djbGbaLlfwMmHO0ANprBngPb7JqlTnCs6Nk+yRP/I+1vwCaUwXuU62IuO+
	ByCQqHuNloQbNQSzvIxhjRRvIZ8up+n25yJ9CdJ5IbpifzDWte9v/urKY9bCV8HFceYXVy8nT68
	swl9cdac6cRVyLVa0Cgz1n52HT2pQk6FPGOg24Q3EQqSfF9AO922djH8ISGAk2V4LRUBy2cpHYZ
	+uxEXF6qqYoeWRV9noWSNvI3tQ77eb4=
X-Received: by 2002:a05:600c:3f12:b0:49c:c8de:96a9 with SMTP id 5b1f17b1804b1-49cf7fdd2dfmr526948265e9.2.1788845982788;
        Mon, 07 Sep 2026 22:39:42 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:42 -0700 (PDT)
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
Subject: [PATCH v3 3/6] remoteproc: implement synchronize_cbs() for virtio devices
Date: Tue,  8 Sep 2026 07:38:14 +0200
Message-Id: <20260908053817.26065-4-kmehltretter@gmail.com>
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

Platform drivers invoke rproc_vq_interrupt() from hard-IRQ handlers,
threaded handlers, and work items. Because rpmsg callbacks may sleep,
the virtio core's synchronize_rcu() fallback does not synchronize with
callbacks across all these contexts. A device reset can therefore
complete while a callback is still running.

Add an SRCU domain per rproc. Protect both the queue lookup and
vring_interrupt() with it, and synchronize the domain in the new hook.

__rproc_virtio_del_vqs() can race with rproc_vq_interrupt() too. Clear
all queue pointers and synchronize the SRCU domain before freeing the
queues, so callers that already found a queue can finish using it.
Read rvring->vq once to avoid a second load after deletion starts.

The SRCU domain has the same lifetime as struct rproc. Its cleanup can
sleep, so document that rproc_free() and rproc_put() must not drop the
last reference from atomic context.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/remoteproc/remoteproc_core.c   | 12 ++++++++
 drivers/remoteproc/remoteproc_virtio.c | 37 +++++++++++++++++++++-----
 include/linux/remoteproc.h             |  3 +++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f003be006b1b..6756f2fe4ec5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2367,6 +2367,7 @@ static void rproc_type_release(struct device *dev)
 
 	dev_info(&rproc->dev, "releasing %s\n", rproc->name);
 
+	cleanup_srcu_struct(&rproc->vq_srcu);
 	idr_destroy(&rproc->notifyids);
 
 	if (rproc->index >= 0)
@@ -2464,6 +2465,11 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 	if (!rproc)
 		return NULL;
 
+	if (init_srcu_struct(&rproc->vq_srcu)) {
+		kfree(rproc);
+		return NULL;
+	}
+
 	rproc->priv = &rproc[1];
 	rproc->auto_boot = true;
 	rproc->elf_class = ELFCLASSNONE;
@@ -2526,6 +2532,9 @@ EXPORT_SYMBOL(rproc_alloc);
  *
  * If no one holds any reference to rproc anymore, then its refcount would
  * now drop to zero, and it would be freed.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ * atomic context.
  */
 void rproc_free(struct rproc *rproc)
 {
@@ -2541,6 +2550,9 @@ EXPORT_SYMBOL(rproc_free);
  *
  * If no one holds any reference to rproc anymore, then its refcount would
  * now drop to zero, and it would be freed.
+ *
+ * Context: Any context, but the last reference must not be dropped from
+ * atomic context.
  */
 void rproc_put(struct rproc *rproc)
 {
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d5e9ff045a28..7fefb4bd7adc 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/kref.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 
 #include "remoteproc_internal.h"
 
@@ -88,15 +89,23 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
  */
 irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
 {
+	irqreturn_t ret = IRQ_NONE;
 	struct rproc_vring *rvring;
+	struct virtqueue *vq;
+	int idx;
 
 	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
 
+	idx = srcu_read_lock(&rproc->vq_srcu);
+
 	rvring = idr_find(&rproc->notifyids, notifyid);
-	if (!rvring || !rvring->vq)
-		return IRQ_NONE;
+	vq = rvring ? READ_ONCE(rvring->vq) : NULL;
+	if (vq)
+		ret = vring_interrupt(0, vq);
 
-	return vring_interrupt(0, rvring->vq);
+	srcu_read_unlock(&rproc->vq_srcu, idx);
+
+	return ret;
 }
 EXPORT_SYMBOL(rproc_vq_interrupt);
 
@@ -153,7 +162,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 
 	vq->num_max = num;
 
-	rvring->vq = vq;
+	WRITE_ONCE(rvring->vq, vq);
 	vq->priv = rvring;
 
 	/* Update vring in resource table */
@@ -165,14 +174,20 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 
 static void __rproc_virtio_del_vqs(struct virtio_device *vdev)
 {
+	struct rproc *rproc = vdev_to_rproc(vdev);
 	struct virtqueue *vq, *n;
 	struct rproc_vring *rvring;
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+	list_for_each_entry(vq, &vdev->vqs, list) {
 		rvring = vq->priv;
-		rvring->vq = NULL;
-		vring_del_virtqueue(vq);
+		WRITE_ONCE(rvring->vq, NULL);
 	}
+
+	/* Synchronize with rproc_vq_interrupt() callers that found a queue. */
+	synchronize_srcu(&rproc->vq_srcu);
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
+		vring_del_virtqueue(vq);
 }
 
 static void rproc_virtio_del_vqs(struct virtio_device *vdev)
@@ -242,6 +257,13 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
 	dev_dbg(&vdev->dev, "reset !\n");
 }
 
+static void rproc_virtio_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct rproc *rproc = vdev_to_rproc(vdev);
+
+	synchronize_srcu(&rproc->vq_srcu);
+}
+
 /* provide the vdev features as retrieved from the firmware */
 static u64 rproc_virtio_get_features(struct virtio_device *vdev)
 {
@@ -330,6 +352,7 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
 	.find_vqs	= rproc_virtio_find_vqs,
 	.del_vqs	= rproc_virtio_del_vqs,
 	.reset		= rproc_virtio_reset,
+	.synchronize_cbs = rproc_virtio_synchronize_cbs,
 	.set_status	= rproc_virtio_set_status,
 	.get_status	= rproc_virtio_get_status,
 	.get		= rproc_virtio_get,
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7c1546d48008..93a182b1868a 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -41,6 +41,7 @@
 #include <linux/cdev.h>
 #include <linux/completion.h>
 #include <linux/idr.h>
+#include <linux/srcu.h>
 #include <linux/of.h>
 #include <linux/rsc_table.h>
 
@@ -256,6 +257,7 @@ enum rproc_features {
  * @mappings: list of iommu mappings we initiated, needed on shutdown
  * @bootaddr: address of first instruction to boot rproc with (optional)
  * @rvdevs: list of remote virtio devices
+ * @vq_srcu: SRCU domain for the virtqueue callbacks of @rvdevs
  * @subdevs: list of subdevices, to following the running state
  * @notifyids: idr for dynamically assigning rproc-wide unique notify ids
  * @index: index of this rproc device
@@ -298,6 +300,7 @@ struct rproc {
 	struct list_head mappings;
 	u64 bootaddr;
 	struct list_head rvdevs;
+	struct srcu_struct vq_srcu;
 	struct list_head subdevs;
 	struct idr notifyids;
 	int index;
-- 
2.39.5 (Apple Git-154)
