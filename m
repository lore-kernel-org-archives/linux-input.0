Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191F4C0430
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863907; cv=none; b=lMs3UJ4cf/uA14oVPVsT3ln2uSmarlcfUytbsC01/bxjMLuhcFi0t700cbe/tYkj6yy9QbL9F9+ECHzR/CURFluEJzatQhn9h3eG0PcMs75TpPWTWq/qKOA0xgJZ7YxrBXwhEhmE5UxFVy0fu6hMX/AH/iE8I8aT+CAwJFPCSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863907; c=relaxed/simple;
	bh=Tss55UWJES8KsjfqUGSbg3Y5xoQRkYL8JGhYNpKzKRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIQe4unBMmK7y7IyMJgCEbk+FBW0x4w/B4BnXCSlLgquj2cHLUkav7eR1+cJVPXpaNfEbl5t1yxOSaQBDGMTqaNq4nFascg8C06hiGRJlNi0SZzR8hgFhs3hJJ7CTkOFYD7/+uu+KeNOdUIP1kw69E7AJBujTAZtG95WWu5LCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=gplunsif; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="gplunsif"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so119515e9.3
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778863905; x=1779468705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBkPEZmtCBj17mFGSUQiWY9yRwp+FYNol8gTjIun02k=;
        b=gplunsif357PN0Uhvt+izUZ73db/Xjs+K1bT3VGn1xmLdsAfB2U1xdDvQNgQKRUp7E
         el7LyozQI1LzrX08VX0YwyM0C3e+hx1xNKOTH96rV4MDmJ+b0OkvdfZtVO38qlKNjuuN
         Ln9/jFJn5nSd1QR0gxkCxNh24X4pSJIB/2h7zJYc3hmkHqOdoYkhJYZmx56rykB/WQyE
         H9takMDiCugsVUt87xmZNdyRgQwxNBWCIhwTuIypgYgmQjS81ldOxxIGwzx4UIK5VH6l
         cz0bdI/u8Sa+tNZj1wAEaNizMun8wFTJ8OBa+UJUdYN4TvmfpIYmYrtH77u4WmxTMAn1
         Pzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863905; x=1779468705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBkPEZmtCBj17mFGSUQiWY9yRwp+FYNol8gTjIun02k=;
        b=fkTKo7VbH4L3bHnYuGj2obxmmm55Ie7APWLv1FJ9NGj+oiiWIrjUSp1NbnjHVwnSwF
         pvPucXzdIHXh5ZtINfz/6m23x7MFvrdP9QsKYCMnXrrNO5kWzcWjRHlys8WBCYf/eJ1B
         bqpsaNb0HJ0lSWsojyhxjldlMKnbHSC70R+Tf7R3AFs807ggI8FNSZssbNO/RZx3GDIt
         TFmeNLbkHmG9nUdvaPHJvCru8AkJHgjatK9IwKVRsDzladN32XNEImAOBCXr4SDKgx8Z
         sgeKx2gdDzRJt6W2B7JgZ5NfeHcVzf+RGgt6amg3i0OD8WQqRxLa1rnis9+sbPYvdn5M
         atkw==
X-Forwarded-Encrypted: i=1; AFNElJ+Wm87MNsD29h0QHkAzJeMftUqH6A1lkL8FPw3vhQygUPrXf7TpL7lwUfdeRlrDYvOcgB1KNzqrCnwVFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPy9ODeIOX9tDoG2zNmUoRnIO4TFSrpttAASugqZXS/AvY1UV
	gYyUHJWBIlhkcKS+4wny1uK0C71dC4PmHABSjuMlIR63II1BdGTbQId3cy6wzZmOyH4=
X-Gm-Gg: Acq92OFxZRLl+U4xBTV/SaTo+T29YYzBccOYp4ntm0jO8P5edTONc7mYgScbSz2yGRE
	O6nulR3Zq7n21/JZZwiHoOA4xp1PI3IYt+3S35qRG1HcUj59/wdQR1eW9y+ueWjb03idbGTg8lS
	eYtybHwYm2W84W2/eRgtJLzdg3534ANsyiYO0KbjSsiIFi9U1U/6nmIYtHwAJUIdoi7XW8YPZmX
	fMcUjYl5Sw4OLovGj/AhwGuOw3zFQZnkJreIbQ9aOezbIr+7Y1x/S88bNOD6bs/y4R/ag1QhqKS
	jy16PEwpzgYusq3gk/A8Gx30psnt2xtzyzycJE7S80ahoTshzYnTT/Zu7w5Wd6RnGNq3z5FHyVT
	ycQiczL5lkKvCHlL8im/znKKy3EP1uc2EX86jyOBhNSeqLuRzAHzS0p99+4FbrV5TNz68nhh39p
	ajj5CyZCH7T8RnkS3DrZnTYfg0rTMJnGicnW+fLDni89k532vk0QnzSq1BIYrwcbgR2EGbMwjMD
	FJSFSaI2vaDMLU=
X-Received: by 2002:a05:600c:608b:b0:488:8bdd:cfcc with SMTP id 5b1f17b1804b1-48fe5ea04cemr68202795e9.0.1778863904744;
        Fri, 15 May 2026 09:51:44 -0700 (PDT)
Received: from localhost (p200300f65f47db047ce9331f6697a627.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7ce9:331f:6697:a627])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48febf8305dsm23928725e9.9.2026.05.15.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:51:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: iqs5xx - Drop unused i2c driver_data
Date: Fri, 15 May 2026 18:51:34 +0200
Message-ID: <20260515165135.498505-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Tss55UWJES8KsjfqUGSbg3Y5xoQRkYL8JGhYNpKzKRA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqB08X5vIScjvhkkupSntoni92SMc4rkWaVyCh/ bL7Sn6BHbiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagdPFwAKCRCPgPtYfRL+ TvKvB/9FMcNFp/ycdfV9WB2Zix3aROnJHLVdD9FOWrgmBi5vdUZRMKoG1AKAlDhilggovmNQ9gV V5P6Hh3ZEymiEr+YyggYRh2a0DhJCjAeeFbTrdsgdqF80iNPbw0ZY9S2LH+2g+yXuIX5pDZ/9EI CUrmQRYc9ry+y4xtE1B340/eTPeDXTFfi8C0GW1u1PVorAeE9eB0aRK45CT5tshU7IF1VFmP2UY oIgXMTkrc4bfYEHXQGU6G+uM8DeQv8JJmpIhXxOTa8M240rZoTxsbOX5UpdkBnzACjOresvDIvh rPKKTifLTrDoAYB2zKm+w/tczYZ3rTN704HR5OhU6FU5ZPdP
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver doesn't make use of the value that was explicitly assigned to
the .driver_data members. Drop the assignment. While touching the array,
convert it to use named initialization which is easier to understand.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is related to https://lore.kernel.org/linux-input/20260515164848.497608-2-u.kleine-koenig@baylibre.com/T/#u.
I intended to send it in a series, but failed to do that, so this patch comes
as a separate change.

Best regards
Uwe

 drivers/input/touchscreen/iqs5xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
index 587665e4e6fd..b9bbe8b3eab8 100644
--- a/drivers/input/touchscreen/iqs5xx.c
+++ b/drivers/input/touchscreen/iqs5xx.c
@@ -1049,9 +1049,9 @@ static int iqs5xx_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id iqs5xx_id[] = {
-	{ "iqs550", 0 },
-	{ "iqs572", 1 },
-	{ "iqs525", 2 },
+	{ .name = "iqs550" },
+	{ .name = "iqs572" },
+	{ .name = "iqs525" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, iqs5xx_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

