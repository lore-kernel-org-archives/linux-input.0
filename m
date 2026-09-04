Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48446EF6A
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520765; cv=none; b=FH9hV4dshgoLLQ2FcnLrlufWQvKwW/xja5EMVh5Ye6aSQucXXyjsSgde2O43d7jc1KeHvZ5nXeEC/lCI09YiPfYE1RGdkj8fW+YpyHisfa7swNh1Mb0ezUnO9Ca18sVH1+xC2k/cCVw3daArHa9HcDcOExbs5NKAZfaVvOgecUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520765; c=relaxed/simple;
	bh=B/y2Mw7A6/bFmMUH3pc1OZgqSvoNPfBN5iK3touTpPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmxc2b+uStT0t2D2DIAlbLGe9PGm/dpYsYRc3AfAhk28TZotBLQkESLVUpNiGX7km00qTBrpWqOuahWd57yoeG1D7V6vwFGk+bRxSl/37ED9p2cqd9DC8caY17q19YY7tfk2XcBcqH3UrQ87LGyG6WatjzLnF1GfkF+ZxK6ICtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBmoeYDI; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBmoeYDI"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1b881a8e9so341618eaf.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520762; x=1789125562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P73s6aLu8k3XruFSDI05GxMhH8qbnt+DqPfiaMUnLfk=;
        b=oBmoeYDI2DPO/G8Zy/UoiHuDQd9wNhJuYzKWCyXsxvzbNZSIVtkMbFVMVoPElC9tVU
         zj21vCeF2lvWlQzZzG0p86TOzOiz+AznQ90H06Kmza9Z/twh4eMYCve9xxdXC1w6uH27
         sIo6eqQvvTFh5H2VU+fF8ImiqOvwWlJ1WOxcMvGoeA/L7acDOFx8uD/c7NGn1DOBvUfV
         xg2LNQfQ+SYl1jaPYdF/5nPYqPwC9YZ20rBRHA8HDWOdZO3hOvPOChGSripmYdsbeN/u
         35HxwYxKjYyDfHMuEJXAEoyFdmmVRLTSUV2w8IwKsffT+TY3s2nLVP+8+eU6Xa51JGEW
         LoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520762; x=1789125562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P73s6aLu8k3XruFSDI05GxMhH8qbnt+DqPfiaMUnLfk=;
        b=aEOUclOKLRHZWxy8viqeh2GWC+BhoE+N59jK5ptjgeSun7pQXhxelPuWaCXyfK1xnr
         z5XpDwhBwfhhdaT4DpB1XU1ZTmq7mYLb9Rvap6fnhuEXXDajxyKkjUv1E2K1aahD8C/G
         ArZ1/EMTcVhJ94T9nY0TYNtrxcih/ULokA1ZajPE0+7OuxGod7HyCUH7zvJLXIuMWIJH
         noqoHguo74Aps1ecjOt0iCo/I0ZXTcIIuDFFV1X3z8usMnKuGaMosLeNoBX8OtPsJHdJ
         JqZnOHKSnt1MAep38p2GBEwhHbk0eIr5SjgCPEx3XcUMQnV3JPw8IOqtcPPTvE3O78Tk
         /QkQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4ZhEz+kaK+OMUcXYkH2X7QdJf11XA3NGcAWBrxMMzHrET1qPs5AIN/zcGp8sJNoZVqYk4HLWDcDIJNw==@vger.kernel.org
X-Gm-Message-State: AFuF++m1FH90U541J/8A8hfe3+Zjaq7nm/FxwtBvO4IBz3VCrz2jMMR8
	+kpSnjEGD+thpI54CMFVe8ColDq4cqBTuDfpxyK/MYDvl0PhKJHqm4nsWkgDLQ1bSZ4=
X-Gm-Gg: AYBFou2IZQm1cRk3rHmHMC7tzi7XixMkcav5ovO4PFxzD9A1K7hJ4FHN/hPCftsuIq9
	Y5TBNWn/ceGpABs3subnKA5PMQ9brB0/iZUYPCtSENUKpfFmlBT2xa7ZXe80ZmU43U73GF/rw+A
	//lYVX8lDBfYww05EA48nyAHn5aIVLGb6t7UEr9CS2Yu9dlXsBqxbcyug+hnINjQDjynsaZyJcg
	TDimcLfpaXMQzSQStN/T4VyTsqvB5WfhASVmjNsY0B6ZCuD2mIh2JBA0xoTbcDbn2EM7pgw2ZH9
	5h35wusbJmGrcIGhBxVl0XRhQebZtXtTQecWp1DqWr7x0uGZzVcS8YqHZnf1c0Yea8yFWMkYZhJ
	hP5VqPsB6SzlyYB15QArqPrWQL093B/3KGEvBtMi++0iRIh+WGgjRiQqb+PSD072of/pO3OB8V/
	9XVLh5A0zrdWGxTgEwipQjjLUnfZrrGMEJwCmawQYb/TtDBGamBQfVBf0vQqhEALn+LWVxlXTPc
	8hXVT0emvGDzZ8=
X-Received: by 2002:a05:6820:217:b0:6b7:8396:f3d2 with SMTP id 006d021491bc7-6b78396f8a2mr1276910eaf.52.1788520762568;
        Fri, 04 Sep 2026 04:19:22 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befdefcsm5190103eec.29.2026.09.04.04.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:19:22 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 2/2] input: fix repeated words in comments
Date: Fri,  4 Sep 2026 16:49:08 +0530
Message-ID: <20260904111911.32224-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904111911.32224-1-hemanth.selam@gmail.com>
References: <20260904111911.32224-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/input/mouse/cyapa.c  | 2 +-
 drivers/input/serio/q40kbd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 47000c30e4d8..96b79796864a 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1322,7 +1322,7 @@ static int cyapa_probe(struct i2c_client *client)
 
 	/*
 	 * Register the device in the input subsystem when it's operational.
-	 * Otherwise, keep in this driver, so it can be be recovered or updated
+	 * Otherwise, keep in this driver, so it can be recovered or updated
 	 * through the sysfs mode and update_fw interfaces by user or apps.
 	 */
 	if (cyapa->operational) {
diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 2f553efbe649..7ab4db61e46f 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -72,7 +72,7 @@ static void q40kbd_stop(void)
 
 /*
  * q40kbd_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and enables in in the chip.
+ * It allocates the interrupt and enables in the chip.
  */
 
 static int q40kbd_open(struct serio *port)
-- 
2.48.1

