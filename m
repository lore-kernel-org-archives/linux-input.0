Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9255396B61
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241499; cv=none; b=WIFkUqeFMhOKFhn1J5r9RHM/lWY2oKocOIPFUMeIeYqCJeQ8GCSnLzlxWNHH3vDBW/tu5JsYnQL+cSfMMK5HDvBnoe2VKH88ObM09tsqj72AY0jqF305wzqSvE87NdTh/DNs7hjHKuqCBiQUpf+ZjuFDwtzbapkmM4ZNKgG05GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241499; c=relaxed/simple;
	bh=3Dz1vnnDfCC5xjG/JwffkR96Prb0LwO5Hv1srPsistI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZ7+g87rT+XkSiUu+C7VlhytvCDMfiGUEDyYqhh9QMUzUa+Q1cGiPwBlmyXhIfowrOFZ9R/CeC+gZ+GDcWx0C//bK0QAUcUnQbi3otJQBGWYDVLpaqtocrZBdmTcC5AKT1x57q4SS5N+Du/UocfmeKb1j0jEvQfvszCPxQ/Jk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOP4nFVX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOP4nFVX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658ce852fbaso41624a12.2
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2026 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241497; x=1770846297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uk8I4gK12p2whVBkLvAYAwLETubRrF0Kti+U7YhSaa0=;
        b=XOP4nFVXIC14bg7Mqr9W+nT0gV5IlxInCtip3Xkr6zEvHum3TnyoT+ZJHPmxh5QHNV
         ImutymEPWA0PiNsgHWBe/Yw0Qv2xUAcGK8LpLoWwXfVX3Vbxbe7mbi/f7UYpvm4y9JLS
         1sC1OSw5WCBkY0/MhFkXnVWRAVTHqFE/UMy9z970rpSJjsUJ3AHzCxanr2lUkglSj5Pp
         yeFtl2gqkh1Sw/MnuWVKc6ff2cbn5Nu5YyRs5xRZz7eeloLc6YaUQ+HaalFHaqjJHbrK
         0d5UGzsHMSL6TzPPw/VYnzT45m9InPbxPkwOh1Y/rS+bMkqxTMW/uMK3647q7af3yJ+n
         eyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241497; x=1770846297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk8I4gK12p2whVBkLvAYAwLETubRrF0Kti+U7YhSaa0=;
        b=Adqtm7xU8zOOcgnVutxFuAhT0lXZGwef8A+vNJxDDwZVtjM5eGl5jxVutrvmJiK/eh
         tseiTzzpENDGV8jnPxt9/zsTTL6VAwLHJ7BXg2z/xRSJJaqpZcM0uBUxxAxeA1Zo30XB
         HcR3Gv/S/ixdAv+RsV8ts7IDqnc/hbQ5UW8UH+d7UIb8pnHmlVGyJKjpI8cMrI6BBqth
         M12PVe7oPRILHTsyWqCGSkDZHBSq49FTPAaJBVpovil7l7Xdfy6AxRtMWzyxy/ve7t6+
         FUAMKi8T4H4dwJgK7bRNNqv5MkI+EKEWUlFtyL98/SMeF7iFeYJgJ2RHuTDxQrBCeHOy
         e2FA==
X-Forwarded-Encrypted: i=1; AJvYcCWUmfe5GjNFWXIpRh+OEpGORATIktd2lui6yOtR51nGvV/adBOR6tKHKCC4SbH2/jzwHylXe19ST+3/Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gAv0IceklRhS1FSPDAUCG1sZeYqwjmE62sD09ZDy6FZUIxHE
	OpYCkzKgBpIKCpBj4fgPeBqFV8Tq+B86VG5g7Wrh5L8jh5clyLQ6Ee1OLLoA9Q==
X-Gm-Gg: AZuq6aLEEugGgK26gizUmd5GV8qWU+E70gr6yFepkF7hW5zvTd8QEu4EykQn42KzJWq
	UpkJc5gIdkuGNadY8rCviUxBMBI/fJsvDASJFbl5eV9Lh1aHUrRt28x+SEVHiaP+WebOxgPWeX8
	vIcRtyfclBywiCIwtZ6a2CLPo9a5Ty+TX7Ku8opmEMj98YbY/gdG9HYXnws2/IPHcn8tSptjGNr
	iym4vx1/s13wNDe9iSTzj+bKylF8QCXiOvvu70RDNf1z07DTwWCb5QlD5lwi/pL0ddjeZlj02/i
	P5ANsl+bTUP//i67i9L0TppEWxXdbtbSnqcdmCKkI44jBg1iBIBk5mfm/KAWUsx7qysKXmw61cz
	ZQHqchuPyx9Q7pTf1KsE2PXbFCeX64ICgteFJPJOZnG3yRIfVj9Rnopahqm0wgkv0U7NFL1OSJp
	jpREAFbpmlseRypifJqNBc8S1LMAOKPjqTho2hHzeo08vfAru3rx1rpuvWpXz2p1Hp
X-Received: by 2002:a05:6402:50cf:b0:64c:9e19:983c with SMTP id 4fb4d7f45d1cf-659499b66c5mr1494417a12.2.1770241496789;
        Wed, 04 Feb 2026 13:44:56 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65949ed6d2esm1585953a12.10.2026.02.04.13.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:44:56 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH v3] HID: pidff: Fix condition effect bit clearing
Date: Wed,  4 Feb 2026 22:44:55 +0100
Message-ID: <20260204214455.68629-1-tomasz.pakula.oficjalny@gmail.com>
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

Fixes: 7f3d7bc0df4b ("HID: pidff: Better quirk assigment when searching for fields")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
Urgent for 6.19 rc period
V1 -> V2: Simplify by using bitwise or operator
V2 -> V3: Going back to separate bool variable. Turns out I couldn't use
bitwise or operator there. Sorry
          
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

