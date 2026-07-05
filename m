Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DF35E940
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 20:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783283202; cv=none; b=kjZnICBh8pEefxpX09KEZgyaUGAf9sqY9m2scnSVzifNgJB+Nw2dqLq456Y4d28tLAFtTUaTO5TLKHO0Vs/4L9kCsH0WVev2eczksA0Yj8qg0x0+N3E+dPsgi6dTfj6PMUS6WG/awgKwFr1w5TxYKsgsf3VBoFwPSah/JJ9URdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783283202; c=relaxed/simple;
	bh=cOeJsDEtRMNDJCLsBLMsRmiTuNsQyfI3SUCZYl6u/WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+AZvCIZLLaDZZOG3T6A3XXQ3cgDJf67EMKfsaWOhedIdb8fAvBivRPBoLnSB7TeQ72oQ+SyefeZCDN+DhnIblJF32bSkvqrzuhaashFURb8PlvOLWxQ5y7klhFc01teE+i8itNA9K/leQLom9nAirF6rrVx9SgJJSL460d8kfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLrDSVOL; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLrDSVOL"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383adaa461fso845634a91.3
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783283200; x=1783888000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsgfJZ0NjzP8ZPKGtPWCLANSMMngsdofAxBSh+8zVRQ=;
        b=PLrDSVOL+4Xc66iOiaOn5TYFsx78Abc5ssdEQ6yvuYzzUNpldHMK+Le+AJuPYhTHMK
         vvxC3arm1OaRVZi3iobzr7gL4DrKGBy4kmC0tNsgokfOz7nOj4xHhwYz0y8wrQLq2AFL
         wmHEcVm4tlst+mIKGPMoWyR6xmAKC1VGx0Uulm4QtlZMCFESsGoYeWxaJm9pHnq3Cfm+
         PYqls55968ljKZDpUHrcI26/rDhYu5VO2SxaJZpinLH+tpsidaPhBGXbcdXQlqKkZTT2
         NcrZglNcjq67Xame///L/rlENNXnbrpq9cl5jp5PqnLoRL8nd5ZZAC4Gt1fhzM6viqS+
         b2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783283200; x=1783888000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsgfJZ0NjzP8ZPKGtPWCLANSMMngsdofAxBSh+8zVRQ=;
        b=QSd+7AOnlzkHYNzlSHWSWop5aQbhW/uhp2bzLBk6ELBste6CWpBvWiaypsg9J2XQhs
         8yC2TeopYqY/9jsqLm/1THiOpfKNS9a7lOqFGT7jkZ1YtMLkDypxh+yFLxXh1pTyvgcy
         HY+MBtAQSKbb7oF9l7XwSz6lz4pQn8tlaIfrI9vQxpONOQacO7lzyanoXbAAlgbK9DtX
         2jEwRhxtzD40VhqZnjGRJU6DBrUWR28B7gjQoT21w5xiucQ9/o8wiG+Wxh7GBV/HHymh
         pU/UmTzb68RRpqdtXvE/qgSByOyQ/BCrC80Aln11B4b8i5aNpspNHlIhCBe0MfyqL5fi
         E7tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3ICe8vfhHuyDZqzO+s+0rPXgB7bL1fCXs80R3iCnLlJppIJfuKapJwDYd6Vrmc1fbD0KRYW+qQCFzJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7x6foLdt4eq7JkHSHZB6YicsfPIXO3LMiUy2lGqRLS22XzYwq
	ieKdjDqNKVYQWXtwO8EJd5wvXSe+U2nhgFHfzImCXoxKXyJN8Vya8Te4
X-Gm-Gg: AfdE7cm2P/ZA4QfvBaS+cuy14IESPkSY24L40ylN4Fl4DcJr3zBhUXWs3GHoPr0q07z
	1qK4OufwN+rn3izsf3ZnyXEylmKR8NZC/ZXeQu1NLV7/R0g9Vy/ITC3l5Q5SvCnuBTKX+M9WMCf
	h/4ZpPAHU1Ty62tbO8muuEnS5vQHidhekIP73HOZeXNHaMW1yA2nc29JQQCExJVCo+gSxIev6AD
	qq7lpVTQ86UZfm8Ahmfn/ObZRDRdfyvwHjMtSmwZV9x5KKaDpFCpnlI6zVNjfCML0cBQaKituCx
	z+sRUKX+mfxD0sadUbEHvARjtjpLSuR8o2Hk+owGYOO+L6VmM5gaP8FFFXA4jdE5kh9aQe6cbP+
	SM4tx9oNwND1ZaK+G7Ij3ULz86PMxOBkeSG81mpwvG4vjFp+onjJNuV40YAMyvfqR8TNyY/XVvB
	7vIH/0U2IV7ierZBeO04lugu1Y2pcGRWKngjmcQhE2sP6RhTyvJ6x3Fg==
X-Received: by 2002:a17:90b:1c81:b0:37f:9cdf:f03a with SMTP id 98e67ed59e1d1-3829f4e8836mr6779812a91.29.1783283200446;
        Sun, 05 Jul 2026 13:26:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:480e:1643:32ae:124b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f38ee1333sm29592829eec.24.2026.07.05.13.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 13:26:39 -0700 (PDT)
Date: Sun, 5 Jul 2026 13:26:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Florian Fuchs <fuchsfl@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 25/26] Input: maplecontrol - fix style issues
Message-ID: <akq9m7oDV0y_sWzx@google.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
 <CACwZE5RfhwhOoVSPqibM9+XaPJCf-TdnJxi_UT7Dgv71OJPsFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwZE5RfhwhOoVSPqibM9+XaPJCf-TdnJxi_UT7Dgv71OJPsFQ@mail.gmail.com>

On Sun, Jul 05, 2026 at 08:28:39PM +0100, Adrian McMenamin wrote:
> On Sat, 4 Jul 2026 at 06:58, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > Fix coding style and formatting issues reported by checkpatch.pl and
> > switch to using BIT(). When reporting D-PAD events avoid conditionals.
> >
> > Assisted-by: Antigravity:gemini-3.5-flash
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/joystick/maplecontrol.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
> > index 3ef6652d40cb..457a73d91239 100644
> > --- a/drivers/input/joystick/maplecontrol.c
> > +++ b/drivers/input/joystick/maplecontrol.c
> > @@ -35,22 +35,22 @@ static void dc_pad_callback(struct mapleq *mq)
> >         buttons = ~le16_to_cpup((__le16 *)(res + 8));
> >
> >         input_report_abs(dev, ABS_HAT0Y,
> > -               (buttons & 0x0010 ? -1 : 0) + (buttons & 0x0020 ? 1 : 0));
> > +                        !!(buttons & BIT(5)) - !!(buttons & BIT(4)));
> >         input_report_abs(dev, ABS_HAT0X,
> > -               (buttons & 0x0040 ? -1 : 0) + (buttons & 0x0080 ? 1 : 0));
> > +                        !!(buttons & BIT(7)) - !!(buttons & BIT(6)));
> 
> 
> Maybe I have missed something but what is this !! operator?

Double negation to coerce the value to [0, 1] range avoiding
conditional/branching?

-- 
Dmitry
