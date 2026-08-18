Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE397477E2B;
	Tue, 18 Aug 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061820; cv=none; b=MoQJvGTncSSGXA53P6wJOK2UXYBUP3aBgdQu4+vzPH8AT3F5xmNTgzWLWBDWbpcaQ4q8/WKjSTHYgESRZ/12UZ5eV9vqZdFO9btT1M4D/MtFf6/8PiO7TY0pR/C8fiRcDb+gy0Dv8A+HJ1zDz+C9HSpHn1y5k61Ck991tBlwMPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061820; c=relaxed/simple;
	bh=bxJG6ZJcgQhn+m1SWyFkXXMJZEzwNW2gqONi/JfTjK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AJYkkLoTrmsfkctyIxMeSmfrCz2cwf0hiVp51UhTjetrjmBsd5eX4tN43UuGjkiMXTQH61wi6FPbXgQO7uxDxeAz0lcADCawRXhe4pbbhEmVl/lrj4yJ7/UgnH9I0OTVokBtJpkSISoM0R+HFx3uSTY3+Q5Nw2Iyn67Ez9v6LFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=UdMz96QO; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="UdMz96QO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ymwhVEpXZj4ctpuKsgPqUZvHH4bSXpvXInZ+DeiyeDc=; b=UdMz96QOAkbH2T0gLWI+x3KSHs
	12xUTrhqm6dk1/E10EAP3BKzLnEURugxJBOepR25tVM/IA+yhBKs/9JiFsUry6j7OnODWhuZcJ9EO
	niCLcJpI8xvpFk3oBIJwPLP4aj+H7TNdb3MmS5i0c9rykbcMnoKMSYoFHj7xnQQJp4yEgoGozVDcX
	Mzn++DINLjTcPVwi89x2/bC2RT1SfPcyQyKyVsC0RbHVt6gXPMilpshVz3ed29XIgzf1XersM2F9S
	LbDnXbvyv/dOkjZOPProGVNjk5o/0WFQNDRXF4a6ryP5ovOEGAdvOsI+YqvpXxeEzQC5U6RyGq0o5
	yLmncR9A==;
Received: from [151.115.150.205] (port=41904 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wwKPg-0000000B364-2YkY;
	Tue, 18 Aug 2026 16:03:35 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] HID: intel-thc-hid: reject oversized QuickSPI GET_REPORT responses
Date: Tue, 18 Aug 2026 14:02:46 +0000
Message-ID: <20260818140245.1903804-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Thread the HID core caller length into quickspi_get_report() and reject
responses that exceed the caller-provided buffer before the final copy.
Snapshot the completed response length once so the bound check, copy, and
returned byte count all use the same value.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 .../intel-thc-hid/intel-quickspi/quickspi-hid.c   |  2 +-
 .../intel-quickspi/quickspi-protocol.c            | 15 ++++++++++++---
 .../intel-quickspi/quickspi-protocol.h            |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
index 91d5807b4a83..a60a0a7f16aa 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
@@ -61,7 +61,7 @@ static int quickspi_hid_raw_request(struct hid_device *hid,
 
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
-		ret = quickspi_get_report(qsdev, rtype, reportnum, buf);
+		ret = quickspi_get_report(qsdev, rtype, reportnum, buf, len);
 		break;
 	case HID_REQ_SET_REPORT:
 		ret = quickspi_set_report(qsdev, rtype, reportnum, buf, len);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index cb19057f1191..acc9d67c53ca 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -342,10 +342,12 @@ int reset_tic(struct quickspi_device *qsdev)
 }
 
 int quickspi_get_report(struct quickspi_device *qsdev,
-			u8 report_type, unsigned int report_id, void *buf)
+			u8 report_type, unsigned int report_id,
+			void *buf, size_t buf_len)
 {
 	int rep_type;
 	int ret;
+	u32 report_len;
 
 	if (report_type == HID_INPUT_REPORT) {
 		rep_type = GET_INPUT_REPORT;
@@ -371,10 +373,17 @@ int quickspi_get_report(struct quickspi_device *qsdev,
 		return -ETIMEDOUT;
 	}
 	qsdev->get_report_cmpl = false;
+	report_len = READ_ONCE(qsdev->report_len);
+
+	if (report_len > buf_len) {
+		dev_err_once(qsdev->dev, "Get report response too large: %u vs %zu\n",
+			     report_len, buf_len);
+		return -EINVAL;
+	}
 
-	memcpy(buf, qsdev->report_buf, qsdev->report_len);
+	memcpy(buf, qsdev->report_buf, report_len);
 
-	return qsdev->report_len;
+	return report_len;
 }
 
 int quickspi_set_report(struct quickspi_device *qsdev,
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
index 775e29c1ed13..aa2c935dafe8 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
@@ -12,7 +12,7 @@ struct quickspi_device;
 
 void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len);
 int quickspi_get_report(struct quickspi_device *qsdev, u8 report_type,
-			unsigned int report_id, void *buf);
+			unsigned int report_id, void *buf, size_t buf_len);
 int quickspi_set_report(struct quickspi_device *qsdev, u8 report_type,
 			unsigned int report_id, void *buf, u32 buf_len);
 int quickspi_get_report_descriptor(struct quickspi_device *qsdev);
-- 
2.47.3

