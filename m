Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90226368D40
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384877; cv=none; b=ojTnzIZGH0hmsR2KNe0U6lYRCn8ItxsGfSR0sbIhKGocTW/ufKPs8+DT1o5ncgL6iDCDWHJi4OwOPBpQCqd6QJ9jWEq5jfa6BgpfzphzPAdvNLCpSD0YXIOJnFARQDeEQaMPvR00AD6NWnY5673PNMezpxjOhS+aa60TEPQSiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384877; c=relaxed/simple;
	bh=MZxK2SAm3YPVZhJ1hT8gdBhRLlQmiXwtnn4QbM/CvEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB/ve9XaIKPVlJFqnpZJLnPyCLL1O9sA6CQK4UOm2R/yDbpxptmuX9VNOYAAVeiI9lDwtwUH3StBcZQAZyAqTm/haC5qmDZdGqxq+6g8wpnRonqnD8s49ICeYyfLSI93BQrI9Ymn8lUbmH29KwGd/12c/t6PqKyIavAavSIApTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Tn0N1ul1; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Tn0N1ul1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785384870; bh=MZxK2SAm3YPVZhJ1hT8gdBhRLlQmiXwtnn4QbM/CvEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tn0N1ul1TXjJ8Z6VbtKTukoxXjtHvusFzc9KMCB2/9lD4ZaxJ6P3AyqnaEy9tfMaD
	 7TE3ySFVUR4HoH+5SbkYpIm8b2N8ElI7Gda7OnUXhjYljStFjNnZhd5g4ABnzXPOqH
	 h1oCMWrIruzA9SX6syK3RwE/UaMkWMO7DlJnAYmCd9CISPS3Z7Wk+UE0ewdBEftgIF
	 t7r9VCFGqeBUOFjLnBtCuFtj6kPc5iznAa/0lcrrasn3ZaZ0B1jOi1afpKf0SzA/fA
	 Kpv7F1XAIcJEUnODxV0lTrc1/oGIPaWmEstih8bv1qilCrD6HubRrZfOD/gdAZqvob
	 PPpJwfKWqlsGg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 9C92613208B;
	Wed, 29 Jul 2026 21:14:29 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>,
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Subject: [PATCH v5 10/11] HID: steam: Reject short reads
Date: Wed, 29 Jul 2026 21:12:33 -0700
Message-ID: <20260730041251.1659029-11-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730041251.1659029-1-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
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
index ddd439dd069b..3b4a588c20ad 100644
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

