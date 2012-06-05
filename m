From: "devendra.aaru" <devendra.aaru@gmail.com>
Subject: Re: [PATCH] drivers/input/mouse: Fix a "make randconfig" warning at
 MOUSE_APPLETOUCH dependency with USB_SUPPORT and USB_ARCH_HAS_HCD
Date: Tue, 5 Jun 2012 15:55:31 +0530
Message-ID: <CAHdPZaNSBQ4weycXG1bNrM-Qq_4zpyL0J1GeZcL3CgkNB+R-HA@mail.gmail.com>
References: <1337037329-23618-1-git-send-email-devendra.aaru@gmail.com>
	<alpine.LNX.2.00.1206051140540.5478@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42031 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2FEKZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jun 2012 06:25:31 -0400
Received: by pbbrp8 with SMTP id rp8so7275068pbb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jun 2012 03:25:31 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1206051140540.5478@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Paul Parsons <lost.distance@yahoo.com>, Jan Steinhoff <mail@jan-steinhoff.de>, linux-input@vger.kernel.org

Hi Jiri,

Thanks for the review.

On Tue, Jun 5, 2012 at 3:11 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>> diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconf=
ig
>> index cd6268c..044378f 100644
>> --- a/drivers/input/mouse/Kconfig
>> +++ b/drivers/input/mouse/Kconfig
>> @@ -152,7 +152,7 @@ config MOUSE_SERIAL
>> =A0config MOUSE_APPLETOUCH
>> =A0 =A0 =A0 tristate "Apple USB Touchpad support"
>> =A0 =A0 =A0 depends on USB_ARCH_HAS_HCD
>> - =A0 =A0 select USB
>> + =A0 =A0 select USB if USB_SUPPORT && USB_ARCH_HAS_HCD
>
> Depending on USB_ARCH_HAS_HCD and then having it as a part of 'if'
> condition seems odd.
>
So,
+    depends on USB_SUPPORT && USB_ARCH_HAS_HCD
will be good ?

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs

Thanks,
Devendra.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
