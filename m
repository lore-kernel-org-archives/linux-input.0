Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE238E5DA
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782653850; cv=none; b=F3uH8prbzJyYcUTbwSIqKkK0HbVtwK+iUDBmCmPwlyCAw2sMOldaY1bf1DGLSI6U9r//iCjTK43ZA2rD8c7GAqpejAUX7GDSFo/Y/eJcNr+i9+q4caMN/ZHapQ79zVCyolyw8TgAWYakHVyQPD6XJOIHg/x7OJ1ETQ85TZy56/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782653850; c=relaxed/simple;
	bh=APeQAyYxz2gOaufxE9Y/rggiGKFvWex60lbtGRy4358=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmWIz/xoPdygy5a0f/c07rEe/k7juAGNGjWpFGtYc1If12IfpVAkH7RUrOGRhn2AqAlPtkkpHGU2ra7HP/WY7bim0ctcOP7pv2F2lZvCp5tZpCikXGqSyGRADf+vWBG+twSmXswKLtpnSNRxajCxPV3+e30z15QpZgJsroA/LEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0dB8ZEO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0dB8ZEO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c82538b6c0so11929935ad.2
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782653846; x=1783258646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/ERgMpgZ/aBHq6dAj6hhrHv3kdwwLXAdxeqFG4lEq0=;
        b=Y0dB8ZEOidzMJfdk1+U47Q+7NOTG6Qkf6vAYdnCSMATZ7MHyzBjRSCOuzE93vSweQS
         G9uN9V1PyJqpjjj073XZnZE7y3T2fjYz9PAk17lKc3XXsn/Oi5UjJ2HwviZfn7tWziAk
         eVcZCoW4odUhCG+9L5jY0Pk/8Ax6hkvT/BrkTHFcU7P9lDyI+HEd+i7IYRcERpHneFgU
         FSpY2D/ttLkLJQ2v5BJKa5lNqys1zsoDywxjzwaWXsXjFI3gYxh7oeEkZQ5Oo7S9CshX
         uGOGBH+wTUJa805lWdzYX2S/tjW6aQHjO04dqSi/icuyOIUPSOw2k4czQFuBmOQnANNA
         hFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782653846; x=1783258646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/ERgMpgZ/aBHq6dAj6hhrHv3kdwwLXAdxeqFG4lEq0=;
        b=U4ZRmJNWpTOL8gk3zIrkIryC170kayt/bVjMQHCJze84+D+pXB682PWt7N73pRWRqE
         ZwEU6K0vxZpfn/KhIwFspdTCBvvVk+j8XXQZv6Dlf7U8iVdWgsEg6PwCxHSH80EWBx9l
         prgi5Mw84Wwn4IfTU/0MU+3JwAlZOHuVKV/wQ8LvHVO8wUwEwwFG89e/otYq2vaCMNXz
         +8JNlwHnJSy1J1VMzRE8NxL2Af8wkWt28ifVExUpJLpc2N9/9y3sJAPByheOJRhbpRQ9
         TJ925dgv+qyOYO1DMEXO5JrVRV1q2m/MCwPhdd4uRAglFYUzK6JJeW71OGAyktOg9rBK
         ltrg==
X-Gm-Message-State: AOJu0Yzo8fUfB2bhKpDYfqNIpNESrfz64agLHTXS+XYSRP9NBfi1173Y
	rRJYVzv0EJBYQTgUfNwHP9Ypn6qqGyuV26YqRsAbhljNVkoegPiJO3Hm3MqHWsKr
X-Gm-Gg: AfdE7cnW9aF/WdzbkBIwrwvFfCFo+AE0yRJnoBu7DaaIVci/WL71L/sH3zbd9KHyL0d
	EV7B/PLXt8BdW3j/wMW1ME5tx5Y3hS9+mdHX5OJ9CkAHBWr6pI28ayJoYrMit2zDhb2IUvHuVf5
	w1gAlBurSFlde2/cbl9fHDLA8szI+yP5NqT57pwvOTCxxRVqxx/VYI+iB+72hYxSgyBQjovh3WE
	Hc8/IEvN+Dy9jgWDgTBdgTFF5ZCe8p5GvvI6AXVpAGmDMoIhnvggW8hnXlTD2BBOgb3kstMxGqR
	3/6oM+p51kStIk/keKhNVIFgBK9bHcupBeOO64T9mSDu3X2gv6DHOVzYyuHyJwes3R0PgQOICsl
	hpMr5TYKI8H6ir4TXY0POui5nCyr63Wc4w7CDapZ0P/7monAPbUHnVdeHJ0eeAvDbMJsM6CJG7G
	EQmHzW+9RRxdh1pqhFHDLK9IkdTcoaomNP4+V9/KF1xUV1a7XuplCGJEeXqOJ+Lt/l9tZrdWyHC
	iMHMw==
X-Received: by 2002:a17:903:2305:b0:2c9:e266:e32e with SMTP id d9443c01a7336-2c9e266e610mr19470105ad.47.1782653846132;
        Sun, 28 Jun 2026 06:37:26 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9dbd09695sm14537525ad.81.2026.06.28.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:37:25 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: validate report size before copy
Date: Sun, 28 Jun 2026 22:37:17 +0900
Message-ID: <20260628133717.941389-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_cmd_to_txdma() builds an output report in qsdev->report_buf, a heap
buffer allocated in quickspi_alloc_report_buf() to the device-descriptor
derived max_report_len (a few hundred bytes for a touch controller).  It
copies the caller-supplied report into that buffer:

	memcpy(write_buf->content, report_buf, report_buf_len);

The HID core caps a report at HID_MAX_BUFFER_SIZE (16384) by default, and
quickspi_hid_ll_driver does not set max_buffer_size, so the length reaches
the driver unbounded.  A hidraw SET_REPORT/SET_FEATURE ioctl carrying a
report larger than max_report_len therefore overflows report_buf with
attacker-controlled length and content.

Record the report_buf allocation size and reject reports that do not fit
before copying, matching the equivalent guard in the intel-quicki2c
sibling (quicki2c_init_write_buf()) and the hid-goodix-spi fix.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c      | 2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h      | 1 +
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 4ae2e1718b30..1695efd5961d 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -559,6 +559,8 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	if (!qsdev->report_buf)
 		return -ENOMEM;
 
+	qsdev->report_buf_size = max_report_len;
+
 	return 0;
 }
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index bf5e18f5a5f4..0ed964bfe3dd 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -157,6 +157,7 @@ struct quickspi_device {
 	u8 *report_descriptor;
 	u8 *input_buf;
 	u8 *report_buf;
+	u32 report_buf_size;
 	u32 report_len;
 
 	wait_queue_head_t reset_ack_wq;
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index cb19057f1191..db6054843e77 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -30,6 +30,9 @@ static int write_cmd_to_txdma(struct quickspi_device *qsdev,
 
 	write_buf = (struct output_report *)qsdev->report_buf;
 
+	if (HIDSPI_OUTPUT_REPORT_SIZE(report_buf_len) > qsdev->report_buf_size)
+		return -EINVAL;
+
 	write_buf->output_hdr.report_type = report_type;
 	write_buf->output_hdr.content_len = cpu_to_le16(report_buf_len);
 	write_buf->output_hdr.content_id = report_id;
-- 
2.43.0

