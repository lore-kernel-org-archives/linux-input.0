Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32E2D5436
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655528; cv=none; b=EogDCrAQOTEPq/3iCvViTarTvWfzp1ghcnrLuEwqQtxDh7U+8DW++JuxvHoIdVyuS0s5UXeM7mOE5DJ3iTmnnusnHOAkfvPpwmKsTdFMsvd4kXV04QthXa+G5mzF1WO2C7Y9ju/P+47hgnbIIWwIwil3rcshVQOeMXJpxD0rRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655528; c=relaxed/simple;
	bh=xlEe+0l/y3qsbo8Kt1C5pTVTlhzPO4X5YXqXiRlgZf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTV0+C9wQt19WLUiFn11qkREiWXeCKFhyuvm2/h+vU5uXsGj/U3ZoraF9iOpZXo4uhD1RMpcwSIi0tvqo24ks+NnBoHYUzNOodPP6moOiNcfeL/E3A9jncWfrKchcuFEauszjKhnMKuxyYRYhR/ZtGWBmNWCQ1Zi+3BqeIDf0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juqAb5Fv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juqAb5Fv"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so57300825e9.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784655525; x=1785260325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYq/X9ZO2Ff72kXn3sF+/1dtB/Yj6Y/p7euGtqgJaZU=;
        b=juqAb5FvGgcEZcFzEBwfBpXlYSL5M0SUmTHYZpRlj3RQ7I4JNZm/+gkH1y0Dhci5JS
         nE69gBnNWU05xixHNWtIGmHYtQXN2uvR4X6mxV8/Cq6P6b6c9EY7Sqzoeuwq4bNkJn6A
         gunr/cBo6v/TNvkWjV/7DCGk7ejXGyYzFQsFIUBVAk6HL2J3iCOD/aQ6PlaANBqFophe
         y4j8qei3Rbf1IBfDTgAfA2ETPve3xHn5iQ8Cc1eAC4WS2jx1aq0et3/xGipiS5cnDWQ/
         +c0uDfzBjHtw6uXHnrwgqJCcxT8v9JlfZ3jfd1A1iBOrPTqDc0XjGZ5jAHZ6Dn5WqG53
         2wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655525; x=1785260325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYq/X9ZO2Ff72kXn3sF+/1dtB/Yj6Y/p7euGtqgJaZU=;
        b=IN1NRbmxuhdR/9apz7LqB3EFfdEYdzJ0sRY18OUqgTyU7JTwFd2pdLgnvikTJwbLJF
         VWjxtp8b9+njqB2fZT3fGIU4G0c+p4qce2UVufLgS0vAr6MM3Vv7geaixzGKRjqHko24
         DKJYMyS+EyGTKexDR+piUNQhGe9+7ENrSmZrt453y7vNxbIeJAYNtwtTFlE2RkZnHac8
         hK733QgGaNySnU8Pzc3jZCuFIR5f0pU5ef+bxWmfEXmShjYu8z9vLjhA31LijYJHB/oQ
         daHHsqbkc7wUqR47zCLos+mn3XsuVrM74ID8ahF7zXd4foC0bjVZ6tjdND2RXdy4dW/O
         0cUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqb16UDj40WTBCHwN+TstezLAjkPGZzsHD9Q2nr8Tw2/FfGoSfTMU3PHWG2MOPuAKcF2iEy0s8t3Ij4cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJIA7628shLSu1Un1UHNwuQbN+8adiNLRWJw72JmMBS9Pu1C2
	ydjtVJVJBplbwUsymrC4kjba5dX+6kkxTDfLDismdASe6oZmAS6d2ZHj
X-Gm-Gg: AfdE7cnuwsZkeqb0ZcSeRjugMWV9FV5wVFJLxyMxMGXSBDFVf7IHDMHAaYZEGI0dJV8
	PJEYLBRL17VBbNl5xL3G1eR79cG/Ul3Ob+Bb8EyVMto6qKDSg5zj9Hifve2p+Sn1d7f8fLkKpjW
	398qNevq9IC5MoBmv/FS123S9KUSSquiJmwYvwK0G/MeqXdGfJxHQNJZ0xz7rpxvtYLaWQGxFhG
	vhePD4dZx9TQ3V4N2RK9UQ7FSYpbUl+Yfjk9XPvcRG2nAaxCQjS6ahVuLvqNupKtIA/K2qudnzm
	XBAWBsFVYBDPMc3fsS6ddAuejMdu4hx1GxYw0nUNr1Gd95EWa0EP2Pmt8W/AO5RH9jrx0FCZvIj
	aqjkLbR0pIwfYcyiS+S+luh2a0SxyNYpt24/xcGUmU97za8bAFTm5G7qcRf6VFkBDkFM7JYWOJf
	8zbZf7Z1HZjm4xSYc7bDkV6/vj0rPSHsTsRDf9RJ80zGhR34qSksw0i4JHVQvYoPF1Ihb2suZFm
	Tc=
X-Received: by 2002:a05:600c:1554:b0:493:a570:df7d with SMTP id 5b1f17b1804b1-4954a402f91mr240769725e9.20.1784655524695;
        Tue, 21 Jul 2026 10:38:44 -0700 (PDT)
Received: from snakeroot ([2a05:87c3:2001:7400:4192:928d:2808:a0ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565304aefsm78583605e9.0.2026.07.21.10.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:38:44 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>
Subject: [PATCH] HID: logitech-hidpp: Remove duplicate ID for the G703 Hero over USB
Date: Tue, 21 Jul 2026 18:37:10 +0100
Message-ID: <20260721173710.500368-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID appears to be given twice, remove the duplicate

Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 90b0184df777..b1b1c5cb657c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4659,8 +4659,6 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
 	{ /* MX Vertical over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08A) },
-	{ /* Logitech G703 Hero Gaming Mouse over USB */
-	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC090) },
 	{ /* Logitech G903 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
 	{ /* Logitech G915 TKL Keyboard over USB */
-- 
2.53.0

