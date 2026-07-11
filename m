Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755222083
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761705; cv=none; b=Dqt+oPT4A9VHwfpc/90i5e1VOqjT9skbsTsgiqEsDv4xeN0S3ibrw2a6ys/LDhrwOK7lPMkROdmTzhHJ/RlGCMxizoABYmTmfEs7FAJXekg7IfYRBNxDdhmTd9inCMwpgU5xH8Cnpcg4LiX6Xk1JAuGSP/YwcDE8Io+juFUEcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761705; c=relaxed/simple;
	bh=uxnE3s+OHBnATD6/J7IwFWikD45wp0+S4wwd8PzleUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kvjelo7GFH8otP95fgCie5mXgh1q5uMQ/VaswvOXvqusf5CP74K0tlyORPlCIntjID/GI1IL8PdgVOZzs/LaS3L0MNsUIOoE/T0w9np9QknXNk/SlEK1BLzrIK98Ya2ztrdaLzZsUf5NeOWRitGWXx8JBLyKzBkYmp49/tJ8Jgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1785295b3a.2
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 02:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761702; x=1784366502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWPkjt8pFCGFWg9O7q8pVB8rJD2AVw+GyK5aJ4zTUoQ=;
        b=qIwDtAdA6QIDGjvqXVLpiV6KMxGh+ufo+pBcDAXByh8Oi7ga5mhxeT9GAHx28rakpd
         3OYGHsuuFW2D8Vox45V+/A0WfEjY2QOGASULIlqMKpoTQgJJ03KZuS7MLkrn5w7CuIna
         F3ufhG2V2gE0B5QCuW9g8yEVkaF1iCsKASQKUtNH0KgAMXm51SR+WWe8NGVKd8ANvpT2
         IWyckUf/85G0PuQQlsaBBjCs5vzHFCMDqnE5P+WwLgOWZcWGqHRi3H5JD172MqNXhl/s
         +aFoiBmSTo7j67hfdWx7KfOLjNdYN6qVBUoBJqNWEf/KEd4x+5tpeCLe3yi2yCXlNRUo
         XzHA==
X-Gm-Message-State: AOJu0YyMtxZlbyHdl8CyIaaoMfeo3ovES6tifn+GZImgTJ9wBlazhiRx
	8ghGJlt+h4vRymWfCjMiOegz1MUc3uJMQadkp1/ZwQatvdZszPPSirA=
X-Gm-Gg: AfdE7cmuoeo/OkQuN3Ze7qW5IRUPHTVAEFozfa4xFs4fwQ9vHoksxmecF1Je3DSYPNA
	OEuq0GHRBAO1UcPPEsd+oc8DfTtASZV30dh21ziQtS6kDxJ757vDcFsENRKHfYDuz1hjVH6VIJx
	DGK0SsUw6sa0olq40FEvePSKAVNdBc1NdLdyDWKnHisC7w/XA0GqzcZNMt4zm1Lvz/kipaEeR7k
	SybnKzqYw2O7P+s3ihcwuGiiKcxp/ydDTxbkdHMo5Qz2Iv7zWPMrKpSBiGEpjwygVk2ufsUXPU7
	BRUmZTAnEXX6vBFdVKrXgi5QoY1pSNE0f1d8dJDfmdD41/rQ8c7PBBOwTuBWYhGLpEjGA6PJi3r
	6H0LDwED/myaGN2lEbTTnlYqD9BteBpm6uUC18zOJ3zMbsPaprmSDWjJr8LWjRJR4DCkWjCs8Xk
	iD81Ie3FVfgv6XV86Q8vqQ2cYUBt59vuzKGiPLr/Md6Z/86Sms+T1d0EmgPstVEhl9ct+y82Y2p
	3j4hYQz6MQ16EWssQ3+r3NiQg==
X-Received: by 2002:a05:6a00:18a0:b0:847:973b:3cf6 with SMTP id d2e1a72fcca58-848894d37e4mr1992859b3a.0.1783761702040;
        Sat, 11 Jul 2026 02:21:42 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm11468726b3a.57.2026.07.11.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:21:41 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 3/3] Input: applespi - fix NULL pointer dereference in tp_dim open
Date: Sat, 11 Jul 2026 17:20:54 +0800
Message-Id: <20260711092054.13818-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711092054.13818-1-fourdollars@debian.org>
References: <20260711092054.13818-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tp_dim debugfs file is registered synchronously during driver probe
in applespi_probe(). However, the applespi->touchpad_input_dev is
initialized and registered asynchronously in the driver's worker thread.

If a userspace process opens the debugfs file before the worker thread
has completed initialization, applespi_tp_dim_open() will dereference
the NULL applespi->touchpad_input_dev pointer, causing a kernel panic.

Fix this by using smp_load_acquire() to safely load touchpad_input_dev
and return -ENODEV if it is not yet initialized.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index fd785dba1174..e3e239f430bd 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -972,12 +972,18 @@ static void applespi_debug_update_dimensions(struct applespi_data *applespi,
 static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 {
 	struct applespi_data *applespi = inode->i_private;
+	struct input_dev *touchpad;
 
 	file->private_data = applespi;
 
+	/* Pairs with smp_store_release in applespi_register_touchpad_device() */
+	touchpad = smp_load_acquire(&applespi->touchpad_input_dev);
+	if (!touchpad)
+		return -ENODEV;
+
 	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
 		 "0x%.4x %dx%d+%u+%u\n",
-		 applespi->touchpad_input_dev->id.product,
+		 touchpad->id.product,
 		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
 		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
 		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);
-- 
2.39.5

