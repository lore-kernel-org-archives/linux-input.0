Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337443A7F5E
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279792; cv=none; b=qPhm3I2ucIW/GxcYEbAmU0PBAMxct5h3VVtP5s9l/XOEsoWA1t/8zfI8zojZvINvOS0yqGUiyVt31Pm6ECFZIl3TekTPK8ziJrj4vUw+0DdKgzvqDgCyGsznhK/13zcWxH8BI4bscrVl0UhrDHOxsQNStbQiCwErzL9QzIiXwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279792; c=relaxed/simple;
	bh=HDcBmvwtIazuzQyAN/7w+ZhNN3Jy4GpM7mlse59y/K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUGh8JZYe7f/z/gwi7Lr3flb7dd8wP+SW1gaIPuH6A3hzy3VbiTfB3YPE6Emt/ofMPUCDXht2T5oc39sLtpEQbZBDXPLoTD4poe56bukM8u5aepXQT1CeCEZVVX+PIqCoOrfwlknhvM+XuoITGrZAKpqovYWdFXnOGl1wmS/FVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Th67Lf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Th67Lf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caed617615so86024095ad.3
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784279790; x=1784884590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pCpmT4pbrNtqEfg5rTMCgVzYOvryZpyfEkqoROTNER4=;
        b=A5Th67Lfzs7sBwv+vvXDwqYbhObRwxH0S0LBdqt9W1/7HonNwuWrKvJFth05Y6EDu2
         Nec2IDJNrt+7+7VMNLSfQciz3tuhlIY+15G84WamUJVhOSDG7QDhlKD2AOC6pJ15dzYm
         FStVX0fTltg4PLA0i+Ld4wlm0peZp9QD4cWYCYVF7A+WCAjszvrSW59WB6GnlGc9tH25
         URUfkZHyc2zLa9pwrjHc0JfZeV9Curv9S/lAwxvAdixvySV3AA203SWszItB7sz/s+SG
         RZiAU6PgGVmBeHh7ixsvytqVv19SBWXvo1xRdbu5U2qr7B9KTIExarPdO13obSLy6MDx
         8J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784279790; x=1784884590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pCpmT4pbrNtqEfg5rTMCgVzYOvryZpyfEkqoROTNER4=;
        b=sWkAXeagdr2cgQxMqrfHM5g+XnekSIbTZMcJ063+CAHtoe23zUcM4TGTf0na0JN+oP
         8eaPAxz380FnFNM5/O8sXEnYZUHRMO9q6PvwEi7a75W4FQ+1DMIQsqTaSe63knWSbA1a
         zb+SmyM4woZ0cho3q5rm0vM9Q+VfXl2ALqTXxA21LrbIZJtRSWlH5iktSTs2EHa+LrOr
         xCVFOiZMvsmJ2MnLVGTcsknvssBjd2mHra6NgmL8OBllaRLNBCnHzFONlT2h+OgwIZkX
         PdjConqYqbTIcQYpBbik9Le9yZNRh9sRx2zkYp8jX6BdMq947kupZFt9rNyen52ueiWk
         K4lw==
X-Gm-Message-State: AOJu0Yw449nOYDB5VPo9v6GzdCpXoR8AQepXu9ef8Ro3QCQzgII1UUU3
	B08U19xnyXUt1R42Zpfaakcp+RZKOgnvAP8SySKCcrIjYbxblNr9j6eT
X-Gm-Gg: AfdE7cmpZtbYLrM9W6Jb3pk872vVmcodAVRF5sFMbNr6z96h4UgDn7dyzid9new1t74
	CIE39UKht+RSEr2siecqQBfxXZucBvEZ5f0BEWsOO1LbmHPk3EB2lRV7fg3HC+6JlHlRgMfutOh
	6LlJrWjVAzsHADrOetkknA0MB4k7Znk6d8GmgLaqinc1f0ZYz4DlOOZSDQrv59neNYWqYLkwxqr
	lXd4TEmz0AmIEycaLW/khoJPS2/eoPbsmZMqB3l86fo08yjZAvBHcFXne2uvjz+VF4PUNFdPSDe
	4qs1806dyUadM6gY12xsGIjZhN4FnZ6lF+2yXE6YpipovSwJHE17gHA27VuVRPpXt7dPaKal09q
	LQyBJ8T7HnVhXfIzBVJtXAti5WxM4yTk+vwI51Rq2mbBR59ssOY5DOON351MODLFCBmLeNZfP3o
	iXSv5Im2S9Ml04VLI9qIVYFFzwjzEycJ5EJhXM3jlqZmBDydZn9LHxgYWsPOrQd3MKt9Q=
X-Received: by 2002:a17:902:f70d:b0:2c6:9f6a:9f6f with SMTP id d9443c01a7336-2cf349b8d41mr18806065ad.28.1784279790317;
        Fri, 17 Jul 2026 02:16:30 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34490361sm7407205ad.17.2026.07.17.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:16:29 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate report size before copy
Date: Fri, 17 Jul 2026 18:16:22 +0900
Message-ID: <20260717091622.1744196-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260628133717.941389-1-sammiee5311@gmail.com>
References: <20260628133717.941389-1-sammiee5311@gmail.com>
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

write_cmd_to_txdma() writes the output report header ahead of the content
in the same buffer, so size the allocation to cover the header as well.
That keeps the added bound from rejecting a maximum-sized report.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
v2: Size report_buf to cover the output report header as well, so the added
    bound cannot reject a valid maximum-sized report (raised by the Sashiko
    AI review of v1).  No other change.

v1: https://lore.kernel.org/all/20260628133717.941389-1-sammiee5311@gmail.com/

 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c  | 9 ++++++++-
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h  | 1 +
 .../hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 4ae2e1718b30..da5ecfcd0fbf 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -555,7 +555,14 @@ static int quickspi_alloc_report_buf(struct quickspi_device *qsdev)
 	max_report_len = max(le16_to_cpu(qsdev->dev_desc.max_output_len),
 			     le16_to_cpu(qsdev->dev_desc.max_input_len));
 
-	qsdev->report_buf = devm_kzalloc(qsdev->dev, max_report_len, GFP_KERNEL);
+	/*
+	 * write_cmd_to_txdma() writes the output report header ahead of the
+	 * content in this buffer, so it has to hold both.
+	 */
+	qsdev->report_buf_size = HIDSPI_OUTPUT_REPORT_SIZE(max_report_len);
+
+	qsdev->report_buf = devm_kzalloc(qsdev->dev, qsdev->report_buf_size,
+					 GFP_KERNEL);
 	if (!qsdev->report_buf)
 		return -ENOMEM;
 
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

