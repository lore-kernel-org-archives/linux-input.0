From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Enabling "extra" scancodes on some Acer laptops
Date: Tue, 11 Dec 2007 18:28:29 +0000
Message-ID: <200712111828.30142.carlos@strangeworlds.co.uk>
References: <200710141803.09039.cathectic@slackadelic.com> <200710161612.40914.cathectic@slackadelic.com> <d120d5000710160852x566d6379i96410c2eebabfecf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:51532 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXLKSaG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Dec 2007 13:30:06 -0500
In-Reply-To: <d120d5000710160852x566d6379i96410c2eebabfecf@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tuesday 16 October 2007 16:52:17 Dmitry Torokhov wrote:
> > On Tuesday 16 October 2007 15:37:37 you wrote:
> > > I think it could be added to i8042 driver to enable it. How messy is
> > > detection?
> >
> > I use simple DMI matching in acer_acpi to do this on known broken
> > laptops.
> >
> > (acerhk calls directly into the BIOS to find this information - but I
> > suspect the data from that could easily be extracted and converted to
> > proper DMI table entries).
> >
> > These are the the three that I know of (and are supported by acer_acpi)
> > that require this quirk:
> >
> > static struct dmi_system_id dritek_extension_quirk[] = {
> >        {
> >                .callback = dmi_matched,
> >                .ident = "Acer Aspire 5650",
> >                .matches = {
> >                        DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> >                        DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
> >                },
> >        },
> > [etc...]
> > };
>
> OK, we should be able to add it to i8042 pretty easily.

Ok, I completely forgot about this thread...

Dmitry - where would be the best place to add this? Put the DMI matching in 
i8042-x86ia64io.h, and then run the quirk somewhere in i8042.c?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
