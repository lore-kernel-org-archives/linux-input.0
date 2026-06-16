Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837433B2FC7
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781583383; cv=none; b=u6a3Mn6ehgPT4ugjdr1JKljCreyW8oy1RbZlwx4RaxnTSGHNmuZctAY7FeWUBnZGNPD3CUYoZZQw1PfUOEYZNC1MgSgkkpEoeWJhBo1EUqb8rQjq0Pwt91vTbwPS4WiNFN524EComn8ZuwBfjIII9GF75c0dCNPOlGUzZqjxJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781583383; c=relaxed/simple;
	bh=zgVrxfsr6Lw9AkBCvthWB97K2H45BrWBfyjksXlWRGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F88vzn4hAPxTw28s72MYXheowELkMmquPB4MT06TgghpxK20PiMUXmDCOgRKU+fWcChSHmOFH7DBmAVD1Ob/qLP61XK+2tCyPsfHGZIsfFs/e7BfM0BeqXtBXn/lZX2MTD9jVuHcbmCVaumH7xaltZlfRL3K369vSAhV9mRZLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kll33fkt; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kll33fkt"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-307d0405e07so6204476eec.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 21:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781583382; x=1782188182; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3em1q6OKNvAsDlZXNz19YR3IMd5ID+hx5lZcJKwh4oM=;
        b=Kll33fkt6DZGXMD9oJKUbHx4vMJB+MzjVDq9MDkmEw3dNgG4mzHo0RZthjTLI/0koq
         M5+e0RZo7PqYOxNA0XOaArM72CS24LFDt6FMGt9yF6kVfjS27WM5QpZ52Y2K4Uic1vOZ
         xQ8mO257g0Glvmd03lHNI+ybYzVVpgBLIkgaYs3DZ4N/HSKsGnt1p4c/bHDyX5ULp24Y
         caAUhxJyeRxNN4BHTyRtMqSEgTvfpBvbFOarZTD2GacMWP1Hk26SRMbeZSnrVyRzZCS0
         cZZocOiSIrU4QjppyNKD+g7S755iWUvHiwP3WyVFjz/jNN43EeL1ATf3DU3UGpkyhKCU
         tcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781583382; x=1782188182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3em1q6OKNvAsDlZXNz19YR3IMd5ID+hx5lZcJKwh4oM=;
        b=JhwtdL8y+fVb7vPV1cBxKhfP4UYTkSEXID15GwWSzzl78Rsh/8OocOme7AotIEAnQO
         +2iPNa2CUdZHRfd/zOZB1YvSZ3hviOrIJ3y37O8lsdg61TYUtR/LbfM2aGvxM1X+hivq
         Src/MTYFR3KXGM+HLHuvhgWMDkeVZFnoooJRMWKJ+VBkrsvy17v3gZUxctcdpNcMniCC
         0teO8HTZH/VauwD08O1KuW9ejGnRKPCw8SFfmT/sqnkcf85YmCwdiUibFyIJdUxV+/Fk
         VGd1EAesYzTDMj6xbV2EtQ5AV5ixEcniuwjJOfzdZ/hQmBYY1g2tofLZf67g3s5YGGbh
         sqzg==
X-Gm-Message-State: AOJu0Yy2Y++Fix4WcK7hvryFDYAzjZwHyq54lHcMHGaDjJRdguuVmE4r
	GxDtE+C0K+UWp9rXPIV+1IWRlmO7JRCnDqWxDcqMADQn6U73zvNXwXXh
X-Gm-Gg: Acq92OGE+dcapqyFvZyUzEaMW3bDQocDZGIG99end1wj8LvvUQ5lc16Uwut3zdXWgLS
	b7srPJfc3a/dVpmH0AZ0fYtQViPFhBBqdgTexwAcSmUUz6oT4U4inYBU81x6unaRaL19b/NBFI0
	obNHqJlJffSFn6qTLZ+pwLj6rzA6hU5BA5VHLT5pafS/tMQ1ycMuJml8z0RW/l+BblxxJASK6lW
	uaptkESSHu+zZ0jd6+Nl5rqtvX681GAIS/BWqyR4mPgtqeaP8zvs5QUfbeuVIMzPwWr4HKnLGG5
	6qUontZ0Yk5PQsjpxwIcD4JaBOYDYd82SFdxrHxj9zrpwppN2M06UnE6koc0WFyKZdLmB24RV2i
	K5S9v5GTs3kPM6GOUoQj4V0N4CTh/MHAoqrk1YtwCpm/+CakP1KOzfxIztbM8uOkqiBzgjg2O2q
	Z53xEFyN7Yjx8C2UKnNWSQWuJu0Xz9xOtnUBshq81PJhwkGQPuNTjVQMaKgpSg8qZX
X-Received: by 2002:a05:7300:730c:b0:2ea:4228:ab11 with SMTP id 5a478bee46e88-30935239ec2mr7746477eec.3.1781583381482;
        Mon, 15 Jun 2026 21:16:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e92096esm17817625eec.15.2026.06.15.21.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:16:20 -0700 (PDT)
Date: Mon, 15 Jun 2026 21:16:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v5 2/2] Input: isa1200 - new driver for Imagis ISA1200
Message-ID: <ajDEsU8oZWT7KB9d@google.com>
References: <20260512102445.55372-1-clamor95@gmail.com>
 <20260512102445.55372-3-clamor95@gmail.com>
 <CAPVz0n3Dw6Vtqqn8if=MYkBbYittXqsBKbDvrs1ntbD5Zn6iig@mail.gmail.com>
 <CAPVz0n3iCSeT3xJ2XkwZ6PYofwSLkc0gfm+iYo4xbKBkAtihcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3iCSeT3xJ2XkwZ6PYofwSLkc0gfm+iYo4xbKBkAtihcQ@mail.gmail.com>

Hi Svyatoslav,

On Mon, Jun 15, 2026 at 09:19:27AM +0300, Svyatoslav Ryhel wrote:
> чт, 28 трав. 2026 р. о 08:38 Svyatoslav Ryhel <clamor95@gmail.com> пише:
> >
> > вт, 12 трав. 2026 р. о 13:24 Svyatoslav Ryhel <clamor95@gmail.com> пише:
> > >
> > > From: Linus Walleij <linusw@kernel.org>
> > >
> > > The ISA1200 is a haptic feedback unit from Imagis Technology using two
> > > motors for haptic feedback in mobile phones. Used in many mobile devices
> > > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
> > > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> > >
> > > The exact datasheet for the ISA1200 is not available; all data was modeled
> > > based on available downstream kernel sources for various devices and
> > > fragments of information scattered across the internet.
> > >
> > > Tested-by: Linus Walleij <linusw@kernel.org> # GT-I9070 Janice
> > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/input/misc/Kconfig   |  12 +
> > >  drivers/input/misc/Makefile  |   1 +
> > >  drivers/input/misc/isa1200.c | 524 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 537 insertions(+)
> > >  create mode 100644 drivers/input/misc/isa1200.c
> > >
> >
> > Hello Dmitry! Do I need to make any further adjustments to this driver?
> 
> Hello Dmitry! Do I need to make any further adjustments to this
> driver? This driver is hanging in LKML for some time already without
> responds from input maintainer. It is still relevant and I would like
> it to move forward.

There were valid sashiko comments on the patch regarding resetting
"level" to 0 and also potential racing conditions, as well as suggestion
to check number of gpios specified in the device tree.

Please see if the following works for you:

diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
index ff82252a08e1..c61adc4b605c 100644
--- a/drivers/input/misc/isa1200.c
+++ b/drivers/input/misc/isa1200.c
@@ -131,6 +131,7 @@ struct isa1200 {
 	struct work_struct play_work;
 	struct isa1200_config config;
 
+	bool suspended;
 	bool active;
 	int level;
 };
@@ -247,17 +248,21 @@ static void isa1200_stop(struct isa1200 *isa)
 			       isa->supplies);
 
 	isa->active = false;
-	isa->level = 0;
 }
 
 static void isa1200_play_work(struct work_struct *work)
 {
 	struct isa1200 *isa = container_of(work, struct isa1200, play_work);
-
-	if (isa->level)
-		isa1200_start(isa);
-	else
-		isa1200_stop(isa);
+	struct input_dev *input = isa->input;
+
+	scoped_guard(mutex_try, &input->mutex) {
+		if (!isa->suspended) {
+			if (isa->level)
+				isa1200_start(isa);
+			else
+				isa1200_stop(isa);
+		}
+	}
 }
 
 static int isa1200_vibrator_play_effect(struct input_dev *input, void *data,
@@ -280,7 +285,8 @@ static int isa1200_vibrator_play_effect(struct input_dev *input, void *data,
 
 	if (isa->level != level) {
 		isa->level = level;
-		schedule_work(&isa->play_work);
+		if (!READ_ONCE(isa->suspended))
+			schedule_work(&isa->play_work);
 	}
 
 	return 0;
@@ -292,6 +298,7 @@ static void isa1200_vibrator_close(struct input_dev *input)
 
 	cancel_work_sync(&isa->play_work);
 	isa1200_stop(isa);
+	isa->level = 0;
 }
 
 static int isa1200_of_probe(struct i2c_client *client)
@@ -331,6 +338,9 @@ static int isa1200_of_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(isa->enable_gpios),
 				     "failed to get enable gpios\n");
 
+	if (isa->enable_gpios && isa->enable_gpios->ndescs > ISA1200_EN_PINS_MAX)
+		return dev_err_probe(dev, -EINVAL, "too many enable gpios\n");
+
 	ldo_node = device_get_named_child_node(dev, "ldo");
 	if (!ldo_node)
 		return dev_err_probe(dev, -ENODEV,
@@ -479,9 +489,9 @@ static int isa1200_suspend(struct device *dev)
 	guard(mutex)(&isa->input->mutex);
 
 	if (input_device_enabled(isa->input)) {
+		WRITE_ONCE(isa->suspended, true);
 		cancel_work_sync(&isa->play_work);
-		if (isa->level)
-			isa1200_stop(isa);
+		isa1200_stop(isa);
 	}
 
 	return 0;
@@ -493,9 +503,11 @@ static int isa1200_resume(struct device *dev)
 
 	guard(mutex)(&isa->input->mutex);
 
-	if (input_device_enabled(isa->input))
+	if (input_device_enabled(isa->input)) {
+		WRITE_ONCE(isa->suspended, false);
 		if (isa->level)
-			isa1200_start(isa);
+			schedule_work(&isa->play_work);
+	}
 
 	return 0;
 }

-- 
Dmitry
