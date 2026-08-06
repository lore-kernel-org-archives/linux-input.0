Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7C448CE0
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026210; cv=none; b=IxVk4oNk+HL3UbWIIzRMztOvv4acbROoPxbAPFGGCzjHvows6VShmAjh8UAFLWbYzPobk2QSol9eF07XIK8hWgS7KHKyFIezfAkKwyPq6xnCJeRJwgR74kjCtPuTFEk71O4ziIsTctzNVLCJp6ZmmERWAyvRDl11E6Swa5kA2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026210; c=relaxed/simple;
	bh=8o/bKbNbg3kyTVTxvgFZt8Eu1oXXlEt3s5TdGxrHtN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZBoHH0wEo/hhY3M+yWXBMLLuGNzjefUtXQmP5M/cLP8W8RTuojZ+OCayY31CJBka17ElkWWBrvTg1lcFbXp4Hp8sg5OQsn16e/teMseXuuSVLkDydkUP2wKGhujD3TPeVRAqyq4EDW9y1k9AT5mQgKkK093kYeFhoIOLv93hDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqy8MWok; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqy8MWok"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caced6038eso12941235ad.0
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786026208; x=1786631008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LyITTJEhy3jveR4MLbliv+w4yGr3YmCW2vDF26WQwj8=;
        b=Tqy8MWokDKEaIsY3vHv1HSDSUNwy5XtECQQUJrfpQAQrBgRwShIICXJL1qOHWJqSDt
         beZXEjL05yojgauQhg4CH2DT7KW3uebPPIGZ1OGjO+UfurY0HbsRayK0FF5PSkud1H9o
         uTwS0EYDDn432TeAXJDWU0GZfcO/nMmYr8mx1+pBUBGLIYRx8UqAe9nwi2/V5ny1977X
         Q4/lfUAGsxJHpA1rMgLd7U14fLCvbhIT5bvplzRmxRTGvdRRLWM3I3LeN3qtlCc1JUTu
         //oYKNGDMy5CDE6g1hO3thrPPmdjHy9ayZ3OWK2HOLZBUCG+a7uXAs4LbrqqDLJMeblE
         Db4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786026208; x=1786631008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LyITTJEhy3jveR4MLbliv+w4yGr3YmCW2vDF26WQwj8=;
        b=rCgh4M9A2WfgBUPwToWI+YtOIsfzvdyMv7F027WHOwBg2EmP8hcOFbXPzu8b5OyzCZ
         oe5lNcwjJt3Eih9dEflCBFH8Jn7a84macQ7O68tjZ0ljEIgnturh2pVqZDtn+rkqAdqs
         DtnOoZXpbJ8fZh4AwKTtoLh26kMpVrT5gzLIbZ0wcP76Smc1iB9KRK1ybqT2qGzUtFRE
         Z/Es4vaBPJxpXCDPI6Vv+0xOdBaN818KmMbwYTLTx+HBt9Ra3fToCfUEwdeI8jigs89E
         7GmJdU5vw2XQS/6wIq38HV61HCLOIWxNfYrg323RgS82fohgdPkUbwnA9csU/1XBQx0V
         fu/w==
X-Forwarded-Encrypted: i=1; AHgh+RoFjmbT8RHULGiSEytzPF8CKtoudqFfqYGFZkxR9haXmW3mqMPXnfYznyeqjEWsxOBxt2K49D39IDfAoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnow832C0xT/aYgvMja6D2DTidDqFfAlefJ18bmC2JidQJkhhd
	rXDAKO6TgXwGrdLyJZfyZIqtb+gEdBKYkQh7yFDZmTalqEulajO1JMK2
X-Gm-Gg: AR+sD12FQZq9onQ/Qm7MdGYQkoCFpNG+60Jy2JCKt5en204NwttuxQ9Omtjqg4A8ZgN
	ObqJeGPE0glv7VcgwXF7s/Oun1Q/U1G22UsD4uj2/7lSqgzfgRiMSio0N2DrJ/71bylxr2D0+9w
	KrMnecGzV7CDAgaVQ54UwVY4JAxuusqKI70/A6WqWfD6lFg2mchYbx0U6yOLaC39h+t0zg0a5yQ
	EiYqMdCOgqzBZ01dMrjhsOrel7MoDLwH/y0AbzzZ7XX30+NOjqWEChGZGVvinhpjP5+zJ0wLdc+
	tDt9fWYVf3ofG1QJ7kUtpMopkVZ+PR2hGPbTh7+xgTG3BcqK24BAGqpPm7kfw6IWNCe7wdr3Ahx
	Ci2Kvy4bOvqaFHR4VvxqBhcU+VsLts1sfJX6kpuLQ3KdtSQZeh7cp7CF8prLVhfK9q2tEmW77gu
	QKn4WuRxVAHdbYtU4X74H8J3EngVeLUOpWmhHsF30Fl7Jmi54N4H/IPHX32LLkm72ERHWMBSV4F
	DSS9YtsYx1wz6aKNTQnk0j3Ak+ID9JwJ1HRwTTkVN0qKlNw6nJ+YA==
X-Received: by 2002:a17:903:1a0c:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2d0f1a4000fmr86726805ad.6.1786026208223;
        Thu, 06 Aug 2026 07:23:28 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa0268b3sm32325195ad.37.2026.08.06.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:23:27 -0700 (PDT)
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
Subject: [PATCH v2] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller buffer
Date: Thu,  6 Aug 2026 23:23:21 +0900
Message-ID: <20260806142321.3383353-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806133838.3378362-1-sammiee5311@gmail.com>
References: <20260806133838.3378362-1-sammiee5311@gmail.com>
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
v2: fixed a Time-of-Check-to-Time-of-Use race the Sashiko AI review of v1
    pointed out - the new bound read qsdev->report_len once for the check
    and again for the memcpy, so a concurrent update between the two could
    have overflowed buf with the checked-against-a-smaller-value length.
    Read it once into a local and use that for both.  No other change.

v1: https://lore.kernel.org/all/20260806133838.3378362-1-sammiee5311@gmail.com/

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
index cb19057f1191..10b06dea3961 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -342,10 +342,12 @@ int reset_tic(struct quickspi_device *qsdev)
 }
 
 int quickspi_get_report(struct quickspi_device *qsdev,
-			u8 report_type, unsigned int report_id, void *buf)
+			u8 report_type, unsigned int report_id, void *buf,
+			u32 buf_len)
 {
 	int rep_type;
 	int ret;
+	u32 report_len;
 
 	if (report_type == HID_INPUT_REPORT) {
 		rep_type = GET_INPUT_REPORT;
@@ -372,9 +374,16 @@ int quickspi_get_report(struct quickspi_device *qsdev,
 	}
 	qsdev->get_report_cmpl = false;
 
-	memcpy(buf, qsdev->report_buf, qsdev->report_len);
+	report_len = qsdev->report_len;
+	if (report_len > buf_len) {
+		dev_err_once(qsdev->dev, "Get report response too big, %u vs %u\n",
+			     report_len, buf_len);
+		return -EINVAL;
+	}
+
+	memcpy(buf, qsdev->report_buf, report_len);
 
-	return qsdev->report_len;
+	return report_len;
 }
 
 int quickspi_set_report(struct quickspi_device *qsdev,
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

