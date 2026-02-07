Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E22E413
	for <linux-input@vger.kernel.org>; Sat,  7 Feb 2026 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484605; cv=none; b=l4c0+BF9SBzKh83HF4G7Cq78EH/j/VJrNtFx3jqt2+qJsMZfovB4H7N7ICowT7aZpBpU35iU60bIJetOqdPJftgIYbZZRP5HUaNs10+fg7A048g7G8281RVW97+QmAEUlX7T9G3dN1GloXPa5IWPaSlctwki35RGjfKXdd4qFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484605; c=relaxed/simple;
	bh=zKLD+DbbJqH54KTsvU0CHzC7k1sPKI81Yoo4OEbtSvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KYHHCdrmWAS2KP/liJr3Sfdk4vB4zEwm9lBxB+DbK/uqYyUOExR2waOC7LD3IrNXnPwfvBi0jCDylAsOFJu2vjyaDALlbSD3F13TgKoo1FhExO7WmHmABlllJmEx37nZesOPJROck2Rp5rFAd0U4RKofsfajqaJErA5TT6ogIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8i7w08G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8i7w08G"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-436e87589e8so234173f8f.3
        for <linux-input@vger.kernel.org>; Sat, 07 Feb 2026 09:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770484603; x=1771089403; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqshB+s7IF5bznS0D4OoEhUU5UhfRazHq7a/Tv2HRpo=;
        b=U8i7w08GwSbvh6d/0JJYmgIn8Bf2qd0/D8IXBZTNdsMkHXuT6TuEEejjBydYrKW3cX
         L042YaPvckwA+BkQiMJ+ajSa8VAvG3d8tvl1uZZYjma4/+Uq9PoTwhEYB9f74qF3fQ0u
         CCvjhh+3jUvJ6MKtLpzaXd05BdAfbEEHCRAy4kBulT+3abYEC6cCOvJEz2ZVk3E54EBC
         Sl+NkzndbWqSWoUsrl41mf/uPM+9xRksjz6+kEZGqOBTUgpg4zOjaF9x5++Z8HwBlkVl
         e3qXKxXLRH6clJa7X6Q0djhmx8XFltvG+xNiIpA1IEfxRjPng6kJzQAjj4F1RSTHniMR
         Q/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484603; x=1771089403;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqshB+s7IF5bznS0D4OoEhUU5UhfRazHq7a/Tv2HRpo=;
        b=WvgYI3fUmB3SrOAdWwcYD21jgs32+AMf+VJY9Bh5ckhSCV+JOKLLLRMy1D0w7Iy6jD
         8+lgLqmSi/77cUU+juEYMBQN+QgYnM/etAG13XtcnxVWWWXitXQn+3VSr9DRdxx1mpjr
         JkCpNWTR0Un296P6UJq4bdfGDneio0lMEKdKGeIunYG+K+2bpcDmOKG56bPhTQet/aVd
         xtQF19J+pfnyUELFecT7Yx485lA7d/6whbW2ybGq24hRVJCM8PC25RNMnqhX41P7m9v7
         RkjZhenoxnVpR/iPq62r6XVST/oddETPaq5CiQIc34uHPdewuiqDF7ZF8CfoCH5Qkb53
         8STw==
X-Gm-Message-State: AOJu0YxyoTvuxycFGh2mRg58CIYdYeb2TFFNhcOuuS4xtNQ2A1YtqTgl
	YccssTlfRzfZvg+8ijb2lTG3qRruntfkxXOndrNWL9F1SBXCPunSHmcj
X-Gm-Gg: AZuq6aKkiTHJDXRRwe5ozdBPVjNZJ3UT5cxzqnwaVpuLlvY/WBU63uvPvJdQshJpRnY
	mGQI/RXm0sz2BMZMgD+Iio5ewOMoSqQQIrHARqIrNay8bJZsb/xls4kFbQ+2al6w4eV7e72CnDM
	LJO91PQCuLVPcVOppjeYDjxv1UHm7sD+5rWR8CVuakYyiaTeZUxQOEjNbKT2m9N+2mVMO4TWywI
	yl3mauYdxf9f3XC/+rm24GOwZaC2scJi/TiqDO5nhW06+LUB/3tsi8EO49J4OzDULb3vO2UxMyN
	yDtl27SsuimL2KsMdRTmzfishx6ifz8ahz0qh3nLM//FhtSwpHU3Ya6IKey6GLeojBKcJhtmpfh
	St0G+Ke9vt0qDKI2NS1IfyzVAPzmFU9WQfwnRHjrchd/OPssa52zzbp91GyKQB3YJzwdCR70IJ0
	XTcEPQUGLVxZ6y0aJ8nVd+xeyD6A==
X-Received: by 2002:a05:6000:2283:b0:436:3483:5c8 with SMTP id ffacd0b85a97d-43634830614mr3321448f8f.50.1770484603345;
        Sat, 07 Feb 2026 09:16:43 -0800 (PST)
Received: from [192.168.178.21] ([2001:9e8:fb8a:5800:22c9:d0ff:fe7b:79cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm14834460f8f.31.2026.02.07.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:16:42 -0800 (PST)
From: Liam Mitchell <mitchell.liam@gmail.com>
Date: Sat, 07 Feb 2026 18:16:26 +0100
Subject: [PATCH] bcm5974: recover from failed mode switch
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-bcm5974-reset-v1-1-af7163903fa6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwNz3aTkXFNLcxPdotTi1BJdC9Pk5JS05ERLMxNDJaCegqLUtMwKsHn
 RsbW1AKs4DAxfAAAA
X-Change-ID: 20260207-bcm5974-reset-85ccdfca9641
To: Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Liam Mitchell <mitchell.liam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770484602; l=3981;
 i=mitchell.liam@gmail.com; s=20260207; h=from:subject:message-id;
 bh=zKLD+DbbJqH54KTsvU0CHzC7k1sPKI81Yoo4OEbtSvc=;
 b=ArPOVDRn01GYEIJUh8nZvEZxHpwmSYcx6+cULsUm60ibb1Z74YygGoWxqwU7IkzHgqNIM0GSu
 YhxY1BEi7BgBT4BbSXdsF3/V4SWa5/mQSHUrS+uteXObH4mN4d0ByeG
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
---
 drivers/input/mouse/bcm5974.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index dfdfb59cc8b5..85ddd65f2603 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -286,6 +286,8 @@ struct bcm5974 {
 	const struct tp_finger *index[MAX_FINGERS];	/* finger index data */
 	struct input_mt_pos pos[MAX_FINGERS];		/* position array */
 	int slots[MAX_FINGERS];				/* slot assignments */
+	struct work_struct mode_reset_work;
+	unsigned long last_mode_reset;
 };
 
 /* trackpad finger block data, le16-aligned */
@@ -696,6 +698,34 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 	return retval;
 }
 
+/*
+ * Mode switches sent before the control response are ignored.
+ * Fixing this state requires switching to normal mode and waiting
+ * 1ms before switching back to wellspring mode.
+ */
+static void bcm5974_mode_reset_work(struct work_struct *work)
+{
+	int error;
+	struct bcm5974 *dev = container_of(work, struct bcm5974, mode_reset_work);
+
+	mutex_lock(&dev->pm_mutex);
+	dev->last_mode_reset = jiffies;
+
+	error = bcm5974_wellspring_mode(dev, false);
+	if (error) {
+		dprintk(1, "bcm5974: reset to normal mode failed\n");
+		goto out;
+	}
+
+	msleep(1);
+
+	error = bcm5974_wellspring_mode(dev, true);
+	if (error)
+		dprintk(1, "bcm5974: mode switch after reset failed\n");
+ out:
+	mutex_unlock(&dev->pm_mutex);
+}
+
 static void bcm5974_irq_button(struct urb *urb)
 {
 	struct bcm5974 *dev = urb->context;
@@ -752,10 +782,18 @@ static void bcm5974_irq_trackpad(struct urb *urb)
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
+			schedule_work(&dev->mode_reset_work);
+		}
+	}
+
 exit:
 	error = usb_submit_urb(dev->tp_urb, GFP_ATOMIC);
 	if (error)
@@ -906,6 +944,8 @@ static int bcm5974_probe(struct usb_interface *iface,
 	dev->intf = iface;
 	dev->input = input_dev;
 	dev->cfg = *cfg;
+	dev->last_mode_reset = 0;
+	INIT_WORK(&dev->mode_reset_work, bcm5974_mode_reset_work);
 	mutex_init(&dev->pm_mutex);
 
 	/* setup urbs */
@@ -998,6 +1038,7 @@ static void bcm5974_disconnect(struct usb_interface *iface)
 {
 	struct bcm5974 *dev = usb_get_intfdata(iface);
 
+	cancel_work_sync(&dev->mode_reset_work);
 	usb_set_intfdata(iface, NULL);
 
 	input_unregister_device(dev->input);

---
base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
change-id: 20260207-bcm5974-reset-85ccdfca9641

Best regards,
-- 
Liam Mitchell <mitchell.liam@gmail.com>

