Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794278143;
	b=r8M/CZCCN5leJVYAJMyWpWe+dEljFreB+7Q0fEYTN3XJKrZVjur8RcLbBhtoxtSX6qpT
	 utf16l1WZcccQUohJpXZWrB8uqtjojEhg1TYl7nNEJVaKQ4QKBeMKNqUgz2jywKKa4bzF
	 9ouKKqWwtebY3AfxA/JNViC7yaMFiA/6KeJLjU/FVeK5QGwkSfkkYBBc0C5z7syAxgyDn
	 Calq1OkI8GzItQYHFjVWbA3kT5Ve1kfwTUrFFziSFfpOI7yvd0T/KKViHWStZtlJpsKkY
	 XJoHNnqbjAN7pQHyvcC0gZizPRdv/aDj1/msdIBK5IsQN2JFQ/hUY/teOGAkS+YgGHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
	b=R+s4GRIgriMKXTA9fZs+3LLQwmjYWvN7CsyeQyFk3p3j3vzztEZYGsTSKApzu+7ygSvj
	 Gr6oYirx8JQmnV4FVQ/cbH9B92Oq5BL77n58DVcNCRWvKZHyMhnYZgwFsxu3vFUZPzzIQ
	 H+2E4Cxi96xexwt2E6/q6cwOinSoXEuh5M7NGIKEMyyM7JIHgNowQGrAz/CxCR1Yry8Hd
	 Dbhk3hVPQixWIQQIFZqk/lJTFDHIRRgrgm++uDJTeFYm4k1nGiWkqjUDyQ2H06JtSXIGq
	 WQl+/bDtQRD9ip+NDoBpDReUK/5oF9girzDOsCstF02bw8L9oS6ZT9PRCuD8lv7ciZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZJa/DLkb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA88606A325
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA88606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZJa/DLkb
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c468bd799ecso217862766b.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794278141; cv=none;
        d=google.com; s=arc-20260327;
        b=ARO7B9Za/Qr1muExzvnty9bg5xY9XMIXQV4P/2b/XAx50K1dbleHyVVQa28SoX81BN
         0zwsjzgkUBVoNH0re+air0WkUoUu+38Bi+jx2Zi1r8ALhjw82iH9ooorMpPlt+I6g4XM
         tKSaBeNjEl3Lr8D7HXi4ou2m8gVGH/hh6Gxffx8chMAO8uGf7GQPZYhGZvr5jKIRIK2x
         Xbdz0POltrBd7x14zDOG/SINm5X7P7c2liDVd5AudYIFmgahabwjr+Oqj7RRF9fvn4dh
         07D0DynIVlG3MoqDA7RZRMPjvubYADS86yB+xS5cKvKJOo5X1iHVmHtqKOiG+KlFIUYs
         gMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
        fh=N8E+sfJib1gKkfe4RZPA6Xj9C+UEpPc5ki2+nW7P2uc=;
        b=oaQuNTGqC10+R+6hVBOLJuz6pPGjMSBTBSh4O9HNy9BaNJNqxCetSe344m2l50dQdT
         t2VMt1BVoZU2dI6DvJTd1aw4BezezWLJgYkZO15cODO8OyrBZ0TOlKHxfKJ3bdrhoSxB
         PJXOZEyHJ7g8a9BG2QTLS6sU304usxHUK2urunc4ljgx8JXsvZZVnPmwmkINreT8QAkd
         Hf9Ioy2UUVFVkiI2JW+V9qmzO8yicN5xL3Sr68nMyYgovjOjULrya+P1lAGl/MpZ5IPE
         02/sVQiF7oHWnPIVTJVvK/rL5kr7TswyhVZxai3QAGN9lewp5+7bR24dkkqRqTEPOCnP
         jTng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278141; x=1794882941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
        b=ZJa/DLkbwFK13GYxif9rrBk9ZFMepmH7kYdlzvkEiIJhXqMFFQEbBTJOa2BkwztIem
         X1tAX5wYK/JV07jx3lDJonCdEFnL0fAlA+FfEm76mlqR5zB8k/FvXPQ9OnKhfXh2gJuX
         dgWJ1jVuYiRXaOL4T6zNpkJN5SWltL/abyNxbghyyvg8/15mNS4WiLQZn0T1eWLVs/T5
         +uXmdJDZgOnwBFpuK/P6vNLzxZ9EDrhRPYN9XpJpPEU/lHdQUnH7L8MyUQ1pAKTsYAD+
         XWvnGYdcjCBiL5vf7xcaDBVnYonKkyGDkSYytToSziNyJ59kFqvXYKcjc83pSAAP23Fp
         DgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278141; x=1794882941;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4b8VMR0ToT11MGOGDl7IQcBDkYw4JTHYnJZ3xagfNUE=;
        b=f13xg8l/uDg2suD6ID9mHEqDGFDDFkUQQBapRW91h77XySNTVj7wClJx/LafX1q3EK
         a8I2meW8vaxQ7O0Wy6+lHUQMfKCb9hQJ7ariOJGic8gN9MQVZ6bEQyjhBT1qqd535Cd2
         J9YL6G16AQ4kgxwpDo5vZThasrOnWppU2kCZClkIaNraBdFazy3aKouPr1f9nNhWVIe9
         7RXqX7ATs+vw2ZreGF6e/a28KLO/AwCwEbYQfLzLu3Vhn8uzea2XR3glOQsmr3h9SVio
         x71mCtUX/GODcMkwhexvwRlAUyMxmlYaHDtNroibmQbxRM6puX667Ig8Juh8XOUXrsMd
         3k1g==
X-Forwarded-Encrypted: i=1; AL+hErElquUs6npyOHdTm8PczcQZoFycJdf7upVGVKNknvFBgUJ4XdtHIdTcD8JOMYr5ffXCrWkDxGOVd/6DLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z82xtkcSDAwPw/YDjVpnZuyKcsfmmf82va4ISpMRI519DZ7rTZ2
	dUcbQzOg1vqXSzPtpqF9atZqZBgSnYD7TgMjawwGOMe4Jqi87IYttSgsQMGL3g+7kb/9FmJykdb
	myQ2DjV0pMLu5LJLB4ooSQpFb6sUsLXYG
X-Gm-Gg: AYBFou16SV0egRwBIAq/3+G6qQKoUJVW0LQW8AIxK4mImKJyJom2P82qzUGBAJJ1gqu
	skw0OKngovZ7tgVRKr0VRbFVDIbKSpK5zgY1cBdmTeksiY3bEB8m5my5uJPXbPmclU+Pqm2+wBm
	Z3AYbzHHl93U4XR72/pYpwsfVFo88lQpldEmI9YzGA1V79nq1XnU7ky+T1SFIwAP/1vknzhFfBO
	7UtxUeu2fPj8uVb7YXpOgsk1gAVRNa+dUpWui1K7U+eDT1C/L76Vc336LGWaOiGzIdJkyANRYdO
	fO3RFs/YM2BjsoPgcc41egjNSziXpdTQG75oJH8TSwTK+w7kyVDnsbWsEwqcPsZDk4Doi7fPHXL
	Aw5aUkX4BfkNyIQql/uEJ1B9Eoy5MjfNNzNhO7CYnXW0KmSJHKc2mOVk70+dMHC+/UxI4aUYaRF
	ZshdWT4+Y2vqT7JNKQ8HS0k2rEHhRpJnVWSDNyGS/c0rlc
X-Received: by 2002:a17:906:ef01:b0:c31:8c48:e18b with SMTP id
 a640c23a62f3a-c50494b5468mr87905566b.14.1794278141251; Mon, 09 Nov 2026
 18:35:41 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:35:39 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
In-Reply-To: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
References: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Date: Tue, 10 Nov 2026 02:35:39 +0000
X-Gm-Features: AclHuK8a2vf6Kdy8AdU3IyQjeInaPjr1EXSZeWDCZfS69AY6Gnq0Va-6HMxz_ls
Message-ID: <CAGEsz8FyKXrsy2GFmBO16mTN+d0KteHk-e7QoO3VsfHdeHs79g@mail.gmail.com>
Subject: [PATCH v2 2/2] mfd: wm831x: Align child IRQ resources and lifetime
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Onkey removal and battery IRQ error cleanup free unmapped platform IRQs
instead of the requested Linux IRQs. This can leave handlers registered
after their data is freed.

Pass the IRQ domain to MFD and use mapped resources in the children.
Manage onkey IRQ/work cleanup and unwind consumers before disposing IRQ
mappings on initialization failure. Retain polling for key release.

This issue was found by our static analysis tool under development.

Fixes: cd99758ba3bd ("mfd: Convert wm831x to irq_domain")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
No hardware testing.

diff --git a/drivers/input/misc/wm831x-on.c b/drivers/input/misc/wm831x-on.c
index 891f498ea..f8e49ac27 100644
--- a/drivers/input/misc/wm831x-on.c
+++ b/drivers/input/misc/wm831x-on.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 #include <linux/mfd/wm831x/core.h>

 struct wm831x_on {
@@ -72,9 +73,12 @@ static int wm831x_on_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_on *wm831x_on;
-	int irq = wm831x_irq(wm831x, platform_get_irq(pdev, 0));
+	int irq = platform_get_irq(pdev, 0);
 	int ret;

+	if (irq < 0)
+		return irq;
+
 	wm831x_on = devm_kzalloc_obj(&pdev->dev, struct wm831x_on);
 	if (!wm831x_on) {
 		dev_err(&pdev->dev, "Can't allocate data\n");
@@ -82,13 +86,11 @@ static int wm831x_on_probe(struct platform_device *pdev)
 	}

 	wm831x_on->wm831x = wm831x;
-	INIT_DELAYED_WORK(&wm831x_on->work, wm831x_poll_on);

 	wm831x_on->dev = devm_input_allocate_device(&pdev->dev);
 	if (!wm831x_on->dev) {
 		dev_err(&pdev->dev, "Can't allocate input dev\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}

 	wm831x_on->dev->evbit[0] = BIT_MASK(EV_KEY);
@@ -96,43 +98,28 @@ static int wm831x_on_probe(struct platform_device *pdev)
 	wm831x_on->dev->name = "wm831x_on";
 	wm831x_on->dev->phys = "wm831x_on/input0";

-	ret = request_threaded_irq(irq, NULL, wm831x_on_irq,
-				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-				   "wm831x_on",
-				   wm831x_on);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to request IRQ: %d\n", ret);
-		goto err_input_dev;
-	}
 	ret = input_register_device(wm831x_on->dev);
 	if (ret) {
 		dev_dbg(&pdev->dev, "Can't register input device: %d\n", ret);
-		goto err_irq;
+		return ret;
 	}

-	platform_set_drvdata(pdev, wm831x_on);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &wm831x_on->work,
+					   wm831x_poll_on);
+	if (ret)
+		return ret;

-	return 0;
+	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, wm831x_on_irq,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"wm831x_on", wm831x_on);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Unable to request IRQ\n");

-err_irq:
-	free_irq(irq, wm831x_on);
-err_input_dev:
-err:
-	return ret;
-}
-
-static void wm831x_on_remove(struct platform_device *pdev)
-{
-	struct wm831x_on *wm831x_on = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
-
-	free_irq(irq, wm831x_on);
-	cancel_delayed_work_sync(&wm831x_on->work);
+	return 0;
 }

 static struct platform_driver wm831x_on_driver = {
 	.probe		= wm831x_on_probe,
-	.remove		= wm831x_on_remove,
 	.driver		= {
 		.name	= "wm831x-on",
 	},
diff --git a/drivers/input/touchscreen/wm831x-ts.c
b/drivers/input/touchscreen/wm831x-ts.c
index 32b03889a..3651c2cd4 100644
--- a/drivers/input/touchscreen/wm831x-ts.c
+++ b/drivers/input/touchscreen/wm831x-ts.c
@@ -255,14 +255,11 @@ static int wm831x_ts_probe(struct platform_device *pdev)
 	 * If we have a direct IRQ use it, otherwise use the interrupt
 	 * from the WM831x IRQ controller.
 	 */
-	wm831x_ts->data_irq = wm831x_irq(wm831x,
-					 platform_get_irq_byname(pdev,
-								 "TCHDATA"));
+	wm831x_ts->data_irq = platform_get_irq_byname(pdev, "TCHDATA");
 	if (pdata && pdata->data_irq)
 		wm831x_ts->data_irq = pdata->data_irq;

-	wm831x_ts->pd_irq = wm831x_irq(wm831x,
-				       platform_get_irq_byname(pdev, "TCHPD"));
+	wm831x_ts->pd_irq = platform_get_irq_byname(pdev, "TCHPD");
 	if (pdata && pdata->pd_irq)
 		wm831x_ts->pd_irq = pdata->pd_irq;

diff --git a/drivers/mfd/wm831x-auxadc.c b/drivers/mfd/wm831x-auxadc.c
index 6280d4f38..e3357918b 100644
--- a/drivers/mfd/wm831x-auxadc.c
+++ b/drivers/mfd/wm831x-auxadc.c
@@ -285,3 +285,10 @@ void wm831x_auxadc_init(struct wm831x *wm831x)
 	if (!wm831x->auxadc_read)
 		wm831x->auxadc_read = wm831x_auxadc_read_polled;
 }
+
+void wm831x_auxadc_exit(struct wm831x *wm831x)
+{
+	if (wm831x->auxadc_read == wm831x_auxadc_read_irq)
+		free_irq(irq_find_mapping(wm831x->irq_domain,
+					  WM831X_IRQ_AUXADC_DATA), wm831x);
+}
diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index df8e76e00..008e19f33 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -662,14 +662,6 @@ static const struct resource
wm8320_dcdc4_buck_resources[] = {
 	DEFINE_RES_IRQ_NAMED(WM831X_IRQ_UV_DC4, "UV"),
 };

-static const struct resource wm831x_gpio_resources[] = {
-	{
-		.start = WM831X_IRQ_GPIO_1,
-		.end   = WM831X_IRQ_GPIO_16,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
 static const struct resource wm831x_isink1_resources[] = {
 	{
 		.start = WM831X_CURRENT_SINK_1,
@@ -876,8 +868,6 @@ static const struct mfd_cell wm8310_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1030,8 +1020,6 @@ static const struct mfd_cell wm8311_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1160,8 +1148,6 @@ static const struct mfd_cell wm8312_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1306,8 +1292,6 @@ static const struct mfd_cell wm8320_devs[] = {
 	},
 	{
 		.name = "wm831x-gpio",
-		.num_resources = ARRAY_SIZE(wm831x_gpio_resources),
-		.resources = wm831x_gpio_resources,
 	},
 	{
 		.name = "wm831x-hwmon",
@@ -1622,27 +1606,27 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	case WM8310:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8310_devs, ARRAY_SIZE(wm8310_devs),
-				      NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
 		break;

 	case WM8311:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8311_devs, ARRAY_SIZE(wm8311_devs),
-				      NULL, 0, NULL);
-		if (!pdata->disable_touch)
-			mfd_add_devices(wm831x->dev, wm831x_num,
-					touch_devs, ARRAY_SIZE(touch_devs),
-					NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
+		if (!ret && !pdata->disable_touch)
+			ret = mfd_add_devices(wm831x->dev, wm831x_num,
+					      touch_devs, ARRAY_SIZE(touch_devs),
+					      NULL, 0, wm831x->irq_domain);
 		break;

 	case WM8312:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8312_devs, ARRAY_SIZE(wm8312_devs),
-				      NULL, 0, NULL);
-		if (!pdata->disable_touch)
-			mfd_add_devices(wm831x->dev, wm831x_num,
-					touch_devs, ARRAY_SIZE(touch_devs),
-					NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
+		if (!ret && !pdata->disable_touch)
+			ret = mfd_add_devices(wm831x->dev, wm831x_num,
+					      touch_devs, ARRAY_SIZE(touch_devs),
+					      NULL, 0, wm831x->irq_domain);
 		break;

 	case WM8320:
@@ -1651,7 +1635,7 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	case WM8326:
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      wm8320_devs, ARRAY_SIZE(wm8320_devs),
-				      NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
 		break;

 	default:
@@ -1676,7 +1660,7 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	if (ret & WM831X_XTAL_ENA) {
 		ret = mfd_add_devices(wm831x->dev, wm831x_num,
 				      rtc_devs, ARRAY_SIZE(rtc_devs),
-				      NULL, 0, NULL);
+				      NULL, 0, wm831x->irq_domain);
 		if (ret != 0) {
 			dev_err(wm831x->dev, "Failed to add RTC: %d\n", ret);
 			goto err_irq;
@@ -1689,7 +1673,7 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 		/* Treat errors as non-critical */
 		ret = mfd_add_devices(wm831x->dev, wm831x_num, backlight_devs,
 				      ARRAY_SIZE(backlight_devs), NULL,
-				      0, NULL);
+				      0, wm831x->irq_domain);
 		if (ret < 0)
 			dev_err(wm831x->dev, "Failed to add backlight: %d\n",
 				ret);
@@ -1708,7 +1692,10 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	return 0;

 err_irq:
+	mfd_remove_devices(wm831x->dev);
+	wm831x_auxadc_exit(wm831x);
 	wm831x_irq_exit(wm831x);
+	return ret;
 err:
 	mfd_remove_devices(wm831x->dev);
 	return ret;
diff --git a/drivers/mfd/wm831x-irq.c b/drivers/mfd/wm831x-irq.c
index defd5f173..200802612 100644
--- a/drivers/mfd/wm831x-irq.c
+++ b/drivers/mfd/wm831x-irq.c
@@ -595,6 +595,8 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)

 	if (!domain) {
 		dev_warn(wm831x->dev, "Failed to allocate IRQ domain\n");
+		if (irq_base)
+			irq_free_descs(irq_base, WM831X_NUM_IRQS);
 		return -EINVAL;
 	}

@@ -606,10 +608,20 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)
 	wm831x_set_bits(wm831x, WM831X_IRQ_CONFIG,
 			WM831X_IRQ_OD, i);

-	wm831x->irq = irq;
 	wm831x->irq_domain = domain;

 	if (irq) {
+		ret = request_threaded_irq(irq, NULL, wm831x_irq_thread,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   "wm831x", wm831x);
+		if (ret != 0) {
+			dev_err(wm831x->dev, "Failed to request IRQ %d: %d\n",
+				irq, ret);
+			wm831x_irq_exit(wm831x);
+			return ret;
+		}
+		wm831x->irq = irq;
+
 		/* Try to flag /IRQ as a wake source; there are a number of
 		 * unconditional wake sources in the PMIC so this isn't
 		 * conditional but we don't actually care *too* much if it
@@ -620,15 +632,8 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)
 			dev_warn(wm831x->dev,
 				 "Can't enable IRQ as wake source: %d\n",
 				 ret);
-		}
-
-		ret = request_threaded_irq(irq, NULL, wm831x_irq_thread,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   "wm831x", wm831x);
-		if (ret != 0) {
-			dev_err(wm831x->dev, "Failed to request IRQ %d: %d\n",
-				irq, ret);
-			return ret;
+		} else {
+			wm831x->irq_wake = true;
 		}
 	} else {
 		dev_warn(wm831x->dev,
@@ -643,6 +648,15 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)

 void wm831x_irq_exit(struct wm831x *wm831x)
 {
-	if (wm831x->irq)
+	int i;
+
+	if (wm831x->irq) {
+		if (wm831x->irq_wake)
+			disable_irq_wake(wm831x->irq);
 		free_irq(wm831x->irq, wm831x);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(wm831x_irqs); i++)
+		irq_dispose_mapping(irq_find_mapping(wm831x->irq_domain, i));
+	irq_domain_remove(wm831x->irq_domain);
 }
diff --git a/drivers/power/supply/wm831x_power.c
b/drivers/power/supply/wm831x_power.c
index d4e85c233..c5914f13d 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -616,7 +616,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		}
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
+	irq = platform_get_irq_byname(pdev, "SYSLO");
 	ret = request_threaded_irq(irq, NULL, wm831x_syslo_irq,
 				   IRQF_TRIGGER_RISING | IRQF_ONESHOT, "System power low",
 				   power);
@@ -626,7 +626,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		goto err_battery;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "PWR SRC"));
+	irq = platform_get_irq_byname(pdev, "PWR SRC");
 	ret = request_threaded_irq(irq, NULL, wm831x_pwr_src_irq,
 				   IRQF_TRIGGER_RISING | IRQF_ONESHOT, "Power source",
 				   power);
@@ -637,9 +637,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	}

 	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
-		irq = wm831x_irq(wm831x,
-				 platform_get_irq_byname(pdev,
-							 wm831x_bat_irqs[i]));
+		irq = platform_get_irq_byname(pdev, wm831x_bat_irqs[i]);
 		ret = request_threaded_irq(irq, NULL, wm831x_bat_irq,
 					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					   wm831x_bat_irqs[i],
@@ -686,10 +684,10 @@ static int wm831x_power_probe(struct
platform_device *pdev)
 		irq = platform_get_irq_byname(pdev, wm831x_bat_irqs[i]);
 		free_irq(irq, power);
 	}
-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "PWR SRC"));
+	irq = platform_get_irq_byname(pdev, "PWR SRC");
 	free_irq(irq, power);
 err_syslo:
-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
+	irq = platform_get_irq_byname(pdev, "SYSLO");
 	free_irq(irq, power);
 err_battery:
 err_usb:
@@ -701,7 +699,6 @@ static int wm831x_power_probe(struct platform_device *pdev)
 static void wm831x_power_remove(struct platform_device *pdev)
 {
 	struct wm831x_power *wm831x_power = platform_get_drvdata(pdev);
-	struct wm831x *wm831x = wm831x_power->wm831x;
 	int irq, i;

 	if (wm831x_power->usb_phy) {
@@ -710,16 +707,14 @@ static void wm831x_power_remove(struct
platform_device *pdev)
 	}

 	for (i = 0; i < ARRAY_SIZE(wm831x_bat_irqs); i++) {
-		irq = wm831x_irq(wm831x,
-				 platform_get_irq_byname(pdev,
-							 wm831x_bat_irqs[i]));
+		irq = platform_get_irq_byname(pdev, wm831x_bat_irqs[i]);
 		free_irq(irq, wm831x_power);
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "PWR SRC"));
+	irq = platform_get_irq_byname(pdev, "PWR SRC");
 	free_irq(irq, wm831x_power);

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
+	irq = platform_get_irq_byname(pdev, "SYSLO");
 	free_irq(irq, wm831x_power);
 }

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 2036735f0..5ce7cbb36 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -470,7 +470,7 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -481,7 +481,7 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "HC"));
+	irq = platform_get_irq_byname(pdev, "HC");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_oc_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -608,7 +608,7 @@ static int wm831x_buckp_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -726,7 +726,7 @@ static int wm831x_boostp_probe(struct platform_device *pdev)
 		return ret;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_dcdc_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 5afd3094b..5c1cbaf66 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -160,7 +160,7 @@ static int wm831x_isink_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq(pdev, 0));
+	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_isink_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index 34a6d6cf7..7c91edb3f 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -279,7 +279,7 @@ static int wm831x_gp_ldo_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_ldo_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -490,7 +490,7 @@ static int wm831x_aldo_probe(struct platform_device *pdev)
 		goto err;
 	}

-	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "UV"));
+	irq = platform_get_irq_byname(pdev, "UV");
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					wm831x_ldo_uv_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
diff --git a/drivers/rtc/rtc-wm831x.c b/drivers/rtc/rtc-wm831x.c
index 1943cb1eb..35b09747d 100644
--- a/drivers/rtc/rtc-wm831x.c
+++ b/drivers/rtc/rtc-wm831x.c
@@ -402,7 +402,7 @@ static int wm831x_rtc_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_rtc *wm831x_rtc;
-	int alm_irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "ALM"));
+	int alm_irq = platform_get_irq_byname(pdev, "ALM");
 	int ret = 0;

 	wm831x_rtc = devm_kzalloc_obj(&pdev->dev, *wm831x_rtc);
diff --git a/include/linux/mfd/wm831x/core.h b/include/linux/mfd/wm831x/core.h
index 511bcad87..0e34a39b6 100644
--- a/include/linux/mfd/wm831x/core.h
+++ b/include/linux/mfd/wm831x/core.h
@@ -368,6 +368,7 @@ struct wm831x {
 	enum wm831x_parent type;

 	int irq;  /* Our chip IRQ */
+	bool irq_wake;
 	struct mutex irq_lock;
 	struct irq_domain *irq_domain;
 	int irq_masks_cur[WM831X_NUM_IRQ_REGS];   /* Currently active value */
@@ -418,6 +419,7 @@ void wm831x_device_shutdown(struct wm831x *wm831x);
 int wm831x_irq_init(struct wm831x *wm831x, int irq);
 void wm831x_irq_exit(struct wm831x *wm831x);
 void wm831x_auxadc_init(struct wm831x *wm831x);
+void wm831x_auxadc_exit(struct wm831x *wm831x);

 static inline int wm831x_irq(struct wm831x *wm831x, int irq)
 {


On Tue, 10 Nov 2026 02:32:49 +0000, Myeonghun Pak <mhun512@gmail.com> wrote:
> Hi Lee and Dmitry,
>
> This series fixes WM831x IRQ resource mismatches and follows Dmitry's
> request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
> The provider and consumers are converted together to keep their IRQ
> resources consistent.
>
> Changes since v1:
> - Use managed IRQ/work cleanup instead of storing the onkey IRQ.
> - Move IRQ mapping into MFD and update all platform consumers.
> - Reject failed mappings and unwind consumers before removing the domain.
> - Retain polling for release detection; the chip only interrupts on assertion.
> - Drop the previous Reviewed-by tag because the implementation changed
>   substantially.
>
> Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
> No hardware testing.
>
> Previous discussion:
> https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com
>
> Thanks,
> Myeonghun
