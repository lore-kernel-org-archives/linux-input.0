From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH 3/5] input.h: add keycodes for Fn Lock
Date: Tue, 30 Jul 2013 06:56:39 -0300
Message-ID: <20130730065639.7ebf490b@samsung.com>
References: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
 <1375070379-329-3-git-send-email-m.chehab@samsung.com>
 <20130729045358.GC8539@core.coreip.homeip.net>
 <20130729070346.0cad1ace@samsung.com>
 <20130730071413.GA19291@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:51316 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab3G3J4p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 05:56:45 -0400
Received: from uscpsbgm1.samsung.com
 (u114.gpu85.samsung.co.kr [203.254.195.114]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MQQ00EPPUAGDF10@mailout1.w2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 30 Jul 2013 05:56:44 -0400 (EDT)
In-reply-to: <20130730071413.GA19291@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Em Tue, 30 Jul 2013 00:14:13 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> On Mon, Jul 29, 2013 at 07:03:46AM -0300, Mauro Carvalho Chehab wrote:
> > Hi Dmitry,
> > 
> > Em Sun, 28 Jul 2013 21:53:58 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:
> > 
> > > Hi Mauro,
> > > 
> > > On Mon, Jul 29, 2013 at 12:59:37AM -0300, Mauro Carvalho Chehab wrote:
> > > > Samsung notebooks have a FN LOCK key. It works like CAPS LOCK or NUM
> > > > LOCK keys.
> > > > 
> > > > When FN LOCK key is pressed, any further press to a key with a blue label
> > > > on it (Fn keys) will produce the alternate code.
> > > > 
> > > > Another press makes the keyboard to return to its normal state.
> > > > 
> > > > On the notebooks where such feature were found, a FN LOCK on event
> > > > produces scancode 0xa8, and a FN LOCK off event produces scancode 0xa9.
> > > > 
> > > > Yet, it is better to reserve some space at the keymap to allow some
> > > > different implementation of this feature where the same keycode might
> > > > be used.
> > > > 
> > > > Also, as this is actually a switch, add a switch indicator to report
> > > > when this switch is set/reset.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
> > > > ---
> > > >  include/uapi/linux/input.h | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> > > > index d584047..4622c34 100644
> > > > --- a/include/uapi/linux/input.h
> > > > +++ b/include/uapi/linux/input.h
> > > > @@ -716,6 +716,10 @@ struct input_keymap_entry {
> > > >  #define BTN_DPAD_LEFT		0x222
> > > >  #define BTN_DPAD_RIGHT		0x223
> > > >  
> > > > +#define KEY_FNLOCK_TOGGLE	0x224	/* Request switch Fn on or off */
> > > > +#define KEY_FNLOCK_ON		0x225
> > > > +#define KEY_FNLOCK_OFF		0x226
> > > > +
> > > >  #define BTN_TRIGGER_HAPPY		0x2c0
> > > >  #define BTN_TRIGGER_HAPPY1		0x2c0
> > > >  #define BTN_TRIGGER_HAPPY2		0x2c1
> > > > @@ -853,6 +857,7 @@ struct input_keymap_entry {
> > > >  #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
> > > >  #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
> > > >  #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
> > > > +#define SW_FNLOCK		0x0e  /* set = Fn locked */
> > > 
> > > I am not sure if we need both the keys and the switch, so I would
> > > probably simply go with the keys, and not bother with switch. Then we do
> > > not need to touch the atkbd driver at all and rely on udev to set up the
> > > keymap and force release keys. 
> > 
> > The hole idea of doing those patches is to have an userspace tool that will
> > be able to show software LEDs, like mate-applet-lockeys, that will query
> > the input driver to know the current status. So, the better is to keep 
> > control of it as soon as kernel starts controlling the Keyboard, as, 
> > otherwise, the software LED indicators may be wrong.
> > 
> > If you think that having both keycodes and a switch is an overkill, then
> > the better is to just keep the switch.
> 
> Yes, we should have either the keys or the switch.

OK.

> I am a bit concerned with the behavior of this FN key and whether the state
> can be reported reliably. Have you tested the behavior of keyboard when you
> press the FN key before atkbd driver had a chance to bind to it?

If I press FN LOCK at grub2, or before that, it simply doesn't work.

I suspect that something at the atkbd initialization (or, more likely, at ACPI
initialization) makes the BIOS to enable it.

I did a quick inspection at ACPI DSDT table, but I wasn't able to discover
anything there. The BIOS don't have explicit support for Linux.

> What
> about suspending with FN engaged and then resuming? Suspend-to-disk
> behavior?

I tested calling both pm-suspend and pm-hibernate here: Fn Lock state was
recovered properly. On a normal reboot, Fn Lock behavior resets.

So, it seems that there's something already in resume code that restores
Fn Lock to the state before suspend.

Regards,
Mauro
