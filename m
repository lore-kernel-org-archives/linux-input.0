Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591343;
	b=GsFRnBitK/ZBzwWnKjFysixdmGo1nbJ/2gqhE6ngjyQz80qCoXKDlAaJQK9Jvs24TAh4
	 4oKql6MvGy1Ccb8AMAqpm2KboBcz3RS4uqRkdZ51mXBnEVnkf8UgJavEZQNWEXXMIlHQH
	 G4ubwyzsWs8mIC5j7IM60wBRipYRpF07okeXutJwH49jTNEmACxlEteTl2+LsNaR4JrBQ
	 T/R/tLISD3wtUhC8TqXP5cvDoHqh98caXCGvVqHvwORlEeX6FRJgatmnNwoJIfb3v3DBm
	 JSWAxrOAkg+xJHeNE7b1aLTgVuHhSxIGqMQ3LzNWRWBbkKSN23UTU8Fq3PS3K+Ot5/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=y8cfjjz4r6naL4ySl2i/NxOj2tW6aHmkSGbH4kcPTRo=;
	b=wp4r3Ef91Sbqs10x5jpPMUalHVzwWzgre+lits9pPZxIlZhXUBKGraGCO6xUtRduy9Vg
	 by6O0NVak5OtmAF+w81edHYkpaD8Wgk5XPrOMiPh1myOndGumGpbFbijPtPHN+m4wNNtN
	 kn0P1qrkpv7ytF/mi5tJbpMGLwWL/QZaUBIfl48IGv+4PfDY3cbuw//po3rhdbgEr+Mjb
	 9wk8gluyo55EEuU1tov22h0hVA5W8I0AbZFZ2iqCY58CmNj3GvlJEPm6tDFn1xWMmUBHO
	 bjDvIh28VS0Vsf2P2bBaVZpxsjmMPJkEA4U4DPvIcGN7TZcOVYqMAESg6MpLA7MrGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=l2b1bxDZ;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD4606A326
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DD4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=l2b1bxDZ
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4aa5833c263so5170542f8f.2
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591341; x=1796196141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y8cfjjz4r6naL4ySl2i/NxOj2tW6aHmkSGbH4kcPTRo=;
        b=l2b1bxDZmFuQmFGw29BylU0gTNYRmFvT+sl6KsXDEekK8gaW1qKLlejprq9f9EgYEv
         oPNRszjAZbElLowNFWAOvIwK3i/aqGrwfveAohDxZ4gf1uDCL/D7K2GhfQjkA3YmpxTJ
         aLpmhptXk0/46vvqlTY9lY6+rvNaJSzsQkOPsfUiX9/+bezDgkt6/RGDDckvyzaKcE4F
         x2SLjayguoMRt+PP9K4x1Jmc1PxFCAtIhibhrwUhfqe3MkxhwZbgi7adnAZAQDa1gEJH
         UCopm+zVhXMqyuAQn5JJQVV6+uhRb7WxrR1i+3sFWmh5gYC1u/u9NShnRwqIjB1RNaYW
         nfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591341; x=1796196141;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8cfjjz4r6naL4ySl2i/NxOj2tW6aHmkSGbH4kcPTRo=;
        b=1bDYFB/YgTiTnV5CajN83dJzR36s/pcZz0mg5tcfScqaMJU5f0rBlPcYSlNt3kGzwv
         y2HBhgGthjCeYUVQngdfxhZvt0rXBCuMwfgg4raNawuI6frfKkZ8q/vlLaA0vcYkTkj4
         E2NtqbzFpzYti04Y7gtxklCDiF1fwbmcli66baTRStPTGBvd7dXWVJPGW3tDtNiLKCGw
         B3d20KNbGDsrPGR6XldgGWNRo1z8r8RqmTPWxW7v3fd1tSR9i7COXVD8adPpgQELgYlD
         5VU0YvUbb0WC+4p3zNQ3uEL+FPzc5Q4cXRhG+XdP2mgPoBmrnALqLmZ4/8R3GhzxksZx
         +j8g==
X-Gm-Message-State: APuU4Z+mxZ4CCfsBmv2J2+HMzPEQO+RldQhmUFXD9zklFC3RPDnc9648
	/UoQZa2YjxRi6oHlY+lGYiZtsRuNeA7h5nYhO6fq949KC814w8K0ME3Fd9UV9NZOEw0=
X-Gm-Gg: AZFdTZfspu28HaTmb3ZyhflfBglfY8En+jVCLLKEwU57SEPwIRxaqLuMnPUzbkTBZii
	qUat0qK9Lk05+hRP92ZJyDpUIT9GnghDUBT+TKe5q33O1Y3RakPLGxGz0+7oDrBUl92aHazuqnR
	gErEGSnGFh2FCd0t6rKiMYA6NCbsFV50Hdd2INOPlZKoVtKa2GcuzLW9+fFb3YkaJ6rO3vqXDqK
	iGAr9lGd9hiRmNUL6F24X0TKpO7B4Zy/nHmWsJX9xjRR7c3tNBD5nAh//iHUiNEUOZDSKaMUg5L
	4gAUXezhrAIZic7D90v5oo//lj/8cL0Yv/+XxsJQroW/YTSYAWv6n2GxJKpF08uiqI4WaN+8NSg
	yhlL0Pa7V/jOw1WYmZI33dkR+vLovx7Tu2VvBJwcDPrAgb82jLS+CLdwlxI9RbGvJrirWrBqTvN
	tRRctY1r5Kx4BUuCpawIA8k/vkVxFnG52roZYpSrUF5OoQbXddgj1lO2JZAKIjXRZwyYPUoDLH1
	27Uh+m3VmxBUjnZpmcXwBF/M23bhU25pfYsBb9j7ruzZfD73BvZJrgb4x7DAIZYRnKLo8sfS11l
	j9C7sbImD/COeRUc1eOEPEBOCPPyuos9H7aLSjL2tx9jVNZNPXBG7SYu
X-Received: by 2002:a05:6000:1865:b0:4ac:5eed:1d62 with SMTP id ffacd0b85a97d-4ac5eed1d7dmr36754833f8f.10.1795591341061;
        Tue, 24 Nov 2026 23:22:21 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6a67f204sm38296149f8f.21.2026.11.24.23.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:20 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 6/9] HID: steelseries: Benefit from pointer typed driver_data in hid_device_id
Date: Wed, 25 Nov 2026 08:21:38 +0100
Message-ID:  <a608a556bfbd440da6f51ca33cb3c96f6c91f00a.1795589119.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4948; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=+lcT/dJEiQSvRCc57rR4ZMANNefD5Wwm5YrrsgluF4E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBoyLzIDRNEBkn+GqN2wGK+WukY2f5fjsCfMXE +wB7aub37+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMiwAKCRCPgPtYfRL+ TiUHB/oC0WMG7D7742BR05ZPeQmpRSaQeX9PUvdmjHQc8U5rNaQMX2BJSCzgHarAeQouw/hYQ48 eRcYBks5NcAjq1CNw7PppFA7lri6zvHWXKCEkJo2kbgjpmsoRFyVwct6EkXF4UrnHhNzYTzpg1H htwDjo9GprbqL2JbSVZMaBPGZJG6fLTnwcYZsP8JLvY7+B1Hbadx/SByr8PhMIle8PkJPU/0bHU O9Gg7PtIYyIg2bqBnu6pftdLdlrb159hHoytHX+iVxxq0f/ctQANh1E+V9bmORcHV+xYpVouo7h zbS3L2j9biyvbjHi355c7RDy1i4lgsc3fi90Ot/AWsaW1qxW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With using .driver_data_ptr instead of .driver_data several explicit
casts can be dropped. Do that. Note that with

	const struct steelseries_device_info *info = id->driver_data_ptr;

instead of

	const struct steelseries_device_info *info =
		(const struct steelseries_device_info *)id->driver_data;

the constness of .driver_data_ptr is checked by the compiler without the
explicit cast.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/hid/hid-steelseries-arctis.c | 39 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index df61fa33d4c6..81c801271f29 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -486,8 +486,7 @@ steelseries_get_sibling_sd(struct hid_device *hdev, int interface_num)
 static int steelseries_arctis_probe(struct hid_device *hdev,
 				    const struct hid_device_id *id)
 {
-	const struct steelseries_device_info *info =
-		(const struct steelseries_device_info *)id->driver_data;
+	const struct steelseries_device_info *info = id->driver_data_ptr;
 	struct steelseries_device *sd;
 	struct usb_interface *intf;
 	u8 interface_num;
@@ -693,56 +692,56 @@ static int steelseries_arctis_raw_event(struct hid_device *hdev,
 static const struct hid_device_id steelseries_arctis_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_1_X),
-	  .driver_data = (unsigned long)&arctis_1_info },
+	  .driver_data_ptr = &arctis_1_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_7_2018),
-	  .driver_data = (unsigned long)&arctis_7_2018_info },
+	  .driver_data_ptr = &arctis_7_2018_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_9),
-	  .driver_data = (unsigned long)&arctis_9_info },
+	  .driver_data_ptr = &arctis_9_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_5_X),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7),
-	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	  .driver_data_ptr = &arctis_nova_7_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X),
-	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	  .driver_data_ptr = &arctis_nova_7_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2),
-	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	  .driver_data_ptr = &arctis_nova_7_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO),
-	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	  .driver_data_ptr = &arctis_nova_7_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_WOW),
-	  .driver_data = (unsigned long)&arctis_nova_7_info },
+	  .driver_data_ptr = &arctis_nova_7_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_2026),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_P_2026),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_2026),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_DIABLO_2026),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_GEN2),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_2),
-	  .driver_data = (unsigned long)&arctis_nova_info },
+	  .driver_data_ptr = &arctis_nova_info },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES,
 			 USB_DEVICE_ID_STEELSERIES_ARCTIS_NOVA_7_X_GEN2_3),
-	  .driver_data = (unsigned long)&arctis_nova_info },
-	{}
+	  .driver_data_ptr = &arctis_nova_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(hid, steelseries_arctis_devices);
 
-- 
2.47.3

