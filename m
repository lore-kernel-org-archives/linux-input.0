Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A93F39E5
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722086; cv=none; b=f1LhfcXiuHinzPc2Ca+EfSozZ3Lff/p8TRuua8BV5RnmY9vpxhlsEO2pUg5cSgAc77rDqlJXR6IGJjbewBp+Adx57ZfALJBpnr6Mq2SRu/acFetuGgoYJ7kIeNeIrF2qX+pSPjDf6WZwAKIGMNwERqXHsYfbNdEv1WWzhCbHVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722086; c=relaxed/simple;
	bh=yZfleqqgRxjy4Am5CNAwgS6zya8iAH/d6o7PPJgGwaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmwTzGVkYCx+h8KrPObCWVqoMqbVFNzE7sUtknBVaLVoy+/EDX7eM6x+8IUdjhsDPC5SfvLp08z4/7wTWlIEfro2UyDyeuaIjZGf/Cy6avgnxgL1p/BkiUpuwZNUpw/iIpueR0Z11+l023ZYmlicz3OZvnBjSxo6NRWbm1f34ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwhJpUAg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwhJpUAg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-366139223e4so5842473a91.0
        for <linux-input@vger.kernel.org>; Mon, 25 May 2026 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779722084; x=1780326884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ekN9RA6xWGM9vsTg+kkP2fzePZkZ7mF7z+5w6nzPco=;
        b=RwhJpUAgVWVYMKpF+DhH7H22vz5C78oQYac7V6CTJ8G9qyEY57Ke+CzaEtAtH+qMBd
         zF3fRgQvEqwgDpnwrl0v7u/83tlWEc/bNoBg+7ZNw2zDLaL0JHoB4SMkjL/g0m3zfy51
         dL92Ctei0X4jLpmmTBmfrMb7J0S4Mc/C8Hz4UW7wUOIjYqivKrRXVZe7He8B9tgYQtPr
         pnLMY40TaXNqd9irUyws1r88LECH73N4GsOpyr1mAnKL/mZoTi3Ih7gZu97NaSUzZdaz
         QE1ClFUC4g9qswsNYw5E1IKKeH1QKtbJ8cIhprvxMRlbmWKZfV/CEuseChlQMRTwKQx+
         pTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722084; x=1780326884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ekN9RA6xWGM9vsTg+kkP2fzePZkZ7mF7z+5w6nzPco=;
        b=IEYKrmxiJDRdrQxKcS+OpCxUpDrL75Y9s1EKqnEvcA9cewhAA4bHZPIZE1HhXAkeH8
         vkzoyus01jr6tEr/BmQMd+QbDBzhtnUP/AghbAQCQhsObXVWf8sll/1hxzmHiBnsV+ge
         zgFrpM98gtKQ/ejXt5L001VA1udpbQLwrmioL2CqLhiLiU00vhdoD23FJ/f27rMmVy0t
         czZYPqc45qrYieVOy9KVSHrm+Z2vC6duVY0c40ytSNPgvrsZogyivQdJ1J2T+A6d5+u1
         tXfQhmFQObcfw1nYFVh08fUl9xJtgz8h/b56MuOqrrz2s+ef4nupcGkXZxSsy35+3lMG
         SLqQ==
X-Gm-Message-State: AOJu0Yw4xhB4KK/UUbo+WUiZ+WJ/YHC3uPkuOoHyFXaq3c2AkaJPvfe2
	a5j1ov8Wvo1KoRf2RfDr41IEKDoiCg7C0WYkiU3Qau6NPelN+Jv7K9lna+xSd4wqweOdCDPn
X-Gm-Gg: Acq92OHaSzQOWgweIGqZdyHYw5fSN2/gfm8ye5zrssF7dtprU1cE6e0OfxxTlO5wKxo
	+DjF+ta31Q858CkWUrmqQICLiawhH2Ua21aqA4t380NVty2Ou9cnsk0TVBlVqfxqHdHmlH8Kp0O
	8UiT2SjLTPiOCQy7rFU262kBTcGojVADm3UIZ2A+IBZDDVikpPJenHzFLJGihb3BQdU5mjQ6Uyo
	7ScCNrNJuUU4EHkjpqegXxxWWmtc4W/Uf8otxZ4N7/HBs2KlGxryjBypU2PLGusQkGUHjfq1h9X
	P4Nkn4fh/YPqMdqMyHhTyTp2joEPFmVnx/Wd4RTIHSCSk4iHPGcp78rbHNqQRDb2qxv1gmb/gfj
	vJxQ2hw9rb+lgLNAE8z4o0fso8oWSzKE3gtYNY5S+BFUDgjS5YVpfugYutbgxWoq5DdmnEujWFP
	HDCJdLimSsgqOvE4MGs4As4TTPFHBFh0h8hNQp2+x1+SsvIthNP/mQKjF7NFDkTMCMM0GGEaNu
X-Received: by 2002:a17:90b:4d0a:b0:368:f0a:1c48 with SMTP id 98e67ed59e1d1-36a671e2735mr14075939a91.0.1779722084256;
        Mon, 25 May 2026 08:14:44 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([223.160.230.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7cf9sm10097658a91.10.2026.05.25.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:14:43 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH] Input: ims-pcu - fix use-after-free in probe error path
Date: Mon, 25 May 2026 23:14:10 +0800
Message-Id: <20260525151410.42750-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the driver fails during init (e.g. in ims_pcu_init_application_mode),the error path frees the pcu struct without clearing the interface data.

If the device is disconnected while in this state, the disconnect handler will retrieve the stale pointer from
usb_get_intfdata() and trigger a use-after-free

Fix this by setting the interface data to NULL in the probe before freeing the pcu struct.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4c022a36dbe8..fce3232ebf07 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -2063,6 +2063,10 @@ static int ims_pcu_probe(struct usb_interface *intf,
 	ims_pcu_buffers_free(pcu);
 err_unclaim_intf:
 	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);
+	goto err_clear_intfdata;
+err_clear_intfdata:
+	if (pcu->ctrl_intf)
+		usb_set_intfdata(pcu->ctrl_intf, NULL);
 err_free_mem:
 	kfree(pcu);
 	return error;
-- 
2.34.1

