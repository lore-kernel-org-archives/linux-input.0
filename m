Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3B486B8F
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052585; cv=none; b=r3uaL5AkVk68ixjmLaJ4ppxyUfdVyqQWGq1B8nEBPzuZBnRLs/VSRPiK96/nHhO8mjK5MM5iM4JimevjAYeNcAF4EKM+jpPZ83lf/OLuR5Cw2f5FdCMwd1+cDtyKlmdAKaS91SPA84FuXpWD8EaYOfc4BmFOr0/+7eQmLRpZq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052585; c=relaxed/simple;
	bh=WEKZGkYMhuG/QcBWeOHNGGmyyaOuLvtBMV1p25iWac0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ1kfV2ulCQmAA1pNtcwuclbH9fS7Hu1/C327osmvCQdPm3rAowGFx3FI7v/Ybv4gJJ35rJnJ2CfSuMGUESAltlvMiiRBpdTH+kRhveakBF8ENJHWy5FgwErU9wMa7DUo5SSJ2PhzInybSSXDh0XsBB3XBn5tgSnzRKeJXQntfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlPadE8Z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlPadE8Z"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso4762495e9.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789052582; x=1789657382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hVkpNvpROCLLMNLfxrQVSfYLWvaKflKzjcbar59UihU=;
        b=ZlPadE8ZbPrHqU+UpuKfaKeQMl18fpsjbiiT5NLdW6yERa0nDRr7vKqETDkcHvMWDK
         gIhLZaiRGQVXVr5wHYYvb8cEQqa0rly2MH+OfqXYxxIu5LzpGp2pBdIAh+FA5mLTG2Ui
         l5+F2wdlr7ZIvHiLj5+wJcnTOFqIXnhD//QWk4bL6b+8ERnn4Fuf08/krI5hwEL1vyrH
         WVW+D8CPxlIxICf6SpmiLfOCVIgX20w2aIfUAId12PoUx/cz6Ku/rrpAvU06i14bOcBC
         U/2w6rCTk67krFes3A0Lir7o+9WQYCdhq3lkmXRZFQpGi5cu6Y1eQg03Aq1bD9xJQSJz
         HA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789052582; x=1789657382;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVkpNvpROCLLMNLfxrQVSfYLWvaKflKzjcbar59UihU=;
        b=KQp5bWybnuFOJsrnuo7sU9KQ5AmrgqH66/aqLPiH49QPqNkfKnSEV5xC1bjjTJN0LM
         UFOcoidyUWV6ZvaxhALLpwVzrD7pvI5sGuJT0n8Sc/cO2JyZbeHCos9+YMb52Uh/kWCx
         ijo8lfNGIjAVZmoTaZs7qxX4oz7GU1JpTp0whlG4HBAVQGdujDR9Zf2AFy34vQEPxVs3
         F02cJfCoYoiKSs0inL8z1AeFcWjELadK0hMYMijv7PoeeXGXsZVSGyu1Il+xHLuxfKF3
         sn7dXYIarkrVoeC3RCxFefHj7IQWWeWue7MCpWVPLNH4Q7CjsJjb9yEJU13o+0xeLEwc
         z57Q==
X-Gm-Message-State: AFuF++kds5m+zay6f5iihZiV/olvVRy1RyCnMzrzi3px9OLp4CDxBWm7
	PwATYJFiTxlGoc9XSooREyfUF0d2XpkbQdcL+dJrLsyOHKpO8VDJk+gQ
X-Gm-Gg: AYBFou0pdAPfEekRqYhwNa/5Q4vxwEAafBReL+DEH4C8Rs0DTVo8xl5Jkozb2ai2QpR
	YKbcJlkXaiD++ybiElR4KiDdG7M2HxLALRY98GYh/8068Fy9Sb3QFlUd7WfNbubPGKAAAqVdIOh
	29Mmmz077O7hsPgE+vna7bSlVNxIV0llyQdM+m7ts7UfPDPf8hJRYMcH4libyLjkE94NeIHnzj9
	wPne9nTnBIuT0QyUTQAvB7EsOdo0MiFLcjG8dDbeRa4+Hr6+Ay2ih1NYiWus0IFwcnaVDUCmWQb
	AgUR1sc9CZXlM+2mdpC6mxG6Z/TXrZ/vXevLKDuZ8jHsqb+wwME8aafCj8xRfF4xGWkv4VxAqz2
	bvwVLxYC5EbYV4J6UCrif8zxW7+CDZ8wo72G4YbLUcPDaUlPHwAMQm3ToTmBFzCgu/INjSM/bG0
	a24wRLBMIUVkoQJVb4+BRDS1Vdzm/p2Yh68r7F0KL0mEvIEOnxVdMJDYxrPm+wujId1pShAHAYb
	g7koFWTCb/OkOeEVTBaTvIZd/XUnc4joiInhg==
X-Received: by 2002:a05:600c:3584:b0:49c:ff66:7d88 with SMTP id 5b1f17b1804b1-49d26d7f8a2mr74899235e9.7.1789052581389;
        Thu, 10 Sep 2026 08:03:01 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-70-91.net.vodafone.it. [31.26.70.91])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm85162185e9.15.2026.09.10.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:03:00 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] HID: Lenovo Yoga Slim 7x Gen 11 keyboard fixes
Date: Thu, 10 Sep 2026 17:02:49 +0200
Message-ID: <178905256920.12856.4223144289618356245@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908111812.43837-1-okerixx@gmail.com>
References: <20260908111812.43837-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is superseded by an identical resend I posted this morning after
losing track of this one:

  https://lore.kernel.org/all/20260910063051.4556-1-okerixx@gmail.com/

Same code; sorry for the noise.

pw-bot: superseded
