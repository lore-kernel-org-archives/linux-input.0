Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465476;
	b=J4+ZuANH38pRinrRtWqam1HPNdozc0PZ9W42THT1JdUOrYX7pFgnzqS64kyKVGYKZunM
	 I3sFv1X0cbwkUvl5yiuuuRn/Q6cMwmD+gNFKY4kVsmqOvXoN/RxWjvNPCOwvPE4A1QH2o
	 lREdF/ioLezyNb84NNYXq/n27u2JbTvzd4qo9bkNwQLWb2Dig0bUbWidkC3hLKNsThSP8
	 KMSt051/sHABY5hcO+JzQrU45N9/Z0fJFYdxjSfUJidkMx4KZUMrLW0DflwD6y5TOIGcz
	 d3uO3d6kTzWy0p126wi9aEQ3ESpjKHmSs6FHn26IMdUAieHR8nqO+kF0+IvFuT4jXEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JBxJLZ9A+stI0T9T5K+ypprlCbaS+rb6xSEgaYsFpb8=;
	b=Pr7ZRAUm/UUuncH5sYZKD2kQM1gAzUned6HBi4SYCUdXpV0dnLv0CsqORjbJ0bv2moDU
	 n4gnC8gILLkSGxmvck6gO5XwWrRjnMV1/EMH690QdAQ15jkUHVaZCcuQzV5cDtY2AEeys
	 KmWT4NdjwwJTIZe8jd+CUBIvkosOp+16TVFFqo1WIezJ/kczbXlxMZ2NAY4Qu/WDOg2FS
	 BXmk6w/pvE1zY57ssnBaztDIP0SVb6PoOo1LefXgfzYrELT0VUhkI+342HOjMGFp2gxtY
	 4BChVtmzFX9z8q4E8kSgKeQesSgx8n0ZzQf3VSZ9afRcOYPnwYM2XPCI3am9P4y/KSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a291R2Tm;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F569606A323
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F569606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a291R2Tm
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f36c18b75so233545685a.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794465475; x=1795070275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBxJLZ9A+stI0T9T5K+ypprlCbaS+rb6xSEgaYsFpb8=;
        b=a291R2TmeVzX+ZoVQl5a1g1biY/0LsJrCAQEGU05PjlSV21LJjuSYaKMSxLRqAzE0C
         oWXoGCom82byt7HcHartYI2RKbISiuWm/7KXKQBxLfYza5U7SKt0NqDxOh3qWJgDWkf1
         /2Mbq3mnP+3x0+7sZMW+CU3tveq1Qmfho+c9KdLeFpV0HMr7ytiEPmlpoq2SNP2wqinw
         1rWoF+WrGAKREs3dTsqwOsMLuzHnj+vS0pFydFW25gv9I6CQsayS+28qGInk0foKTEf2
         hGse02rFGTgDaG+0/ULezN+rf1Yi8Rs1WMJWJllVFPCrpNGIzWok2pWC0Y3lK8FXzb5p
         43hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465475; x=1795070275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBxJLZ9A+stI0T9T5K+ypprlCbaS+rb6xSEgaYsFpb8=;
        b=1IfkiwoupVFTlKy/27sweldeXlgPG8v6BaNp0/6xrWZw9jW2Wvzbxs/beGECC2/aFM
         1SBCtkVU/yqg7rdajS3sAQoOx8UT9vKCIaVQ6l/NUQVLjuPUFO0Q9OnXglsHBwaH+42O
         ZOoy2gDXD7d/JSlZQ8/HMsydZw9VyavIS38plhyUBEn84/GVLdmSJZ5YVr4cYwhDOk9f
         JA6J5Dn2kNPaJqYZd3ptoM7Wb/OCvnBJdkuXXCVTHqCOIvmYF9F8KH+81Y2slGMp/M9q
         fQUc3Y1AAll2KMvx56eZqbDPLxGgw1cSLH8moAZ2lronUb3W1KtS86A/VVtB6mmymFzC
         bB2w==
X-Forwarded-Encrypted: i=1; AL+hErGix28bynUkN35zfOZZ3MqD0qSEVpdAhmgWTfx04u46hwo6vWaMLwvIl69IL7uSO3rgrHwgdMI6jJ5+Ow==@vger.kernel.org
X-Gm-Message-State: APuU4Z9C5TVfjWqyQAihsN9RGO3r5xGW9Nkg2PKnpfShALRiPhFKNCqj
	4TDPZu/UyA0h8rcxXbvZZEVpR7nsMXJsTnev/TtuZqkNkZUiACG0NNg=
X-Gm-Gg: AYBFou1GFm0PtLLXRRDSnQmQJ3vDaX8dS3GLlWURFzd9zW0jwxDkbKQG2MIcCPFQ38f
	6IYsoxwHiOrwwwgBGo5mrcoHP3FgYx6G6tLrlGij0eLm0iHXNsWiJiMsx96H/L0VCm2x5T0JjLd
	jzEBfyTJxDbvQUlja5JF7ViBWLw+6jl4nFvJt31px6mOsIGXm0PzwIMEalOJ+szrEBOmH1xx07k
	f158vSeul2y8oAjTAlGhjT31boGn3nuZnP7ixN3IdfadHtuu5+9zvFxMu31/U/32d+okreVnPS7
	5D2lM3p1v0NsmEsDXrTl3Zy667L1W4ayE99OdfG8fHvyW0NYKBDiSbmMEgBIHT6Cz9yWEgBU/72
	UlwiyPZsxfV4nfXQugOcz7syjH/bhhMCzELp9S/7eSs8QgIpN5ml5r62RCOKC+kQfPfF2LVwZcd
	kG7xo78U70UVjiiSdCDvlJG3aQrOUTZ5I1l9yueOefBZ8sOb73NNxAoMmor0DYxsBba06f9NHwi
	axw0htIp6G+6P6Wh+la3ilFSetJNe5tuNQdtb4aE49Yta2pWTU/bdluORXMue5+N0SZEcfQFtMs
	VNZa66cn+tVLFeCRGB74C6f6HUgkT1vrMrE0py5XjkItFxS3nQ2un9uJ4e/aQ4yeeqHPXcD3VAF
	RESiJ1lS2FS42nJXZB1pitSd8Z1h5ib/yeo5KMLM51P0xieduHmPCwedVjRKHSuztmXyegSHqYL
	+hn8AYzh8VC6vdyvdo7YdHFwlQ3Svy2Iv6
X-Received: by 2002:a05:620a:1b9a:b0:93f:3576:d428 with SMTP id af79cd13be357-947aff8876emr767795885a.22.1794465475188;
        Wed, 11 Nov 2026 22:37:55 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e3c34sm658719885a.36.2026.11.11.22.37.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:37:53 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ae878000@gmail.com
Subject: [PATCH v3 0/2] HID: intel-thc-hid: quiesce IRQs during teardown
Date: Thu, 12 Nov 2026 01:37:50 -0500
Message-ID: <20261112T063704Z-thc-v3-0-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This resends v2 with the probe cleanup formatting requested by Even.
There are no functional changes from v2.

Changes in v3:
- Add blank lines in the probe error paths of both drivers (Even).

v2: https://lore.kernel.org/all/20261109-thc-rebase-v2-0-mhun512@gmail.com/

No hardware testing.

Myeonghun Pak (2):
  HID: intel-thc-hid: quickspi: quiesce IRQs during teardown
  HID: intel-thc-hid: quicki2c: quiesce IRQs during teardown

 .../intel-quicki2c/pci-quicki2c.c | 32 ++++++++++++++++++++++++++------
 .../intel-quickspi/pci-quickspi.c | 32 ++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 12 deletions(-)

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
