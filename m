Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7BC3A5E8F
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500100; cv=none; b=QmVpa1cFqdkwjQLiXJtSY71AWQW4nPL0Qwwnl12/jxyK7E+vEw6qMCNFlBjO+lLbXxOYbjcd/C7FfYz+x1xHrhfbyrbTl65sTMprPfgHiSlInkqMx7tthfFzWmqb1xAgEhEcldm7vggq1sMvjizg2LHPG6xkKROOF46tez1NFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500100; c=relaxed/simple;
	bh=eyE5ONza2g00ngsOZ/vfxLhp26+pbBKnioZqVkrpRu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs+/DjnXhc7/lltra4dk41ocHYsE6fDu6ZNf5pBoi/i66LYypCT7lcBZYMmBG+p1CY/8700HSvEZDL1zQ8oA2LxsYbIOZOGXkeTUUAZriw/h4U0I1wK6ZHjuT23nINydo/EwYgOlT3UAsgndqIPRJRWKezYKu6S8auJ0UXsJaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRo7bBu9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRo7bBu9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4315289f8f.0
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780500098; x=1781104898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fG18Jon/R/ZMIqezQkAZKEkqFZGqMRhHhJYKl2YUd3A=;
        b=CRo7bBu9y7/2qZv8Ut5L5GaQy8U1J0+JHACzbdYmDntQ2sKfUcFrXO5rbYXwFwrXlF
         8Vd/9Lsf7Bgyu5XvhyUtrc3XyFTM47nUTJ8bw+rP3qkFLZhAoMiBG8lbhT+sc6ojMyW0
         +fSSF/nG56Tlxu17R3RtykGCUgBF2cGUooxZLwacn8PGos+tsdSaYNgQeLLHyUkE3cKv
         1Qc/vyQXE47UEzgGBzFz1yZMp3p4ZLhO+SAa1slr3bR1PTJxPUXwZR5AWaqi90zgkmaO
         /uYrEubUmn/NCq1lR3XTxeg7j8SRudMS7ifzmUtYHMA5+n+K9W5MU0RSzidyQo5Wfl54
         WNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500098; x=1781104898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG18Jon/R/ZMIqezQkAZKEkqFZGqMRhHhJYKl2YUd3A=;
        b=gfdmRxak/CuWpkiWG6J+7hkKMUDq4QoFtjkcXr5Am8bA9Ns1vQAWNK/DTodi62QlfL
         1WOTMFQe61QjluD23haMSUUWyvLZq+A5TUTHkgW84PQ7OmD5tJ9n673+6lPXUfD5UIs7
         50nxk6Cly8LxLBqcRjJOj1q3ioqSTeglYr+5fcu/50KS1dbObZNbWE6a54G7+QAIEZip
         cs5UdhZCOctPA3nfdQByqybGloVxL0eRm8kaHKL7wS1GkSHMuAzSeuMUt3EMN3K9Kx/T
         faHHmu+DihrhlCFqP2ocQ9XQR/gXnehIa/k1Fhy+bCRBopsniGmjHQX1VexxjJ6Yy3iu
         t8uA==
X-Gm-Message-State: AOJu0YxZXA0PEe5Gok4TwCDEX1nECdQ7xsQTVpnuHutUCaqsIkPShvga
	VPiofFcCnGek1c9L3+jLqAJ/atDzXLLx/WTHTci5FWjV7PGtbXhVIBE61ZMTrm8Y
X-Gm-Gg: Acq92OEi1Et3AIsTNtVj8FPEIkEMGtGWSPQtsQfEy/44ZQweeq2WIujXvM+ZP8hN2Bf
	yiEMY3MaE/BgTSyVVdcZBlkBFbR5fVchBUWZ+FpzoieXE3d7ZGWFkHC9hEFzllME20qAPBVkS8D
	+MLFzQRfyX9iolK7QAJ6z7Fd4dnTZYbgwpbQAg99dLe8Q1OM7+d2ZpwfydAmbG0Vi5QXzFB6mzq
	ApRqx5U3ctKJzu1i/D5HhBD+7JQboV8Oio3Ek77qUw7WSgEhye58qSLTuop8ErPAFi2qiVi3HvX
	MKWjhzCB6NerAir6DFKsmDEWCSj36qnc6xRjhTvyxTWOuSFjdcrBIAVzIkLTgJ9yUsrZjQ1BBIQ
	FK76cmO7FiNFIt3kZpTMZShptHLZyIfAaGZeewHigESMU0oOvGdcEaw2LtpcVqwPv3yiYemGBOz
	9dXNjWR+/Mh8e8gqmuKzJzTLgv0f+f0wloXFXnYeZ4VsQ=
X-Received: by 2002:a05:600c:8b64:b0:490:b642:ce31 with SMTP id 5b1f17b1804b1-490b642ce7cmr65950675e9.2.1780500097530;
        Wed, 03 Jun 2026 08:21:37 -0700 (PDT)
Received: from bazzite ([2a02:586:4c01:7800:f711:f6c7:6224:a5eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35ee64sm10493316f8f.30.2026.06.03.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:21:36 -0700 (PDT)
From: Christos Maragkos <whitetowersoftware@gmail.com>
To: linux-input@vger.kernel.org
Cc: djogorchock@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	Christos Maragkos <whitetowersoftware@gmail.com>
Subject: [PATCH] HID: nintendo: Fix imu_timestamp_us double increment per report
Date: Wed,  3 Jun 2026 18:21:34 +0300
Message-ID: <20260603152134.94439-1-whitetowersoftware@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the imu_timestamp_us variable was incremented twice per
report, causing it to advance by two times the desired amount.

This resulted in incorrect jumps in IMU timestamps reported using
MSC_TIMESTAMP, so userspace applications saw corrupted timing on
functions such as gyroscope-based aim and motion controls.

This is fixed by removing the redundant increment at the start of the
report handling so the remaining can account for the full report
interval.

Fixes: 4ff5b10840a88 ("HID: nintendo: add IMU support")
Signed-off-by: Christos Maragkos <whitetowersoftware@gmail.com>
---
 drivers/hid/hid-nintendo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 29008c2cc530..a701e396ee50 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -1453,7 +1453,6 @@ static void joycon_parse_imu_report(struct joycon_ctlr *ctlr,
 		dropped_threshold = ctlr->imu_avg_delta_ms * 3 / 2;
 		dropped_pkts = (delta - min(delta, dropped_threshold)) /
 				ctlr->imu_avg_delta_ms;
-		ctlr->imu_timestamp_us += 1000 * ctlr->imu_avg_delta_ms;
 		if (dropped_pkts > JC_IMU_DROPPED_PKT_WARNING) {
 			hid_warn_ratelimited(ctlr->hdev,
 				 "compensating for %u dropped IMU reports\n",
-- 
2.54.0

