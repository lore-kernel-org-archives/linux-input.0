From: Wayne Thomas <waynethomas69@gmail.com>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
	quirky remote
Date: Mon, 18 Jan 2010 11:33:09 +0100
Message-ID: <3711715e1001180233k36072dd2r518c0b388bc8d475@mail.gmail.com>
References: <3711715e0912310013u25e921cbqe6abb7c1621109e@mail.gmail.com>
	 <20100102025312.GC5788@core.coreip.homeip.net>
	 <3711715e1001020152s626739daw6cdf2d7742a0d959@mail.gmail.com>
	 <alpine.LNX.2.00.1001022221320.2277@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:57331 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab0ARKdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 05:33:11 -0500
Received: by ey-out-2122.google.com with SMTP id d26so652429eyd.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jan 2010 02:33:09 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001022221320.2277@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sat, Jan 2, 2010 at 10:25 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sat, 2 Jan 2010, Wayne Thomas wrote:
>
>> >> The Behavior Tech. Computer Corp. (BTC) remote branded as "Emprex=
 3009URF III
>> >> Vista Remote Controller" uses non-standard mappings for all of it=
s 'special
>> >> purpose' keys (0xffbc usage page). =A0Applies cleanly to 2.6.30 a=
nd 2.6.32
>> >> (other versions not tested).
>> >> scripts/scriptpatch.pl reports 13 styling errors in hid-btc.c
>> >> ("break;" should be on trailing lines)
>> >> but have not changed them to maintain styling consistency with ex=
isting drivers.
>> >
>> > I believe that this kind of mapping adjustment can be done via UDE=
V/HAL
>> > key remapping facilities, without need for the kernel patch.
>>
>> I'll look into what you have suggested. =A0The issue is identical to
>> that of the TopSeed remote, which is why I used this method. =A0If t=
his
>> is the case I assume that the topseed driver (and any others) should
>> also be removed?
>
> Hi Wayne,
>
> unfortunately you have a point here.
>
> Moving all the drivers which don't do anything else than establish si=
mple
> HID->input mappings (such as your driver, or the TopSpeed one), into
> userspace (udev, please note that HAL is now deprecated), has been on=
 my
> TODO list for quite a long time.
>
> But there has unfortunately always been something more important, so =
I
> have been quite sluggish with this.
>
> If you'd be submitting your changes for BTC to udev, it would be cool=
 if
> you could do the same for other drivers we now have in kernel, so tha=
t
> they could be removed one day.
> Otherwise I'll do it hopefully soon, I will push it in my TODO a litt=
le
> bit higher as a new-year's resolution :)
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
>

Jiri/Dmitry,
I've had a look around in the udev source code for an idea of how you
intend on this to be implemented, but unfortunately couldn't find a
sutiable example to examine.  As such I wont be of much use to you
with in this regard.
Something I did note however was that there is at least five different
quirky drivers that are using the 0x0ffbc0000 HID usage page (defined
as HID_UP_LOGIVENDOR), a handful of which do nothing more than capture
the keypresses from this usage page.  Comparing the keys in question I
realised that they could have been captured under a single quirky
driver, if not in hid-input itself.  It appears to me that a new
generation of Windows MCE remote devices are coming onto the market
that are using this usage page as standard.  I was going to fiddle
around with this but instead will wait to see how this will be
implemented in udev.
Sorry I couldn't relieve some of your work-load.

Cheers
Wayne
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
