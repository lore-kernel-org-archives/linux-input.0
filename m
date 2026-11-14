Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636003;
	b=Qy5ab35aE1JmUrDZ702JZaz5T+8E5etcT7pvJM9inBn6Mxyd0X0YExNWVLBqZNoZmftC
	 357YdiafDG69Hgw3knv8H6G7hTqKQt5M+DyJYJi2UZYSAgeD8Y/m+d8/oEGHgmW4z3KR0
	 GP810rLhBOasYJmBFe5mFeKLSbQ/i+W/XrPYMPCrwIZoFPKnEVI8xjlHVJQda2jI+t2x1
	 wAdFZDPxRduL1E9qaPpvRiOYPTOEN3Y2Ih7c7wioLXpt+tIz6DPHDx3j205d/TT2z6+dL
	 OGJL/cvV7+1J1OBLdmCCrlT/N3A1nEdAsaUi/2Uf5OO/Q4uGICqkbkwUJXWjgrpxwKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=mgLVCzwEEWzs9CinX/+7QiADn4eqTPW4ogsrN1nMB7g=;
	b=CCkHpHTAjnLXNxP2Xz9jK29QT1V8oBgD2oiDOR+hA1Zy3olFkN6Qn8dFyQlqUiZ7kmws
	 KixlYi0wJyAn+bneeAq518TV5ja+EQ776jY4KgF+7ZM4y05qYAt7l0EntRjmCy8GzuNEf
	 ucR0m1HRZwVbiBqYtcbsr59148t421Y6Ig79sGDe/a0a9UHgxKbvbDMomNkaYQ33GQGuF
	 +u3Bio0hs20hu2PhgkbNVknWZjJbaDT+99ez8ZnGgNhetKHfdto0AR5wdkD2urRDc/e3y
	 iOrOFxLHm3Htsa9lZuzTvkIdpt+Z4hZigbAEgbdopXF2xr62lE1kvNbVtpDQ8Ad6XQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pSrzRYDo;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D0606A337
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4D0606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pSrzRYDo
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1260712c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636002; x=1795240802; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgLVCzwEEWzs9CinX/+7QiADn4eqTPW4ogsrN1nMB7g=;
        b=pSrzRYDowsSSYc1//w68QUfa2cBuROaP0oEKgpP7Y57cArUc6zvkzvkyZqwMuEv9fA
         AZ/sg0KYTwtvwIIx0zNG+HddOk3r1XaXVVuEvI5g16eLUZbvtXrC7e9noqjvtpYWi9+8
         43QXMP+y7OOZNLBTUp5ZD8Of5l5KPUqFe6HSn5Y+/nvJP9FHhZEafEnWbKbbtZkiENOt
         jEsHVOPwodtfYqpNAFgmBb+HJdDFD3NqImpWhDhWnlSUkaNgeP8SlInhCGEbsX6OOOf7
         ZFa29cdHdgkSJ7VOAQot6bb10atZtCzrmNW1Kz+l/yYfV7+N8ycHzWoQ44b12aptUjGM
         stnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636002; x=1795240802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgLVCzwEEWzs9CinX/+7QiADn4eqTPW4ogsrN1nMB7g=;
        b=jgaOXXqXlNBri8qrB5/Kp/5YjAphA4mX51GaCn4h1rSkTzRTbDX+20Kuhvo5rCSw5N
         4vwIqyCjn+m27Scdo8h3YOE2wwN34NtQd8e6Q2/3XAGTLst1PaljhKGbIxhDYJjhy2hI
         r4ACWOnYZNR69EbQUKug2cny03/awgXYg9CFmAqlFd0P66HWN+fSIF4DOZOSSGWK7Rfo
         iSmyHb9tdxONYujPg7P/BMz4u22yQX9rtySIgQ9BIiz/c5+N4trMivMp6Gama/+N5yc4
         ZwLmvj2D0kr9oiDaZKrhp+w74OHyyd9dAcxfVBIuWliV/MMwoTH/ndLxNwfJG567+Yiy
         D0+Q==
X-Gm-Message-State: APuU4Z/93vn2gca9jux1VFVGL9emeEsJ8Rv39Y0XLfgFSk8J2irLN/HD
	X2nptOms2g8eE7npUBHqtZmC+28WQf7LMhAEpKSZ+hqalGkjoH/eFDkB
X-Gm-Gg: AYBFou0d3dhajcvXMAE9at5TUd+OwftF3pKpzfLLM6hwQcdmG4UaVWhUB9Z0IevkUad
	1QTPCR4oGMOTEqdawOz7+5bL8RPKSlxMoqWKkXfuZhVv697DcrbmSgNulgR7N8LCufPGsGmhdLc
	1wFpxk9iFk8ll3+90P+cvFQOcoVl05SiKzQKYAD6QF/ZErB1vzW7GNTL+WnaK9FUwXMFNzGqgOA
	sIlmxy5q7lkW+NEvoQDxL30GJGa8c8NLWLtCFPhS8naOVHJhXjeEBN3BdDegyhj0lRRJ/WgVcGl
	3VBiXaX7DOY0hgwMxnUBQpw5pSWEtTKiXDmSW+2WO21IfgboHlEtEN0DqHcPl1Uee7ZhXZ+DQu1
	I1W1oKjjS56i4CVkIWbRxsbOX2EuLTSH6atact93GG8cm97Ae1UkBJP0oIGGrDJ+jWgQ5QkvzRc
	kdwx/f2qAbQy7WlcZTW1jX3SDW6fy3Nw09SlJunFuMIfVNZnvbyKsAHa8oi/1HreW5mDLxNNdhe
	8JVIrxXfgg5L0EORqSiUTFnEL+vvA4SwjonPZpqHPwlzycyjT5k3ubUvUV6DNPoNiLQnRrf06O8
	gafan4JxRhdMMLMvXgCLyjWHrEyM+gLgeT5tvwieq6JerQHnMGBxqGqriwBBz/GCed67PEne6D3
	JqqDw7FscGmgxl0Y7
X-Received: by 2002:a05:701b:4551:20b0:14e:d0ba:75af with SMTP id a92af1059eb24-1b50308a20bmr4240827c88.6.1794636002333;
        Fri, 13 Nov 2026 22:00:02 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:01 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:51 -0800
Subject: [PATCH 01/12] HID: rmi: return error on short output report writes
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-hid-rmi-v1-1-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

HID output report transfers return the byte count transferred on
success, allowing short writes to either be ignored or propagate
positive byte counts as errors to callers expecting 0 or a negative
errno.

Treat short transfers as -EIO errors and return 0 when the full output
report is written.

Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Fixes: dd8df28459dc ("HID: rmi: Add functions for writing to registers")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 20dda1992f98..cacf81ed56a7 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -130,7 +130,7 @@ static int rmi_set_page(struct hid_device *hdev, u8 page)
 
 	retval = rmi_write_report(hdev, data->writeReport,
 			data->output_report_size);
-	if (retval != data->output_report_size) {
+	if (retval) {
 		dev_err(&hdev->dev,
 			"%s: set page failed: %d.", __func__, retval);
 		return retval;
@@ -182,7 +182,13 @@ static int rmi_write_report(struct hid_device *hdev, u8 *report, int len)
 		return ret;
 	}
 
-	return ret;
+	if (ret != len) {
+		dev_err(&hdev->dev, "short write to hid device (%d < %d)\n",
+			ret, len);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
@@ -216,7 +222,7 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 
 		ret = rmi_write_report(hdev, data->writeReport,
 						data->output_report_size);
-		if (ret != data->output_report_size) {
+		if (ret) {
 			dev_err(&hdev->dev,
 				"failed to write request output report (%d)\n",
 				ret);
@@ -300,13 +306,12 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 
 	ret = rmi_write_report(hdev, data->writeReport,
 					data->output_report_size);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&hdev->dev,
 			"failed to write request output report (%d)\n",
 			ret);
 		goto exit;
 	}
-	ret = 0;
 
 exit:
 	mutex_unlock(&data->page_mutex);

-- 
2.56.0.679.gc527c65306-goog

