Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638046D0A9
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189754; cv=none; b=BCc1WSxzyWNqAAD/G8wm99quINsB+NHyGqFBt2jyOwzfubt+OK7la0endhZ1MdLvGJuMRZbuau2Xtmwth1LBBGdKqaCpTF44IO64Tb9zfwdbSH8tkbO36/r5stUs1+uVlzx8InIor7kfKpCIgSuwuiyMz5WWdrtWFoBGwvHaDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189754; c=relaxed/simple;
	bh=xF4vDxhZsiTA4r2A8/vCm1EiUkqmg5AbA5+SGktjuhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PG5SOhEPOQRdF4fmlMWMrZ5G/fmtRniIUMGMOAetFDg0oBJlUG7tdo/p5NBa+Q3UwSjpCysquLnIand0FihYn1+Jr/SZWsXziKiI/KClZJ/6VrO0AKjafR1czXBLYZ9MfwRORRZ3KU1h3SRTzn02xgXy0SU1/DxgJrW94nk7Smo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVC7eJ0K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVC7eJ0K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so26768315e9.2
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189751; x=1788794551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0rSuKTGURsC+BjATOKT6I6iefn9uhHjm15dQZzDRO74=;
        b=TVC7eJ0K0D1sriZ9t62OwxLOetT5Oz50xrZW0yBKOFXQ4ISRb4BvNH75Yea+/f95aP
         UnUwht9BaogaVQKG6X20c2gQUgN5wE86ei0ap+iHCG3WBs00SUS7ZZBXmCcMEPdx0pCX
         FjCb9znoknMbRulscor/RsYe7pP7ETuWHA0bacgowTE5sTZjqWf38rPo2U0x5v3McycJ
         TRKM9woWjRQR5oCj5pKQr25Cc0kwI3P77eTje6MaH6h+C0cfrWeXPhUkMGNzDJDEqMQy
         8rvfCo4WM50op4Jdmr3l62+Ii6U+e4xkvyfm6Y+/fqbPy3QI5cqqh1l3HWBYf73SukSb
         XaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189751; x=1788794551;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rSuKTGURsC+BjATOKT6I6iefn9uhHjm15dQZzDRO74=;
        b=gA9CaRHtMYglRy5gcaaMez9vM/I+wDUB6nHIJY05kqDLSBCJbzUUtIw87tMwCdSdtp
         pgLQWEnCjcZsJGw/xL0HZr0bduw46u7yFH7URl8YagoTBrLZHmFhYMgtwx6Uadn1pgQl
         bayj/zv3nO0h4Hrn1x6YPbFaRb2Tt5mjGDXGBlkIchMvffHHqEDizSWt7exIQLbWCbx8
         +sAcbeMLKM8Omit0tj7Dhp/HDOwTxjdIJ2uiYA9z5zDAgBNjOgIQzWtATId74N1tTTwu
         KF6WmNlKArPzOkaxg7JjwYTeC4lIzdiSOD/5EytpHOfjnb0Xi0K4iaqtzzaRXJoG6axz
         FWXQ==
X-Gm-Message-State: AFuF++lrbcoCrZEvcZZEWmlCz3YtNfFV87OJw21c/bdaQ1dpJHpZHCc5
	+UXlN+CoIdprxoE5/iRYkTwIfCpjL7f4fC3JnOLqVcCxM3fvQgbkAOkP
X-Gm-Gg: AR+sD139X5jAvrlp7tAofgUiinY3TbWoWZiEr/sES/uwbBkp51QwEeITkN3/t7ML9Gm
	bbsCn3lywMDdgv6ysqO8ZTCku0uAdnETbvYvCRYOXdyi+H1rE8Syo6tTBY30NwwxDdMLprBF+Sw
	KTRmXj7QRsXrXtdXq5xbupBADjPf41fp1CvffkmH5BeWoTS9FqgAX88GL1+wJ+KpLII3zFWOYqf
	ZOLDIEoAVx3As36BGLIb8jEtKY0JbCBSr6LWvZQffdRIuGilMIN1M7RhuLPnxWQFYsfYA10atg9
	bY3Yr9QXuCZ3IwQMHUyuwmtMjhhmWuql+pjuA4dT7stAOb5z/3S2EScjFb0P8P9Qpn6bjFOtwK4
	APQ0DE1M/b1hpauSLHa1/oISau7rXfBovnF6Hs6qUXcVKu2id4PR5RXMPHWtfdDGAbK8CjUUV8Z
	c6l+O/6TeHkluvt/g3HqoagOsfIKYCf+cy1Z/DdbagXpmF1L5Fb+CGzaAMbdHWBw0a6TNKzv5an
	7KndxrvAwXgSeGweUiOWBqR
X-Received: by 2002:a05:600c:c113:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-49cdc435d58mr25770285e9.9.1788189751203;
        Mon, 31 Aug 2026 08:22:31 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm17342585f8f.19.2026.08.31.08.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:22:29 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 1/2] Input: evdev: propagate EVIOCSFF copy errors correctly
Date: Mon, 31 Aug 2026 12:21:55 -0300
Message-ID: <20260831152156.166514-2-ivanrwcm25@gmail.com>
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

