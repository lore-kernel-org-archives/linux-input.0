Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0094CF49D;
	Sat, 17 Oct 2026 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792218260; cv=none; b=ovTlIw2BQNoFBEKF0GO+xUdfBoiqMQJUSAHc8sHtK0rpqK/iZkyF03mxHqYSCmwdzl9VvMPYc48vbkBVplzdf7zeZBXzYnoe0/w3yaVhlKFt9x6A7Ey2ywIKDfbSPMxJ134WfyQE7quC+UONEdSPkV+3a/qu6PavWDrCOly8wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792218260; c=relaxed/simple;
	bh=J6LFs4uT3lm2GEKyx2Z/JkFeejKhKTTKcijAOhYyrb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBJAZdyPK1KkFmWyr4Gj0nyjkh/vaqyV86hG7w8Hzo5PdFO5COR+lZVTo1EoBCEUyu6xXAV5dWTjWD5A1KDqHD6GOkT3OkydI0rEdOztGXPHiWFWYmp9OkhWi3VgiXKepWQGbm/iqLiW/1f+OxHFal8VNSCv81v4UsrXr/3HB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UZTTx4VB; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UZTTx4VB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dE
	Of4C7FgK4s5Gqak2ciVN/X4cpQysfzRBeGs/JWgrc=; b=UZTTx4VBlaW67OxCvU
	wxDxpmtGa8Nm9aTZVD3iBBuF2c5nQlRxCFs8siBOrIWbpI5ffglMyrOER+NzDy8Z
	HllAQ1BAXjBUA4a5t1AhflDJOMiHDJ2lvvx7Qxpcu+ZXSVJ6rPGaBeeApmcnUe/n
	E5/TMxz6xgqBUPznGlvh9lyKE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v6R2FNNqz8K5AQ--.4199S2;
	Sat, 17 Oct 2026 14:23:51 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] HID: oxp: reject short input reports
Date: Sat, 17 Oct 2026 14:23:47 +0800
Message-Id: <20261017062347.3787437-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v6R2FNNqz8K5AQ--.4199S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1rur1kGw1DAw4xKF48WFg_yoWftrgE9r
	4UZ39Fgr1qkFsayr1kJFy0vrykKa15uF4rZr40qF9xAryxA34rZrZYqrnxW3y5ur1DW3ZY
	9ryDJrWI9r1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtvtCUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRiy7GrTFHgo0gAA3k

oxp_hid_raw_event() logs a full OXP packet and then dispatches it to one
of two parsers. Both parsers access fixed offsets and cast the input to
fixed-size report structures without checking the received length. A short
report can therefore be read beyond its valid data.

Reject reports shorter than the fixed OXP packet size before logging or
dispatching them.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-oxp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 1e691ebc1199..e1e1b99e9878 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -435,6 +435,9 @@ static int oxp_hid_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	u16 up = get_usage_page(hdev);
 
+	if (size < OXP_PACKET_SIZE)
+		return 0;
+
 	dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", OXP_PACKET_SIZE, data);
 
 	switch (up) {
-- 
2.34.1

