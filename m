Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4935DA69
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172600; cv=none; b=QXr2Qh38IOJj7jppBRZ78bF0cDAhuRT7RcEJpCULVHg8qAUwOFcIrhQSCsEPK+Eqel1kvE1GHsEcpvKoGzbFpnzcrV9gVtiPoY5xXYOhYGpSglKXn8hC96yphCP0UT5wXwXP8CMQgWTbsrlUB+tGClyxHda/NVGeFpv00ididwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172600; c=relaxed/simple;
	bh=g+o8Gax6yXxVJ9Ymvpwj7De47snR6AbkdQJOz9rOYXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UED5xADcm2Ve3qJlh5b3viVlZUh3DQOQ/YWIrtZ6bizF5P80X8NdrBHKDxxm0qbkjbrIR6w7wecFncRicylws7O2IJbJXRD5aavebFyRLGwowWXP729xij98CXyKUyIgHZkCQU2xzHMfKqfQvJ0/FiB/b0s5e2e3Q3oLiGxfkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=qafyK8Cv; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="qafyK8Cv"
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-12713e56abdso737027c88.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1778172598; x=1778777398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqcAML0ZZ43DsvITP1E2cCodXpE6DI+947s+bAV6M6c=;
        b=qafyK8CvTdEgqBnkFua3jfjtE4gqMWnJD20A3y/53xiSB2VCLFidb0Fwlrxt9OvCz9
         10x90hxiTV2NcaQ6QXenz6s+W2+M14dR8ZFv/S6G1v0d/h/BnFiQOZQDUH/oX7sHVwIb
         0u1M49DrLmsQNHt8HljYV6AYvtB+a9VEwfb0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172598; x=1778777398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqcAML0ZZ43DsvITP1E2cCodXpE6DI+947s+bAV6M6c=;
        b=bhTJllZLfNL2t6OLPfnD7deeNaiU4XEitfi7M895P7xGmBdh1aZIAlcdzMdxcenLrS
         hAmFEtYZrsQ8s5wkmZk/zFCxZzAkUFHi6STzdlSPuysKfTS3o8iggnU2nQ5L+zjypq7u
         sIuBGlsas1Timir35fX/3f2cSSQbNf9yC7jm8DPCIRALOt4VLWrWofOHa+a7UEmcOLlR
         Y2lN8oX/PEu7I4KDAUTSTXf06ydrFLIGSCXyKHse4xilfGyr6gVGp3er8WM9oxFyz8nb
         Sds+t8Dc2iefREsddYmihk8MGOGar2v/3IPF6cVlV+RW+kjxs3F62tgw29gnT7ykiY6/
         V9fQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ohjFV3Lmx4XUDLvInf7FyUytm3iqlh6FsL5qfaeCvUNR3x7TBaAtfOOeGec92dMojllnNmHMndBYrfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztI0XRmLeZgh4hhL+og5QRCrKyqzVeLF3FxWUCJxe0xDDuF7b0
	3KE5kRxGpprachmpYz8Vt2HtoSELLzuc+e/ivw5gSrHu5DtIsQSTaML3KSZI8Oom0bdGtRVFLYx
	QsiGGgZRNGIqDrpetUdwRdAs2myu62KvcaAtu
X-Gm-Gg: AeBDietPHOzMWwRr7oevASDES1yFENeViG622SrhqDkBMv/rWCOnaGCg0XOI2XvpKF/
	ZeyL5M3h4J8QklXL82wtODK0KeRd4lb8ppfz5qlgpxjIeYyQQxgvN8M6ycNhIq0gQcvsfCgYIQB
	cMWLWLKjy/NmkJLTI4A/q33Qmg4n83EbNJv/HFk5Kd6wkSyRtJ54co0buIPk80gBzuqioueTufg
	Am8zjXnRVBX4EEDI0H+Z9JMGd4HOP36UBTQsL8PPTtFVdstkTjKWnaugASGTyWN9VAWI7GbMaUr
	zjYaJA4pBNi94wokwjulKgLETMcQTmlo5GXG/ccuuKiwdDqYJWC1IKKmBWBwFZ0RzAtNJ9AWh1P
	BIgzHon4A4UM02Tt9MomuGncL35XxlyOVWCJOAZnxORv/u+AW
X-Received: by 2002:a05:7022:986:b0:12c:6ec9:3f1 with SMTP id a92af1059eb24-1323b0b726emr1668516c88.21.1778172598081;
        Thu, 07 May 2026 09:49:58 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-131f99a5a9dsm498874c88.4.2026.05.07.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:49:58 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Thu,  7 May 2026 16:49:43 +0000
Message-Id: <20260507164943.760009-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workaround for XPT2046 clears the command register, giving the
touchscreen controller a NOP. The change incorrectly re-uses the
req->scratch variable which is used as rx_buf for xfer[5], so by
the time xfer[6] occurs, the contents of req->scratch may not be
0. It was found that the touchscreen controller can end up in
a completely unresponsive state due to it being given a command
the driver does not expect.

Instead, rely on the spi_transfer behavior of tx_buf being NULL to
transmit all 0 bits and use the scratch variable for the rx_buf for
both the 1 byte command to and 2 byte response from the controller.

Also relocates the scratch member of struct ser_req to force it
into a different cache line to prevent any potential issues of
DMA stepping on unrelated data in other struct members due to
sharing the same cache line.

This change was tested on real TSC2046 and ADS7843 controllers,
but not the XPT2046 the workaround was originally created for.
Confirming that the original modification to clear the command
register does not impact either real controller.

Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
Cc: stable@vger.kernel.org
Co-developed-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---

V1 -> V2: Don't use rx_buf when clearing command reg
V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
          output on xfer with len and NULL buffers
V3 -> V4: Move scratch to end of ser_req to force it to a new
          cache line.

V4 Note:  Change to moving scratch was tested against an SPI
          controller without DMA. We do not currently have a
          platform using this controller on an SPI bus supporting
          DMA.

 drivers/input/touchscreen/ads7846.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35..1ae1ae42582a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -325,7 +325,6 @@ struct ser_req {
 	u8			ref_on;
 	u8			command;
 	u8			ref_off;
-	u16			scratch;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[8];
 	/*
@@ -333,6 +332,7 @@ struct ser_req {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	__be16 sample ____cacheline_aligned;
+	u16			scratch;
 };
 
 struct ads7845_ser_req {
@@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
+	req->xfer[6].rx_buf = &req->scratch;
 	req->xfer[6].len = 1;
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.34.1

