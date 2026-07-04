Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE738C2C6
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144672; cv=none; b=rGUDzhA6mXmIVn0skeTZkEh4eMxYQcd6lco0kDtOSJ3qbOFRM7Mm+pb5q1pf97qKtAev6rNgcKxcrghVnYCpq2nbRqssWWY0Nvz7ZPQgnYC/Ylt90bKxCpRs/J+pEORhI5rF8ImoCRMzpjykWqIyxFuLO6tVpeGr8mZiiuyesOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144672; c=relaxed/simple;
	bh=U89bmDnB42n015VBS+JIrR6P2wqCp+hfkJZAF2Zhsw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qxbz1cYHkPd6zVqgm7eODvx0fCEqhK7XxDg9zoImc1NWozGiy5P0EQVqQo+4xd03xyfBKXcDZbhugZ/ri3tz8T3VNYZLt7vJnzWI2IXeajh8bzGacFXYZSbfzzlUuV2lG+uZTbuTaGDC5gD6kjY41AYn8bqZrnN5vYCNcf5mp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juBRAZN4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juBRAZN4"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so591102a12.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144666; x=1783749466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dp1mXo5SNq9TpBKhHNYZae1AakBfR6uJunKVLp5bf8=;
        b=juBRAZN4wWECQgbFAan8foBltK1+P2IZKh8sPbEa7j6j1tMBWEFu4cC6O4YnpQlQoQ
         vASZG9ld6IFf9H0MObdseQcm5+wjjglcG9Zbz/Ay8LgDAQgZmm+uWV1ehemCP/HvE4Q5
         ido8+c5HzsIh70we+DVHG5VIC/170oE38+03OkieZSLl9IkFpPEYcq1wRn7jBsBw+4o5
         KbIQJPWMjUvmjB0CZaSYo3tnm0WZO/yoWThRciZa0o3Mw3jvTCRr4oPdhNqpIcgKmjy0
         90YOHYkyzgCWSgDY4Gfenm+wTLUanaFfbpjgPagN9qYqgvEvoynoMzIlh9CP5qB+OlzS
         zK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144666; x=1783749466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dp1mXo5SNq9TpBKhHNYZae1AakBfR6uJunKVLp5bf8=;
        b=J8FRjJ+C/95qgtGfx4jmC7FsLfOr7dUWPrmUBerTG2eiU6fbXHIBfavnKWgS7qIU1h
         wUu1t7dJAaP6RyLM0mdyEC6Fr6gBd/NXpb3s+SJSHZTHCLcqcd7clxDwKK6RYw/dAWHz
         YB3aEtnP0sOCYYkuXowy3DnQkHgNZgDWJ0pZbxdZY9HIsjMgDDKqQOIgB+ipkk7NrNWu
         HJQ9FHEMov3pKB9bUzwxFeYwi5Z8NkcFnm4ggMuyCszhFsWOhlw1evsV1oP1XR0b1vyZ
         EKhp41XRPV0R58rcOkUVxAbZ1KyWJC5+Mc2ESl7x3ttOaucETWqZnX7q737zRaHiAqyL
         UFcA==
X-Forwarded-Encrypted: i=1; AFNElJ/YUK167UXgtntM+QBXIvXq++ETRtAsgHsZ1IUgGexXQVO6hjxgHnLYeeTSkLPbnKLNqKeSqt5X4pSi6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHgw1y0vuVQymyg+83NF7vfJ6fa9D5TvO1f/MGM4S7F1JPpkR
	QGXoGExhN6nEbL00NGVPiv8qkfTsrL0qi7KynZJjuJFr31P/WwSbTU/2
X-Gm-Gg: AfdE7cmsbYrIt7Rj+9jopMW/LxNCYiLm2MipHLtW6ZHJHqrDI7B/s5tsh2yExzkAHDs
	EI9CBD1ojUiAs8JUh4z0pFlluXuEXuoYWq5IRPIpttlTcYG3HE883/WURLU+lSHorDJ1whwmczb
	jikuKwNyvb5cfmdTyrXLATK0whlGekAjyvmrJZj070+c9D1pFBseKCWXivL3FfYEKnNfOQ6dJfN
	UqZC9ffZWc3hSG/hT6K46FVNI5Cpyyle8mvwrBVQ42w5REBDGtH0VQXzZWOqen07tF6VImz75k4
	UPaNIfCb4PQJMQa7kajlYpypvqMBll0RoPxTRYdueK7JynHpWt1x5vLX/OvK+T0GpjeYl06cMqn
	XkKwDSKYPVrWNtQ2CenYlJWYycSdtghZ6RJb3xAP2r+P+O3Ojdw89J/N1cKRvyHDBC99wHElCV0
	LW+GtgRpgwg1u++ReW34bp1XLtblt6PBMPtStbyR/Tg73dIll+uf3Fi2IAZUOB66Am+cWV/te7e
	2M=
X-Received: by 2002:a05:6a20:d43:b0:3bf:e66f:266a with SMTP id adf61e73a8af0-3c03e5b8218mr2447512637.59.1783144665865;
        Fri, 03 Jul 2026 22:57:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:31 -0700
Subject: [PATCH 08/26] Input: maplemouse - remove redundant drvdata
 resetting
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-8-41e424964da5@gmail.com>
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

The driver core automatically resets driver data to NULL on probe
failures and device removal, so we can remove it from the driver.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 97d520e7d66d..37f60bbd0ba4 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -109,7 +109,6 @@ static int probe_maple_mouse(struct device *dev)
 
 fail_register:
 	input_free_device(input_dev);
-	maple_set_drvdata(mdev, NULL);
 fail_nomem:
 	kfree(mse);
 fail:
@@ -122,7 +121,6 @@ static int remove_maple_mouse(struct device *dev)
 	struct dc_mouse *mse = maple_get_drvdata(mdev);
 
 	input_unregister_device(mse->dev);
-	maple_set_drvdata(mdev, NULL);
 	kfree(mse);
 
 	return 0;

-- 
2.55.0.rc0.799.gd6f94ed593-goog

