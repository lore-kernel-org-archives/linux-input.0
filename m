From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Tue, 14 Oct 2008 11:12:36 -0400
Message-ID: <20081014111236.2495140c@infradead.org>
References: <1223993968942@dmwebmail.dmwebmail.chezphil.org>
	<20081014104442.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54903 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYJNPMe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 11:12:34 -0400
In-Reply-To: <20081014104442.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Phil Endecott <phil_dubhl_endecott@chezphil.org>, linux-input <linux-input@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

On Tue, 14 Oct 2008 10:54:36 -0400
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Phil,
> 
> On Tue, Oct 14, 2008 at 03:19:28PM +0100, Phil Endecott wrote:
> > Dear All,
> >
> > I am seeing a 2-second pause while booting which I hypothesize is
> > due to a locking interaction between the mouse system and the
> > platform bus system. Here's a fragment from dmesg:
> >
> > [    2.202156] serio: i8042 KBD port at 0x60,0x64 irq 1
> > [    2.202170] serio: i8042 AUX port at 0x60,0x64 irq 12
> > [    2.202183] initcall i8042_init+0x0/0x32a returned 0 after 29
> > msecs [    2.202191] calling  serio_raw_init+0x0/0x11 @ 1
> > [    2.202345] initcall serio_raw_init+0x0/0x11 returned 0 after 0
> > msecs [    2.202356] calling  mousedev_init+0x0/0x72 @ 1
> > [    2.202638] mice: PS/2 mouse device common for all mice
> > [    2.202648] initcall mousedev_init+0x0/0x72 returned 0 after 0
> > msecs [    2.202657] calling  evdev_init+0x0/0xa @ 1
> > [    2.208739] initcall evdev_init+0x0/0xa returned 0 after 5 msecs
> > [    2.208746] calling  atkbd_init+0x0/0x1b @ 1
> > [    2.208855] initcall atkbd_init+0x0/0x1b returned 0 after 0 msecs
> > [    2.208864] calling  psmouse_init+0x0/0x58 @ 1
> > [    2.232546] input: AT Translated Set 2 keyboard
> > as /class/input/input5 [    2.247037] initcall
> > psmouse_init+0x0/0x58 returned 0 after 36 msecs [    2.247047]
> > calling  pcspkr_init+0x0/0xa @ 1 [    2.247067] pcspkr_probe
> > starting [    2.249202] input: PC Speaker as /class/input/input6
> > [    2.259239] pcspkr_probe done
> > [    4.379527] input: ImPS/2 Logitech Wheel Mouse
> > as /class/input/input7 [    4.387077] initcall pcspkr_init+0x0/0xa
> > returned 0 after 2040 msecs
> >
> > Note that the pause is between pcspkr_probe returning and
> > pcspkr_init returning.  My guess is that during this time the
> > platform bus is matching the pcspkr driver against all the other
> > platform devices, and in order to do so it is taking various device
> > locks; at the same time the kpsmoused workqueue is locking one of
> > the same devices and spending a couple of seconds probing it.  But
> > that's only a guess based on a couple of hours work; no doubt you
> > experts will have a better idea of what's going on.
> >
> 
> Hmm, I am not sure here. Psmouse module works on serio bus (with
> devices registered by i8042). The real probing is offloaded to kseriod
> as it may take a while (as in couple of seconds) to go through all
> possible mice protocols - you can see it because psmouse_init returns
> early, before the mouse is detected. Pcspkr works on platform bus. The
> only thing they share is input device registration but I don't believe
> we get stuck there. I wonder if this is a sign of scheduling problem
> early in the boot, lets CC Ingo and see if he has any ideas.
> 
> > What can be done about this?  Is it unreasonable for the mouse
> > probing to take 2 seconds?  Should it not be holding the
> > conflicting lock while it is probing?  Does the platform matching
> > code really need to hold the lock when it's just comparing the
> > string names of the device and driver?
> >

the real thing is to not wait on this while booting;
my fastboot git tree has the patches to fix that part..


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
