Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71914430B85
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772341516; cv=none; b=R5DtuXR2Cg92UMZJq5DldH+oY+zfBVLRj1purl1lZw6YUaNQxRWi/0QBzaqCrrReclG4mum2YB/3XXEHpi7kFhO5bW+OyhV+1t/RdMFV4eeAsCDbylOGOenpbluRJMXo8orwzwuIh3fGd1yf8XTCDsAJP7fwy8zT7O6pqHvNUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772341516; c=relaxed/simple;
	bh=yHi0dcVwFnZ3408WTHv6DayGAPwkBF8w98C0UNjcaRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y5U4DlzkqoME5pEX9yCSkUMG008hKrnxjojRPZZINWvlaOjjhL3ycLXk0oHjylvLFt8kILAKh92ZgC/jceBBLi0psVXEQ7Ms5TtflQCCi5tPZyUzFXdTWN9fEaDwAqeUWca9w92GOwWqtnoYMK4m/nDGXu9QTti1vhXU6B/FxWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j97ur1FW; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j97ur1FW"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be06c02f66so550454eec.1
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 21:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772341515; x=1772946315; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCOgTXBl3ExkHQ5G38a7ch0w/W/MqPAXecK622QLvnw=;
        b=j97ur1FWqya6Vt02AS1Kv6BtXvgMAVl03qVr/NtsK09fEyTFs64NCkw+UJXEG9P1aT
         Ca1394JTRsb8+lGAepNABSTjYd8FZWvH+W8pFUfHvXtTDS90AMRLarnNSjoUJNDWS6dm
         6eUkAue8O+XilenZnqcMlVRsz9jiCNXZFpgz/PVDQsam4pSPSDO3T8JPheW9W481cZra
         Ga4NPSis8Y5cyS2ZAXXUeTuoQqORNrHkTGJoxq1jTRFYE6wAe0zqg8qEx92U/tYKAWNU
         HUz+50dtecp1OKBj63zgn6aowZgnpPz3VNerN+2Y0a/oMA3hACCmVihiCh4qE467FujW
         +OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772341515; x=1772946315;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCOgTXBl3ExkHQ5G38a7ch0w/W/MqPAXecK622QLvnw=;
        b=JWbjScr6gLNx/qAXHVR+I+xWwbjXU3PaLL8oYCvCrKFIWf1VARUh61Enwkfp0xGi1g
         1tn99la7AP2TcLGc/Qnfj8aStUnuiKo5V0ho2q1ngFObkKDcPFV/SIinqt33ofoPLmUl
         Mz15z2kOOnjppByQF0p/EuDbbVX5Nvxb0L9+gYFYTIpo4u+GsiH1HytYWAH1FIeWx5A/
         wwTJ/qcjzrEJOqM9EtZtAL5Yy94roKwi8+2qK8EMciosju1xNx8L1Lri4/rp4IJpzPNZ
         jJu9SyULr3qnactuWY7yBiw+XX0F+3Wmd1A15+MpjflfEUkeBURflzc2lQ9W91pg4X4p
         +5kw==
X-Gm-Message-State: AOJu0YyZZDlLkztvh38ZpDZ7W0zDdrD/U+8ayv0GQhyWHzaRIDWm4bAd
	pyXPxUnAXDXFWdS55KEFhw81LYkb88eZnwZSdI23Lf5rXhsPQ7tTG7ergajf9w==
X-Gm-Gg: ATEYQzxn1RFojuyRxTKHC+LrGM6qyAxf/fGD89lKryf+ODug9VMjYfKtH3Xia61c6qX
	Vgh8jMMkKJy9RSkNHjbcvJiftVmGlgiGnbsjUz5ajD1uKLQE9BLmUcSYP7xyFGxvfKP/qAz32ZW
	OxpVndDUNcVqiuBvUmsolCaCX9Slf4hdZPtLWLoZM5jSgwUqXVL6a2bTPapH9hZ8ml1XEs3uUs3
	INSeUAMPXCmD9b79vPzzUWYVDMlgcjcM4XOp2WfAWjPpNvt7Sb0HtQj2WglIImsEpfs2QqUNk7q
	9Sgs3cQNJw5oNBNDTjk8j/vLb7ReOAol209fS98YvHImW2rm1Bb+XJdqqLmcYmUyZfaQC+NWIhv
	LCPO3oWpdoDGw0IWulTNYwZTUq8bpZ45FSCO6JRSxC7tC+HZSxbFWEdFCdYWWfcTeDeCb6vgsjl
	k7h0K/JcIOiTaXH8ocakM4hJLOvkLHUcHeJBzgGiGdlq1kzsAu1tm7hX38ske9ttm+
X-Received: by 2002:a05:7300:bc09:b0:2bd:de8e:d734 with SMTP id 5a478bee46e88-2bde1fdd6a9mr3219382eec.37.1772341514565;
        Sat, 28 Feb 2026 21:05:14 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:cf71:43a0:f3f6:e5be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfb3f898asm1813197eec.29.2026.02.28.21.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 21:05:13 -0800 (PST)
Date: Sat, 28 Feb 2026 21:05:11 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: input: use __free(kfree) to clean up temporary buffers
Message-ID: <aaPIp-z92hMsI7J5@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The __free() cleanup automatically releases given resource when leaving
the scope, so use it to make the code less cluttered with error
handling.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2633fcd8f910..9b2d7795c621 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -432,23 +432,18 @@ static int hidinput_scale_battery_capacity(struct hid_device *dev,
 
 static int hidinput_query_battery_capacity(struct hid_device *dev)
 {
-	u8 *buf;
 	int ret;
 
-	buf = kmalloc(4, GFP_KERNEL);
+	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret < 2) {
-		kfree(buf);
+	if (ret < 2)
 		return -ENODATA;
-	}
 
-	ret = hidinput_scale_battery_capacity(dev, buf[1]);
-	kfree(buf);
-	return ret;
+	return hidinput_scale_battery_capacity(dev, buf[1]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -1832,7 +1827,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	struct hid_report *report;
 	int ret;
 	u32 len;
-	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
 	if (!field)
@@ -1859,7 +1853,7 @@ static void hidinput_led_worker(struct work_struct *work)
 
 	/* fall back to generic raw-output-report */
 	len = hid_report_len(report);
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
 
@@ -1869,7 +1863,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	if (ret == -ENOSYS)
 		hid_hw_raw_request(hid, report->id, buf, len, HID_OUTPUT_REPORT,
 				HID_REQ_SET_REPORT);
-	kfree(buf);
 }
 
 static int hidinput_input_event(struct input_dev *dev, unsigned int type,
-- 
2.53.0.473.g4a7958ca14-goog


-- 
Dmitry
