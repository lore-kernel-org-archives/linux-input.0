Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591346;
	b=01WVkszawnfCGIp321LdcMffNUa71ZFnSrGIHdzuXIz2xUi8UgBRWf/NZlL0Zi53edxH
	 wfgko0jRS/tDeATb6bEiRFj/Bfeudhnq7USQxrWJ5cIWVW7ieREuKqNlrehj+UW50S9ZW
	 gMwkOXPO+/AJQYIr3bG4ILaODhVvwBMo2pYiS4Z2Co7WXvf7XGpWnl3Q0JVu9GwVBMiyw
	 kNu4hyCRX3wUItHrOAK83VWKwatgeIv0U36hgpgXF8EUSI9D77MaFxq5JuUxXGinHHedo
	 obctzgMaZl+Z87O0dh/Y0WvPqMhx7D+EpM2f+tdeLiUD9xpoFXHGXjAkeWIhabdSrTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=5GJjIuaHt/D2r/JVDTfdWB1lkG6fDVc7Xt2s1yufKlg=;
	b=3KK0NFE37DVIKSSd7fT44RAAUtd08ZT6Rz8rvfGMEnBYi393yBeQ42ebXCn526YTaQ3g
	 sm/3r15XxHEj2N7a77cVF8q6G+veOaQKVfzjacy2gr0HxdmiPj4x7ml3SbMI9+xGBCux2
	 YiZW7MUQQ724cP68LvMpEORnZghn92u4NoCqCvwW41zyYP2r3RNGS93fM1aeRaZivciuq
	 QxjgoHGR6J2LNXylA1R4ZEVUsQkiQGFCwsFk//qK6PrUO757nssMD/zszebAE3PziSC0e
	 6sPKFHCvKAvhGaUJPHPl2PeYkQX6ncsjYj/t5CNDQFJx9v6Oko0sVovM/eO7ylcLXCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=oQHNGMUx;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECE606A327
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8ECE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=oQHNGMUx
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so47128935e9.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795591344; x=1796196144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5GJjIuaHt/D2r/JVDTfdWB1lkG6fDVc7Xt2s1yufKlg=;
        b=oQHNGMUxb7J0rz1oVQdLEM3PNXOSZ7T5V2z8g39RqOGkMklUi/mpAcgO1/pCNyTuTN
         GUv2l0y4yJ5vFAAUCDJNHWihy/fW8w432s9SCiM8bzMiuPllj1QDKdU2P2ZtI5sgvm90
         SnCFoTwgdFaovvSqYA7Di0ma+x2yTl/0Ekc7NoDRQnGozXh6chcfnwyMTQbXjMCe1AGX
         LrleTCk/xvqeCKiKh2ozTeG497RtOvr5Qw1F7JhW3+s77HqmmW/ytAHQbGX2C6MPuYg8
         I0oZqXW0b7NBGogepi+DjoTrJKPBjCGMisEd+3l1zKT1RcB4fW2pAyXgKI88TbU2Pwo/
         oO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591344; x=1796196144;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5GJjIuaHt/D2r/JVDTfdWB1lkG6fDVc7Xt2s1yufKlg=;
        b=FPhdMka4PaAn8PC7teYMpjUJ+6IaDE/tFecv6JQmKxMlSV10CIofFPiu+Mcg8gyo2i
         KHszZZs40ZRQoBVEBZlSVAKbhXJrB1rVQ/Dw5KSvtuiDJxbWJxqraGIm1oOUZ1tfYf66
         TGEL+bh30zSGiREyZ3O2yc9PBhLr1l478ciZk7/WQhg0Sy83BNk52/mDXB+ObHDYZohB
         2qEmJ2nIUTINZCdqMlY+fMInSxTTmKSNviGSRTQ+aRyJcUei6RexH8dAxCdYdJUial/v
         H2A99z03fQjCRiC/s4Er/2zayYyytuBGCgToS+yzzqjTg3J6PkPp7BpOrj4AFu0A2k0o
         nY9A==
X-Forwarded-Encrypted: i=1; AL+hErEEg4n0u7ycDv+lRe+XCk27bSFoXRrVgVuqH2NXZGIPzG9Nyg5+PXmmAaDsVBH918VSRPtLqUxxzFt9HA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/eaDatjKbF+qoO129KZZTd77Crj3Y0sFScT0Q8oz4v4I7bZvrl
	THX+jcR3BxWEjaW3/93xYEJJK2DkgOMv0jVNhKy4pMEuJRcYORhfIcT/3WwIK/WIlIU=
X-Gm-Gg: AZFdTZeW7jYsmwR4Kl5nY3ubMX5DWQOVPAio1cNa6JA1UdEft8qvzo1URj0EvEmQVuJ
	oReg4/Mrsot3NsJ8GrgoHAvlz/wGKQZSnEu+oz72YcG3BD584IqwoBuFJtI6wq7Q2xUad3oiIZF
	scYLnksts1ekhrLzJsXas6Z+ceXTidXgbFmQSWNXcHu2beQY/HXiAZlq1/X6c6Vw0MZJ+BeN6mg
	+QDOuzjW0NcjQw1bNhHY1/gUiALb44LrNsUuWqnKYG0Ns7+RCer99tO7gQiyCE1Lj7gHDnWrVY3
	r1YiC5+KP/hM5egQozVjjwnj/I2OQFMMYaTVLRKhLYsP5L+8wd9t07s0dImZxeQGGne/iUzyqmN
	SXOXPA4uI1RWhthpXkzyLN8yJEOz7O+Bdn+junhjGHp+dMDz/9Inj5ggUJumMJ/xtqiABXYaapO
	GgdHlpWRpk0eeTvlL5sidFYaMhRofkk0Av07kMfaWO7qv+jgGdU/NqtGYSjYpyfp4YZUF9Uz/ye
	Dm8S7/9y420bTUQeV9uUZwSCvl3jJp8pYv191bBXGGLIKriURi1G8PCxlGU4i/93kjTgUnGgU/z
	rmlo2pHEq0oYcxdc2+OjD7XR7vaeOvDFWhGll1ywjjTsyRhPE+OpJMk=
X-Received: by 2002:a05:600c:4fc1:b0:4bb:53e4:a7cc with SMTP id 5b1f17b1804b1-4bb88820741mr378949045e9.30.1795591344294;
        Tue, 24 Nov 2026 23:22:24 -0800 (PST)
Received: from localhost ([2a02:8071:6e30:8500:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8849247asm502188025e9.7.2026.11.24.23.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:22:23 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Subject: [PATCH v1 8/9] HID: wacom: Benefit from pointer typed driver_data in hid_device_id
Date: Wed, 25 Nov 2026 08:21:40 +0100
Message-ID:  <23d19d751aea2d855bf1360fd4e84cc30d0fc8ca.1795589119.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3256; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=04+Lq9F8U8XiKgZ5haxzdh7WYgFsl3nmCxOnWykLAUk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBrBoyPhXCykB1OsmdnYwJEUK7A4PzwlD2PmBwd6 1t0D6yykaGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCawaMjwAKCRCPgPtYfRL+ ThzvCACumwpeYZrNnwuMn1tkoZ3spyCK1kZtH1sTWeTPEj+d1WBFtD+/eI5AjDHhBh5ehC+Oe0C 94nmXR0FV1ZfBTIGbbD1ok1sb7HxaBulgKi+rxWn1Z8OLrsNF/v8+Rw286oOIxxCY7PpcOEb29D G7orUwz6mCi1LXNzlsqX2yugsVXW+MidzMYQI3xB03rE+4Lb9VNEEovAEzoDqcbrLHrhWRt5l67 oefDIBilHTOO/A5z+oDAg6x+hTFmF52ZRkEMhVnQlJQVK4Ll4h56KPzhgH9ga6+kayq3lEZ6O5h 43bxz/UBkDtEXxQI1FE2+xJ2EqhJt1kjoilzaQG1bXcQN41p
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With using .driver_data_ptr instead of .driver_data several explicit
casts can be dropped. Do that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/hid/wacom_sys.c |  8 ++++----
 drivers/hid/wacom_wac.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2e3ce9b63d7a..d826a6b4d41e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2657,7 +2657,7 @@ static void wacom_wireless_work(struct work_struct *work)
 
 		/* Stylus interface */
 		wacom_wac1->features =
-			*((struct wacom_features *)id->driver_data);
+			*(const struct wacom_features *)id->driver_data_ptr;
 
 		wacom_wac1->pid = wacom_wac->pid;
 		hid_hw_stop(hdev1);
@@ -2670,7 +2670,7 @@ static void wacom_wireless_work(struct work_struct *work)
 		    (wacom_wac1->features.type >= INTUOSHT &&
 		    wacom_wac1->features.type <= BAMBOO_PT)) {
 			wacom_wac2->features =
-				*((struct wacom_features *)id->driver_data);
+				*(const struct wacom_features *)id->driver_data;
 			wacom_wac2->pid = wacom_wac->pid;
 			hid_hw_stop(hdev2);
 			error = wacom_parse_and_register(wacom2, true);
@@ -2927,7 +2927,7 @@ static int wacom_probe(struct hid_device *hdev,
 	struct wacom_features *features;
 	int error;
 
-	if (!id->driver_data)
+	if (!id->driver_data_ptr)
 		return -EINVAL;
 
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
@@ -2943,7 +2943,7 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom->hdev = hdev;
 
 	wacom_wac = &wacom->wacom_wac;
-	wacom_wac->features = *((struct wacom_features *)id->driver_data);
+	wacom_wac->features = *(const struct wacom_features *)id->driver_data_ptr;
 	features = &wacom_wac->features;
 
 	if (features->check_for_hid_type && features->hid_type != hdev->type)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index ab89a11d6740..2b2dbe5f06fe 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -5014,23 +5014,23 @@ static const struct wacom_features wacom_features_0x94 =
 
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
2.47.3

