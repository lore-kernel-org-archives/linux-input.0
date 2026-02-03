Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11330DEDC
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140569; cv=none; b=RH+XirklDhdPoL6pheLfzYNpWt+5PdjsYWrHkPS9azIEBkDFIL1OHwURfXUyIDyU4T8+MwfFpMJ3PePXEbJObe6CPn+/S0nsi83JSCnXUnNfY66+IM/KpdhJakmZVy+euIjw39/6W9cYwQKJ1G3I97I1lpTXbNkzgWBcphSezNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140569; c=relaxed/simple;
	bh=XsYfAuikLlaOfTmt/l8n20FoLsRWn3fKrE6HabUSTLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H9/TSEF/qkZVfqoIKugC1gp346IyST20hl9mcTR4XJZQR0Csf6PqLs3xjPHvhz5/YuY7fJai2ElqS9ZlNsDV4iJvAHPn0tLC7jQZ5+C4Ge/RwTTZvaBTGQNPegeb/cWRFkfu+BuWEOjP0Ngud6fC1WDxHq3Pr6wDEvXrLjGRXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxd3bWfL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxd3bWfL"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b876b5c69baso69376966b.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140566; x=1770745366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJlB42/KFIlk7GeivHJ/GHOk3Bxvmmpk4HJ11cBcz4Q=;
        b=Jxd3bWfL0aaMhuL9v5xFUYg0a/wwRdauhiRvU3o96AJQT691nxBstIjKHfxzOgwExV
         cDH8WhKPg4RpABk3HnkwtOisD1bfOVDyYomqw8IKEIvC7QtuMSdaovMTmbcP8FQ7zSEq
         bqeGH57kpAAZlmvuT2P++t2dV+81Q5Rr00vFzBVqFqEXM1OFInLMSCZnjdBqC48n+N7P
         z0k987lQZK3JgdFP+KAKvTQJkCLrNfDfUwrJ0x7vXvhd1doP6wsdT9ePtIrxVYaZEWUU
         ydtYzxFp2Ora3XewaF4c5JDDdQy5rXhMtmde6jKP29xFucQqM/4Pyz4GnzP9sGVI9JGW
         un6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140566; x=1770745366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJlB42/KFIlk7GeivHJ/GHOk3Bxvmmpk4HJ11cBcz4Q=;
        b=IkrmKGVp/VWBqHTa2WtnvEKxkQLkQtQIPB0BIqt7Iz5at6J/POVfnPQFijUFbUcRfM
         iJ5c9XUnA6MQ0Dh1Odo7S4kwASbQgTNgJ5sgmW453xGsl4eA/OQOBKhY9xtFhVklhFp7
         GRp0mDeV+I/55liQATTPr/2bsK4kK5LVShTqd1fZIovwDhk9InBrUmJQXfPzbQe77YLC
         zzjSj1l7IRLKaX1aorKEwq1Q7KSLHqdB3snu27RhPjaU38G7ctUUb5A1zF9JreFb+BWd
         zgA+nwp1HFggEg0uRUgchlGvM3kQLs5fa+LwnuhX6XkJX9Wgzy96M0Dxd3xHxqbeDJoO
         ga+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI/g2Ny6izAbNiyoawMbk6zBPlgh4mHaCY9ZrR7lPvJjLXY7PvLDrEWb1lSvGARZYo/d8enw177D+LJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKaW6ZnK9r8kfdK0a6eLKqMXjSpKx2DrBhopC/NJ7Vpc8kvUI
	B3SDw+n2q6CkD9ayGPyi6gf81E2tuxoww+5Ivrkp48hRz7N/ND61V93g
X-Gm-Gg: AZuq6aKp2kFueCT7auV4mejSaofnR2JWKRIZnrLHN5Hfz7fFE2aSuVCDQ3UewiAZ3YQ
	7QmUjtvxSW450QEQDhOn007/ZTwWoJ3GaB5ZbKG/Mx4zzcKMMM3Mj71kIEPjasyzOwNEqBsSql/
	pKQfhrwml/KUPvgG62L4XS+hpUlqqbZxW+7D4JxxQgHKJg2M+iSVzzDCZSbU8IEZ7+9v5E/+i3C
	TTJCxiI3GKb8JP5EEmZZBdKuiuXsADrUGU9Lz7FOLkHDdHk8wolmSWOV0P3NKFf4q94x1yOg1Gb
	VNNlPAT4bKIj7ZZpB5HI4oO0meee8+R/Pw+iyDzYhWnxli5TnxImzH5GE0B4VI1CZVSe7IMSooq
	cPSeCfRia1PZs1a/LVihKsb1IBy+J24dydYiZ1vJJcUWWbbJqhBVH71wDSFe35+QQ5OzOOV48FM
	8DCNGQGRe2GNiLiYGl/Pe9NuJ0X1oK/5Yknp2laCXrcBZgpNWQmp+s1K2I320n3Jqs
X-Received: by 2002:a05:6402:13ce:b0:659:3f9d:757b with SMTP id 4fb4d7f45d1cf-659499b8e05mr174881a12.2.1770140565884;
        Tue, 03 Feb 2026 09:42:45 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6594a2168b3sm163968a12.20.2026.02.03.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:42:45 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	sashal@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH] HID: pidff: Fix condition effect bit clearing
Date: Tue,  3 Feb 2026 18:42:41 +0100
Message-ID: <20260203174241.2863219-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As reported by MPDarkGuy on discord, NULL pointer dereferences were
happening because not all the conditional effects bits were cleared.

Properly clear all conditional effect bits from ffbit

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---

Urgent for 6.19 rc period and backports for 6.18

 drivers/hid/usbhid/hid-pidff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index a4e700b40ba9..56d6af39ba81 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1452,10 +1452,13 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 		hid_warn(pidff->hid, "unknown ramp effect layout\n");
 
 	if (PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1)) {
-		if (test_and_clear_bit(FF_SPRING, dev->ffbit)   ||
-		    test_and_clear_bit(FF_DAMPER, dev->ffbit)   ||
-		    test_and_clear_bit(FF_FRICTION, dev->ffbit) ||
-		    test_and_clear_bit(FF_INERTIA, dev->ffbit))
+		bool test = false;
+
+		test |= test_and_clear_bit(FF_SPRING, dev->ffbit);
+		test |= test_and_clear_bit(FF_DAMPER, dev->ffbit);
+		test |= test_and_clear_bit(FF_FRICTION, dev->ffbit);
+		test |= test_and_clear_bit(FF_INERTIA, dev->ffbit);
+		if (test)
 			hid_warn(pidff->hid, "unknown condition effect layout\n");
 	}
 
-- 
2.52.0

