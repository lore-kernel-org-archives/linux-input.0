Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673927;
	b=F4MJWEOutSS/zeaXqpNSUpDf+yg6c1KC81jEdIpogHEk1hgEsNpaN/SZl0FZcxDCNQQQ
	 VrClGDd+coUt1pK8n8Juwb8hBc5OJF/37fTJ4IWHMT2t47IufZkPTJANkYKC+5esHyp6I
	 vg/HGmELL9mJysOevLkV0sREcDyUxMAbd5IRG6XRtfn2dRmNecuy8I/Zb7WF/X3TLclA8
	 9nInF12s/mzfLbG90q/Azgr758k/CPi4QvzIxgJxt1BFwJVl9mhxCTsFGXwB3FC3eiMgL
	 HqludwyephJdUCsrGG8ek3ViSCaqWpYeCT7z+dRe2pYRELlEdtvitbrB1aANgyz087Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673927;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=Z1b4LdluQD3phylo9nFQqJDe0PHo57hXdTtNXDTMnCw=;
	b=KOgYR0+We73RFU4NpTlrc7qgKcX05ktyUPoDPakHhFJi9jWCMY4Soso9Ydxp2yGQswJu
	 PE+c3IQZ4TdYyn5VOlUAsuwc4QTOMvgZh+gtqw61391JJZiFKnPqcwFbw/7cx2ox5/4F5
	 F2mAoAd2Zuy+vWsfQwge+II5eKGA/xR1kIG7VagqBUDaS8gOhohPARrK9grkVQUDwf6if
	 jyqIdI3ubLGe7fl+fPeao9scNDXIHPwqtVwlSWJ95TN75sXfDqV2FVccKajhQXD45vJij
	 9bRw3go/VDC0tJqnXKlAqJxuWs+uB+tjD4MPmviPdHxpRqT4m6j9tFgUS1Qgi4GcoDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=QHPeeCiN;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31944606A332;
	Tue,  3 Nov 2026 02:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31944606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=QHPeeCiN
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [IPV6:2409:8a00:3c11:dbc0:2581:8e:ca0f:59ab])
	by smtp.qiye.163.com (Hmail) with ESMTP id 534316a37;
	Tue, 3 Nov 2026 10:45:20 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:45:19 +0800
Message-ID: <179367391951.8187.17327354719079930667@stu.pku.edu.cn>
Subject: [PATCH v2 1/2] HID: bpf: synchronize hardware operations with device
 destruction
In-Reply-To: <179367391951.8187.14164894863012056170@stu.pku.edu.cn>
References: <179367391951.8187.14164894863012056170@stu.pku.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19f4c01ca03a2kunm153cdd6b10a853
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGRlJVkpKTR4ZHkkZQh5PTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUMaS0tBSBhKSkEfGRhLQUlOQ0pBQx5BGBpLHUFOQh
	oZWVdZFhoPEhUdFFlBWU9LSFVKS0lITkNDVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=QHPeeCiNP0eZkZknfB+fE+K9W/zHPcLepa9Gkxhi5Y6bLYVaO1W+iVKfojDPc5n6fpf4pfhA36rYPccytUrvcX4hhf8QH5hb5tMazeHS2rP9CMJvm55pa5wTiRPVovt9yb9S8hPvr1B/Ui5jlMXA1+njvM/yqX8f/EI+hMHgokY=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=Z1b4LdluQD3phylo9nFQqJDe0PHo57hXdTtNXDTMnCw=;
	h=date:mime-version:subject:message-id:from;

A HID-BPF syscall context pins struct hid_device, but it does not pin the
transport-private data referenced by the low-level driver.  A hardware
request can therefore sleep in the UHID report-wait path while closing the
UHID file destroys the HID device, wakes the waiter, and frees struct
uhid_device.  The awakened request then accesses the freed object.

KASAN reports:

  BUG: KASAN: use-after-free in __uhid_report_queue_and_wait
  Read of size 1
  uhid_hid_raw_request
  __hid_hw_raw_request
  hid_bpf_hw_request
  bpf_prog_test_run_syscall

Add a lifetime lock that serializes admission of HID-BPF hardware
operations with device destruction.  Take an SRCU read lock while holding
the lifetime lock before accessing the report tables or the low-level
driver.  Destruction marks the device destroyed under the same lock and
waits for the SRCU readers before cleaning up the SRCU state.

The lifetime lock is released before calling the low-level driver.  This
avoids reacquiring the same mutex through a reentrant low-level path and
does not introduce a lock dependency on driver_input_lock.

Fixes: 91a7f802d185 ("HID: bpf: introduce hid_hw_request()")
Closes: https://lore.kernel.org/linux-input/179317460423.87432.1451672332362541157@stu.pku.edu.cn/
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 73 ++++++++++++++++++++++--------
 include/linux/hid_bpf.h            |  1 +
 2 files changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 6b467c74601cb..0c0c8e9939f05 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -398,6 +398,18 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 	return 0;
 }
 
+static int hid_bpf_hw_operation_lock(struct hid_device *hdev)
+{
+	int idx = -ENODEV;
+
+	mutex_lock(&hdev->bpf.lifetime_lock);
+	if (!READ_ONCE(hdev->bpf.destroyed))
+		idx = srcu_read_lock(&hdev->bpf.srcu);
+	mutex_unlock(&hdev->bpf.lifetime_lock);
+
+	return idx;
+}
+
 /**
  * hid_bpf_hw_request - Communicate with a HID device
  *
@@ -416,17 +428,21 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 	struct hid_bpf_ctx_kern *ctx_kern;
 	size_t size = buf__sz;
 	u8 *dma_data;
-	int ret;
+	int idx, ret;
 
 	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
 
 	if (ctx_kern->from_bpf)
 		return -EDEADLOCK;
 
+	idx = hid_bpf_hw_operation_lock(ctx->hid);
+	if (idx < 0)
+		return idx;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype, true);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
@@ -437,21 +453,24 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 	case HID_REQ_SET_PROTOCOL:
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	dma_data = kmemdup(buf, size, GFP_KERNEL);
-	if (!dma_data)
-		return -ENOMEM;
+	if (!dma_data) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
 	ret = hid_ops->hid_hw_raw_request(ctx->hid,
-					      dma_data[0],
-					      dma_data,
-					      size,
-					      rtype,
-					      reqtype,
-					      (u64)(long)ctx,
-					      true); /* prevent infinite recursions */
+					  dma_data[0],
+					  dma_data,
+					  size,
+					  rtype,
+					  reqtype,
+					  (u64)(long)ctx,
+					  true); /* prevent infinite recursions */
 
 	if (ret > (ssize_t)size)
 		ret = size;
@@ -459,6 +478,8 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 		memcpy(buf, dma_data, ret);
 
 	kfree(dma_data);
+out_unlock:
+	srcu_read_unlock(&ctx->hid->bpf.srcu, idx);
 	return ret;
 }
 
@@ -477,24 +498,33 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	struct hid_bpf_ctx_kern *ctx_kern;
 	size_t size = buf__sz;
 	u8 *dma_data;
-	int ret;
+	int idx, ret;
 
 	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
 	if (ctx_kern->from_bpf)
 		return -EDEADLOCK;
 
+	idx = hid_bpf_hw_operation_lock(ctx->hid);
+	if (idx < 0)
+		return idx;
+
 	/* check arguments */
 	ret = __hid_bpf_hw_check_params(ctx, buf, &size, HID_OUTPUT_REPORT, true);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	dma_data = kmemdup(buf, size, GFP_KERNEL);
-	if (!dma_data)
-		return -ENOMEM;
+	if (!dma_data) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
-	ret = hid_ops->hid_hw_output_report(ctx->hid, dma_data, size, (u64)(long)ctx, true);
+	ret = hid_ops->hid_hw_output_report(ctx->hid, dma_data, size,
+					    (u64)(long)ctx, true);
 
 	kfree(dma_data);
+out_unlock:
+	srcu_read_unlock(&ctx->hid->bpf.srcu, idx);
 	return ret;
 }
 
@@ -641,8 +671,12 @@ void hid_bpf_destroy_device(struct hid_device *hdev)
 	if (!hdev)
 		return;
 
-	/* mark the device as destroyed in bpf so we don't reattach it */
-	hdev->bpf.destroyed = true;
+	/* Block new BPF hardware operations before transport teardown. */
+	mutex_lock(&hdev->bpf.prog_list_lock);
+	mutex_lock(&hdev->bpf.lifetime_lock);
+	WRITE_ONCE(hdev->bpf.destroyed, true);
+	mutex_unlock(&hdev->bpf.lifetime_lock);
+	mutex_unlock(&hdev->bpf.prog_list_lock);
 
 	__hid_bpf_ops_destroy_device(hdev);
 
@@ -655,6 +689,7 @@ int hid_bpf_device_init(struct hid_device *hdev)
 {
 	INIT_LIST_HEAD(&hdev->bpf.prog_list);
 	mutex_init(&hdev->bpf.prog_list_lock);
+	mutex_init(&hdev->bpf.lifetime_lock);
 	return init_srcu_struct(&hdev->bpf.srcu);
 }
 EXPORT_SYMBOL_GPL(hid_bpf_device_init);
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 19fffa4574a47..3624937d340b3 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -195,6 +195,7 @@ struct hid_bpf {
 	struct hid_bpf_ops *rdesc_ops;
 	struct list_head prog_list;
 	struct mutex prog_list_lock;	/* protects prog_list update */
+	struct mutex lifetime_lock;	/* protects destroyed and SRCU admission */
 	struct srcu_struct srcu;	/* protects prog_list read-only access */
 };
 
-- 
2.39.5 (Apple Git-154)
