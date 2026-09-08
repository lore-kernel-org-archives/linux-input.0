Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF2525A8E
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859160; cv=none; b=llqQCUs5ARoyDfkbXYp76Pz/dnCANdR3WO+0zhTJ3SgvijBAq+afgcfap8U7cgGzlSl5uVFcOmzZ/D2JdEjTaQ6ywbcfPIwG9hNXevRrVpf9yRjSFsaifXrcCRMxgmIv4Va1pyhMvdS10kAVYtt2NIDe/JvnygYgRto9/6tUQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859160; c=relaxed/simple;
	bh=xtgeItdy0OzALjOO+/MceqMtezUFrplKml5SLbPUvec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBIakucAF2L5blkHln6nF7pYrPCLpVZJrEaC0q0wRfkD4XLjFEY3zBIeAQOLgcv1LPKuU/iOJh9rjgPNMQrIPNk9mhiAvPz2G2GT5QBbpaQROR0iRJ2UOm5buCF3PZ2teaFQ/kUhqoTDnpuuOVh6adlmprtd22U1DBUkuOzU3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=LakehRZF; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="LakehRZF"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso5625930a91.2
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1788859158; x=1789463958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtIpB1hhLYGZusTjT6rnPHQOVwY+sSeAbi/bl2xwBEA=;
        b=LakehRZFsFY5Zn0t5WjpOX3Dx2j17EAlrGMVJsjOsnTVMibF6/sRvBfvEPrN64wWtM
         HqTvoSlW9fxGqyg9Ssv0Ia8zB8X2xCQAYBnVxnHD3R4OK1C6HniLBQRZh3vId/QiWVBK
         U1BEr05m2i1sqLZPFHID50C6vC0O620gCBdF0KVknTfSCQmWg/Mbgm7EZZrpNTWQW9Ah
         njybgh3eabDmUg/dSvmOakj/4aF38H1dLXyKUZwYEo2YmjPKBvHAoSVeWYwZoFhyKwSi
         KGB8+8hAhOhH6FwYiKzR29T5iJEA6rqYOfW1EZLlna1fiwLMjXdz3D4JYBCoePOSI9rM
         b8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859158; x=1789463958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtIpB1hhLYGZusTjT6rnPHQOVwY+sSeAbi/bl2xwBEA=;
        b=Sq+LYWD+SX419pA6bxHTTVT0YA7NUFd9JRXmSHb79kxA1TuajM7y474kU/BtweMyx3
         3sgnwiilleq55APR44bAD8cZhtyhmzvyajIzBF2sHwVyrwlUYSdmWSM/PZDArr1Rf/1I
         gnK1d8XUiWzdNZxz8C4EEwT7YPE7ZcR9v/y3AE6pQ2vWRrHpVLcxmtalGrfa5ZYjnk2P
         spowvnwkxuF098PXRIYbaK9Ihort3eXNaWxIhcOw+Nt89A5wmI3+IwupF263rnRcLuX0
         ItsZrRDx0iz3KzfU3L6Dv2INxe/+46IDQKqHRcAEHcE1Jllk0PrxCO8Z0kx9jTcsFZ/u
         j+Ig==
X-Gm-Message-State: AFuF++kvL684MsL7VXjWFojcYcGdj9b11B8sUzKSlin7o1wBZhDPcasI
	2GLZy6lfim/S1Uf4hViA5LzzVLs/3TXXcpNzvRvUTeXOfWDzwb181pg1X8SAUrVLjLE=
X-Gm-Gg: AYBFou1rXyUryAopf+xc6qiDaKlw1luAGl7zRA+4P4V4azRtWMlrM2ia1r9AY9T0c3l
	98xyu/co6XvhrU2WPhpi4rM6uHU4/mx1o1Y07LSgDGpXaJ9whBLLXNF9/7lr8yBvRcU6m3X1mLM
	jJhw+OmSF/PItNCGIy9PfY4WLdQkwK/RqPJV0u7TI6e3BaaHq+0BUzdgImeNCea6KdRTB7aTbuV
	WpS9vnubqMzjTyZYAGRjrvG1VdsE5/WWTfqhmzb6+5u9spYxkoCfUrvINgh+S5W0zuiwynPD276
	h+534M9nSmraAb6xPt7hH4+N++aJdyBhseA3vtOUCi6BVYuisGuoWt9qeRmPsYjbc+0fIkNZJAT
	YVS4cs+l/UpnP4Ew0MkNiuPWT94NyjlOdXtWm6WUhhJGNy/llDQGaqclAa6O5nH1MFIbhGCoqdb
	pJfDevX94XWArX1sHnM0Zwb+8cD836/1vj0p8vpl7wxN1R/nxYtQXO3rj/1/7R7Oeowt+j2unx7
	n/3lw==
X-Received: by 2002:a17:90b:2e0e:b0:398:9be5:b419 with SMTP id 98e67ed59e1d1-39b2622bfecmr41833249a91.20.1788859158105;
        Tue, 08 Sep 2026 02:19:18 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:75be:f01c:dde1:cb38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm32015722c88.14.2026.09.08.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:19:17 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Tue, 08 Sep 2026 10:19:05 +0100
Subject: [PATCH 3/3] HID: surface-hid: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-acpi-hid-v1-3-08df24c4b139@thegoodpenguin.co.uk>
References: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
In-Reply-To: <20260908-acpi-hid-v1-0-08df24c4b139@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788859148; l=949;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=xtgeItdy0OzALjOO+/MceqMtezUFrplKml5SLbPUvec=;
 b=Bv7PIIbID1GVnQlHmUM/w6I/Dk/7/ZxTyv7MMza9p2ztJgGoB+kz78mu4kY+t8C8rVCMasMtZ
 uHNKMpfVlH4ACgJZ8jyEvtF5bC+fh9VtG+PEI5AhmcQ4SoYes01zUkm
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a named initializer for the acpi_device_id fields which makes the code
more readable and consistent with how lists are initialized in the rest of
the kernel code base.

Unify the list terminator to have a single space between the brackets and
no trailing comma.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/surface-hid/surface_kbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/surface-hid/surface_kbd.c b/drivers/hid/surface-hid/surface_kbd.c
index 0be01b5e74258..036829ba47d42 100644
--- a/drivers/hid/surface-hid/surface_kbd.c
+++ b/drivers/hid/surface-hid/surface_kbd.c
@@ -277,8 +277,8 @@ static void surface_kbd_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id surface_kbd_match[] = {
-	{ "MSHW0096" },
-	{ },
+	{ .id = "MSHW0096" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, surface_kbd_match);
 

-- 
2.43.0

