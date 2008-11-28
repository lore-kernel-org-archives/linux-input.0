From: =?iso-8859-2?q?=A3ukasz_Luboja=F1ski?= <lukasz@lubojanski.info>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Fri, 28 Nov 2008 20:08:40 +0100
Message-ID: <200811282008.41601.lukasz@lubojanski.info>
References: <200811262333.45245.lukasz@lubojanski.info> <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz> <49303827.4050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:63491 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbYK1TJA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Nov 2008 14:09:00 -0500
Received: by nf-out-0910.google.com with SMTP id d3so837884nfc.21
        for <linux-input@vger.kernel.org>; Fri, 28 Nov 2008 11:08:59 -0800 (PST)
In-Reply-To: <49303827.4050907@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

> Jiri Kosina wrote:
> > On Fri, 28 Nov 2008, =A3ukasz Luboja=F1ski wrote:
> >>> Could you please rebase your patch on top of current state of Lin=
us'
> >>> kernel tree for 2.6.28-rc? Then the code could be reviewed and I'=
ll
> >>> merge it through my tree.
> >>> For inspiration, you can look into
> >>>
> >>> 	drivers/hid/hid-pl.c
> >>>
> >>> That driver even contains support for some Greenasia device ...
> >>> (0x0003).
> >>
> >> I have rewriten the code for 2.6.28-rc6 and after testing and chec=
king
> >> it with checkpatch I will send it again.
> >
> > Great, thanks.
> >
> >> Anyway I know that pantherlord code is also supporting greenasia d=
evices
> >> (first code was also mostly taken from that) - and I'm still don't=
 know
> >> if I'm dooing right naming my part "greenasia" - because some peop=
le
> >> could get confused. It could also happen that someone else will
> >> implement other greenasia device and this will make another confus=
ion.
> >
> > The question is how much the protocol that is used by your device d=
iffers
> > from the one that is already implemented in hid-pl.c? Would it make=
 sense
> > to have these two implementations in the same driver, or is the pro=
tocol
> > just completely different?
>
> It seems the protocol resembles more the hid-lg2ff one. The differenc=
es
> are the additional 0xfa 0xfe 0x0 report sent to the device, and the
> missing 0xf3 stop command.
>
> =A3ukasz, I see your code implements both FF_RUMBLE and FF_CONSTANT i=
n the
> same way. If the device only supports rumble effects, then you should
> only implement FF_RUMBLE.

Yep - different reports are send in case of Pantherlord and GreenAsia 0=
x12 - It=20
could be implemented in it but it will require checking what hardware i=
s used=20
and send different reports. So it depends on you - what is better in yo=
ur=20
opinion ? Please note only that I have only one hardware that it will s=
upport=20
so it will require tests from Pantherlord/Logitech users test.

No problem with the FF_CONSTANT - I will cut off that code. I was think=
ing it=20
will be better to have it implemented and as the hardware has the same =
report=20
for both effect and it was very easy to made.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
