Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8E3B71AD
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983309; cv=none; b=aIJzMSONyvldKvThXy0uGarZm6fNuBIARC8B9lz97hDskrHxUZqND3T1+NSP6ZO8CEbHAliD8SQ25a0Ku068OOGCO69nkujhqST95I9I9yKAFV5j7RKU2hBPX+t/ksgaSHVeRWVc95FE9JOOnP6NLLfUNwh3RQ/fjyHJ+0gQK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983309; c=relaxed/simple;
	bh=t+kAOMWlq15zDw0HNijcbUi+bGrffM0C90fYncA1ukU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6zOYLc1W7ITxuIF49myll1z3i1IxjE2FEefUg/x3i0g52ZmegNwxN/bxmdL8JW0gKFugCHTgTmvS0aSkM4JblM9niLN+4FvRLF3kU1o66O5z0C9AI+BKTp283Q9m1B2Uds7OSSQ34F2RxJbVWW/yShJoKKLktX5BR5FjTFz58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=M+VzbNFm; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="M+VzbNFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785983301; bh=t+kAOMWlq15zDw0HNijcbUi+bGrffM0C90fYncA1ukU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+VzbNFm2NRvStavwpW/ZP2p1mx+llPSLCegak6pHgmuQAsyuKoWWeT2JXM55X38P
	 BOigGT8/5DAOsj/brjYuMuOqBluaPrwudPWRKiFmAzfzMIYrq1w5R9yUU0RHwESZe9
	 H5HrpbBLnotsNEDCWpKrgkEE3bYr6wkmZ/CBM59KLt8iitfUYv46wp/jTq93FByp3j
	 qiwMFKEyI7hWr64C3gjTVXiniAkVePyydR5Edfb4XSvM4dqNCBXZF+uibEHV7vYxdS
	 TqAn+WiUApUWp0wdaO2cJWVhgN4ehY09DXwgwNBc5TyCT0SBkmAbDsbJ5iEPT9Fph0
	 d02wX99poIqsA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id B1B60A239;
	Wed, 05 Aug 2026 19:28:21 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v2 4/6] HID: steam: Don't set feature reports when disconnecting
Date: Wed,  5 Aug 2026 19:26:43 -0700
Message-ID: <20260806022653.93939-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806022653.93939-1-vi@endrift.com>
References: <20260806022653.93939-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 38c00dab0b06..8c97302c35de 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -489,9 +489,13 @@ static int steam_recv_report_id(struct steam_device *steam,
 	}
 
 	kfree(buf);
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
@@ -569,7 +573,11 @@ static int steam_send_report_id(struct steam_device *steam,
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

