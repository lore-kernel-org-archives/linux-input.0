Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199847;
	b=R1r1dX6sO+I7Vdkbp4Mt8lFhoxeVph/B1dN61pvhRCsNabxOuPspuFo+Uli7Hh/aMB53
	 slWRl1TsviRUPynhGap+t/ZPEN3hzW+x85dcQBUEaAxYGNIc+dGSd6EgGtrvBhT+N1aLi
	 84/aBl/pQoCQ8OXtn9aeRQH1w+gQLSzslf9h6XTXQp3YqYQJCfaDkikHzF9MHzq0uqSz7
	 IOugsLwWEgft6APePNyeHYll1lQ7enSbwMryXZzJ5SlokRMg8mmyGFjrgicBjWpvNr88J
	 vcD6rgn3A9Nc++uWZIo/1wVVgTKiHkhUd+fJNN5CVcoHzva5M1X52Bm+b46g1VJPDgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4kjgCSLosXq/SLvCwDVJ+pxPOiRFESJ6Fwr6qQ2Iw0U=;
	b=UuMT0v7tqwxfvb7jXgVkzEh8XfT+DDi5GOfBh6SZ3a48+qLfZnx04+Vyv3qX4YGfo1dc
	 75m15puVh4HdWUOA/ZM4KIJaH8Wh3LBaOz36mrcA1VDRr3xGOwp0+Qy6EQ8I+G28Emqx7
	 t2vTHKLOUQWMnoygwk5shQAiasa8nXwPhuxLvvuA3PvcyZJ2pVk0wwxTE1O1yh5N0AOQi
	 2bE91vS0EpbIXUtJD7Wry7mJKlyY3ZMu+4JclVrxg0Bp5s48BU7U+jzLNH0DljSGKo+H4
	 ifSHf2KDilRJoBEgxtcVoHY05bfa4VgMGQJwA0AZBrzJUrI871r7Wo33f4sjUiqYYhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXbwKFNt;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F3606A322
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 15:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A9F3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bXbwKFNt
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso9881805e9.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793199845; x=1793804645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kjgCSLosXq/SLvCwDVJ+pxPOiRFESJ6Fwr6qQ2Iw0U=;
        b=bXbwKFNt+U6tJ6iAZmYjP4JiGxbGg+dtYAdC3ZStzFIwyNbrd2NALJBOPl6EEJF66X
         bQzB7kUc+hZY8ChlVQNhwoFkLUgq1XW0SFu+/jUfsmCreAp9oY59Kul+1rXuO8OpKcRG
         o2jYK9sWVAeI2rCZmkwpsqtjsBv6tRq1CsKqc5s0jzNWZ2PHj9wIvQ2DSCkgumFmK/mU
         NbExgyJSIFcZ5RpjoVgW4qMcarhn8H8Oa7QcEOEfxgu0GCAcnJiA1/qyEd0Q/xW9/OBV
         vhRwRHGAYJ9Pb3v8sgB5tXkHr7eIBMlFMfin2vgd9LtrsaOcYzETk9sM5WUMKBQSH/Yp
         O2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199845; x=1793804645;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kjgCSLosXq/SLvCwDVJ+pxPOiRFESJ6Fwr6qQ2Iw0U=;
        b=IotkcGZnAuYof+/OX4UnlE4GojlMJcg0IciTU6XJlowWVwe9ydNFyaRBaZcA3Z1FtC
         nFucza3aAu32RFmnMWnaTQuCSg7seEmMWl0Y0gfhxOctjMZ9eDNGwETESasXVJQc+vcN
         h2Lq0SvMyqbT8jegMxHjJ9uT+atkr8jwWOv2o4k2uSKDzrEWU3MUSmUwLmRzJZ7xANif
         uGe8jMytyGgjKIMNg5eQSiWRvgZVYBxlqGbSQaSymo1cXtDj+YCcDFh/edOxcrk3T0VW
         Gao8gnblCdX1ylmSnv9tH35KnrXijlW/iHlP59of38krh8qu33NXLhMrxSpjbOZD3q29
         j5Fw==
X-Gm-Message-State: AFq9FYKY/2yEj9CavjL/jaPreOOOkla6x9vT88gKiYkAgGFm/DUEBoXu
	bue2qSTAUOvOA6m43bAr9cuVTyHOlgD0DrChskjrnSgl85GPq/aMsfgVKd92e2RkG3w=
X-Gm-Gg: AYBFou3wQB/Klt/zY33xae1Tmx1nvJYSJc3O5i/LL62+djY1QIAaUgSEUrajM4LtWyc
	DmZ8ts4xcYZM9Sid9X7gyE49uVKzZ/bxmAKH8jAxexxaPR3Tim6kIGmqLHUIuBrBTvhJYoB+ZQl
	Aw3g+jX9CA4RWSRs37ufrWgyZpyVCd/cUGfT241ebBM4z4nRatK5tSaNr9ErG8Tuw6HIbxEURkc
	fr7cTlCMk6+KTPOwt5tEPebtmtJtm0IScvObhbX0o7sZFijp4dF8ca6L4xrGrhaQsrjsAreuvWh
	7F24ywuG47ykqXyzEF3Wn/kOO/1IXVUAFpXa5DZaIFs7elm56jQ5+wEmFlzSTH6x+fZVLOWtOzU
	hMrF61UCqnzTDzryZ6WYj1K9KRcJCwd/0ZL+nHE+DKvwa3oDP0/NvsZ6njlWl9AXOBwsEJE9bGr
	WCbcbkNXnFUrlfWfyEP5fmfCaK2CNHced503sfXaHi/di/DN/gbLWePrWlgS2tF/aoZ/MEPZYZW
	I2KdXgQwmC2HxweUof4f6+YEZRtqERKyPNMiKyGnMdrCf5nco7awFBLXnoqrKAHPVaVldfqDuZR
	I/jNQYltid33d0Sr/rjj0/TBlpzPhJkB31wvW+JnUECaauJZM5MBQZvVLY5pU9nY7A==
X-Received: by 2002:a05:600c:354a:b0:4a2:74f:46c1 with SMTP id 5b1f17b1804b1-4a96667c86dmr56028895e9.8.1793199845349;
        Wed, 28 Oct 2026 08:04:05 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f5311bdsm62547865e9.5.2026.10.28.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:04:01 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: uinput: document -ERANGE for UI_ABS_SETUP axis codes
Date: Wed, 28 Oct 2026 12:03:46 -0300
Message-ID: <97e5c71542aa8074c6db4d4146d9aab53f0ce04f.1793199818.git.ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831192752.258550-3-ivanrwcm25@gmail.com>
References: <20260831192752.258550-3-ivanrwcm25@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

uinput_abs_setup() returns -ERANGE when the axis code is greater than
ABS_MAX. The UI_ABS_SETUP kernel-doc only listed -EINVAL, -ENOMEM and
-EFAULT, which led to a mistaken attempt to change the errno.

Document -ERANGE instead of changing the long-standing user-visible
return value.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/linux-input/20260831192752.258550-3-ivanrwcm25@gmail.com/
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 include/uapi/linux/uinput.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/uinput.h b/include/uapi/linux/uinput.h
index c9e677e3af1d..4bbb9db1dbad 100644
--- a/include/uapi/linux/uinput.h
+++ b/include/uapi/linux/uinput.h
@@ -127,7 +127,8 @@ struct uinput_abs_setup {
  * old kernel that does not support this ioctl.
  *
  * This ioctl may fail with -EINVAL if it is not supported or if you passed
- * incorrect values, -ENOMEM if the kernel runs out of memory or -EFAULT if the
+ * incorrect values, -ERANGE if the axis code is greater than ABS_MAX,
+ * -ENOMEM if the kernel runs out of memory or -EFAULT if the
  * passed uinput_setup object cannot be read/written.
  * If this call fails, partial data may have already been applied to the
  * internal device.
-- 
2.43.0

