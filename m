Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF33A48E6
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848631; cv=none; b=uLjxMvXt7TN4gxwe9Y1ttiySjgJkZag5zh1PvcvhuPORn7OfArQm+PfQE1OL87W0lTzFsPgXiBnM62Fx2TNJQfGJU/gZTMqAVALPiBKdsmnr5/YeCONB3tLshXVOsfpO9fTFCRK4rIMBILtrD4G5nqUbPRYEioEcwuq1JSnqGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848631; c=relaxed/simple;
	bh=C2eBZXTj7z4JargxfKoe48rn4iOm6Qbo6aOlsrmLXyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT4gC+B+zrDOpPJ9hTZFSoGueubNQj9ez4Qia7zYT9/6libWQbwl44rs6mPTr5bZhjNNu9gFifZP0pqrTYtESCXMqbQUtkWqI9gnrWWdaUR2NnZBB0uff62MktOumJrMEu8076JnAeXhY2gNC5/GOV+TAID1QwrpZV8ETdAXtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0MVjWAZ; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0MVjWAZ"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48aff58e6abso986703f8f.3
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2026 02:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790848626; x=1791453426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzZubT1XUHSGbDZM1zvSP0sHOYv28Uuy2JZcRRHm8fc=;
        b=m0MVjWAZYekfTNHpYDmSS91S/p9gd9tkwNst2XbJe4+jSWJPFor0zO3jgeqoAVHFEL
         pTL8tEpXB5njnNDs/SkpWcO5UanmvMRidArD2dYkMK85fXifRmVuiapKQwBbJSfzT7T3
         t+L5e8mu+pa+Xyqd7B0+QvErC7H1KEX2NwtXviixpBUbib3VvTrQcgDjZ2vw1DbN+wsu
         4ZncLN68cRp1ctv3Q5sInN3BP2iXsnZ/EPPmYdWrJx6wgaltbWjHYCTd8JaiTmXPWAh9
         dzMsvG+UAuCjoXvX/TcXTZ0QWrsK/HaZyVuUz+DMuuR9WWX3kwN99fVvOOU9LptOEm+q
         EJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848626; x=1791453426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzZubT1XUHSGbDZM1zvSP0sHOYv28Uuy2JZcRRHm8fc=;
        b=IjzLC2ZqJZAo2lYXsmGx8mWTB5ysAf76C8mzm73vDLegmM32t9iG4JIXVchz3UzqlO
         RAQtU0DW9lOeBvGgVfCPpjHph8YXOR49y+JUAjkM0CQIexT9ywBgzt/uslrePFSr0Qws
         lmwP4Dr7TXH/ysTZu2a/5MJiM2jsmzjBkBXRnJaTDAgzr2FLbe2q/EARjnOMRBvddRMo
         7ZY8228LD+d6z8bioNKiw0Xhf8UTtt/YnJIUrGzyCVhJCqtLBUCBvu+FMfIs5ifMFHYG
         nyjWGqEOqCX6iyYnEJuZ/7sqPrBQ75V5t0yHwaG5A3lR3h1n/0tSM35JqhEIyZuY4pom
         w+Xg==
X-Gm-Message-State: AFuF++m5K+eMiEme727YfVl111xlXyp9TwGy/YkzDMbQM9DeUBMu3WJe
	6ZNtiq7vsD2eWKrGZ0aqKTqaVGOtvsg5fP2P31BWcy5teQsI2XOiyHNUl7gpmg==
X-Gm-Gg: AYBFou3xWXFNJAR5t1L/OtCrTbvYUgYMhpTjIwtEoNqFdJd7lBLy6t6OrBWaXSrM1wK
	ws4B2xRn4FFwBCItzi4FULEaPXQiCy/9NJZ4IvqajEZjnNdUh8P2Tc/V7kNV75UqWVEhij/uZHZ
	mhORevFA8JP84jhQmoI6AQhs6uofTaOmJ6tRFD/3BVBR4RRneW2hOm1mKWIinHnL2Sa5of/0/dE
	ESSCmOyV/Pf9NXH6/QmV98HsGXXw0Bulsqbrr0tikjAmv+EO8Gxg2KmSIV6XdZLdQklBCsqAU8+
	Nhex/R++66vAUZ6VKrbrezIq61tZYprkuZIbXg4Du95zb6dRyx1abrC3CRA0c/llS1+pA3VWeWC
	z+uqOLkjayHsoDkzmBifmxKAKj/rYkvcG2eZLk8g5rYhpW6Hl22Fc55q5l7eLUW96pMGQDtlYsV
	OlUaRtQDQ9/6P21KJ21vAi81aABe2xzYxnLzOTgpORHvDZFlLNWruNu5Lzx/TqHiCyffIIYU1Mg
	39d8x0qpSqL4TBKrA/IZ4qC
X-Received: by 2002:a05:600c:19cb:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a01c175025mr58235685e9.31.1790848625739;
        Thu, 01 Oct 2026 02:57:05 -0700 (PDT)
Received: from fedora.tail922d40.ts.net ([213.55.185.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99a332sm105855845e9.12.2026.10.01.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:57:05 -0700 (PDT)
From: Michal Szpakowski <michi.szpakowski@gmail.com>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>,
	Aditya Garg <gargaditya08@live.com>,
	Lukas Wunner <lukas@wunner.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: applespi - turn the keyboard backlight off across suspend
Date: Thu,  1 Oct 2026 11:56:58 +0200
Message-ID: <20261001095658.5821-1-michi.szpakowski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001084154.4703-1-michi.szpakowski@gmail.com>
References: <20261001084154.4703-1-michi.szpakowski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keyboard backlight of the SPI topcase stays lit through s2idle: the
driver's suspend handler only switches the caps-lock LED off, and the
backlight LED is registered without LED_CORE_SUSPENDRESUME, so the LED
core never gets to blank it. Under deep (S3) the rails go down anyway,
which is why it only shows on machines that default to s2idle.

Set the flag, and deal with the two things that follow from the LED
core now sending a command of its own right before applespi_suspend():

- The LED is a child of the SPI device, so its "off" command is queued
  just before applespi_suspend() runs. The driver keeps one command in
  flight, so the caps-lock command was skipped while that one was still
  out, and then dropped by the drain. Wait for the write to finish first;
  the completion now wakes the drain queue unconditionally so that this
  wait has something to wake it.

- The level the LED core blanks to would be what poweroff_late and
  shutdown save to EFI for the next boot. Keep the last level the user
  asked for in its own field, updated only while the LED is not
  suspended, and save that instead.

Tested on a MacBookPro13,1 (2016): 30 s of s2idle with the backlight at
200/255 leaves it lit on the stock kernel; with this patch it goes dark
at suspend and is back at 200 on wake, and a caps-lock LED that was on
at suspend is off during the sleep and on again afterwards. A
hibernation with the backlight at 200 leaves the level for 200 in the
EFI variable instead of the blanked minimum.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Szpakowski <michi.szpakowski@gmail.com>
---
v2: address the two points from the automated review on v1 - the
    caps-lock command racing the LED core's backlight command at
    suspend, and the blanked level being saved to EFI at power-off.

 drivers/input/keyboard/applespi.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -407,6 +407,7 @@
 	bool				have_cl_led_on;
 	unsigned int			want_bl_level;
 	unsigned int			have_bl_level;
+	unsigned int			bl_level_persist;
 	unsigned int			cmd_msg_cntr;
 	/* lock to protect the above parameters and flags below */
 	spinlock_t			cmd_msg_lock;
@@ -724,7 +725,7 @@
 	if (is_write_msg)
 		applespi->write_active = false;
 
-	if (applespi->drain && !applespi->write_active)
+	if (!applespi->write_active)
 		wake_up_all(&applespi->drain_complete);
 
 	if (is_write_msg) {
@@ -923,6 +924,14 @@
 			 KBD_BL_LEVEL_MIN);
 	}
 
+	/*
+	 * The LED core blanks the backlight around suspend; that level is
+	 * not what the user wants restored after a power-off, so keep the
+	 * last one they asked for separately.
+	 */
+	if (!(led_cdev->flags & LED_SUSPENDED))
+		applespi->bl_level_persist = applespi->want_bl_level;
+
 	applespi_send_cmd_msg(applespi);
 }
 
@@ -1772,6 +1781,7 @@
 	applespi->backlight_info.name            = "spi::kbd_backlight";
 	applespi->backlight_info.default_trigger = "kbd-backlight";
 	applespi->backlight_info.brightness_set  = applespi_set_bl_level;
+	applespi->backlight_info.flags           = LED_CORE_SUSPENDRESUME;
 
 	sts = devm_led_classdev_register(&spi->dev, &applespi->backlight_info);
 	if (sts)
@@ -1791,6 +1801,14 @@
 	return 0;
 }
 
+static void applespi_wait_for_write(struct applespi_data *applespi)
+{
+	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
+
+	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
+			    applespi->cmd_msg_lock);
+}
+
 static void applespi_drain_writes(struct applespi_data *applespi)
 {
 	guard(spinlock_irqsave)(&applespi->cmd_msg_lock);
@@ -1829,7 +1847,7 @@
 {
 	struct applespi_data *applespi = spi_get_drvdata(spi);
 
-	applespi_save_bl_level(applespi, applespi->have_bl_level);
+	applespi_save_bl_level(applespi, applespi->bl_level_persist);
 }
 
 static int applespi_poweroff_late(struct device *dev)
@@ -1837,7 +1855,7 @@
 	struct spi_device *spi = to_spi_device(dev);
 	struct applespi_data *applespi = spi_get_drvdata(spi);
 
-	applespi_save_bl_level(applespi, applespi->have_bl_level);
+	applespi_save_bl_level(applespi, applespi->bl_level_persist);
 
 	return 0;
 }
@@ -1849,6 +1867,14 @@
 	acpi_status acpi_sts;
 	int sts;
 
+	/*
+	 * The backlight LED is a child of this device, so the LED core has
+	 * just sent its "off" command; wait for it, or the caps-lock command
+	 * is skipped (one command in flight at a time) and then dropped by the
+	 * drain below.
+	 */
+	applespi_wait_for_write(applespi);
+
 	/* turn off caps-lock - it'll stay on otherwise */
 	sts = applespi_set_capsl_led(applespi, false);
 	if (sts)
