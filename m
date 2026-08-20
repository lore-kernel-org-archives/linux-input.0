Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4241CB57
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224579; cv=none; b=nHxfQzkPk9ZYnhlFEeY1ayGY0yx8OwPSVfoCfLQSji28Z/4hc2RgXkrcOiN6TIYPALVkbAeF1edONx+x7nIcdw0PcKieGlpnZqubSgIcEUCrHQfXyQIUD3pHG8bybekt53Jms6rUkksPFL/bVTNLI6GcsV9VzwX41ViiQiBN6VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224579; c=relaxed/simple;
	bh=vO0izHD2f1ofrT6G0UqWkyQBcgoDbMLoEZdWgvw592E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAGpIhBkat664KWJTVm7rTc+R+emfArijBNUHQOHjPyHv7hThQTtyQiHQcq9o/oSold7z+FO4E/jIx5oMBrHBTdpMUx7taWYZGHYzIP1cDC1O4NU1Mzfag+C0SO8vpEr0H0gHFcyvOuP8gPBC7iUs4+VaVeLsmloXLKlVDn7KYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdwBoTS+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdwBoTS+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca80d708489so539370a12.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224578; x=1787829378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xmFjaomKOSQJ0x9BcEAzGij2qfGuvuK5f2g46VdQqOU=;
        b=RdwBoTS+PBqktKaMXyAE0n7knUQGLTqRAbZJrSyvMR1n01dqwiWdJ/lyDXMQKyMwj3
         SdtETFoCpeqLKNCDoc+TC4sdQRzevmwYi98T1wjOA1DFCXrG7ArmBioHfZStTj9OT2Kb
         r6IR9NRorpuThsnJvkDocdqtYp9zhm6qHzMIyHdAZgJ6ZQGePlnBLIy4xJM7ji+2MnDq
         ZMruzVRDRkpOhKmvzKXEGfsB5tZYm56Mo5n5TYmG+cNeKIeiYRwpChg611UiyFI2h3PP
         fkNXCll3Ut7WttNd4pCIeqqt+LjGR9fgLClBlPmA9/eLCgFPx4lH/zQFVmbXz7OYHXUO
         lXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224578; x=1787829378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xmFjaomKOSQJ0x9BcEAzGij2qfGuvuK5f2g46VdQqOU=;
        b=mc+CH5hkPZWmWwb2W3lI8r6ugQwcTQQUE1LlN2e2UAytl3jaNRNoQD86jeMif3MCTa
         j6F+UAWubGHJbgFnaUb631KahemMTxBGG54i2jETeVePtkpSDyUJFVh32J2lmJfLdNcr
         dV7wZwkUYPIGLS0T4rvbKuFVru1TWiCvWLXo9m9UYCZoqOoxHKqBJ8Bx6xRnsH2YYZgO
         CWLcubp6NGK9ANWjDlA/zT47E4Xp3Ww5VTjxkr/U/e4Jinny/WKdeFlfAgwAVKtZlO9q
         9KVkp2GP35czVfSMxzsmo2kqKDLRP7S0MWcHdHrE0LbsB3A8RaD9U6qfD7OHhW3z/ZX8
         VhwA==
X-Gm-Message-State: AOJu0YzEsT/+kkogrlbAM0xsP++7LmNDtpk6CJfC//P/OZbQaHD81G0Q
	e7I7CL4SEjyh+tFUxl+0kPKfOQ8c6mKIeZc+dp3MeLC5/Sz6Q1B/EALB
X-Gm-Gg: AR+sD13u2wL4wQ5wMnXWqQd8YHL+ZHjpejOBKdW38bAkiIs6YCvdyfrmzIqWPlsndSd
	CVOts6jJqjvhf8zqVAW10iii/5UGJ566pGyOKk0++Bjp8oj+QK60xlglYr85HFKaR29JQmvo9za
	YqKCwdtbe90HXAQdSkzIXT2hSPYmGkUnKrY0j191jUbOnbDGgcxabcOcYfZeoKOz3aUPbdYukLz
	Vk073MvdwVFPycwgmdbt2vF1dkxLL485qrCFTC253a5Obu52SCFHE1oi43VIEjA7pC0RicWCL5f
	EihkMycbeTyoiTg7O5GKV3ia116oZusYYkP3U9oxd5btfKCiY8tPb4eQNi+ERdCykonlwjHm+pf
	ylZm+nug2lZkBKNR/0YEMXoeugWtj43mT6x33jRhGK6zcLqov/F61UWT8lGkh4sA3+6IJp8b61H
	mwWxOGCGhL9C3ln4l7ygo5w4FI2UzjJsb5h2pO0vw2oc6J9XCginPlZ4GFYNS6w8V2qtk8Pn5tq
	8QeyJTLUe2CqMq+NGlprIh74mbg5Ja2dtV7nAObEcUqy865ObpTKOJDm3t//akK
X-Received: by 2002:a05:6372:a70f:b0:3cb:b6b0:1b83 with SMTP id adf61e73a8af0-3cd14f251acmr5785817637.9.1787224577549;
        Thu, 20 Aug 2026 04:16:17 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15cada6fesm1236455a12.27.2026.08.20.04.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:16:16 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the GET REPORT response to report_buf
Date: Thu, 20 Aug 2026 20:15:58 +0900
Message-ID: <20260820111558.475304-3-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820111558.475304-1-sammiee5311@gmail.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quickspi_handle_input_data() copies a GET_FEATURE or GET_INPUT_REPORT
response into qsdev->report_buf using a length the controller supplied.
The only check it passes is against buf_len, the number of bytes the DMA
delivered, which says nothing about the destination.  report_buf holds
HIDSPI_OUTPUT_REPORT_SIZE(max(max_output_len, max_input_len)), 68 bytes
for a controller reporting 64 for both, while the copy is bounded only by
the 4K DMA packet.

The REPORT_DESCRIPTOR_RESPONSE case a few lines up validates against the
size of its own destination.  Do the same here and let the waiter in
quickspi_get_report() time out, as the other malformed-frame checks do.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
This needs commit a59cf84441f9 ("HID: intel-thc-hid: intel-quickspi:
validate report size before copy") for qsdev->report_buf_size, which is in
hid.git for-next but not mainline yet.  Same Fixes: tag, so a stable
backport wants the two in that order.

 .../intel-thc-hid/intel-quickspi/quickspi-protocol.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index 847c5ec55569..7d34cc22a11a 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -161,6 +161,7 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len)
 	struct input_report_body *input_body;
 	u8 *input_report;
 	u32 input_len;
+	u32 report_len;
 	int ret = 0;
 
 	input_body = (struct input_report_body *)qsdev->input_buf;
@@ -210,10 +211,17 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len)
 
 	case GET_FEATURE_RESPONSE:
 	case GET_INPUT_REPORT_RESPONSE:
-		qsdev->report_len = sizeof(body_hdr->content_id) + input_len;
+		report_len = sizeof(body_hdr->content_id) + input_len;
+		if (report_len > qsdev->report_buf_size) {
+			dev_err_once(qsdev->dev, "Get report response too big: %u\n",
+				     report_len);
+			return;
+		}
+
+		qsdev->report_len = report_len;
 		input_report = input_body->content - sizeof(body_hdr->content_id);
 
-		memcpy(qsdev->report_buf, input_report, qsdev->report_len);
+		memcpy(qsdev->report_buf, input_report, report_len);
 
 		qsdev->get_report_cmpl = true;
 		wake_up_interruptible(&qsdev->get_report_cmpl_wq);
-- 
2.43.0

