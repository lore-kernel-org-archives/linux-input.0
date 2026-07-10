Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747229D260
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648931; cv=none; b=WsiZJmrobXEh2xBP2X8wIw7wohTrzRAO8v1wIQ7XTE4kIdcptyKqpBBLG+QfkpJWBZ+sp2Ah2bgcpK9gS90ZmDvFc0JUKdbodDQ3+Szj5X0GMRvE8oj/gpdLA4lIcvlkN+JP568iwrflRJcvCsqmgJBzQy1mkckYVsX8H3Gcdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648931; c=relaxed/simple;
	bh=NFp1h5EoZrdmIYm6PcdXVoGNPGA8vk+PD9BN4qzM1kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJMeJexElhqfVBBDan7nUxXU3QgrswatwQ1gxlvEh/uuz6QEB7eHyHjNztoQi4SH9NONBt038wzrHkD1rZ+x/RIsgb2kLs9uvT/MvVr7Vsz0gGRusy2OeabmVVnGVU/rgtzDN3/+TAF2LL9oiD1TL0W99z3Vxg1hinBtsXPghsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=mmIAMZVL; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="mmIAMZVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783648919; bh=NFp1h5EoZrdmIYm6PcdXVoGNPGA8vk+PD9BN4qzM1kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmIAMZVLDVEa2yjVAAYd6H0ya6SNe7VrSAon1b3Q9pbHZ/aClLZ5808ACkYXntNYV
	 +d7zbvGS4IF1mB8aVqWID1+59LGE0sevb8YRvM8Pv51DSydFe1kxqCThKDrkYx5ctm
	 3C/TaTlap8rWzzwBG00E+RaBLkSjj7b20ZG7IICiImvFICosQPYyE2qIhrGcIIgomL
	 5BQaVnhO6Y6HR3677ZK9Dlo793s4/F9CEPj4jgvCrFktEYUilWZgNoP7ORldN+R30+
	 Hr9X5qlOTMR41IyiGkTS84XIm5tHh0XcQnjbEu1Cgs8r0wFf+bd7SpjbqGXP8zkVIM
	 e2Rf5QDUkij4A==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 4257713208A;
	Thu, 09 Jul 2026 19:01:59 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>,
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Subject: [PATCH v3 09/10] HID: steam: Reject short reads
Date: Thu,  9 Jul 2026 19:00:44 -0700
Message-ID: <20260710020048.2337655-10-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710020048.2337655-1-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
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
 drivers/hid/hid-steam.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 298a2c17e112..a80d54ed9784 100644
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
@@ -380,16 +387,30 @@ static int steam_recv_report(struct steam_device *steam,
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
 
 	if (ret < 0)
 		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
 	else
-		hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
-	return ret;
+		hid_dbg(steam->hdev, "Received report %*ph\n", size, data);
+	if (ret < 0)
+		return ret;
+
+	if (ret < 2) {
+		hid_err(steam->hdev, "%s: reply too short\n", __func__);
+		return -EPROTO;
+	}
+	if (ret < data[1] + 2) {
+		hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
+				__func__, data[1] + 2, ret);
+		return -EPROTO;
+	}
+	return size;
 }
 
 static int steam_send_report(struct steam_device *steam,
-- 
2.54.0

