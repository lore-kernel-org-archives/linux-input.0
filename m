Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF643E075
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564560; cv=none; b=j2cDAn9XDik4yy3D3KUktU5yyRjUimkkH8VbRXUPCjukt5KPoDdRl5Fg9+RgLVL7jB9omNNrb6F5/iqvvbICw1oKK1TFgrmD/bnvJIKFox8yCJJ/yj/1wA+Wo2G6yr0/d/vFCo7iHldou1s8FQH2PTXCJ0rM65QhE5EoW4SUtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564560; c=relaxed/simple;
	bh=9pB2UASsNT6tRLrddKLGk3chBzvFw90R7Bm4zhenDzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TP+0Xc1/e+d3AeOCb8qzwkicWWj3XQ+8TJ5TJYCvFA8j0ZXRCVS6hlNUyf57WOGVnc9aDEXbHdl9cBaFFw8UcV5KMu0M3FMirSU4cyicQyUzgbKvV/l5dqF0HHKW4jsYynpKEfDVdgHXWu1snBL+IJJTiOBIrJwKQcwzAlsBVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-384c94c9414so5879674a91.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564551; x=1785169351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iIWbRQOsRBXbHQl+Eokek9JB8ruZxyWntLUXaYunpkA=;
        b=gCH4CcSMud6qjXXSvsLPPmBGYz/qzv/xvH56E+egBTbNb8aPuNUTHEYNwwmZI5QlsM
         v2VV7AJ9X5CltSj+rC8e1TYNN6Ge7S2/Snm5undzz0w73pxWyvV6GpqdXU2UsGqjCdxx
         9x/ZxJ6WAphffjUHMJspKr97cFTQnOGtlPWMZ9Epwy7Xz/3wv7udh/hswk66uKCaX51N
         JKV8pqWxLV3FpQlQphsAmaHAAnBxk2nHt+gaZcs4UedCW+FoSMDOnfzAax7p6BgcBtAN
         prW6HoKVCaQMxqafUhIhIlV2OMpMzf/nVxgomRyoGqKPrjEyYh34oA5ZROxfhG+93bvn
         3KkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJq4gpyrqMmnUpWmufRR8fUZbIEzqtUOGBrzV67T9Z0kI+XqEP15jpxob3Iypgs+kNY9KBKB1GD8v/pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtVg0s6HM3sXotwAyrysjSLxBCqpNJy0/n/wBtLeBTyQeXg95
	ub6+KLSuno8bBEv6m/0z4myIxpIsDjRxyMjQZTkMpu4EnyQZq6/SWfg=
X-Gm-Gg: AR+sD12f3vi8VvBLan6lJ8uf+e2uRr0GkXYbR+OwnkPDbSY2b/ZNC4b62kWyHjM6ePt
	0OcQ4ppfwWKxp8jm7Yd2WxxbCBwZx5sf4HDCCWUosKqZL0uYd6Kd+DPlYxb0OOBQZqm29Smgv9V
	vsguxW6fqxZRyt0cSiHFXZcVrV9dhfHTaOEKhtyTs0vp0qL72azaE8GPev+zqxFuc7sp0zFd99C
	e/wrDehxTqAo2PFazEUN5FIA9pLjRCbfdSNLWaxKM3EJXe1Ko8pOo0XZU9RONq0JB/mLpVQUaja
	W5xaZDBXCGKUn1Oyd8HbWpGxlHOyBolXDbxRaCEXY8lFvmOZnR3fGz92Kshj2VyEEgW8h4c0iR8
	HPdAqMIshNl6JgdjxqxMG/ZTPQ7McKbyjuAvedsawWyBEt+uxVQ2YnUMKZF5jsFQ1L9ywr4dJ5p
	fOtCRFlzwlgM+l5Y/IsQIo6Qzr3m0n6M3Qlz5g/y7P2fKCNnBSDv3drt+8BT3xR0utTQKPRsGRs
	Es9N/LPetIxzMu0rQ==
X-Received: by 2002:a17:90b:2151:b0:38e:59c2:cbc5 with SMTP id 98e67ed59e1d1-38e59c2dc76mr8159002a91.18.1784564550787;
        Mon, 20 Jul 2026 09:22:30 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9205d358sm29366a91.3.2026.07.20.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:22:30 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 4/5] Input: applespi - prefer asynchronous driver probing
Date: Tue, 21 Jul 2026 00:22:18 +0800
Message-Id: <20260720162219.32324-5-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162219.32324-1-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set probe_type to PROBE_PREFER_ASYNCHRONOUS to allow the driver core
to run applespi_probe() asynchronously. This improves system boot speeds by
avoiding blocking the main kernel thread during the 3-second touchpad
detection wait.

Additionally, clean up applespi_tp_dim_open() by simplifying product ID
retrieval and avoiding dereferencing touchpad_input_dev without a helper
variable.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 6db4eeca3060..a21e89f30387 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1029,6 +1029,7 @@ static void applespi_debug_update_dimensions(struct applespi_data *applespi,
 static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 {
 	struct applespi_data *applespi = inode->i_private;
+	struct input_dev *touchpad = applespi->touchpad_input_dev;
 
 	if (!applespi->touchpad_input_dev)
 		return -ENODEV;
@@ -1037,7 +1038,7 @@ static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 
 	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
 		 "0x%.4x %dx%d+%u+%u\n",
-		 applespi->touchpad_input_dev->id.product,
+		 touchpad->id.product,
 		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
 		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
 		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);
@@ -2044,6 +2045,7 @@ static struct spi_driver applespi_driver = {
 		.name			= "applespi",
 		.acpi_match_table	= applespi_acpi_match,
 		.pm			= pm_sleep_ptr(&applespi_pm_ops),
+		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= applespi_probe,
 	.remove		= applespi_remove,
-- 
2.39.5

