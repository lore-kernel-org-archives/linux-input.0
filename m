Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C92E9729
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854338; cv=none; b=rwagwvT0OrWamU8yaX+dUrguAUs0LHAp5EGUOhMwKVlkH9P2BhA39f1uLbQtsfLsbyj4uo7MNZWSiscKd1b8a4oY0HbKMB96FLay8ul+qcpPSQ4TfOtE8Rly5RAXZCSsJ5Qlfj4r7lwBml3zJI5t6pw8maTNlVv89isdQJrp4yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854338; c=relaxed/simple;
	bh=DshD1xcus9VBsfM6T66t/GzdDGQc3tUVa5lbo0BqehY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMeNVlU/RzZFB8g6CvpP2vjz9DY8e5AFO+kocVox3a71kKoNxi/ua73JPXtRf2JeKnjQUd9rVFxfg6vlRrHOyNTSaWv+sAwqhoduvJSSVqlvIWVQ2HZ5d+OW3RODV2SEM7A5AjsNRcMfZ8zn0iWlMNmOIJX3igvI0TgQXIeNVG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieyX/ZCc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieyX/ZCc"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80c5cb9a888so33026007b3.3
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854334; x=1783459134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P55DR2iwBeqXLU63WwWlW1zNXbu/+RdUBxWvsdNCu8w=;
        b=ieyX/ZCcUeNE+5bltBJ6gjY9hnhcfDfBXZ4s4sWBw5q741ANcrWT4Q1ftfjkK41SKh
         gqyJjJO3vHWc8hsJ9giNKnhyL32/ht0n7N9fpEA5DHEY4JSLMUod/5HwVv/EFZfAEG9R
         xjMdyapPa9Okp1cFewi0hMVI1I85TnWvm9qaUpVYN3GZGD+eKg8VJ3DqU2ORXz+Xz7hn
         ufPZCCocZPHzGNWgGZOsiOUrg9tlNDzapsnP9ku6n/ER2hvdYFdxZZ5xv3gfguctRIpO
         on7jSfqqmjq49oZCnTFSuCkUv1zeoOpz6SoIUWdrN2jUTbIM2Guqw+sXCD7tUBsSJki+
         7wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854334; x=1783459134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P55DR2iwBeqXLU63WwWlW1zNXbu/+RdUBxWvsdNCu8w=;
        b=Vig7lre/fJzTlriPHMyyhVwz7Um61/6u7JEgcWDcIPExYcXq3UeMLmtHWt+EU/kpYt
         DgSofmm9J/mTYNMoRiq/Ot7qBU+a5pFc/AKjVdToyyB4sdIBTGR+OudsptM4qDmU4c43
         HxIdAH7CPo8jJU9DSfAAx4QtyTpL1oNFy4KqlTYU9zjERIvCbBZul8ghexN4gEqADWep
         UZfPnEeJQEuBmIRt2qui42mZfAOU19eYsSSvDfda7bkRdRVcuNVjCL+Ve4IB1SzlyZ1m
         NOipGuhFA3sGu/oNaoUK/4jPr3Avh+T1SHlc0kTDno3Ktozp6gezS6TSbvBv1v+DOAQV
         YnOg==
X-Forwarded-Encrypted: i=1; AHgh+Rquc1xkQvtsSftdf8QJfyH708kN2JL3QWnfYnprksOlivn+b5Y3PvaAp7gJ/eLgh2tyhtFWvxFCV+pvow==@vger.kernel.org
X-Gm-Message-State: AOJu0YycZmxBVX1YUP9rvjhW++Tm0NIm5pKDJ9TuQlmJ5Sy5SBzxAfG5
	8+rcNiT4+CR9bNsNB8BeEpK66gzURbOE+tlVIWWym5ItqEPrDRbnolyp
X-Gm-Gg: AfdE7cmWPAMyU7KYhJhuJ21lb51qMpLoqVg+Ruc0nZG4FCvRjxoG6q/D2cjlWzYK7/w
	xoGK9obpMvm+eRNBxpDbmVrEdvv61qhFhxFHHOSN+9bUqm2AbIL1pZazsFfFGLLa5CjQB1JJtvN
	VZ7bTu89EY8bf5JmE5rJzpgmhTSA9ZQ1x3rww+469Gj4pcAMjcr+cCQFv7lePi/j2Utk5amKN6h
	EZff9YiOjokjLyeg6ZPpSAS9Yj9vgv9rq4lXTl0yPvUSwIQCfOHUl09Yp3mqkb7szz+KCEToLeY
	l74ootLVoCQwjEgMdkJwUUKbvu+lFwdTPU7rP+B+94F2uPl9sLnrQSKTlIwrCujcjWtzslLB8lq
	a+EUKnlacVg7n6hxNur6GuPtn7jb753fab4Rv47jlvcN1kbWDwPWF8GAXdJNcA4bvUs4UQIUbnM
	L+10VFSlyv9Q2XdVRpKAqdHHF5BA==
X-Received: by 2002:a05:690c:6905:b0:80c:76fd:f74c with SMTP id 00721157ae682-810d8ce9c56mr57247127b3.22.1782854333639;
        Tue, 30 Jun 2026 14:18:53 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8128ce56ecasm33737b3.31.2026.06.30.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:18:53 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: hiddev: set report-init policy before device registration
Date: Tue, 30 Jun 2026 23:18:45 +0200
Message-ID: <20260630211845.50511-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_register_dev() publishes the hiddev character device before
hiddev_connect() initializes the report policy. A process that opens the
new node immediately can issue a usage ioctl while initialized is still
false and trigger usbhid_init_reports(), bypassing
HID_QUIRK_NO_INIT_REPORTS.

Set initialized before registering the character device so every opener
observes the quirk-selected policy.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/usbhid/hiddev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 6378801b22c6..c822e7dee8b7 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -900,6 +900,8 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	hid->hiddev = hiddev;
 	hiddev->hid = hid;
 	hiddev->exist = 1;
+	/* Honor NO_INIT_REPORTS before the character device becomes visible. */
+	hiddev->initialized = hid->quirks & HID_QUIRK_NO_INIT_REPORTS;
 	retval = usb_register_dev(usbhid->intf, &hiddev_class);
 	if (retval) {
 		hid_err(hid, "Not able to get a minor for this device\n");
@@ -908,12 +910,6 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 		return retval;
 	}
 
-	/*
-	 * If HID_QUIRK_NO_INIT_REPORTS is set, make sure we don't initialize
-	 * the reports.
-	 */
-	hiddev->initialized = hid->quirks & HID_QUIRK_NO_INIT_REPORTS;
-
 	hiddev->minor = usbhid->intf->minor;
 
 	return 0;
-- 
2.55.0

