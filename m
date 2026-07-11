Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CD2FDC27
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783749179; cv=none; b=D+aKekALswa22Q/JUhI6sNZJL/++vSmEblBPYUi53V2aHGwEU9EtwD1F9+RDASR2DASC7nrQh7TNEB80YAHE0GaApZ6eQIwbCbLYy0Jke4aFiDXO30uxPaFtmK5mNmxkrM+WIxOmf2m7FHHwoK4cuS/BMhKRIDoxMPvf8YJiQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783749179; c=relaxed/simple;
	bh=xphEW9XTWpS33CqICv1EZRuHhUQvJtLUGr5IZoIgBws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K80WtB83aJp9reZyr8E7WJRa9L8HeqO0VRbjBj4VvmWJVEkWSTavzEEsDqp9TAy8atclfePSJxBkP9jmBAOThZ1qUy6kqMNCsGiioSSSyxl4vDw2g2kDlqPNlz5QGUNPq7g8lTmmH73vw0ATSKOmg5ZWJzk7bfLSbF3QnvAeSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84864b41100so1402348b3a.3
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 22:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783749178; x=1784353978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TiuABHyoT5VB4eAodbqY6nxwBvN1wwB2YRwpSyn5yOw=;
        b=J/7lQVSGHFV65lTu/GRIj5mSZFtbJRfToSbz1CA6RylQgiePPiGkxSurxLwNyNZavX
         hIIP9DD2JJYWkGtQDLGTVpOfpvDMIDQA8q5UbpEQN3BYSGXwq/A31lLLnRcJm6c0n+Mn
         E7oxYOarLIA79eobWE+imQObJ8MuNNpYCI3bZNXTam6DiRzmOGq8cCsA6/NlxEIB+eQC
         0z76TbLggEwLnmikEw3Z26IQ55iyJ2rk5FlGu5Mo7eptxzn395SVKT8T+hNHxU/BKz46
         tzcT0lxQ1rjGSGpzAfOgwl+YdNAskJ4huT+0FvrlZs+lrIBXWGjziwg2TzGRF/fD4cAs
         P54Q==
X-Gm-Message-State: AOJu0YzFwDK1WO8miVnd5TSFoMO2k65YGC95r0PTbBgasuu+Wrj6am3K
	TOC56hGVUYv8uy2t/8uD6B3bXtQ3JuERKxL2gKVWysbpAcvQqzUhAKM=
X-Gm-Gg: AfdE7cmdpFqMy7+OPavkEy8Kv2Q0qPDyvAq77/2FK4R5spvbeyvjpmfHMZzQRT8mpkw
	58Pc92Zt/nADrtM4raMAxNWfnWWqpXt7BhYK8rrEXIUy/QAGC9zIpgmva325JwGQbdDeYiI9YEd
	HJ9sIqJyT0Xa7HTcayQin+q4L4V/y06qyD4se7h82zwEYjqZPV9oZsoBLe30TY04BxMzISFez1k
	9rGoRwAoInIeEEz9mQfAadhX1wXSwK3JKvNXlsNYX1/ozDW51KEL8Wn6HpiUieTEtWEiHA7iLz9
	8JyAO7ypHHogdd0byipJ3hiFERIk6BTmVhXj8BL8fqvReCvJBwaL+08hiVoVX5Blf3ud+hy4axj
	QdqBr8kUqk1K5jbSF3zcfNyXrN/5n/Iucl5K/sk08YNrAtWy1XH/ytc0aLNZrnDIa+lYQipv4SZ
	Zk7t2Lxv/4MNvi0oRat0dI6JxQT7mlBi6Yx/HagbxfQsE2qugVnOfoIoX5JY3DLHlGVvdKmXJPy
	fCoYW/hPXeznzczztGjaMQ40w==
X-Received: by 2002:a05:6a00:2346:b0:848:2f84:736 with SMTP id d2e1a72fcca58-8488990b70amr1881143b3a.73.1783749177965;
        Fri, 10 Jul 2026 22:52:57 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484123ce87sm5360084b3a.58.2026.07.10.22.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:52:57 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH 0/1] Input: applespi - force PIO mode on MacBook8,1
Date: Sat, 11 Jul 2026 13:52:46 +0800
Message-Id: <20260711055247.5412-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry and the linux-input community,

This patch addresses a long-standing issue on the early 2015 12" MacBook
(MacBook8,1) where the SPI-connected keyboard and trackpad intermittently
fail to initialize on boot, and consistently fail to initialize after warm
reboots (soft restarts).

The issue stems from a race condition between the Intel LPSS DMA controller
(dw_dmac) and the host SPI controller (spi-pxa2xx-pci). When DMA mode is
active on this controller, transfers consistently time out (taking exactly
200ms per transfer), leaving the applespi client device in an uninitialized
and unresponsive state.

When the host controller probes before the DMA controller, it gracefully
falls back to PIO mode, which operates flawlessly.

To resolve this reliably without introducing platform-level DMI quirks into
the generic Intel LPSS PCI driver (which might affect non-Apple systems),
this patch introduces a targeted DMI quirk directly within applespi.c. On
MacBook8,1, it overrides the SPI controller's can_dma callback to a custom
helper that always returns false. This forces the controller to use the
rock-solid PIO mode specifically for this device.

Testing shows 100% reliable initialization of the keyboard and trackpad
across multiple soft and hard reboots.

Shih-Yuan Lee (1):
  Input: applespi - force PIO mode on MacBook8,1

 drivers/input/keyboard/applespi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.39.5

