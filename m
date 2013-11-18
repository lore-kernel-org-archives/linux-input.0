From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3
 USB
Date: Mon, 18 Nov 2013 16:27:20 +0100
Message-ID: <20131118162720.a8be1c71577a82bbc4406fc7@studenti.unina.it>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
	<1567991.TNa7UhjX8Q@sven-desktop>
	<20131117232559.d2791ac2c278f56630aa41a7@studenti.unina.it>
	<5434362.OvDlhOjSJd@sven-edge>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:63276 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3KRP13 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 10:27:29 -0500
In-Reply-To: <5434362.OvDlhOjSJd@sven-edge>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>

On Mon, 18 Nov 2013 00:12:14 +0100
Sven Eckelmann <sven@narfation.org> wrote:

> On Sunday 17 November 2013 23:25:59 Antonio Ospite wrote:
> > Sven, if you are going to resubmit another patch for this functionality
> > (I've seen your v2 just before hitting "Send"), wouldn't it be better
> > to advertise just FF_RUMBLE? AFAICS your first patch results in this
> > (from evtest):
> > 
> > ....
> >   Event type 21 (EV_FF)
> >     Event code 80 (FF_RUMBLE)
> >     Event code 81 (FF_PERIODIC)
> >     Event code 88 (FF_SQUARE)
> >     Event code 89 (FF_TRIANGLE)
> >     Event code 90 (FF_SINE)
> >     Event code 96 (FF_GAIN)
> 
> I don't set them, ff_memless is doing that in input_ff_create_memless:
> 
> 	/* we can emulate periodic effects with RUMBLE */
> 	if (test_bit(FF_RUMBLE, ff->ffbit)) {
> 		set_bit(FF_PERIODIC, dev->ffbit);
> 		set_bit(FF_SINE, dev->ffbit);
> 		set_bit(FF_TRIANGLE, dev->ffbit);
> 		set_bit(FF_SQUARE, dev->ffbit);
> 	}
>

I see now, thanks.

> > Also please make sure that setting the rumble does not change the LEDs
> > status if there is any set: HID output report 1 is used for both LEDs
> > and rumble. In the bluez plugin[1] I plan on setting LEDs from userspace
> > to match the joystick number, just as the PS3 does, it would be strange
> > for the user if a rumble event would reset the LEDs status.
> 
> I never used the LEDs and therefore cannot say anything about it (I don't have 
> a specification for the used command format). Maybe I can try to play with 
> them next week.
> 
> But you're patch has some comments in set_leds. Do I correctly interpret the 
> byte 10 in leds_report as "only make changes to following LEDs"? So setting it 
> to 1 would make the command not change the LEDs at all?
>

That would be an interesting approach, I'll do some experiment about
that too.

> > Maybe only send up to the rumble related bytes, or do a
> > read-modify-write if that is possible with HID output reports, if this
> > cannot be done we will have to design a solution to set LEDs too in the
> > kernel, in order to be able to keep some status around.
> 
> The in-kernel state seems to be interesting because it is already done for the 
> Sony Buzz LEDs. But I this is only a wild guess because I've never checked 
> this code path and never used it.
> 
> > Last comment, if we want a conditional config what about using
> > CONFIG_HID_SONY_FF instead of CONFIG_SONY_FF? Not a big deal of course,
> > just a suggestion.
> 
> Most other hid devices omit the HID_ part in the _FF setting. This is also the 
> reason why I've removed it too.
>

OK, I didn't know, I guess I am fine with that if others are doing so
too.

> $ grep 'config ' ./drivers/hid/Kconfig|grep -B1 _FF
[...]

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
