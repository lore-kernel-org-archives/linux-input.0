From: "devendra.aaru" <devendra.aaru@gmail.com>
Subject: Re: [PATCH] drivers/input/mouse: Fix a "make randconfig" warning at
 MOUSE_APPLETOUCH dependency with USB_SUPPORT and USB_ARCH_HAS_HCD
Date: Thu, 7 Jun 2012 16:05:14 +0530
Message-ID: <CAHdPZaN8LBs_xZ=w82zwbxTzTtLYAPjEPZj88M29ZQhmQQAS8g@mail.gmail.com>
References: <1337037329-23618-1-git-send-email-devendra.aaru@gmail.com>
	<alpine.LNX.2.00.1206051140540.5478@pobox.suse.cz>
	<CAHdPZaNSBQ4weycXG1bNrM-Qq_4zpyL0J1GeZcL3CgkNB+R-HA@mail.gmail.com>
	<1575762.xp4W0eRkvE@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44792 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2FGKfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jun 2012 06:35:15 -0400
Received: by dady13 with SMTP id y13so688116dad.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jun 2012 03:35:14 -0700 (PDT)
In-Reply-To: <1575762.xp4W0eRkvE@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Paul Parsons <lost.distance@yahoo.com>, Jan Steinhoff <mail@jan-steinhoff.de>, linux-input@vger.kernel.org

Hello Dimitry,

On Wed, Jun 6, 2012 at 12:50 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I'd rather we "select"ed the new symbol. So please do
>
> =A0 =A0 =A0 =A0depends on USB_ARCH_HAS_HCD
> =A0 =A0 =A0 =A0select USB
> + =A0 =A0 =A0 select USB_SUPPORT
>
> Thanks.
>
>
> --

with your change told, i ran make and got the following error when comp=
iling it.

devendra@devendra:~/linux$ make
scripts/kconfig/conf --silentoldconfig Kconfig
drivers/usb/Kconfig:76:error: recursive dependency detected!
drivers/usb/Kconfig:76:	symbol USB_ARCH_HAS_HCD depends on USB_SUPPORT
drivers/usb/Kconfig:58:	symbol USB_SUPPORT is selected by MOUSE_APPLETO=
UCH
drivers/input/mouse/Kconfig:152:	symbol MOUSE_APPLETOUCH depends on
USB_ARCH_HAS_HCD

It seems that USB_ARCH_HAS_HCD needs to be selected? too.

> Dmitry

may i attach .config?

Thanks,
Devendra
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
