Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CE34D4CB
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974759; cv=none; b=rsQeXXRau/0GSvlYswEUIPWynA80+BCUxc1ecJtKOeC1wpLhI0LxHiCVkM7OtlyAelf9VIistBhzisl2Ylrv4OkwStP6IPIPpKnfeMeeaxqZIsFd9FbgJqZGMYh104p4RUdOLhrmgQoYSpUWLpOOUqZRAOVy/p4+c8t3yk+wG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974759; c=relaxed/simple;
	bh=4Ij2NBoCIlNWCY0qDQILXOuDEmN9GJTc5JcYF6tAQvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nSzWj4mFdYrm/N1YFc+hL0wnhfAon4kbu7/9P2wc3OQ5IRre/dzD8VyQpK1SIopxYU3cjTSBfddFSmbIcvQjKuqOQNWQfU2gmAF9IDiSfiRkdASxfa5jsArtmxmfe2zUqLCQDx2zZGqoUoeCpg8Z6UUnyxvtH3eBsW4atDJOM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJDH8adf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJDH8adf"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so3128215e9.3
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770974756; x=1771579556; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U422Lt4MbhlsafmUTkDHvhgOOQ/KQODiSAzag8Wg63s=;
        b=FJDH8adfhN9Vjk+JRzj1w5w15n0ErrQ1MXCQ1S1aGSxgvpjK+mGRm7tU9rDYPpPpZt
         rapnWTC5V6D47wDhh7ciaJkfZCGErVwwPJBZJQ65PD6ZmcQulg4VOYVbWuKJKAX3pBpU
         zpZDkH77Xl+DpdaAdloZyaUz7nPhU+dHTHqw+I5cbKOgVn+wTkmcxwOtQGHlQIo8Xu65
         8hryABHBn6yDXFZ37bijXYajApguXUBqt6oESCnI2T8uAGtYMTmoW4TpJM49l1U2a6I0
         qVD4yH2ZB0dYC5hpmckYfbapGAsJ5XxhOWYmgY1c5LzmXP2oGzwkwL96T65XlJ+wxsnI
         vz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770974756; x=1771579556;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U422Lt4MbhlsafmUTkDHvhgOOQ/KQODiSAzag8Wg63s=;
        b=YsFEjJVQSCnn1EnDkqJ2aF6DW0CMdyz7y9xT+9pg7uVdypYTb01nhMoy5GqFsvlh41
         tUag1qfMmiAdZH28Fo/nBsKblk5AQxbC4hSD0LHhNpHz6KXo7FgUl7QV8OKuV+JK0CI5
         V+Fdb0H2TPkerQg0Er8KXwziEbqSg9msp/G9p21HWwtw6/0CHPiaKCsM7Qp+Oxs38imc
         PVz05KZUbW8eagtUPCb8nLSaISciL+4SIFbHy17J6XZlemmP0oKbBs+Oo1XfWUNfak13
         ufn+ytV2tB/0/z4kLMzF5dAs2BDPvOOsLPNRdUsF3eBZTI06biMEW2Ib4VO1uGI3osJ5
         ehMA==
X-Gm-Message-State: AOJu0YxPZf7XptNe/BTMNHblOH452HXfnnlXePusoqPx9HMDhgMq1ZW7
	CAWyyCepzIuK80dMOpDz+ofAMJ0lkA1idyE5NLIzhV3iAUAEBGlbF6de
X-Gm-Gg: AZuq6aKOx3kMXIBpsW0meIzf4bGnOhN9EW++DirRr7GOndHAz20UdBNozl0CYu22saR
	dDxQxrLrYpHism+Y8d0pKpVL4yDa8xKTKLuBasaMsvCiS2KZsFzUyBh5Ihowlm2HqCLKNMHJQoT
	EoCvK1ZU+7GOvV4mKPyxMGoPsxFfgyoaK3wzqeO6/aaTcM+muJWegDYPk8EhsnaTeqVXW9/aCp0
	XPcuJQaoyi/o4/VE6NFNeFSmZOG38vRt3DMrl/oOb3cBfImMg2UwzXT05aX6ga3FEy4lyO5VT7Z
	QYwdh0ALNsi9U8fDBIbuVvKyRssbJYdG5L+WusiAi/YcB1D6ZPDX4CoqtxZs7ekw7qzl2zTjXwL
	LbCvE76q+mOsUurX8FusX2ItzPbZxccT656B3yuc+Tj4HjXrDHBzrd0hzGELQxQZ4rtxTa03r43
	It9nDDgb6VfjXbzQWYMEhZjaQDLtQrs4YNWS9GRg==
X-Received: by 2002:a05:600c:4e4d:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-48373a3e749mr17358265e9.22.1770974755835;
        Fri, 13 Feb 2026 01:25:55 -0800 (PST)
Received: from [192.168.178.21] ([2001:9e8:fba1:9200:22c9:d0ff:fe7b:79cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a41be2sm24302765e9.1.2026.02.13.01.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 01:25:55 -0800 (PST)
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Fri, 13 Feb 2026 10:25:40 +0100
Subject: [PATCH v2] bcm5974: recover from failed mode switch
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-bcm5974-reset-v2-1-1837851336b0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ7CIBCF4as0sxYDtAXrynuYLpAO7SRSDDRE0
 3B3sXuX/0vet0PCSJjg2uwQMVOisNaQpwbsYtYZGU21QXKpuOSaPazvB92xiAk3dumtnZw1g+o
 E1M8roqP34d3H2gulLcTPwWfxW/9JWTDBjNNCtQNvnVG32Rt6nm3wMJZSvnMijjyqAAAA
X-Change-ID: 20260207-bcm5974-reset-85ccdfca9641
To: Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liam Mitchell <mitchell.liam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770974754; l=4355;
 i=mitchell.liam@gmail.com; s=20260207; h=from:subject:message-id;
 bh=4Ij2NBoCIlNWCY0qDQILXOuDEmN9GJTc5JcYF6tAQvU=;
 b=5IeXF00uQBUO/z2qvJjGtiewVRhLOQcBzlCo/8zJFtPN6yIeeXjKEKqGpMl72WbDVURD3jslk
 r+4eNYOzKYyDkxPkBADotIJksVOcYTLxP39gCdNeDU2rMoHfwkWOJuE
X-Developer-Key: i=mitchell.liam@gmail.com; a=ed25519;
 pk=Y9mPqBk1OuHZ0OaUZ5a8Nc5X7YHs7+SKiNwUfcLfPmg=

Mode switches sent before control response are ignored.
On receiving unknown 8-byte packets, assume that mode switch was ignored
and reset by switching to normal mode, waiting then switching back to
wellspring mode.

---
This patch addresses an issue where the bcm5974 driver switches modes
before the device is ready, resulting in an unresponsive trackpad and
"bcm5974: bad trackpad package, length: 8" repeated in logs.

Discussion of issue in the thread:
https://lore.kernel.org/linux-input/CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com/

This fix is conservative, avoiding changing existing mode-switch
behavior because I cannot test all variations of hardware.

On receiving an unknown 8-byte packet, we assume the device is not in
wellspring mode and schedule an asynchronous mode reset.

Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
Link: https://lore.kernel.org/linux-input/CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com/
---
Changes in v2:
- mutex_lock -> guard(mutex)
- dprintk -> dev_err
- msleep -> fsleep
- removed 0 init
- cancel_work_sync -> disable_delayed_work_sync
- work_struct -> delayed_work
- Link to v1: https://lore.kernel.org/r/20260207-bcm5974-reset-v1-1-af7163903fa6@gmail.com
---
 drivers/input/mouse/bcm5974.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index dfdfb59cc8b5..6ee766ed8402 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -286,6 +286,8 @@ struct bcm5974 {
 	const struct tp_finger *index[MAX_FINGERS];	/* finger index data */
 	struct input_mt_pos pos[MAX_FINGERS];		/* position array */
 	int slots[MAX_FINGERS];				/* slot assignments */
+	struct delayed_work mode_reset_work;
+	unsigned long last_mode_reset;
 };
 
 /* trackpad finger block data, le16-aligned */
@@ -696,6 +698,32 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 	return retval;
 }
 
+/*
+ * Mode switches sent before the control response are ignored.
+ * Fixing this state requires switching to normal mode and waiting
+ * about 1ms before switching back to wellspring mode.
+ */
+static void bcm5974_mode_reset_work(struct work_struct *work)
+{
+	int error;
+	struct bcm5974 *dev = container_of(work, struct bcm5974, mode_reset_work.work);
+
+	guard(mutex)(&dev->pm_mutex);
+	dev->last_mode_reset = jiffies;
+
+	error = bcm5974_wellspring_mode(dev, false);
+	if (error) {
+		dev_err(&dev->intf->dev, "reset to normal mode failed\n");
+		return;
+	}
+
+	fsleep(1000);
+
+	error = bcm5974_wellspring_mode(dev, true);
+	if (error)
+		dev_err(&dev->intf->dev, "mode switch after reset failed\n");
+}
+
 static void bcm5974_irq_button(struct urb *urb)
 {
 	struct bcm5974 *dev = urb->context;
@@ -752,10 +780,18 @@ static void bcm5974_irq_trackpad(struct urb *urb)
 	if (dev->tp_urb->actual_length == 2)
 		goto exit;
 
-	if (report_tp_state(dev, dev->tp_urb->actual_length))
+	if (report_tp_state(dev, dev->tp_urb->actual_length)) {
 		dprintk(1, "bcm5974: bad trackpad package, length: %d\n",
 			dev->tp_urb->actual_length);
 
+		/* HID packet means we aren't in wellspring mode */
+		/* If we haven't tried a reset in the last second, try now */
+		if (dev->tp_urb->actual_length == 8 &&
+		    time_after(jiffies, dev->last_mode_reset + msecs_to_jiffies(1000))) {
+			schedule_delayed_work(&dev->mode_reset_work, 0);
+		}
+	}
+
 exit:
 	error = usb_submit_urb(dev->tp_urb, GFP_ATOMIC);
 	if (error)
@@ -906,6 +942,7 @@ static int bcm5974_probe(struct usb_interface *iface,
 	dev->intf = iface;
 	dev->input = input_dev;
 	dev->cfg = *cfg;
+	INIT_DELAYED_WORK(&dev->mode_reset_work, bcm5974_mode_reset_work);
 	mutex_init(&dev->pm_mutex);
 
 	/* setup urbs */
@@ -998,6 +1035,7 @@ static void bcm5974_disconnect(struct usb_interface *iface)
 {
 	struct bcm5974 *dev = usb_get_intfdata(iface);
 
+	disable_delayed_work_sync(&dev->mode_reset_work);
 	usb_set_intfdata(iface, NULL);
 
 	input_unregister_device(dev->input);

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20260207-bcm5974-reset-85ccdfca9641

Best regards,
-- 
Liam Mitchell <mitchell.liam@gmail.com>

