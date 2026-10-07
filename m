Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656443F076F
	for <linux-input@vger.kernel.org>; Wed,  7 Oct 2026 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351881; cv=none; b=uJYPvJsW4t/BnyWVJhaRxWyH59GIv/hpW65umN4jWWtpHVDs2A+RhXjiYCp5AyReSk+6h1l9qOduRXxZ2dkI/5u6YdSQ93AhRdhGNAy5v9pVrf6cZSf0uIMPRRlGyUctZD9xIlxgzUqc0p509LVlgQwiWNhukw//3GzeX+xX3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351881; c=relaxed/simple;
	bh=ynjoLLi/n3KHDvPRST29+7ahVSC3TrfwzXl6tLKusn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+qJTTlyThd3ya1zImiheqgEsYB4pu5PMPL2kq/+CTXpP3v6yvayGhOTdv0uwl7B8R9q4y44QzwjVfqj7hgdkhouAHi0nHMFRA73OPM78GPz9zUZz0mSKWz9RaX2aoaHmdvtnMvGzv/CCkhEXBSktHh5UUUmtyoIrHu9YmwvTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5JoKDh7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5JoKDh7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49d05d51553so25661215e9.2
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2026 22:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791351878; x=1791956678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dm9oz8PbVLbTHr6sUh2Zmk88hMu2YoF1bMSolTgGPRo=;
        b=P5JoKDh7EBaOp2EyL3T1jBlCMcsAfzyZAcWxZV1tCF48Hik3o6VXsQs/k59rdTGL9J
         BzrwMAzKkGR5sKoEWuO79WMkWObmaXF/I5MUV4K8Qwp8FP/thRaZfopof5DJxZMzCdWK
         r0W+2Qv4npUO3DZV0nVpII+VIPvRoH0jS/PuxYDI4csg4BQGZsGI888PADi3QwYYmV0w
         CRbcBXg5CK07GA2133R5LY2CE/vqJoJE1KL5LFlgopocou3Diw06S7VFR+K4qjLidiXO
         qBCfb7/We2U39DgmxKOm9n4PiAXSZT6V6fv9clPr5TYVAMz9cBuElnnz9zkzyMmzL2iF
         0Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791351878; x=1791956678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dm9oz8PbVLbTHr6sUh2Zmk88hMu2YoF1bMSolTgGPRo=;
        b=P+FWhYrCPjh+ZpJk25PVNCBs1ir1R+fnZZ631mqI8eNuETI8EEohr5ehvA1wZFpXKC
         SLumYX6qoqOEZeJMdJvc8qaEJL/iD4NzDsDSeWV9+ci9d18s0k/hs7vI2zN4IINHsdUY
         o3XZfNAVKoIo0nzcNRixJMQ43QHYhn+s8CEnDHFkvddJD8yIzFB8aItjiOcaIsKG1wy/
         961C5tFhMZZDTtvcc7tV2RBFJnDVP0/BvYtVMzGaeEoEvJECjWEwooz3RSVi9LhNHiG7
         EUYYbdZyX1PFp39JzZ3OMuma60s3tJeJXsSw7SEINqVZdgLx1tfMx3X28+nr5Kpl4zeL
         Sdhg==
X-Forwarded-Encrypted: i=1; AKwUvBw7fyRPuJYUv9rKuWzsjYNdW01zdmkg+xkcBjZwgwLKhmlGmglMM0iYtc9VJaZFZM3FNPvcexzdwcTIjg==@vger.kernel.org
X-Gm-Message-State: AFuF++kLYK55QwCOPEz+ytVA/MTnVAksb8oAMD0etCBoZjGZ6dzORmZW
	2dqzCgGHp8BX98AGEBj0OXq6BATsiCNO/AcENbsvDm6zKwo3Tek3j4eR
X-Gm-Gg: AYBFou0M70zcAVhevSwE0bqgXb9a8zDiehWMEFFJMb7njll+5KErhZ+VRVeqrtsXIhr
	pfct4hqfqVrncdKusXvWPiq4CLbBmice8wYrXCmPRjEjctYD9Qrl2rqCRAUE/uMEWPnsZ4WvyBJ
	ynsxjQM6f/1zPqHT2c8M3ofHjAwiUWNpg/qKUWxuoTImo298wTURjy4GyFR44LTcln9fKLskPUM
	JKGniJjoCOd4GpjWocZB/zlgGdBzX+Az+60ytridBEbLZQQrA+OS8VTKqlTfsoz19ALzmY5hTxx
	+GPh40K+mm7EUYc0YrF0z6Tc0QOXmwiueYec54WTWfiPLE1a/xAlsCSCh3sRZvd9oZ54dTA5UF/
	+r9tCqW2gk4CpMbjlponFDxJpUlXQpvhxlxe0+Dyri6zWZljAr3UArWcMCSu0GVCT3+oMufUrsv
	vGsT3qmWSMNOjxNyXDX6udeZRkHQfNoqUJT6OvGngcwpndPGba/PdoV8hkyVh8+4TzmJaFohERZ
	1DlVCOUsGhXWpIEp2BAs1cYiL/hl5nSHHv4XRa1mMMR5tN869qlbV8pdrKiD52qW18hQs66dEXo
	+SAHpSSe3PKA6fwHJXj7cgZndmz76mZnRwXugaKXuE218wuUwbeCrK2xg1M1nl2x0UG7W38SawK
	uGhbEsi9rYOCpHsPrOg==
X-Received: by 2002:a05:600c:5252:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a1806878c3mr10840485e9.33.1791351877434;
        Tue, 06 Oct 2026 22:44:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a1e1-2201-60f4-32e0-4d59-5772.310.pool.telefonica.de. [2a02:3100:a1e1:2201:60f4:32e0:4d59:5772])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178a17ac9sm121780835e9.1.2026.10.06.22.44.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 22:44:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Florian Echtler <floe@butterbrot.org>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
Date: Wed,  7 Oct 2026 07:44:30 +0200
Message-Id: <20261007054430.40155-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Video capture has failed since commit 6eb0233ec2d0 ("usb: don't
inherity DMA properties for USB devices"). sur40 gives the USB
interface device to vb2_dma_sg, but the interface no longer has a DMA
mask. The mapping fails, leaving no entries for usb_sg_init().

Using the host controller device with vb2_dma_sg would give
usb_sg_init() an already DMA-mapped scatterlist. The USB core maps that
list for the host controller itself. Mapping it twice overwrites the DMA
addresses, and vb2 later unmaps addresses it does not own.

Imported dma-bufs cannot supply the CPU-side scatterlist that
usb_sg_init() needs. Importers may use only the DMA fields of the
attachment table. DMABUF_DEBUG makes this misuse deterministic by
clearing its page and length fields.

Use vb2_vmalloc for capture buffers. Receive each frame into a
driver-owned, page-backed scatterlist, then copy it through the vb2
mapping. Synchronize CPU writes to imported dma-bufs with
dma_buf_begin_cpu_access() and dma_buf_end_cpu_access().

Verified with a custom QEMU model and raw-gadget emulation. Not tested
on real hardware.

Fixes: 6eb0233ec2d0 ("usb: don't inherity DMA properties for USB devices")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
RFT because I do not have SUR40 hardware. Testing on a Microsoft Surface
2.0 / Samsung SUR40 would be appreciated.

The current RFT passed an x86-64 W=1 build of sur40.o with
DMABUF_DEBUG=y. Runtime testing used v7.3-rc4-70-gfe2ec83746e5 on QEMU
TCG with KASAN, DMA_API_DEBUG and DMABUF_DEBUG:

- a custom SUR40 model behind qemu-xhci and Intel IOMMU strict mode;
- raw-gadget on dummy_hcd.

Each setup captured 300 MMAP frames and 300 udmabuf frames. Every frame
contained the expected sequence data. The xHCI/IOMMU run produced no
DMA-API report. The dummy_hcd run reported udmabuf's separate maximum
segment-size issue, which also reproduces through DMA_BUF_IOCTL_SYNC
without sur40.

Nguyen Ngoc Thang's pending disconnect fixes move resource cleanup to a
v4l2 release callback:

https://lore.kernel.org/r/20260920113949.12726-1-ngocthang2710.1999@gmail.com/

If that series lands first, the sgl_free() added here must move to the
release callback as well.

 drivers/input/touchscreen/Kconfig |  5 ++-
 drivers/input/touchscreen/sur40.c | 68 ++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7f..e433db3d340f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1276,9 +1276,10 @@ config TOUCHSCREEN_SUN4I
 
 config TOUCHSCREEN_SUR40
 	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
-	depends on USB && MEDIA_USB_SUPPORT && HAS_DMA
+	depends on USB && MEDIA_USB_SUPPORT
 	depends on VIDEO_DEV
-	select VIDEOBUF2_DMA_SG
+	select SGL_ALLOC
+	select VIDEOBUF2_VMALLOC
 	help
 	  Say Y here if you want support for the Samsung SUR40 touchscreen
 	  (also known as Microsoft Surface 2.0 or Microsoft PixelSense).
diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 09d8c5f8d09f..72e3f0fa1f4c 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/dma-buf.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -36,7 +37,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-ctrls.h>
 #include <media/videobuf2-v4l2.h>
-#include <media/videobuf2-dma-sg.h>
+#include <media/videobuf2-vmalloc.h>
 
 /* read 512 bytes from endpoint 0x86 -> get header + blobs */
 struct sur40_header {
@@ -221,6 +222,8 @@ struct sur40_state {
 
 	struct sur40_data *bulk_in_buffer;
 	size_t bulk_in_size;
+	struct scatterlist *video_sgl;
+	unsigned int video_nents;
 	u8 bulk_in_epaddr;
 	u8 vsvideo;
 
@@ -531,8 +534,10 @@ static void sur40_process_video(struct sur40_state *sur40)
 	struct sur40_image_header *img = (void *)(sur40->bulk_in_buffer);
 	struct sur40_buffer *new_buf;
 	struct usb_sg_request sgr;
-	struct sg_table *sgt;
+	unsigned int size = sur40->pix_fmt.sizeimage;
+	struct dma_buf *dbuf = NULL;
 	int result, bulk_read;
+	void *vaddr;
 
 	if (!vb2_start_streaming_called(&sur40->queue))
 		return;
@@ -579,11 +584,17 @@ static void sur40_process_video(struct sur40_state *sur40)
 
 	dev_dbg(sur40->dev, "header acquired\n");
 
-	sgt = vb2_dma_sg_plane_desc(&new_buf->vb.vb2_buf, 0);
+	vaddr = vb2_plane_vaddr(&new_buf->vb.vb2_buf, 0);
+	if (!vaddr)
+		goto err_poll;
 
+	/*
+	 * vb2_plane_vaddr() may return a vmalloc or vmap address. Receive
+	 * into page-backed memory so the USB core can map it for DMA.
+	 */
 	result = usb_sg_init(&sgr, sur40->usbdev,
 		usb_rcvbulkpipe(sur40->usbdev, VIDEO_ENDPOINT), 0,
-		sgt->sgl, sgt->nents, sur40->pix_fmt.sizeimage, 0);
+		sur40->video_sgl, sur40->video_nents, size, 0);
 	if (result < 0) {
 		dev_err(sur40->dev, "error %d in usb_sg_init\n", result);
 		goto err_poll;
@@ -595,6 +606,39 @@ static void sur40_process_video(struct sur40_state *sur40)
 		goto err_poll;
 	}
 
+	if (sgr.bytes != size) {
+		dev_err(sur40->dev, "short image (%zu of %u bytes)\n",
+			sgr.bytes, size);
+		goto err_poll;
+	}
+
+	/*
+	 * vb2_vmalloc does not synchronize CPU access to imported dma-bufs,
+	 * so bracket the copy into one here.
+	 */
+	if (new_buf->vb.vb2_buf.memory == VB2_MEMORY_DMABUF)
+		dbuf = new_buf->vb.vb2_buf.planes[0].dbuf;
+
+	if (dbuf) {
+		result = dma_buf_begin_cpu_access(dbuf, DMA_TO_DEVICE);
+		if (result) {
+			dev_err(sur40->dev, "error %d in begin_cpu_access\n",
+				result);
+			goto err_poll;
+		}
+	}
+
+	sg_copy_to_buffer(sur40->video_sgl, sur40->video_nents, vaddr, size);
+
+	if (dbuf) {
+		result = dma_buf_end_cpu_access(dbuf, DMA_TO_DEVICE);
+		if (result) {
+			dev_err(sur40->dev, "error %d in end_cpu_access\n",
+				result);
+			goto err_poll;
+		}
+	}
+
 	dev_dbg(sur40->dev, "image acquired\n");
 
 	/* return error if streaming was stopped in the meantime */
@@ -725,6 +769,13 @@ static int sur40_probe(struct usb_interface *interface,
 		goto err_free_input;
 	}
 
+	sur40->video_sgl = sgl_alloc(sur40_pix_format[0].sizeimage, GFP_KERNEL,
+				     &sur40->video_nents);
+	if (!sur40->video_sgl) {
+		error = -ENOMEM;
+		goto err_free_buffer;
+	}
+
 	/* register the video master device */
 	snprintf(sur40->v4l2.name, sizeof(sur40->v4l2.name), "%s", DRIVER_LONG);
 	error = v4l2_device_register(sur40->dev, &sur40->v4l2);
@@ -811,6 +862,7 @@ static int sur40_probe(struct usb_interface *interface,
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
 err_free_buffer:
+	sgl_free(sur40->video_sgl);
 	kfree(sur40->bulk_in_buffer);
 err_free_input:
 	input_free_device(input);
@@ -831,6 +883,7 @@ static void sur40_disconnect(struct usb_interface *interface)
 	video_unregister_device(&sur40->vdev);
 	v4l2_device_unregister(&sur40->v4l2);
 
+	sgl_free(sur40->video_sgl);
 	kfree(sur40->bulk_in_buffer);
 	kfree(sur40);
 
@@ -1114,15 +1167,10 @@ static const struct vb2_ops sur40_queue_ops = {
 
 static const struct vb2_queue sur40_queue = {
 	.type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
-	/*
-	 * VB2_USERPTR in currently not enabled: passing a user pointer to
-	 * dma-sg will result in segment sizes that are not a multiple of
-	 * 512 bytes, which is required by the host controller.
-	*/
 	.io_modes = VB2_MMAP | VB2_READ | VB2_DMABUF,
 	.buf_struct_size = sizeof(struct sur40_buffer),
 	.ops = &sur40_queue_ops,
-	.mem_ops = &vb2_dma_sg_memops,
+	.mem_ops = &vb2_vmalloc_memops,
 	.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC,
 	.min_queued_buffers = 3,
 };

base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.53.0
