Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1037FF70
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066094; cv=none; b=h1I7GLoluoX/LZqh/A0qbRUyY118UMgimd5M5UR7SK6RI7hh4FMw5+nbULSuDM7R8TS3/QLfHcC0b9WA/GxDFbzqT9vL7pzz6l7m6Y0NDzH5N4Mp7w05LePF26QkaRrH5UhdAXkzeGX+e4Wyslw0ugiXI2utPIO1YPOIX1nl/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066094; c=relaxed/simple;
	bh=axV0Xe/l0zqKu4dH1Id8zerBM+MGpmGJDJcGlyeEvtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMyb067CDAxWnnyVQsOMFkY7vVOiak25p+lX0R+D3Mf5U417zyCXJOSv6R6lnsdZgWpM7+h24qwWgmsWP2HoNmu8UB//U0/vuw7t98LsrMjbLfdH2XwMWkepPrjtD776omNImCjLwo3tSM6roscK2w/cktEfICL5XwQGubSYJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDYBV3vu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDYBV3vu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b966dd74so32227715e9.3
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787066082; x=1787670882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzohCHfuB1luQeAMOC/pqUEUdm2PKR4ZBwb8q7ZkmM4=;
        b=iDYBV3vuDHy8Ao4KsY2+F8AZX/nG+09r1Z/cCzEWN7Viidw1xvpZcgHOUQ0KJL22YU
         14zfDJRIi/2Mh8sRbxtQOYNiJ3b9NUzB6wNmxhGf0ZjFMpoD+LWthL8tQK0Imj8oKfqr
         efbabG5cSwfKviC9Irng7kwP3HTvsoJHFXQCyjQ72aEXyeciSKRzun3qPxMKmFkkFttv
         5X0DqvwWlAHAvisewiNq/3hsKjJbI+3B2woOU9aU/CwWT9KG3n9YcbJUXQB5DdpDO5BE
         lAxekUpYQDES1q/snzFhb/5ku3uoVmJuW8ImCuk2RNui2u4ABt+uPL/04vcIZQFXYsP2
         NVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066082; x=1787670882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzohCHfuB1luQeAMOC/pqUEUdm2PKR4ZBwb8q7ZkmM4=;
        b=M3MalBbzbmTMD3H8gjT2QiW81VnvsbrAw0D8GjXgZUITT2y+eJ5aXkzyIznsP9KRAT
         vLTf9zRIxYdq7BCHkaJ7PILQB1mD/iSSpzXMVDokJZnM/V4QlIntk+gF1hTuuBj1Emzx
         ZGmBT6KW1fT9nWwq5l2NEczbtewA/wBtZ68mW+DuLb73v0Up+ysoNXPykeu3z4ERueoA
         byH731lkPxaJ94BwDS0Q9A8aJEla/2mvYKNogkp9wU6ezQitI8YlqXdwjow27qxkhXcS
         SLF32JCdv4s/IbQ76grvhTXbC6ff5CywmkyHDmPAvtJq/ZoVuyUc+qLYDgB7jyairyYd
         h9HA==
X-Forwarded-Encrypted: i=1; AHgh+RqQIh4fXQXyfQMiejnO3oJVkWqveJibnjXAtNzHbsrDHF1TX6mxlOKpEhb9XSclr/a3Tu1QrkCZW/nRtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91QTBJZtGqIL9OJ02K6XOW4/+e1gRHo7X6t0kkrPQAwTv7oV8
	xC7oPuXLAQJ3rpqoRqBBn8zUORfa+0punLZusUs2QQSOeq1rmMV3hoa0
X-Gm-Gg: AR+sD12S6Ym2Wb9jVBejkBgE31LObfa7S7Iw3IFAv4bLWaCLKoFMfKyeLuNxTKEUtSi
	IRxONXHGmnVUoImKxGB1fFAvFD9BA8H0lxIic0SkS3tJStFr+A2ZJ6dyojGK1V5rj5kHyaE0f14
	0iBamwNeaumOSte+mrq4hrQ8GLYoo+bzNWTUF4n7Y0NPLg7NHpD9lX2bo6IH2ob0nJL5oygzaHx
	uv/XywJp++TzheUmwwwJkFoLIEQLjPIOwgLsRUlkv2TxXN2RwhdPO1NaYUMo5b5RFlqYqh0WFmX
	CDLWEpu6isrwSG9qRy/oqAmOUeH1s+CEMRDgStjaOcCiSlDYNuO0N8r5D5w93ih4qyC+6zbWAG3
	bLKi6jReK0NXz9MQoH4EkB6YlcUun+DW+rlP49v2CqYLphh54FfCjhDuJZWQOWb3ruQiG1/8keL
	pJ65CsbIrTLQ1OT90hpnMagcGrbwRyKuJOwMxDPuUfLKiKjgKJUXxSsySPML9FPygweTTcg5VpJ
	Bs9BV9SDifTKUYezfHzUWf9rFngDA==
X-Received: by 2002:a05:600c:19ca:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499879426e9mr450375235e9.8.1787066081793;
        Tue, 18 Aug 2026 08:14:41 -0700 (PDT)
Received: from HomeOffice (046125138157.public.t-mobile.at. [46.125.138.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm13657469f8f.32.2026.08.18.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:14:41 -0700 (PDT)
From: Panz Dev <panz.development@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <denis.benato@linux.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Panz Dev <panz.development@gmail.com>
Subject: [PATCH v2] HID: asus: do not send keyboard init reports to touchpads
Date: Tue, 18 Aug 2026 17:14:31 +0200
Message-ID: <20260818151431.939132-1-panz.development@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0919db9f3583 ("HID: asus: always fully initialize devices") added a
loop during asus_probe() to send keyboard feature report initializations
(asus_kbd_init) to all ASUS HID devices.

On ASUS laptops with I2C/HID touchpads (such as the ASUS E200HA), sending
keyboard feature reports (FEATURE_KBD_REPORT_ID) to touchpad endpoints
sends invalid feature requests to touchpad hardware, corrupting probe
state and causing the touchpad to become unresponsive.

Wrap the asus_report_id_init loop in an `if (!drvdata->tp)` check so
keyboard feature initialization only runs for actual keyboards.

Tested on ASUS E200HA (where touchpad functionality is fully restored)
and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).

Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Cc: stable@vger.kernel.org
Signed-off-by: Panz Dev <panz.development@gmail.com>
---
v2:
 - Keep asus_start_multitouch() inside the HID_CLAIMED_INPUT check to avoid
   any UAF risk if input registration fails (as pointed out by Denis Benato
   and automated review).
 - Focus the fix on skipping keyboard report initialization for touchpads.
---
 drivers/hid/hid-asus.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..7f19ca1e5a1b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1294,12 +1294,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}

-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
+	if (!drvdata->tp) {
+		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+				if (ret < 0)
+					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+						 asus_report_id_init[r], ret);
+			}
 		}
 	}

-- 
2.47.0
