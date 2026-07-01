Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032D38E5ED;
	Wed,  1 Jul 2026 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884437; cv=none; b=jwXiAxWtDz0rVKdlONs64vGo+swY76mvDASI63Z4E1yHQlng4aFFVn715okjMhPC1uzsvecihAq462sN6byhOHu/3DjEkZVC+XPP9gf7g+gd30+q8IfvIjZvVW1RyU5I5ycieakokUtPFpq2PegWwYpBIkoNms4tUeofUloVYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884437; c=relaxed/simple;
	bh=3xhVolVBFJA926BVhMkOKQWNOkGRPtucBgpijFwmt9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssnt0DgfAzO6lIdjosyNhgYiN5ie/5UXcAkHg5HKNvPHSErgGVECbzDKCLy0BB3hZvqjDnp1k7/cc4ZmeZuTBy1hwrhl6808+FdDAcVrPH1tiUwj9JGSqzxw76FUR8jxQkVhcX32/8Pi3G6nN2AIpmooj3Ph/N6KzZOJFM8qBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAnKL9IqERqJeSHFg--.50699S2;
	Wed, 01 Jul 2026 13:40:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: cp2112: validate raw report lengths before parsing
Date: Wed,  1 Jul 2026 13:40:23 +0800
Message-ID: <20260701054023.59015-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnKL9IqERqJeSHFg--.50699S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5KF47trW3tF4ftw48tFb_yoW8Kry5pa
	95tFs8Kr4Dtw1Ivrs3Jw4kJa45XF1fKFWUuFyxG3Wj9w1Fkry5GFy0gFyIqrZ8XFWxX34q
	gr4jqrW5WF1q9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeKsjUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

cp2112_raw_event() receives raw HID reports and switches on data[0],
then parses transfer-status and data-read response fields at fixed
offsets. Malformed short reports can therefore be dereferenced before
the handler verifies that the fixed fields are present.

Check the report length before parsing each response type. Short
transfer-status reports complete the pending transfer with -EINVAL,
while short or truncated read responses complete as a zero-length read
so the existing short-read handling can reject them.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/hid/hid-cp2112.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 803b883a..7527bb08 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1387,8 +1387,17 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct cp2112_device *dev = hid_get_drvdata(hdev);
 	struct cp2112_xfer_status_report *xfer = (void *)data;
 
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
+		if (size < sizeof(*xfer)) {
+			dev->xfer_status = -EINVAL;
+			atomic_set(&dev->xfer_avail, 1);
+			break;
+		}
+
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
 			xfer->status0, xfer->status1,
 			be16_to_cpu(xfer->retries), be16_to_cpu(xfer->length));
@@ -1422,11 +1431,19 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 		atomic_set(&dev->xfer_avail, 1);
 		break;
 	case CP2112_DATA_READ_RESPONSE:
+		if (size < 3) {
+			dev->read_length = 0;
+			atomic_set(&dev->read_avail, 1);
+			break;
+		}
+
 		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
 
 		dev->read_length = data[2];
 		if (dev->read_length > sizeof(dev->read_data))
 			dev->read_length = sizeof(dev->read_data);
+		if (dev->read_length > size - 3)
+			dev->read_length = 0;
 
 		memcpy(dev->read_data, &data[3], dev->read_length);
 		atomic_set(&dev->read_avail, 1);
@@ -1453,4 +1470,3 @@ module_hid_driver(cp2112_driver);
 MODULE_DESCRIPTION("Silicon Labs HID USB to SMBus master bridge");
 MODULE_AUTHOR("David Barksdale <dbarksdale@uplogix.com>");
 MODULE_LICENSE("GPL");
-

