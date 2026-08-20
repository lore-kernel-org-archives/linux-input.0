Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95041F7E1
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224574; cv=none; b=nUdjZgkiaYdpx6B0Q0pS8cdKlK8Gx0494iy4LfzEnG91YFPBgUlB0E9uJ5Ic1623GwpUFVckJ5BcR5mMSeGnRK5cWOTNBrrRr2SYxr+22b7cLEqoDob+zZujfYEFf2dRFNvZol+FQANsC99Vs5M2ronCVSZOj+ZH1OLnssenBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224574; c=relaxed/simple;
	bh=rHwP4XfA9jRj+RHRKEKyTJXOCcW4DcDGXwa8aSdNjkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWUBr5PmIOEP+/h1jXxcjbIv4aML+3IaPP5fQgEpp8JyJOFY+3PXBpMc0GWdDzhcMCTk/xkDZ++jrJaf3sgvyK3Zm90ZTA6i8Biqi47j9NoSTX0ar2pRrIwUQcoaIDPaeY27D2nudLGulb6m/YhxQDO+1CEYO7bztgAQjcsPe2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K74blQIr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K74blQIr"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca80d708489so539312a12.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224573; x=1787829373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUdHCBJZOHM/va9FiVML/hn1mg9LRuKeIIYVF8glt60=;
        b=K74blQIrSh/UssZZ78uXjrRKNv6N4HumxwusJgVzth8os3kIaWSSK6acGE4r5pvzJe
         vwP0p/vTY/pSabEANau6VfbXMCkAgLIgTVCE3aaUOwmwDP/qQAAQj5Ml9X7/scGUOsCj
         q880YiiRqOo5sS4mKU/2tHf7neZJgSfBiS5mfrFT/sdQ/Eo6d7RrrdJ4WnvvzqZS2K0r
         JSSEBHzuD08UXA2FqXVZIdgX7GcrKlL2QuPsXBcxYCKWKVgot0zpHxRIIgf1oWyR7WNd
         a7mQE3QWSO/K3dQ7lXR4yv/c0gVtrYqUdqzz+0oUaHc6Ym7Vfjo38ZMhRXN5VTTId5q8
         G9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224573; x=1787829373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUdHCBJZOHM/va9FiVML/hn1mg9LRuKeIIYVF8glt60=;
        b=A0b7/JuTfhehh4yoTwPh+s1XHZkGW6WHqbRwDizScUu1xFYkBOTdCNm+E0Ivbb9khK
         uJVMldXCsXmPjD1MusofxGIzWpfS3xPLe9wCGujvQ/GmtFiIcCmtdIsNNxplXH5w+ATk
         vDziAQFr2Ra7m0kq5OummnCd+24pgREhaKetK/b4FZVCmUmx2y6VdAbMWtcN+cLBP8pu
         wwuyq2shL1PJtpXolO56Z5xNhHXTfCnupfxfv+bNSgRCavdfI6g1AH0P8C3DK9m4lVEq
         rm4cWvsSRzDfBywYHrTood9fjTFrYxPkBHatvxZ3dx3uhbyXnlq50Ut8sktXoaRvdqIL
         GbXA==
X-Gm-Message-State: AOJu0Yx07CtJoCuKfKbyvnQj3sSPbuWp4MQj37aZjzal9I/AVhLww8LD
	22PP2A5XVcs+/PzBwP5DBcoTxHovK8oPof0wiWvWIDGJt78i9mdJo6g4
X-Gm-Gg: AR+sD12oFJCwX/YVmH0z/PZ+4zkGwhlB8ZEWDLHSlxArVqdKYVuT1EBIUYZ3UYMCcT2
	WT+k30MYwnIPsgf9+CgFp0hc0rzL8DVVZnbicS0nSTBaMM5CuiSXulIY/UGU8i5wuWT1jnxq9eZ
	Vsmf4nAfYku1VwAoYuWm8eUXucgLXEg5fUPt/3TKpi70tHvNwUyiQIZCEjtM/vG0aHawuRm48wk
	1Y0IiTc7lX1+sHeb5XknoanIRteXwyozfw/5yfmsvYhDJZ6QvTxqPo/lKYnYlGUNKIRI4TRODe+
	JIYPwLUnyb7iAycWDKv05rOVeFvdLOtd0cBhUcq0FFL9mMlMftvvuYft4zV0Zt2djvqZxLZKdqR
	avCIA67PvM4/NiZg8BKDeqn5Jc1SE8OlgZrtXsGzA2vm6GXMKGrLTWi7COWDrjXpk1aC1KT/FD7
	CrmFeqhQQ8xgSmW/u7Wx4LJyhcdiaT9HS9HHDmkc+c4m47cm2w8jCv2UOvKuCXnGV7WxQMXLfvq
	2iFEa0Dk9xw8HkYqIVfr2RR+6yMQcDtxUsHX3CT1+b4PboaDikCZ8tTXvhT9XPY
X-Received: by 2002:a05:6a21:6f11:b0:39b:bc11:9ec5 with SMTP id adf61e73a8af0-3cd14faf56emr7432453637.13.1787224572709;
        Thu, 20 Aug 2026 04:16:12 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15cada6fesm1236455a12.27.2026.08.20.04.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:16:11 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 1/2] HID: intel-thc-hid: intel-quickspi: size the input buffer for the DMA
Date: Thu, 20 Aug 2026 20:15:57 +0900
Message-ID: <20260820111558.475304-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820111558.475304-1-sammiee5311@gmail.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quickspi_alloc_report_buf() sizes input_buf from max_input_len, but the
RXDMA2 channel it feeds is programmed with ALIGN(max_input_len, SZ_4K):
quickspi_dma_init() passes the raw value and dma_set_max_packet_size()
rounds it up.  setup_dma_buffers() maps that rounded size and
read_dma_buffer() bounds the message against it, so a controller
reporting max_input_len 64 and rep_desc_len 600 gets a 600 byte buffer
behind a 4096 byte DMA.  thc_rxdma_read() has no capacity argument, so
nothing downstream can catch it.

The intel-quicki2c sibling floors its input buffer at SZ_4K for this
reason, with the comment "give default 4K buffer to avoid DMA buffer
overrun".  Round up the same way the DMA does.

Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 89226f5ce45e..9ef33574c202 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/gpio/consumer.h>
@@ -549,8 +550,12 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	if (!qsdev->report_descriptor)
 		return -ENOMEM;
 
-	max_input_len = max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
-			    le16_to_cpu(qsdev->dev_desc.max_input_len));
+	/*
+	 * thc_dma_set_max_packet_sizes() rounds the RXDMA2 packet size up to
+	 * 4K, so the DMA can hand back more than max_input_len bytes.
+	 */
+	max_input_len = max_t(size_t, le16_to_cpu(qsdev->dev_desc.rep_desc_len),
+			      ALIGN(le16_to_cpu(qsdev->dev_desc.max_input_len), SZ_4K));
 
 	qsdev->input_buf = devm_kzalloc(qsdev->dev, max_input_len, GFP_KERNEL);
 	if (!qsdev->input_buf)
-- 
2.43.0

