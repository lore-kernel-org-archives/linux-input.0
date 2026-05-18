Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA43FDBEE
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120424; cv=none; b=fu8KwBFPqS6EX1Zl/XdVmgUKDite4zBK7S1h3ryQ/o9sGnlgwoP5qDQDgrVIlGnL1AVGuJiUesibgJPHtYlz+EnisHdwTKX8bXzmBrwQ+lKOzZ2yjtrOTiA47rbWiDinXQ5rZ2RN77Y7hW8wNqHA1hxRyqJz/0MN25Q9Nvr8Q0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120424; c=relaxed/simple;
	bh=egSOONxdnqBhFwUZnKXnaBT3uMNM2lXVFquENOo2ChA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gys2yoF1n8tioxcGJKPSTBgO+5W2okW3+Lx/l/lUCkNAjQ9gu09tcvV7BaOHP2X4K6+qBpB+1XS70kJWw2P5DxNE8y9iRKXFP4NEb/aBvTcZKXqcXTVK60nCSlc84uYyGFBpk38cCIUAshGzMqGo8z2jtnTR29BmagupYzH5/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=smXU7tdh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="smXU7tdh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48d146705b4so26934675e9.3
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120412; x=1779725212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qIz31yrxS9W/8Z/8yM7blQBiQ6xv2671X73kGvx6JQ=;
        b=smXU7tdhMmpFow6neuEK5euoW11b++ASaz9ATdLlfU8VFcWoRr1tTEVlBmsBzbDWQn
         wJ5NFU8sYddGJm1O3fySV73+ZyWQNXJwQUhTeWt7ZgCynM1m5XNs4Uqhe7+WaoOOS1ix
         Gt+GkJtetJNkEFaJcnny37gqxZHzBLjDWFdAZDrIw5Bgv+axq7U/L3N/Rrd0CH4NNN/c
         CuR9T4BKfOy+T9pm6gqNgj7s6pah5t5f4tu7Aj6bOMep5fc6YFWAU5JLu3gMxrs3QAOb
         UUlhjNXiU4bwEfYNfuqiF1HSyEskrokZufhPIsTrtiaknqsfevEyFTeh+k9Lo1TsTqWs
         T/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120412; x=1779725212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7qIz31yrxS9W/8Z/8yM7blQBiQ6xv2671X73kGvx6JQ=;
        b=FegEoK1KxvcNjpHqgM60yFuGeT15h5fDNj1oAbWF8lQ7PST9zXxFWnNUsxOcwdegqG
         uNQXGO2L7JZT2bTtB0G3lfoJJSkwubQPeKZb+92RfN0GpqtdiE4GZ0xrS6SRBrOA7JAW
         OsV9ar1220DxReYZAKziLKWtf3DUST30WWLBtrxa0cF7P2tim3e52kDeM1NPB6tCaN0U
         5bwAtA6wMD6drJudn8c4RTrT0IZVbsLwVQvFVQilbx7aytpLb5VDHmhwHTsE8FTnRGCg
         YVIqdA3e+AIey9hLghlULO+5LDfe/HaeBqO9nyw7vlPazfxEob1uLGgbUeuIEt3QomeO
         QNLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AVN1gATzR8CqiFsfuytx7LiSxW+Pnncufh+sf+HalK0qfsrR9D18YN5S04BorRRMOspGTPOV6A5Syww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMj/ppcsvIxZCV41VAhOgSQWA2QieFauyeJyo7xXIfG93lpSpi
	eTNd4Nu4QqMfpdScYyM5VrdBzcy9rwl+0kffaoQNDVx+qEIJA30gGfy2T6fEqQ66yOHOinYIEob
	K2KOV
X-Gm-Gg: Acq92OEXnWj+38+aKpXarVsUY+vqE2V+IzsBt3qDbGXj/bNPKUA4NQjnu6i0PwpqTkP
	9iG+p23ulpZ8tuwxuGGjDkX6Ln6MPrzq4PKnIZWvSsmNakXelHbbojeo8R+znZIt8QxsIQcVe5X
	oMQshNI7zo+ykx0bcz6jOdXBvjdK3g+qlRKUKMnPoZsI49YbpDLzOXNXb+yzzLG4WrPvcEE28f9
	NeX+21MqZfWMMcu+2sPSpmLFmC48BenZlhZOkWMPb3hH8XJbZD3pb/Jvt0M983XATISYfj6K/I9
	/Epi7dwSi2VclDSVct5st2wFFISkTBmhZsSM61rjyUEbc9AKd6rgvjsJEIgojRd8yuBRmr7cR9n
	BOB3Ig/59stb3cjSnbjQoFxHtpfFUMttdo6sa5GCvXttUhVQupWnhNAsIrvKJcAUQdrF7IUcifZ
	/hmqF69FLVv+UFcTPQWULLnhhUluKM0cz4f56UmWJsrE3Hz6GBjEk=
X-Received: by 2002:a05:600c:3b21:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-48fe6514dd6mr230750925e9.24.1779120412382;
        Mon, 18 May 2026 09:06:52 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:52 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:30 +0100
Subject: [PATCH 11/11] HID: wacom: use 'hid_device_id::driver_data_ptr'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-11-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=3202;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=egSOONxdnqBhFwUZnKXnaBT3uMNM2lXVFquENOo2ChA=;
 b=dVhk87EFjnY6yHm068sDeHPuQYnPBbIgzk0uO5cKAKvTGUKV5ahCHhqpu0SV03NAC42o5kQ+l
 YAPXE+NtFIqCqjs94Eg4Q4Vo6Xqyljwu+vUjPJqB5d3t1NbG25ucraI
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Remove the casts to (kernel_ulong_t) and (struct wacom_features *)
and use the 'drvier_data_ptr' field instead to improve readability
of the code.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/wacom_sys.c | 14 +++++++++-----
 drivers/hid/wacom_wac.c | 10 +++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0d1c6d90fe21..25408676c5f6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2555,8 +2555,9 @@ static void wacom_wireless_work(struct work_struct *work)
 		}
 
 		/* Stylus interface */
-		wacom_wac1->features =
-			*((struct wacom_features *)id->driver_data);
+		const struct wacom_features *features = id->driver_data_ptr;
+
+		wacom_wac1->features = *features;
 
 		wacom_wac1->pid = wacom_wac->pid;
 		hid_hw_stop(hdev1);
@@ -2568,8 +2569,7 @@ static void wacom_wireless_work(struct work_struct *work)
 		if (wacom_wac1->features.touch_max ||
 		    (wacom_wac1->features.type >= INTUOSHT &&
 		    wacom_wac1->features.type <= BAMBOO_PT)) {
-			wacom_wac2->features =
-				*((struct wacom_features *)id->driver_data);
+			wacom_wac2->features = *features;
 			wacom_wac2->pid = wacom_wac->pid;
 			hid_hw_stop(hdev2);
 			error = wacom_parse_and_register(wacom2, true);
@@ -2839,7 +2839,11 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom->hdev = hdev;
 
 	wacom_wac = &wacom->wacom_wac;
-	wacom_wac->features = *((struct wacom_features *)id->driver_data);
+
+	const struct wacom_features *id_features = id->driver_data_ptr;
+
+	wacom_wac->features = *id_features;
+
 	features = &wacom_wac->features;
 
 	if (features->check_for_hid_type && features->hid_type != hdev->type)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625..034bde5af2df 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4947,23 +4947,23 @@ static const struct wacom_features wacom_features_0x94 =
 
 #define USB_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_USB, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data_ptr = &wacom_features_##prod
 
 #define BT_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data_ptr = &wacom_features_##prod
 
 #define I2C_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_I2C, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data_ptr = &wacom_features_##prod
 
 #define PCI_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_PCI, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data_ptr = &wacom_features_##prod
 
 #define USB_DEVICE_LENOVO(prod)					\
 	HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, prod),			\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data_ptr = &wacom_features_##prod
 
 const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x00) },

-- 
2.43.0

