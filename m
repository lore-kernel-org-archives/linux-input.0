Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20BD1A6820;
	Sat, 17 Oct 2026 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217986; cv=none; b=IuheOw827XwQXlnqkQ4R1vlGaYxPspYDKMKzbee8ZUBqLDuWtcZTxTQPIPr6W6fdxB+jDrHxnqPEK7baNSG71yfmOe1Qm18QNUV7Hph2PUxTRXcN51Q4raMsAzLP92YszrapdGqu+GIH2i18fj3NUSFG7iM6tpNRPOPePdypjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217986; c=relaxed/simple;
	bh=1eO4q/o/wsoIWoBvY89BkJES9RF8qD6tLLdU8h2sLSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DvJHkDXrMWAXnChfmxPHCtXLNnsm0CGB6Q5/q+s56azgX1+es0xm+rfopuYRGX/DngQ8rcHldwvgCZ2uPtRbcxMluQN780KQnmYrGfDCEdLTHcjUxCDOEbuOAoydmgNrxhw7Eop5/6hBWapoxtxkZPpKa6sOCJnap8Ivv7JtUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FIo5/v74; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FIo5/v74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xu
	MBQ28bm3FO0/CpfyclRDufAhjncezY/NZQmfK3LDQ=; b=FIo5/v74joY4y1pkf1
	cGcq3sKuXWKMf71htr7s7c/VyeLMlx08QCLQRdN1uDM4bFX0Dl/NTfVOmkK5vwlX
	iFkFmLJsJr4jhwG607yVhe5LO+Wj+tQw29Ral5vIZzYXEo5lp3x1+zNbvJrbwtrt
	5XjoYvaOe9O+l4LGDzheuCQ0Q=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDH77xpE9NqnFWgAQ--.8282S2;
	Sat, 17 Oct 2026 14:19:23 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] HID: wacom: reject short input reports
Date: Sat, 17 Oct 2026 14:19:19 +0800
Message-Id: <20261017061920.3781644-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH77xpE9NqnFWgAQ--.8282S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfGw15tF4DuF1kAFWUurg_yoWDJFb_ua
	48ZwsrX34kWFnFyr1xKr15Zryq9ws5WFnxXr4Yyr93Jry8XF15AFs3Zws8WrW5ur4kX3Z7
	KrWDJ34kZrnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXBMtUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQtuqGrTE2saFQAA3O

wacom_raw_event() passes incoming reports to the pen serial extractor and
the device-specific IRQ parsers before the HID core validates the declared
report length. A short report can therefore make either consumer read past
the valid input data.

Require the complete report described by the HID report descriptor before
invoking either parser.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/wacom_sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 40770affdbde..85e966e80012 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -175,6 +175,9 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (wacom->wacom_wac.features.type == BOOTLOADER)
 		return 0;
 
+	if (size < hid_report_len(report))
+		return 0;
+
 	if (wacom_wac_pen_serial_enforce(hdev, report, raw_data, size))
 		return -1;
 
-- 
2.34.1

