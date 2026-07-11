Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A35474F
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761699; cv=none; b=RaSL4ovNa0zq1HdeNBNNlAgjf8lJJrFNYU90mXHgpLQ/5kqIEFfxje+O9NDcsjTzbE6KR15HMFdEm8FE1ssnq0nWSLLJdC1vHtfEBU26Mq/RsREoUH5h7uJt1XwW2jiOq69R9882YuJtOa3rEBD4L611M4o1OPTZmxRpM37XhZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761699; c=relaxed/simple;
	bh=6Lqq3SsRto1UjLy5iyFR5JFQX+HovWl0jT8mWHPbsLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L0Wwgtt86lq8l+7Vp3GTB7LXM8hP//I3Q2MF8593ygfbKyt55/1oSl+0S8QN5+/sy9PhARFvlJilnAgcqVeFqMsdPJRAhd69RMjBWbvtG/kKagntLFetSO6E5j44tFJqQmT2C8Ar66/ODBQP3GvhokYc+FkEyWyIXrVQQiB69SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1378705b3a.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 02:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761697; x=1784366497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AJTvwyhcXvY6PQwSFo4wzuwbYjER1dNCS/K3HQvqUo=;
        b=NbFLjEDVufTIaXGoQF0q/+9gdMmzeV4We2lI7/DASoXPBEXsESc5xBvRwBTBkaueKA
         GbpsaE/xBAdhvyhmhFkBTHB0gGPNvzxiqanOSrQiSrCRbres3CwUm5nYlgAqEOsIMwa+
         32ei+9s7QzooWUvv0IrSfUW/2JiR4STgtt4e0YYb0hr5Rjwp4cuBSWa+YSu3ELUmSG4I
         0Zy3kGWFHMFrFP/TDWvlYLc12xKznS4xDp/w7d8+Z2By8u5eIjTBg9u2iFEQcizZRkm/
         fpP812WYNdCXXEmNCvgaQ2hS/++qaIhy9TpHtk3FrzoQa+TTLjYyW23mnTMhZGCURMgD
         k/cg==
X-Gm-Message-State: AOJu0Yw9PLiCsFbzFX60fUcJPMLzcdnOvbA5pVIv0MCCGktR/NEV8EaI
	vWLivuc2mfO1Vi1a1PV6q+4O+32ncvwqJ7xE7RchmGnpH08PFLuqW8Y=
X-Gm-Gg: AfdE7cneNKcBzRO3ccdN8OVbmh6PMG5LR8g3W4Ukl3FfcT/7sq/2vedhHN/FQasqz1L
	sHxRO6vCnVRpgH01RrDm2jAwnqyY2FQuBf+3HvSqTEWDUP2Kts9znSedlU8D5eSmEhOEgyqDodV
	xZFQRnmtc3yINnx0BWq8/Lnzu1zHAs2Cr34oObsOv0lN8zpxe6evbSe/9PRKKCwf1YaIKde3wbI
	uWuxQ8dJdN5f/YLRFpMiSDbuNEJH9UvvCZzXh4Z6VNmNT4DWOfvs/AQ1cUUYb7KPb3Zx/zVW9Ev
	hrLrjk1Q50nTR5zvAshjAXL2JAv1/zksqj7V98nXa3HVEU8ZcmkZ7r6K+ecu/I3vs2dWk/S3Xez
	UuzPK1aCF+g/G/GO5y9tQveNEPk0pBncUxP1LE4Gd7tYFdGGxzdAM1bNYzMqlkEP5TZKWsofZCS
	unBt3KhS4EArg+vUaa+ihIT16v/oAmH0rR28UbR6qBOeIFmi5dPhBiro1fBj4QYveai4opNKuFP
	dQGovZjmYBaCL5qbtnnKaetug==
X-Received: by 2002:a05:6a00:228f:b0:848:3e69:4ba6 with SMTP id d2e1a72fcca58-848896eb4bcmr2198939b3a.54.1783761696751;
        Sat, 11 Jul 2026 02:21:36 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm11468726b3a.57.2026.07.11.02.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:21:36 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 0/3] Input: applespi - fixes for DMA timeout, UAF, and NULL pointer dereference
Date: Sat, 11 Jul 2026 17:20:51 +0800
Message-Id: <20260711092054.13818-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry and the linux-input community,

This patch series addresses a long-standing DMA initialization timeout on the 
early 2015 12" MacBook (MacBook8,1) on any boot (including cold boot), as well 
as two pre-existing, high-severity UAF/NULL-pointer bugs in the applespi driver.

Changes in v3:
  - Added a `force_pio` module parameter to applespi to allow users to manually 
    disable DMA for SPI transfers.
  - Resolved the execute-after-free vulnerability by unconditionally restoring 
    the original can_dma callback (even if NULL) in the driver remove path.
  - Fixed the probe timing issue by applying the can_dma override at the very 
    beginning of applespi_probe() so that all early initialization transfers 
    safely use PIO mode, and properly restoring it in all probe error paths.
  - Documented the Bugzilla link in the commit message of Patch 1.
  - Format the `force_pio` description style to match other parameters.

Changes in v2:
  - Fixed an unbind/remove execute-after-free vulnerability by storing and 
    restoring the host controller's original can_dma callback in applespi_probe() 
    and applespi_remove().
  - Split the fixes into a 3-patch logical series.

Patch 1 introduces a DMI quirk and a `force_pio` module parameter in applespi.c 
to disable DMA. It overrides the shared controller's can_dma callback at the 
very beginning of applespi_probe() and restores it in all failure and removal 
paths.

Patch 2 fixes a pre-existing UAF vulnerability in the driver unbind path by 
explicitly calling cancel_work_sync() on the asynchronous registration worker 
work struct before devres frees the driver private data.

Patch 3 fixes a pre-existing race condition in the debugfs interface where 
userspace could open the tp_dim file before the asynchronous worker has 
finished initializing applespi->touchpad_input_dev, leading to a NULL 
pointer dereference. We resolve this using smp_load_acquire() and checking 
for NULL.

Best regards,
Shih-Yuan Lee

Shih-Yuan Lee (3):
  Input: applespi - force PIO mode on MacBook8,1
  Input: applespi - cancel pending work on driver remove
  Input: applespi - fix NULL pointer dereference in tp_dim open

 drivers/input/keyboard/applespi.c | 76 +++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 13 deletions(-)

-- 
2.39.5

