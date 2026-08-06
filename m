Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC0373C0B
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028195; cv=none; b=E9m+xo4iJ8jeoUZvm1TPk+p8QbwlR6QuoIHdUzhKTLb8pSRETOJeC2nkGtco/mI7jlt/c5szC9/C2FnRFk34u3Of90LaR9P/5/4IXFMbfzZCxiUx0ua9KPmEwLpoKbFvPBn36q8cyWl+28hTv6h97VsJelx1SJNXF7yhhRHjbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028195; c=relaxed/simple;
	bh=r/Vkb1+BMlYNY1tJcqhwNh3VEVI3USzDIKSso9O7Uts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHc2ILyVtOTFX9J2NqoKxWx06VKBbfIVjvkVtd1LhKnIG/sSapVOMVAO7C/tpaCTGqC26HyHqEHYtOtO7YN/mU26bCYSdvR7ey4NuZoFyYJjK2kOFDrzGbtNpaR2ylRO9cpMuzqgpRQeHuSg276sQN6cZYg6DpvNXNHWrgStTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7eOxczH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7eOxczH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2041334a91.3
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2026 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028192; x=1786632992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnK5eS+Q5x9auDCqli6J0bfpL+fgyXWFA73Li6vz2dc=;
        b=V7eOxczHA2s8KSscwV+JGqXuxLnlwH5Le0ehkTRTXS8vwIxLfMrQXYexRJIni50CWv
         2/kVIk9ht+GkXBnQKvpa1IAQw8FEIIZk6VSkB347QMbvSksC4VmdkI5xsfoKtWygtHQr
         WCwvAmtAz7m5OhAQBsuW8DUdBYRlmtSM9iAzV71HTTd5OLXNqW8mHaKTT7dGOOT/H8PC
         +TBlIOr9CkT/110X2XkBsuD8QJoNC0mo0pfUoomXqlqmXafz93TZg3bOWe9wfYBsTM+H
         lUc8CFp1V6px+6nToEOiPaDoEnbPiKJTytp9jmJmYnDWcR5fpA0wek36HTqEKj8wYWaT
         s5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028192; x=1786632992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnK5eS+Q5x9auDCqli6J0bfpL+fgyXWFA73Li6vz2dc=;
        b=bx6915QwWkXFDYfTacrEn1ql3z0NTmhxNCJqIPmFG0+8nTzuhlx0DZ+VahyOHAnmmN
         yqy7LZtd+eNcCE9OjNWrBlK+BMn0VdCulIK1+wEYCDjaPOYPUg+QpMO2NPe24SCaGOeN
         Mm4vmUmY/Tqii+Sg/snk1z0GrS8vPHUxK5EwpMg1xd0fq6AY7URnIwqx9IwoJALv84jM
         Qr73VHsJnYcbEKRiGd5jlqSk1BhG4Lqpd1M2qopcTJ5cejBb2jLyB7/n8jRSbBhbSsjD
         H55p4J0+cT8g28V0M1N3mvcPdr1oTb/AxsBUL17Ry3+uKJNx+oH2tXoMjz24FDuyfzvc
         EvsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3/HPHhXRxr6NKOUCOdpDJT14mmX70HRVtOi0ZmYvPoxza+nJEcJ6qfSVKsdgrSDt5qYGgMr6hGOzYgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZKzNcwvmzj/XbIuGcKS2KLcT0jVf+alVivvjtq745OnW09Bu
	WnPNy9dh6gRIhS0EUsPK5lpOZ/oGWtm/i4JJCHlWaqkqsCZjptgu0WRf
X-Gm-Gg: AR+sD13JzdBqbLreQlc1DfiGXG24rieYviGjmuEfsoyZYJPFcwD0jaX7E1WKeMhe4Wo
	0+QH1YywK5/8YiGm5Cv/Ff0+CSJjGenXA1HikXHyh986TPcKBsnYc/NCMmVmJCIymNOLlpAIiZR
	EZDKLkPnxx9/2aVSVo7DimYzDi68jrRoSVNo776XJ5DDk9ltvOUxXsW/nIvYj4q2PfFQopLWwJT
	XT/IIHh/n7u7I7CzeUp/pcM7xJ8DRHfGuVKjG0uFhLfy7OWWbELPcCYzCumNfVgKc+9v1MAYT3I
	gW45UQ/7waiMitVPTeLnxOBjcx0UespNbqKK4psUMHoLvMAWK+yGG75YWfmePVL2ILCqohs/IyA
	k/QG8Q54CF37faRaKawTDdg629exJSLXjkggY73/uB/5Uy8aVaJwoX2CcjjFSz9+JqRzG5OJjn4
	IozYpehYIH6uJSqb4yPfu2aa52TyNN31ahe+oP4IuI6JFQ55sz+D+dh+3Q1tl9TJs0cea6gi1lZ
	brPtjll3PqiqxfBd/Wpxhn0tYw43bYsx8jFVBNtXed6nIbpkvDa75nLLhn6vf45
X-Received: by 2002:a17:90a:c106:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-3909d8d5993mr2367502a91.16.1786028192196;
        Thu, 06 Aug 2026 07:56:32 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d183e66sm3069178a91.0.2026.08.06.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:56:31 -0700 (PDT)
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
Subject: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller buffer
Date: Thu,  6 Aug 2026 23:56:19 +0900
Message-ID: <20260806145619.3386809-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806142321.3383353-1-sammiee5311@gmail.com>
References: <20260806142321.3383353-1-sammiee5311@gmail.com>
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
v3: added READ_ONCE() around the qsdev->report_len read the v2 bound uses -
    quickspi_handle_input_data() writes this field from IRQ context with no
    locking, so per kernel convention for a lockless shared read it needs
    READ_ONCE() regardless of how many times the value is used afterward.
    Raised by the Sashiko AI review of v2.  No other change.

v2: fixed a Time-of-Check-to-Time-of-Use race the Sashiko AI review of v1
    pointed out - the new bound read qsdev->report_len once for the check
    and again for the memcpy, so a concurrent update between the two could
    have overflowed buf with the checked-against-a-smaller-value length.
    Read it once into a local and use that for both.

v1: https://lore.kernel.org/all/20260806133838.3378362-1-sammiee5311@gmail.com/

 .../intel-thc-hid/intel-quickspi/quickspi-hid.c  |  2 +-
 .../intel-quickspi/quickspi-protocol.c           | 16 +++++++++++++---
 .../intel-quickspi/quickspi-protocol.h           |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

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
index cb19057f1191..9dacfdf7aff6 100644
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
@@ -372,9 +374,17 @@ int quickspi_get_report(struct quickspi_device *qsdev,
 	}
 	qsdev->get_report_cmpl = false;
 
-	memcpy(buf, qsdev->report_buf, qsdev->report_len);
+	/* quickspi_handle_input_data() updates this from IRQ context. */
+	report_len = READ_ONCE(qsdev->report_len);
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

