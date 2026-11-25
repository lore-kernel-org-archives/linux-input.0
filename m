Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591348;
	b=0/CHvgNeAN0e+K30GROLvhUN8gbhtsMS0J5EjjQSo66gHnZ4QCKeaESB12xa+/iCarL9
	 UwoxihMYodCN42ACn3MeSAkVFJeaw73LhmNlD6L18tAtqcnY8BAIuIl8U7mIAXvfilebk
	 4+MoWeo2Ig5JvPLwPmLGreE7I3H045wutHxg1ML0B48SUCLNkFg4Hi1nma1voyjeAvm7I
	 pK/o7fWo5dMhlBxYYRzQrnREmI8jISpOS2H+2mEUFDlMN9H7QvGKU0MDVawoJGWzlllj/
	 /qhQHNqPqaT3GayfBaW+yF+rMbGiS+uCg5B1UbV5+TLGbxrcd9tB22pOf8sZ7O6CZ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=NVzVp19JvDbqfvDzPWmy1u8rnSEFL2fJi1oKNs782OM=;
	b=RiVX0t01C+D4WZ6lAM5OtdBQP1TCUTsluFIjA18YKCAUKdCszc3oHDLlYcMAb+bow3Lx
	 YFufDCqrbrTHcGemT7drmHhuRwQ2uZ1xrjGKTwlzTqU13J4xhkmh3m/bLS4SXvERoOiaT
	 gPRYcSuaYlJRgR2bDwiEOiF+UbAddkxYnCeJB4s67e2rm7mmsVhYAJz5ewqoeW9vxRlm2
	 caFqiEQ5MciCzy9iBXAiBBPA6trc5W8QNPLFtagfZ4K6RkqKFPWj6clgoJT7HNjOJgHjP
	 4e4nNAb4YTulnQEZczwuciLmsQGfH4PAJF8uhwbwTaAHmWT2AR07jDZro5a/2Rm+ziA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ebc3LPkG;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C454606A331
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C454606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ebc3LPkG
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4a357b1c649so3107306f8f.3
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591346; x=1796196146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVzVp19JvDbqfvDzPWmy1u8rnSEFL2fJi1oKNs782OM=;
        b=ebc3LPkGfZ36BSHh9sAN0hKMynsolsNDPivSZNKgIpJJJVABMJuGT2891EIvh572XW
         FxY0OyHa+Zwg+kWM0iQWUaEkQ3fHvOg4CzVWaVMqhA2iuh+JmbsifqSvbd4Dh9sjnNN7
         EOGntMQS/qrjLgtHbKzeeCnRS2R3VtyU/paJvROUadj+Vvu3CSBfBZ4WztlX6oQUbw95
         qSv5OAqzSWUvKZOABsXQO8Dk8nKmXlP7uZkm8W9kv0lpqxgqoMn/yojYb0TuapzY5jDX
         vB7crUrvbWkhD1SiTfxM7zSFX0LPioWfielKMHj8FpUqMTcscCneT+S4Fzi+Us41Ny3O
         aosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591346; x=1796196146;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVzVp19JvDbqfvDzPWmy1u8rnSEFL2fJi1oKNs782OM=;
        b=JFav6DfzhKP35V2tiRB18TIN2MmXa21cAe5RwRdulGvgSXvjEqPE4LN/YLkRCULFzi
         fY63reGu0eoSU/P9/GkVaVdcgwFbXnEqJQhGuWwINW7lPHVxO2YJZM15AxhlVI7Yec9B
         CbLERqiMGv/prR0WwxC/+phnb7O9Gzq2VdSvDbrNo3LZ0dpL3J8Zx/ggmiVsun16ogDj
         XfVZB7KDqQNrwuku/znTv9VZdymEOj5tbCskVqkSuxATN8i5pS/CNI/xI5g3XK8Mf0v4
         R1BIYidN6qTIK/AFGzuyJp//Yf/6SgRn/MPGrGChCnMUjy3ughsxgi8kqxe9r8j7j2iU
         tFgw==
X-Forwarded-Encrypted: i=1; AL+hErG2FFz/rw5Y5QzBHqaYH6KKjRCKZ6R5jKUIjwqw28cIdk8aCTb2aD9PjzE3QO1VL2dIaOvFVpj8MnkHnw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+uVbXLKxsPEouZ+eqNseWBxYa0VbXu7Jl2jW7vZqdcmoK1afP
	ehVyfHxLC3Vi6jxz818dVCH0ud6DknPq2DI6NPqwb5K5yT8VViwOVFsD1kWc99ByARo=
X-Gm-Gg: AZFdTZfDo+KPieJrTdc/gyz/ofrJI8qwEPZptaqNuplboWcaIXKQEBrd782ocY3EHgG
	BKX6zK5zaRtlmNBtJJuxNk80O/Nq/0qOPQL7dBY6vb0GxdJuFh26iC1o6euMBwggbTxCHxamxjW
	JYHEhy9lc9g/KNFwKxjfkITPEwvnG0duPv1GlTSa0aUIn9cnuXSMGYq/SX6Qwn3IiOk8Q0pkBwd
	yt4dBxtreXP8Z2BKC5cwLDF7UkSSdpGuK3gwMf6n+ey7olriStOOLGV0vH7oRKzQhlF74whg5ij
	HRPpHsgX2GrfwQSHwXotrbPz0xCLPg0hjMFsYdQ5KafFCGONxKfS1znJg6qdJ3Fi97Ml+FWsptA
	9mxRrrVnXlo6yCb1oL6LzTX5de/X83/O9gJkDAe16ENdeFPVp5KUGSrGX/RIlU2Njb4arydPv/6
	ypEa6zT7vCIKNAi+HE9Lhlnj9yWUCmBuqX0mPBxouq1+PA6h59hFcVtWGnZNDEJ811wkE94n0wG
	ViVC1K5fmbV97njB6qnDwzNkv+7YJwmpNqJ2NuCwfOJj2+g8y3H6tf0TSejAEqLcoWjphk13Fxf
	oV/VPSPbSPE4BJ16itn2llgqCEnObycsvS4=
X-Received: by 2002:a05:6000:2b8a:b0:4a7:b365:19dd with SMTP id ffacd0b85a97d-4abb4b85bcbmr21871977f8f.53.1795591345712;
        Tue, 24 Nov 2026 23:22:25 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6bc8ce06sm31646643f8f.47.2026.11.24.23.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:25 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 9/9] hwmon: (asus_rog_ryujin) Benefit from pointer typed driver_data in hid_device_id
Date: Wed, 25 Nov 2026 08:21:41 +0100
Message-ID:  <b59ac871503e7edbaf8fe0cbc2fac61129f8de2c.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=IYSG7hypyn2y01x+I7WvsjnBk57ikf9BHMp/yyVSFFY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBoySC0L9INXi0JtCpW98H7fphBLSocscIWR+r as/yOjsmD+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMkgAKCRCPgPtYfRL+ TiZjB/oCqZ/ZQR2avl6RrtiZNReg5yDrMGz2dREpA5Q/6Lg0IZQPiBCFijYnveQL4JgHx5SrjPC eWYl+VO8vurmR4noHzB99BgGYZ/cyv0JdzWagNJKhaISe2crddunoCqlKIZntEHsoWFuo1pyvNi VT+CQeT1CIuAPkDtVEl/CatKNeQo7r25WplgPLmx++3i+ltl9EeoNHWJc8NzYdoKjsiFR3+/Ebr T4VNoRlDR5m97l4rECHwjur2qX7EMb8ER7ZidjugznnsoUmy/OlEsp44tUfnpKL17wPICeKCZ8C /FFeqK5AHmM/Ot9kx9exmovCeRyiyTVg+AoHrV5OoPyn8h8E
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With using .driver_data_ptr instead of .driver_data several explicit
casts can be dropped. Do that. Note that with

	priv->info = id->driver_data_ptr;

instead of

	priv->info = (const struct rog_ryujin_device_info *)id->driver_data;

the constness of .driver_data_ptr is checked by the compiler without the
explicit cast.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/hwmon/asus_rog_ryujin.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/asus_rog_ryujin.c b/drivers/hwmon/asus_rog_ryujin.c
index e9722c2dec63..ae53e7583001 100644
--- a/drivers/hwmon/asus_rog_ryujin.c
+++ b/drivers/hwmon/asus_rog_ryujin.c
@@ -696,7 +696,7 @@ static int rog_ryujin_probe(struct hid_device *hdev, const struct hid_device_id
 	struct rog_ryujin_data *priv;
 	int ret;
 
-	if (!id->driver_data)
+	if (!id->driver_data_ptr)
 		return -EINVAL;
 
 	priv = devm_kzalloc_obj(&hdev->dev, *priv);
@@ -704,7 +704,7 @@ static int rog_ryujin_probe(struct hid_device *hdev, const struct hid_device_id
 		return -ENOMEM;
 
 	priv->hdev = hdev;
-	priv->info = (const struct rog_ryujin_device_info *)id->driver_data;
+	priv->info = id->driver_data_ptr;
 	hid_set_drvdata(hdev, priv);
 
 	/*
@@ -789,15 +789,15 @@ static void rog_ryujin_remove(struct hid_device *hdev)
 
 static const struct hid_device_id rog_ryujin_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS_ROG, USB_PRODUCT_ID_RYUJIN_AIO),
-	  .driver_data = (kernel_ulong_t)&rog_ryujin_ii_360_info },
+	  .driver_data_ptr = &rog_ryujin_ii_360_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS_ROG, USB_PRODUCT_ID_RYUJIN_III_EXTREME),
-	  .driver_data = (kernel_ulong_t)&rog_ryujin_iii_info },
+	  .driver_data_ptr = &rog_ryujin_iii_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS_ROG, USB_PRODUCT_ID_RYUJIN_III_EVA),
-	  .driver_data = (kernel_ulong_t)&rog_ryujin_iii_info },
+	  .driver_data_ptr = &rog_ryujin_iii_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS_ROG, USB_PRODUCT_ID_RYUJIN_III_WHITE),
-	  .driver_data = (kernel_ulong_t)&rog_ryujin_iii_info },
+	  .driver_data_ptr = &rog_ryujin_iii_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS_ROG, USB_PRODUCT_ID_RYUJIN_III),
-	  .driver_data = (kernel_ulong_t)&rog_ryujin_iii_info },
+	  .driver_data_ptr = &rog_ryujin_iii_info },
 	{ }
 };
 
-- 
2.47.3

