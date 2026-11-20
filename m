Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137137;
	b=5kU3vhkvrvSHqgHCzLundx0O1y/Kivb7UR8FrQ2vHqsxgkHH73FV4htQE5GSHKWRDFm6
	 Ag2HbckesrgC6vZwz3lR1Y4m5kzUenYzugEq6tuGpRfvaeyEI9l0fB5YLrYS2kANiiBq9
	 h4Zm1gKidOmlLl8Y9+w44qbeub2KjBLiv9XpVEjp4FRVLaLsoByuMRcsH7XwMTDLITwEk
	 RnUDZVt0dovTSxGk7CzakM81vdIEibmHwrYA1wux/YQuJvaX/RIcvvMQK1AKvcg2YrhN8
	 tTLBOgJ4TJ/LvvytgrWRh9ZSviOaR07JspHoR8KgHhLy2b6JZn1QNY+GtiZNKr5pVEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=7/H/OeHZ3clKH3qdVG9FU0x+z/0lJ0k+l4bKjCHjwmM=;
	b=HnY9mudVVIiUuhema/PK3sMuyePitYEHasBVoucbLKqUGmUBGtT7x3bxsaHrrP8qkfcY
	 4KJQTta9yUChBzU7p56fpJ0rj5TXQrWLncXDLNQfTc5qbWnYlDHzEQ6MRECMjXL1juCzA
	 TpmEkhHULN0jk3rzCequFDjvAwS96h9jNtRt0MzY0jdWmJBCxzSfQJxLvFM2Hg6kncsSg
	 2pns/Z0+RkuvRU/5WYUxpuLVWv/aGTlndw5u8HFgnsJrThFzsJRi9NLkrxUvWk3mYZ9k9
	 HTbVWNhkxleaXtepgm+NCLCdwf9kDajKQrUx8oJOyY7Zt04slCuCJGRBQ89NvZLBDuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ieylbmUS;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15A606A320
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 01:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE15A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ieylbmUS
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b196fefa1fso191254a91.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 17:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795137135; x=1795741935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/H/OeHZ3clKH3qdVG9FU0x+z/0lJ0k+l4bKjCHjwmM=;
        b=ieylbmUSrGzbDWtadwnkLRhGRooEklfA1UgdRD/4svCcj+JG5Wvd4LUDqp3F2Z8vBO
         1yBTNiMbFJL0n2m0bHBhrgVqXIuMSMhPcNyqacCOvxW3ppLk3t7oD+QtK4demjnsKAfs
         jP7rIoQu4EMpGBVok84vg3ATNeHXcNGrGSq9h91j2DrfX83INw8cYP0nnOKrKj+1xJ76
         5v1BPSdtRot/6SGZ0bgrfRDBJH+uYnOMcKoMvYPU1XYdPspF4iV6mcczOlz+/XO8q9Rn
         w0X12q5S942ujttQF4qMBZXva1VON02kYtgz5T4NrIfufjoMCyLUKZMWTYHrKDJ0SCue
         rVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137135; x=1795741935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/H/OeHZ3clKH3qdVG9FU0x+z/0lJ0k+l4bKjCHjwmM=;
        b=Zkb0V161c3pJ9jwZUxK5rwu4xHcGp5dj7EByziD10qUhl/eizPQYmspo8BHUILlKnd
         /EVyvanTI8003+17PXhM6yLFgYCaYMafWxlcYbyRe/rV/kERKfqgA+Hlu3Y3c99ImiGr
         jjNF3YNsm0gQLX6RgNgSABosSvGmHX3jEZdUmaOrsQDHIghPQ/QTbaU6gpnHr1TCLBxY
         w5h7jDaysTAE3zAx1QipixTwXTldV0gTTqgDOMZTE0vttCj3mZwNaH+xPtxLdynYzIMz
         jXslrlJ4o0Rg92k9TV0npXwye5nS5ECK0wqmitvw1i0d4RSc1GKxeTW/nilbW/FI+DvJ
         TM5Q==
X-Forwarded-Encrypted: i=1; AL+hErGtg3MCfe7Hnho0pCpE7VfUK9KFssbnIonESt84POYf4LOpgqGLCHnSsaxsecH+8YCrgcy6naJGbX+XyA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8K/7Ft9OBI6wm+zh5yhsutlDQ3zcLU70J3d2ae3te//qKtPeQM
	ez0IjiMtKloaIJshs9VZSSwQ70AwxNy5ohG4W4GBhwrKsYOe7GDyqYei
X-Gm-Gg: AZFdTZdKi0Pb3Mcb+DBSRQZ26gDRj6f7RKU2V8k9f8nJpQGkVzQiJMYwkCgzEMpqXEn
	I46IWqditrElrh+KzfxufOXrYEjGjdg0FmX39+nqOY1IIEdS9HxiBkxGzbfuvEiWCWz57/5WLGK
	xSJ8b4JfiAP0Rdt7dttW6JWSLz4WQ0j0xt7VxbEySdt++mGhG93x4BpWNUeA2wKbmv5LEIkZ5vY
	GAf0zA47tROPQWiktC9o2kq9nTVijZaNU+PPUF4aJ3ealF34nmyc3somE0azrtaFJ+UGu7HULIn
	KhLhMosJc/2GPYGuOPgLoYAUJ7ihouak2EAq3HxPnAPGD69Q8LrkTte4PJfjqQrE2KRJGIERCfv
	SekLlG5FG9YR+eaiyycRwDBAoXkrb02wAKG8Lf99FoxMetKlst+OczRGeKDrIfRXMmM8qHWpvEi
	36qtg/muCkzOlIDrhH67pzIFN7urt6TPIOaTbeXzj/qbnMFbA8py8h3mFh2YhnjElYyRKAAS5Ir
	ae6wmb0K/dpt3bA3ncYLehRlaL97UtssnEyt7kQt7/rYK44ZFFne4Ru5k4/UuzJfiOtR01pQmiL
	E1quLglEF+MVF/Xc2hsjF9MW8j4vPt4p/9uOR+E88ZHVM8NqRvegfvymXGtlDzbiIe6KDcq94cB
	1vbB7nuGOMsyY
X-Received: by 2002:a17:90b:498c:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3b41c902f3emr1026135a91.28.1795137135025;
        Thu, 19 Nov 2026 17:12:15 -0800 (PST)
Received: from localhost ([50.7.253.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d243eb1sm622215a91.3.2026.11.19.17.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:12:14 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Fri, 20 Nov 2026 12:05:47 +1100
Subject: [PATCH RESEND v2 1/2] HID: picolcd: Move output requests out of
 spinlocked sections
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <20261120-mail-picolcd-v2-resend-20261120-v2-1-d7531fa8061b@gmail.com>
References: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
In-Reply-To: <20261120-mail-picolcd-v2-resend-20261120-v2-0-d7531fa8061b@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, deller@gmx.de, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Clark Williams <clrkwllms@kernel.org>, bigeasy@linutronix.de, 
 linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Takashi Iwai <tiwai@suse.de>, 
 syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com, 
 linux-rt-devel@lists.linux.dev, simona@ffwll.ch, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
X-Mailer: b4 0.16.0

Creating a PicoLCD through UHID triggers a sleeping-in-invalid-context
warning in picolcd_set_contrast(). The driver calls hid_hw_request()
while holding picolcd_data::lock, which is a spinlock_t.
hid_hw_request() can allocate with GFP_KERNEL and wait for a reply
through __hid_request(), so it must not be called from this spinlocked
section. The same pattern exists in the other output paths.

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

Fixes: d881427253da ("HID: use hid_hw_request() instead of direct call to u=
sbhid")
Reported-by: syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D912222e4cb82423535fa
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/hid/hid-picolcd.h           |  2 ++
 drivers/hid/hid-picolcd_backlight.c |  7 +++---
 drivers/hid/hid-picolcd_core.c      | 46 ++++++++++++++++++++++++---------=
----
 drivers/hid/hid-picolcd_fb.c        | 23 +++++++++++--------
 drivers/hid/hid-picolcd_lcd.c       |  7 +++---
 drivers/hid/hid-picolcd_leds.c      | 31 ++++++++++++++-----------
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
diff --git a/drivers/hid/hid-picolcd_backlight.c b/drivers/hid/hid-picolcd_=
backlight.c
index 4b43b64537..9fe27437d2 100644
--- a/drivers/hid/hid-picolcd_backlight.c
+++ b/drivers/hid/hid-picolcd_backlight.c
@@ -23,19 +23,18 @@ static int picolcd_set_brightness(struct backlight_devi=
ce *bdev)
 {
 	struct picolcd_data *data =3D bl_get_data(bdev);
 	struct hid_report *report =3D picolcd_out_report(REPORT_BRIGHTNESS, data-=
>hdev);
-	unsigned long flags;
=20
 	if (!report || report->maxfield !=3D 1 || report->field[0]->report_count =
!=3D 1)
 		return -ENODEV;
=20
+	mutex_lock(&data->report_mutex);
 	data->lcd_brightness =3D bdev->props.brightness & 0x0ff;
 	data->lcd_power      =3D bdev->props.power;
-	spin_lock_irqsave(&data->lock, flags);
 	hid_set_field(report->field[0], 0,
 		      data->lcd_power =3D=3D BACKLIGHT_POWER_ON ? data->lcd_brightness :=
 0);
-	if (!(data->status & PICOLCD_FAILED))
+	if (!(READ_ONCE(data->status) & PICOLCD_FAILED))
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
 	return 0;
 }
=20
diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index d73e97c8b8..9d6bf75aba 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -77,7 +77,7 @@ struct picolcd_pending *picolcd_send_and_wait(struct hid_=
device *hdev,
=20
 	if (!report || !data)
 		return NULL;
-	if (data->status & PICOLCD_FAILED)
+	if (READ_ONCE(data->status) & PICOLCD_FAILED)
 		return NULL;
 	work =3D kzalloc_obj(*work);
 	if (!work)
@@ -89,23 +89,27 @@ struct picolcd_pending *picolcd_send_and_wait(struct hi=
d_device *hdev,
 	work->raw_size   =3D 0;
=20
 	mutex_lock(&data->mutex);
-	spin_lock_irqsave(&data->lock, flags);
+	mutex_lock(&data->report_mutex);
 	for (i =3D k =3D 0; i < report->maxfield; i++)
 		for (j =3D 0; j < report->field[i]->report_count; j++) {
 			hid_set_field(report->field[i], j, k < size ? raw_data[k] : 0);
 			k++;
 		}
+	spin_lock_irqsave(&data->lock, flags);
 	if (data->status & PICOLCD_FAILED) {
-		kfree(work);
-		work =3D NULL;
-	} else {
-		data->pending =3D work;
-		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
 		spin_unlock_irqrestore(&data->lock, flags);
-		wait_for_completion_interruptible_timeout(&work->ready, HZ*2);
-		spin_lock_irqsave(&data->lock, flags);
-		data->pending =3D NULL;
+		mutex_unlock(&data->report_mutex);
+		mutex_unlock(&data->mutex);
+		kfree(work);
+		return NULL;
 	}
+	data->pending =3D work;
+	spin_unlock_irqrestore(&data->lock, flags);
+	hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
+	mutex_unlock(&data->report_mutex);
+	wait_for_completion_interruptible_timeout(&work->ready, HZ*2);
+	spin_lock_irqsave(&data->lock, flags);
+	data->pending =3D NULL;
 	spin_unlock_irqrestore(&data->lock, flags);
 	mutex_unlock(&data->mutex);
 	return work;
@@ -224,18 +228,21 @@ int picolcd_reset(struct hid_device *hdev)
 	if (!data || !report || report->maxfield !=3D 1)
 		return -ENODEV;
=20
+	mutex_lock(&data->report_mutex);
 	spin_lock_irqsave(&data->lock, flags);
 	if (hdev->product =3D=3D USB_DEVICE_ID_PICOLCD_BOOTLOADER)
 		data->status |=3D PICOLCD_BOOTLOADER;
=20
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
=20
 	error =3D picolcd_check_version(hdev);
 	if (error)
@@ -268,7 +275,6 @@ static ssize_t picolcd_operation_mode_store(struct devi=
ce *dev,
 	struct picolcd_data *data =3D dev_get_drvdata(dev);
 	struct hid_report *report =3D NULL;
 	int timeout =3D data->opmode_delay;
-	unsigned long flags;
=20
 	if (sysfs_streq(buf, "lcd")) {
 		if (data->status & PICOLCD_BOOTLOADER)
@@ -283,11 +289,15 @@ static ssize_t picolcd_operation_mode_store(struct de=
vice *dev,
 	if (!report || report->maxfield !=3D 1)
 		return -EINVAL;
=20
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
=20
@@ -537,6 +547,7 @@ static int picolcd_probe(struct hid_device *hdev,
=20
 	spin_lock_init(&data->lock);
 	mutex_init(&data->mutex);
+	mutex_init(&data->report_mutex);
 	data->hdev =3D hdev;
 	data->opmode_delay =3D 5000;
 	if (hdev->product =3D=3D USB_DEVICE_ID_PICOLCD_BOOTLOADER)
@@ -603,9 +614,11 @@ static void picolcd_remove(struct hid_device *hdev)
 	unsigned long flags;
=20
 	dbg_hid(PICOLCD_NAME " hardware remove...\n");
+	mutex_lock(&data->report_mutex);
 	spin_lock_irqsave(&data->lock, flags);
 	data->status |=3D PICOLCD_FAILED;
 	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
=20
 	picolcd_exit_devfs(data);
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode);
@@ -630,6 +643,7 @@ static void picolcd_remove(struct hid_device *hdev)
 	picolcd_exit_keys(data);
=20
 	mutex_destroy(&data->mutex);
+	mutex_destroy(&data->report_mutex);
 	/* Finally, clean up the picolcd data itself */
 	kfree(data);
 }
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 8c28e982e0..c17104fd60 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -91,7 +91,6 @@ static int picolcd_fb_send_tile(struct picolcd_data *data=
, u8 *vbitmap,
 		int chip, int tile)
 {
 	struct hid_report *report1, *report2;
-	unsigned long flags;
 	u8 *tdata;
 	int i;
=20
@@ -102,9 +101,9 @@ static int picolcd_fb_send_tile(struct picolcd_data *da=
ta, u8 *vbitmap,
 	if (!report2 || report2->maxfield !=3D 1)
 		return -ENODEV;
=20
-	spin_lock_irqsave(&data->lock, flags);
-	if ((data->status & PICOLCD_FAILED)) {
-		spin_unlock_irqrestore(&data->lock, flags);
+	mutex_lock(&data->report_mutex);
+	if (READ_ONCE(data->status) & PICOLCD_FAILED) {
+		mutex_unlock(&data->report_mutex);
 		return -ENODEV;
 	}
 	hid_set_field(report1->field[0],  0, chip << 2);
@@ -133,7 +132,7 @@ static int picolcd_fb_send_tile(struct picolcd_data *da=
ta, u8 *vbitmap,
=20
 	hid_hw_request(data->hdev, report1, HID_REQ_SET_REPORT);
 	hid_hw_request(data->hdev, report2, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
 	return 0;
 }
=20
@@ -187,13 +186,16 @@ int picolcd_fb_reset(struct picolcd_data *data, int c=
lear)
 	struct hid_report *report =3D picolcd_out_report(REPORT_LCD_CMD, data->hd=
ev);
 	struct picolcd_fb_data *fbdata =3D data->fb_info->par;
 	int i, j;
-	unsigned long flags;
 	static const u8 mapcmd[8] =3D { 0x00, 0x02, 0x00, 0x64, 0x3f, 0x00, 0x64,=
 0xc0 };
=20
 	if (!report || report->maxfield !=3D 1)
 		return -ENODEV;
=20
-	spin_lock_irqsave(&data->lock, flags);
+	mutex_lock(&data->report_mutex);
+	if (READ_ONCE(data->status) & PICOLCD_FAILED) {
+		mutex_unlock(&data->report_mutex);
+		return -ENODEV;
+	}
 	for (i =3D 0; i < 4; i++) {
 		for (j =3D 0; j < report->field[0]->maxusage; j++)
 			if (j =3D=3D 0)
@@ -204,7 +206,7 @@ int picolcd_fb_reset(struct picolcd_data *data, int cle=
ar)
 				hid_set_field(report->field[0], j, 0);
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
 	}
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
=20
 	if (clear) {
 		memset(fbdata->vbitmap, 0, PICOLCDFB_SIZE);
@@ -232,9 +234,10 @@ static void picolcd_fb_update(struct fb_info *info)
 	mutex_lock(&info->lock);
=20
 	spin_lock_irqsave(&fbdata->lock, flags);
-	if (!fbdata->ready && fbdata->picolcd)
-		picolcd_fb_reset(fbdata->picolcd, 0);
+	data =3D !fbdata->ready ? fbdata->picolcd : NULL;
 	spin_unlock_irqrestore(&fbdata->lock, flags);
+	if (data)
+		picolcd_fb_reset(data, 0);
=20
 	/*
 	 * Translate the framebuffer into the format needed by the PicoLCD.
diff --git a/drivers/hid/hid-picolcd_lcd.c b/drivers/hid/hid-picolcd_lcd.c
index 318f19eac0..a1fdbfdfde 100644
--- a/drivers/hid/hid-picolcd_lcd.c
+++ b/drivers/hid/hid-picolcd_lcd.c
@@ -27,17 +27,16 @@ static int picolcd_set_contrast(struct lcd_device *ldev=
, int contrast)
 {
 	struct picolcd_data *data =3D lcd_get_data(ldev);
 	struct hid_report *report =3D picolcd_out_report(REPORT_CONTRAST, data->h=
dev);
-	unsigned long flags;
=20
 	if (!report || report->maxfield !=3D 1 || report->field[0]->report_count =
!=3D 1)
 		return -ENODEV;
=20
+	mutex_lock(&data->report_mutex);
 	data->lcd_contrast =3D contrast & 0x0ff;
-	spin_lock_irqsave(&data->lock, flags);
 	hid_set_field(report->field[0], 0, data->lcd_contrast);
-	if (!(data->status & PICOLCD_FAILED))
+	if (!(READ_ONCE(data->status) & PICOLCD_FAILED))
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
+	mutex_unlock(&data->report_mutex);
 	return 0;
 }
=20
diff --git a/drivers/hid/hid-picolcd_leds.c b/drivers/hid/hid-picolcd_leds.c
index 6b505a7535..c6ae8ace1d 100644
--- a/drivers/hid/hid-picolcd_leds.c
+++ b/drivers/hid/hid-picolcd_leds.c
@@ -29,10 +29,9 @@
 #include "hid-picolcd.h"
=20
=20
-void picolcd_leds_set(struct picolcd_data *data)
+static void picolcd_leds_set_locked(struct picolcd_data *data)
 {
 	struct hid_report *report;
-	unsigned long flags;
=20
 	if (!data->led[0])
 		return;
@@ -40,14 +39,19 @@ void picolcd_leds_set(struct picolcd_data *data)
 	if (!report || report->maxfield !=3D 1 || report->field[0]->report_count =
!=3D 1)
 		return;
=20
-	spin_lock_irqsave(&data->lock, flags);
 	hid_set_field(report->field[0], 0, data->led_state);
-	if (!(data->status & PICOLCD_FAILED))
+	if (!(READ_ONCE(data->status) & PICOLCD_FAILED))
 		hid_hw_request(data->hdev, report, HID_REQ_SET_REPORT);
-	spin_unlock_irqrestore(&data->lock, flags);
 }
=20
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
@@ -59,20 +63,23 @@ static void picolcd_led_set_brightness(struct led_class=
dev *led_cdev,
 	hdev =3D to_hid_device(dev);
 	data =3D hid_get_drvdata(hdev);
 	if (!data)
-		return;
+		return -ENODEV;
+	mutex_lock(&data->report_mutex);
 	for (i =3D 0; i < 8; i++) {
 		if (led_cdev !=3D data->led[i])
 			continue;
 		state =3D (data->led_state >> i) & 1;
 		if (value =3D=3D LED_OFF && state) {
 			data->led_state &=3D ~(1 << i);
-			picolcd_leds_set(data);
+			picolcd_leds_set_locked(data);
 		} else if (value !=3D LED_OFF && !state) {
 			data->led_state |=3D 1 << i;
-			picolcd_leds_set(data);
+			picolcd_leds_set_locked(data);
 		}
 		break;
 	}
+	mutex_unlock(&data->report_mutex);
+	return 0;
 }
=20
 static enum led_brightness picolcd_led_get_brightness(struct led_classdev =
*led_cdev)
@@ -87,7 +94,7 @@ static enum led_brightness picolcd_led_get_brightness(str=
uct led_classdev *led_c
 	data =3D hid_get_drvdata(hdev);
 	for (i =3D 0; i < 8; i++)
 		if (led_cdev =3D=3D data->led[i]) {
-			value =3D (data->led_state >> i) & 1;
+			value =3D (READ_ONCE(data->led_state) >> i) & 1;
 			break;
 		}
 	return value ? LED_FULL : LED_OFF;
@@ -122,7 +129,7 @@ int picolcd_init_leds(struct picolcd_data *data, struct=
 hid_report *report)
 		led->brightness =3D 0;
 		led->max_brightness =3D 1;
 		led->brightness_get =3D picolcd_led_get_brightness;
-		led->brightness_set =3D picolcd_led_set_brightness;
+		led->brightness_set_blocking =3D picolcd_led_set_brightness;
=20
 		data->led[i] =3D led;
 		ret =3D led_classdev_register(dev, data->led[i]);
@@ -159,5 +166,3 @@ void picolcd_exit_leds(struct picolcd_data *data)
 		kfree(led);
 	}
 }
-
-

--=20
2.56.1

