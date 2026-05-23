Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DBA29CE1
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548469; cv=none; b=FyT2ubP9p33EwAWqjGOBZHes12l5DqrqHOOosFk4WLeHP2Nuw88whb9g9yHC2E6Fbxqgo4HdN7QDB8xjKeWChCfUI/r8xPd2RJIe7S/NnASFH1bQnrPJvxtef8uMQxz0R8/vIhsuOF7Nu1dd09MwF3l7/Hnc2Rvu4OerpvTMTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548469; c=relaxed/simple;
	bh=Fapa3MTveE1aKAWForPg5UO8pyPt/pLrcQ5n2r6vfGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMqFEj8th/t3qwf/hHPMugGRAAcZ3fS9Kv1OAZdeRHYvUQ8ag1c68/bSdoWBfIVUoXZ6HyOM4SR/uBXMqB0PEiZ2X6CwoY07qZx5OlUjDnHl8PRimsHieCVKUBHvufa7t9lwVtRsJ1f2tiesgragGgL2P15Aj+5yO0ImPTsZhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gezPY7uo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gezPY7uo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b941cd869cso53728925ad.1
        for <linux-input@vger.kernel.org>; Sat, 23 May 2026 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779548466; x=1780153266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVpIs4ttWICLx4q0loWWbBkveNJdZ1S0OPQUDo6VyKU=;
        b=gezPY7uo79erFztdQN0ZXj8CxhPOoEEn+L7KXRLDqFmmSzZ6OiKdOScdtUqy8fV3Ar
         qXgMNfdxBbaihAFZP2mgUHINlSNCpFY6btSV4ndXzu95URZQmqXlG68AGxnyH6ouGAMH
         R+WzagubSzQETGfBKGsa9EE6DDXT+twHuFUmfa9nVTrYOlB0v47mRHqJkreaTmCodZhc
         SotSOLbWM61BMccVQdA/fRQSXqCQs8IFTRoYPmYLbs4KZYgS11B0Ags8Ul9SSp5qTJ58
         Z0tFKxM1nDp/j+LhEWm2SgG4wYzlF8VvERj/gNtA0a+NaTMh4tKbWspW4YSx6spzLdx6
         6T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779548466; x=1780153266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVpIs4ttWICLx4q0loWWbBkveNJdZ1S0OPQUDo6VyKU=;
        b=KvoHs6GAnbtzC6Y+DtWSnbU6XldGTGdfWijOjYitwOYqspdmAmrNp/M/CmV2jgyX6W
         NyrWXIMmdXEaeW5Au68+fgxbM/N/+DDEjUDeABKeiSsL5sqZm9gDNWBz4hzuVmmuravj
         v4MoPlm/RuBLxWMh8ljxisBBG/yKeXubZvN8ogjxreZKWqmuH18ZC5t5qatE0+AUX5Fo
         uQxE9hrBhK4OmvAYacomJaIyPZdrjCZFtDsYoHhvxu/0RsocCujXBlStKTCqa37/85m9
         NJJdSQefsIy74+E5xRnQYaI7ePyNa5LL8a/udchKRTsV4h4wyi0HvCMfXXpLbeXW/UAS
         zpoA==
X-Gm-Message-State: AOJu0YwUiz/vkBpGj0/wnrL405tsYPSY5YPrGJYGhuhhFst8ZE5yI2wJ
	JK2Zx41AqlK5XE6ol56tHWHYbZ97BXAKLxNQNhFhTu6QDORjnUdSeqL4
X-Gm-Gg: Acq92OEgdmpw03mx8iXfGhGBqoLxMvTc/OEmfbZYKtsYA4vzS3yjzeCxFYNEygQYUa1
	g417qaHjOAYKsi+3WwEULBete7RyPRyAmMdG9Vr7ug7o0zlkIFbCdhbW+/4KcduKrQOovonOhBf
	HMyRIJxfUmCNp+pMerW3F407Sg1lzmn83VwlOIYCRsGBqFJ4nYEXFwIJgSRxBLZVyCuSBnPNEFF
	NeTA1fg15id1lc7CeX8IFoiUenk6gR4I5DZgQzFd8cXNefdu/wNPSt0EMHYLRqtbX8HeZYnEcR9
	8bRdIJPDLX7jH3uep3wRdN4rE+DOK9lSBLC92/xn9ayscizdOY/Y8r2vu/orFtzFSJsoKjkWI2+
	My+rNfnajRSy/aRZaALkkJVnRzDr6wAkO9CRz94hsjcpffTh/VospsBNielM8liwnZWVLseD0pK
	z+xKuHWVx52qxgJl/+7pFYLCmoxPMkVDaddzzme0KUxTh7En+h
X-Received: by 2002:a17:903:2b0f:b0:2bd:63dc:b7ad with SMTP id d9443c01a7336-2beb05a227emr81761355ad.2.1779548465579;
        Sat, 23 May 2026 08:01:05 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f05sm64262405ad.6.2026.05.23.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 08:01:05 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH] HID: wacom: fix NULL pointer dereference in wacom_intuos_pad()
Date: Sun, 24 May 2026 00:01:01 +0900
Message-ID: <20260523150101.611473-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_pad() dereferences wacom->pad_input without a NULL check.
When a Wacom tablet is created via UHID with parameters that route
through wacom_bpt_irq() -> wacom_intuos_irq() -> wacom_intuos_pad(),
but probe did not allocate pad_input, the call to
wacom_report_numbered_buttons() passes a NULL input_dev, causing a
general protection fault in input_get_drvdata().

Add a NULL check for pad_input at the top of wacom_intuos_pad() to
bail out early when the pad input device was not set up.

The bug was found by syzkaller and confirmed on a Pixel 9 Pro
(Android 16, kernel 6.1.124) where it causes an immediate kernel
panic and reboot via /dev/uhid without requiring root privileges:

  KP: Oops: Fatal exception: comm:wacom_27qhdt
  Reboot reason: 0xbaba - Kernel PANIC

Reproducer (unprivileged):
  open("/dev/uhid", O_RDWR)
  write(fd, UHID_CREATE2{vendor=0x056a, product=0x0020})
  write(fd, UHID_INPUT2{report_id=0x0c, size=10})

Fixes: c7f0522a1ad1 ("HID: wacom: Slim down wacom_intuos_pad processing")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85..251ddda3e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -515,7 +515,6 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pad_input;
-	int i;
 	int buttons = 0, nbuttons = features->numbered_buttons;
 	int keys = 0, nkeys = 0;
 	int ring1 = 0, ring2 = 0;
@@ -523,6 +522,10 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	bool prox = false;
 	bool wrench = false, keyboard = false, mute_touch = false, menu = false,
 	     info = false;
+	int i;
+
+	if (!input)
+		return 0;
 
 	/* pad packets. Works as a second tool and is always in prox */
 	if (!(data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||
-- 
2.53.0

