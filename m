Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD838C406
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756338; cv=none; b=QEVP70+nIVqLYPqI6/tlM4nIGowiFMxiWNdnt6L4TbMl67Wdu4qJSb7A77UCq827JglKxm8spncOxdZlmv4d7dGFtKBuilZsFrD1IxJO+8niYesGaM75j448A9MBajC/pFTi/DmdGyiivnThel2b1suhV9VhT8qCEPLEFEsLelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756338; c=relaxed/simple;
	bh=No2YuVut+yvKVP4Gc3VbjZiY6kYBHQiFWeVJHG5ZJ+A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fPmHxfLSIWFgbQctH3xkhC1kxPBjBqb4RVHNRG6VLptCfqqeJk2Ae5oXYBwSH38w22RGZP/48luDfKDSWlzkBcvZe12u4WzPFp02Ib7WXZToYCnVwA9r/0vVVYRx+DthBxUV5UhpTowJzTu6vvkswk8lxyzvY3w8lXHr5dU7PKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSrFTuU7; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSrFTuU7"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917c04630c2so19284056d6.3
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 15:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791756336; x=1792361136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=No2YuVut+yvKVP4Gc3VbjZiY6kYBHQiFWeVJHG5ZJ+A=;
        b=kSrFTuU7lwiFje4ypqm4qzHv5q1sIZbIFofOorZI3naKRnU0x8zdXczu+Bkx3G1/7w
         TYnhEfNjJFzHrR61U5shQTuJa44qbvWEY3WapUSuzXU9c9cbgUJZeMKcRNK5E/US+Hsv
         3e/ktzBalZBrG0BMS0aq/AIBVp/2zk3/SfjF6vTkbP5Rsm2WJmV7um0kel2dHqVkLFwC
         4gCN1XwRVY96rXv0si8O5dckUrLkBYeKYPRu3l63HUoAdPCDDTe9hELExqvHCGzjAZ17
         68c61XS1Xajaf4ZWBlTA85cI5nH28HuEze27lmZ7ltseEN0IllKfIlrWtjWdeL3jeDme
         xk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791756336; x=1792361136;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=No2YuVut+yvKVP4Gc3VbjZiY6kYBHQiFWeVJHG5ZJ+A=;
        b=op/t81g1//Y5dA4iuJP4WN360NFxlgHv6ZU0WQ0JFKd8iAQo5fKtwZD3SSy/KXBO1d
         rlWlLf26SsvC/INkGI9aHMq/qlzGneHFGYBIxditopeP5XOM0iW+ou0elB+Q0K+mW+zg
         +rPB2ZGXwX4K/Hr6cQzKByo/vVvDOQQbm+wbmNuuiGw1gJYw4eoiO+z1uRELf6R/bZs4
         XjPpWzqJIx3EVB6g/JR3reSC3HfBRnKAU7j32K8JwKz7Wt7zn3Z6LBEo1TJ4M0gGMlxm
         jPQZ4KEhZDpMVMUj3RA5FRxSR6JZV+tH6Ju+AMMihm/oBMZ7OROpXJWNEVgGWJI8FMyV
         ePvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuvOtf2PX7/qgAGei+ZcxIqjGdg7IU3whhBv1cF/yfCxrjnGkAQhJTQxqjj+kb13JdhOt/flAnBeLAmw==@vger.kernel.org
X-Gm-Message-State: AFq9FYItrKWxuf+0ly8PUMlMJ5hSLwPCzE0Ve6SZ+69Bs1YQSjyp8mrY
	FTBmCVUYuJT1bllT4k/HYT05T+qRk7HNOpo/7L7abah9v4qJT1XhdrM=
X-Gm-Gg: AYBFou2S6/ycbtOhfuduI1WZF3Nc5UgXDWJr5hdTsQfh8D9zSsYwS+k0dcNV6zcJ0Yk
	XA1KisU41XILWJaKMdElus5rtpeAkgjNIczKfM35OE1c2jdwMzxY3w0qLPTJxX1XL/HUimm0h6P
	dTiBibxLW5+Msp6qlymrEtTQrYT4AifflIyI4g+PLwflnQCsMFAMQKVHsoepVTzcX/hQ6OBpB20
	E+FBsKhSbVWe39oKu7yF3QOfNb/ZFPScQwxfSjk8JcgIa5QLbOOudAUiHHrhNZQ0GXEKA7WmzqF
	rHhCQsQFK3HR2o/CDV5BHPJrk10v37WYuOKhrYKxzTv8vh+Ln98W5hJHeUyklJ6h1LJ5C8muqqv
	yLL9FDO1HX7ciiaGmQhl2GgMYvBILN6t5ow4l1sbdNo0BFq59VrT+liXq9/Ld3oSwzUhX3NmxBN
	HSxyN1wND3e/ugE7z7ZeOKb46iWYuvqeQInq34K8IR9uPRY1L9C8fGz9HyR08krXnPvhx2RcPNc
	s96FL5RDr7ib58yxNOyqwkNtbALzAbObAC68bRh7ww4hwvd/OxGbd6PZnAyNOOASBkCSeRh8zIj
	aXANtahyyeOn3yOGTtmSq4xgHsWrK5D02/jBLt0=
X-Received: by 2002:a05:6214:5d08:b0:917:a256:c151 with SMTP id 6a1803df08f44-91b557c63f4mr151810126d6.45.1791756335963;
        Sun, 11 Oct 2026 15:05:35 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b54e7f6a1sm79788786d6.6.2026.10.11.15.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 15:05:35 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 0/2] HID: intel-thc-hid: quiesce interrupts before final teardown
Date: Sun, 11 Oct 2026 18:05:29 -0400
Message-ID: <20261011220531.2073892-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QuickSPI and QuickI2C can tear down HID/DMA resources while IRQ handlers
are still running. Stop new IRQ handling, wait for running handlers,
then drain recovery work and mask THC interrupts before final teardown.

This series covers remove, probe unwind and shutdown.

GCC 15.2.0 x86_64 W=1 builds, strict checkpatch and patch application
checks passed. No hardware runtime testing.

Base: 238650ef6c7c7cca08e032527329424c9fbd70e5

1. HID: intel-thc-hid: quickspi: quiesce IRQs during teardown
2. HID: intel-thc-hid: quicki2c: quiesce IRQs during teardown

Assisted-by: LLM
