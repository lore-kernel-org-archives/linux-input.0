Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9228DC4
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783752882; cv=none; b=lH1zB1ePz7N5Ls2a3WJ91f6i+bUdibOtHZAP58U1Mw8jSRwKUum9Gs3FW85POt+lMMIvMOjAAVREQii5QTWtK796ETCMQYNDvC9WxMBddSK/r2mfPXLYV8emI2XoIX/jjObTZTeSp8gf9bwCY2pGkjN6kS3IGDhnKbkYSiPE+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783752882; c=relaxed/simple;
	bh=D8yYnBi2xWj5LQjMfc8OYQDCU1x5mJJfXM9RShn7Kro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxRX3OwTsuQDZlogBe9/opZOEEGW+wQEzQhPl5D6E24vAngn1s/Vk167gQzu9OoOJgZ/Tl/2SgVmkkm82GrVTtsRY/1FfxLgyAcgpEeQ2mNts8t8mlpGEaUasyihRou/jPECxcXNwbJ0U2Rqbl67YSs9KIN9I/ds3eK/LbH7ZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cad8076b01so19938755ad.2
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 23:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783752881; x=1784357681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NehpXHsDwbbOd4+3jJr5pKlNjm8Jud+jtN5wBuDe+jc=;
        b=UjizTMPT3r8d9cCAUsNbMBm4JqKi5rMClzn7dFfnI7ioRFOllpsdUiMsVwbUvYeno1
         +kRsIc0qQ3Jg206wBzvRPJVDOWkT2L/UXFiuC35B0fXHqhz4gVDUamE/5YbRXZBdr+vL
         QifNPhTJBF3/gEodjw7C2tssgIpcvCWwVyLnVMgj+lc3FxDK/xV3Zy1RXyzPSwRlwWan
         MMDybrg996SLRB1xWqJuWtdF2nduudTmszHWlskPsjIIcd+t0SWS0WemuHBhUo5E42rq
         C9+yj4osGdTed/htMobgD/whaSA1g5i+ciXL2s2jkEZd3oBnSu6sAD5PZ+jbxjePXEfI
         KS7Q==
X-Gm-Message-State: AOJu0YwKxdRt6+/Ifgxg30PVdlHxDju+KtL82EuWttsrYwPbcv562lnf
	elb4ad0ym4VvbeDSVztFO7CPVUaQx509OKgjc9rZuwJYlQbONDeYxn8=
X-Gm-Gg: AfdE7ck0wZjQVuPfvH1nxAYUdM6cKwWJpjZgmwTDCizCaM2waS9dq9AheNxtAuKs9FF
	MEm8CwJfgK0YY1ykODU4FFgSMRwtWo2nz4Hg5IGmrxYp/vD8Y3KoO6ln21G/IU/MJu258lROon5
	Xr3L2PXFDbF1sClf3uyIZbkZNax+Bpbz2uGtsD1rsT2P8YM0fi4Vj9vDl1CwtVAIBsadkAtsSy2
	5Mc+23LyKhuZj10d8JJZiSCzkTSrO54e1isoHJooya021onlL83boAjVyV9/EDfoDnUJ8HnaqQ+
	uZ5SM6lcNj9MyoqYReFTdPLGouB4mPDVarOJ1XWv11OSq6Q25cvV4A05zhEkatl06hL5CLl8xcV
	EMAkwhvIrMZkx3MNDvrSQuvhBkZMD2cui9ALc9JXa8evrfcfXvJJutv00TJv1fKXEvI9n0I/jXC
	duqUU8IiqKYzzo/l9GiREd+cw9uTd3ICMsljPBJyK7HY3PDm/3Iy6vK3432Qmc9XpdNU4tFQlYf
	ZRiCa8Y3PSR6MHnYBYGeu5R/Q==
X-Received: by 2002:a17:903:2f0d:b0:2ca:304:f93e with SMTP id d9443c01a7336-2ce9ef1bd48mr21133375ad.22.1783752880825;
        Fri, 10 Jul 2026 23:54:40 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce8f5183b9sm18272535ad.5.2026.07.10.23.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 23:54:40 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 0/3] Input: applespi - fixes for DMA timeout, UAF, and NULL pointer dereference
Date: Sat, 11 Jul 2026 14:54:12 +0800
Message-Id: <20260711065415.7396-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711055247.5412-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry and the linux-input community,

This patch series addresses a long-standing DMA initialization timeout on the 
early 2015 12" MacBook (MacBook8,1) as well as two pre-existing, high-severity 
UAF/NULL-pointer bugs in the applespi driver.

Changes in v2:
  - Fixed an unbind/remove execute-after-free vulnerability by storing and 
    restoring the host controller's original can_dma callback in applespi_probe() 
    and applespi_remove().
  - Split the fixes into a 3-patch logical series: Patch 1 introduces the 
    MacBook8,1 DMI quirk and its unbind safety, Patch 2 cancels pending work 
    synchronously on remove (UAF fix), and Patch 3 protects the debugfs open 
    handler (NULL pointer fix).

Patch 1 introduces a DMI quirk inside applespi.c that overrides the SPI 
controller's can_dma callback to a custom helper that always returns false 
for MacBook8,1. This forces the controller to use the rock-solid PIO mode 
specifically for this device. To prevent an execute-after-free vulnerability 
upon module unload or unbind, it preserves and restores the original can_dma 
callback.

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

 drivers/input/keyboard/applespi.c | 38 ++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
2.39.5

