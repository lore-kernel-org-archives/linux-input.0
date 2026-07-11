Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E43C8C55
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775510; cv=none; b=lEoP7tMX6HQ71oe7dYtuqPAs54bjfC6kccQihOB0XcagTJ8O/SWQqkat9JmbQfiq5YXh6IzJcMDInYUJMYOMwPAZ1WAhZIPG0t1BdlYP3pIRSCHIrUIkVrfJFMJVaMLEJefOV2Gh9sxsWOLgxR2zij2DxbxE9fj6a8SJV/idF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775510; c=relaxed/simple;
	bh=o2Hiy84rnP/9UMKURCEIhcD7/nHJlcIAPilhOK3M2oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=La0zmBT/dDiYn0eIQ6D43Vzl3y/b9UGSpTWAJhQW32bsdY8TCrEXO35uCiW7VCtCYfOL4VDtXLLwpGN5p6garlTIBCR13jvfM3YwQk94ASueowqrm4oi7RPMqeJ0H29RHbaWCFGEipHDbn1f0008zmbnoJvXssH1Kg7ajabKxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1761075a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 06:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775508; x=1784380308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJ53oWqRjCNjVlROCxKHTEOJ8pLHHBllpxRR0nGEHyI=;
        b=GziGw4svcqhg033u7x4ei2cfVXK9UwyMjl/zlxpelW/SB15N0ZeOZVSH1fsk6vdllI
         muaTpgwX//jx9bxbtUu/2KqepqLkr7x1JU2hUXSc+Cjee8jc+IxzpEzPgroPJLQ0XNXs
         M3bSrBNaDkrGGfAWvkP5ZX4iGb4oXr1MQb9NLdhgL1DZou/QOlGtgFJf5pItL61TSJwo
         py3asB+mUwFCIq8qmvU3+uJQC3n91a0OB1M44OMnFGVFET7ov8knLPqwYQGITqchOhlB
         S4lgTLHCAWJJhZ1hXEhIY+Bx51zAsxVFqtPzuCa0UKqT63vvyVW+paaCAFHPHeZ6mxy5
         jsdA==
X-Gm-Message-State: AOJu0YxdsXU9ZLaYVC60QSUkvVzdN1UYepHhjMYdGT7q3oINeo8vyI9c
	VFD0ZeaPyHbPANAzoEbx4chA9ezjYVPCj3YAUxhZ1uKKtlbCieePB9g=
X-Gm-Gg: AfdE7cmVBhFQ55FCkQleJv5kJv5PEYacwWvdwV1SILdN0dzCkMhANPEcDT5Oc1MaV0s
	ZRvWaEQYrGSMbsE7PW0cBrL57iyE+xb97WERPHsbV4LOnXiXt5vqRqp8Qd7vMWTI+ZLTU84MszU
	yGeIYHHr+mmu6pJLZcfx/nkPbNNzGmhMORhCE8ZZKkIou91v1RjetYGxFAuhUK9StyC617+CvKl
	w205AX4bgulA4X4P1xlmrlQT0ff5c+WQurL2RfGunws575/Fingn37doY7HAGVTcy9qkciYeEkw
	vywtVYxBjikkcMZg8dIrhPhBXQxbTENmJVRA/BJZi2VGABBqD5vZzUmSMrvsgtKr2Dlu4H79pRI
	kaxz0bt+XMommFcbO7qjvH80WrIw4N+Iu55JVUxf978HsHIvWAN+XcEUAhCUz8WDqHGk+7/cWmI
	zJI+SIhRQm8vXA2do9JwRC/tbsLWOGsjHRr3SKqUKOSFq9/03DPWh+0zRg1qQPSdQtAD6ZlnPl6
	dGDHUxz6DrAhiPcLIbKTndG5w==
X-Received: by 2002:a17:90b:224c:b0:381:b64b:5a28 with SMTP id 98e67ed59e1d1-38dc779eb0bmr2445869a91.30.1783775508217;
        Sat, 11 Jul 2026 06:11:48 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55557f25sm4136221a91.5.2026.07.11.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:11:47 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 1/3] Input: applespi - cancel pending work on driver remove
Date: Sat, 11 Jul 2026 21:11:38 +0800
Message-Id: <20260711131140.18777-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711131140.18777-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

This creates a use-after-free (UAF) vulnerability if a pending or
running worker thread attempts to access the private data after the
remove function returns.

Fix this by explicitly calling cancel_work_sync(&applespi->work) in
applespi_remove() before cleanups.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..3bdb9e7cfb8b 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1822,6 +1822,8 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	cancel_work_sync(&applespi->work);
+
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
 
-- 
2.39.5

