Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E633FE05
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783752890; cv=none; b=dxQB2B0yVjRewuXTkewJ+LgsAf4Chde04lPErYxcD517e/XpKTOLWlatDM68bv6U8wpXrfhn+7I89AP0M0en5xN6PMiovA7QWWDFdbttfNO2CXW5nb8+5gkCM2b/b80667Yyc5fhOnhCjIAgL1lz1COVvtp3SwVCtPlMN8/givw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783752890; c=relaxed/simple;
	bh=8fT0Gg/8Igu9jt6gZKh1bW7ODGFpVtDQrf69dpWU9zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V25Z4rToZmkBM+z141DxT+2ocAKjqFsOqfNAJDQ1muyXUH29FVV4ueLepoEIhNAeWQdGf/yFSAKLNFmvFkvggywQRAPD2rc9ALN0c/v5PxO8iERPd5jBOeSAQysQukn3JiQ39js77obD3YNNEDO3+Z2YEMivdPbSl3Bp1ufy21U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc97653887so18091175ad.1
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 23:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783752886; x=1784357686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNuv1LlOXCQ1HK6vbtUi5c2rok5gLYfCN2rAKCK3bnw=;
        b=H8jAbmgrZoJlqci9R6ergTydWhBLnTvucE6ppWHrCWc0vxRlyKfTW8/Uz+wwzRjrxF
         grofab+OT+tCzT05/Bo6iL8PnQgzIAvABs9y8ISsDJZ1wsEeNsgBeqEHIu0PCV3gn19i
         c8BbppAjKIdYDiqLdYX29YOu4f3gO+lIKf1aR3Agg8z7Oh0sxqZow//vEMRNJADxUGpW
         NP6Gd8ZW5JW8rtzpzcAfF7+0se+TkD1tckW1Wu0jF0Bry+PWsGKywCDaQbBwgUgoXKvd
         FAOkH8mOAziBomeKfCorxTjfmJ6GLnK/fMiTgQpsYIIFi5pQFJ7pBJdM4h7MnvkZUfW7
         FwOA==
X-Gm-Message-State: AOJu0YzUI+eZ9TwSUxH6yGZzsT9jbguYWayY2Bl+lZVc7G11RQpRoCrw
	+of6cvHyj1S2EXiEHY/45u5B6vrXTlhFITxgUzp1D9AQzOOQeXbY0nKeDRqwnwbLhtSh
X-Gm-Gg: AfdE7clDspTkkXCu6J1mNk0LOuynRibp/XFMbj5mgPOXGLNWUsuhWkatovC7Sg8cVXs
	sy2YES6L+ZrzxmSRRIfRFcHXAOxQwZZwyhXLaAjlRrA3f98hR++mzWlSn1dFuMiG99xyYIOP9TS
	VP1NC8kLZ/K9BEFCwhmbCm8mKQnkUmHXPTlN77TKFYkaOXGZYxiH27XXofhTz3LQ9RR14zoeX8Z
	BTcyFJ1iPeLc2rbhlZ3Gq2EsVp2oLCQFz3HqOn3AMOPJzVbyMPwJlw0cozAN+w+a3D5BoyQsDDE
	wMTiIJ7s8FvFoy3mQehH768lHvI+C/WPH1c6Xr6v4y4hEwAHDsix9cIm8El1bvOzSpTCPWJ0xOj
	bZct3GiXf5NeGLsax+ba7gwbm+ufYYHxQrii9Q1F553p8sYH4/z6r0pzfZPzcFW864Xx2UmxBiw
	wEl6k0JKlCDFw/LKLPvnPULE/e97LnYZkh+AuTohCJxDIQvfC23uOeMYPazooinXQztyAt0/+G1
	W5mPuNN0j+/PVTaw4S7z6M0MHpe2KS+15Br
X-Received: by 2002:a17:902:d987:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2ce9e9a7128mr24297395ad.4.1783752885868;
        Fri, 10 Jul 2026 23:54:45 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce8f5183b9sm18272535ad.5.2026.07.10.23.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 23:54:45 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 3/3] Input: applespi - fix NULL pointer dereference in tp_dim open
Date: Sat, 11 Jul 2026 14:54:15 +0800
Message-Id: <20260711065415.7396-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711065415.7396-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711065415.7396-1-fourdollars@debian.org>
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
index b6b4d258d0dd..1f8e4ae90285 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -968,12 +968,18 @@ static void applespi_debug_update_dimensions(struct applespi_data *applespi,
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

