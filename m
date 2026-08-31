Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE9378D94
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204482; cv=none; b=DPYve+qqxo/qZHxXYcCk4EUjdqCAawETAvXs+of/dG/LugfTy12cd9Ws11S+SInNrsrp2NPB/dR/xtMoScjc9jIDkA705KE4USXg9AgYyKM0OOlMhK3gKD9VHzwqKBJbFiGYmRvkaco4+L+sGJCJFUO1rrGqf8CFAkFQ24lvpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204482; c=relaxed/simple;
	bh=xF4vDxhZsiTA4r2A8/vCm1EiUkqmg5AbA5+SGktjuhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKXRGU235FGQSuWhjkpbm1HA56rR9p9z/pCAMjUcumlx8FPIs9bsOJccWxmSK9q7zCX3Bqbu2sj4mw3DW8K5VFl5sqOg/ek2L+uHDCWeOnbAF+f13ZltclRE68xt1GoLUYylu23T08uEmneZMOvUWU3JCS8xgAGQAnLYR3zff1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHdbXuLj; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHdbXuLj"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97bf90f4b41so1848281241.2
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788204479; x=1788809279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0rSuKTGURsC+BjATOKT6I6iefn9uhHjm15dQZzDRO74=;
        b=JHdbXuLjs/uvzE0KKURgJQtzVvjb0QIrI06ntbD2DqYHJpBdJC3I0V6dVpAvgQZeL7
         K9QGL/WhMygN+0AatxaAzPRRwEFEe0xuYpeXC5Dg6mRcfdYxj94wCJEcEaUbzH5NTrFW
         plTfz992Ry0isMW8lFWRiwcBCOmznyUutaWUXs8iEUIhcq6SzZqdupmo5RBLFJEcoJT3
         GB75C4P8maHiAx8mNL4C5MvDneo1Sjcdm+/zPMqq51TYzjuHsjLdLraF3LFrub7OvRpv
         ufPJUbEmjPA/hL4Ig1lC/O11+MtqdQ0geiuywzkhFV0wLo1abkIsl1cvrKwalP8crMmt
         SR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788204479; x=1788809279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rSuKTGURsC+BjATOKT6I6iefn9uhHjm15dQZzDRO74=;
        b=AOcW58RqlQBpm074qv0EzhIxhCoNN0DxWQ0pgQHGVMIdiV8/yNQal2lyW2FLP4wuGM
         kBCyvJuGANGPoeciDvdeDYEGH2mwaAvDfFoIM82QNEgdEmq1851YGKQx7UbzwZyCLh8p
         UxphYSzvYIg7Rq1jTF2xDPJJygVMY4gP7sIyIEeOgaxeuNyShu/gjftuUAb0yOEuMYBm
         U+TfQPb0D60gVIUZoi2wtknl36iLzGKCfjiD0gLhUgmupS6Yc2/LuO49Dk0/6kH+4y5+
         4qZdzSxDSgweDhTrSTyLhgB8KvIzyhkTH+nJPMSlAacbAyv3lRgSHyivNVhacckuN4PH
         puJA==
X-Gm-Message-State: AFuF++kVxZ0J38yEE5SdPR/nzq3dEQfsEUkR/PT2GL4s9zosGB8GFUsl
	x5JFHTDa+KdrNN/bqS03RygY+FQ58VN27wFK/hx0NwhSlsBy0adZXqHZ
X-Gm-Gg: AR+sD11wMz0LrPbCItV7yOJEPXXEIshzutaR3Gb3xhQAOCEy2oNHHE1sC/LnSiElDnI
	xTd+eObnKtU2htMPGYAg86PCgQiL9YtcnWeOPatSw7Io/EILjcQjcUL+gkC0ApwbsrJ7dOW7ZjI
	s9dBIMCrdsaFRibVfqDQub7Sxnu17lmzvSdi5icY8PxGew4axzOP3PgP6NWjetRqXig4KG8+AtK
	DpG8eNqEyYYU6OU4acmbvZwF8RI2LASZLZJzb7o1QhXXVugPeDO6dixSqMkySJu5sEPfE5/Pquf
	7vDx9Uw2gh9pxaAlGVDllqHl+p2cXYyw5Al/DX0LqWoJG4YUTrNZA/sJB3QCSFhSbttDb28T7cu
	xWVhossYMUELIukn1+F/ObLGXx1hhYUN3MlXOnApxHMNRtoyFTW+KGFntzyUNRstMZXU1osdeHl
	aRPKEAA6gGHnh78nffhweaWYZnVNC1+uXeajU9cPl/Y27EB/mnswUtXw==
X-Received: by 2002:a05:6102:f0e:b0:785:10ea:be93 with SMTP id ada2fe7eead31-78597c00625mr11953348137.4.1788204479427;
        Mon, 31 Aug 2026 12:27:59 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f247e397sm7359428137.0.2026.08.31.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:27:58 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v2 1/2] Input: evdev: propagate EVIOCSFF copy errors correctly
Date: Mon, 31 Aug 2026 16:27:51 -0300
Message-ID: <20260831192752.258550-2-ivanrwcm25@gmail.com>
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

Return the error from input_ff_effect_from_user() instead of always
mapping failures to -EFAULT, so wrong buffer sizes surface as -EINVAL.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/input/evdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 3a718d600006..27bcf4f099be 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1180,8 +1180,9 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 		return str_to_user(dev->uniq, size, p);
 
 	case EVIOC_MASK_SIZE(EVIOCSFF):
-		if (input_ff_effect_from_user(p, size, &effect))
-			return -EFAULT;
+		error = input_ff_effect_from_user(p, size, &effect);
+		if (error)
+			return error;
 
 		error = input_ff_upload(dev, &effect, file);
 		if (error)
-- 
2.43.0

