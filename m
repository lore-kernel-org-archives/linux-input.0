Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547410;
	b=z12wff/3Jf4/7J0MLluYn79OIczZZFddif3WW0npJ0TRhpBtf83yqf+LcV9xsm80f56R
	 NIVgrkvN5AtH3oWkt/u9MxZXg7PoAesZ4mOwplVfyJbI0D14Wz/Z+0VSPG6pGWA35/IyD
	 /Ych0xSUeyb037IYl6XXslgdJR8DHWg5KztbHN+c7TbzFGIOQRnSby6SMj4SA7NjfKmtM
	 uaw/A/oiGahtXsrJ23CjxDcdvnKMM2ZfF56UpyZD6L3UtWtrUP9UhdtTi5Hy4CZdSpR6s
	 0FuUrw9s7j0bCMNv4ZTp9IJkKy8KuVhWfG22ahpzhFG6QDb59fftICZrmUNZeEa9NXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZzodloN7LBcv77UWxjh4ySVp/0KBbsvTGp2wrXjuf+k=;
	b=d/ZCEBB1jf9spfy1vRzLhkstp1Q+PWHRFdVF/jCHgRBMvAsIAFMX6f46PB6FGYsrKiMD
	 ybNKZ1iAZIw0SoyV0Ln360JSa5cqXzgHaJETOk5ovY47ig8fW2h/JhNxlFL+hU/69xqFU
	 wK6/ZhEnAL91pTdwFNTQPaimYKmKlODkBuhX/0diyUEBUHB75G9CkpGiRmucbpOOuszyH
	 wfe7TXNWlzGJOpx4lzVis6KoJW16tSJex9ldQbKZs8mSDWK8MfdhGJEZz3krkuBU34ufW
	 5oQQmemsXmIFEyWxIpnYs9KBI+j655/1OM3FGRD9c1LKiiqW+u/m0lPRld3a4szxRxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E3fbWYHb;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F7606A31A
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 01:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 954F7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E3fbWYHb
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so364964eec.0
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 18:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792547409; x=1793152209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZzodloN7LBcv77UWxjh4ySVp/0KBbsvTGp2wrXjuf+k=;
        b=E3fbWYHbX7mmjLg+UlxS8u1ckBsCnUupfeK9IDOV5bKHEOl9oXhdtzunmC1TZ8P3mU
         0uzHxGHRZ90em4PzeLIVtTiQVtU1nu18ihMU4e1wjaq9nn85rgLkqZ7sgumefeoYUa6e
         2Z/iyhkbVplGzkfRTG5eFKr578pCJ0EL/OftwCcTKv8wRc2h4+OscKuDqoIe7rlTYZIb
         hqHrRoNHRonTuNW0f1BNHmbGP2W3uuZtThNNOnkc7uVQ7cYPiAE7oAZXUz17Tgfomy4+
         tgNmSDdMvNq/O1OYLdZVXfxB+SIPOwgNcRlCsD/1YjbUbPfLbxl6ipSj2HCvLNlgdLSq
         9XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792547409; x=1793152209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZzodloN7LBcv77UWxjh4ySVp/0KBbsvTGp2wrXjuf+k=;
        b=GUgpacIBQCsjqCDOlnH3ah8q0zKvlGkWGEeuxVqT1kaYHJCe4ayC/WlWOh31+WK/Um
         WRpY9xStBAmk62sgUdUVzl4CMrJM+dVb0HmggATRZEn9SeA9Y1Lm0NLBg/T0jiU46KF/
         MVYEHArJDe0nd8gXXCKbti9AMTXY0cOJBXLxqM7oBXU6n4EAGXY7/zkdfcSlB2Wqw33c
         MyfwKTNytgUTRDnxhd8U+NmzqQB0Y65xGvsKonOOxYXlOT9+nNggtblEXGlgJtJJEmIJ
         aRKXVIf+dkobZDk+qG5I6m6hQNaX19ZAd1hsx6PEpsmjBtTMdU1QtEXb9m4MJzDTdUEG
         y10Q==
X-Forwarded-Encrypted: i=1; AKwUvBz0d1a9vD17SFqi3rmSenZHzpz/u9HyBUrQUY2JZ+4+tP+p6fUlCbXz/tgmGSwOZpFPtK4dPHUAq/ihPA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJe9Wmzum2V0MzqHC/j40ucHzIEsZOZ0ZhF8jANT+SwZr3zSA6e
	eqDdS6xwhk0h9htTEHTRA12/EfCA/BeDWDWjjrW2L1lniwrQ9gYjTV/y
X-Gm-Gg: AYBFou0fm+YrHIrQpFkPwESiDzi6Rc1tV38oCMjF9r905xSPLm3toJBSUHsO3oRx/Oy
	ozmBkTkruhC57h97w3VuhsevVD6OGVbirxmq64BJHZiaasJzK3HxLz0Y1Q8Z6pllDU/AznQDhzB
	mZE2xNWuUeIeY2LaYcF5/1nYO5GEhswKLKdwOycGBxR+7WPsILdkJmXVkwUnvaBdQICXbg7Hphs
	gZA0Qqkq+QQiblaSRBLhT+VPHc8QOBXFXCcobBvVwP3Cni7ZlrRIOXp5IhWSeS4kVY7jn7fWEhc
	hihlcIg5x/x+++ZATSMPQWgGqwcKdG1+Qe91Kk9V4kCtXPUTJ99DEEJQXY5e90diIX4Vqcampq6
	AR1J3XbbDlLE2uTCJrsGLf2hWIrQBzxDN6EUFI1C9n3QuhTPA9DPJwfB3pmRzV/N87cSXeeEDDo
	Si8Xz+v1TtYCazX8eAN3gXfb+UfMRucziNfQMY7PLXw7pM2M9bv3XzE6aeptp/Sw0C2AJrYxASt
	nMtPxzvmaWSHlnbE6VQPcIbd+BdiA0tXQQJU3C3pZ7DF+8vNl5cKXZ611yAJ7uxlZGQHtk4U2PN
	R20wDe+hUeXCLJJsfpxpRV5DJmf8T8SbxOjsfGaeVycd
X-Received: by 2002:a05:7022:698c:b0:14d:baf5:c411 with SMTP id a92af1059eb24-190a44718e6mr1323146c88.14.1792547408569;
        Tue, 20 Oct 2026 18:50:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm2106839c88.13.2026.10.20.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:50:07 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Input: soc_button_array - use resources to set up IRQ info for gpio-keys
Date: Tue, 20 Oct 2026 18:49:59 -0700
Message-ID: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for transitioning the driver to use static device
properties instead of platform data to configure gpio-keys driver,
switch to using IRQ resources attached to the gpio-keys platform device
to communicate the IRQ selection.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/soc_button_array.c | 33 +++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index dbf86ea778e6..d4dc4e7116a7 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -17,6 +17,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/platform_data/x86/soc.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 static bool use_low_level_irq;
 module_param(use_low_level_irq, bool, 0444);
@@ -154,6 +155,11 @@ soc_button_device_create(struct platform_device *pdev,
 			 const struct soc_button_info *button_info,
 			 bool autorepeat)
 {
+	struct platform_device_info pdevinfo = {
+		.parent = &pdev->dev,
+		.name = "gpio-keys",
+		.id = PLATFORM_DEVID_AUTO,
+	};
 	const struct soc_button_info *info;
 	struct platform_device *pd;
 	struct gpio_keys_button *gpio_keys;
@@ -167,6 +173,15 @@ soc_button_device_create(struct platform_device *pdev,
 		if (info->autorepeat == autorepeat)
 			n_buttons++;
 
+	struct resource *irq_resources __free(kfree) = NULL;
+	/* See dmi_use_low_level_irq[] comment */
+	if (!autorepeat && (use_low_level_irq ||
+			    dmi_check_system(dmi_use_low_level_irq))) {
+		irq_resources = kzalloc_objs(*irq_resources, n_buttons);
+		if (!irq_resources)
+			return ERR_PTR(-ENOMEM);
+	}
+
 	gpio_keys_pdata = devm_kzalloc(&pdev->dev,
 				       sizeof(*gpio_keys_pdata) +
 					sizeof(*gpio_keys) * n_buttons,
@@ -174,6 +189,9 @@ soc_button_device_create(struct platform_device *pdev,
 	if (!gpio_keys_pdata)
 		return ERR_PTR(-ENOMEM);
 
+	pdevinfo.data = gpio_keys_pdata;
+	pdevinfo.size_data = sizeof(*gpio_keys_pdata);
+
 	gpio_keys = (void *)(gpio_keys_pdata + 1);
 	n_buttons = 0;
 
@@ -212,10 +230,9 @@ soc_button_device_create(struct platform_device *pdev,
 		}
 
 		/* See dmi_use_low_level_irq[] comment */
-		if (!autorepeat && (use_low_level_irq ||
-				    dmi_check_system(dmi_use_low_level_irq))) {
+		if (irq_resources) {
 			irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
-			gpio_keys[n_buttons].irq = irq;
+			irq_resources[n_buttons] = DEFINE_RES_IRQ(irq);
 			gpio_keys[n_buttons].gpio = -ENOENT;
 		} else {
 			gpio_keys[n_buttons].gpio = gpio;
@@ -240,10 +257,12 @@ soc_button_device_create(struct platform_device *pdev,
 	gpio_keys_pdata->nbuttons = n_buttons;
 	gpio_keys_pdata->rep = autorepeat;
 
-	pd = platform_device_register_resndata(&pdev->dev, "gpio-keys",
-					       PLATFORM_DEVID_AUTO, NULL, 0,
-					       gpio_keys_pdata,
-					       sizeof(*gpio_keys_pdata));
+	if (irq_resources) {
+		pdevinfo.res = irq_resources;
+		pdevinfo.num_res = n_buttons;
+	}
+
+	pd = platform_device_register_full(&pdevinfo);
 	error = PTR_ERR_OR_ZERO(pd);
 	if (error) {
 		dev_err(&pdev->dev,
-- 
2.56.0.212.g129ede20d9-goog

