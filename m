Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBC34252B
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872939; cv=none; b=amM1KPKIy+POZPIiGf+Q8n0HEy1udk9az+R4kcyi3Gnaov2pTLfOjiB+wuZPvVZPo4JdYpJ8HfprmRNnaVRvOD7e+wp2dj40FQaFsAAY5QOlB4EfGK6V+GEuiMl/A76TxqsKpNS3bVTmJfaf7/4L8KlDJja5LlMP7XxwtJ1DCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872939; c=relaxed/simple;
	bh=cqWgqzqpt+dQ5ALw5z2iwRwMlyE1bSGGQ21Nab/4J3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmHtY0H4kdxR79xvTLewKixpboibaPlF2VgvsIImh2BRiAxRUkpKq+fk46JIFABHK8kXhnoylUZiaaWWFR6uzyUi8ZrTD984/muqC8i5VwmguCNiWeGolGWeKesoREk7WSrZMbkOkS0cNoQc2fGDXMcGCu+oPX47fEzy9aJiK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1976775a91.2
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 09:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872936; x=1784477736;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nT7yTkEDfYcf9lWdgojrnVs0B+arz0FgBansL9gvOaQ=;
        b=Aw0Ta/TByrA6BjyL71FW9R7kYbRZyWeykSsn7dYPewlpZr2wkF5kvgBdXtm9Ys83mj
         EbyifnapN5sPPG/LQXTkLc2CMzqOuAcNknocz9o02k0z32vo0IafhgpH2j2XQ3qKvpSB
         vAfFkmt4VJBhbhDmey975XsLMS/WZnal0VYge2E+Ui7Nt2jLSERjXfilzBsh42HRcoDN
         S+/heAAt7pRy6levNEFf30xQl2MMJS7eCnTo7NWM/iRivJwyTgdjXQ7/5QgqW9d3CX+A
         4BsofVtNaMEehZDrTUiv5l6o8HoTXrT1gcI1dqXuIrpq2hIDMC0W6QuS67GM9k9GgNvI
         b5bg==
X-Gm-Message-State: AOJu0YyDP4R2XR3t562CTZpft26COk5fOcNgdXlklIIrNm44XWZXdkXk
	TFHNYqUw+b2lQ+BlY3UkE1p488LnED5cNMxVRzGrtu0yYVn6+M0C2MQ=
X-Gm-Gg: AfdE7cnv7sd9pHqAIpnXBF4+VT7syi0kWJFeySa9NF+Fayye9wJlW9wUtcYVPxFMEch
	V6Ox68onoYzlhD3wbaiFFroRU+nKEoIen4Tikq/32kOX8Z/tc0+88Oj9ANrEqzE7Q3JrG6nNGVi
	cztlOCUpHJNBNJjF3Zb1Zbu6rcuuBQVhn71ef+cgOeU8FKVjsuGsE0ky6y1x/n4ZorSurFA0zow
	Ap1SW+QbwinKm30FFCOIh3qd3P8TewlW3GKwG3w9d9auE+1jcsMhaSOFN/tQnWDCJSFgpnScgKK
	aSQLkKvwz7WMPeg3mMzd4lifgOww3+GbRlhe1QCjLIgJsKLjP9NBgqqeahCuNWZTutIIh7/pOAh
	ult3eIQ6zrN/XVm0Hj2StM0P3y0F78yxzpgGZAIQlQSK1pWtH+fv7I3z7/IJfCx5BAiX0ZlLNtT
	4hFt4fGJTD97q4iNi8geyesoYu5ViCblWTwLBXX3fYLsRU7St5t89W9GX5ke5N4WFvMIRD2BVBp
	zzvJecQ+dTERDIpgQ0qykyvksfqu2wz1Y/mxe8=
X-Received: by 2002:a17:90b:3d4b:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-38dc782ab85mr5724754a91.2.1783872936006;
        Sun, 12 Jul 2026 09:15:36 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm51034331eec.20.2026.07.12.09.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:15:35 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>,
	=?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH 1/2] Input: applespi - register touchpad device synchronously in probe
Date: Mon, 13 Jul 2026 00:15:26 +0800
Message-Id: <20260712161527.7350-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712161527.7350-1-fourdollars@debian.org>
References: <20260712161527.7350-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Touchpad registration is currently done asynchronously from a worker
thread because it can sleep. This leads to high-severity unbind/remove
use-after-free vulnerabilities and debugfs race conditions (userspace
opening tp_dim debugfs file before touchpad_input_dev is initialized).

Simplify the driver and make it robust by making the touchpad detection and
registration synchronous in the probe function. Introduce a timeout of
3 seconds when waiting for the touchpad info response packet, and add
3 second timeouts to the drain functions to prevent suspend/remove hangs.
Define probe_type as PROBE_PREFER_ASYNCHRONOUS so that the probe is run
asynchronously by the driver core, preventing boot delays.

This obsoletes the need for async work cancellation on driver remove
and debugfs NULL pointer checks.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Based-on-patch-by: Ronald Tschalär <ronald@innovation.ch>
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 148 ++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 30 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..c1065a6ba96c 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -417,11 +417,16 @@ struct applespi_data {
 
 	bool				suspended;
 	bool				drain;
-	wait_queue_head_t		drain_complete;
+	wait_queue_head_t		wait_queue;
 	bool				read_active;
 	bool				write_active;
 
-	struct work_struct		work;
+	struct applespi_complete_info {
+		void				(*complete)(void *context);
+		struct applespi_data		*applespi;
+	}				spi_complete[2];
+	bool				cancel_spi;
+
 	struct touchpad_info_protocol	rcvd_tp_info;
 
 	struct dentry			*debugfs_root;
@@ -607,13 +612,61 @@ static void applespi_setup_write_txfrs(struct applespi_data *applespi)
 	spi_message_add_tail(st_t, msg);
 }
 
+static bool applespi_async_outstanding(struct applespi_data *applespi)
+{
+	return applespi->spi_complete[0].complete ||
+	       applespi->spi_complete[1].complete;
+}
+
+static void applespi_async_complete(void *context)
+{
+	struct applespi_complete_info *info = context;
+	struct applespi_data *applespi = info->applespi;
+	unsigned long flags;
+
+	info->complete(applespi);
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+
+	info->complete = NULL;
+
+	if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
+		wake_up_all(&applespi->wait_queue);
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+}
+
 static int applespi_async(struct applespi_data *applespi,
 			  struct spi_message *message, void (*complete)(void *))
 {
-	message->complete = complete;
-	message->context = applespi;
+	struct applespi_complete_info *info;
+	int sts;
 
-	return spi_async(applespi->spi, message);
+	if (applespi->cancel_spi) {
+		if (!applespi_async_outstanding(applespi))
+			wake_up_all(&applespi->wait_queue);
+		return -ESHUTDOWN;
+	}
+
+	/*
+	 * There can only be at most 2 spi requests in flight, one for "reads"
+	 * and one for "writes".
+	 */
+	if (!applespi->spi_complete[0].complete)
+		info = &applespi->spi_complete[0];
+	else
+		info = &applespi->spi_complete[1];
+	info->complete = complete;
+	info->applespi = applespi;
+
+	message->complete = applespi_async_complete;
+	message->context = info;
+
+	sts = spi_async(applespi->spi, message);
+	if (sts)
+		info->complete = NULL;
+
+	return sts;
 }
 
 static inline bool applespi_check_write_status(struct applespi_data *applespi,
@@ -677,7 +730,7 @@ static int applespi_setup_spi(struct applespi_data *applespi)
 		return sts;
 
 	spin_lock_init(&applespi->cmd_msg_lock);
-	init_waitqueue_head(&applespi->drain_complete);
+	init_waitqueue_head(&applespi->wait_queue);
 
 	return 0;
 }
@@ -725,7 +778,7 @@ static void applespi_msg_complete(struct applespi_data *applespi,
 		applespi->write_active = false;
 
 	if (applespi->drain && !applespi->write_active)
-		wake_up_all(&applespi->drain_complete);
+		wake_up_all(&applespi->wait_queue);
 
 	if (is_write_msg) {
 		applespi->cmd_msg_queued = 0;
@@ -963,12 +1016,18 @@ static void applespi_debug_update_dimensions(struct applespi_data *applespi,
 static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 {
 	struct applespi_data *applespi = inode->i_private;
+	struct input_dev *touchpad;
 
 	file->private_data = applespi;
 
+	/* Pairs with smp_store_release in applespi_register_touchpad_device() */
+	touchpad = smp_load_acquire(&applespi->touchpad_input_dev);
+	if (!touchpad)
+		return -ENODEV;
+
 	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
 		 "0x%.4x %dx%d+%u+%u\n",
-		 applespi->touchpad_input_dev->id.product,
+		 touchpad->id.product,
 		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
 		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
 		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);
@@ -1324,26 +1383,14 @@ applespi_register_touchpad_device(struct applespi_data *applespi,
 	return 0;
 }
 
-static void applespi_worker(struct work_struct *work)
-{
-	struct applespi_data *applespi =
-		container_of(work, struct applespi_data, work);
-
-	applespi_register_touchpad_device(applespi, &applespi->rcvd_tp_info);
-}
-
 static void applespi_handle_cmd_response(struct applespi_data *applespi,
 					 struct spi_packet *packet,
 					 struct message *message)
 {
 	if (packet->device == PACKET_DEV_INFO &&
 	    le16_to_cpu(message->type) == 0x1020) {
-		/*
-		 * We're not allowed to sleep here, but registering an input
-		 * device can sleep.
-		 */
 		applespi->rcvd_tp_info = message->tp_info;
-		schedule_work(&applespi->work);
+		wake_up_all(&applespi->wait_queue);
 		return;
 	}
 
@@ -1415,7 +1462,7 @@ static void applespi_got_data(struct applespi_data *applespi)
 			applespi->read_active = false;
 			applespi->write_active = false;
 
-			wake_up_all(&applespi->drain_complete);
+			wake_up_all(&applespi->wait_queue);
 		}
 
 		return;
@@ -1610,6 +1657,7 @@ static int applespi_probe(struct spi_device *spi)
 	struct applespi_data *applespi;
 	acpi_handle spi_handle = ACPI_HANDLE(&spi->dev);
 	acpi_status acpi_sts;
+	unsigned long flags;
 	int sts, i;
 	unsigned long long gpe, usb_status;
 
@@ -1628,8 +1676,6 @@ static int applespi_probe(struct spi_device *spi)
 
 	applespi->spi = spi;
 
-	INIT_WORK(&applespi->work, applespi_worker);
-
 	/* store the driver data */
 	spi_set_drvdata(spi, applespi);
 
@@ -1757,6 +1803,22 @@ static int applespi_probe(struct spi_device *spi)
 	/* trigger touchpad setup */
 	applespi_init(applespi, false);
 
+	/* set up the touchpad as a separate input device */
+	sts = wait_event_timeout(applespi->wait_queue,
+				 applespi->rcvd_tp_info.model_no,
+				 msecs_to_jiffies(3000));
+	if (!sts) {
+		dev_err(&applespi->spi->dev,
+			"Timed out waiting for device info\n");
+		sts = -ETIMEDOUT;
+		goto cancel_spi;
+	}
+
+	sts = applespi_register_touchpad_device(applespi,
+						&applespi->rcvd_tp_info);
+	if (sts)
+		goto cancel_spi;
+
 	/*
 	 * By default this device is not enabled for wakeup; but USB keyboards
 	 * generally are, so the expectation is that by default the keyboard
@@ -1789,25 +1851,50 @@ static int applespi_probe(struct spi_device *spi)
 			    &applespi_tp_dim_fops);
 
 	return 0;
+
+cancel_spi:
+	acpi_disable_gpe(NULL, applespi->gpe);
+	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+	applespi->cancel_spi = true;
+	wait_event_lock_irq(applespi->wait_queue,
+			    !applespi_async_outstanding(applespi),
+			    applespi->cmd_msg_lock);
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+
+	return sts;
 }
 
 static void applespi_drain_writes(struct applespi_data *applespi)
 {
-	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 
 	applespi->drain = true;
-	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
-			    applespi->cmd_msg_lock);
+	wait_event_lock_irq_timeout(applespi->wait_queue,
+				    !applespi->write_active,
+				    applespi->cmd_msg_lock,
+				    msecs_to_jiffies(3000));
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 }
 
 static void applespi_drain_reads(struct applespi_data *applespi)
 {
-	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+	unsigned long flags;
 
-	wait_event_lock_irq(applespi->drain_complete, !applespi->read_active,
-			    applespi->cmd_msg_lock);
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+
+	wait_event_lock_irq_timeout(applespi->wait_queue,
+				    !applespi->read_active,
+				    applespi->cmd_msg_lock,
+				    msecs_to_jiffies(3000));
 
 	applespi->suspended = true;
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
 }
 
 static void applespi_remove(struct spi_device *spi)
@@ -1919,6 +2006,7 @@ static struct spi_driver applespi_driver = {
 		.name			= "applespi",
 		.acpi_match_table	= applespi_acpi_match,
 		.pm			= pm_sleep_ptr(&applespi_pm_ops),
+		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= applespi_probe,
 	.remove		= applespi_remove,
-- 
2.39.5

