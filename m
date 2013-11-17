From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3
 USB
Date: Sun, 17 Nov 2013 23:25:59 +0100
Message-ID: <20131117232559.d2791ac2c278f56630aa41a7@studenti.unina.it>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
	<f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
	<1567991.TNa7UhjX8Q@sven-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:18712 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab3KQW0J (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 17:26:09 -0500
In-Reply-To: <1567991.TNa7UhjX8Q@sven-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>

On Sun, 17 Nov 2013 10:36:55 +0100
Sven Eckelmann <sven@narfation.org> wrote:

> On Saturday 16 November 2013 17:30:25 simon@mungewell.org wrote:
> > This patch appears to work OK with my DualShock/SixAxis controller (USB
> > connection), but causes a machine lockup when used with my Intec wired
> > controller.
> > 
> > The Intec controller works OK up to the point when I start rumble,
> > sometimes the motor runs some times it doesn't. I am using SDL2's
> > 'testhaptic' application.
> 
> Thanks a lot for this bug report. The testhaptic was a good testcase because 
> it is a heavy user and can reproduce the problem quite easily. I've only 
> tested it using testrumble and own programs which didn't seem to trigger the 
> problem here. The problem is easy to explain:
> 
>  * usb_control_msg/usb_interrupt_msg/usb_bulk_msg/... may sleep
>  * sony_play_effect may gets called in an softirq context (atomic)
> 
> So it is a bad choice to use hid_output_raw_report (which calls 
> usb_control_msg) in a ff_memless control function. I will just send a revert 
> patch in some minutes.
>

Sven, if you are going to resubmit another patch for this functionality
(I've seen your v2 just before hitting "Send"), wouldn't it be better
to advertise just FF_RUMBLE? AFAICS your first patch results in this
(from evtest):

....
  Event type 21 (EV_FF)
    Event code 80 (FF_RUMBLE)
    Event code 81 (FF_PERIODIC)
    Event code 88 (FF_SQUARE)
    Event code 89 (FF_TRIANGLE)
    Event code 90 (FF_SINE)
    Event code 96 (FF_GAIN)

I don't know if this is how it should be, I know nothing about FF stuff.

Also please make sure that setting the rumble does not change the LEDs
status if there is any set: HID output report 1 is used for both LEDs
and rumble. In the bluez plugin[1] I plan on setting LEDs from userspace
to match the joystick number, just as the PS3 does, it would be strange
for the user if a rumble event would reset the LEDs status.

Maybe only send up to the rumble related bytes, or do a
read-modify-write if that is possible with HID output reports, if this
cannot be done we will have to design a solution to set LEDs too in the
kernel, in order to be able to keep some status around.

Last comment, if we want a conditional config what about using
CONFIG_HID_SONY_FF instead of CONFIG_SONY_FF? Not a big deal of course,
just a suggestion.

Sorry for the late comments but I got to see the patch only after Jiri
had already picked it up.

Thanks,
   Antonio

[1] http://ao2.it/tmp/playstation-peripheral-pugin-v5.x-2013-11-13.patch

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
