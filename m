Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620731;
	b=NhHnGTf/lOmN9EcRxRAtX5ZFPz5Ice8vxwZtQzkZOI5m0kNlSLkfnSutMBi2+PidxizX
	 s6NRYA2bI3SFaeUiodA6GVLnpDYrxaMU2fqYc+ySVBese1yzNQsejxse5b6uTSzErjQWA
	 ILndi4e09CBjbcy056XBlBYcWS6y1/YOEuUjnWG5df69BsN8qDVE6AedsLQRdycj1CkYP
	 WEzfqPuhNl1IS4OWHd295vNQVz4jSOttydY+IZN0KUNmrKk0sZaQrknJl5MNd6HFol+1j
	 mrndHQIhFCEFgh9QSOMmSfS/JwEEOtzydJibykdAuEx/9UZDOqgFLiqpP3aVosQTYLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620731;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=zfEvyvDZECbBv8i8o1bSrP5c9YfsZo7IfPIWqPxmVzI=;
	b=VaH7oBywnGhO+FqzlTmIuTTXGnlG/HAQkws2kh49VdY5zZuuBwtbHINmBG7LZjjZ2KYE
	 vXc36uRAg/w8crkY97XpVvyPXH2n0W3P7W/LjnUxlbyZPQWwRpCWOFlOq0QgFiyZXeRIb
	 /9ka1+L/62ydF+4ldaokLqMSfZlITsNLjLKJkdJeoAdhM6b26Kj7fttJMLDftItw4UOWq
	 LL1tAulBcBcMzy9RRAmx9migM5oG5/oGtX5ZKVdvA3b5RkDirAMNWgNV7Eo7KkXmMp3Sz
	 nX5uz7SCzzp2gY0qf9qrN3R34IIg3D+ZpuYimM6BvF8QB7GOs+cBqRMAS98mgWLzbpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=NVOkS0ro;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685460A2635;
	Mon,  2 Nov 2026 11:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C685460A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=NVOkS0ro
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b234b;
	Mon, 2 Nov 2026 19:58:41 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071770.29269.481376767482231629@stu.pku.edu.cn>
Subject:
 [PATCH 1/2] HID: bpf: serialize hardware operations with device destruction
In-Reply-To: <179362071770.29269.16022650793604369465@stu.pku.edu.cn>
References: <179362071770.29269.16022650793604369465@stu.pku.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c203fd003a2kunmab045f0fe84de
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUtNVkoYTkxOQktLGktJGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=NVOkS0roELjGOimIBWoWlHXifvXztJYmgxWR49LN0qK6PQ6hLPxiJL17uxSClWsU3f015oxbksS5tvN2DhOlz/FY5rej47P7WnGJwwpliurNF23PvOvXFbTh6UOxmR70VknZlPGgGoF1WxuOfDVf2F1QkMYXdMMWE7D607jRK5w=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=zfEvyvDZECbBv8i8o1bSrP5c9YfsZo7IfPIWqPxmVzI=;
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

Hold prog_list_lock across HID-BPF hardware operations.  Device destruction
sets destroyed while holding the same lock, so it waits for an operation
that has already started.  Later operations return -ENODEV before reaching
the low-level driver.  Apply the same lifetime rule to output reports.

The reproducer completed 100 close-versus-request trials without a KASAN
report with this change.

Fixes: 91a7f802d185 ("HID: bpf: introduce hid_hw_request()")
Closes: https://lore.kernel.org/linux-input/179317460423.87432.14516723323625=
41157@stu.pku.edu.cn/
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 36 +++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dis=
patch.c
index 6b467c74601cb..4fea42dd2f392 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -444,14 +444,20 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, =
size_t buf__sz,
 	if (!dma_data)
 		return -ENOMEM;
=20
-	ret =3D hid_ops->hid_hw_raw_request(ctx->hid,
-					      dma_data[0],
-					      dma_data,
-					      size,
-					      rtype,
-					      reqtype,
-					      (u64)(long)ctx,
-					      true); /* prevent infinite recursions */
+	mutex_lock(&ctx->hid->bpf.prog_list_lock);
+	if (READ_ONCE(ctx->hid->bpf.destroyed)) {
+		ret =3D -ENODEV;
+	} else {
+		ret =3D hid_ops->hid_hw_raw_request(ctx->hid,
+						  dma_data[0],
+						  dma_data,
+						  size,
+						  rtype,
+						  reqtype,
+						  (u64)(long)ctx,
+						  true); /* prevent infinite recursions */
+	}
+	mutex_unlock(&ctx->hid->bpf.prog_list_lock);
=20
 	if (ret > (ssize_t)size)
 		ret =3D size;
@@ -492,7 +498,13 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *=
buf, size_t buf__sz)
 	if (!dma_data)
 		return -ENOMEM;
=20
-	ret =3D hid_ops->hid_hw_output_report(ctx->hid, dma_data, size, (u64)(long)=
ctx, true);
+	mutex_lock(&ctx->hid->bpf.prog_list_lock);
+	if (READ_ONCE(ctx->hid->bpf.destroyed))
+		ret =3D -ENODEV;
+	else
+		ret =3D hid_ops->hid_hw_output_report(ctx->hid, dma_data, size,
+						    (u64)(long)ctx, true);
+	mutex_unlock(&ctx->hid->bpf.prog_list_lock);
=20
 	kfree(dma_data);
 	return ret;
@@ -641,8 +653,10 @@ void hid_bpf_destroy_device(struct hid_device *hdev)
 	if (!hdev)
 		return;
=20
-	/* mark the device as destroyed in bpf so we don't reattach it */
-	hdev->bpf.destroyed =3D true;
+	/* Block new BPF hardware operations before transport teardown. */
+	mutex_lock(&hdev->bpf.prog_list_lock);
+	WRITE_ONCE(hdev->bpf.destroyed, true);
+	mutex_unlock(&hdev->bpf.prog_list_lock);
=20
 	__hid_bpf_ops_destroy_device(hdev);
=20
--=20
2.39.5 (Apple Git-154)
