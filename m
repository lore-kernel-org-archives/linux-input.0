Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47E43B491
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782811; cv=none; b=B+0AnqscC3BXb4+JYts/6GcN0k+Dkf0YxlUKq8xG3aKBm5w+Htbqv1rbzPCKIJelOPSUhcQ/uyzRd1PD4NzkSq5H0DvBstUojAamDaULBBJQpbRTOq3w1M41NjyUO5QlhaXEz4d6oN54NMApr46yJTBSulhESx3dEhmupS712NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782811; c=relaxed/simple;
	bh=qaDSk/5YmV6gZkAdMcHZslIzINZ+ip8Z1U6jUiEQCkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1zMJnp7EG0fiholfg0r7PTC99RT2/R6GhUWH5OYG+1ZKmDpz/hv9x8Dvxv+74hdv8cBAdEA64v5rWCzQnxXKoxDxNiP//TUGVyTSVgmEwFkKOQP/eZJNJOiKXjQ4aVo9yxGu9VTOK6z7exY/xnZRpj7+PUIfvo2taCE+oFIhAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UojGgpTM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UojGgpTM"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84874b52eabso5081507b3a.0
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785782807; x=1786387607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SV2MN5jqx3aqjs62FVvaU6OUodkPbSGwRNX49TcVWl8=;
        b=UojGgpTM/RbHpng8Ahk0hkgXYtt8tzAjgnARt/9zR+NwwlkckcQqZr75v83wYQE1Gp
         dAUDPpmrll1DayJ7j76N8Cy9s83PeXQxzQiDxsm5De2lQlYrmWcTubiNiUILL+0iWCHF
         vbbrnIl1XT0tRyBpsi9j2ZtSR5SHibg9CIGgkNv1+5Uf0fXq8FBS3P/YohmH1/oBFebG
         GikzNLZAgQZClMdDqqBuYijnGtoS3b6HkjnWcDTF1HZUmpHFQ5bB+mSe3t2DPSacWsRq
         Qnn9Q3HATVGejorrtRczdeOEhT4dBq4R4zVU2cVRYGzt5mFwexYInmt4E7/6PW0kzUa2
         B4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782807; x=1786387607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SV2MN5jqx3aqjs62FVvaU6OUodkPbSGwRNX49TcVWl8=;
        b=Odl2+LSXeLjIV6lykrdy82yHM1sQEkTcm9qpJc/+mVszuY3D2Z7bo+RzfrM6v3VlC6
         U6lBzCIVtDYuC5XG1gmjpYitVf0TTotykKcuxPz9g88uuwBdU4U8rSOvjNaGBkkXm6Vf
         F/1uJHdZjm1TEEwcvHiOorkwhVD9BOoEMFANQ1T0NTs757dEr5My7mpu4IwHixgkaXA3
         758wMsVzb1vtJ6xDObqUdPZWhuCFZhvwQyzwa/2NdL/chdPMm20rRqB3VrED0CGYl5vz
         2Gd0TX+JdGhLDER0lpWt3EmYSY4eEftpRiTcv/zKgL+7slZz7fTh2LF2qDDzvMPxpWA6
         zceQ==
X-Gm-Message-State: AOJu0YweKt+FyK5lv8lpaVc3VulUb0htW1rap+noNOs0RDJ5WKLTULzB
	xU1SWBL1iDx5bdKmKEtT9gfwdoAn1CfxrA+AG/reATXSU+rpq2cbMotU
X-Gm-Gg: AR+sD10WLCqH73nJEFhst805soMTV2xrs4Nk/qmTa7ViLbUu+/Exr7YfYbDuisXlO4l
	s3dTYPvmqk564WOAo2fQgOKXNRyErftBj6k1BAwWm3pRU2F8Gw94aOd4N+/TtYhl1WTCCo43yHl
	6PSvyHMPdTc/IeQdvhNSTkKxdQB9vIDDZ02Lx5yjIWKwlK4Vnj9KE3boazb46Dv4rcY+/jkAwKx
	TvxzSjxwwojb3CcQFZvioUJJXmdOZ9dUrHLyiJmXGC9kYKluYtnfTQJtwWPbGBmgzJmS9C2Df+E
	37UVTG81B7EmfO9u3jhU4D0vYa0up5bqk1I70OqmdhPdNHfikpRfCOHtx1bAmDdbitj3rCQVXPV
	X/FLMZjY3CTvLT8J+4qKy4eAYVOFMlsmP7pAbRFn8RZKHeY6nzGKMx1OD9vw3tQQ0B5oicoqDJ2
	62CPy4FFUO16XtvWV25vNYtio4Gqtf+fhCy3nIbJhwRF6Y7ifwLa/8H/VBCHX2gNwIn47b53S3C
	u7QS9vaSQPzdgd8oYv8rJ5T9TjpcvhV1yr6b4yHfQdwVM3omcVL
X-Received: by 2002:a05:6a21:7002:b0:3c2:dcdd:a861 with SMTP id adf61e73a8af0-3c92a85c953mr11789820637.43.1785782806919;
        Mon, 03 Aug 2026 11:46:46 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab24ec10sm33935472c88.6.2026.08.03.11.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:46:46 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 03 Aug 2026 11:46:34 -0700
Subject: [PATCH 09/21] HID: stadia: use open/close to manage workqueue
 lifecycle
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-hid-ff-input-configured-v1-9-1dc9bbacd88c@gmail.com>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, cocci@inria.fr
X-Mailer: b4 0.16-dev-b242f

Override input device open() and close() callbacks to enable and disable
the force-feedback workqueue item synchronously.

When the input device is opened by userspace, call hid_hw_open() and
enable_work(). When it is closed, disable_work_sync() ensures that any
pending or running work item is cancelled/flushed and no further work
items can be scheduled.

In close(), zero out magnitudes and issue a final report to turn off the
rumble motors on the physical controller before shutting down transport
I/O.

Pack strong and weak magnitudes into a single u32 integer using
WRITE_ONCE() and READ_ONCE() for atomic, lockless updates.

This allows eliminating the manual 'removed' boolean flag and spinlock
completely.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-google-stadiaff.c | 71 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/hid/hid-google-stadiaff.c b/drivers/hid/hid-google-stadiaff.c
index 6b38d2421d3d..d6a73d210599 100644
--- a/drivers/hid/hid-google-stadiaff.c
+++ b/drivers/hid/hid-google-stadiaff.c
@@ -17,10 +17,7 @@
 struct stadiaff_device {
 	struct hid_device *hid;
 	struct hid_report *report;
-	spinlock_t lock;
-	bool removed;
-	uint16_t strong_magnitude;
-	uint16_t weak_magnitude;
+	u32 magnitudes;
 	struct work_struct work;
 };
 
@@ -29,12 +26,10 @@ static void stadiaff_work(struct work_struct *work)
 	struct stadiaff_device *stadiaff =
 		container_of(work, struct stadiaff_device, work);
 	struct hid_field *rumble_field = stadiaff->report->field[0];
-	unsigned long flags;
+	u32 mags = READ_ONCE(stadiaff->magnitudes);
 
-	spin_lock_irqsave(&stadiaff->lock, flags);
-	rumble_field->value[0] = stadiaff->strong_magnitude;
-	rumble_field->value[1] = stadiaff->weak_magnitude;
-	spin_unlock_irqrestore(&stadiaff->lock, flags);
+	rumble_field->value[0] = mags & 0xffff;
+	rumble_field->value[1] = (mags >> 16) & 0xffff;
 
 	hid_hw_request(stadiaff->hid, stadiaff->report, HID_REQ_SET_REPORT);
 }
@@ -44,19 +39,41 @@ static int stadiaff_play(struct input_dev *dev, void *data,
 {
 	struct hid_device *hid = input_get_drvdata(dev);
 	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
-	unsigned long flags;
+	u32 mags = (u32)effect->u.rumble.strong_magnitude |
+		  ((u32)effect->u.rumble.weak_magnitude << 16);
 
-	spin_lock_irqsave(&stadiaff->lock, flags);
-	if (!stadiaff->removed) {
-		stadiaff->strong_magnitude = effect->u.rumble.strong_magnitude;
-		stadiaff->weak_magnitude = effect->u.rumble.weak_magnitude;
-		schedule_work(&stadiaff->work);
-	}
-	spin_unlock_irqrestore(&stadiaff->lock, flags);
+	WRITE_ONCE(stadiaff->magnitudes, mags);
+	schedule_work(&stadiaff->work);
 
 	return 0;
 }
 
+static int stadia_input_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
+	int error;
+
+	error = hid_hw_open(hid);
+	if (error)
+		return error;
+
+	enable_work(&stadiaff->work);
+	return 0;
+}
+
+static void stadia_input_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
+
+	WRITE_ONCE(stadiaff->magnitudes, 0);
+	stadiaff_work(&stadiaff->work);
+	disable_work_sync(&stadiaff->work);
+
+	hid_hw_close(hid);
+}
+
 static int stadiaff_init(struct hid_device *hid)
 {
 	struct stadiaff_device *stadiaff;
@@ -90,11 +107,13 @@ static int stadiaff_init(struct hid_device *hid)
 	if (error)
 		return error;
 
-	stadiaff->removed = false;
 	stadiaff->hid = hid;
 	stadiaff->report = report;
 	INIT_WORK(&stadiaff->work, stadiaff_work);
-	spin_lock_init(&stadiaff->lock);
+	disable_work_sync(&stadiaff->work);
+
+	dev->open = stadia_input_open;
+	dev->close = stadia_input_close;
 
 	hid_info(hid, "Force Feedback for Google Stadia controller\n");
 
@@ -127,19 +146,6 @@ static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 }
 
-static void stadia_remove(struct hid_device *hid)
-{
-	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
-	unsigned long flags;
-
-	spin_lock_irqsave(&stadiaff->lock, flags);
-	stadiaff->removed = true;
-	spin_unlock_irqrestore(&stadiaff->lock, flags);
-
-	cancel_work_sync(&stadiaff->work);
-	hid_hw_stop(hid);
-}
-
 static const struct hid_device_id stadia_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STADIA) },
@@ -151,7 +157,6 @@ static struct hid_driver stadia_driver = {
 	.name = "stadia",
 	.id_table = stadia_devices,
 	.probe = stadia_probe,
-	.remove = stadia_remove,
 };
 module_hid_driver(stadia_driver);
 

-- 
2.55.0.629.g250fe7f194-goog

