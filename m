Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591344;
	b=kVkDeVLZex/MdAjTaI0des3Dq78G+Ae87Q+LuG2/92LARMNvcuWqRvziRZg93cyR0dLV
	 J+kzfte2c3DU1Y7ycIKqtaQKeg6P0vYdsr6vf1Ols4yeOBi8cZoqHIBHkJskIpXsaPSRg
	 sc+mjLIzEzrZKVseBUN3GCGV4/J6LQvTsXc/Gkphp3CEdD25huEmuXlpgwnnG2jDpZEwr
	 4B2Ux94GjfD0xzcVWnuPGBxTu/6vAnslv4A04Vei66CB2ShIvZ2/vHebcneKJn0TRyMjY
	 M8edoPjannaHIdONHIBk7uH6IitjVdBE+aUoBIYrAc7dX6UfAYuHCIDAlDJDAc8fgEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=IU/5EU6kLKWQTqQMCwuN+Sfr8qGMe++p5+2CQiOJDp4=;
	b=QL58hc7VYqvkFqTffHvKbXlEiVrH4uiJQbSeuEQzPv8HRG9Gcow3YrHSspICzY5TVRaQ
	 IVpYumctmWgqlYuTQfMaFSMfe6FRdEl/fHZmhHVSCxSHyaXB0tgMcBMSxPcDhQ4qkAuQ6
	 95Ho2T4N/olGprc6JaC4fhgpXd9TplnLeZ6gwqC2EImnaBL0Sjmpz25YRSdFEDYWPQMn1
	 lJn/9mrJ/z7DfqOgMUhmqGgnVPf7nIJmVIo+M1jgh02ihHh77D0npNWb1kGQp6R5KKk4I
	 /HKx2YuLdhNvteIohJHuOJutIW6v3Yow05YUnkFX2u+Zmv2pNWkJloHCv527cqy0eNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jdoByc6b;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA09606A331
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA09606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jdoByc6b
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so41300095e9.2
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591343; x=1796196143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IU/5EU6kLKWQTqQMCwuN+Sfr8qGMe++p5+2CQiOJDp4=;
        b=jdoByc6bVPQCzqFF3mA3N37rzFUSBMbO1xDlXjGGB4wt6hBFsCoE/mXz/sClW2GWsO
         4+V07N0vs0z6hmkvf47KRF5gK5Ge4HJVqnpMhGe2VAAIs+Tv8GIxp8WQo+T+jIr1Czbr
         lsULpw2VGZFPbCzXkOaxTCPwQaNdV2tcimg27HZpzzipUa1Id2pldhPlvf8TOJoiLiuP
         EkgtuCPd9rO+19IacxRw0Z9XjW6Ls77SlhMf9bUROhsfIGbHYBM2c5x3lZ3JA5vuD6H8
         fIjI2sdXgHXdZfBskPg/yLjbh5KjgO8yJEB/ZoCN4K6xwsEY7pjqh2Nz0hvaIQV8Z6F7
         BlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591343; x=1796196143;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IU/5EU6kLKWQTqQMCwuN+Sfr8qGMe++p5+2CQiOJDp4=;
        b=z8qYlhia7ZkR5SpK4UWEK+nWztL8sDUEcGWsC0XNLwCrUfJKBLPJNaJelSFuOxrlDZ
         JFxcyyFbvXMryjD5ILbe/teCzYLkODJRqTNsdzLl/1jvhP6sW+doM/sGTYJwP7S5dQx+
         SfVTfOBylXHcnoD1hAc8njXrlmKhxvES+/5uMvzYXcjjymZqEbPj9140LMh+BozSoiN6
         JZvlnagtpJYJAYkc+beBOd/tPILyLY7fqQNEj0Janjjv1k1c3bAjJE8qO60EbaoPJUho
         MwQjUJkHGtWndIO+gHFL2lpXA2BCTtXbYlDIYgCDbr0CN1ZwifhrgEtNuPrH35cpcFAK
         VUsg==
X-Gm-Message-State: APuU4Z8wtJlxwVREDXgam/jRMWJ+wb+qBnWrQWDrQ8h0T3RJfemxhFbD
	s/SZga4yZINZ6zwavUeQbxA9+qsL0+9d/YE2HzKFO7ShTm3kcwLyHX07CLUng25SEvQ=
X-Gm-Gg: AZFdTZdBnlKVCJoPpKaZBumpW0AUDweYBOPmeDuwItHRYAm0QJ3Vvo+YzuR9vfB9D9z
	o/9bA9qHcycrpPE2vGQx4XkifXmPxtW/WFc/XT73Z82jO1FiJ2rJbRVni0jZUN/qoN71N7DaXzs
	uHukm2U/mzQmGLaa1ctFO9Jo2yAwsNirHT5xxlN2yYtR/D4ulS9UwEISLtQUPrnEvvwMI1d8yLR
	BzUzSRzHXbnZn6sjZrTZCPhXOL/VfYNM5bq40Td0GLy6Dv7xzQJsud5OnOe+TiqsEB7iraUpQnp
	l/KhTMBp5YrOPV87Xs3NecIGcez2JRCjo7otDr107dPbT9IiR/8EMhVjTO/VrgR6a5zNzlq6v72
	og+DYWcecmyWHxSRQOxP+XWLRHcIF1GUyTe3b1Y7yKOs/aKBRGK6uzG71ydZuXXzN7Ki/MOxx9P
	CJ7pXlOLnhjWU0JHytQXaIAD0MOnbX4QxDRyjryS+YXns5tvbDbOES8/UFnS0tvzQb/ocBRnpW9
	w9ILrkMCVJNIYfpyljldX7YMbh/hmQKKn6uCXij8fLoMueAFrTJFpV9sywhThRpVQcd7C9IgcX6
	WhZCE/oanQZgKh+5XJGCnbh7hs1VilPNPhM=
X-Received: by 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id 5b1f17b1804b1-4bb8880ef6amr365746595e9.14.1795591342751;
        Tue, 24 Nov 2026 23:22:22 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8533579csm433940905e9.2.2026.11.24.23.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:22 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 7/9] HID: tmff: Benefit from pointer typed driver_data in hid_device_id
Date: Wed, 25 Nov 2026 08:21:39 +0100
Message-ID:  <7a81a87f31cab973c732655bfbd1f0a26f10a9e4.1795589119.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Koo/sPRv396KRBYM+orlPuG9eMfo1P9PhjdbhkmFBUg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBoyNx0fNxJxYBJKZzz7osw5SYjT3cCi232BxQ zZMCsxmEEKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMjQAKCRCPgPtYfRL+ TpZiB/0RRQFM2UcnCkVD4oZCckyuOCPiUxVQlDV09o4yGC4AEGuD8823HWY9+WZMuH0FwKXYtCU IxC9BI+8J7VCe+ebAFBnm9k/fLqaIAVinclHcw87GcOs7ifJHNwG2QanH8Vbu6XUpl0yJ15UJ0C 80ImWk8DVbUaR0bVltDcjvpOSa7+Mcpr1GcCzy4Z8AfKTizlw+T9UoDl4Sw3peNqzY3bXxoISfU 9K9XaLJdxbNMw9vcsu1pgRrFzsrS/BRzxYQtpjrlRUmeA3be6rLbo908s8IvxBHRuHHaEJQDOVB L5z4ew5hW1TKauGpeRJQamZXJirOJaXdC4uRJI2oVpKF73g0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With using .driver_data_ptr instead of .driver_data several explicit
casts can be dropped. Do that. Note that with

	ff_bits = id->driver_data_ptr;

instead of

	ff_bits = (void *)id->driver_data;

the constness of .driver_data_ptr is kept and if ff_bits were not a
pointer to const data, this would result in a compiler warning.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/hid/hid-tmff.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index 303769b07628..795d23cd6290 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -134,7 +134,7 @@ static int tm_input_configured(struct hid_device *hid, struct hid_input *hidinpu
 	if (!id)
 		return -ENODEV;
 
-	ff_bits = (void *)id->driver_data;
+	ff_bits = id->driver_data_ptr;
 
 	tmff = kzalloc_obj(struct tmff_device);
 	if (!tmff)
@@ -217,25 +217,25 @@ static inline int tm_input_configured(struct hid_device *hid,
 
 static const struct hid_device_id tm_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300),
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304),   /* FireStorm Dual Power 2 (and 3) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, THRUSTMASTER_DEVICE_ID_2_IN_1_DT),   /* Dual Trigger 2-in-1 */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323),   /* Dual Trigger 3-in-1 (PC Mode) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb324),   /* Dual Trigger 3-in-1 (PS3 Mode) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb605),   /* NASCAR PRO FF2 Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651),	/* FGT Rumble Force Wheel */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb653),	/* RGT Force Feedback CLUTCH Raging Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654),	/* FGT Force Feedback Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a),	/* F430 Force Feedback Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, tm_devices);
-- 
2.47.3

