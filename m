Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DA37B01F
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328302; cv=none; b=dNSXPSSf2uPDmtDg5AaN8625dHdozt9BGEAEVtDmVPg4sfpUQIlBZHJEjjqKwhGAlyTvCutDBW7GuxUgwqYy+SClquVEJHdON1N18Bfssw+dqgAZRDVnmZmqy8Gv9TRQq993RiP9vlMRlnK5Z1BETKeBE5AQke+NcJMfyL3g83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328302; c=relaxed/simple;
	bh=rsyuw981n4NVhsIaBTUsHYg+kOmfbqnfnOOq108N0y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1UpWxOs1xDOoCafO3HT7CHItkz0DA2E2QPaQCDjSEFfIEl7+3qhbZPENh14wVy8qyT+wbPdL0xyfCIZi7vLyOS6Ef8iFsH2O1ytNQMl8vz6K4HoqppcIOkaN0ja6ehVeD/picOadnP1cYXoPu4vMhBvYTk1rwKW+GLhEU9Seug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg2tGkdn; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg2tGkdn"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso503057eec.1
        for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 02:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790328298; x=1790933098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2Xgw42/7p7dsnyTvA1Jhb5iy5oJXJ+/JZaVZl7VGKg=;
        b=Wg2tGkdn9RVFIkNyo0uNbmXlKH3UVq9/GnB1Mm3+tKWdIqF55dZR5N/nOzRRu8RH4w
         deUDuaztTm1WWcVnggP8OWLquX/FwbFLR01a8MTsdVZRXZTHffYfYiDCYBrcoClq4rZ1
         QbQ78XpL1NzrJJFGtTjR7z+wpx5t056QRfpPDoborOP3mjbLQcRMJ9Wr7nWK+m2Xpb3S
         c0/TzFZ5G0Es8PjhH+mCWP+/Q29iviRyWK8L/hi4o09Pv7fvgjlZNlA+7UwkaxNrytUW
         v6dsuoUxNbeN1plfKZZ1X+QH/4HvwvUYdL5OR3cftUQraKRJD9ovtlyjzLbyi1W1J42F
         uliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328298; x=1790933098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2Xgw42/7p7dsnyTvA1Jhb5iy5oJXJ+/JZaVZl7VGKg=;
        b=nS7t50j35XzRLLgHEZGq3Mz2d9kj06puHy2ICq2M9mFc2esJ44z3uOjRr204QSMX0/
         YNaLNJYadC9OVmZ7oLLkVOypsgbtpXuuub/F5MTUYa+jfBHV2cNYtAV/546f9gEtows3
         XLvDMJg9AOZueiD898BUNBIhy0SFAB5p5vFob6JrrbeX5NCB4OCtGxhCqe1DAIXCdzz1
         WYLg0jHRFFNs9kRylquvR4oXHGtCbKJ2s21jZBOkxS0MGQM84mcmNwgYdo745z7gqEcx
         MedM7iKMAONCS52Es68S4fq+LNbz/sPSZ97wiiaUEUcmOfpOfK5puCa3Yi63eQ9Mq252
         RDUQ==
X-Gm-Message-State: AFuF++n3ASFEUfPEKAj7VT5cGHfTNQrcLExlmYH0Tei1/wGYpk7fEenw
	O52qR7lU/Pkh1AjWrQ8SD4lQ3wUoVb54jvq2hFLmboQ1IdUCm8u73R43
X-Gm-Gg: AYBFou10MZhc7eohEeBUzLt6Wow9djQ3X0wqZaqmJYyc6nLkOL+TIkvj/nSKmqfk3/D
	l5jOeBmCH8jMUFdqN2h7bof4q7Aq13ofL4OOO33Ltv3XVGjlmXd1vWRp0QWPF4WU5Vhm9Hq2xKg
	sYrxxNs86wMQ963d+l6FrOE/F8V1Wq3kLNqkjJnIqQpJ0/QoUQ80rr/bQt/PZD5sB32Zh0Wv9Mk
	Ru+TIMZHDxFPoYQzdWUpeFlhnSibEk4RDYxjH/+z6S5n2RC//NwknAmHbqQqSI+24mKlju0DT+0
	6FZuY6A7o5ITULbxUEJq4PeRb2jpW1OCGfyZ3nqREmdiE7asaPKr+pM7OSmawIy9cKPIk7kEdWc
	sfiHz2LBL6ca9DHrEXBQ2On3EkYImdp6lNrczi1iZOiEve3+O7yImGtuUst0ewcVYuH/C2hM5Yb
	c3p+BqM94vl/QTcmo/WlVPyqhIav2M77GYDc60WBsOsSzUgo637PwplMxRqdXDKxkRWEjlQT4ci
	mI1sfCIocGTZcDTKdGcy1YQHSk=
X-Received: by 2002:a05:693c:6082:b0:33c:19bc:d8d2 with SMTP id 5a478bee46e88-340039b5202mr6094857eec.31.1790328297715;
        Fri, 25 Sep 2026 02:24:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:8004:98ea:c60f:8ff:fe17:57ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145727589sm5035806eec.23.2026.09.25.02.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:24:57 -0700 (PDT)
From: Bihaan Sen <stevewholikesthings@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bihaan Sen <stevewholikesthings@gmail.com>
Subject: [PATCH] Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox
Date: Fri, 25 Sep 2026 14:54:34 +0530
Message-ID: <20260925092439.79904-1-stevewholikesthings@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 8BitDo Pro 2 Wired Controller for Xbox is already matched by the
vendor-wide XPAD_XBOXONE_VENDOR(0x2dc8) entry, but a later hardware
revision reports product ID 0x201e, which has no entry in the
xpad_device table. The device therefore binds and functions but is
exposed to userspace as "Generic X-Box pad".

Add the VID/PID pair so the controller is named correctly.

Signed-off-by: Bihaan Sen <stevewholikesthings@gmail.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..e7af88bfb8da 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -371,6 +371,7 @@ static const struct xpad_device {
 	{ 0x294b, 0x3404, "Snakebyte GAMEPAD RGB X", 0, XTYPE_XBOXONE },
 	{ 0x2993, 0x2001, "TECNO Pocket Go", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x2000, "8BitDo Pro 2 Wired Controller fox Xbox", 0, XTYPE_XBOXONE },
+	{ 0x2dc8, 0x201e, "8BitDo Pro 2 Wired Controller for Xbox", 0, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x200f, "8BitDo Ultimate 3-mode Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x3109, "8BitDo Ultimate Wireless Bluetooth", 0, XTYPE_XBOX360 },
-- 
2.55.0

