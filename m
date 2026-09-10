Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970F49F13A
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053077; cv=none; b=MLPclLT8kqhOAXHRbpqApOHTDAfFn6LMglIN+Xe5MlBTZcn3z/uLOYN35rB3BNzitMStFO6QY5e4UCuzPSQcbtDFUDKnM7RVqLlQvatq2JW0qBxpsC8a2UCBa1gRaN7pWtHzqTbs/nSKyz6RAh6k+pzgTUiBHJUEvlq3BxdYVx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053077; c=relaxed/simple;
	bh=cEgo8nnQmkJEpRZ1/68xRReSRAPTxcuAW+yA8flOcrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQQib/sN1MW7ZXB6+6mfQVGYbPZuXpxAdHoDVbL+rlIGNNS4nU5IaziGnS5ScgJ+ucf15qL6G1OY9VlmnWfesgZoo7qWtjR+7Ko4V76DTvR6kyJZuVoxM1hMvCpouADF0yw/hefxx8YsFVZFYUZlLLjNZxWFu4R3nEifcHznqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7HoG0sU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7HoG0sU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957eefd361so56655075e9.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789053066; x=1789657866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t7z7yI/bUngFYIiaK8kW93MOF+YxMwhoVqpDAC52084=;
        b=O7HoG0sUYBCjoJud4zoVKzdXR/KZQN/PXSO83PaeIQ4iIif85yjZsBuVzWVygsyRA1
         W0UVoJ6lVGQXAVf83Uepprf5A19/nh1cvCNQkZlWzhtgApsY+VWQy15fsa3N0YWnlGBU
         apf+tH+4HFmsLibS9iAvGh+2C49+3UjqiF1EIYM2Nsiv0DH4fg85PW6vkLQjwaLSa3Fs
         nCA+aK3jbf9mMVZjNxZeZMEM9zOIlZ2cEIT4YrxPUN0QFJ/gu7HRvxH6Z0O9eeHw3QSK
         t+9vAugUfr6eDJQHMcfBm8Trq+j3g8wFhTUchT0sVrDNl8WplgcfdgbUYmRdHTWoerQv
         lhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053066; x=1789657866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t7z7yI/bUngFYIiaK8kW93MOF+YxMwhoVqpDAC52084=;
        b=dyjjBm8BicsQupcL3c+fLbfq3iWKZT5G4E6MvXotfD/4sBC4EUw2zaeqEYpBbdSYBE
         CmGiAn70cl6iTAYt1dTFJ0FGyLBqChyX3DNUui7fgEYxRW6bE9VXd7KOthIRydZASsOH
         jNzlpSkiznijKPWtV0JjT0Oo2ZC5KY2TiJgVBe7GatGgIR9Yz8m81nc68iPYNuh9uwso
         2oaL/+z/WyMXq5J4CNSSAZdYPbH9KMDucoTz6O/aisud9SYAyksno/pnOgym3oaGcZt/
         jvJ8rAUanFI3rZWasYNZYoDg36LGIHRxHkBMjeCrYxSnx24//O6iDD/OT88b1B5So/N8
         9RzA==
X-Gm-Message-State: AFuF++nDvishcr4F/1YsuB+BxdOig81lgAiKm4d/pm1J9qneqmMT9S76
	RgfteWz5twnl/KopyOoolfiPv1+H+6Lll8ZvOzFcz/DBf5ksp4fkAZmb
X-Gm-Gg: AYBFou3AQZA0n/xCoJIuRv2Z2WVk+6uVzLE87uk6qWtrfk8IkqyoMdr3gurBAj7aeng
	fasCg8oulL+SZBHlSC+4CJmRY4aosPASE+J24Kbypw16MLB4TY23EPkvlQ8yano0asbGgFrRwfV
	DRSe0rrP2S4EarKf1HuBFsS+VLpFb0TmdcEwgkh2spv6YSplHFfJ+0KwBmNSJOrZCBaCgyhL7y/
	As5KS4to0wFjRVu09evGlWT4GJjBXS221jbYn+Xywsi8/IMXCvy/YFTNw/LOY1SZZG51Sri0tX6
	p1t9uk3ZHafqP3ivZ/lxPkn9HMkK9IZHvLo1bcIBLFnIgbSEl+M+MEPfV//bxsX+9KRVefXnIac
	vgXfHv7Ba5QyQvI9QWrrRC/sDz5J1tbOpRUhw2JYQ6luxR+al6IckC/QVzGqPVom4z1g3++vAjQ
	Tq5bdY17RUEwAqILSy2MJUiJPBcI4E0PS/FInENoa9vvpRI3e+p1TZ/0tfahVtyL92jHb7PNLGO
	v/eYbjT3zWlulJGhbI0jRIgkCSNgcvRC9/EOFA=
X-Received: by 2002:a05:600c:3b0e:b0:49c:fc6e:a3d5 with SMTP id 5b1f17b1804b1-49cfc6ea726mr379851185e9.20.1789053066253;
        Thu, 10 Sep 2026 08:11:06 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-70-91.net.vodafone.it. [31.26.70.91])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d1fd532dcsm123568545e9.1.2026.09.10.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:11:05 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Bernhard Seibold <mail@bernhard-seibold.de>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: lenovo: allocate the trackpoint drvdata before exposing its sysfs attributes
Date: Thu, 10 Sep 2026 17:10:51 +0200
Message-ID: <20260910151051.12975-3-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910151051.12975-1-okerixx@gmail.com>
References: <20260910151051.12975-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lenovo_probe_tpkbd() creates its sysfs group before allocating the
lenovo_drvdata that every attribute handler dereferences through
hid_get_drvdata(), and drvdata is explicitly NULL at that point.  A read of
e.g. the sensitivity attribute between the two steps is a NULL pointer
dereference.

Allocate and install the drvdata first, then create the group.  The
allocation failure path no longer has a group to remove, so it returns
directly.

Fixes: c1dcad2d32d0 ("HID: Driver for Lenovo Keyboard with Trackpoint")
Link: https://lore.kernel.org/all/20260910064345.9BF1E1F000FF@smtp.kernel.org/
Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index ff7c5ef..62bb805 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -1253,17 +1253,12 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 3, 0, 2))
 		return -ENODEV;
 
-	ret = sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_tpkbd);
-	if (ret)
-		hid_warn(hdev, "Could not create sysfs group: %d\n", ret);
-
 	data_pointer = devm_kzalloc(&hdev->dev,
 				    sizeof(struct lenovo_drvdata),
 				    GFP_KERNEL);
 	if (data_pointer == NULL) {
 		hid_err(hdev, "Could not allocate memory for driver data\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 
 	// set same default values as windows driver
@@ -1272,6 +1267,10 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 
 	hid_set_drvdata(hdev, data_pointer);
 
+	ret = sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_tpkbd);
+	if (ret)
+		hid_warn(hdev, "Could not create sysfs group: %d\n", ret);
+
 	ret = lenovo_register_leds(hdev);
 	if (ret)
 		goto err;
-- 
2.55.0

