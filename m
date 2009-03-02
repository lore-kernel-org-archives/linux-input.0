From: Mike Murphy <mamurph@cs.clemson.edu>
Subject: Re: PATCH [1/3] drivers/input/xpad.c: Improve Xbox 360 wireless
	support and add sysfs interface
Date: Mon, 2 Mar 2009 17:27:41 -0500
Message-ID: <5aa163d00903021427v4088e29alac4350f9006d5a35@mail.gmail.com>
References: <5aa163d00902282053h38b0febbyb37fc30855fdc985@mail.gmail.com>
	 <20090302130425.23cc628d.akpm@linux-foundation.org>
	 <5aa163d00903021346g59d90241v11f384eb97641e43@mail.gmail.com>
	 <20090302140014.47b60178.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:11579 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbZCBW1o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 17:27:44 -0500
In-Reply-To: <20090302140014.47b60178.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, greg@kroah.com, oliver@neukum.org, fweisbec@gmail.com, torvalds@linux-foundation.org

On Mon, Mar 2, 2009 at 5:00 PM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
>
> Yup, there's lots of crappy code in the tree, and it is regrettable
> that maintainers continue to go ahead and merge that crappy code.
>
> There's no easy fix for this - you need to be aware of what is right
> and what is wrong, but you cannot look at existing code to determine
> this :(

Part of the problem is that this is the first driver I've really
worked on to any extent... and all my formal kernel hacking training
was on FreeBSD, not Linux. Given the speed at which kernel development
moves, lack of good docs on how best to do development, etc., one
simply has to jump into the process and hope for the best. That's
awfully hard to do when kernel hacking isn't your full-time
occupation....

=46or example, my dissertation is on virtualization of grid computing
systems. I'm doing this driver development simply because I need the
driver for my own use... and perhaps one of our affiliated research
groups can use it. In my own research, I use Linux exclusively, but
all the work I do is at such a high level in userspace that I write
all my code in Python. I've taught C programming before and have done
a ton of low-level development in a C dialect for sensor networks
(nesC for TinyOS), so I'm comfortable with it. Even so, the kernel has
its own internal types (hence my unneeded typecasts), and it's not
always clear what type belongs where.

>
> If the code which you're modifying is known (by you) to be wrong then
> there are two schools of thought. =A0Some people do like to "match th=
e
> existing code". =A0I disagree with that. =A0The code's wrong dammit -=
 we
> might as well make the new code "right". =A0If that results in
> inconsistent-looking code, well, so be it. =A0We shouldn't have merge=
d
> the wrong code in the first place.
>
>

Agreed on the code being correct, but there always arises that
question about what constitutes "correct" in any given context
(provably dumb things, like dividing by zero, excepted). For example,
I broke the xpad driver into two pieces to make it easier to
understand. When I go to compile it, the #include "xpad.h" in xpad.c
literally causes the preprocessor to dump the contents of xpad.h into
xpad.c, before handing the result off to the compiler for conversion
to assembly. So the system doesn't really care what goes in which
file... that distinction is left to the humans, who have to establish
some kind of convention. But where is that convention documented?

I could make the argument, for example, that the table of different
Xbox devices and their properties should really go in the header file,
even though it generates an array. That table constitutes metadata
that the driver uses to map device ids to products, so from a software
engineering perspective, it is more of a configuration than an
executable segment. On the other hand, the only piece that really
cares about that data is the driver itself... userspace really only
cares about what type of device is actually connected. So from that
perspective, it belongs in the C file. But then, whose userspace code
is really going to include xpad.h? Circles are fun....

And perhaps this is why we academics tend not to write operating
systems that find their way into widespread use... instead ruminating
on "nicer" designs (perhaps with a microkernel, *cough*) over more
practical solutions :).

Mike
--=20
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838   Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
