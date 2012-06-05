From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/mouse: Fix a "make randconfig" warning at MOUSE_APPLETOUCH dependency with USB_SUPPORT and USB_ARCH_HAS_HCD
Date: Tue, 05 Jun 2012 12:20:49 -0700
Message-ID: <1575762.xp4W0eRkvE@dtor-d630.eng.vmware.com>
References: <1337037329-23618-1-git-send-email-devendra.aaru@gmail.com> <alpine.LNX.2.00.1206051140540.5478@pobox.suse.cz> <CAHdPZaNSBQ4weycXG1bNrM-Qq_4zpyL0J1GeZcL3CgkNB+R-HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59165 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2FETU5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jun 2012 15:20:57 -0400
Received: by dady13 with SMTP id y13so7704813dad.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jun 2012 12:20:57 -0700 (PDT)
In-Reply-To: <CAHdPZaNSBQ4weycXG1bNrM-Qq_4zpyL0J1GeZcL3CgkNB+R-HA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "devendra.aaru" <devendra.aaru@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Paul Parsons <lost.distance@yahoo.com>, Jan Steinhoff <mail@jan-steinhoff.de>, linux-input@vger.kernel.org

On Tuesday, June 05, 2012 03:55:31 PM devendra.aaru wrote:
> Hi Jiri,
> 
> Thanks for the review.
> 
> On Tue, Jun 5, 2012 at 3:11 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> >> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> >> index cd6268c..044378f 100644
> >> --- a/drivers/input/mouse/Kconfig
> >> +++ b/drivers/input/mouse/Kconfig
> >> @@ -152,7 +152,7 @@ config MOUSE_SERIAL
> >>  config MOUSE_APPLETOUCH
> >>       tristate "Apple USB Touchpad support"
> >>       depends on USB_ARCH_HAS_HCD
> >> -     select USB
> >> +     select USB if USB_SUPPORT && USB_ARCH_HAS_HCD
> > 
> > Depending on USB_ARCH_HAS_HCD and then having it as a part of 'if'
> > condition seems odd.
> 
> So,
> +    depends on USB_SUPPORT && USB_ARCH_HAS_HCD
> will be good ?

I'd rather we "select"ed the new symbol. So please do

	depends on USB_ARCH_HAS_HCD
	select USB
+	select USB_SUPPORT
	
Thanks.


-- 
Dmitry
