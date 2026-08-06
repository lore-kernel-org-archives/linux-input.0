Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5A22689C
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023527; cv=none; b=nUBQ3UHg0vGYDa9pJn3Yx7hnlPSqb2llNTt9KEDsYlpZ6POevR5CQ3kybfiEtZWPB5QR71kFPDNUQ8V6YYQlKLxTKqXV8wfi/Pu03x3kMoOJPIaRdFAqjf43yoXTLtcDbpNzBVyashMwIfgmejvrx5O56hznFI9/+K98xgDRQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023527; c=relaxed/simple;
	bh=SJ0CQsymO4jcDTqokRj2XeROVTcXNVQ5WcS9OVMXblk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etMmnEqk6bFHbvFSXVG7b0Qy74CSi+9fMRZqtXcXDiCTKE3O9tfWpXjcFcvyxWFayWBXMAhFtoLKceUYgDqq9UmKu7TcsL/4KdUN+LBGYXpYG6xAMZNoQyV5SUsDc3h8ou7h6nqKbBTkuPE7illM+4DPT8NOjcOyA7bJTdfAEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6TMgMmH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6TMgMmH"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so2047304b3a.3
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786023526; x=1786628326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n8znQjoP1MnTnyeT/KthZOHx57cQrDSiKl3hZQXMu3I=;
        b=T6TMgMmHyyD8gZvlgw4sAdYgo2aZk5GWe/Uuw5WBOZYDlskC4OlTN78QcGvFdhaCyf
         4o/qpqW13FPKhTCa/WCcZE+lqo5iiHOtZPFdxxeBMVrSeFPLZVp/nmPSE1xlj8dAsY7S
         yPzbVl7kOmvfZQnXBYa9MW01NKn6CyPkuCm3fTpQQU0p3VWmtLm+IC7vMl6VlJLtRlTJ
         PBhKkcKfjrf0UA7AA9LQ12xkVrDNWZVKP2TthMQQxQ8p1cOB4ufUjd6tK3qme7Jy60Ut
         g4jwQ+4/TAl99UrY1C3eTJjtjsQjSrwav7g5Qbs/ipFWn6Ukx3lJ4nA0dT1md5yToBCw
         jh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023526; x=1786628326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8znQjoP1MnTnyeT/KthZOHx57cQrDSiKl3hZQXMu3I=;
        b=eOnEmIO1DAgaRvfeHw5QHJ9h6BAQcnAwbrzrngYUaMhR+s5NIurHUmltXOu+ahRbJH
         hF0MK0sNLAEachaPdCnAl6nIK9WHgw8T/8HCGdpjJQf83vOmGuW3WZaLWdp3eWLJbwrT
         9bBww7l1hXRs9jZ/6tqG86xTiyujeiYndV90AYIAv1NE6fcGolJoxJdsU3MrMtXPqngr
         2cbRvHrmjQGzgVavcQjJ24O1HL9/UeBP2axrxS/9RjdcUAxRDzVU618uGfrBZtV/w2j/
         zzdjjCM1B2cNV9mK0qwyfWHRL533b+yqLKkBhavMykpeB5xTEPhIpsouO+A+wVsrrGco
         5oeQ==
X-Forwarded-Encrypted: i=1; AHgh+RogK9nP6ontZApXch6rEG1z/YkqNIEznci/62skZLar7fB6KFCpVa745/2oLPhU6sEdCFeqddbqLXHr6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+4LScbfJAT+vE7rWu8suOe7N9ay3fjl19X+GsODiyFaNzswW
	OUpIUBfjTHYNfvCGiSZRHU1lKiPkdHtGRL6uI0aPpw3JjFf/W6+4qcLj
X-Gm-Gg: AR+sD13tfbyj2d8oB7DE4pFb8suDCnq0DdXeicvStngau5/hqtxpcgnJWQG4n0mZ+PH
	Dr+hvCEJq9RL2STKnbCNL6yJ5ZP/ClSxVkNvOCFM/EhGPJXo2xtPmbfze3sq+C+I1J+qNrbJj23
	HOh52vqZa1MVaYoNO86FE3MSus8rx9MwiHT+bq4nXeoVVoJ3C6OnUPsVBV9aJ0majzFPiaiwDpp
	FXlX4gWRVjN1M9PXOtOwKFbRHSuqH86cFeSCjyusivyqDpksTUTICPDfRAhEVEMbL7t9+BLx78B
	+rjguuT4h6CUDKD3KyrMTM1c6ZIhuNQgmOuKjhRt/nfA9VVlpLlpQledkmWPmIP1FrEa/jC4Q0U
	mdGqsrC4dKYEoREBnNbZvkK80LQwmDp+5X+0p55W5HCqR8g+/zyfux5oM/OOrzgIyz0uqSLkS6R
	+SdzhhzMdPdyAM34q7WzatdPnqK22IrSLJEL3AOqaU2xdA3UhFjFg4GtBYavsfq0sqsXbi6XE0h
	SXF6aVSV5bgGfCzXSXhfJmThH4aRCpP2pJgAAkAfKH42eOBN9PX4A==
X-Received: by 2002:a05:6a00:8019:b0:848:4a48:9f9f with SMTP id d2e1a72fcca58-84f4fee000fmr1925189b3a.34.1786023525452;
        Thu, 06 Aug 2026 06:38:45 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0cfbsm1463682b3a.19.2026.08.06.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:38:44 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller buffer
Date: Thu,  6 Aug 2026 22:38:38 +0900
Message-ID: <20260806133838.3378362-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quickspi_hid_raw_request() receives the caller's buffer length in len, but
quickspi_get_report() never sees it and copies the whole device-supplied
response into buf regardless:

    memcpy(buf, qsdev->report_buf, qsdev->report_len);

qsdev->report_len comes from the input report the touch controller returns,
while buf is sized to whatever the caller asked hidraw for through
HIDIOCGFEATURE or HIDIOCGINPUT.  A response larger than that overflows buf
with device-controlled content.

The intel-quicki2c sibling already passes the caller length down to
quicki2c_get_report() and validates the response against it before the
copy.  Do the same here.

Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
Suggested-by: Sashiko AI <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c  | 2 +-
 .../hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 9 ++++++++-
 .../hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

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
index cb19057f1191..9c4fce09729d 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -342,7 +342,8 @@ int reset_tic(struct quickspi_device *qsdev)
 }
 
 int quickspi_get_report(struct quickspi_device *qsdev,
-			u8 report_type, unsigned int report_id, void *buf)
+			u8 report_type, unsigned int report_id, void *buf,
+			u32 buf_len)
 {
 	int rep_type;
 	int ret;
@@ -372,6 +373,12 @@ int quickspi_get_report(struct quickspi_device *qsdev,
 	}
 	qsdev->get_report_cmpl = false;
 
+	if (qsdev->report_len > buf_len) {
+		dev_err_once(qsdev->dev, "Get report response too big, %u vs %u\n",
+			     qsdev->report_len, buf_len);
+		return -EINVAL;
+	}
+
 	memcpy(buf, qsdev->report_buf, qsdev->report_len);
 
 	return qsdev->report_len;
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
index 775e29c1ed13..8a2338bee808 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
@@ -12,7 +12,7 @@ struct quickspi_device;
 
 void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len);
 int quickspi_get_report(struct quickspi_device *qsdev, u8 report_type,
-			unsigned int report_id, void *buf);
+			unsigned int report_id, void *buf, u32 buf_len);
 int quickspi_set_report(struct quickspi_device *qsdev, u8 report_type,
 			unsigned int report_id, void *buf, u32 buf_len);
 int quickspi_get_report_descriptor(struct quickspi_device *qsdev);
-- 
2.43.0

