Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73A83AFAE0
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572805; cv=none; b=aPhaCduH04hDPClo3zpJcs4oF2CUYmGgdgBKbPK2kbUdeLdqJ+JiTEjOTz+D95D/KsSLHrPgDARqjw/LCYQiZdymP9PSxOcgDAAf8ya6gd6k/X9HYubum2jH+ks47np2aPGTOEFTqddHtnHdHuf2xgc3AHiBk1rTdAsvL6mLtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572805; c=relaxed/simple;
	bh=Svna67/rxF6DksoFBUX9w6XOFyVVHvkbN2umn96QZkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYa9V9ZQpOQYIeWjVoa/sg4W2Io2zQo1I943TMiPVTcw2XxJC5aAZRLiKUZ2paz9p4OuBlNhrUJdmM46ywetkRK6nMW8vDLXL239lAaxx9iX214yWHY7mOIwbFCubpJCHK47K/V/xdKeW3a65kzo8y0IDBwNEIJiLaCjJWt/VI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9lyiBHk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9lyiBHk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca80d708489so314896a12.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783572803; x=1784177603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2coInV2uMlLIpeqglM0vcfoc2SKHKrxAU98gxOM5VA4=;
        b=X9lyiBHkzjSoaVCFPY6NCEE+xP4jCuH1+IZ88hd7nkE1CoaHLZSnKEGW5t+CAy+ZnC
         tbeIZ+VXfDsgeyXYNxeyYd32PKOgbWeYH2OoFNIKzZVEpI9q/J3oXM9lHs4i2FFDsgBy
         s4d0mZXMNqQCcNgNPN8UKNv+jzwxli8Ha9zH95GJ3niAKf/sUTKnKQ4hwTTDCxZcB+12
         oD1ZlPcf2aH7mAvSTfyni4pXwc7PnHocPklyrBnP3//LGD3c3cpJWwVofkSJM6NWZZik
         iMgQ+MWc/Cb9BoEgkB4g7FL3liRoy5LQrwSJt0pwTr+uD8SfpkUv6Y2sRPutO77yfY1G
         ppcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783572803; x=1784177603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2coInV2uMlLIpeqglM0vcfoc2SKHKrxAU98gxOM5VA4=;
        b=TndOFXuGDDT2Y6PfAllFW28qYZ7NITKbBLN+hWbBc5RdZM/A6IeuBfUsUbCVwrqo+F
         borHceHOo/oCpspau9QIiJb38H3K9NqvrYk3J1ZF4avGs9srvBaiGKwEJf7xZZiATt1J
         /ZqTjgFWfMQrYZXqVniZTL+2s1VD3q9BYlnipeezTT+5biVcrHOshP+qesORmDKPHsOc
         MODgHmKUSSA1pbaOP4wlycrTWVAB4f7TG5g72mVjEUwYpg0hT1LcWQYfCk4qXxPoS4io
         5jjyFEdLXlGBeuxUy8dzafnQhZUp7XN1bMup6bjJ2CGagHz8oWUr1479kaeC3liR0kZt
         odoA==
X-Forwarded-Encrypted: i=1; AHgh+RoK+pcXE2SaPf81rxoPsafEma68/vG2ZBO+mz2a2llkOB5MCeDaVrd2XhiQoZh3KMiZbY6NtdbrJPrvXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9H2lYF2JRCYovIMcw2GqOvuL0EG27R9fiM+eSw8UPUGdjAkZ
	8x6lb/CmsXY1eRIqN+rQ4YEGvspyeyuJC0QS5GHOeFLxXvvIdPOoyUu8
X-Gm-Gg: AfdE7ckOVPSESfmKy7hweMLS2kiusHN4PDlHOLnMw1C9DMS2cx/08jC3k5Ms7wxcy7C
	Cy7uydKWGUgtWI4qofmd36neGvD6wskWaFJADL0R9chVTKnoCAaNej2m1bS7VI6Nze67INiDKzK
	AsIXEET0gCCR4ucjquU0cpDvncFS1aQo/tR/fIqLELwxPfByAzdS0YY3sl8Z6hid5WxQoPFDKPM
	BqPEKXMvrcvDIaX6aIxU5WfqsIB+N8q4e8ImHYcZqge9crJHVg1G1RcbJqStNeh5DpFQ77c0LQ9
	WHwrMXIjT2Zs35MYl39iooMSCeT/rb9AduU7U/+iF3FIJPQhjYePZtuE4VHc8TkTSqMIcvH/m5q
	csNFavbf8WpX9+fpCR/YHmF1yr5SFp+H5/hQYZ3dAJm4slaomsGUbJ2dbAjwUKOxEC8uBkewr/0
	cfzb7ASSsr9ni8ne/7y60MOH/elDWdVoGCNpOkld8zKVA/hqgDhwZ9uZ2i78DutDIsd1C6fKCBX
	K1v
X-Received: by 2002:a05:6a21:6daa:b0:3c0:9acb:3fb with SMTP id adf61e73a8af0-3c0d6a8ab01mr1403688637.32.1783572802842;
        Wed, 08 Jul 2026 21:53:22 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e229:88c8:fd09:9a39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm26559252c88.0.2026.07.08.21.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:53:22 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 08 Jul 2026 21:53:07 -0700
Subject: [PATCH v2 09/11] regulator: wm831x: remove legacy DVS platform
 data
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-samsung-kp-v2-9-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
In-Reply-To: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 patches@opensource.cirrus.com
X-Mailer: b4 0.16-dev-b242f

Now that the only board file in mainline using wm831x buckv DVS has been
converted to use software properties, we can remove the unused legacy
DVS fields from 'struct wm831x_buckv_pdata'. Also remove the fallback
logic from the regulator driver, making DVS support purely
property-based when software nodes are used.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/regulator/wm831x-dcdc.c  | 22 ++++++++++------------
 include/linux/mfd/wm831x/pdata.h |  3 ---
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index ce43c51c0170..05f49b2f5bad 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -336,15 +336,10 @@ static void wm831x_buckv_dvs_init(struct platform_device *pdev,
 	int dvs_control_src;
 	u32 val;
 
-	if (!pdata)
+	if (!pdata || !pdata->swnode)
 		return;
 
-	if (pdata->swnode) {
-		struct fwnode_handle *fwnode = software_node_fwnode(pdata->swnode);
-
-		if (fwnode)
-			device_set_node(&pdev->dev, fwnode);
-	}
+	device_set_node(&pdev->dev, software_node_fwnode(pdata->swnode));
 
 	/* gpiolib won't let us read the GPIO status so pick the higher
 	 * of the two existing voltages so we take it as platform data.
@@ -352,7 +347,7 @@ static void wm831x_buckv_dvs_init(struct platform_device *pdev,
 	if (device_property_read_u32(&pdev->dev, "wlf,dvs-init-state", &val) == 0)
 		dcdc->dvs_gpio_state = val;
 	else
-		dcdc->dvs_gpio_state = pdata->dvs_init_state;
+		dcdc->dvs_gpio_state = 0;
 
 	dcdc->dvs_gpiod = devm_gpiod_get(&pdev->dev, "dvs",
 			dcdc->dvs_gpio_state ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
@@ -362,10 +357,13 @@ static void wm831x_buckv_dvs_init(struct platform_device *pdev,
 		return;
 	}
 
-	if (device_property_read_u32(&pdev->dev, "wlf,dvs-control-src", &val) == 0)
-		dvs_control_src = val;
-	else
-		dvs_control_src = pdata->dvs_control_src;
+	ret = device_property_read_u32(&pdev->dev, "wlf,dvs-control-src", &val);
+	if (ret) {
+		dev_err(wm831x->dev, "Failed to read DVS control source for %s: %d\n",
+			dcdc->name, ret);
+		return;
+	}
+	dvs_control_src = val;
 
 	switch (dvs_control_src) {
 	case 1:
diff --git a/include/linux/mfd/wm831x/pdata.h b/include/linux/mfd/wm831x/pdata.h
index d73a04c82ca1..c48333552f5a 100644
--- a/include/linux/mfd/wm831x/pdata.h
+++ b/include/linux/mfd/wm831x/pdata.h
@@ -48,9 +48,6 @@ struct wm831x_battery_pdata {
  * I2C or SPI buses.
  */
 struct wm831x_buckv_pdata {
-	int dvs_control_src; /** Hardware DVS source to use (1 or 2) */
-	int dvs_init_state;  /** DVS state to expect on startup */
-	int dvs_state_gpio;  /** CPU GPIO to use for monitoring status */
 	const struct software_node *swnode; /** Software node for properties */
 };
 

-- 
2.55.0.795.g602f6c329a-goog

