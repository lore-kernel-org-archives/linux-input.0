Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C7455607
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862952; cv=none; b=V7+d7ShKWWKYHIRVAOExNzdLYH8MHcRJ/FE1oxPrBakS/eijFki4A4atJtpb7IE7rVbONV4EvfD10dI66WkkShUCKvSItiJsvbmY2vTNYZyNTk9n3qQcR9xy/nGfaoPBlArUxWak60JGsreRSbTc2w3MXfFytxjfDWPO1yABh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862952; c=relaxed/simple;
	bh=t2Bum7GpUEdOyjJeHInjV042qhA04/3uM5P6PudeGd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDw4+sDyJsPHsiKinpNQt8893nmt2K3UQTYrJrac7/AGknMdRUJfbV4h1wHGRXzm7K4Z9ykTePWrS8jsijh/5qC438Iz4iMX6txws2Yf/1G2r4wwHhQPudrbovBjtmdrLRVNA8Jtxejyzf7wLBnEXA+ODXFFUZA+FBDU/0Ikzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5rw3nli; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5rw3nli"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3115c4451c8so2619863eec.1
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862951; x=1792467751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WE6Vuhv/fDlAsuH6U6LTbJbfMX4hUE168v6aPJguThM=;
        b=V5rw3nlixE6Dw1mMRaZDMEG2Rdj2yepUVKmxY1sXheLKIkVBAvmyFzBE/2OPVHKcD6
         VxLR8GJztz9lTMlotx9RtwnvTV/Pyg1sj4nq3A7X3v7W1fIDjqvGwTQmOjwnigEsy1Lp
         pQ8YPzy/92C2VtjGrIppTuHb8mKt4CooPfN3LgfAe1a7J8YxRur6ZqW7vtDeqqXQWGHp
         foIa7vF97yVZFO9VBAOD/2D2AeNC4AKorLhb9yBHew5wnNvd8hMTXsoDbSaSI0cx9YUM
         5CcoOJtOEarmGVXZmI3wBQ6oZwnWUqzzoPznJRADrwHiXOTqfiVrhYKLG/KE6I0xveqq
         JpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862951; x=1792467751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WE6Vuhv/fDlAsuH6U6LTbJbfMX4hUE168v6aPJguThM=;
        b=Xr4QAdtOOpAo/7hX0WO6VMRE3k/SJy7Y+F/x7hnSNBe+/3DsXOWrjVeZuu4dHbDLYa
         acqyPcvTGqWAy7hx9pcrsbSOBq/L8IrZ6j1sSDmQTuywNBwWtpEWJhHAhAZvVN/rAZ+S
         /+QNpAa69o00pc2T47/7KturexL/BcLlnaizy4LEwNN6/IqCKzJxMZo7eITWrmR+R59V
         9wgcosiFVETw9rqQ0cfGs4cvnt9UQ/Q37ZO8Da5d8l02Qf+Na8MzRXectdz+ynKJxa+A
         rjTSMOmWk+uqFFEBWoJRkRM7JLBr/AZr8jHbjNRoyANLldQ3LLTqFST45z3Q6xrTivUT
         EerQ==
X-Forwarded-Encrypted: i=1; AKwUvBy675i0Qs9fwCM+QpqzmCSvq+hoABQKZ6lWkznFYaaV1eHpX73qBd87kllyWCV9ohy+5k2YRUXNqn5HiA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJjj3AaCvZ/51I+p+WzBc17isrE0ik5+3FOSw0Qt3MiGHon1seW
	lJw4rlGCTn1J+h8hWNGAjRkmJhVAr3eYAMpJIr6GOUZCvto5WX/6RTtv
X-Gm-Gg: AYBFou1hDdj4dMeioWTcsNexr4m+sxg0jFxQpTjWzBhD8skOyXaO+6TJMsmCH1xg8as
	lruJLWDljNbku9QxeeoN0IaLF3oh3z2I9oTk+Tac1Wohqp9nOWT2o0lXlRwqWGqa8IqlYkrfl4+
	c+LoJCgAOXh+mO7b0eRuqQ78bHYhnqxcxToe699l4evnKmA0rRu3Adt20FBD8i6qLeXbDaIxwwd
	bhArFCFKkTbTM6lLv3++B+HO4L8tRwAuztyU3MzWOhK7HxX9mLBDeFTl4qmFm0ORQk+SPCHKKAH
	0R2CW8Qt+9Rqb4tVovQb0WQccaJegG6lO0/VTZhYCJyTj21nQQFID+1XXiOLRjOBA8o0R2cSzR5
	qtbFW5Su3TG4O10ZudZo+7hzJG4Hh4xp938RrTrAgXIn71fFo0Cq2nr+l/koVsW5H5XxKp9uUwl
	blnMFpfUBBly575zP9aS4zdyGOKbP/Al+TO2ZiocBxXA8v1Aas8zSJWnqxcDt7diAQdhbgRMqd4
	A4SVDI3muFn0eNmC92DryVyFui5vdEZNyP+J+Y6R048n7vepnkFYbycc7Ij2fs=
X-Received: by 2002:a05:7301:6794:b0:351:606f:2832 with SMTP id 5a478bee46e88-3537df77e03mr21347424eec.3.1791862950452;
        Mon, 12 Oct 2026 20:42:30 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:29 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:20 -0700
Subject: [PATCH 4/9] HID: core: Validate GET_REPORT report ID centrally
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-4-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

Several transport drivers and device drivers individually check whether
a successful report retrieval response returns the expected report ID.

Centralize this check in the core HID raw request path so that all
report retrieval requests verify that the start of the returned buffer
matches the requested report ID. Introduce a new quirk,
HID_QUIRK_IGNORE_REPORT_ID_MISMATCH, for hardware with buggy firmware
(such as the ASUS ROG Flow Z13 touchpad) that returns mismatched report
IDs on feature fetches.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c   | 11 ++++++++++-
 drivers/hid/hid-quirks.c |  2 ++
 include/linux/hid.h      |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3a9bd56dbf85..cd099a420b9b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2565,8 +2565,17 @@ int __hid_hw_raw_request(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	return hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
+	ret = hdev->ll_driver->raw_request(hdev, reportnum, buf, len,
 					    rtype, reqtype);
+	if (ret > 0 && reqtype == HID_REQ_GET_REPORT &&
+	    !(hdev->quirks & HID_QUIRK_IGNORE_REPORT_ID_MISMATCH) &&
+	    buf[0] != reportnum) {
+		hid_warn(hdev, "mismatched report ID %u (expected %u)\n",
+			 buf[0], reportnum);
+		return -EINVAL;
+	}
+
+	return ret;
 }
 
 /**
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 96a36c5ba04f..0ea592d1c9e7 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -37,6 +37,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AMI, USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_REVB_ANSI), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO),
+		HID_QUIRK_IGNORE_REPORT_ID_MISMATCH },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM), HID_QUIRK_NOGET },
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..8f5e485b1351 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -388,6 +388,7 @@ struct hid_item {
  * | @HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE:
  * | @HID_QUIRK_IGNORE_SPECIAL_DRIVER
  * | @HID_QUIRK_POWER_ON_AFTER_BACKLIGHT
+ * | @HID_QUIRK_IGNORE_REPORT_ID_MISMATCH:
  * | @HID_QUIRK_FULLSPEED_INTERVAL:
  * | @HID_QUIRK_NO_INIT_REPORTS:
  * | @HID_QUIRK_NO_IGNORE:
@@ -416,6 +417,7 @@ struct hid_item {
 #define HID_QUIRK_NOINVERT			BIT(21)
 #define HID_QUIRK_IGNORE_SPECIAL_DRIVER		BIT(22)
 #define HID_QUIRK_POWER_ON_AFTER_BACKLIGHT	BIT(23)
+#define HID_QUIRK_IGNORE_REPORT_ID_MISMATCH	BIT(24)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)

-- 
2.56.0.385.gd3acb90ef8-goog

