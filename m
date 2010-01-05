From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Tue, 5 Jan 2010 08:14:12 +0800
Message-ID: <45a44e481001041614i35ceef84q5f12a068e2f0b97b@mail.gmail.com>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
	 <20091216103423.GE1377@ucw.cz>
	 <alpine.LNX.2.00.0912161504360.3755@pobox.suse.cz>
	 <7f9100aac5f9b06ec78efff25c7a5a71.squirrel@intranet.cs.nmsu.edu>
	 <20100104224817.GA21695@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.223.194]:47076 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab0AEAOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2010 19:14:14 -0500
In-Reply-To: <20100104224817.GA21695@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, krzysztof.h1@wp.pl, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org

On Tue, Jan 5, 2010 at 6:48 AM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Ok, but I guess you should cc auxdisplay people in future.

Hi Pavel,

I just looked at the drivers/auxdisplay directory and got a bit
confused. The reason I got confused is because auxdisplay is actually
an fbdev driver but it is outside of the drivers/video directory. It
looks like there has only been 1 commit and that was for the Samsung
KS0108 controller. It also sort of uses platform support but the way
it is abstracted is odd to my thinking. The controller is ks0108, so
in my mind that would be the code that would be platform independent,
and then that would use a board specific IO driver to push data (eg:
parport or gpio or usb). I think in the long term it would probably
make sense to write a cleaner approach with a drivers/video/ks0108.c
which is cleanly platform independent (and back within fbdev proper)
and then a board specific driver in the appropriate location that
handles the IO.

Thanks,
jaya
