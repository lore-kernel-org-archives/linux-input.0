Received: from mail-ej2-f33.google.com (mail-ej2-f33.google.com [74.125.228.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033055D869
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083086; cv=none; b=PySI63kmpXW48n3o4KGVqht7iDF3jgRycVvVgm2+7K22I2LITKHedVlYY1h2k2G8MSsh4sJ6lCSyKsDIKMIUoMVXi+xHPkyS6LV2SuONtT7jQskRu2L3Q0WNUxS8Pkmlk5csU7LxZgJzyQZVkyiGQlR560a1zqHTPsi4usHqxvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083086; c=relaxed/simple;
	bh=K7BtVzN6po+S2COgmRkxMGzzT7rvJc80uqYEHixK68E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RdshfZ+NaMDP0r9l0CscA4+CkKjtGQLahg0BTkZQf42P3qjRHamHyGSuCmv3zJfIHwUO+fWM03m6jmJIeBRC1tpg92ge/5I/f3qE4BJBPFpzdsot+5IUBx6/anChpxGN3Uo0L5Kz288qjpynrl5ggTnJZo7eDqRe1ORVXeul7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyS6eb+1; arc=none smtp.client-ip=74.125.228.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyS6eb+1"
Received: by mail-ej2-f33.google.com with SMTP id a640c23a62f3a-c2507a0a24bso38006766b.1
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790083082; x=1790687882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Zjh9iTNK9ak9O81z1axMf4LnrFq9Uu6eTXFdZwaGIg=;
        b=gyS6eb+1LcYhkoFQeLA/NQFXX2bv2qzEXDBgi/6cfyNanOe0RNdLAOacCvfl0kgdzK
         CM16jTebOUV+y+VjFWdNUmp6kak2kYuSh6oo69LyzOiJtN026zdM7CjSdavjbwvxfgID
         f26Nc7Ih2PsmItpffGvxZ+4hhbvtC+eqSXG/ejnkBLhjb7HrEO913seqrIglaROJiFKD
         s6uvbkp/U2yzZmkugfnRJwhRg4ylabovz+K+wuV9ZxU2VyiF37rEq5G9FAVqWgDlmOz5
         JOxz3HGLbnnznz1+Zcmx7bplM7run+HhPNUbv2zQ/RY4yNqreIotq822yOqUKIiSZph1
         kNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083082; x=1790687882;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Zjh9iTNK9ak9O81z1axMf4LnrFq9Uu6eTXFdZwaGIg=;
        b=ugKm5YafHW0reCblsJ9+J3FLXBnyRm9OTB7T1Qay+VrYi1Mq9ZzNSj+EcpqNwJwaBk
         hmSSLyGQeREB2x6l8EoQihwivyYeT597zH7lPF1ojKsqfHZHZ6ubQgbRq/AfvPNI93hZ
         C/0Ng8Xvo//TTmAhk4wYTO060cQtNxoZZUVZiftRc1+hMWcLAQT9XhkMzHhQFQujNarP
         5C1hrmZUwK4weUgzrDmnWiZV/o5GXgdkK/98IxlTjkhUT0dkrN+SZmJny5m6wT4yLGNm
         1YXitmx1voiegaJJsj0HsTtwg1ycowIlSRCeVDggeoH5LTj5zkLSDezkzfNhwtHEYeSE
         H2fQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5iFTqywWTKKt7RbNVERvoZ/8H+RLGbCEZrVFHL6I0Sye0rOsw22g4FWap0UidWfLOxNsfFstuID30Fg==@vger.kernel.org
X-Gm-Message-State: AFuF++lKweilZ/FGiAoj2zo6D0cKfln6k9tvugtDcuRsonXXbUAlXiCA
	+5U6R5qYdsAjSSebbRc5s0oX1pU09wFbwxiToRFYu6XeW3dAPiK/8iP4
X-Gm-Gg: AYBFou110qLWGGCPUobFl2MUliPH11K/moeV5bqiz4RMirGOUcPNR1uxC8pJujho5k8
	Ydr2h+q9ZtySFoy0Sdp/C1NIV0dmESwG2br7fCcdX3KGMmMFwU+mk5wtcQ23gjH1VlFbX/xjWNq
	XRBaodmIf9NndcHYS6Xmd7wqXj54VJmaGRlmdgBK1vv0Ekgei5VR71KbeUHg1H+8uqSTlZuAjjP
	Ptm0u47yNMv+Ws5Lxhua79IVTPN0KFUUjPQJpz4fEUzTh4qBnblnZHZ+baHa5h6lRT9Nq9KLbKP
	Uoxqx0JYoJiRgnSSR6sVjHZCng5FeiKO0MrDu7uSG6m5GhyB3QerWEDo7aUoEuQhlv24ne38yLo
	QuBBtM7hDNGicA4yJ/V6KJ+GINDmYZHhRWffdAuxaxRrtfNrO8lZEh9GeYA9DpfWTiq7p7FWyf0
	Z4vF27IGTlPld2gcn4z+R3gulx1iRWZczwUyKPzyJHeYnm3yY7Q9c5ewcyXvQP65dXaf8eYkbNr
	Bv0ZEujO8vAKaHzw/g+532FzUou6yHRmo0ZBEtbmdwZl1tYJDGK9Q==
X-Received: by 2002:a17:907:970c:b0:c29:4634:5c8f with SMTP id a640c23a62f3a-c2a1a450003mr1298250866b.0.1790083082411;
        Tue, 22 Sep 2026 06:18:02 -0700 (PDT)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c62d4b4sm83416066b.57.2026.09.22.06.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:18:02 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH] HID: universal-pidff: Add support for Turtle Beach VelocityOne Race
Date: Tue, 22 Sep 2026 15:17:58 +0200
Message-ID: <20260922131758.1242755-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add usb VID and device PID to hid-ids.h

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/hid/hid-ids.h             | 3 +++
 drivers/hid/hid-universal-pidff.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b3aca5aa9176..52b25d76cc2a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1504,6 +1504,9 @@
 #define USB_DEVICE_ID_ASUS_MD_5110	0x5110
 #define USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART	0x7100
 
+#define USB_VENDOR_ID_TURTLE_BEACH	0x10f5
+#define USB_DEVICE_ID_TB_VELOCITYONE_RACE	0x7077
+
 #define USB_VENDOR_ID_TWINHAN		0x6253
 #define USB_DEVICE_ID_TWINHAN_IR_REMOTE	0x0100
 
diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universal-pidff.c
index 60180467a0bf..f1854cfe42d0 100644
--- a/drivers/hid/hid-universal-pidff.c
+++ b/drivers/hid/hid-universal-pidff.c
@@ -187,6 +187,7 @@ static const struct hid_device_id universal_pidff_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_FORTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_LA_PRIMA) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASETEK, USB_DEVICE_ID_ASETEK_TONY_KANAAN) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TURTLE_BEACH, USB_DEVICE_ID_TB_VELOCITYONE_RACE)},
 	{}
 };
 MODULE_DEVICE_TABLE(hid, universal_pidff_devices);
-- 
2.55.0

