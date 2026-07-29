Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C02D7D47
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290054; cv=none; b=PeQ+l04kDs/ulqBI+IZtqTojYfxk6yGJbdP135EqfZCSSeuU9K6bKYs97AV+gkNWKk+UUz9umncS5rb/LIgVcIuCVFRHmSC80QDD0RwTgwzhnCGPZVRr2bdYZtnrbhhxYkzKKhLbecDOnm/RFRMfkDGPYeLQ6MVkruAJjpCuN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290054; c=relaxed/simple;
	bh=I2JT9xhT/cE57dwnOzocWl6Ps9LTegKZ7rWz5zV6Fpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li2fyYIGLpnMvG9fTbwYoB7QPGI8d8kr3XaKP2mmRqUMr8mwwYjsT12W6aqA1+kmvKBfKvIgpx1lkulCTPXn+0d/d2hSjx52qDoHF2LFWgnv+BTjxusvu6kMUW1D2w+W0/TGPzbSqNFz3er7M0barJ6kqCCHA6pOPaeDz7vn+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=ydCT1dga; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="ydCT1dga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290047; bh=I2JT9xhT/cE57dwnOzocWl6Ps9LTegKZ7rWz5zV6Fpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ydCT1dga8oDAz0sJ6mhIwy15EML1bfV+I/lziN7gfdNk/9CWWiOntJ3vwstHMHd02
	 w23J3s6uDcAx1ZGUc/uF+PfxJ72HRfQEuyjvhEoQDooVX+eKA+30RM+qDq3qH63jdh
	 iDcGqCQbywi2KBndDPiNddEIBYVbVAVcMh57CSJBDklJvPn7WIoTx7oOvlj6VKV3t7
	 huvc5nJC0zo9W/33qyjZ+a/6gZ0IkxDuHyFPNxxp1HPsX35Ehac28LNOjHrLpvW17w
	 Zy40acUA3sEP9Rs7c/j70EaZAw5X1BEL+1SSJr9vOvYJZKSkemO1Y6PETpwdmGR72u
	 dmZ9R964hwkjQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 9D64EA2A3;
	Tue, 28 Jul 2026 18:54:07 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>,
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Subject: [PATCH v4 10/11] HID: steam: Reject short reads
Date: Tue, 28 Jul 2026 18:52:32 -0700
Message-ID: <20260729015243.1170573-11-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
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
index 3738a4de3bff..7c100d61495a 100644
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

