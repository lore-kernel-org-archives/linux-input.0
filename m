From: =?utf-8?q?=C5=81ukasz_Luboja=C5=84ski?= <lukasz@lubojanski.info>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Fri, 28 Nov 2008 07:18:22 +0100
Message-ID: <200811280718.23274.lukasz@lubojanski.info>
References: <200811262333.45245.lukasz@lubojanski.info> <alpine.LRH.1.10.0811271337320.26670@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:25641 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYK1GSo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Nov 2008 01:18:44 -0500
Received: by ey-out-2122.google.com with SMTP id 6so548977eyi.37
        for <linux-input@vger.kernel.org>; Thu, 27 Nov 2008 22:18:42 -0800 (PST)
In-Reply-To: <alpine.LRH.1.10.0811271337320.26670@twin.jikos.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

> On Wed, 26 Nov 2008, =C5=81ukasz Luboja=C5=84ski wrote:
> > I have implemented Force Feedback driver for another "GreeAsia" bas=
ed
> > device (0e8f:0012 "GreenAsia Inc. =C2=A0 =C2=A0USB Joystick =C2=A0 =
=C2=A0 "). The
> > functionality was tested with MANTA Warior MM816 and SpeedLink Stri=
ke2
> > SL-6635 and fftest software - everything seems to work right.
> > Is there anyone able to check the code say if this good enough to i=
nclude
> > it into official kernel ?
>
> Hi,
>
> thanks for doing this work. The HID code has been redone for 2.6.28, =
and
> HID generic layer now provides proper kernel bus, to which the specia=
lized
> drivers should register properly. This has been done in order to keep=
 the
> code clean and maintainable, as adding all the quirks during the past
> years started turning the HID code into unmaintainable mess.
>
> Could you please rebase your patch on top of current state of Linus'
> kernel tree for 2.6.28-rc? Then the code could be reviewed and I'll m=
erge
> it through my tree.
> For inspiration, you can look into
>
> 	drivers/hid/hid-pl.c
>
> That driver even contains support for some Greenasia device ... (0x00=
03).
>
> Thanks!

I have rewriten the code for 2.6.28-rc6 and after testing and checking =
it with=20
checkpatch I will send it again.

Anyway I know that pantherlord code is also supporting greenasia device=
s (first=20
code was also mostly taken from that) - and I'm still don't know if I'm=
 dooing=20
right naming my part "greenasia" - because some people could get confus=
ed. It=20
could also happen that someone else will implement other greenasia devi=
ce and=20
this will make another confusion.

Maybe warrior_strike will be better name ? Of course there will be stil=
l noted=20
in description that it is supporting other GreenAsia 0x12 based devices=
=2E

ps. Do I need to ask Manta and SpeedLink for permission of using they c=
ompany=20
and product names in descriptions ?

regards
Lukasz Lubojanski
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
