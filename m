From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: Logitech M705: Thumb button (was Re: [PATCH v4] HID: Add full
 support for Logitech Unifying receivers)
Date: Wed, 3 Jul 2013 12:46:58 +0200
Message-ID: <CAE7qMrosUkhF3Yak11Mh81NcGhYduUKRoHiUwH4RbTN1KXqi8A@mail.gmail.com>
References: <1315638713-3731-1-git-send-email-benjamin.tissoires@gmail.com>
 <20110910072826.GA1611@x4.trippels.de> <CAN+gG=H2jfT2zdn5H19hyn9JtDU7U1ensX_aUDgv0jk4d81jXg@mail.gmail.com>
 <CAN+gG=E90-y--6C-Ok8TibcFZGAaL2X-KxnchquDLCUUniip1Q@mail.gmail.com> <alpine.LNX.2.00.1306271513180.3538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:59286 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754047Ab3GCKra (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jul 2013 06:47:30 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so5808451veb.34
        for <linux-input@vger.kernel.org>; Wed, 03 Jul 2013 03:47:29 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1306271513180.3538@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Markus Trippelsdorf <markus@trippelsdorf.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Titmuss <rtitmuss@logitech.com>, Olivier Gay <ogay@logitech.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Daniel Zanone <jzanone@logitech.com>, =?UTF-8?Q?Franti=C5=A1ek_Fuka?= <fuka@fuxoft.cz>

Hi all,

Sorry it took me some time to answer.

I extended the Logitech HIDPP10 specification here:
https://drive.google.com/folderview?id=0BxbRzx7vEV7eWmgwazJ3NUFfQ28&usp=sharing

The document "Logitech_hidpp10_specification_draft_Unifying_devices_receivers.doc"
now contains most of the relevant hidpp10 registers and notifications
needed to interact with older Logitech devices that support hidpp10 as
well as the Unifying receiver.

In particular I added the specifications for the registers that enable
retrieving the FW version information for devices/receivers. This will
become relevant below.

Cheers,
Nestor


On Thu, Jun 27, 2013 at 3:16 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>
>
> [ Frantisek Fuka added to CC ]
>
> On Wed, 14 Sep 2011, Benjamin Tissoires wrote:
>
> > >> Nice. Does this mean I will be able to use the thumb-button of my M705
> > >> mouse in the near future?
> > >>
> > >> (Someone asked the same question 1.5 years ago, but nothing happened
> > >> till then: http://thread.gmane.org/gmane.linux.kernel.input/11791 )
> > >
> > > This is quite weird. I was going to say that it will work, but with
> > > the M705 I've got at home,this thumb button doesn't work at all
> > > (anything is emitted from the usb, even with this driver).
> > > But I'm pretty sure I made it work with the one I got at work.
> > >
> > > I'll give a try on Monday unless people at Logitech gave us the solution.
>
> > I got some information for you. Apparently, it won't be possible to
> > enable this thumb button right now.
> > To enable it, the Windows driver put the mouse in a kind of debug mode
> > that need to be handled properly, which is not the case as of today.
> >
> > I was able to make it work at home because there were different series
> > of M705, the latest sending the thumb button by default.
>
> Let me resurrect this 2 years old thread, as I have received multiple
> reports since then, stating that some revisions of M705 don't have working
> thumb button.
>
> Question mostly to the Logitech guys: Nestor, Olivier, could you please
> provide us with the sequence that needs to be sent to (certain revisisons
> of) M705 to let enter the debug mode, making the thumb button actually
> emit a USB message?


There are two versions of FW in the field:

1) Version 17.01.Build 0017.
This version reports the thumb button by default as HID button 6.

2) Version 17.00.Build 0015
This version does not report the thumb button by default.

It is possible to enable the M705 with FW 17.00.Build 0015 to send the
thumb button as HID button 6 via HIDPP10 command. But this will have a
(undesirable ?) side effect.
Once the button 6 is enabled, the buttons aside to the wheel (tilt
buttons) will no longer be reported as AC pan HID usage, they will be
reported as buttons 7 & 8. This might disrupt some users that rely on
the mouse AC pan feature.

To enable HID button 6 reporting from thumb button we need to clear
the bit 1 (Special button function) in register 0x01 on the M705
READ register: 10 IDX 81 01 r0 r1 r2
Clear Bit1: r0 &= 0xFD;
Write back register: 10 IDX 80 01 r0 r1 r2

IDX is the device index on the Unifying receiver.

Note that if the command is sent to all M705 devices, users that have
the  17.01.Build 0017 will lose the Ac pan and will gain nothing.


>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
