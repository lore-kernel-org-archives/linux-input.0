From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Tue, 14 Oct 2008 10:54:36 -0400
Message-ID: <20081014104442.ZZRA012@mailhub.coreip.homeip.net>
References: <1223993968942@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40480 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbYJNOyl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 10:54:41 -0400
Received: by gxk9 with SMTP id 9so5228864gxk.13
        for <linux-input@vger.kernel.org>; Tue, 14 Oct 2008 07:54:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1223993968942@dmwebmail.dmwebmail.chezphil.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Phil Endecott <phil_dubhl_endecott@chezphil.org>
Cc: linux-input <linux-input@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

Hi Phil,

On Tue, Oct 14, 2008 at 03:19:28PM +0100, Phil Endecott wrote:
> Dear All,
>
> I am seeing a 2-second pause while booting which I hypothesize is due to a 
> locking interaction between the mouse system and the platform bus system.  
> Here's a fragment from dmesg:
>
> [    2.202156] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    2.202170] serio: i8042 AUX port at 0x60,0x64 irq 12
> [    2.202183] initcall i8042_init+0x0/0x32a returned 0 after 29 msecs
> [    2.202191] calling  serio_raw_init+0x0/0x11 @ 1
> [    2.202345] initcall serio_raw_init+0x0/0x11 returned 0 after 0 msecs
> [    2.202356] calling  mousedev_init+0x0/0x72 @ 1
> [    2.202638] mice: PS/2 mouse device common for all mice
> [    2.202648] initcall mousedev_init+0x0/0x72 returned 0 after 0 msecs
> [    2.202657] calling  evdev_init+0x0/0xa @ 1
> [    2.208739] initcall evdev_init+0x0/0xa returned 0 after 5 msecs
> [    2.208746] calling  atkbd_init+0x0/0x1b @ 1
> [    2.208855] initcall atkbd_init+0x0/0x1b returned 0 after 0 msecs
> [    2.208864] calling  psmouse_init+0x0/0x58 @ 1
> [    2.232546] input: AT Translated Set 2 keyboard as /class/input/input5
> [    2.247037] initcall psmouse_init+0x0/0x58 returned 0 after 36 msecs
> [    2.247047] calling  pcspkr_init+0x0/0xa @ 1
> [    2.247067] pcspkr_probe starting
> [    2.249202] input: PC Speaker as /class/input/input6
> [    2.259239] pcspkr_probe done
> [    4.379527] input: ImPS/2 Logitech Wheel Mouse as /class/input/input7
> [    4.387077] initcall pcspkr_init+0x0/0xa returned 0 after 2040 msecs
>
> Note that the pause is between pcspkr_probe returning and pcspkr_init 
> returning.  My guess is that during this time the platform bus is matching 
> the pcspkr driver against all the other platform devices, and in order to 
> do so it is taking various device locks; at the same time the kpsmoused 
> workqueue is locking one of the same devices and spending a couple of 
> seconds probing it.  But that's only a guess based on a couple of hours 
> work; no doubt you experts will have a better idea of what's going on.
>

Hmm, I am not sure here. Psmouse module works on serio bus (with
devices registered by i8042). The real probing is offloaded to kseriod
as it may take a while (as in couple of seconds) to go through all
possible mice protocols - you can see it because psmouse_init returns
early, before the mouse is detected. Pcspkr works on platform bus. The
only thing they share is input device registration but I don't believe
we get stuck there. I wonder if this is a sign of scheduling problem
early in the boot, lets CC Ingo and see if he has any ideas.

> What can be done about this?  Is it unreasonable for the mouse probing to 
> take 2 seconds?  Should it not be holding the conflicting lock while it is 
> probing?  Does the platform matching code really need to hold the lock when 
> it's just comparing the string names of the device and driver?
>
> This is on an ASUS Eee 901, which is the same machine that Arjan van de Ven 
> and Auke Kok have got to boot in 5 seconds (with only 1 second of that in 
> the kernel).  As you can see I have some way to go still.  I would also be 
> interested to hear if anyone knows what the touchpad in this machine really 
> is - is "ImPS/2 Logitech Wheel Mouse" right?  I'd like to be able to tweak 
> things like tap-to-click and two-finger scrolling.
>

I believe Eee PCs use Elantech touchpad for which we have a driver from
Arjan Opmeer which should be merged real soon now.

-- 
Dmitry
