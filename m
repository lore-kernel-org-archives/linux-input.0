Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEA34EEEA
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497342; cv=none; b=OLawKXBbWk4aWD+W42xdQrt9oi5GnQNPWOOXB3ICW4ead2VYd3t0UWm+WfMFE6YWIodpOWddQ4EyXo0V4Vh0NSlkHr6BjYKR+UzE8kKCMrKbDnLjqdxr/9m95Wl5MsZoox6LPnrZ2URoqAC2tha7EmaKOkKLmOaY7OIEoXqrhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497342; c=relaxed/simple;
	bh=A5xHFAN8WfU1xij6lNwb/2hSRtdA5WHHNnuJT3pwhOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jvh2gRTye+DxxQ5+Re3WTfLAzVr4xue2ls0dYfQq10WES6Q/AVP3+7ErWVpZ5JCsgNrsDznr/9dvtgGaIcRNjT9CHYxwwfBQCSbRkBJRfEReC3WAFXP7qOXLrG9Da7Umc8YK8cbWjjGnKzox0E6Mnd3DNb1xO6LHtT3rijdmHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=NYGg7409; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="NYGg7409"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1786497334; bh=A5xHFAN8WfU1xij6lNwb/2hSRtdA5WHHNnuJT3pwhOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYGg7409pzn7xgAHge0FOZA8eNQ9ntO6XBVJwqEj+RypgZggEfIjDF8Tivu1/qyLv
	 PI0f0f/5B/SCpHsaA7wQpXLcp2yinSsViu1np4CQLYY5PP5wm3049cZOUEzTjFw/N6
	 HMhXrQ3qn5jwAKVquxNkldy12oHTSqRvEcr2/EPlqxdsAihzpdD5HTayqffRYyvfAm
	 B2IFP6de/GiTuqJ1sxwxmiMl7M34EwanxTns3ThLvKhPCIT1MPByxt94wBwVBKDcDT
	 ENMwKGUxw3upglLQQE2alH9J6t4Dj4RuYdETyjeErk9vyNPiHWni8vor8Y/wScraT4
	 +IlojAsA09nNA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id C2B3BA0A9;
	Tue, 11 Aug 2026 18:15:33 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH v5 4/6] HID: steam: Don't set feature reports when disconnecting
Date: Tue, 11 Aug 2026 18:13:55 -0700
Message-ID: <20260812011401.3250968-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812011401.3250968-1-vi@endrift.com>
References: <20260812011401.3250968-1-vi@endrift.com>
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
index 461ebf37171b..7226c0681ed1 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -490,9 +490,13 @@ static int steam_recv_report_id(struct steam_device *steam,
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
@@ -557,7 +561,11 @@ static int steam_send_report_id(struct steam_device *steam,
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

