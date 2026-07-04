Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC938F252
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144691; cv=none; b=P8/HmkjriX34cXYXk1urpjUp49+r5OP/8Urh/eRBe3UdUTQbiiES5n/7F87SAIstLLCbbgzvjTit3WzLZaqlUpwKZ1hMiPJ3sNNa+hxcQnvH0020JoW0D0dwY13CS7SGoXHzkXOSrefa5BmtXRvkDvCgtQLri2yVp/VQ9gg+4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144691; c=relaxed/simple;
	bh=6EzURDVZSteYdlzW0VQHcWCyhb9aa+OxMVVJplZpIQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJ897wswI8Cj5BaWWCdPdG4xqMfPye6t8eqM7W/RD+WUlhg1kTEVoA/11MrsQ1Vv2D1MB1O1KhOZXM7xuJ8pl6OAm5l8N8GWx1moKDhF7fst3vtmSpcIQYMAyOae0685YobtuInroIk6E2lWPXR7r3zBmg6vsxpz1HbG6Ko7Tl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP46HLvL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP46HLvL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso708630a91.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144690; x=1783749490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odQ5XDRk/imIwJvcMYJydfLsPk2M2zgv/XPdgoTp5mQ=;
        b=IP46HLvL7nILQMse1iD53aqLSbSXJIea+uEgLok0G335qURq4K0CyyzIBdgpNzvAZV
         wEb2xz989aAMx1AignNq9YUdZ7+2FeykboP9cF3Qe4V3kQW3iIszlJHf0wbIK9u3iCyF
         e23ABRxGPvzaCnJXFiVVER5tR5KEVKOghb6Tj2w3NA9Yjr7HOAqx5V6FH8cYYU2TFSpb
         VpIsME1ZqdiC5eaeJK7M28DNtTlrpbwUzMFzmN9yB75ZGx9yD/V5wJ0Cf0q2muZlOzRI
         mIZ5zxeZqiD0M8GI+ggF2WTYii0Vpd+yL8mpbjiLw0uIHyJuy7SRdetCcvFw0HHSxnxr
         0/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144690; x=1783749490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=odQ5XDRk/imIwJvcMYJydfLsPk2M2zgv/XPdgoTp5mQ=;
        b=qopKoEWXIQN4pRGKX13ZEwPMDwUrFdMavVpSb/NMwgTu9hL5Cb6CslfICItXefYniK
         5Z0f3rcNyQhDs3qlsaLQlVdsbg6HmoqROka5niSfgIJ/3quXk8zhT+2vwqz554TsfIhD
         JsXwg5tJ5mv8M9nT2vfH6p4mT3JXDMEBlpaaaTYMNKWgzjNDPribRmg6UXKV7z4WZdSe
         hEImpV+9RtH/gzp8152zWE5F6NzolRPDT2M0HGbeH8Xvuu3syO3XqisMVe0nV2JP0VIa
         tTUxCLtgfdzjGPlrGDJ08IJAisuSEKXpdz8ZHvWFT+g5hbjKU5k+IRpwxO2zh4K87xw2
         OGiw==
X-Forwarded-Encrypted: i=1; AHgh+RpkFIwfmXnFnB7mYTNK9xpfnKibpQNFlCvX4IuflMjYjQdKPN9HMiSzuVmRunsu0EbjI/ncovTXTM+9Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBso3JntGCmxoKzp2yXZzevSct7Q7ztOZjXkXj84SSo8zbFZI
	RHnZCFQ2/+EQZEBorWejCE7wABjXpn3Mv7T4tVCiouSXl08K7xzcic3R
X-Gm-Gg: AfdE7cl8AzN7uoi6+4VoGsCy1iL1zxFEt/AllaGzACT2xMrJArpKsx2zr55h4SNAuRP
	Pkks3ICKezs98mrKLmMMc6VCpLpxowyQW89Bd+gnmDhYmPnGGtSbS7Sa116+MvyA/eAFoKMeMw2
	sOcAWEOle+AGbWX0sbSnK2yqvo5mycOKcK8OrD76Eqah7IRBH9wQfgvwJItfWlghLWr68zBbue1
	CnF0RrnsquCdVRGjwfv1cpIJmnHbRojbhhYHGfwgfSUZlL2vqAgBU7q8nBA9lAb7fIMk1Tbnxig
	QJCBG4zKuqP5yokQO+6mWeGnZutTF+FnXu/hZ2SWiLfpRyhOAtCRUbkpsTA+aSLQpqPvQwiAKe0
	VEZ3FPk1aZPK7OSUHtv3fxv8rIG9XwpIp19u0Smi8EXVNhISwVbeUdB/S7FQuuFTNjj840KFvFz
	WvT/YZ21or7kohLTPS9GfH44kLhSqUJZjh8ZR+S+e0mpF3eIqPqiYfrpeTpIXFnPGUNBhAebR74
	wt40YXbbMS/yw==
X-Received: by 2002:a17:90b:3b8a:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-3825c50c9cbmr2507478a91.0.1783144689694;
        Fri, 03 Jul 2026 22:58:09 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:09 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:45 -0700
Subject: [PATCH 22/26] Input: maplecontrol - convert to devm
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-22-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Convert the driver to use managed resources to simplify resource
lifecycle management.

This eliminates manual error handling in probe() and allows removing
the remove() callback entirely, as all cleanup is handled automatically.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 6864243b0b4a..3ef6652d40cb 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -99,12 +99,13 @@ static int probe_maple_controller(struct maple_device *mdev)
 	struct input_dev *idev;
 	unsigned long data = be32_to_cpu(mdev->devinfo.function_data[0]);
 
-	pad = kzalloc_obj(*pad);
-	idev = input_allocate_device();
-	if (!pad || !idev) {
-		error = -ENOMEM;
-		goto fail;
-	}
+	pad = devm_kzalloc(&mdev->dev, sizeof(*pad), GFP_KERNEL);
+	if (!pad)
+		return -ENOMEM;
+
+	idev = devm_input_allocate_device(&mdev->dev);
+	if (!idev)
+		return -ENOMEM;
 
 	pad->dev = idev;
 	pad->mdev = mdev;
@@ -129,33 +130,20 @@ static int probe_maple_controller(struct maple_device *mdev)
 	if (idev->keybit[BIT_WORD(BTN_JOYSTICK)])
 		idev->evbit[0] |= BIT_MASK(EV_KEY);
 
-	idev->dev.parent = &mdev->dev;
 	idev->name = mdev->product_name;
 	idev->id.bustype = BUS_HOST;
 
 	error = input_register_device(idev);
 	if (error)
-		goto fail;
-	return 0;
+		return error;
 
-fail:
-	input_free_device(idev);
-	kfree(pad);
-	return error;
-}
-
-static void remove_maple_controller(struct maple_device *mdev)
-{
-	struct dc_pad *pad = maple_get_drvdata(mdev);
+	return 0;
 
-	input_unregister_device(pad->dev);
-	kfree(pad);
 }
 
 static struct maple_driver dc_pad_driver = {
 	.function =	MAPLE_FUNC_CONTROLLER,
 	.probe =	probe_maple_controller,
-	.remove =	remove_maple_controller,
 	.drv = {
 		.name	= "Dreamcast_controller",
 	},

-- 
2.55.0.rc0.799.gd6f94ed593-goog

