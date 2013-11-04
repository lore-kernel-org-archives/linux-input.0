From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: About the PS3 Sixaxis linux driver
Date: Mon, 4 Nov 2013 22:18:24 +0100
Message-ID: <20131104221824.2bd181e60f01f41e1e4f4898@studenti.unina.it>
References: <526A697E.7050605@corpsmoderne.net>
	<1256411740.1745741.1383597450835.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:18081 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009Ab3KDVSp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Nov 2013 16:18:45 -0500
In-Reply-To: <1256411740.1745741.1383597450835.JavaMail.root@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <btissoir@redhat.com>
Cc: case <case@corpsmoderne.net>, linux-input@vger.kernel.org

On Mon, 4 Nov 2013 15:37:30 -0500 (EST)
Benjamin Tissoires <btissoir@redhat.com> wrote:

> Hi Marc,
> 
> (adding in CC the linux-input mailing list)
> 
> Regarding your problem I vaguely remember something about not having duplicated axis with the buttons. My memory is rather confuse about this, so I may be wrong (but others on the list may have a fresher memory).
> Other than that, if only one axis is not working, then it is definitively a bug...
>

The problem with the left D-PAD should be the one I talk about here:
http://www.spinics.net/lists/linux-input/msg16881.html

Basically the keycode is a multi-touch one and it gets discarded being
the device not a MT one.

I was told the hack I came up with is not OK for mainline, but people
can apply it locally for the time being.

> I'll try to add this to my todo list, but I can not guarantee anything soon. If someone else can confirm and fix this, I'll be happy.
>

Will remapping just the faulty keycode be enough?

Actually I intended to rewrite the whole HID descriptor and add a sane
mapping for all the buttons (maybe following the Gamepad API and
even using the new ABS_ACCEL_* and ABS_GYRO_* events from David
Hermann).

I may try to do some work along these lines myself in the next weeks
but I cannot promise an ETA either.

Marc, if you need the latest BlueZ patches for pairing the sixaxis for
BT operation just let me know.

Ciao,
   Antonio

> Cheers,
> Benjamin
> 
> ----- Original Message -----
> From: "case" <case@corpsmoderne.net>
> To: "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
> Sent: Friday, October 25, 2013 8:52:14 AM
> Subject: About the PS3 Sixaxis linux driver
> 
> Hello Benjamin,
> 
> I'm mailing you because it seems you're one of the kernel developers
> the most involved with the hid-sony.c driver lately, with which I think
> I've an issue. If you feel like I'm mailing the wrong person,
> I apologize, and would be glad if you could point me to the right
> person.
> 
> I'm a game developer experimenting with the sixaxis for a while, and
> I've a big issue with the current state of the driver:
> 
> On the sixaxis all the buttons (except select and start) are mapped
> as buttons but also as axis, which is pretty rad. That was working great
> in 2010 when I started to experiment with the sixaxis but in more
> recent versions of the kernel, one the the buttons has lost his axis.
> It's the left button the the D-PAD, witch is only mapped as button 7
> (up is button 4 and axis 8, right is button 5 axis 9, bottom is button
> 6 axis 10).
>
> This is quite inconsistent and makes impossible to rely on the axis for
> all the D-PAD buttons.
> 
> Again, this bug wasn't there in 2.6.32 . I noticed it for the first time
> in 3.5.x . I'm currently running 3.11.0 and this bug is still here.
> 
> As my experience with kernel hacking is minimal I'm not even sure
> the problem lies in hid-sony, but that's where my investigations lead
> me.
> 
> Thank you to have taken the time to read my mail, I hope it will help
> to fix this issue, and again, sorry if you're not the right person to
> write to.
> 
> Regards,
> -- 
> Marc Planard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
