Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5C38F251
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144691; cv=none; b=L0kEHtQyw1szWx3KSi80aJNm0Johjn7Hvs6yiOp/KeDNSRIu0xCV1QdNGEpqcM38vor919sbyyFvL2yEwvAyE13aZM0XSBLoDfivFu189a5Uy+zwaKaEhtRHJF1GNT0RV+tg69v7j27shZfQ4zi1E++YXvXzpYTz22/0cwdHkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144691; c=relaxed/simple;
	bh=x+qjLATprHWVETyBtguIFSzJzAIa57zeTCo+KlBh1GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rk9T7a+Ssbv/13fJp290ZI4+Amtw4nnOpz9Qt48ISgrkA3U9FnzjsvlXJNUJ8xy368pAoFyV2eBWrNupIfl8oXoc47oYbLMR1T2iyGulf6/mif83esh7EMYBBDKUo5BxL0VMcw+eM3HtgKS/kwUc6gJZfpDrBwy06FdB7YBEbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqUKsabw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqUKsabw"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9d265355so910686a91.2
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144688; x=1783749488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjRXENzhFdJSLRiM6d5V3++2rjRXfCmisZIqwmSzJyg=;
        b=hqUKsabwulssajAcE2+cEgHwYIE9nSin9/+Mx+zD85wAbYUVWWRN3V0unhVqiK3Lds
         QNSulPD8BsFnXyk86M8gYLWW8udBnWTTvLbCLAgZHuoksGqQR0op0/PRuiUB4A11Q5MV
         FywMe/8EHZmlpS57EtE7s013BfqjCnZBggCu8nB54mdza/D0eqbjf4DCRiBlNW4B1mpo
         GcejxH3HnLzGmqEd5LC18flJDrm13TPl0mTzi5WjOGjXvvx9jUMsmt6y9VRWDaCJwhfW
         IKiPtiglm4W/uTnVXRVrirOlROQ0Fy8zRZ8krNSSMLdG+rWEVxLpXuM5+m3kM2+OtQr5
         87hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144688; x=1783749488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjRXENzhFdJSLRiM6d5V3++2rjRXfCmisZIqwmSzJyg=;
        b=tIzzJIFyB8oa7exjKhvW+KBN7WuU9boZhWy+kjXrAALgixpqNptsXpfTWv9q4JIw2U
         eJesRjB5agve/MieD0rK2ZhfSaYbIEYmCo9PPriUIzaTCLr4PMDbkzhZgwwfnmoLRRxN
         5Hsc8sW7Xn0VAZkVtLSmurhyL3rqkibCh7TbpmiaJVKrRzTca/Sx8E8LT7d+DRDoV14Q
         maG5LKZvS40Qcvcz9hBRYvtDF50pB8YVwIK/b+l4onYG4F2TrEn28TmUKQSU2fnA+N90
         D1TK+jnKUpaumQVw6Ip/AxYH3lXwK4rDwLttwPLKyIqN/Qg5h/NchsEkO02d3EkDP2VF
         5RRg==
X-Forwarded-Encrypted: i=1; AHgh+RpbpIPksk4gpJpH/A5fqvPhiSlHjhur8t+TNtxw9x+An6S7mqRWi2euiUmUCXllgm7AllG/LPFlvFA4Uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDXGMNKH9hgzba7D72kVa48MERRFcm+tNG3dBug6X82wUuzXwA
	sY2Ts566y5knOrkKf0ExmmwcIm/Q5sfWOa7aP6d39XfG3nGmwfLAdr0e
X-Gm-Gg: AfdE7ckv5FM/cT8/fZ/55RQol26Q6V+MAk5n+H8/JhGI/Vih8oRLeX5Oa8DKkt/QbWx
	m9MRIGDTrFBn2PRWS8Q4iMAdEmI8IrFemKGhbBT3Hdbob39/PfbET0skWbzzyd+7fY+qQEv+e1R
	BYw8m+vswyKQdjWxcn5hJIg34ahmrp4KGmGIj16gcFT/mckNlfq8GwmdU47f7pGKmXjDlToW/w8
	gPRICWFG2xsXQkEZ66gqRjlEFLNKz1pfcHIdHU0UX9DwiUlTiuyy4itkdJhUt/s/eZjFfKB/QI6
	IM7Ew8zJ/LqvVgHLJJe5eo0t39A8V/CAnyM0sG+55rYjvut2ezR55x5w1TcjSMlezkyTGKqbgPc
	R3BM2v0aqu2VZErcLMRLEEnCrj/cLkN2fc4/w85bEphr2yTuyokFDMSpDi++Ne0Y8hPUJylH9xh
	GfkYKzzvKIHegyrWW4x0ySyGPXSsV5hvVliUx0P6VnC/olib4jHcQ9zaYKrVA9XbqMwtoGFePdr
	jQ=
X-Received: by 2002:a17:90b:2c8e:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-3825c50c2ccmr2400537a91.0.1783144688130;
        Fri, 03 Jul 2026 22:58:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:07 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:44 -0700
Subject: [PATCH 21/26] Input: maplemouse - convert to devm
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-21-41e424964da5@gmail.com>
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
 drivers/input/mouse/maplemouse.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 03cb666d278d..7842bd46c9a1 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -70,17 +70,13 @@ static int probe_maple_mouse(struct maple_device *mdev)
 	struct input_dev *input_dev;
 	struct dc_mouse *mse;
 
-	mse = kzalloc_obj(*mse);
-	if (!mse) {
-		error = -ENOMEM;
-		goto fail;
-	}
-
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		error = -ENOMEM;
-		goto fail_nomem;
-	}
+	mse = devm_kzalloc(&mdev->dev, sizeof(*mse), GFP_KERNEL);
+	if (!mse)
+		return -ENOMEM;
+
+	input_dev = devm_input_allocate_device(&mdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
 
 	mse->dev = input_dev;
 	mse->mdev = mdev;
@@ -99,29 +95,14 @@ static int probe_maple_mouse(struct maple_device *mdev)
 	input_dev->id.bustype = BUS_HOST;
 	error =	input_register_device(input_dev);
 	if (error)
-		goto fail_register;
-	return error;
-
-fail_register:
-	input_free_device(input_dev);
-fail_nomem:
-	kfree(mse);
-fail:
-	return error;
-}
+		return error;
 
-static void remove_maple_mouse(struct maple_device *mdev)
-{
-	struct dc_mouse *mse = maple_get_drvdata(mdev);
-
-	input_unregister_device(mse->dev);
-	kfree(mse);
+	return 0;
 }
 
 static struct maple_driver dc_mouse_driver = {
 	.function =	MAPLE_FUNC_MOUSE,
 	.probe =	probe_maple_mouse,
-	.remove =	remove_maple_mouse,
 	.drv = {
 		.name = "Dreamcast_mouse",
 	},

-- 
2.55.0.rc0.799.gd6f94ed593-goog

