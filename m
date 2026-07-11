Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F13769F5
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770607; cv=none; b=gcxgBhakiP6BK34tbNKED1PdbpOlIBy0NZApkUffbCgp24CTaSmyoP0jvUvT+onIn9AIxfTIgJ/wtwxxMVFeXpgmVlBLtyBSaTeiNpVmqvksqH72CoLul3a209X2rGOIt3+gECOKIIsmeezChBohkx/V0E+pCxqbUZp1TsUVdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770607; c=relaxed/simple;
	bh=16ZCF42qfyfecp4FE6xDMCEwifOTFXd6LvfmvaYgqJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwNaZ9FVvRBAEVFygdH1Bsu4QnyWXOPnbbCIbUFxZ7Q/6tvnE+Tp2ufBuF01z0i38fAhddCGyUbcw5RbJWEHrdZ5ApKw6wPJHor9ywxB66KGLMxRmtllvKRADzn2mh4hURTg2upnoRCt8EaarWak5gF+/CwyRM99VZ4/KP7CQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1732507a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 04:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770604; x=1784375404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hk5V5J+DbPG/Ee/w/hWVnY1n/ftwZsWJmMFAPAEy6a0=;
        b=DqYmgjnaJ5LzhfW8Lti1s4mwFOIhSGD2Itg/VMAzxp3AZU1pokQ9NBdE9MaA7o3fa/
         NoIFLqWY3FUeAKC6ZdkIWDLoCGdx0SWPoSsRORnqUeWzLwg+6Gvbgruy4XukYbBHxEUv
         SCnENqZY6trV+j6uw5Fni5blC3XPqJ2t/Ev0r3irAsJZ1AVsDJmDPqt1TfUUKe/XYnAc
         JZLS9jcXoHR3sr7iXxoIGNUQRQsz4f2HQqIDU2JfKLVObozXHfE/gryt5uG+w1GFfrjI
         su4uvJWfMfpZM586cfSVB8xwcoM6XjMVV7hhDzycFA98Hap9CLKXm7qBpe4tvT8Yrq/O
         dJwg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0rbo7wr5nR1SFSIuHBcI1RAkmibgtveIEEREHDUahl/4OrLBy1xDIWWjWIySbx+LXToXb3Nv8Q0aIkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZqZpeOor2fvrdWdMhB9Sz92CvvoyjWBjACzu8yXFgjcMt9Ut
	qtlvB+QJxuqbpPubabV65a3aaGQbAiysKGlX9BLWglPN/0NRE8dYdDmuJendJglcjIyZ
X-Gm-Gg: AfdE7cmd3NnBZdp+b7EwDwOLnbei9RgVyCRHQ8ATogWUHEJQOuRjupnvxAchN8FsbYP
	pnOoqyFo67iSmT7xd6J8TEeRCyryAu6eTsZOyieS8c2HTnqBPSSnNtWbqmRTJtq13eYiuiweSjt
	Y050tYmsdORg6nFC74YHYgdUsRTBu4/Q7B/cGpqaRQ82EM7/4E+VBsHu2wy00yMs74MIJbyGMI2
	NJk4PPwPpyEePJgLoZjPMlxaVux19EqUHkkFjW1bJcJY8C8A0he1PtbsMHFtf6awtzsB7uBJ9Ra
	HdJkingA3K1ExllUXQUu0+F58T1g+wg00TD+PG9P+W8P1lf3SsMpssm4zOq+8KuKfDWe31sy5EJ
	vOcoXgSHi1MIpg204FI8ONDvbOROF7vQSXpOL4otqq4cVpIev19NwUwq9zrqjGjySD2GqkSRn+C
	7nENeRTy39rrdfA1eaDGIFGn4LrRcyE+0DXQT0SnMecDtqAmxEoKgEiIC+ufy7FOucx7S9pIOqx
	VrXmqUuV9g3y+OaiuvNZb8zXw==
X-Received: by 2002:a17:90b:58f0:b0:387:e0db:bc23 with SMTP id 98e67ed59e1d1-38dc77b82bemr2604555a91.35.1783770603661;
        Sat, 11 Jul 2026 04:50:03 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm3957570a91.1.2026.07.11.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:50:03 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Shih-Yuan Lee <fourdollars@debian.org>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] Input: applespi - fix NULL pointer dereference in tp_dim open
Date: Sat, 11 Jul 2026 19:49:36 +0800
Message-Id: <20260711114937.16670-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711114937.16670-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
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
index 3bdb9e7cfb8b..4d339445e9c7 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -963,12 +963,18 @@ static void applespi_debug_update_dimensions(struct applespi_data *applespi,
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

