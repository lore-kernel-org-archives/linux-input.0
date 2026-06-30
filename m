Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A5312836
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798460; cv=none; b=pGgjVmtkoQDd+dpYZpwsDNmmetWCm2h9LxhVMfnkp8x/MCTI3PzLk5v1SRY/IyKWG2yfrYMMEU4lmtP7Z+r49ug5du4Qh5t0hikahQ9QXKPVWnlYv2HDpw804duF25H6/n2ONN6mSOSEN86lqPWWq0ZM42DA4nOn2M0Fnzbbtok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798460; c=relaxed/simple;
	bh=SljzRegAkT0uzd/56vjLEGIdJlHsNr7Mehml7rKmmnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pcis3EZYyipzjy91Ld0ndqIPl2EYid2NzVn2P6VShbvkI/JxAraw5Rk0T4MR9OP9SfaRnWdtwsZXnbFSQye/wlT6cb4tXKaiN3vecj+o5Z+XkwJ9bgjg3A86/PHz6tzpR0ab93hJmw8MjnJ1JPiP5P+7K7y0XZPO7FcIgLeJ4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiakvVCY; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiakvVCY"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30cac93dfd7so205891eec.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782798458; x=1783403258; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR8+fYhCt5WnitF16S0W2Q4lRJrm6F/b3dePzK7qEN8=;
        b=iiakvVCYkEtuj3d2uG/lABceSRf2SEn/Mqd1K6BhvROhhloBSUwfNHlSpwv5AAk+oM
         RSFmyig8lBGFapBKWOJMlPrZNyNVU+VYPugY60OXglSef9K5yW9ze/QxdyflpteOnYeB
         7mBgf7CaSfS/7tdvCoNPgduzeorsv4l32vAK4LA9Cd0J2f6wRC5SH1xq+/kK+x67c89P
         5dyubmwur2lE6WsCXpT4OMcT3672WvuhQqCA0kskjj3mG0jU3frNtZTCS+W7tIekb8Z2
         qyUqcnTsBxrVd+/tC0kp9Qshcg/BTCKG6NfkN+9vNFF3zLLGdjauwLHG+kov5NCNDaQS
         lLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798458; x=1783403258;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR8+fYhCt5WnitF16S0W2Q4lRJrm6F/b3dePzK7qEN8=;
        b=lB93BRUqhl5tI6DxDhrTkd4LSEzaUUN/9DnMKBC6xXzzU3B7irHKbsVAUycOzRM1ZM
         Je798lBjdpLcbqyFaf5ZDV9nTTR7Brs0k4F8jAMU4iOTKEl7hovQSW4Fz+wPfhS74tNC
         PFY6cEJuHhfjbZCHNmYDJ4uLd0zdMD4tGR+naDo1aozKhkR8zmHKsIXFzq0f2BYaZ2If
         6+6R+mNschUV9ANySeVSsTik9/BMX0EpwDsgR9SffO3LLdef17g4Y4OsX7mqPGipM9Hk
         A986VcxlFcbvpLaXbNC5Yu5xaG7fndqj8OYD8pdL8o2E57BQpIqtSjJpnaIdLR2dIfNn
         n9BQ==
X-Gm-Message-State: AOJu0Yy1nUOnouZe6WJR+zUWUZChmcmVUvO7IljVmBI6CXnzqrjP/970
	wv6urQ4YiZLRpzK/b+eF9JjqAM0SHeom8IA7G2WFfAUYd5qNPeDhetKrbd1FLw==
X-Gm-Gg: AfdE7clh/ieDQfDZ9MNgR7thevRJNXHrULCXXVgAzk6amBdutvdYnJEws+/fnOmwF3z
	CQLjLCewzWJBm20dC3EoEOsFNSjgUxGJwOC7PpsYjtTgIc66NOrZxBS5dzE0rdVW47igRUge1Up
	AdfU40LzCBiui9MhLIrCeWr1dZofzmWhMMP7Vh3+kZIEUcEik1dosvrXkAkbe9ojmt+T1aaCDFW
	AV/3CG7dVjOfn9r0h0T8aILDHQ8jw7y/Gutm0zvHMr+tBz1HLWs5m5hyFwK62f+cYgftYKvoisa
	8w5vM0dIdTAurRaBhZbV9ZDVMykYVtZ9SzbHPLc9MOKlEnaX3HoPZ3wkD4pJZpijU4pRislbzcR
	FXARxTg7OzRDgcow/64wqS5IvQ24A1meJMQH64JZ1J0Ll4+N8t41xQg5eBxbFYd8O/yfRwG2rXk
	TDkParWwpiTUusFf5dye5CTnd6eiQIV8Ep/OH8PalbesWIXkPZVFcIiA==
X-Received: by 2002:a05:7301:1015:b0:30c:4ac0:d0f8 with SMTP id 5a478bee46e88-30eea0d87b3mr370661eec.14.1782798458384;
        Mon, 29 Jun 2026 22:47:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8d36:e610:a260:756f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2cd21bcsm6708185eec.0.2026.06.29.22.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:47:37 -0700 (PDT)
Date: Mon, 29 Jun 2026 22:47:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, 
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: Florian Fuchs <fuchsfl@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: maplemouse - set driver data before registering input
 device
Message-ID: <akNXw45L_8bxD6QV@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Set maple driver data before calling input_register_device() to
ensure that it is available if the device is opened immediately and
the callback is triggered.

Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index c41182766538..0c8f7d1b02aa 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -88,6 +88,8 @@ static int probe_maple_mouse(struct device *dev)
 	mse->dev = input_dev;
 	mse->mdev = mdev;
 
+	maple_set_drvdata(mdev, mse);
+
 	input_set_drvdata(input_dev, mse);
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
 	input_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
@@ -103,12 +105,12 @@ static int probe_maple_mouse(struct device *dev)
 		goto fail_register;
 
 	mdev->driver = mdrv;
-	maple_set_drvdata(mdev, mse);
 
 	return error;
 
 fail_register:
 	input_free_device(input_dev);
+	maple_set_drvdata(mdev, NULL);
 fail_nomem:
 	kfree(mse);
 fail:
-- 
2.55.0.rc0.799.gd6f94ed593-goog


-- 
Dmitry
