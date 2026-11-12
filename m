Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508079;
	b=qlw0CCja7o19fVRCj+cKjkA/NuTBGY6r+KRODIpVjJPZ4LwQqprP1dmKOnrdVJCv/L+m
	 jQWcO0u7CiJhhpSDVEtT4LTFDTBY8bDJuoTJrH+qFylysvx+FWxGQMggtwXFI1Syx7pK1
	 4FMU10MtxUmHqoXsdLODij+ONQ4aXp2Q72vPGaVbwiaXiDqkmAbVywLG7I0scrga3i6rp
	 jWmg5Gp5nBQSfeKsTwFutrRKdwLFyifcng2C5Nl6KakySPSjFZBX9f9Gi8kxRjPY9Zb1H
	 KPnsg/QWVScKRQIf9BVA1QLYcKRgq6H7au+Y9dCbYGPeZD9TR69etkOUOpDHxE96K4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508079;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n2B1g6rUWTzaGvCjrue47KnOs8o8AYoZ1Erjwb9P5cs=;
	b=HLm8HeWdCZqqyc426e+qqlEZYWvo7AkewUvikR3HSwL0+JlWHKeOSpwwBlFtUJi4RcRQ
	 Z2LskVgEU2VGwuUQH37/mqpcvXAr9LcvOiqTf4Xd5srUk/E5APCzmMbHMTGue/mZbMbSF
	 wwPDAvSxdfXZmqjbv3ORNdCM1pfFS5puH/wEvKj5ngeceICjP7sSysl4aZ545M9SOuWhJ
	 auQCjc7mD+OiqmJXWjkm3yZlNurxybbC60esvT5Wo2zHt1XeAZfB/5MnuKYpHHFanfZXG
	 NDMRdR/W3zMisDgUUTZdSQMKvJ3L6/f7pd/PsbB5qKBuA0sLDm/tjHn8KSvx/6Ob7CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf8SFvW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF698606A31C;
	Thu, 12 Nov 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf8SFvW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8C51F000C5;
	Thu, 12 Nov 2026 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508079;
	bh=n2B1g6rUWTzaGvCjrue47KnOs8o8AYoZ1Erjwb9P5cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gf8SFvW+cWcPIX2hjrsa8llV4wQAtOX9H3tSwPersFCvE7xbZWRT9rsA/xaOli+K0
	 NsFo4JlssWwPRE9PWQ6Zc/bDZE+nc/3azxjmf4om5SLyeS+2Tib6yBUDXP0gQe9FWc
	 NFZyq4tWB+TpMyTjiUcI8e3KI0HELLFml8YZIqQ44o/OzEYEfCdj+hCyySnr7lKWdo
	 WrjRfSQ0G5DVVkErFqUCDl7iP4v77rtgwAyWXHObTkdcjWHoEkln3g4uUyXLLtkUGv
	 6PNiaADcgWrjLLU8lArYd3SC9UQtZ39R9bvEBHirBEaWPO2EfuoLr3Evbn3OnlDCh7
	 /ZeYSqCnKATGg==
Date: Thu, 12 Nov 2026 10:27:58 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, justinstitt@google.com,
	morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <202611121026.23C58B347@keescook>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
 <20261105112813.13210334@pumpkin>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105112813.13210334@pumpkin>

On Thu, Nov 05, 2026 at 11:28:13AM +0000, David Laight wrote:
> On Tue,  3 Nov 2026 22:23:18 -0800
> Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:
> 
> > In preparation for removing the deprecated strlcat() API[1], use
> > strscpy() to initialize the mouse device name.
> > 
> > The destination is zero-initialized, and the constant string fits
> > within the buffer. Since the return value is unused, this preserves
> > the existing behavior.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > ---
> >  drivers/input/mouse/vsxxxaa.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
> > index 042a17fe81db..b3a0d7ff5738 100644
> > --- a/drivers/input/mouse/vsxxxaa.c
> > +++ b/drivers/input/mouse/vsxxxaa.c
> > @@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, struct serio_driver *drv)
> >  
> >  	mouse->dev = input_dev;
> >  	mouse->serio = serio;
> > -	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> > -		 sizeof(mouse->name));
> > +	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> > +		sizeof(mouse->name));
> 
> You might as well use the 2 argument form.

I'd agree: this is a true array, so the sizeof() can be dropped. But
it's also exactly the same binary output, so I'm fine either way:

Reviewed-by: Kees Cook <kees@kernel.org>

And I echo the surprise over strlcat being used on an empty string. :P

-- 
Kees Cook
