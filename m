Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEB53A881
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189767; cv=none; b=RuCOJ7ErkO5Khqk3G98SEQE7woMYGtIk2n78gVoHyrB6s4TF8shSxEfHV3RBIryaiEiAvr1R0SRbuGD+m4EGT7+9ElYS+7sS24x6VG4x0pFZeJiiBf0gzk+5M5E82KFDBJGOdVwKYgxlq25yAcxZT1wJ7btWfYO4XE2W1KJYAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189767; c=relaxed/simple;
	bh=8uWwuLTbjvbKa5agNuttA+2GRu/EMBc+DbU7hG1WJLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHv1HIyi3f3HNbgmYTFSVVSeb8FmLg+6/bLHATbFhFmtmaDk2r2LY7nxzGpJsxvbDi289yYjmKAFSXaEs6GLGDkVA7GRACjXNWP9dj4IxsIuZC313n3dpYUv2PsaOHrh1feg8JEIiRUINwr/cPtXWjUVGCBWY3lUaXNLiENmhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2+16Cnp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2+16Cnp"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4843750de83so345038f8f.1
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189764; x=1788794564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BNOjgOexwjRZk3IN1bkdWZODfXKgHQbtu+Lx5gdpkPE=;
        b=A2+16Cnp0rK69gIkar0dHYxRH0V3qfCd5H3iMy5X+Odf1eZbxR40B636i3haE84yoF
         hZQmLirpEvl1Jf95ksjER0Fi+zPSkX6w8ssRRJbDRzY7AuApupV0unhENKvay+0Nq1oZ
         tuP6RLTQsoVoTFB8lk68XJUhlJgu595VTvK5CWbmYmrKp8ZzfSFXe8uHO65xuhy6OSLc
         ayTDIPJgR+jGQC492Oxa0oeh2+IMjHeCNSfYbPFYHlaAaqP16lK5+lRuQySu0axKczqP
         xmTKzD2mxQ7iw+NcepLA5dvCl5Yd8vhW7Lez0HF6CxN63Bz6n+IzBSAl2ZBuvVXI7zpF
         yldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189764; x=1788794564;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNOjgOexwjRZk3IN1bkdWZODfXKgHQbtu+Lx5gdpkPE=;
        b=BrnS94wfX6rD2zZfGRAVR/SjbG403JBdu7m5Ukqp+1f2SuUgt8EpHOpyWL/C46tpjk
         6ye16WB2mFAp2OdXHkktlBRSX9C5Oyiq9O1ExHW2v0WdNJfN9RJEVwgzlbxCEI9VBTcn
         8DwNJuO7UPuPyx3+dyVcvgItXl94IlxaiRElpj4naKaVfGPqRlhTE57RtT+zvtxUZRAs
         jtq5s7MhWUatYAfD6lwTI5NDZGFOfG6zyPD0dIIBlCvo0uV0IZ2UKMZCHC69TwrqEAUg
         E0PTXkvLvVLg8DL3IDzLrrr8P3qEKmdU1eOn6MW5JuV8cvbS0T8L482wfVVVuQtm1vMF
         HCeA==
X-Gm-Message-State: AFuF++kNMuXjYgs4TCz0KifaIl18/yyPyp3kojNOPekzIvtcnaBQPZmA
	eFv5WJnOHNhxofoVAzkHlOBOodY9H7ERqHXCkebVNDOcIZhZ+E6cWs9652VBmEZ3eR0=
X-Gm-Gg: AYBFou21KN92hHbS3/RIZgLd54mIqznV3E+me1E5vwplBe9ghNR427FWZrIjLwnw8i+
	Q3rZwHxS8Q2EFynsUSJ1OU+Iyl7pE1KQuWEoaHYdFTb/Oqz8R/twLmqimRpfVJBGIkbHlSAm4aU
	gIdpcOKa7SqvHRSIDd3H3z0o74b9Gc9HafN7sMduW73pLjk/GpgQ87M5Uu8vF4wKIpQ7Gbg0xQn
	58400/cHevdcH+p3AlJ7c6C+Kvxl3KI2I6O25wwlf1Y/Iq3s+w6vE7MCKpjspNNvI/Q0I7ZnFkS
	laXuCLIGOf9NZHPJYFZY/qM96pDnXCeRm78PO6wE1PQVlFmVCihn1De7OH/BbPxGCZQNr/myRgA
	aBCRqPKJr65ouvDNXwPwzu/tf8JhXpK25LgFu8vkJWJ0yebprgw6La/+AER/83mXUrX9Jt0EyML
	XggOaEJbRs77Kca1TY/4OXcLkAnWDfvPr7gW/1cK2AtDAYwyY4BKYKxI/8aWtVK1OB9f6AY6i1Q
	aXxybb8i6PTpP3W4ZYDqjzOmD/+x3n4EU/7
X-Received: by 2002:a05:6000:4305:b0:484:3647:d977 with SMTP id ffacd0b85a97d-484410431f7mr2552640f8f.27.1788189764283;
        Mon, 31 Aug 2026 08:22:44 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484322ce2a6sm17342585f8f.19.2026.08.31.08.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:22:43 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 2/2] Input: uinput: align UI_ABS_SETUP validation with uapi docs
Date: Mon, 31 Aug 2026 12:21:56 -0300
Message-ID: <20260831152156.166514-3-ivanrwcm25@gmail.com>
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

Return -EINVAL for out-of-range axis codes and reject ABS_MT_SLOT
configurations whose minimum is not zero, as documented in uapi.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/input/misc/uinput.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index d32fa4b508fc..e05c80182252 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -424,6 +424,13 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 	min = abs->minimum;
 	max = abs->maximum;
 
+	if (code == ABS_MT_SLOT && min != 0) {
+		printk(KERN_DEBUG
+		       "%s: abs[%02x] minimum must be 0\n",
+		       UINPUT_NAME, code);
+		return -EINVAL;
+	}
+
 	if ((min != 0 || max != 0) && max < min) {
 		printk(KERN_DEBUG
 		       "%s: invalid abs[%02x] min:%d max:%d\n",
@@ -524,7 +531,7 @@ static int uinput_abs_setup(struct uinput_device *udev,
 		return -EFAULT;
 
 	if (setup.code > ABS_MAX)
-		return -ERANGE;
+		return -EINVAL;
 
 	dev = udev->dev;
 
-- 
2.43.0

