Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DBC3BD62F
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775508; cv=none; b=mS9nEZoVy/zIa43LcVWaTjGuWqDCsWvQnmYvZdGJUmPbTq5RV/7fzbAgiICJ2TzEUclCqyhbvLoLHveHrfZvegEvcY3/feJZ53pwpNOuw1dg6zJzHBWrsQhF4Uxqp9ABNktzh3UCCkcUQ/hONbcUCtkY+A1VDAMkAQMqMxZ0lGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775508; c=relaxed/simple;
	bh=Cn6yGw5q9/Z0212RFdCF/Qhf73gxRfIE4bUedXUKP7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q79mWIu7/EZyLFodl/myjm9vyAqRkSFmla67BXUscdXu5zERZ+m5/mACRXHNmHhqiP2RFUUg7jsb8jAApZVnF06Bk2TuGOvkGfPCH9MMTKXqv0xGTQsOBxma/dLuatVGr5Z/E/aORDQ3svioC6nD0b/BBniZ8hGWx4ACZxvmH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1761065a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775506; x=1784380306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wB9KtAsHUlHpaPuJBonnbCsh7/wGYO7fHNabzQOq95U=;
        b=mWhXXWqQPK4xGkoygrlF+uvQhuLNFxbrMdoafml1V9ejNhiUbV4DBcbzTP9LxE7bdk
         bWrwJ1oljgpkWNjY4klE4HFO5gqKbH7oLjnXXfXWqoLZNLfOlA5ZymnJ8TFrAUFeqgBn
         ih/3I4cbayCDxqrnIzJWF0+M5p//Jbdxx439GGTagp4Zf4NBaiQ+GVWdjWm9Pqx2xNad
         m7Sob+ECQ4xdOd7WX4wqvZYCq9D3b0ewzkbBOrGoLPo883byvk4N5oftr+CzrutFdX3Y
         lGnPWuz7Y3GV2E2T/umLECD6iLZ9kGUbIlfqmrCI3gpDmgdAqQJzKlCd4XysTKC4FfGF
         UOQA==
X-Gm-Message-State: AOJu0Yze2clByDp4VoeAodIiwMCD0pBdxqwop0bfT3P44XF8TPoBu0V/
	kq7fEgvH03bI7WmbR4Daysof+sTJpVSHNPQyTeD5O/KsMj3Dzd7bzTs=
X-Gm-Gg: AfdE7clUQ5DraztHE4ZAblp08P3NrT27AMf8JePc4CUPFvU6v3gRbaLaZ64z1Emla13
	lag+vN/CqT1edrjy8wOibRcHC53QsezIE7YZi5fj4HVDDNRZIhXOd/y486ypIBCNnFiP+CT0R5c
	ThMP7EJY9h+2C1y6wyb9ZomBNoclp//A/xWNSimJ9XwNdjxGLaMuyLrNmRkB4K0WSZvh5Q0PAEl
	B191ppQiItFJY5tMlz+LhNDh15etpRRqk5e43Uh7V+v4r8RA0UOJiFPKUoTL3vUZs1wDDu9hWMk
	CJZ7u41OKMYuuUaHztCS3y1DWAsseEgyOvU9kf1ZTz3JKHfv6X8jJ6zbg85V9bjUyLS9QwWB/Ni
	pg0U7MWxNY1Kd8D7+VB9SMOXP+NQ1OFDlqdHw9iREktjZ54u3XpBgajUL7eyrNCXxV/dhgh+Z6k
	lcnnRLCe1T54SLWQS9MMrboYCLDmW5NK9d/MrW74xY8Kfmeyz8xPRhxhSdukss3G54NKrRbEHEU
	dZtmYqrhu5RImUF+OP4GgWPhw==
X-Received: by 2002:a17:90b:560f:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38dc7779d1bmr2946328a91.24.1783775506362;
        Sat, 11 Jul 2026 06:11:46 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55557f25sm4136221a91.5.2026.07.11.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:11:45 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 0/3] Input/SPI: fixes for MacBook8,1 DMA timeout, UAF, and NULL pointer dereference
Date: Sat, 11 Jul 2026 21:11:37 +0800
Message-Id: <20260711131140.18777-1-fourdollars@debian.org>
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

Changes in v5:
  - Updated both `lpss_spi_setup()` and `mrfld_spi_setup()` in `spi-pxa2xx-pci.c` 
    to consistently respect the `force_pio` module parameter across all supported 
    PCI devices (avoiding hardcoded DMA enable on Merrifield systems).

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

 drivers/input/keyboard/applespi.c | 10 ++++++++-
 drivers/spi/spi-pxa2xx-pci.c      | 35 +++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.39.5

