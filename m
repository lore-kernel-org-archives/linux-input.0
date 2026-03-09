Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4153CCA0D
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071579; cv=none; b=kUWm1JybgHUUPeaO7AwflSmmHqcGfaBIfy02TDfzDPEMp14pCcIPoxcCQSXIlB5qQ0mkq0HpyVMMt6az6CznWIPowLJy4exIkPts9KFoAgjQqtTAzIPG6nPgvBMOTpw3uh3b+L1qv4Wczd4+7CL0N6luiduubEEw2ISpmVsX2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071579; c=relaxed/simple;
	bh=iWVCH2yklbl9N7AcxKQ+vGMdANbmkzkqn9Aa+siws5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hG3DXHvHGm5nDZ4Etgofn06qpd/JEmR3PpbcczJgNdj/GcApXWBZzOzX+ZkQGdlWxsv425himNe7hv1RfYqgVct/8idKepNiQqn/l4dLSvHvgsgwPE5PPWsCCo/G3vajS1b1rNSCNKxrv0YVLuxBahctAs8sFSwrEHGVF5nsYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVo3Z8C1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVo3Z8C1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c9eb5d36so4856958f8f.2
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773071576; x=1773676376; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IhpgDcAFUhFb6KTnVULUhmATOOLbhT8RuXZbX1GI4fU=;
        b=YVo3Z8C1BMSXK0iJoj9zWD5eiLaVdVmGB/QMYkWt/jfbvjN6RdhrHo9NweEAjnxesK
         7x41IMubrY1IS7Rl6Mh1Zvr5yxd9XDxoln5L2xbXFCEDta98/U4gP80Uplpf71oKZb33
         BJp6PE9AsrAlfdgg+q+XT7+2ch6IrM03+DInhcl1KRVochnZoVRlhJIpQw6aGlx7bUCE
         rwpYr/Tz4bOugrEnafxxQJ9Oso9qLeFjRStc/YkAnf2taxFmBB3QuCGRp6h99G1cK8Gk
         qrIU4EwA2egMDLPw9GodcgLITkHkNm/qNZ8e1ChO+siEj35WJ2eYktV3CSgzWznDZ4lH
         aUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071576; x=1773676376;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhpgDcAFUhFb6KTnVULUhmATOOLbhT8RuXZbX1GI4fU=;
        b=cKFwirUKle7q3qVyEKC2uBhKZla7l1Q3f/tK/EVw3iXQ1EOG5oFmalBHseRnGimE/N
         4ZAfWc2Za8YTLWl9Xh0v+R7OYeDAV0T7Io3UrdQ4eF3OLSozvaf8IFf3XtEw1UtUr7lR
         Tr/gmZmQkSJXUayO2Ii2PjX4vXzIuIUC5GdwRvJCB6oQ5fVllwop7NafNuHE8leJ7a3G
         p1TenBzJLSnDqZDsyC2zmvfCempi5bWAO6WBTHVHGLcULNNrgtRoIoNLbTTh4wIrZoXx
         g8jGw2gO2C2yhJBf7T2syh8Jj9A+MEtJbUagOTDenve8h3sqKgai5weE1S3XIygXSIgb
         gssQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoPtLRgZMKb4AckqkrbcRHLiERcyjuICQWQvl54eCyWo8Xrh9EXqIqjvvTh6Pu2etcG8+LE3I0SsKKpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vEZQbk25FaQFuTeaCE6mTpfbzO8hgKBHGOET7z1xPI1IZPUu
	mO72VngoY0yugQjXN1myOWpdebhITmJCWGW3v0GbUZEyWFWoieaNP3KPCXztPFO/JSQ=
X-Gm-Gg: ATEYQzw7ddbOo/imSlARTRXBwTXyaeigYSMLhAxQkw0HXlxVPW2Ymb1rL5qUA0V3aGw
	tncVaT5X3C0/OCOfnrH+K02F1hdmdQ5/j+t8nMFshJ+WCMLmB5LAnTYmmFf4pOOoqYsiONaLT0o
	/rjcW0drJ+L4lz8JmvRx/aBHIpKl0rfd4QKDtSVWW2FOcEUWnMJ0u4/HTsL2nJltRgKM4vPxNsy
	vI4+aXFEPPOW/+rkBAr4RvWt12rkVuIGRSxwBT5DxvQf384tHX6pkf96h3Ttgy1Ejuco1RAIEgx
	/pHZHf1dlxiv+g8fYsOqz7GTNrfytK77lsE/QS7tDC/6tuzIfUnYicFaRK63oKn/t4bNlFnJzYh
	aVmOLVW52ZK3SkIdBF49JVssaqG3j8CWtfooaqVzoSQfOVOO3cWhOZsktL3/uj2UE7JeGAK4sF5
	sB+nwO8f2VkfAyUqOuT8ZhHXZFVUTK1ckYUuS6
X-Received: by 2002:a05:6000:3108:b0:439:ad3a:b737 with SMTP id ffacd0b85a97d-439da35f75amr21842270f8f.35.1773071575494;
        Mon, 09 Mar 2026 08:52:55 -0700 (PDT)
Received: from [192.168.178.21] ([2001:9e8:fbbc:100:22c9:d0ff:fe7b:79cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba66sm24243288f8f.20.2026.03.09.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:52:54 -0700 (PDT)
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Mon, 09 Mar 2026 16:52:29 +0100
Subject: [PATCH v3] usbhid: tolerate intermittent errors
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-usbhid-eproto-v3-1-23bd841dfc91@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwQ6CMBAFf4X0bE27WKie/A/joS0rbCKUtNhoC
 P9u4aIx8TgvmcmbWcRAGNmpmFnARJH8kKHcFcx1ZmiRU5OZgYBKgND8EW1HDccx+MlzqcDVxjo
 rtWLZGQPe6Ln1LtfMHcXJh9eWT3Jd/5WS5JIrXYOTojkKa89tb+i+d75naynBxy5F/WtDtlEZn
 b/goVLwbS/L8gZe6XHS6AAAAA==
X-Change-ID: 20260208-usbhid-eproto-152c7abcb185
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liam Mitchell <mitchell.liam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773071574; l=7440;
 i=mitchell.liam@gmail.com; s=20260207; h=from:subject:message-id;
 bh=iWVCH2yklbl9N7AcxKQ+vGMdANbmkzkqn9Aa+siws5o=;
 b=9e9bCq0SwuHrS13t56iVkRSO+65jnshIMHN6EgjL3eUUIQxm4shkucwvwQj1CLvaPVKPqjTBD
 fg/m17pp276AV9E8O4Vu/8g+CfMMHtQtTkwr/DKom7N8kPo/bOYipym
X-Developer-Key: i=mitchell.liam@gmail.com; a=ed25519;
 pk=Y9mPqBk1OuHZ0OaUZ5a8Nc5X7YHs7+SKiNwUfcLfPmg=

Modifies usbhid error handling to better tolerate intermittent
errors, reducing URB resubmission delay and device resets.

---
Protocol errors like EPROTO can occur randomly, sometimes frequently and
are often not fixed by a device reset.

The current error handling will only resubmit the URB after at least 13ms
delay and may reset the USB device if another error occurs 1-1.5s later, 
regardless of error type or count.

These delays and device resets increase the chance that input events will be
missed and that users see symptoms like missed or sticky keyboard keys.

This patch reduces the threshold used to assume device is working after
discussion in V2. Truly disconnected devices should error after 3 polling
intervals.

It allows single protocol errors to be retried immediately for minimal
downtime.

It changes the retry timeout to be relative to the last input URB
submission so time spent active counts towards the delay.
This makes it more likely that subsequent intermittent errors can be
retried on the next tick.

It only tries reset after 20 errors, roughly about 2s, longer than the
previous time based threshold of 1-1.5s.

Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
Link: https://lore.kernel.org/linux-input/CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com/
---
Changes in v3:
- uses shorter threshold to assume device is working
- stop_retry & retry_delay -> error_count & last_in
- retry after 20 errors
- includes running time in retry timeout calc
- immediate retry case is integrated with other error logic
- shortens initial retry delay to 1ms
- changes max delay to 128ms
- Link to v2: https://lore.kernel.org/r/20260307-usbhid-eproto-v2-1-e5a8abce4652@gmail.com

Changes in v2:
- revert changes to hid_io_error
- add more specific fix in hid_irq_in
- Link to v1: https://lore.kernel.org/r/20260208-usbhid-eproto-v1-1-5872c10d90bb@gmail.com
---
 drivers/hid/usbhid/hid-core.c | 44 ++++++++++++++++++++++++++++---------------
 drivers/hid/usbhid/usbhid.h   |  4 ++--
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 758eb21430cd..233c1950632a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -70,6 +70,12 @@ MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
 		" quirks=vendorID:productID:quirks"
 		" where vendorID, productID, and quirks are all in"
 		" 0x-prefixed hex");
+
+/* Threshold at which we can assume a device is working correctly.
+ * A disconnected device should fail within 3 polling intervals.
+ * Most HID devices poll 8ms or faster. */
+#define HID_ASSUME_WORKING msecs_to_jiffies(100)
+
 /*
  * Input submission and I/O error handler.
  */
@@ -90,6 +96,7 @@ static int hid_start_in(struct hid_device *hid)
 	    !test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
 	    !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
 	    !test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
+		usbhid->last_in = jiffies;
 		rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
 		if (rc != 0) {
 			clear_bit(HID_IN_RUNNING, &usbhid->iofl);
@@ -154,19 +161,13 @@ static void hid_io_error(struct hid_device *hid)
 		goto done;
 
 	/* If it has been a while since the last error, we'll assume
-	 * this a brand new error and reset the retry timeout. */
-	if (time_after(jiffies, usbhid->stop_retry + HZ/2))
-		usbhid->retry_delay = 0;
-
-	/* When an error occurs, retry at increasing intervals */
-	if (usbhid->retry_delay == 0) {
-		usbhid->retry_delay = 13;	/* Then 26, 52, 104, 104, ... */
-		usbhid->stop_retry = jiffies + msecs_to_jiffies(1000);
-	} else if (usbhid->retry_delay < 100)
-		usbhid->retry_delay *= 2;
+	 * this a brand new error and reset the error count. */
+	if (time_after(jiffies, usbhid->last_in + HID_ASSUME_WORKING))
+		usbhid->error_count = 0;
 
-	if (time_after(jiffies, usbhid->stop_retry)) {
+	usbhid->error_count++;
 
+	if (usbhid->error_count >= 20) {
 		/* Retries failed, so do a port reset unless we lack bandwidth*/
 		if (!test_bit(HID_NO_BANDWIDTH, &usbhid->iofl)
 		     && !test_and_set_bit(HID_RESET_PENDING, &usbhid->iofl)) {
@@ -176,8 +177,13 @@ static void hid_io_error(struct hid_device *hid)
 		}
 	}
 
-	mod_timer(&usbhid->io_retry,
-			jiffies + msecs_to_jiffies(usbhid->retry_delay));
+	/* Retry time is relative to the last start time and increases
+	 * with error count: 1, 2, 4, 8, 16, 32, 64, 128, 128... ms.
+	 * By including running time in the backoff, it should be possible
+	 * to retry many intermittent errors in the next tick. */
+	mod_timer(&usbhid->io_retry, usbhid->last_in +
+			msecs_to_jiffies(1U << (min(usbhid->error_count, 8U) - 1)));
+
 done:
 	spin_unlock_irqrestore(&usbhid->lock, flags);
 }
@@ -278,7 +284,7 @@ static void hid_irq_in(struct urb *urb)
 
 	switch (urb->status) {
 	case 0:			/* success */
-		usbhid->retry_delay = 0;
+		usbhid->error_count = 0;
 		if (!test_bit(HID_OPENED, &usbhid->iofl))
 			break;
 		usbhid_mark_busy(usbhid);
@@ -312,6 +318,13 @@ static void hid_irq_in(struct urb *urb)
 	case -EPROTO:		/* protocol error or unplug */
 	case -ETIME:		/* protocol error or unplug */
 	case -ETIMEDOUT:	/* Should never happen, but... */
+		/* Allow first error to retry immediately */
+		if (usbhid->error_count == 0 ||
+		    time_after(jiffies, usbhid->last_in + HID_ASSUME_WORKING)) {
+			dev_dbg(&usbhid->intf->dev, "retrying intr urb immediately\n");
+			usbhid->error_count = 1;
+			break;
+		}
 		usbhid_mark_busy(usbhid);
 		clear_bit(HID_IN_RUNNING, &usbhid->iofl);
 		hid_io_error(hid);
@@ -321,6 +334,7 @@ static void hid_irq_in(struct urb *urb)
 			 urb->status);
 	}
 
+	usbhid->last_in = jiffies;
 	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status) {
 		clear_bit(HID_IN_RUNNING, &usbhid->iofl);
@@ -1504,7 +1518,7 @@ static void hid_restart_io(struct hid_device *hid)
 
 	if (clear_halt || reset_pending)
 		schedule_work(&usbhid->reset_work);
-	usbhid->retry_delay = 0;
+	usbhid->error_count = 0;
 	spin_unlock_irq(&usbhid->lock);
 
 	if (reset_pending || !test_bit(HID_STARTED, &usbhid->iofl))
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 75fe85d3d27a..b5dbfa588dc8 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -84,8 +84,8 @@ struct usbhid_device {
 	spinlock_t lock;						/* fifo spinlock */
 	unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 	struct timer_list io_retry;                                     /* Retry timer */
-	unsigned long stop_retry;                                       /* Time to give up, in jiffies */
-	unsigned int retry_delay;                                       /* Delay length in ms */
+	unsigned int error_count;                                       /* Number of consecutive errors */
+	unsigned long last_in;                                          /* Time of last in URB submission */
 	struct work_struct reset_work;                                  /* Task context for resets */
 	wait_queue_head_t wait;						/* For sleeping */
 };

---
base-commit: b91e36222ccfb1b0985d1fcc4fb13b68fb99c972
change-id: 20260208-usbhid-eproto-152c7abcb185

Best regards,
-- 
Liam Mitchell <mitchell.liam@gmail.com>

