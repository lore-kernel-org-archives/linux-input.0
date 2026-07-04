Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B538D
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144679; cv=none; b=TwsXe/ha8YGV9ibPv8mSEBbp8BkXTUJQvNeGBA8HwpGRP8umPOk5uAv5OcaCxTcwBfR3LcgN0HLQkhykdAiNgT87x0V7oKBLdVJVCmlnwErn9ALR1erq2yAR1zcq2GQIVce5QprOf8cto3EJw6x6TthhXqQf0AqBnyfO5r7Lzhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144679; c=relaxed/simple;
	bh=ESZdrdZ2pFZrru/54YpCHZhmVY/KZxg+461Ix4csKsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DN/0LUIFkOKDsmfowVnAFSdPVHgC9H7YXMfeyMrKpT77PCy22iezHxifA5wxAncRmNfsU69gmOFsvrpBO9xA7kgKwF6la8WFajeAPw0MLCwLNJDuBoIaMQV6Fl3j3KdrhWMVgtJcG/N3PCriljVHRoxeXkVzs/Qh2qtq/JS9HVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTaH370n; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTaH370n"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9672e02e05so678667a12.3
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144673; x=1783749473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07j3He9KyvXqEqK2ACGmojqTsdGGsyBD8B2ZxOHnjt8=;
        b=lTaH370n3BCEDWiDxsyQ7R8kxVpqdPPlFQobwI6tGhtOATyCHt9TKi3SkFkW2Dup6J
         SiByt8qIywKzyrdfjXk89GEhOu4dIfaQ480nff3L9NmoDG0uYFhWbOUzbphN2my+e33L
         FUjERcPLky8Mxqz2rBNq3nyMVe55mGCbWAnVz+S86QvB75OPxm9O97H4NaY1BGpHHFgI
         Ufogt/k7Syi2QcfMk9XtLyu2dU486YwT9uw0JAoBvX8bJC/f56ENq0pY68BibQYHzRx5
         6wLW9++jfkZbntOLrx6lBdH406WtwaLfTUsZmPgRvVGaG0Iy9z4b3CeGZMfCgnmaT7kg
         Ff3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144673; x=1783749473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07j3He9KyvXqEqK2ACGmojqTsdGGsyBD8B2ZxOHnjt8=;
        b=LHPNPcDHsuogcgy622Xb28cmN3UpQHbYVA26gqE9YFHNjvgi2Wlzao30vZpoc3pZ+H
         K0zmj1JQ9I//c4Nx7trNsnNmOMeLkMz5DwapZwIzQsmHbZf6VStJ6zwozYjy9csuaecS
         tnVHSEF/oRAtyPra0BttUX2ol1CAE3UH3QD04tmw7kZpnUk0UdXexQgHixgRPpZDJp84
         sMY9KV8O+OPqzw86EJnkzyOy+ADumxsMOc5feMADb91XFonbk9Yj3NRYzUWA1MBculJj
         loxyYFs6PXj6NlZ18HC/GunXGtYIRnsrmbe4gvny2IPlWL9iSaf9T4HoCtiu5WgYKMZC
         n7nw==
X-Forwarded-Encrypted: i=1; AFNElJ9/45Fr0PRL8/8gHJZtJnWQv3Q3mnmQQiZbr0oiu4VYCNMQd3PNlDSWMuB2fZGsNG490AM6rVjUy8nNwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzesBFDL099ZX0AUJcd+G0X9jMd0CJZXGKZZotINnPNygQ5ci2/
	V07IHMVag1AJnnXi+DTNoStXJlD7/4ziv9JDomdQ597wk29X5cPGSA2h
X-Gm-Gg: AfdE7ck5ab2FjLumxEr9EUyLxA3CRHmNu6Gk9nVCORXKwZYVlTmsCWipKKX81zr1ldq
	i6a4kkxCLePQcLxQxiuecCbZY8VBE9eUWpR5xs/z2alJCunRsJ2vPfIXu49JK4g4DZFpZlUcR7+
	sT8wSJ+HOPyL1fg2ppzb/9oC7ZWLieIpQLFY2jA9M48SIwDSv0Stk/ZD6bz8UTguyRhVQCEnez/
	PagngbtiTfejan1i7bIlthFPPVhD7YXn9NxEDegI4pWu02jU9YLydZuV42+4e54Jh+nJJKCicS7
	0DHbdEbW/Te/tWdxTqiKSl76btRj29pU7/MooxSHPiZAhGHqWWlAnZtFl8niJnAmLou0I6GSRCP
	DhJE9CNeQYrlO8JlYsdBsXDJm5rF/tTX0P0bA0elumgoCSe9bcef13fA30E9HUCNS/LYJw8dMxv
	PWqj6EzGeb9z2Xa0+Tb+MNK211CA51/bKnbeBPcgVRFMDV/P5AX/lB1eQlUn76euzpFF75MjSw+
	mE=
X-Received: by 2002:a05:6a21:2d42:b0:3bf:6c08:fb87 with SMTP id adf61e73a8af0-3c03e51b48emr2391065637.55.1783144672651;
        Fri, 03 Jul 2026 22:57:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:51 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:35 -0700
Subject: [PATCH 12/26] Input: maplecontrol - remove unused mdev->driver
 assignment
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-12-41e424964da5@gmail.com>
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

The driver field in struct maple_device is no longer used since
commit 1795cf48b322 ("sh/maple: clean maple bus code") which removed
the reading of this field.

Remove the unused assignment to mdev->driver and the now unused
mdrv variable in probe_maple_controller.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 79cec89ad52a..955e01bcfa0c 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -95,7 +95,6 @@ static int probe_maple_controller(struct device *dev)
 	};
 
 	struct maple_device *mdev = to_maple_dev(dev);
-	struct maple_driver *mdrv = to_maple_driver(dev->driver);
 	int i, error;
 	struct dc_pad *pad;
 	struct input_dev *idev;
@@ -138,9 +137,6 @@ static int probe_maple_controller(struct device *dev)
 	error = input_register_device(idev);
 	if (error)
 		goto fail;
-
-	mdev->driver = mdrv;
-
 	return 0;
 
 fail:

-- 
2.55.0.rc0.799.gd6f94ed593-goog

