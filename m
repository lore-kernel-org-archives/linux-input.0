Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0388225403;
	Tue, 14 Jul 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034996; cv=none; b=NxwNVxxuNLJO/vBCzh4ZdMAAQOmpFzovIIvtfIqKUTKqxud8+WvGoF2kBGXWpnca234HgDzra7EhWKtp920uiKHZ1CHeMtD2m1vCG4t2wZOKfLy6Dq5Xl+L9VW98EltlnoCK0aA9l52fTdF8N/2iTfemvCMIL8EXROmjTXAfIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034996; c=relaxed/simple;
	bh=ObfqSUBbAaL26yL/BfoSKv+gieDDIinenIMk7EN146Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUU6jIRm78ySRwx+S8Kp1Z/Qr7lOfj5i8wPLAivEyIawOwcHLgXfmtIryh7ocAwsqWlU2uVL5Z+Zp8zMVep6Kjq6k/7W+vbwcGZZWFK1GDmjpY9Dy54jQCcRZgO5oFdIodIQygBksQYzNqhoVsCN6yB7s9YNQrKH1wVvNvV1ovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JZuqluXL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JZuqluXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=i0
	ifEE4lOlAq1Yz2w2x6ySuALZI5cg7phVGwgSM8Htk=; b=JZuqluXLObJdv5e+rQ
	JzP6AvC1I38zmrtwqzbHnXfJOt0CnYPTCZXdyai2octSeeA1euIQ5n8YYhbzgKif
	soC1LO6MXcQ9ZpDJvqGIAh1ehzkTeuMo9uXvj8DAKYXHIKkNQ+ANL/7gr/ztj8Da
	ViTjEcITWlQPS2gYlLDpYhNM4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHhdSdNlZqMIoQJg--.20750S5;
	Tue, 14 Jul 2026 21:16:18 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 4/4] HID: cp2112: fix out-of-bounds read in cp2112_raw_event
Date: Tue, 14 Jul 2026 21:16:11 +0800
Message-Id: <20260714131611.269929-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDHhdSdNlZqMIoQJg--.20750S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww47Zw1kWrWxJr1fXr43ZFb_yoW8AFW7pa
	98tFsxGrs8tr1Ikr1fXF98Aw15JF1fJFyUury0k3WUWw1Fk345uFyagFyIq398WFWIgr9F
	krWjqrs8CF1qgaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRuVb9UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wPlIGpWNqP-igAA31

The TRANSFER_STATUS_RESPONSE path dereferences xfer->length at
offset 6, requiring sizeof(*xfer) bytes.  The DATA_READ_RESPONSE
path uses the device-supplied read_length to drive memcpy()
without clamping it to the remaining report size.  Add both
checks, and clamp read_length to size - 3.

Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-cp2112.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571..99e31724a421 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1430,6 +1430,11 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
+		if (size < sizeof(*xfer)) {
+			hid_err(hdev, "short transfer status report(%d < %zu)\n", size,
+				sizeof(*xfer));
+			return 0;
+		}
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
 			xfer->status0, xfer->status1,
 			be16_to_cpu(xfer->retries), be16_to_cpu(xfer->length));
@@ -1463,12 +1468,18 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 		atomic_set(&dev->xfer_avail, 1);
 		break;
 	case CP2112_DATA_READ_RESPONSE:
+		if (size < 4) {
+			hid_err(hdev, "short data read response(%d < 4)\n", size);
+			return 0;
+		}
 		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
 
 		dev->read_length = data[2];
 		if (dev->read_length > sizeof(dev->read_data))
 			dev->read_length = sizeof(dev->read_data);
 
+		if (dev->read_length > size - 3)
+			dev->read_length = size - 3;
 		memcpy(dev->read_data, &data[3], dev->read_length);
 		atomic_set(&dev->read_avail, 1);
 		break;
-- 
2.34.1

