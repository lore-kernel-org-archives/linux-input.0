Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888813;
	b=5WpARQF3CVIn7ZFJGcJLPF7UOYJpz4ueZCcuuCzcVGTbeUi9sKktg8Eig34fDnCiU0EK
	 /SuZ+GOmIWgNegxsbNIU+ndm17mqVwLI4X6Pdmt5VK+rH0DW9B3UEEQBUrQ4XJSiyKjrh
	 GBszY+++ISWucKKe8XvquqQCmVtUdfzhK1R+iegs7uL6N1EHJXE9oSJNvUIa8En5j5w4i
	 1LewTMU8kv/dwG03GIwKiSvGFR+8yD/Z2FJjBoU3R+WuOkir/nXGW4S3FBUxhJc/O55BE
	 aofwOKFVF11CaC6dQr/l9RYvbHYnrSaFXsJZ0B+IcBMoyGvKswrhQe4vLUiMhkwR56A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888813;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=qwTaxhhy8rcwybJtjSGgH9NPf1UmCFM/LYMRCH45yBM=;
	b=i3Aeb7oSOcmbDSY6sz9vl752K6akUxQA8mkWD/s6NdcNVfpx5psIMycUARrIIwaKZ4fe
	 uN88qo0pHKNFK2SK3WcK6F4FibcBsOQMQmnp08BnJF9Opc4mCB8aHR95Dx516yo7HC76M
	 I6SMR//3cU3tsWpoPM2qRUqg1r4TG28osqz6YCdpO7Kl8HhuqTyDAll9L2X0ljQg99TRE
	 e77ueCbcb0AC6gQEUSRmvkst1G7ave1JQnqLYJGZxNUbKKnn78uBgJRjk7yuFgPzYQaW1
	 u7FuZSJ1XKfKhiAMTUblX8Imo5HvgVKDyiRcl9Kse2mRdlH2kw/JbqQjsRAMRQ31nPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DONOgjAt;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CA606A323;
	Tue, 17 Nov 2026 04:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 497CA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DONOgjAt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=qwTaxhhy8rcwybJtjSGgH9NPf1UmCFM/LYMRCH45yBM=;
	b=DONOgjAtiUQELL42UXvBE3URTJyYGPyJ2QvJYtwvfXtm51/vbBRDlRInxyemeM
	8kGf8SAkoCGOPkOVTOz5UWmVcNnEx7PQkxcMJtOBX9vTn262MHXH8HOVj86D/fyy
	jMe1x9FH42/ETyZUG3NAEagi0rkSHqr65paVAfkCUfj0I=
Received: from WIN-TOG0NDEIICD.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3HxVZ1PtqHveJIA--.26682S3;
	Tue, 17 Nov 2026 12:13:16 +0800 (CST)
From: Shirong Zhao <shxzhaosr@163.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] HID: gembird: bound the report descriptor check by the
 pattern size
Date: Tue, 17 Nov 2026 12:13:15 +0800
Message-ID: <20261117121315.827019-1-shxzhaosr@163.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.53.0
X-CM-TRANSID:_____wD3HxVZ1PtqHveJIA--.26682S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1fCw1kJF15Gw1fAF1xuFg_yoW8AFW5pa
	n5ta1UKrsrtrn2qF1jkw4kGayFva97Xa4DurWUC3429a1Yyr95Ja1Ut3yUWFZYgrWkCrsx
	Gr1kta17uas8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcsqJUUUUU=
X-CM-SenderInfo: hvk06xhdrv2qqrwthudrp/xtbC7hzlJGr71FxgbQAA3n

gembird_report_fixup() compares the report descriptor against the
26-byte faulty pattern starting at offset GEMBIRD_START_FAULTY_RDESC
(8), so memcmp() reads rdesc[8,34).  The guard only requires
*rsize >= 31, so a device reporting a 31-33 byte descriptor triggers a
1-3 byte heap out-of-bounds read.

If the adjacent heap bytes happen to match the tail of the pattern,
the fixup body then runs and memcpy()s the fixed pattern at offset 8
into a buffer sized *rsize + delta_size, overflowing it as well.

Any descriptor that really contains the faulty pattern is at least 34
bytes long, so requiring GEMBIRD_START_FAULTY_RDESC +
sizeof(faulty pattern) does not change behaviour for real hardware.

Fixes: 931830aa5c25 ("HID: gembird: add new driver to fix Gembird JPD-DualForce 2")
Signed-off-by: Shirong Zhao <shxzhaosr@163.com>
---
 drivers/hid/hid-gembird.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-gembird.c b/drivers/hid/hid-gembird.c
index 20a8de7..ae56ba9 100644
--- a/drivers/hid/hid-gembird.c
+++ b/drivers/hid/hid-gembird.c
@@ -66,9 +66,11 @@ static const __u8 *gembird_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			    sizeof(gembird_jpd_faulty_rdesc);
 	size_t new_size = *rsize + delta_size;
 
-	if (*rsize >= 31 && !memcmp(&rdesc[GEMBIRD_START_FAULTY_RDESC],
-				    gembird_jpd_faulty_rdesc,
-				    sizeof(gembird_jpd_faulty_rdesc))) {
+	if (*rsize >= GEMBIRD_START_FAULTY_RDESC +
+		    sizeof(gembird_jpd_faulty_rdesc) &&
+	    !memcmp(&rdesc[GEMBIRD_START_FAULTY_RDESC],
+		    gembird_jpd_faulty_rdesc,
+		    sizeof(gembird_jpd_faulty_rdesc))) {
 		new_rdesc = devm_kzalloc(&hdev->dev, new_size, GFP_KERNEL);
 		if (new_rdesc == NULL)
 			return rdesc;

