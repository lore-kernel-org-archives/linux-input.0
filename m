Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3C4B1B5C
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.192
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596018; cv=pass; b=pMJQ8xavEsz9pIHtSlgU9r658G7bjHb5da5z3hfzEkO2nwNTxJxnqIt03nh7SmZDeiqOwHHDk0ZNsfp1PaYCWSLdm4iIrYdFqRo2bUKq4IOBLpdhmJXv7SeqTMXUJ5Hr668vrr3IHpJKQf67CTUlVWnD3qRfLf4CDJmCjqPlmj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596018; c=relaxed/simple;
	bh=TAkv1EiTIHzH7s4Ic/6KxfJfuBew5rdbjm529OpwC8s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9oOQRIL4cssbIb3uWnRQO5+NSlxH8yed1kWwMWySkZdE343t4yPtkkDBBIeLBeHiGa+dLYMFS4e/hgtLAVu+OkKkb0S+H0tgLY7H535DCp0lvOqkCRVdNMhK3tnmY4eJiDHb9l7oBIxq+IoyNgmugfmODyiMpvbg5zjGj/7ATA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxbw77U5; arc=pass smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxbw77U5"
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a49b13b745so288955b6e.0
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 04:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596014; cv=none;
        d=google.com; s=arc-20260327;
        b=TxwTlDRCO1x8jD/fpPKZDnB8xE8HapnW1rJ6U4sT0eQCGrh1apQroIQXHZSSXSoQ6+
         E8Qy5bpXoNQoCV7eDNb1WMvbMIWhdCMxcQQRiubvyLU06EpXwzi+3O0zJ6i5tyDdRY2x
         fUO5zgMQM1uZES0PNC4iW1FsDBjMqyg1mTbbgSdle0KcNTqcYzuy2WTDjofIuiybm8Pb
         X9/ejMNuOwUFQ6fQonBQtXREOfs8eeQ8l5uQO5yZfaTVUJ3QtIFT0QkKv6b+T477s3KQ
         xMSVY3Hd+AC96WUALgamVpMrSimB7L3vmiTW9RQQckK51mDPwYoZ7ti3y0p+Ll83cKql
         o0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8q22gsWgg1PAfQFYRgiVxIZbPdMGkykBouJXoalgYbI=;
        fh=BHLExjcBRVc5syVYN/ABiVI0GkmTLvg99SlA2IiKnbs=;
        b=EtfIa87ZY9Gu4/Yq5roAbE6oIGdbOJe3uhkNdvaRqOXN5a2Z8LfWVftVTk32Cg0TLx
         N0eCPuqsGhddPTMSQTyaqycqAKYOiIO6242zxhOn/j/K/cVt0+iv7aLTypSHNBwnQ8D0
         IpOGPQSAbzYOiUP5mtrJMkQOL3FSlyyRUGQvGEPvk++tQpG6qXWJ6IC1Wa18JAtAeLYu
         7WV23ZBsM8/q1R6vrEp0ioH4N9DQnMOyeioq77NaLKxuFnOBXX/Y9x9JmwTZBDlG5OIx
         /NwHlY6M1XtUGW8F2hEMgz9ANT+NCe8zooYi+dPyDhHRQhGW/WhSqrRWZpKdpXrzxgZZ
         tG7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596014; x=1791200814; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8q22gsWgg1PAfQFYRgiVxIZbPdMGkykBouJXoalgYbI=;
        b=Kxbw77U5tHmPyxIyb7qFHh+ulGgh06qbviRBIDw9cfJnRHKgPZVD7aZdsNkvAqGt6J
         4lDCX2GEZKvI0s8ZBSbU59CSG89l9BNzcaaDB+t7IhlbtGpNtLnMQYTYZDspwnaiGRG6
         M7YSjMQ71/cxJOLmIF1RK7oh3ExYGkH7hUFYYdIga8sDk1Gg7lQbp62vG8s5lmAAqCRQ
         7aOrtOjuUhnzzG+2sHIkfLDbiKotrZwMW/yUzhQFUrC8ZUATnDobem2yxgTwoB/VovUd
         aDPUIjTJfNwR3qtU161qrfXmAiigMSPGNZW1TAlabUMw5GMHfZQ4pq2DdfcCNh1QS13t
         Qm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596014; x=1791200814;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8q22gsWgg1PAfQFYRgiVxIZbPdMGkykBouJXoalgYbI=;
        b=P0qxQ+zpAVRf3NUq2fen6amvcu04kv6MBxyOj3lgjHtcAI8ULshYszRiToYoF8Sm1r
         CmY2c4DshsouCxIsucXVbOhUJFQqCNNyWDhEO5OmXMlXxmQhAMDK8RoVQRHZhhGyeean
         2ErA1HrithrbxENw6wjtT7YGMkLwvy8J/FOpV4xY3usFAQmRqST6VZApKUwPY3xkjnGb
         ne6v/TefndJg82d7BGCXyJyKNQOd+YrRdUq8Xce4yTMt96OoFneprXleblE1JYe5FbDV
         tM9ZjMrGE1mYp8fwEsVOUAuicrK4e4WeXLUKiwiXzVO9Wmvfa27Hq4zgThUhdNJd3jLh
         FgPA==
X-Gm-Message-State: AFuF++m+OZGkZu42SnrxXKdo9z3J3KXKcn927OvJPQxUdekvFTWAK87U
	SAMVtdupoC/4ahrsnvSd7N4qsPN2ECx8ooUGp9VcYxA15RU0/fUi6QCalYDJdHSh/DmvyB1kxno
	yRlh9y63u/y3V+jz6QZ6sNWFMfj3nsyc=
X-Gm-Gg: AYBFou2cWa5m8+i48m1HMPJwesiiNmi8t82zhPBtcTSi/CqzXRIZvu019CY1q6qspEK
	si1+wpwht1+HYSSxk7tgYFX78xjKGKb31I0EiC2TB7Xtn5cftJL8KtERhlSvzBk7BjH4JiSSkhj
	5DDQlvt6VMEDzK0PukALsTc1a/NifjUZTbGYthXh4OXYqh9ESIvwFeMTuNukxauRyO6U59K/foO
	aAmQxir8aUgrpIKqqd5pzz5dUKWXJSLajoUNZ5GTPmPbKSAiBKC578fw+ebOwOcHxmpNqJ1Znmq
	IX0g/wO7tTHn6ZPdZe53U0R1VpwFbIk+5LIgnjSpLYUtFJZBhAWbEfxxihfOjxNsiG7lQKDN5+k
	zsTyg7Ik4lD9NoA1JLPAT
X-Received: by 2002:a05:6808:8983:10b0:4e4:4b49:3a31 with SMTP id
 5614622812f47-4e44b7707bfmr4005856b6e.2.1790596014276; Mon, 28 Sep 2026
 04:46:54 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:53 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:53 +0200
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
References: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 13:46:53 +0200
X-Gm-Features: AclHuK-LgVtdD9OWC6wM2fRx3Dbg6SSDnvXWs7wRBZWuJE8GQkEcKnTTVIRDDCs
Message-ID: <CANOyQmGkGwSkwUj-NOKzhQ_mgapoqqoOLaqXaGAjWK8jiknarQ@mail.gmail.com>
Subject: [PATCH 1/2] HID: picolcd: Move output requests out of spinlocked sections
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, bigeasy@linutronix.de, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Creating a PicoLCD through UHID triggers a sleeping-in-invalid-context
warning in picolcd_set_contrast() on PREEMPT_RT. hid_hw_request() can
allocate with GFP_KERNEL and wait for a reply through __hid_request(),
but the driver invokes it while holding data->lock. The same pattern
exists in the other output paths.

Serialize output report updates and requests with a separate mutex.
Keep the spinlock for status and pending replies shared with raw_event(),
and drop it before submitting requests. Serialize the failed-state
transition with output requests during removal.

Use the blocking LED callback and protect LED state updates with the
report mutex. Move framebuffer reset outside fbdata->lock so the new
mutex is never acquired under that spinlock.

In a PREEMPT_RT QEMU guest, the original syzkaller reproducer triggered
six sleep warnings with the baseline module and none with this change
during a four-second run (214 iterations). Five rounds each of concurrent
LCD, backlight, two LED and UHID destroy operations, with and without
persistent-open framebuffer writes, completed without BUG/WARNING.
Physical hardware and suspend/resume have not been tested.

Fixes: d881427253da ("HID: use hid_hw_request() instead of direct call
to usbhid")
Reported-by: syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=912222e4cb82423535fa
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/hid/hid-picolcd.h           |  2 ++
 drivers/hid/hid-picolcd_backlight.c |  7 ++---
 drivers/hid/hid-picolcd_core.c      | 46 +++++++++++++++++++----------
 drivers/hid/hid-picolcd_fb.c        | 23 ++++++++-------
 drivers/hid/hid-picolcd_lcd.c       |  7 ++---
 drivers/hid/hid-picolcd_leds.c      | 31 +++++++++++--------
 6 files changed, 69 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 57c9d0a675..846a8ceb95 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -102,6 +102,8 @@ struct picolcd_data {
 	/* Housekeeping stuff */
 	spinlock_t lock;
 	struct mutex mutex;
+	/* Serialize updates to output reports and their HID requests. */
+	struct mutex report_mutex;
 	struct picolcd_pending *pending;
 	int status;
 #define PICOLCD_BOOTLOADER 1
diff --git a/drivers/hid/hid-picolcd_backlight.c
b/drivers/hid/hid-picolcd_backlight.c
index 4b43b64537..9fe27437d2 100644
--- a/drivers/hid/hid-picolcd_backlight.c
+++ b/drivers/hid/hid-picolcd_backlight.c
@@ -23,19 +23,18 @@ static int picolcd_set_brightness(struct
backlight_device *bdev)
 {
 	struct picolcd_data *data = bl_get_data(bdev);
 	struct hid_report *report = picolcd_out_report(REPORT_BRIGHTNESS, data->hdev);
-	unsigned long flags;

 	if (!report || report->maxfield != 1 || report->field[0]->report_count != 1)
 		return -ENODEV;

+	mutex_lock(&data->report_mutex);
 	data->lcd_brightness = bdev->props.brightness & 0x0ff;
 	data->lcd_power      = bdev->props.power;
-	spin_lock_irqsave(&data->lock, flags);
 	hid_set_field(report->field[0], 0,
 		      data->lcd_power == BACKLIGHT_POWER_ON ? data->lcd_brightness : 0);
-	if (!(data->status & PICOLCD_FAILED))
+	if (!(READ_ONCE(data->status) & PICOLCD_FAILED))
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
 	return 0;
 }

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index d73e97c8b8..9d6bf75aba 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -77,7 +77,7 @@ struct picolcd_pending *picolcd_send_and_wait(struct
hid_device *hdev,

 	if (!report || !data)
 		return NULL;
-	if (data->status & PICOLCD_FAILED)
+	if (READ_ONCE(data->status) & PICOLCD_FAILED)
 		return NULL;
 	work = kzalloc_obj(*work);
 	if (!work)
@@ -89,23 +89,27 @@ struct picolcd_pending
*picolcd_send_and_wait(struct hid_device *hdev,
 	work->raw_size   = 0;

 	mutex_lock(&data->mutex);
-	spin_lock_irqsave(&data->lock, flags);
+	mutex_lock(&data->report_mutex);
 	for (i = k = 0; i < report->maxfield; i++)
 		for (j = 0; j < report->field[i]->report_count; j++) {
 			hid_set_field(report->field[i], j, k < size ? raw_data[k] : 0);
 			k++;
 		}
+	spin_lock_irqsave(&data->lock, flags);
 	if (data->status & PICOLCD_FAILED) {
-		kfree(work);
-		work = NULL;
-	} else {
-		data->pending = work;
-		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
 		spin_unlock_irqrestore(&data->lock, flags);
-		wait_for_completion_interruptible_timeout(&work->ready, HZ*2);
-		spin_lock_irqsave(&data->lock, flags);
-		data->pending = NULL;
+		mutex_unlock(&data->report_mutex);
+		mutex_unlock(&data->mutex);
+		kfree(work);
+		return NULL;
 	}
+	data->pending = work;
+	spin_unlock_irqrestore(&data->lock, flags);
+	hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
+	mutex_unlock(&data->report_mutex);
+	wait_for_completion_interruptible_timeout(&work->ready, HZ*2);
+	spin_lock_irqsave(&data->lock, flags);
+	data->pending = NULL;
 	spin_unlock_irqrestore(&data->lock, flags);
 	mutex_unlock(&data->mutex);
 	return work;
@@ -224,18 +228,21 @@ int picolcd_reset(struct hid_device *hdev)
 	if (!data || !report || report->maxfield != 1)
 		return -ENODEV;

+	mutex_lock(&data->report_mutex);
 	spin_lock_irqsave(&data->lock, flags);
 	if (hdev->product == USB_DEVICE_ID_PICOLCD_BOOTLOADER)
 		data->status |= PICOLCD_BOOTLOADER;

-	/* perform the reset */
-	hid_set_field(report->field[0], 0, 1);
 	if (data->status & PICOLCD_FAILED) {
 		spin_unlock_irqrestore(&data->lock, flags);
+		mutex_unlock(&data->report_mutex);
 		return -ENODEV;
 	}
-	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 	spin_unlock_irqrestore(&data->lock, flags);
+	/* perform the reset */
+	hid_set_field(report->field[0], 0, 1);
+	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
+	mutex_unlock(&data->report_mutex);

 	error = picolcd_check_version(hdev);
 	if (error)
@@ -268,7 +275,6 @@ static ssize_t picolcd_operation_mode_store(struct
device *dev,
 	struct picolcd_data *data = dev_get_drvdata(dev);
 	struct hid_report *report = NULL;
 	int timeout = data->opmode_delay;
-	unsigned long flags;

 	if (sysfs_streq(buf, "lcd")) {
 		if (data->status & PICOLCD_BOOTLOADER)
@@ -283,11 +289,15 @@ static ssize_t
picolcd_operation_mode_store(struct device *dev,
 	if (!report || report->maxfield != 1)
 		return -EINVAL;

-	spin_lock_irqsave(&data->lock, flags);
+	mutex_lock(&data->report_mutex);
+	if (READ_ONCE(data->status) & PICOLCD_FAILED) {
+		mutex_unlock(&data->report_mutex);
+		return -ENODEV;
+	}
 	hid_set_field(report->field[0], 0, timeout & 0xff);
 	hid_set_field(report->field[0], 1, (timeout >> 8) & 0xff);
 	hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
 	return count;
 }

@@ -537,6 +547,7 @@ static int picolcd_probe(struct hid_device *hdev,

 	spin_lock_init(&data->lock);
 	mutex_init(&data->mutex);
+	mutex_init(&data->report_mutex);
 	data->hdev = hdev;
 	data->opmode_delay = 5000;
 	if (hdev->product == USB_DEVICE_ID_PICOLCD_BOOTLOADER)
@@ -603,9 +614,11 @@ static void picolcd_remove(struct hid_device *hdev)
 	unsigned long flags;

 	dbg_hid(PICOLCD_NAME " hardware remove...\n");
+	mutex_lock(&data->report_mutex);
 	spin_lock_irqsave(&data->lock, flags);
 	data->status |= PICOLCD_FAILED;
 	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);

 	picolcd_exit_devfs(data);
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode);
@@ -630,6 +643,7 @@ static void picolcd_remove(struct hid_device *hdev)
 	picolcd_exit_keys(data);

 	mutex_destroy(&data->mutex);
+	mutex_destroy(&data->report_mutex);
 	/* Finally, clean up the picolcd data itself */
 	kfree(data);
 }
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 8c28e982e0..c17104fd60 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -91,7 +91,6 @@ static int picolcd_fb_send_tile(struct picolcd_data
*data, u8 *vbitmap,
 		int chip, int tile)
 {
 	struct hid_report *report1, *report2;
-	unsigned long flags;
 	u8 *tdata;
 	int i;

@@ -102,9 +101,9 @@ static int picolcd_fb_send_tile(struct
picolcd_data *data, u8 *vbitmap,
 	if (!report2 || report2->maxfield != 1)
 		return -ENODEV;

-	spin_lock_irqsave(&data->lock, flags);
-	if ((data->status & PICOLCD_FAILED)) {
-		spin_unlock_irqrestore(&data->lock, flags);
+	mutex_lock(&data->report_mutex);
+	if (READ_ONCE(data->status) & PICOLCD_FAILED) {
+		mutex_unlock(&data->report_mutex);
 		return -ENODEV;
 	}
 	hid_set_field(report1->field[0],  0, chip << 2);
@@ -133,7 +132,7 @@ static int picolcd_fb_send_tile(struct
picolcd_data *data, u8 *vbitmap,

 	hid_hw_request(data->hdev, report1, HID_REQ_SET_REPORT);
 	hid_hw_request(data->hdev, report2, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
 	return 0;
 }

@@ -187,13 +186,16 @@ int picolcd_fb_reset(struct picolcd_data *data, int clear)
 	struct hid_report *report = picolcd_out_report(REPORT_LCD_CMD, data->hdev);
 	struct picolcd_fb_data *fbdata = data->fb_info->par;
 	int i, j;
-	unsigned long flags;
 	static const u8 mapcmd[8] = { 0x00, 0x02, 0x00, 0x64, 0x3f, 0x00,
0x64, 0xc0 };

 	if (!report || report->maxfield != 1)
 		return -ENODEV;

-	spin_lock_irqsave(&data->lock, flags);
+	mutex_lock(&data->report_mutex);
+	if (READ_ONCE(data->status) & PICOLCD_FAILED) {
+		mutex_unlock(&data->report_mutex);
+		return -ENODEV;
+	}
 	for (i = 0; i < 4; i++) {
 		for (j = 0; j < report->field[0]->maxusage; j++)
 			if (j == 0)
@@ -204,7 +206,7 @@ int picolcd_fb_reset(struct picolcd_data *data, int clear)
 				hid_set_field(report->field[0], j, 0);
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
 	}
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);

 	if (clear) {
 		memset(fbdata->vbitmap, 0, PICOLCDFB_SIZE);
@@ -232,9 +234,10 @@ static void picolcd_fb_update(struct fb_info *info)
 	mutex_lock(&info->lock);

 	spin_lock_irqsave(&fbdata->lock, flags);
-	if (!fbdata->ready && fbdata->picolcd)
-		picolcd_fb_reset(fbdata->picolcd, 0);
+	data = !fbdata->ready ? fbdata->picolcd : NULL;
 	spin_unlock_irqrestore(&fbdata->lock, flags);
+	if (data)
+		picolcd_fb_reset(data, 0);

 	/*
 	 * Translate the framebuffer into the format needed by the PicoLCD.
diff --git a/drivers/hid/hid-picolcd_lcd.c b/drivers/hid/hid-picolcd_lcd.c
index 318f19eac0..a1fdbfdfde 100644
--- a/drivers/hid/hid-picolcd_lcd.c
+++ b/drivers/hid/hid-picolcd_lcd.c
@@ -27,17 +27,16 @@ static int picolcd_set_contrast(struct lcd_device
*ldev, int contrast)
 {
 	struct picolcd_data *data = lcd_get_data(ldev);
 	struct hid_report *report = picolcd_out_report(REPORT_CONTRAST, data->hdev);
-	unsigned long flags;

 	if (!report || report->maxfield != 1 || report->field[0]->report_count != 1)
 		return -ENODEV;

+	mutex_lock(&data->report_mutex);
 	data->lcd_contrast = contrast & 0x0ff;
-	spin_lock_irqsave(&data->lock, flags);
 	hid_set_field(report->field[0], 0, data->lcd_contrast);
-	if (!(data->status & PICOLCD_FAILED))
+	if (!(READ_ONCE(data->status) & PICOLCD_FAILED))
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
 	return 0;
 }

diff --git a/drivers/hid/hid-picolcd_leds.c b/drivers/hid/hid-picolcd_leds.c
index 6b505a7535..c6ae8ace1d 100644
--- a/drivers/hid/hid-picolcd_leds.c
+++ b/drivers/hid/hid-picolcd_leds.c
@@ -29,10 +29,9 @@
 #include "hid-picolcd.h"


-void picolcd_leds_set(struct picolcd_data *data)
+static void picolcd_leds_set_locked(struct picolcd_data *data)
 {
 	struct hid_report *report;
-	unsigned long flags;

 	if (!data->led[0])
 		return;
@@ -40,14 +39,19 @@ void picolcd_leds_set(struct picolcd_data *data)
 	if (!report || report->maxfield != 1 || report->field[0]->report_count != 1)
 		return;

-	spin_lock_irqsave(&data->lock, flags);
 	hid_set_field(report->field[0], 0, data->led_state);
-	if (!(data->status & PICOLCD_FAILED))
+	if (!(READ_ONCE(data->status) & PICOLCD_FAILED))
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
 }

-static void picolcd_led_set_brightness(struct led_classdev *led_cdev,
+void picolcd_leds_set(struct picolcd_data *data)
+{
+	mutex_lock(&data->report_mutex);
+	picolcd_leds_set_locked(data);
+	mutex_unlock(&data->report_mutex);
+}
+
+static int picolcd_led_set_brightness(struct led_classdev *led_cdev,
 			enum led_brightness value)
 {
 	struct device *dev;
@@ -59,20 +63,23 @@ static void picolcd_led_set_brightness(struct
led_classdev *led_cdev,
 	hdev = to_hid_device(dev);
 	data = hid_get_drvdata(hdev);
 	if (!data)
-		return;
+		return -ENODEV;
+	mutex_lock(&data->report_mutex);
 	for (i = 0; i < 8; i++) {
 		if (led_cdev != data->led[i])
 			continue;
 		state = (data->led_state >> i) & 1;
 		if (value == LED_OFF && state) {
 			data->led_state &= ~(1 << i);
-			picolcd_leds_set(data);
+			picolcd_leds_set_locked(data);
 		} else if (value != LED_OFF && !state) {
 			data->led_state |= 1 << i;
-			picolcd_leds_set(data);
+			picolcd_leds_set_locked(data);
 		}
 		break;
 	}
+	mutex_unlock(&data->report_mutex);
+	return 0;
 }

 static enum led_brightness picolcd_led_get_brightness(struct
led_classdev *led_cdev)
@@ -87,7 +94,7 @@ static enum led_brightness
picolcd_led_get_brightness(struct led_classdev *led_c
 	data = hid_get_drvdata(hdev);
 	for (i = 0; i < 8; i++)
 		if (led_cdev == data->led[i]) {
-			value = (data->led_state >> i) & 1;
+			value = (READ_ONCE(data->led_state) >> i) & 1;
 			break;
 		}
 	return value ? LED_FULL : LED_OFF;
@@ -122,7 +129,7 @@ int picolcd_init_leds(struct picolcd_data *data,
struct hid_report *report)
 		led->brightness = 0;
 		led->max_brightness = 1;
 		led->brightness_get = picolcd_led_get_brightness;
-		led->brightness_set = picolcd_led_set_brightness;
+		led->brightness_set_blocking = picolcd_led_set_brightness;

 		data->led[i] = led;
 		ret = led_classdev_register(dev, data->led[i]);
@@ -159,5 +166,3 @@ void picolcd_exit_leds(struct picolcd_data *data)
 		kfree(led);
 	}
 }
-
-
-- 
2.55.0
