Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80142F5A13
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782505250; cv=none; b=bSI4Q29hkseK6/X20OSM3lYwbfEmu6cqDzVyzGPVGRq084SfAVZFXz9m5B3NjKYkrSrBQFuK61ch5yuvPCpFv0Ap5G7wp+kXEbuYYoWRNMW4wi5bfDY7AczySdTB77CPiT++p6pHYk7WYKNhZCuPuF3Aw0eTywbkCrF0kVNcrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782505250; c=relaxed/simple;
	bh=RGavRq2w7Eh/HCoask6CSMiKDWutmt9ky7lRrahkzTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpNITeRKrJUWCM2lMzmA1zXtdnPCVMw15bvQhYKaWXbB2vDHHf6TfKmc+cjK0JjePJIvNIIYy24C0Q7T5tPG6GQxoz5LmHog9kTIbLsXrWsrJ3u0wJJFsgO2ESEXot3AIj858RBwlHK+BNcshNde+rV8d4tzf6Q5je3pTQB4wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6PQxWT8; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6PQxWT8"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139edc6bfc0so871211c88.1
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782505248; x=1783110048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5YzRske6TyAkzZ6v5R+u17HWPV5j9lKO+pa7wB7nPTE=;
        b=l6PQxWT8dq/nla1UST36v+mSYoFyfxHfa7O/XU9kNIh4rp/NFUgSIRAWdPMmTbie0B
         VDE7g+gs18roF7ngR4vL6IJudr8/IhmOQdL+UC1AhPPTFdaYcxL6o1mJQLS9DkDjaGYa
         y15af0YbgwaJgMx5+XpLuDUCgmLl3tDSNjNYaaygR4ioqdNspvZ4+b62A/NR/QlFoQvM
         OgyfrOFyRTfHmolDa5XcFBteD9Zb7lIWNVlYMGhILVDbt8tPpxhC5OmbhJM3SjFDPuJ0
         q8CC8rfyPqRspLSzTKSL35pkr5VHCUzUuqFQmTCj9WfSIZloQymC15rzrYkbXskXW+0C
         XyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782505248; x=1783110048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YzRske6TyAkzZ6v5R+u17HWPV5j9lKO+pa7wB7nPTE=;
        b=WyViHXA0zay+4GCnLcBDaUU9NN/uabVgDmNZoC60zCpp8vhIQg508nio9Zy1SsyjqV
         xkfLMEQDrieW5lylcrAWGovPrnJLyYdKshyS1FP8FLjFsmOfsfZiiR9+0DFKBNb0M1lW
         twej/nwOL4nngCMs/wxzjj7oSLVGfyXrJqlLgFk6vCrVA/+nf2yOtTi8jsMEOL6pO8Gz
         3iiglt6hG5R/GZxsZqkLEdM215Ud1TN/Fn9AxbnFK2DTte31hCCRAceQOHG8YhrONAYA
         yNpzoXOLQIChClFkuUEyXR3/uydFM3a72vSZAQR37waI9qotxP6hKr4k3OwFc4hzxEle
         5OAg==
X-Forwarded-Encrypted: i=1; AFNElJ+2+J7yy3439YzCLyRwNNfAROFxIzogTnUWQQEHfA7uyFT+tJb6Ysa6ULlFZdJ6QzfsKLa4lcFOyU5E9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDY4F5eOXcOK6aMww47a6qds+y1bV4LDpMQVB9SzxZXwizrDE
	aftqie0+Mdk6k5lxvoN+/2i9dq0Xd9T7Uy6Dmie/4V8sVUhabaRgra8jp2WR4A==
X-Gm-Gg: AfdE7ckJibiSX86k8U8CGSEoJpNhH+R+c8Uyl2MM9ZGUshrPy9vzPs+yVmfC7K42WNW
	7ZdwaJ3m+kABqZrbN9UELKAGjNsyGc33BIBHpUQzxgrsP3ZmhD9FCG8x/AqEljwBo3lZV3GozX+
	rjdMvYD9EU/w+N9LXsEiN7VKtoTIC3G1ncWRrJKt3T3R9WL5soj8jzJ7A69X1j32BAVd6pIdQ2m
	dy+GzzqmIwefpdeWi3iegs3KsFRYxybeL+pSQHZ8vRrjb32IySh6bnjM7E9FOBcRP0Gs0jkSCWC
	533OcNkxRPqEvZ5oJ1Nu3pL0yPIHf/jr6R4Y9wYUu719YnkwFIXWXSq7QcqTCVKLPKUxbSwps5D
	PuIRw/nHakZzua8EP1TVwOicT2xFoxNUihWdzAR56g64PMvON0pD0Tmir7eYMEm3Q0/emNJkOoy
	HoTBmp+qPG+WDbaaLsfk0FvU4XFlLeLeYFxks+0G1XZjrv+NcdRA0cnQ==
X-Received: by 2002:a05:7022:23a0:b0:137:d08e:e5b1 with SMTP id a92af1059eb24-139dbaba7abmr7015184c88.16.1782505247784;
        Fri, 26 Jun 2026 13:20:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d912197bsm33048756c88.15.2026.06.26.13.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 13:20:47 -0700 (PDT)
Date: Fri, 26 Jun 2026 13:20:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] Input: isa1200 - new driver for Imagis ISA1200
Message-ID: <aj7fASOM-jwLTCQS@google.com>
References: <20260617070528.35006-1-clamor95@gmail.com>
 <20260617070528.35006-3-clamor95@gmail.com>
 <aj28fvj34b4_VI3k@google.com>
 <CAPVz0n0Ja0eKrpirtMxK8bkTV0NY-UoKU0c09qLEF-xMWmOzKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0Ja0eKrpirtMxK8bkTV0NY-UoKU0c09qLEF-xMWmOzKQ@mail.gmail.com>

On Fri, Jun 26, 2026 at 10:45:20AM +0300, Svyatoslav Ryhel wrote:
> пт, 26 черв. 2026 р. о 02:45 Dmitry Torokhov <dmitry.torokhov@gmail.com> пише:
> >
> > Hi Svyatoslav,
> >
> > On Wed, Jun 17, 2026 at 10:05:27AM +0300, Svyatoslav Ryhel wrote:
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
> >
> >
> > Sashiko convinced me that using mutex_trylock() in the playback work
> > handler will result in dropping requests and that we are safe not taking
> > the lock there at all. Can you please try the following modification?
> >
> > diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
> > index c61adc4b605c..fb7f68fa0a2b 100644
> > --- a/drivers/input/misc/isa1200.c
> > +++ b/drivers/input/misc/isa1200.c
> > @@ -253,15 +253,12 @@ static void isa1200_stop(struct isa1200 *isa)
> >  static void isa1200_play_work(struct work_struct *work)
> >  {
> >         struct isa1200 *isa = container_of(work, struct isa1200, play_work);
> > -       struct input_dev *input = isa->input;
> > -
> > -       scoped_guard(mutex_try, &input->mutex) {
> > -               if (!isa->suspended) {
> > -                       if (isa->level)
> > -                               isa1200_start(isa);
> > -                       else
> > -                               isa1200_stop(isa);
> > -               }
> > +
> > +       if (!READ_ONCE(isa->suspended)) {
> > +               if (isa->level)
> > +                       isa1200_start(isa);
> > +               else
> > +                       isa1200_stop(isa);
> >         }
> >  }
> >
> >
> > If this works no need to resend, I'll fold on my side.
> >
> 
> It does work fine. Thank you.

Excelled, thank you. Applied both patches.

-- 
Dmitry
