Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636015;
	b=CvmFWAd3m0DSZ10GhpZj1FTO08iDKXWw06HFdo3iYLW2zJsq+4UQ/d8PwGkWwvBbnnmQ
	 jN/H47cM3J1TJZ2GoGcL5AVZpyyxp5tPNC+IYCks3RkK9VhznTJ2oMpTgRPVTzaxbSBbe
	 ZPpeniGN3n2+mSJQlUVE48CavHdm28joB3uDQqttu+NcmuZKMJrgVfiDSMfX1QpUZAFo7
	 hhppEVEWYLTfyeoRTDguHSjhDgznOGAnSO6WXR/oxiXK7ypKJXWRPTngisC/4+Flslw9B
	 8gQe0XxWaJ+U82zxU2xpoUIg06OYt4XvxbC/snjx046c7+l1h/yO5fKjKxH8bexj2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=CVV/alUGMc+8ghh1WdWVQB+EmKW8C9wgdGmwYrZy3oc=;
	b=xRJLtz7ZHeQRbErmL6XbGTGPqmWG26LDL3Km72vfvqUCychc3Tk9fsxaKc9UWkmGdRnB
	 hb+b2+Bs4Ei8DRA15sxB6cAq79OlwrWIBCBBWRQsBRBZixEJgF5G25CJhnJUIdrDAx/he
	 FqZ6zy3pPV+pBiJhU6OHx1X7ocPmuheiJ97Ok6+PMCEMMCo4XoQM3kX9cdqLFJdsnP7Js
	 ZOvHRrTKqfhOS3NDBsNakIlE7tv52cPCI+nTRKzYXvsTmTWwp1TBwWJg+IRgrA5kYU/6P
	 W3pjv/P9A0PFkyMETfyWzDjuFKoFW9xhK8CQnpfJ83xKx/ZjcJRNad4F0WRQrCv18og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cr20jhil;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8860A3822
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD8860A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cr20jhil
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3791619605cso3502178eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636015; x=1795240815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CVV/alUGMc+8ghh1WdWVQB+EmKW8C9wgdGmwYrZy3oc=;
        b=Cr20jhilNZ7CAwk+cpzndN3BncQScYEgrw4SDUjVYHvVcLMYO1fO0sSIuom/3uukFE
         bZ4zoeTQvMIYtWF1SHnYClirqPC9DMKakrTYZnCQS7KDgJ+3xDg7ZV03OWqHtl8xj7Ra
         GqtO42MrfC9CiZ/qjvDIaOunNWutyOAIXKFLLmaeZuPf9eYmmmnDI/pDTclWbpW8dLDG
         5bivm4PcuHpSAYJYBsJaLa6TEicthy4tjOHzklKyM8weJu7g43izwB+uCMWeGicig48n
         X2p7UWnUZyGSnoYAjDbgDNlDiDDdj5v94cWQTr6MvusPzUBmoUqb46MrG5xIUujDKY8u
         azCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636015; x=1795240815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVV/alUGMc+8ghh1WdWVQB+EmKW8C9wgdGmwYrZy3oc=;
        b=zFQs/3sgK0MpAoHeiVD+3mub7/3lOgtdQYU6vWEjjbb8Y0SU2WCEzlFuRZsUEdxG5C
         bb4LRqJosYZldkOJ0DfoD2KgMGzd/YsoSJJwlevtp8uUlCIIhSv8WYmHUxCyXjfkcOE1
         h3iy9hHGxLwI2AZr6YIUEorPc1ytvft4xTF+ua48AL2usq01U7yZvw2mddY1WYtmc+rF
         4h4119A5SeoQaR6YJjoyDO3nvqGgzd6FV+dhFPYofFW0j4UR57zu4RvZEepZXU2mMtZB
         4kxXlkv7zOB7hSML3mKtb0Nl1vSQp4lUxE1Oft1NtwRYexV9u0Bai3cDimRJIPwGuVxw
         TJAw==
X-Gm-Message-State: APuU4Z/TTgEoWWogkW+7gsVhLo9+uSkQMwGarB12/6Sa8ApHV6fCEbQf
	Mr1MOeEfTswaZ3pgAfLTaahW4QiA1kOrfURqdFVoZBg3IgaKRABLs9lY
X-Gm-Gg: AYBFou2+c4KbIw2q6WY0r4uiBLemyb+CvLEsNkZM91hkCMBshlqKRjKCHD77z02r3XH
	zXNF9b3WBoPSk/3VBpGaqZSqhZHMN+qKIPgmHRd4U1/KAlPjeKsSuU9ThGA5c2cVL1oQjJlrqbf
	gWtq7ZmYLDYJ8jv26ZAWOIaVhOPtdirzOT2qb3U182o9yvQo16CUM08FCVS0zrI3jOVgCTKcIp6
	IWsEmwKGSFpCUSgbzgqHISBEDZRaPqpYqow0TFHlZxHg6xddrVVSQz7gqllGfe+llaCuR4ZxsVS
	2uTSiIdnt3aY+Cjd/8DMYQXUVPi302CDthmcKNXrzYY8J/GKzLhVQGH4xYiGikovPPlu+A2ol4O
	EcH0zoEIytkwK9hiZGM+9BfMH0xwafo4zI3VhbhngX0pIPyJf14q+aWTIc5T5UtEbA3tCNVND3T
	EkefFSxDBSLrQmHR/wWeokxDsfYepLui8JeUxoWgT4UU2n7y05xZAMyG49gBx0fyF8sppCm3n7u
	QLVSbf/yMPSur7kF4m1bV5hj5n9vfagXBAH8oi2ct0QMa1Srkzngs5jUFWz0T6hJQKK8lUf3+AF
	X5tNLXB7PnFC3K+wecLc7tX9q8t+0Ju+OJjrLBm0SHybsB+fdTHukHA02Oc3UH8Ufdnhz7BJiSf
	MADTnfWv1qcOkRiwi
X-Received: by 2002:a05:701a:8148:20b0:1b3:a89c:c456 with SMTP id a92af1059eb24-1b5030627f5mr4240331c88.6.1794636014438;
        Fri, 13 Nov 2026 22:00:14 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:13 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:59 -0800
Subject: [PATCH 09/12] HID: rmi: use scope-based cleanup for mode feature
 buffer
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
Message-Id: <20261113-hid-rmi-v1-9-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Manual memory allocation and release adds boilerplate and complicates
unwinding on error.

Switch to automatic scope-based memory cleanup for the temporary mode
configuration buffer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index ad2ab6c13550..f1d52d55fe0d 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -144,17 +144,15 @@ static int rmi_set_page(struct hid_device *hdev, u8 page)
 
 static int rmi_set_mode(struct hid_device *hdev, u8 mode)
 {
-	int ret;
 	const u8 txbuf[2] = {RMI_SET_RMI_MODE_REPORT_ID, mode};
-	u8 *buf;
+	int ret;
 
-	buf = kmemdup(txbuf, sizeof(txbuf), GFP_KERNEL);
+	u8 *buf __free(kfree) = kmemdup(txbuf, sizeof(txbuf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = hid_hw_raw_request(hdev, RMI_SET_RMI_MODE_REPORT_ID, buf,
 			sizeof(txbuf), HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
-	kfree(buf);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to set rmi mode to %d (%d)\n", mode,
 			ret);

-- 
2.56.0.679.gc527c65306-goog

