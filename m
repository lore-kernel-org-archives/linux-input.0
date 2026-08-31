Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6537C10C
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204485; cv=none; b=s4DlxUyfHfY5XW/M4ZrtFnqdddZr8Lwr3Nynhhl2X/sp9SAjM8sy+isA18dCc7b078tXn2JYfbfqDosN+pbs9aXN1F+o9IZ9LMOIcQsdZnD+w9RMPbz0OBNsLVWRiedSx9osfDQYqcbx5eInsaASkQz3D8WODY6yRMzxub00i2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204485; c=relaxed/simple;
	bh=NnEQOnZj4BFAWotZoJ9Pa2KYzLkhMswxt53AVdkVHVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYn/4E8cMvjthKEDhYeF3nnKwEh3OAWgB7ujw7GgN0Il8cv+khcU6fQCnZMgWYVxcYyAO/kmUFc/P0Z1DnjpEWgZPXRstZMyymViY5Ns0ZlbUUDylT7vVcs0APzW6xoG5C/pRB5dBEGoYHXVYC8rN8BNM4BCZiC8JVUoPQLOU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfsGlr9a; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfsGlr9a"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-783fffcfb96so13832137.0
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788204481; x=1788809281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EN7H2mlXyqcLAf7M2EYDutGVS5enJP1kVnOii3DYdIE=;
        b=CfsGlr9awmPj6BOaUxb8t4d1xyG2siLpKbOxQV/JGjbPbuuTMQUonX6bHCpcMKzIfK
         +FqVIQNeiHsrBgzDOHt8fcJpJZYZHco0hOg6IUr7VEnygMlWrH0cV5FpO9qJ7ErIYNPf
         yQI0V2F6upz/9KGfLl/5x29nC0b7RpJNiYBo6k33p5kBLP8/5Xd8nk2HDLU6G7WGQ0dp
         QTQUgJ5GVhdx5WLcEImCF20czmcmysHBN2yrMQWK6FcnOCJdKoPmlTX3cDa548GR9ELW
         TdKGLHsEWFf7kpaVwHUbsXwMJ647OfODMCLNi9mII+dK0mIi9R+5x9QIGGzRVda+ja6r
         DtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788204481; x=1788809281;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EN7H2mlXyqcLAf7M2EYDutGVS5enJP1kVnOii3DYdIE=;
        b=ebZWgpm5/S40u8V7e3GCcV7PQHr3sdHIXM6HGiPra/eKPvSVTj7KZnXQOi3e3gckWO
         nrPOwT7hiFxUqTVhTE+RsG+YkQ67W5h97mTd1GeS1TvK3S/hHrWyTeBD5OPAI1/4tzpu
         GuhLzIExDkdRYg+wTzeCiz151k3K2OMSeKKdj/HH9DingdaCb3xhC/CpdIPoknteskvz
         qiIiH/W6ALpjvFtXV96rfPQUY9l+1YcR8nVCe7nzT4Q6YOOi7TENuwoasszkPo9U0VjQ
         KOA/lbrQFAfgjI/RE/sy2Hxl/q0jCkFr7aUcBNcu3dKoWNbv3ByKa3ky8mEF8WeWWiPy
         OHLg==
X-Gm-Message-State: AFuF++l0ORQqa1Zs/qWoqi2ZDt9TqOEI5PuAaeOz+WYfSnWRaCnnJr1k
	jO+oJuZK+4cZUG+CcqcF5aBHoxTXImrrw/Yiq77eNY57GDMaSKf3M4GB
X-Gm-Gg: AR+sD13kU1iLG+JvLP7OK5UYUWAXwbPUZiCEANV8NfKGeO/gLZx9KmnEtvrLxgN6CKJ
	OHWTm153hnxRMScAsLAkjNgxe66azdnLhJNWcBklNx9yYutcU27oGYf2JE9COmRAv7eG+PScsDP
	j7UlFXYz96q9LKuV3s27LHDDpvKGO/lEnMqrKdJ8P1oWIJkCezgoa96/WDVuoc0bvLJuJyLbF41
	EAoBMf1cKeTGhseJTXGbPcJKtmFRdCyAft9dkg3OouqGerHqE8pEt5lOeFGkEsVVYHXos9raCYV
	tve0HSvofrqDiXDjEfRQmTvbHMuWQxYBSi+qSXS17K7cy9ELcBa0kIJSJJwIsB6zKhCnvz+jpIr
	i8YnxJCedxi9BoFA98Ejw/dMSVkiMwkCHZ7epMf5zOGefb8MBhjcIHTO6h8r8Vv72inD+XzdWX7
	HMDe8ihLXYEXDo5J6jSf2nNLPK8VT46RhpAL/0VlTUx0LefhoMcV4+x/JNLszXbwBG
X-Received: by 2002:a05:6102:c10:b0:77b:28c1:210e with SMTP id ada2fe7eead31-785967c8f7emr10293783137.1.1788204481486;
        Mon, 31 Aug 2026 12:28:01 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f247e397sm7359428137.0.2026.08.31.12.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:28:01 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v2 2/2] Input: uinput: return -EINVAL for out-of-range UI_ABS_SETUP axis code
Date: Mon, 31 Aug 2026 16:27:52 -0300
Message-ID: <20260831192752.258550-3-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831152156.166514-1-ivanrwcm25@gmail.com>
References: <20260831152156.166514-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

uinput_abs_setup() rejects an axis code above ABS_MAX with -ERANGE, but
the UI_ABS_SETUP documentation in include/uapi/linux/uinput.h states the
ioctl may only fail with -EINVAL, -ENOMEM or -EFAULT. An out-of-range
code is exactly the "incorrect values" case described there, and every
other validation failure in this path already returns -EINVAL.

Return -EINVAL so the code matches its documented uapi contract.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/input/misc/uinput.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index d32fa4b508fc..7d6266c2bd84 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -524,7 +524,7 @@ static int uinput_abs_setup(struct uinput_device *udev,
 		return -EFAULT;
 
 	if (setup.code > ABS_MAX)
-		return -ERANGE;
+		return -EINVAL;
 
 	dev = udev->dev;
 
-- 
2.43.0

