Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310412E1DC;
	Tue, 14 Jul 2026 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034992; cv=none; b=AKeZ8FBpGonNVhAxIN5CeK6l2PteelvZYEFm4L9WP1HUg9bH5WtvNSkJkIqlk1Wk4ttAUVLq88Th6D0fx0GTMOodI7o7xtQ8hVmEfMHC5rQ8+hg9p5edj0LoMYyf1kLZnqb3ga2Qp243ZVXGUB1PhkurRylrN7ZpXQ/1uRJRf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034992; c=relaxed/simple;
	bh=d4aOIzEH7auRhyl/2bO2W1PJ3n2MjA/cha+EVnZ2Z8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=njXE3emtYss0W+Y5yMeW5G1xzQ4E6pnmQsm9Uk+kyigMxnf2+thDPPGCDmEtNEI3VQxNbMlAkTbUSUKifTZnFNSHHF+ETfX3Zj9XR2EMhncr2a8Og8OAfODD1wZCDnz3NFlSVIdz35kg9Y8ZstJBw5DBxnOuKqGa7UDHt+nXljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZgsAiryj; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZgsAiryj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wl
	B3OaDa8iVP+XyzsUo4CvwcKQBf92lyOYN5UjIbcSI=; b=ZgsAiryj+owW9bw/cq
	59TQHOI3UFanKlMP71NfU6RFMAE6X7pdTAbBRGQ0So2JInakskWclgfI6IeMp20J
	uvlRDgd7OwZpQ4sTr97Ax/v/IKdxpZZfGToAYbW5Yp4JeKiiiwuBkBECuvQ18yna
	AmUNH7Rc48K4cd9PMfZ48aflU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHhdSdNlZqMIoQJg--.20750S2;
	Tue, 14 Jul 2026 21:16:14 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 1/4] HID: cougar: fix out-of-bounds read in cougar_raw_event
Date: Tue, 14 Jul 2026 21:16:08 +0800
Message-Id: <20260714131611.269929-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHhdSdNlZqMIoQJg--.20750S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1kZFy8Zw1rZFWDuw17Jrb_yoWDCrb_Cw
	48X3ZrWF1qgFZ2yr98tw1xZryFq3yUXFs3Zr1vqry3C392y3WrGr45X3ZxW345KrnxJ3Wx
	t3ZrW34fZwnaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtJPE7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x-kH2pWNp--EgAA3z

cougar_raw_event() accesses data[COUGAR_FIELD_CODE] and
data[COUGAR_FIELD_ACTION] (offsets 1 and 2) before validating
the report size.  A malformed HID report shorter than 3 bytes
would read past the allocated buffer.

Add a size < 3 check before accessing those fields.

Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-cougar.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f162..9927f45a795b 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -270,6 +270,12 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
+	if (size < 3) {
+		hid_err(hdev, "Received HID report of bad size (%d)",
+			size);
+		return -EPERM;
+	}
+
 	code = data[COUGAR_FIELD_CODE];
 	action = data[COUGAR_FIELD_ACTION];
 	for (i = 0; cougar_mapping[i][0]; i++) {
-- 
2.34.1

