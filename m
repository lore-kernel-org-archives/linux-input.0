From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: Re: [PATCH] Input: Add direction to ff-memless
Date: Tue, 08 Dec 2009 11:08:04 +0200
Message-ID: <1260263284.19783.1758.camel@tema>
References: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>
	 <4B1D70C4.9000603@iki.fi>
Reply-To: ext-jari.vanhala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19610 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZLHJIP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 04:08:15 -0500
In-Reply-To: <4B1D70C4.9000603@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2009-12-07 at 22:16 +0100, ext Anssi Hannula wrote:
> Jari Vanhala wrote:
> > This adds simple direction calculation to effect
> > combine. It's useful to decide motor direction for
> > rumble (vibrator).
> 
> Interesting. None of the existing rumble drivers use the direction
> field. I assume your device has two directions for the motor?

Motors can be driven forward and reverse.

> I'm somewhat suspicious if the motor direction matters at all, but I
> guess it could.

They feel a little different and chancing direction makes it briefly
stop. In one effect it's not that clear, but having effects with
different direction (in sequence) it's notable.

> > +static unsigned int ml_calculate_direction(
> > +	unsigned int direction, unsigned int force,
> > +	unsigned int new_direction, unsigned int new_force)
> > +{
> > +	return ((u32)direction * force + new_direction * new_force) /
> > +		(force + new_force);
> > +}
> 
> What if direction is 0xf000 and new_direction is 0x1000? The correct
> behaviour would be to use direction 0x0000 or so, but this code would
> return 0x8000 (assuming equal forces).

I know it's not perfect, but it's simple and gives good enough result.
And I just need to know which side of 0x8000 it is.

> We could also additionally carry the effect of directions into magnitude
> when summing the force vectors, so that two equal-magnitude rumbles with
> opposite directions would cancel themselves out. I'd be slightly against
> that, though, as rumble doesn't really have clear directions anyway.
> (just mentioning this in case someone thinks we should do that)

I also thought that, but magnitude is felt much more that direction. If
that direction used would be more than forward/reverse, it could make
sense.

	++Jam


