Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDE34F255
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770600; cv=none; b=dxlhhOKBcPov6dSz0o+Q+4c8blertFEIxx1NRRYuXC7YKr3KkHnaKdu8yvGzC8RC8UMPBbndlKEtT4f2WbYcvaJu+jx3a3/chLK9V2m/njCJXsfyJZk/9+/PkxxzeEkH59kn1Qs4Tm94puUXwnjmTP7WyW5k/fxEqYTYAvc90tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770600; c=relaxed/simple;
	bh=Ywx0xSaBfiyT+DYliXVShFmq1Z788TCNlfdv+ynHru4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGYBvGWkL3I4DIvWjsnsE5EWXZN4FewuXnYxJhMvUTHHIqViERJBQJBsNmatfgjdYpA3EgpAORX/3rwENvQ49aVUzAwu7gsKZCQeGAsK2/mjROgINxKW4DqVAxNas1rG5Qv1evAzFdy8DmiW5aI3x3NYBU1rzDB+Inf7LGUwDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1541481a91.2
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 04:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770598; x=1784375398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lKrCfY1VHLhMvkhcd76jeSHgip0JtyyrN3VT+vcLICs=;
        b=kmFY/p8tYlEfuqpkjMyJrF6PZDU6KUlf9ICU5xL7liMTfcmnw08Nrh7hr9iqYWAyc4
         3BY8dzvH44RmGR9+clbyw68rd9Xfoqm9CloFZLXvyla37RtOjdBM23HfLOVP/XEDNnIo
         UwZPht6W4Mt8eq8lEMUsC3uhWiJso6u9W8KqD8WP/SVNXlDWchqEns+c1ihrz+lFbYlR
         HXe2tpYdMnCrID99GO508b3tg70p+S+ealNFOhbaAIIDzBzDltsVWsaTIIgIAETT8Xik
         Oc8WJaTm5RbgjVOyTv3fv+Fc8fNWfnr9FjfHuMgOr5OcLFRe5IcCS3+7AFcaRNgI/ses
         ACDg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/C31d2mWPcofUhVKru1r32w9x2nAdXh0DfNa++qK9zM409MU4JK7E5xLMg25gjYp4tIzLrOyyM4SOUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/xjgKPA8EXJ2EOnIUY4YEHtc6ToWxRcsktw+4HvF19TorZ2d
	IrwsztGJ3YtxP4f24uKaLLZ7g+ugVWG6ctgGPXbUoHt+S4Eoa1we5Cc=
X-Gm-Gg: AfdE7ckj0Sx7LDjAVVzTdq3U3HuLuai0ksEAUk7FbXUtYOh1ovnktJd9Cy6jxz2rZQ6
	6M6P0rnH/Pr+Zuk2dFag0EyB24hWF9CpIx0bTNEGt/YBTUKdUtDqsmGrpA2sXcCL+L/pIsDuWve
	1+W+O2RQpzjcNc0c7vFzw0oc4taKgIzoaTSIHDdWJPIHfr1IgCdzbQJ03Go+7gJzKksSXoNe7+d
	xk+PQWEkjHpRNkZnOBlwg4nR6LJmjDi1yas1Sk4EG4fySz8zOmQXr4zlwNBOAZ6cdl/iMheRnRt
	CN2+dAs1Je2WbqwTHO6tKEF/ILTeO2cWhSD7Vr0vF3qFPFJjMNC8sz3ZKL6y4jA/WfDkgfP1i3E
	3hHK0ic9+Wfz9BweTsaAp3xkBl6x4TSJtbjL2/JVx+2a1pJTbuX5rKOKsvqJubl9888k7AlH/vS
	fu3/X88KWqvTlAlMs7ZFb68/ds51rHpArOnsrIY2TPRq+VuYRSWFmOlU+X3Xk5YpiVvbtB8Z3P+
	irAGnFTWgndtfoCZSb8DhPIw376zHlwWnP3
X-Received: by 2002:a17:90b:1644:b0:387:e0db:bc2d with SMTP id 98e67ed59e1d1-38dc7ba5a7emr2604450a91.35.1783770598497;
        Sat, 11 Jul 2026 04:49:58 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm3957570a91.1.2026.07.11.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:49:58 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Input/SPI: fixes for MacBook8,1 DMA timeout, UAF, and NULL pointer dereference
Date: Sat, 11 Jul 2026 19:49:34 +0800
Message-Id: <20260711114937.16670-1-fourdollars@debian.org>
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

Hi Dmitry, Mark, and the linux-input/linux-spi community,

This patch series addresses a long-standing DMA initialization timeout on the 
early 2015 12" MacBook (MacBook8,1) on any boot (including cold boot), as well 
as two pre-existing, high-severity UAF/NULL-pointer bugs in the applespi driver.

Changes in v4:
  - Reverted the runtime `can_dma` callback override from `applespi.c` to avoid 
    architectural layering violation, data races (TOCTOU) with concurrent SPI 
    transfers, and execute-after-free vulnerability upon module unload.
  - Moved the DMI quirk forcing PIO mode for MacBook8,1 to the host PCI glue 
    driver (spi-pxa2xx-pci.c) where LPSS setup occurs.
  - Formatted the DMI match using a structured `pxa2xx_spi_pci_dmi_table` and 
    helper function `pxa2xx_spi_pci_can_dma()`.
  - Added a `force_pio` module parameter in spi-pxa2xx-pci.c to allow other 
    users to manually force PIO mode for debugging.

Changes in v3:
  - Added a `force_pio` module parameter to applespi to allow users to manually 
    disable DMA for SPI transfers.
  - Resolved the execute-after-free vulnerability by unconditionally restoring 
    the original can_dma callback (even if NULL) in the driver remove path.
  - Fixed the probe timing issue by applying the can_dma override at the very 
    beginning of applespi_probe() so that all early initialization transfers 
    safely use PIO mode, and properly restoring it in all probe error paths.
  - Documented the Bugzilla link in the commit message of Patch 1.

Changes in v2:
  - Fixed an unbind/remove execute-after-free vulnerability by storing and 
    restoring the host controller's original can_dma callback in applespi_probe() 
    and applespi_remove().
  - Split the fixes into a 3-patch logical series.

Patch 1 fixes a pre-existing UAF vulnerability in the driver unbind path by 
explicitly calling cancel_work_sync() on the asynchronous registration worker 
work struct before devres frees the driver private data.

Patch 2 fixes a pre-existing race condition in the debugfs interface where 
userspace could open the tp_dim file before the asynchronous worker has 
finished initializing applespi->touchpad_input_dev, leading to a NULL 
pointer dereference. We resolve this using smp_load_acquire() and checking 
for NULL.

Patch 3 introduces a structured DMI quirk and a `force_pio` module parameter 
in spi-pxa2xx-pci.c to disable DMA on MacBook8,1. This forces the controller 
to use the rock-solid PIO mode from the very beginning.

Best regards,
Shih-Yuan Lee

Shih-Yuan Lee (3):
  Input: applespi - cancel pending work on driver remove
  Input: applespi - fix NULL pointer dereference in tp_dim open
  spi: pxa2xx: disable DMA for Apple MacBook8,1

 drivers/input/keyboard/applespi.c | 10 +++++++++-
 drivers/spi/spi-pxa2xx-pci.c      | 33 ++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.39.5

