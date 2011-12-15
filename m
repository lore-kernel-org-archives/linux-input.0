From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH] input: egalax_ts: optmize driver for more fluency touch feelling
Date: Thu, 15 Dec 2011 14:24:24 +0800
Message-ID: <CACrgxGA3mV8MpkPOumpbofSdsb+4AEAxBevLn=dJ1x68qzH+dQ@mail.gmail.com>
References: <1323249002-28397-1-git-send-email-jiejing.zhang@freescale.com>
 <20111212083415.GH4682@core.coreip.homeip.net> <CACrgxGAUYW0E3cLradFJ8SAYBjszWjYdsfrFBAZN6R7a0NO41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56421 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab1LOGYp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 01:24:45 -0500
Received: by vbbfc26 with SMTP id fc26so1263149vbb.19
        for <linux-input@vger.kernel.org>; Wed, 14 Dec 2011 22:24:45 -0800 (PST)
In-Reply-To: <CACrgxGAUYW0E3cLradFJ8SAYBjszWjYdsfrFBAZN6R7a0NO41w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Dimitry,

2011/12/12 Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Hi Zhang,
>
> On Wed, Dec 07, 2011 at 05:10:02PM +0800, Zhang Jiejing wrote:
> > egalax_ts use threaded_irq to report touch event, it will wake up t=
he
> > irq thread and stop the thread irq after process one touch event, s=
o
> > even user touch the screen very fast, the fastest event report spee=
d
> > is depends on the scheduler, so the event reported is a uniform spe=
ed.
>
> I am not sure what you mean by "the event reported is a uniform speed=
"
> but since I2C operations generally sleep you are at the mercy of
> scheduler anyways. But since IRQ thread is a real-time one it should =
get
> scheduled immediately.

I'm using 2.6.38 kernel and Android 4.0 and with a Freescale ARM
A9(1.0GHz) Soc doing this test, but in my test, if I sweep on the
touch screen with very fast speed, my UI can't move as fast as my
finger,
I first suspect our GPU not powerful to drive UI, but after test with
USB mouse doing same sweep operation, the UI was moving quite fast.

So I made this change, after made this change, I can't feed any lay
between finger and the UI animation.
I think the threaded_irq not quite real time.

I checked kernel/irq/handle.c file,
I found in handle_IRQ_event() functin, it will use
wake_up_processs(action->thread);=A0 and the thread was created by
kthread_create() in __setup_irq() function.

I think in this implementation, it will be not so realtime, it depends
on schedule time.
>
>
> >
> > This patch will let thread irq check the gpio's status, if the gpio
> > is down, means still have more events, it will not exit the irq han=
dler
> > and continue process another new event, it can improve user experie=
nce.
>
> Does it really or it is your opinion that it would?
>
As I mentioned in above, I got this result with a real machine and
environment=A0 test.
>
> Also, your change means that the driver can not be stopped/unloaded a=
s
> long as user had finger on the touchpad. This would need to be correc=
ted
> (but first you need to prove that the change is actually needed).
>


I need test in the driver unload case and suspend case.

Thanks for you advance.

BR,
Jiejing

>
> Thanks.
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
