Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2D4B1D0F
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.202
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596022; cv=pass; b=f6jSsFRANB9y4CD5+psi4ZRAi/1Li9pNB1L8IvhiJwO4tHRa5zOwRECSZdNezDX5lgZO1y1JvVHdX31ICTMiI3XpU/rNbCDe7tSrXhiEE6B4fuEK2kGp/zNgf94zV+qnfQi+U60zeQm7WfRynJzkhTFRCVZLvRFKen2IMlHeCWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596022; c=relaxed/simple;
	bh=/9u3l8tvroAWhsZ3+bgszRdYGfDaF3Zw4nAXDtkGKNI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0Tu1QvMQyCdGTBO7jLOdcNcsYO+67yjNNPNThQW3o1n16QVhc0GAseH9+Bqh7qq9ojYpoteE9kV089QULDANKHxvyDTMvakiVyDO23AYOLRoN1apT+3d1CAWXb+scphLO9LkTr2m9fGqVqWMhcKe24e/dNVJYgB3Qjs5OJi/NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGDQkEJ8; arc=pass smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGDQkEJ8"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c3bb46aaf0so283022b6e.1
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 04:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596020; cv=none;
        d=google.com; s=arc-20260327;
        b=l/v7M+jsKMXPxmAtcXXxH57vjq2n3YxNU72o90nqf+YeE3HuuN+QKLN4KrGbHkAKXW
         YM5dzNbYq5etiOHYvqVZhJQxnkwecjYL4q9uG0/y/I38+oJASLmFIBw3k00j/oDZeelF
         CiAjT2tYXsuXK3vJgV5FuLxEVTeUqLRWr4hTttyTboundxpBGBp4DNtiOPgJmDWJpdCl
         Cp81m5VfxtcCUpNBvL6RonA9j7GWQMz4IFm4IiSCQ05Fk9PiO40P9ytwa9WwdrO8dPYb
         GGC6mCAhlvl8A7sTu2coRUj1gxxZ7cVnzcf1hfxAAc2QK3YpQ/ApNCOdKoCaaiuPIojY
         +B/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
        fh=wMG66rvNc84lFY8oF+LOVJKUoapFvlhrRy9Nmv4IaJU=;
        b=SC7Z7xRXKDqeGVMjJpN/RLFbPWVIgLltwwHHg6I1fo2IzMEr48lv+QHEKYgu52foEQ
         nO9sfk1nFlEZ7Q1w9Vlu36+QscE36LL9jwFUTe0c/nn4X/FqJsOSZDgPPT9bqzKG6zdg
         UUKo/itltKGnT+ZBWaGWuVTYEx3jOg2XIms8v4WfEakYG8T0qV5HkoMEi5fAxrwPDNWS
         d3qS5fCCUun2xip8TKkHpLILOoWnFOiytGJgCE67t63gLlpgacpsc9cF/PBSlrIh2rw5
         trEXV/rT1eYWQHdjIR673HcWEBcpm8+UONra2j626Cip+3qKd29yIVOWOABrVFci2hmP
         zQ7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596020; x=1791200820; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
        b=RGDQkEJ8DdhtpsyqKWS8r4pferyNJ1qbWLQpUXxqE9gXWNojvrdiMWbxfi0Qd+jWap
         q8ReyeUQrpo2PqbKoP9TdsLmAsMOUZRYfH530+qHDqsAFZ/FUChOKj7JIUmlnfe9mbH1
         97P8XsB3FEG4Cnmitg8dK4OH2ApcoFpGZlUigUmhWbAS1vMk9AwykT58/6WwgaeyYmCJ
         xioMvo0DXneYJ5eaGESJGKCSBs9hPWmLb2c9YsJu6wNRzBfXJA9Ax1KFATkEGv+Ac0j0
         fdLsEwNKz0qneQLDNCdwdgWJ94LmnfvrAFsY0kl/ym5n9Ct0gAAaEVvCf7N3aH32+BY0
         peGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596020; x=1791200820;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
        b=VJJi9z8xMx3KZbBvSw3hXJr3YQ6qP828H/k7tEtkzBIAcxwkQCvTzQSzNXatn8HVmY
         Jt1a8hO8Y2ws2qRxUyu3PIWwdZP31puG7yl2cqvxedUpU3YZtk2rYX/qHnNwaz7FKPrB
         DG2El42Cj481aFMyAUhYdj4uWMS/224zV4GXuNbpgopie335E8PCPl5kTAhw+4ign5UA
         K+4q4npq/0ZU50XOBiUQTDuUGWYAaHxRnvLEfRBR3ltp+WDu0SBUIkMnbpSg7MXBNKBU
         TgYiqxCDN5swKRk/JzLtMhWKjvOk9wOxLYy1hjO9cglxmLdHBQWQHzvyI7Vwp7pDx4Mq
         H8Ig==
X-Gm-Message-State: AFuF++lqg5xSvYe3Vi+g7l65s6dFzOp/9GlqcpQC9nyx4G2uP2vr+7ij
	SmP9YKa9dSmX4+x8BuFdDKLf1d3hGQptnjMdW0xFFnyp70dLITICuB0MUB5PRGffHBITzQeJHqC
	GiyZzwq2kA54XA0UOIbPtNuvDN/hb/oU=
X-Gm-Gg: AYBFou2SaOK6RB5jOH3lonYHXxQekG5ckyvBEtd3XfIrSqxl9EQUrIHjz55RpVRTkyq
	8aHgVkybsc9fh4ZOLtWI0EdMS3ceu9RX8kRg99EcHYlWFUETwHTlNAYPLegDA6jxDJD5fHz2llk
	oS7t53WRZtImQ9HhotAXuzBbqxe1Wnm0PObXchmNVsUVNYlXUhEXyHQExTg7PnqIEeUyZ4be0Ao
	hwTad/h5AJVdCySwEvAbqjjNurPngiIk3sAA/l9VYH1y3VbJX/lluNJs9T+ssH9zSkLSDjvbasx
	Y8Ju0d5lZm9UaZubkaKRqS0MaQ2xjbqpWH0WbomKXKOs8FEZVbvT6ZfCTidyu+8LQH5Si55aRkf
	xJf9whbb5rw==
X-Received: by 2002:a05:6808:4fe1:b0:4e9:429e:d9a7 with SMTP id
 5614622812f47-4e9429edd08mr3795446b6e.49.1790596019638; Mon, 28 Sep 2026
 04:46:59 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:58 +0200
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 13:46:58 +0200
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
Date: Mon, 28 Sep 2026 13:46:58 +0200
X-Gm-Features: AclHuK_kufxbmR3rqUnxgcHL0HxOsXbK2RSoAj85Izv9mkp5_zAOdC4beU5raZY
Message-ID: <CANOyQmH1zm86uwt55Ueg50sBkiKHxXc7oJqNO3x_64qc5sE4Vg@mail.gmail.com>
Subject: [PATCH 2/2] HID: picolcd: Avoid framebuffer last-close deadlock
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, deller@gmx.de, 
	simona@ffwll.ch, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Closing the last framebuffer descriptor can deadlock against PicoLCD's
deferred update worker. fb_release() holds info->lock while waiting for
deferred work, and picolcd_fb_update() takes the same lock. Lockdep
reports the cycle through deferred-work completion and fbdefio_state->lock.
Repeated framebuffer open/write/close with concurrent device destruction
reproduces the hang in a PREEMPT_RT QEMU guest.

Use a private update mutex in the deferred worker instead of info->lock.
Take it in picolcd_set_par() as well to preserve serialization of pixel
format conversion and framebuffer updates. Initialize it before exposing
the framebuffer.

The test with the preceding output-request fix hung in the first round
and reported a circular locking dependency. With this change, all five
rounds completed, including 29 successful framebuffer write cycles and
concurrent LCD, backlight, two LED and UHID destroy operations, without
BUG/WARNING. The original syzkaller reproducer and persistent-open
framebuffer tests also passed again. These are bounded virtual-device
tests; physical hardware and suspend/resume remain untested.

Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing
deferred I/O devices")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/hid/hid-picolcd.h    |  2 ++
 drivers/hid/hid-picolcd_fb.c | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
index 846a8ceb95..33e6654ca0 100644
--- a/drivers/hid/hid-picolcd.h
+++ b/drivers/hid/hid-picolcd.h
@@ -115,6 +115,8 @@ struct picolcd_data {
 struct picolcd_fb_data {
 	/* Framebuffer stuff */
 	spinlock_t lock;
+	/* Deferred I/O runs while fbdefio_state->lock is held. */
+	struct mutex update_lock;
 	struct picolcd_data *picolcd;
 	u8 update_rate;
 	u8 bpp;
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index c17104fd60..258c7c4fa2 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -231,7 +231,8 @@ static void picolcd_fb_update(struct fb_info *info)
 	struct picolcd_fb_data *fbdata = info->par;
 	struct picolcd_data *data;

-	mutex_lock(&info->lock);
+	/* fb_release() flushes this work while holding info->lock. */
+	mutex_lock(&fbdata->update_lock);

 	spin_lock_irqsave(&fbdata->lock, flags);
 	data = !fbdata->ready ? fbdata->picolcd : NULL;
@@ -258,11 +259,11 @@ static void picolcd_fb_update(struct fb_info *info)
 				spin_lock_irqsave(&fbdata->lock, flags);
 				data = fbdata->picolcd;
 				spin_unlock_irqrestore(&fbdata->lock, flags);
-				mutex_unlock(&info->lock);
+				mutex_unlock(&fbdata->update_lock);
 				if (!data)
 					return;
 				hid_hw_wait(data->hdev);
-				mutex_lock(&info->lock);
+				mutex_lock(&fbdata->update_lock);
 				n = 0;
 			}
 			spin_lock_irqsave(&fbdata->lock, flags);
@@ -277,13 +278,13 @@ static void picolcd_fb_update(struct fb_info *info)
 		spin_lock_irqsave(&fbdata->lock, flags);
 		data = fbdata->picolcd;
 		spin_unlock_irqrestore(&fbdata->lock, flags);
-		mutex_unlock(&info->lock);
+		mutex_unlock(&fbdata->update_lock);
 		if (data)
 			hid_hw_wait(data->hdev);
 		return;
 	}
 out:
-	mutex_unlock(&info->lock);
+	mutex_unlock(&fbdata->update_lock);
 }

 static int picolcd_fb_blank(int blank, struct fb_info *info)
@@ -332,17 +333,24 @@ static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_fb_data *fbdata = info->par;
 	u8 *tmp_fb, *o_fb;
+	int ret = 0;
+
+	mutex_lock(&fbdata->update_lock);
 	if (info->var.bits_per_pixel == fbdata->bpp)
-		return 0;
+		goto out;
 	/* switch between 1/8 bit depths */
-	if (info->var.bits_per_pixel != 1 && info->var.bits_per_pixel != 8)
-		return -EINVAL;
+	if (info->var.bits_per_pixel != 1 && info->var.bits_per_pixel != 8) {
+		ret = -EINVAL;
+		goto out;
+	}

 	o_fb   = fbdata->bitmap;
 	tmp_fb = kmalloc_array(PICOLCDFB_SIZE, info->var.bits_per_pixel,
 			       GFP_KERNEL);
-	if (!tmp_fb)
-		return -ENOMEM;
+	if (!tmp_fb) {
+		ret = -ENOMEM;
+		goto out;
+	}

 	/* translate FB content to new bits-per-pixel */
 	if (info->var.bits_per_pixel == 1) {
@@ -369,7 +377,9 @@ static int picolcd_set_par(struct fb_info *info)

 	kfree(tmp_fb);
 	fbdata->bpp = info->var.bits_per_pixel;
-	return 0;
+out:
+	mutex_unlock(&fbdata->update_lock);
+	return ret;
 }

 static void picolcdfb_ops_damage_range(struct fb_info *info, off_t
off, size_t len)
@@ -506,6 +516,7 @@ int picolcd_init_framebuffer(struct picolcd_data *data)

 	fbdata = info->par;
 	spin_lock_init(&fbdata->lock);
+	mutex_init(&fbdata->update_lock);
 	fbdata->picolcd = data;
 	fbdata->update_rate = PICOLCDFB_UPDATE_RATE_DEFAULT;
 	fbdata->bpp     = picolcdfb_var.bits_per_pixel;
-- 
2.55.0
