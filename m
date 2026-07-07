Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E136DA0D
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467236; cv=none; b=Aec7sDemi6rxwXGFhrfDltT2oDi7qJ8xR/Yh0EkG1WL2ua/KWj1Vpkk0Zv0bw3m336C5uBZNEK4wqeFBG+ZPYCgt/tBDLelIpGttd3inTKTaQwEupURdVMtb/OHKCuoKCmHUJs6WefdDTAyCo8AfapOVKSBP2Dvr51UkuPEuQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467236; c=relaxed/simple;
	bh=0Ihd8G1LhGna94oilrP9oD4Tyy7EEl+WVsIX4JyAAz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+FdszQImA2Fd2/JFh7fQo9ijq0SZWAIWan8tgTaLrfcPmG5R9IodQWsNk3wiexpiKQra/9tygYplSI9d2WbfOFc5G2LFcFlqLOnzYmmqdNt53kL/VkH+YrJV70BT95Aqzv7l+6ybq2lI232fyjLS3WJPvv3jfODDxzZYJEzDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=0Ucsgrup; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="0Ucsgrup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783467234; bh=0Ihd8G1LhGna94oilrP9oD4Tyy7EEl+WVsIX4JyAAz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Ucsgrup3RhsDq2UKFOEu5h2mHib5kJqu+ypiVFVZWaTWKwglyODiHZpe7u6Qbdhd
	 NAU20lgDI8/BDbyr4niImPPxrYTRMQbbFpNsOdCdD5AF1MPJxw5I2bOhpgSc7Jq154
	 RdY+4hstJNPkMqSR5XoMyxxj4tglhtA5bSqHUlNszDgjT8Zaj/d5/4bDOmR0H1o8Tj
	 3JGVjKWmGDPZu+KRiprEcTkuq0IKP1+diNjeRPif19xoZG0xIlYeMkDKxWjsDeAeLy
	 WuDeF1K4ZFBQ4s2Nv2+cScwEyRNEbpNj16447A7f27Caz2WfIonTuqJRwiGzwXNeMv
	 GYxzKdvm/Hmpw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 084C3A0D2;
	Tue, 07 Jul 2026 16:33:53 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>,
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Subject: [PATCH v2 09/10] HID: steam: Reject short reads
Date: Tue,  7 Jul 2026 16:32:29 -0700
Message-ID: <20260707233241.2644971-10-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707233241.2644971-1-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Steam Controller FEATURE reports encode the size of the message in the
message itself. Previously we were trusting that the size reported matched
the size we actually read, leading to a potential issue with short reads.
Instead, we should actually verify the length of the read.

Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=75f3f9bff8c510602d36

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 1f2cf15d4083..49f6733d8935 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -357,6 +357,13 @@ static int steam_recv_report(struct steam_device *steam,
 	u8 *buf;
 	int ret;
 
+	/*
+	 * All reports start with a two byte header.
+	 * We must read at least two bytes to get a sensible output.
+	 */
+	if (size < 2)
+		return -EINVAL;
+
 	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
 	if (!r) {
 		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
@@ -380,8 +387,10 @@ static int steam_recv_report(struct steam_device *steam,
 			buf, hid_report_len(r) + 1,
 			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret > 0) {
-		ret = min(size, ret - 1);
-		memcpy(data, buf + 1, ret);
+		/* Remove the report ID from the return buffer */
+		ret--;
+		size = min(size, ret);
+		memcpy(data, buf + 1, size);
 	}
 	kfree(buf);
 
@@ -389,7 +398,15 @@ static int steam_recv_report(struct steam_device *steam,
 		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
 	else
 		hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	if (ret < 2 || ret < data[1] + 2) {
+		hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
+				__func__, data[1] + 2, ret);
+		return -EPROTO;
+	}
+	return size;
 }
 
 static int steam_send_report(struct steam_device *steam,
-- 
2.54.0

