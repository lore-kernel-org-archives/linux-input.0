From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: ALPS: Cirque Smart Cat Pro AG Touchpad Support
Date: Sat, 18 Jan 2014 00:01:19 +0800
Message-ID: <CA+F6ckMgiF-TrCf1rxNGvGrPHubxdVCtTBsLOKHpg=StRt8BvA@mail.gmail.com>
References: <52D6B45A.4050202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:52344 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbaAQQBU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 11:01:20 -0500
Received: by mail-la0-f45.google.com with SMTP id b8so3788308lan.32
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 08:01:19 -0800 (PST)
In-Reply-To: <52D6B45A.4050202@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: AJ Guillon <aj.guillon@gmail.com>
Cc: linux-input@vger.kernel.org

Hi AJ,

This is Tommy from ALPS. From the PCI ID you attached, it looks like
an external USB touchpad (?)
If so, modify alps.c may not let touchpad work since its only for PS/2 device.

I'm sorry although I work in ALPS, I'm not so familar with the
products made by Cirque.
However, I'll try to ask our Cirque's colleagues if they have schedule
to support their products for Linux mainstring.
Thanks !

-- 
Best Regards,
Tommy

2014/1/16 AJ Guillon <aj.guillon@gmail.com>:
> Hi everyone,
>
> I bought a Cirque Glidepoint (Model GP415U-5321) that I would like to
> use with Linux.  I haven't hacked on the kernel before, but I'm happy to
> test and modify alps.c as required to get this device working.
>
> I downloaded alps-reg-dump from
> git://kernel.ubuntu.com/sforshee/alps-reg-dump.git and it reports:
>
> Found serio mouse at /sys/bus/serio/devices/serio1/
> Invalid ack byte 0xfe after command
> Invalid ack byte 0xfe after command
> E6 report failed, not an ALPS touchpad
>
> The PCI ID of the device is: 0488:0282
>
> I'm not sure if there is anything else I should try.  I am currently
> running Ubuntu 12.04 with kernel 3.2.0-29-generic.
>
> AJ
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
