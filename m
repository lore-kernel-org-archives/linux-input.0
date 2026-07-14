Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75020222590;
	Tue, 14 Jul 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034997; cv=none; b=eOtaL/KEFpAlqALhzxcMRAXk+o8sQGynLOuCW6l3joqVZOV89B0T2H8BHnH8Z3MNF0TovdK6PMziepETrvZRnbiauglQQ4UnGe286VvpdBHSgRQIw/5FWKk4bIN49YVmAqWkjlnDxyriiZxDEYU4sNlgGW3AIWNCqavhm/mR6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034997; c=relaxed/simple;
	bh=c3WwKUMHC9ycRPZJ0pmTTs1Bs0LRbgfAYBGiLAH7z0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nf7y9YPajTmyRykHlzvmx9zfOWWUcMTwsBW9tknDLICQAyER7L7eWhnDjczwAVmAo/PKrpEt+WFBt7a0/YucG7MkOonN2a6teai5NJX4wOFoCS1S4ACLjXiKdQ2Mf+A2U9YWu3TP2NaMJWL/aZM4IvfiAdKXQFi86raVCnO0EBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OwFo0qPi; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OwFo0qPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JA
	DpnXF70rh0Jigvj3HlU4HFNjBDDwY+BcJq/fY4IcA=; b=OwFo0qPivue/6Qq5SQ
	soVmgxAOmkfVvdHWS3/+fCeRuBSk+Z5i9zxIsNe4E4Z9WDXYpXl+lAtI3WEXbgZr
	+eYKSe10IBga6yblf7V58lyz+XHopiDzA1WZBdjqT19kO4KGJtXbs6AuBOqkp3yK
	8eYXYxfyL6TFxVe4UkUg8QGgw=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHhdSdNlZqMIoQJg--.20750S3;
	Tue, 14 Jul 2026 21:16:16 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 2/4] HID: corsair-void: fix out-of-bounds read in corsair_void_raw_event
Date: Tue, 14 Jul 2026 21:16:09 +0800
Message-Id: <20260714131611.269929-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714131611.269929-1-yaojiale02@163.com>
References: <20260714131611.269929-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHhdSdNlZqMIoQJg--.20750S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr17ZryfJw47KrWrGrWfKrg_yoWfuFgE9w
	18Ja1DJrsrJa4Svr1kJw45Zry5Aa18ZF1fXF13t3sIqrZrZ3W5XFWqqr43GFZxurn3Jas7
	Ar98XFn2v397KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR-YFwDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQDlIGpWNqDbuQAA3A

Both the STATUS_REPORT and FIRMWARE_REPORT paths access data[4].
Add a size < 5 guard before the report dispatch.

Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-corsair-void.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index 5e9a5b8f7f16..7c5435de6aae 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -740,6 +740,8 @@ static int corsair_void_raw_event(struct hid_device *hid_dev,
 	struct corsair_void_drvdata *drvdata = hid_get_drvdata(hid_dev);
 	bool was_connected = drvdata->connected;
 
+	if (size < 5)
+		return 0;
 	/* Description of packets are documented at the top of this file */
 	if (hid_report->id == CORSAIR_VOID_STATUS_REPORT_ID) {
 		drvdata->mic_up = FIELD_GET(CORSAIR_VOID_MIC_MASK, data[2]);
-- 
2.34.1

