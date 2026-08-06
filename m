Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C541305692
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997327; cv=none; b=HqnkOLH9DsSiSd2+Uzi9y3Zu2oEOIcZlbBfQDMZz+6Tj30PZ6UgXoUVJUOA6XyyuDeNigPK6CQjm7c0M01qmuQu+TRLWhMeeBBelDNabl+r+WuISECiuVadGHgZIqrSdRoN/CFTs5nxx1ki2U+kD40xTtw3EndCcNtgRq9GdP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997327; c=relaxed/simple;
	bh=cDMNpazCMTtIGQLm+kw5+VDoqXHW1j0fBEb9LvXCNVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBCytZbOd9xNqiR5XpGa8iAyuODUfdyUq6iGFXodZBaYl0IQRTVKhrKuQLDCnJ+SvJg8GQ+TQHE7v42usyZdquRnSeg7nt77tKsNW/q889/yuGLVkcPmJkNNrVa0OvPE58OWOWVftZLrlaKyrLsW47zM450PO9jzcqocdkOs5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/eYHOfX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/eYHOfX"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1051040a12.0
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785997326; x=1786602126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSiApwR1mx/EhqhzyQvUIyZv/3wBIS1aGlL5D5CHEI8=;
        b=o/eYHOfX6CdUnm2DuPpxDV0TR8fxjl75QiktpFf7JmH3Oj0UUvv+cU/oax40RF6zJB
         yc+PBNMT+/KuqA4lg4GWxbL/VhD4HKRKdv7E87cnNMVLdzXzYlXlBNvlq6jQtJ64RuJB
         5USakE0lFBq7usdTM7Rxp3CNCikshroIJp5hstPTlDjm5M3A1eDcdFIOgePT9Jc0gXTv
         A2DkO9cBO0vFMdTOyfR2eIXuMssLN2KU/X7fLc55v/tAB+0TSw2NpO/ffqWeTdGKxMyf
         z+9l0yopHhO+d7+EFLsnE6UnyDDX9HI+EUiCDQ0JDns0CcJD3p1vPqaA85w6mUA+fq2+
         Lviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997326; x=1786602126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dSiApwR1mx/EhqhzyQvUIyZv/3wBIS1aGlL5D5CHEI8=;
        b=TnhozzHQjYLylNYGK1VOtaFYYMj0xp7u/CRx2uMvqSb9GCywsaqiW9x34mRItcTDBd
         R4coQcyNhXWRTcjxdlUrhwx3C1AZ+rMG4QBEDrrgZzsel55W0PxxyB3n/782gmFX04Eu
         UvXk/OUHpwb8QDE3wU6rgwX9YQDcM5swt7mqzs25qWfIK83Y4TZbTwVsTKZSPJg556FZ
         an0mGbG70ttD09OHoFvMwumdPhyWhYA8kjroQ4VisgEMLJDBVLxCAI+yT9vUhCEyOOZp
         vM1FpCCngIPWsaAJnAGDADAQqgzrXiOHd+l+2EH0/0WFnJ3nP6J8j7q577uGueWdWfaS
         Pwhw==
X-Forwarded-Encrypted: i=1; AHgh+RrYszO9sScn2nfEI+u184MJD6U4+FlI9PXF0OIZt5waVIAaPOqydw1k8x/r9rZp99n+5+iojylRVMLecQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9efHLOsgU3D4QhsQkE/fD/BmBsMKVOIqRvP142q0u4Efsf91
	7yyWsJG64OYFu0ZEuF+wvVhJTGcXoB8hUpF55zXcCSN1WNhVs2TtqQVX
X-Gm-Gg: AR+sD1040xvl07eB0LVHQyBsF0KjE2+Sx1Q4+3jDPaWN0W17zrfhjZpMWDa3zoV5GQb
	PI2dZhmhVD/43CxeojYkIVbSvJtc22Y1vqFTYmfa7BNS4UJnp9PURfY08NkzI9rFDsDQKZ/s0fJ
	5De/3Ie7odQgkEKVVWxCDRzAtsS6jmSD3flHqfbBPiBzeNDWHblGrronQ3b7o7U1xEM+SXkYkbR
	o4GSHS47+Wfw0J4uEL1EiYWJs1c1XVK2ry2LPhJSwTyQ8cwTYu7l1W2VRjzjz4xsHCP3Cc73zsf
	csN9W0jSKBByw4W/XmG1IRiwLhRCUwOXsu+u18mT+8gPKXGOt1wSlUS6v1jDlq6RiDgEfARTKqU
	uECDX7GO8Cl0buyJeRbRCCUnl7P+zy+N+L8RoyhDEyuZQr1eslZTZTaGBD9TOtKPjE6meIIyQ66
	SC8rfHA47vSNEA4QIr+2pXgj6XmFKF4YGIi+xKdvn6bk2BgIn3QNbMnJGmcOaUglJVl4PUYQRVF
	OEIYBtv/q9iWrp0F1camecfC0F9
X-Received: by 2002:a05:6a20:4309:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3cb85dee5ecmr14191561637.9.1785997325601;
        Wed, 05 Aug 2026 23:22:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d081:36b2:965:e66f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca660e66sm20857368c88.8.2026.08.05.23.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:22:04 -0700 (PDT)
Date: Wed, 5 Aug 2026 23:22:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via
 device property
Message-ID: <anQnwJYBmY7wxF-B@google.com>
References: <am_9BvmZu9g4RlUM@google.com>
 <4346aa03-1d8c-4a9a-bad3-0c4186dbc65d@gmx.de>
 <f0d96059-31c1-434c-b3d0-b2119f915d61@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0d96059-31c1-434c-b3d0-b2119f915d61@gmx.de>

Hi Helge,

On Tue, Aug 04, 2026 at 08:36:17PM +0200, Helge Deller wrote:
> On 8/4/26 15:59, Helge Deller wrote:
> > Hi Dmitry,
> > 
> > On 8/3/26 06:39, Dmitry Torokhov wrote:
> > > Instead of hardcoding PA-RISC specific keycode tables into atkbd via
> > > compile-time inclusion, have the gscps2 PS/2 port driver attach a
> > > linux,keymap software node device property to the serio device when
> > > a keyboard port is registered. This allows atkbd to dynamically fetch
> > > and apply the custom keymap when probing the port using generic
> > > firmware property helpers, removing architecture-specific hacks from
> > > generic keyboard driver code.
> > > 
> > > Co-locate the keymap definitions with the serio port driver by moving
> > > hpps2atkbd.h from drivers/input/keyboard/ to drivers/input/serio/.
> > > To handle the five conflicting keys on RDI PrecisionBook laptops without
> > > runtime model string checks or duplicate keymap tables in memory, add
> > > CONFIG_SERIO_GSCPS2_RDI_KEYCODES to drivers/input/serio/Kconfig and
> > > resolve the conflicting keycodes at compile time via preprocessor
> > > macros.
> > > 
> > > Assisted-by: Antigravity:gemini-3.5-flash
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > > 
> > > v2:
> > > - instead of using device_create_managed_software_node() that has issue
> > >    if serio port is unregistered before it is fully registered, switch to
> > >    creating software node when initializing the driver and attach it to
> > >    the serio port
> > > - added keycodes lost in movement (0x92 - silently ignored, 0xca -
> > >    KEY_KPSLASH, 0xda - KEY_KPENTER).
> > > 
> > >   drivers/input/keyboard/Kconfig      |  38 ---------
> > >   drivers/input/keyboard/atkbd.c      |   8 --
> > >   drivers/input/keyboard/hpps2atkbd.h | 110 -------------------------
> > >   drivers/input/serio/Kconfig         |  27 +++++++
> > >   drivers/input/serio/gscps2.c        |  47 ++++++++---
> > >   drivers/input/serio/hpps2atkbd.h    | 120 ++++++++++++++++++++++++++++
> > >   6 files changed, 184 insertions(+), 166 deletions(-)
> > 
> > Thanks for cleaning it up.
> > Your solution is much cleaner and gets the hacks away.
> > I'll test and report back very soon.
> > 
> > > diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> > > index bf9b993f5733..cd1bca57fda3 100644
> > > --- a/drivers/input/serio/gscps2.c
> > > +++ b/drivers/input/serio/gscps2.c
> > > @@ -22,20 +22,19 @@
> > >    *                 was usable/enabled ?)
> > >    */
> > > -#include <linux/init.h>
> > > -#include <linux/module.h>
> > > -#include <linux/slab.h>
> > > -#include <linux/serio.h>
> > > +#include <linux/delay.h>
> > >   #include <linux/input.h>
> > >   #include <linux/interrupt.h>
> > > -#include <linux/spinlock.h>
> > > -#include <linux/delay.h>
> > > +#include <linux/io.h>
> > >   #include <linux/ioport.h>
> > > +#include <linux/property.h>
> > > +#include <linux/serio.h>
> > >   #include <asm/irq.h>
> > > -#include <asm/io.h>
> > >   #include <asm/parisc-device.h>
> > > +#include "hpps2atkbd.h"
> > 
> > Doesn't it makes sense to move the contents of the new file
> > "hpps2atkbd.h" directly in here instead of keeping in own header?
> Other than that, you may add:
> 
> Acked-by: Helge Deller <deller@gmx.de>
> Tested-by: Helge Deller <deller@gmx.de>

Thank you very much for testing it. I went ahead and merged the header
into the driver code and applied.

I have a few more cleanups since I've been looking at the driver, I'll
send them out in a couple of days.

Thanks.

-- 
Dmitry
