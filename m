Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020B43E488
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564557; cv=none; b=uCJSFF6rBQWgS7FxvniprdvU2JjvY5rCc4q+aQ7RQPTfLB5SBrmMhMjwq1tOaiKjPibYZ8fxa6vWP3sv3NVRSdXI1/L8ki8ol6WIn2WToZU2dmPRm9GZXudK8ZlcjqQZAcNVhncMD/bPhe90NrMu8THxGefguT5WtFH4znS3R44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564557; c=relaxed/simple;
	bh=lMEL/guzYTtbgyFldhZtTjCpjd6NFbDQi30FdOkNlHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlVZzrt9gOxFjTPZcRCjj46WveClKkU0ZIUorWvq/1YINcvKRGv/cz2j2f3c1BBG0DIvHcBxsqc/cbVENM7Gdn6P3aqZmmj958t0joQZokFm+6+yyR01g78DFPOsvltwqXAvdXLIbh1p55FWdugWMdmyvn4wps+ZmbO5O4HGSWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so8163117a91.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564549; x=1785169349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4QSVvjgeOnTqjGkk31K3nbyNNkT3S+X+wqvMTCP4ZKo=;
        b=Sp0hnz1tghZ4hbVCC+j65FSORptgUUE0bD84+oDFkTtVeekSKA7ZaZqhFr1571Q4Ey
         isrDKNydufow5zY6YJdjEUNIj8e48VtFRQWe91SyU8+kvnim/9Q9ezll9yaOCNxjeBy2
         mqcKOKd98uBFuyFzW/fxSgl5N9oyA47dvI8VmdnEpbByX2Ia7Hp3118zNjHTrVi74yvV
         hWQkkfUn4hcXPd4Nbm/A+MqTLw3HAQ3ePmrOSmlx+Yo1LeBHSDMbrZbyHGS5Ik4NTlKk
         /7M8h1VYVZTjE/shzK+DgzaLyABL9WPog5G1P1Z215bX+ahvTCKL35siudCFhKuQKtTe
         JdTA==
X-Forwarded-Encrypted: i=1; AHgh+Roadt2og+OD8m6vKcimHUYHsoVJ0iPjU0tlFGlLeAmu6IQugmbUi8FFw1bcH5HeeP0dsxEnx+F4i74xjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFuAFQeR0iWyK4lABsGksaSz+mHq73HHXsHLUolB3UzV27/PS
	nXx9A6sSE9cTmHFaN4mzXw5vpoTtwsm17mbiNdHaBCxbbprl35xOY8Q=
X-Gm-Gg: AR+sD11eLKjwMulhzTn43hbBIV7imZlFnaMaZeIMoc7pAyYbZBbZedQD4r2OKS+1OON
	qZjcvPgLOsyzGMnDgD4FsqtWEgowDWyQ4RM7DbTaO86zoxXuMlzyL2JUoQ5OzRAd88BcRExCBy6
	XXnmMiYdcR8IoCfRy2I1UGcidqIOAHHMgrlZlJuWWCgAKm/oxX5HJ2dzZ3JOGaLzCUpr8Ble5Tm
	KnOwS4lj85CQsJB8gR1rEnJDOfyt19UZkVFR74tl9oFX/Zsc/0B30QItpXuJRnWEoqjZzsbhddg
	c3hWnpxUVdZa+BGYsjh2rBuoah00nOLwMO7UiLpnT3tn57nJn8nLmYVhX4YPjlULVR0VFKCqgZu
	JmB+b0cLUGi+c+3IKI828nKlp20G4V7wza8AeVzKK1kOnaW+kO8fOHF766JQyYWDLh+f1R1YCwK
	aN/FIpKFimv8P10zGhw1lSQXtMKo45ErV+nQWHAqbZ7jCzdgW5QvBUK7S4CIUAf/F9Ep0UXMGK/
	bAdqOmZxR9Gmz31oA==
X-Received: by 2002:a17:90a:d646:b0:381:50ab:1594 with SMTP id 98e67ed59e1d1-38e4b51be59mr16272082a91.27.1784564549188;
        Mon, 20 Jul 2026 09:22:29 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9205d358sm29366a91.3.2026.07.20.09.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:22:28 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 3/5] Input: applespi - register touchpad synchronously in probe
Date: Tue, 21 Jul 2026 00:22:17 +0800
Message-Id: <20260720162219.32324-4-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162219.32324-1-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the asynchronous worker for touchpad registration with synchronous
registration during driver probe. Wait up to 3 seconds for the device info
packet and fallback to keyboard-only mode if a timeout occurs.

Prevent a kernel panic in debugfs by checking for a NULL touchpad_input_dev
in applespi_tp_dim_open() before dereferencing it, returning -ENODEV if the
device is operating in keyboard-only mode.

Protect rcvd_tp_info from data races by creating a local copy under
cmd_msg_lock before passing it to applespi_register_touchpad_device().

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 60 ++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index c9bbceaf0671..6db4eeca3060 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -427,7 +427,7 @@ struct applespi_data {
 	}				spi_complete[2];
 	bool				cancel_spi;
 
-	struct work_struct		work;
+	bool				have_tp_info;
 	struct touchpad_info_protocol	rcvd_tp_info;
 
 	struct dentry			*debugfs_root;
@@ -1030,6 +1030,9 @@ static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 {
 	struct applespi_data *applespi = inode->i_private;
 
+	if (!applespi->touchpad_input_dev)
+		return -ENODEV;
+
 	file->private_data = applespi;
 
 	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
@@ -1390,26 +1393,20 @@ applespi_register_touchpad_device(struct applespi_data *applespi,
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
+	unsigned long flags;
+
 	if (packet->device == PACKET_DEV_INFO &&
 	    le16_to_cpu(message->type) == 0x1020) {
-		/*
-		 * We're not allowed to sleep here, but registering an input
-		 * device can sleep.
-		 */
+		spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 		applespi->rcvd_tp_info = message->tp_info;
-		schedule_work(&applespi->work);
+		applespi->have_tp_info = true;
+		spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+
+		wake_up_all(&applespi->wait_queue);
 		return;
 	}
 
@@ -1677,6 +1674,7 @@ static int applespi_probe(struct spi_device *spi)
 	acpi_handle spi_handle = ACPI_HANDLE(&spi->dev);
 	acpi_status acpi_sts;
 	int sts, i;
+	unsigned long flags;
 	unsigned long long gpe, usb_status;
 
 	/* check if the USB interface is present and enabled already */
@@ -1694,8 +1692,6 @@ static int applespi_probe(struct spi_device *spi)
 
 	applespi->spi = spi;
 
-	INIT_WORK(&applespi->work, applespi_worker);
-
 	/* store the driver data */
 	spi_set_drvdata(spi, applespi);
 
@@ -1823,6 +1819,25 @@ static int applespi_probe(struct spi_device *spi)
 	/* trigger touchpad setup */
 	applespi_init(applespi, false);
 
+	/* set up the touchpad as a separate input device if info is received */
+	sts = wait_event_timeout(applespi->wait_queue,
+				 READ_ONCE(applespi->have_tp_info),
+				 msecs_to_jiffies(3000));
+	if (!sts) {
+		dev_warn(&applespi->spi->dev,
+			 "Timed out waiting for touchpad info, continuing keyboard-only\n");
+	} else {
+		struct touchpad_info_protocol tp_info;
+
+		spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+		tp_info = applespi->rcvd_tp_info;
+		spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+
+		sts = applespi_register_touchpad_device(applespi, &tp_info);
+		if (sts)
+			goto cancel_spi;
+	}
+
 	/*
 	 * By default this device is not enabled for wakeup; but USB keyboards
 	 * generally are, so the expectation is that by default the keyboard
@@ -1855,6 +1870,19 @@ static int applespi_probe(struct spi_device *spi)
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
-- 
2.39.5

