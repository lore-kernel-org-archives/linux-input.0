Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDA323EABC
	for <linux-input@vger.kernel.org>; Sat, 11 Apr 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775888686; cv=none; b=gV8TEMJtf+VmAZpXGaXNf1P1eFzZ3byMTbkg1RApo4CS9hEAw+/IKTI6rov26qcLZEwXbriYKRPxCM0F0u6a3L5OrGzzRcy1l80qLtSxa9ZgGdjpvFyvyi8v7URs1DHC3VJ/ljuxGpJ49WRYcSjDaedURaRYXuLGf7z6punFMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775888686; c=relaxed/simple;
	bh=3snsAoIMBzCHRg/GUGzBNUgkch32WkivELDaPo93WgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyRZG67RyyTMQduC9uvYWiSPP6PRwOdhyB80jzh/oglJtiL/tGgssHygHwbNf/lwXKgUCeqva1+anFVzgvtcIb0s0slgzVUzS0k9UEGwxbfzZ7ykukgYAenWPBTnCpbuVfpxhtwkfRMNs0WcTI0Wj3mikfg5bq33mHFeR4D8xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czMMNgVW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czMMNgVW"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso32268395e9.2
        for <linux-input@vger.kernel.org>; Fri, 10 Apr 2026 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775888684; x=1776493484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfMaeNbFtgkbM0ewh/h9BevALASkRdIGD35O9poxD+w=;
        b=czMMNgVWLsw/fED9Yg3PRri9fig7TrxzTQE2Yw2cJ4AO4TXGnkWZXFwz+YwX6SQAtj
         5LhWYUqTIhYYkVSzZzhS5jyNrBDIjw0otNMeCHvTv054knSAXPSDjcvk7ni3Jy73ZZ8F
         r0mwooxbuj6roQmsgsLkHaJjtSswLmNMxpZRLj4nxa341unwlzTZG3pnzoAAmMkABfX4
         k+eQrtOaCGnw2y8c/FTRTZX82g8D8B5+dCjmc8bg/zD7rNek/L3bPNJkwXzqjKIRdAnJ
         Ue4KrLBfsaWDV2pFpYWgyN2G2APes0u0aWPGsj8SXF1VbjkmwwZtg4MHMMwbckhO49Py
         mSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775888684; x=1776493484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bfMaeNbFtgkbM0ewh/h9BevALASkRdIGD35O9poxD+w=;
        b=efLvxiBOW4wvhcrH9FeIYlZwV2QSxdccdVgQExPCmkohfjpXqYdMbWy/KGGZ5JjgZd
         THVQPYWMhlmxjqCVSeJKfLiLmv/QBxwmuZCXSEeBRsb2lqciFpVfxIaYD1rh/kEu+boI
         vxH3I4KdAzT+Jv0O/IjSnJrWZl30ufV3+eu9xQ+NkkbHDNoPCi2Qt19zQ7AYF8OGqIrS
         3LRYOG1mUjzqZe1tnk6p+t3FVR2O1HHM+n9vrcYfZ3xoMNG/PyD3CeEnz9lnTCBVlGZB
         SZfxvFJrSsJGnUp1adojMacqjtCZBYsT3LO8cWEt3xjNHxqPyXuPFTanoY5MA4oZ+QE3
         bNIA==
X-Gm-Message-State: AOJu0Yx0Q+mgZrV/eweSGqvmIp1kofv+UZw1QlNPr05qUy0S20Cqd52B
	U2YOBM2uYLilzihSSvNAIYpvc9VJHeD1jNRBtO1v5UFMN2XCQsfoCQWD
X-Gm-Gg: AeBDieuRx5IznX7r7aZgEPRfQc6bdfzM4HoiPkg8VreI6wTjvkvJyD7fPBvWaHt1Nqs
	IRRkGCD+j+i53UvxBZDKzthZL0T5ajqNTMhv9HZix5UdqLDK4eToBAc9bH9jJjLimNatu6I1hvA
	E9JSYR/3N1KqQ/0TufnQ5vvJBxLFn/roBwsoFcsBC5ZK7iBa0fSRCJIyvTnEqlfhjZxpROqNhui
	aCUIIociXxoBAN7PlsHal2NUCei3rgxE/cLnbg4xr2x22vl+gnHVJpno0Ev3+9WizHNSfZSBB+O
	YXMAnPYNzViT4yU1110arh8TrMejAw7XWP+kmPub0THnEWidA0VWWoEiGY2MCUU0oe0Lt7wVOy+
	UV6eOmmr5zq+3OxTEissoHbu5vtzIMedLcoRQZl0vtecqbony4orkwUWi2ExkTeYLZabpExcwVl
	yeHS1Ct4SJtPY/n5q1rTsCWdITI0BFn3Wm9h2RE3gT04lE82NVB92mHKOgChiGBeZgx1st
X-Received: by 2002:a05:600c:a415:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-488d67bf7abmr58956365e9.1.1775888683705;
        Fri, 10 Apr 2026 23:24:43 -0700 (PDT)
Received: from x2-evb57.xsight.ent (genie03-172-158.inter.net.il. [213.8.172.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58bb830sm127720075e9.7.2026.04.10.23.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 23:24:43 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebasjosue84@gmail.com,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v2] HID: ft260: validate i2c input report length
Date: Sat, 11 Apr 2026 09:24:37 +0300
Message-Id: <20260411062437.279838-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
References: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add two checks to ft260_raw_event() to prevent out-of-bounds reads
from malicious or malfunctioning devices:

First, reject reports shorter than the 2-byte header (report ID +
length fields). Without this, even accessing xfer->length on a
1-byte report is an OOB read.

Second, validate xfer->length against the actual data capacity of
the received HID report. Each I2C data report ID (0xD0 through
0xDE) defines a different report size in the HID descriptor, so the
available payload varies per report. A corrupted length field could
cause memcpy to read beyond the report buffer.

Reported-by: Sebastián Josué Alba Vives <sebasjosue84@gmail.com>
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
Changes in v2:
- Add minimum report size check before accessing header fields to
  prevent OOB read on truncated reports (size < 2)

Tested on FT260 with I2C-attached EEPROM (24c02) behind PCA9548
mux switches. Verified reads of various sizes (1-4 bytes using
report ID 0xD0, and larger reads using higher report IDs) with
debug tracing enabled, confirming xfer->length is correctly
validated against the HID report size for each report ID.
---
 drivers/hid/hid-ft260.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80b0e..70e2eedb465a 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,10 +1068,22 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	if (size < offsetof(struct ft260_i2c_input_report, data)) {
+		hid_err(hdev, "short report %d\n", size);
+		return -1;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-			  xfer->length);
+		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
+			  xfer->report, xfer->length, size);
+
+		if (xfer->length > size -
+		    offsetof(struct ft260_i2c_input_report, data)) {
+			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
 
 		if ((dev->read_buf == NULL) ||
 		    (xfer->length > dev->read_len - dev->read_idx)) {
-- 
2.25.1

