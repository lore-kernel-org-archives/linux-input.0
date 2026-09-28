Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6FB4DAF8A
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612273; cv=pass; b=cGfh7hIGBjPMXBd4ySzsKxn2j4cV023rf7X0iOcmJJDrZsiGAwKt7N8Gr+aQj9YYW125XanU68cHRUVZ+6c+CPeK3fLxe2WQ1s4YMWrybohoqoiD3F+EUp9U2lY4HMsmL3qMwZFGqUrU6Kgry97CK8GbNsNUTtTA3qK88PDfUjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612273; c=relaxed/simple;
	bh=/9u3l8tvroAWhsZ3+bgszRdYGfDaF3Zw4nAXDtkGKNI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOH3O36uRLo7wp/XLXcn6lYlUou18XhiTHESOMtmQ1103/hu/1TVtGEAERmSoey4AaKO0/aRyXvPZ6h67cadzKI0feZU5lC9V613VIDO0KqPzx7p1Yw1wXeotuD3UE2lbn3ps9884FxRrOvnrepsKjpDDIalno9KS39JJiDLAl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7K4jm22; arc=pass smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7K4jm22"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4c650fea78aso1487266b6e.0
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 09:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612270; cv=none;
        d=google.com; s=arc-20260327;
        b=aw2Udz/MhUce+2S1lJGMe07KexBwMz0dWRbO33VxjzrBytRtAXQ9Joc7cq4xP/Uqby
         eLMIp9LJiViyIzlj9MUjS7Cw3JrIaS1qQkdP9I4DTULQV8GTBcqMehhK3GcX+uA3cIJI
         +GuK4yene4tri4t9mSc8tNvAQSCRCkZGYJQ10c1wvH46BG6lsNVVw8vVKhRWkyVvAwKW
         tbcGdNOS+X0lflnIibB4PrBCt8I6CRuG3Z7SQ0B6NP1uoIaBuiLEjhZNnOupEqDBK9jY
         Eo8lzccD0LI5mO7rS1ThveNkSJzE5gmjc97eX14nejujnHeHSucjFXAlfi1+bP8QaYSK
         NpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
        fh=jgbOxNfItUf1exIWwcmOwabuobq2AztmNRqcFYEq0w0=;
        b=kkG59+87DNvp9z9IwyaBVGC9B9vab3JaYIIQHbUlvu+dH0WyCjpIiEcCfhxB3zm6Bp
         y0VHOIZ7YwK4n5DgoFbGN6HNFCIshuKdntyMMz12TqrzpN5TB4TQ/VmGTmTi/EEFwgEP
         PqI/zxmYj25YKMvfGthQ8uzyUk39l0s+g+2hq/B8XjfaL9bHkiMhmxWYgdY3qhQ1EG8L
         QmgkuwAGyhS78Fv04CNNwZXJUO/T+oe7FWVDjIdsaQ04mGQFcEOFmMimvUllKg6FKWKy
         TJQhMTYdHI0mIQcMXnWmPoFLxHkTtTxQmozMj1M5S9YI76xLdzuRWdb3vBDumr340Tvo
         /Bhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612270; x=1791217070; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
        b=T7K4jm22TTyshae2BQw2pmgbgDt009kzc7b+aCWAh8Hox6+IZGJj6DdNnXUrZ0QsAG
         tZi7G6g5N6nh3qbbAKiiz6Okzwq+beTf+vJKN2KsupZ8hFJkyANbpJcBmH5dsfMo2nwK
         O6y//GA1tld7ZsZlAVQsIHvEUB7gZwOThyYqWlAb5I+4pYTq0IArU0OdhlqjYLMwtFbi
         DYIzmEQ147pZ6XMqa8PlZGY4iEBiIfmhGw+C2eyU63x4lw+cx6CbUJOqyMcSWWfS28KE
         kUXT2N2hNv/LVY8iiYwofbaX9b10gvafyjUlpBWlaTcnQmKspGzZkzAdXfvHPv7+L2w7
         31nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612270; x=1791217070;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAEzcqvZR7kY5FZwPLKlXWGuBFBAruI7pzeVz3Vqh4E=;
        b=NNP8cXp1+XS/7swHxOBnnrVosbUL+vEe+1KNJSkmAfVZmijWXNWrLENR35VpYmYFKc
         WA4wtGBYqe75wybwW8JWJNc6Z3kvL9cldSukCQaJFpJtikMGvLABf2FdRB/dxzl5cr0S
         YSgRrpdaMR3PNqc0EaH3eeBchrldVHkdDs+BWl/dzonYTkfSK+5X6CP+8SGF7e3NHtBF
         tJtREilknvDvBFMUqb4mjR3UUVcDnCnS4ijbBaC/Ppr+kTff2oneZyaRNt23Uh8+5jQf
         ShHQJz362V5C1kK1dk8gQn0QjcArfeIaSzxk/2C0ziz2aEoz6/0/FD3r1rCRg74r9ZSm
         e77g==
X-Gm-Message-State: AFuF++nxNOl10WFPjFyWt9Ingqfb+b/olsUl29XrAkBBPqWGxHtsHft5
	BCTB+PGiB507+LgImHA0fjUF5atw7WjutwyG+wwMQITbViNxmHm2B9TVSTQC5cPdQKhJH7iXNB1
	f2KUgIzTo5ErhnLVljhINQxtN1irHCPk=
X-Gm-Gg: AYBFou1NH1FOMDuc3uIMIP6eCcr852mI/lHF+tI+W5BW0z4qQ3Ki3UL1+k1OPMzz0pj
	UdajfqY/T1mKe8Pmdr2VbYTF9XH+SijbDfEHZuZcxYXop85ninuvXHGiqm/NhHH2DT04V3F3jBW
	1q4n1dLku8PZnMJrK5XbhUtchvbYNabkN6MMo1XonPhqnOlhLJjyMsM3F5iXhyNo7V3MaocLVMG
	zrTi14b70wz4dufiNc6MRn7o9q+kOd2MyGNgLlewTRO2pZpLZ6iMNaS/x2HaoeBLQ+vYuhdvmV1
	nZHUkBfzYGBTDSPWdv910u2xQetWvNE3wZ+s465S6UzL6PFMNVQhgQRjIVdieeh+B5x10GcgtiP
	g7zMmiA7BXA==
X-Received: by 2002:a05:6808:180f:b0:4ea:f4ab:dad7 with SMTP id
 5614622812f47-4eaf4abde31mr3114576b6e.43.1790612270217; Mon, 28 Sep 2026
 09:17:50 -0700 (PDT)
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 16:17:49 +0000
Received: from 578479312649 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 16:17:49 +0000
From: Aveline Noir <jm5905938@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 16:17:49 +0000
X-Gm-Features: AclHuK8BjruCpIs-y-znTwRHy4UbPVU7NoASXj59drlp5sgPwJENTSFHMkI16G0
Message-ID: <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com>
Subject: [PATCH v2 2/2] HID: picolcd: Avoid framebuffer last-close deadlock
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
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
