Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C982EBDE9
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761702; cv=none; b=hl2Poa4W+U/4/EfhENTmOhYNanFym2crNvD1d4mLLps7eqGIzK/zldiDT3QlECFqRdROfpRJALspxCpmKgQsZnzK04/8yqoMAb8F0heZHhxLUZIq4s/TWFgDQ8syJJ4e12iGJhNEFTm3Pli4D3jZMzM/Y5ez2BmSCMa22YMPKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761702; c=relaxed/simple;
	bh=D3DyRDfYmIf0cQl/XuSThu6cyET5FQRA2JO6N/D7FYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/y4wj/bt6b69qF1th4X+sPXeMWzEEUi+QmmkK96ShtImuqWMfkwI9wyt/ljQ98pzZ6bijAwjgsuuCuM5HhySXRY9RvlNJsdTy1e2Y0cjTpbe5bpM/c4aDxiHO6mBaCshnko9BWrjM0jFrJQ4oXEzcSiHcQsbzxlBjNBYe+wIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1378717b3a.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 02:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761700; x=1784366500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AOzFhkvMsPSUSjbI9YVx5lNGMOZCWdcLEVik8BT/Ayc=;
        b=Z+AqG4PGDzzcygt5LFcu9SsR2NVhbZzddoIyKjPG5O2OX3g77R1WxpHNAGB4Au1KCh
         McsZ6c/58RwcPgoy/fKhXM/sx+q+Z2JFeJMjHK52o6RIb7FE1c934cFbUes8iqcpA7nM
         4x1mLiRLy+x8Z3kJoFHSjl0J/IL2Gtw44WEw9x3IU+QKyFOKFUfAq6bj2IrLgKSO9j+p
         ZfLjVWl8Xwf5860LkSwXkYRsYJYFNKKFDH2gpqD83Hz2krXv1VSV6SuzhycG1V9DK9wN
         KDUKamLZeD7+WK4HpuEMEH019KP1tqbXrSNGUdgPYKF/C9YqbSj2HuTmAUtWaoQrrFAx
         4yAQ==
X-Gm-Message-State: AOJu0YwwtwvDB/gdSzOrBggtFOsiAMHKUbPxLx4AR6MWLrydLN+CzcXO
	d7CEjDq/llIztyHL7+/x+aol88ot+Z5uSo1MGCW/K7AW+2LxN+cDBTo=
X-Gm-Gg: AfdE7ckVzD2ShATaV7Knrm3AsR3s7RUS3/6kYJapob2IoMXnnrpPX4xCfQ9FdNDdkGa
	D7L2Xj6I90uxQMWBkopgb+VRmCmWRGjdgE/COHhHfzEzX7tJnd2bu5lrCxXnjOrjBNb/J1t+3r6
	m83eAFLfAmTLKHWPMB+iSYMdgBUNKoajCwCI0VjqMC1SaH1vkvpfr2p3Ky3R8EENNRAg9Z9Uo5y
	T4tKs98GodMeCGxnyDgrB4q6bAaJiizUl/GAvimOea6ZUMrAlIN86wwdWJGinvfSsdHfTybLNEg
	5vwo+CNGIupLkATdF0vJMLCyWqCHB4W8HmOe8/q7Mv6yuMuBe0U2LAr08+GBGe0KiF4YGlC/hx5
	/RDvFxyxtd3U3MvUFRy6pdHojgT+HOi9EBndJS4kC9eKUgjg8mYj/IjMCt8Vs8174bjj+ZtAF6/
	D70fOgJ6/FX3p4UkiPgCHx0XsRwZQZWTKsW3TXMdRnuCI4SnuxuNpbrjoyuyFzsiHzqO67h6n2l
	hixtY0kJB6IW7w1tITYi/A9gw==
X-Received: by 2002:a05:6a00:2303:b0:848:2f74:1d68 with SMTP id d2e1a72fcca58-84889750a60mr2313588b3a.78.1783761700389;
        Sat, 11 Jul 2026 02:21:40 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm11468726b3a.57.2026.07.11.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:21:39 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 2/3] Input: applespi - cancel pending work on driver remove
Date: Sat, 11 Jul 2026 17:20:53 +0800
Message-Id: <20260711092054.13818-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711092054.13818-1-fourdollars@debian.org>
References: <20260711092054.13818-1-fourdollars@debian.org>
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
index 79e5cb5001c7..fd785dba1174 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1861,6 +1861,8 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	cancel_work_sync(&applespi->work);
+
 	if (override_dma)
 		spi->controller->can_dma = applespi->original_can_dma;
 
-- 
2.39.5

