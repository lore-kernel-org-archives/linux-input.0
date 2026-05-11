Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB73783BB;
	Mon, 11 May 2026 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506168; cv=none; b=A+YPAsPmyY8vk9Ml/U0M3bp1/Az43IvmusXlBMgm7w8SfHUJxwAkcKCCTojiAmaE0mAqni5lRmS2N+yGVPWSXh62vN1ZEzJ6z7YQPKVdas+uaQZW9F5kRTEIPiwPeVzEFuNDMUZ6R+cSVkw9ZtnUyGSIrDSY5dCMob1+U+wpovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506168; c=relaxed/simple;
	bh=PVgAEcZDJBK3KZ5mp3jDD0/RUd1WFdBdcg/eZrd98aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJNVFG9HtXeS7DWqkW8dtHqC5vAxYT+H2PXy8KDTVQJQvADYAduz8jpyU/SVJ8lFrwN/k8wpfLrk5jx8i7b/vOi/4GAdfV5JUR8YZFbfwM6uxaSIocBP/dADjBWlIag8y1oaMVY3yywq0q1t9LJ1cQxsvfftPg+pYdIksSZ/7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=msb942wC; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="msb942wC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wo
	oGZWfATJiycwnKIxnVXoXdypso1t8ZWNPjptXnQIk=; b=msb942wC6o4CURnIY9
	uKS++1IOWhLxNNEyvl0o5BpCwjRFtOmGhVaaBJFUgFZyEP0sm5imM6SjDdY0Qdkg
	WXea9aZtA1clH5rZoUZdC9LcMvN2UrHFcyd/7+FjDnul9AHHU7au9VqYa5nBgoDo
	5iz0w9ZiefX13tMSVVrBdqw6c=
Received: from debian (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHRfCc2QFqWVULAw--.31622S2;
	Mon, 11 May 2026 21:29:00 +0800 (CST)
From: Kean <rh_king@163.com>
To: derekjohn.clark@gmail.com,
	mpearson-lenovo@squebb.ca
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kean <rh_king@163.com>
Subject: [PATCH] HID: lenovo: Fix buffer over-read in X12 Tab raw_event  handler
Date: Mon, 11 May 2026 21:28:54 +0800
Message-ID: <20260511132854.1351379-1-rh_king@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHRfCc2QFqWVULAw--.31622S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF48tF18Aw4fuFy8Zr4xWFg_yoWDWFg_Cr
	1j9wn7uw18JFn7XrnxJa1FvrW2yw4UuF4xZF18trW3Za9rJ34UXFZ0yrn8Jr98u3y7GF9r
	Gr4DtF93CrsIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRE-eO3UUUUU==
X-CM-SenderInfo: 5ukbyxlqj6il2tof0z/xtbC-Bx4J2oB2ZxAvAAA3t

In lenovo_raw_event(), the X12 Tab keyboard handler reads a 4-byte
little-endian value via *(__le32 *)data but only guards the access
with a size >= 3 check.  If a 3-byte report with ID 0x03 is received,
the code reads one byte beyond the end of the buffer.

Change the size check to >= 4 to match the actual access width.

Signed-off-by: Kean <rh_king@163.com>
---
 drivers/hid/hid-lenovo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index a6b73e03c16b..4686ecb6cfa8 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -793,7 +793,7 @@ static int lenovo_raw_event(struct hid_device *hdev,
 	 */
 	if (unlikely((hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB
 			|| hdev->product == USB_DEVICE_ID_LENOVO_X12_TAB2)
-			&& size >= 3 && report->id == 0x03))
+			&& size >= 4 && report->id == 0x03))
 		return lenovo_raw_event_TP_X12_tab(hdev, le32_to_cpu(*(__le32 *)data));
 
 	return 0;
-- 
2.53.0

