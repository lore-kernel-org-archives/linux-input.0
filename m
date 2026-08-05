Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90A3A5445
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894787; cv=none; b=M876VvqBKCY9/8syLKjMTcxYGpOLsdQAtfOwq4S9xekHPWTGetr2bFxy5FIw0EAeDpGpltTx11GbJP/OyC1RPJ5zLkdgF2VxSs3gbLomPVsmS7DeMMjF4/T7+/TKn+svKMIEz242cphLBP1oWHvIS4GGesvoKYeGzYbL5n6kQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894787; c=relaxed/simple;
	bh=OP+y8yREgzg50rMJwyJaMHFHx1Grsb7iUi8n2D37r2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoJY9mhhKR9DHwOlCBo4NKHSCI8hcO+4Vz7ByAFOMY+pX5hDZnqUm7m13t1sOCvgT12GlmCCKFQ/WDqIN7yEg7TzH/b2RrZhHR9sqt5MW5ZkQKmqTk+/Q1R5/ZZCvYBXR6OV8rm8NHIljR/yyoSPzkXu0Yw18BvPUzR9bsyHLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=JPzmR47M; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="JPzmR47M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785894769; bh=OP+y8yREgzg50rMJwyJaMHFHx1Grsb7iUi8n2D37r2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JPzmR47MblGb7HdZj73PghkT8KDlkBDZgQ13UmCrja/jiUPvGnshnVJraszrwkPtN
	 ytPGvfoi/CtOpC5ZK3yi6o2iFWEX2g9D0eGqcl4I9/2h9t7rxiedxtNNlfHJThFK1A
	 2U+bKuiVVYlyBy+jtFxznY9QEuBBlLYQqnR6sYQvv7IuI9RyEI9FKXPGWv2xrlzOxp
	 0mE5xmkTV9R8i/s45goacY3363Mz564/rONkprM+vmykuBFeQFfrUAiLZ5FCbuQRQ2
	 IRN5YOpc07qlyiALFDqDskOVkwnQ/C3ATocW2XHGgczJw6EVC0e+w6t6VN0blO8hJd
	 bIuNW/xGt6KQw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 5F73BA239;
	Tue, 04 Aug 2026 18:52:49 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 3/5] HID: steam: Don't set feature reports when disconnecting
Date: Tue,  4 Aug 2026 18:51:04 -0700
Message-ID: <20260805015116.3884465-4-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805015116.3884465-1-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an input device is closed, we set a feature report to reset lizard
mode and IMU mode. However, if the input device is closed because it was
removed, then we will necessarily error out when sending this, resulting in
logged errors. Since an error here is expected, we should just fail
silently.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index fdf32722c8b3..2d60b79441b6 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -489,12 +489,13 @@ static int steam_recv_report_id(struct steam_device *steam,
 	}
 
 	kfree(buf);
-	if (ret < 0)
-		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
-
-	if (ret < 0)
+	/*
+	 * Don't log if the failure is -ENODEV, as this
+	 * can happen normally on disconnect.
+	 */
+	if (ret < 0 && ret != -ENODEV)
 		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
-	else
+	else if (ret > 0)
 		hid_dbg(steam->hdev, "Received report %*ph\n", size, data);
 	if (ret < 0)
 		return ret;
@@ -572,7 +573,11 @@ static int steam_send_report_id(struct steam_device *steam,
 	} while (--retries);
 
 	kfree(buf);
-	if (ret < 0)
+	/*
+	 * Don't log if the failure is -ENODEV, as this
+	 * can happen normally on disconnect.
+	 */
+	if (ret < 0 && ret != -ENODEV)
 		hid_err(steam->hdev, "%s: error %d (%*ph)\n", __func__,
 				ret, size, cmd);
 	return ret;
-- 
2.54.0

