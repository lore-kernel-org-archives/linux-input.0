From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] input: remove unneeded DRIVER_LICENSE #defines
Date: Sat, 18 Nov 2017 13:49:42 +0100
Message-ID: <20171118124942.GA31864@kroah.com>
References: <20171117141720.GB17880@kroah.com>
 <20171117203313.l7lqzrun5bnuj2ht@dtor-ws>
 <20171118102724.GF8368@kroah.com>
 <CAOFm3uEScMh9PmQMuGvUY39sw=0iJhs0BezQHUhg2-KWZ1fRuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59272 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966502AbdKRMti (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 07:49:38 -0500
Content-Disposition: inline
In-Reply-To: <CAOFm3uEScMh9PmQMuGvUY39sw=0iJhs0BezQHUhg2-KWZ1fRuQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Sat, Nov 18, 2017 at 01:39:03PM +0100, Philippe Ombredanne wrote:
> On Sat, Nov 18, 2017 at 11:27 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Please do, I got rid of all of the DRIVER_VERSION crap in the
> > drivers/usb/ tree a release or so ago, as they make no sense at all.
> > The other defines are also really silly and can be cleaned up too.
> >
> > Want me to do that for drivers/input/ for you?
> >
> > thanks,
> >
> > greg "I'm a janitor now" k-h
> 
> 
> Thing could get worse: you could become a documentalist like tglx turned into.
> 
> For the fun, another weird thingie that I once stumbled upon in an
> out-of-tree third-party module:
> 
> MODULE_LICENSE("\x47\x50\x4c\x20\x76\x32");
> 
> ... which was most likely from a GPL-shy closet Free software
> advocate: this is "GPL v2" in ASCII.

Hah, we've seen worse with people trying to put '0x00' in the middle of
the string to fake out the string checking logic.  Whenever stuff like
that gets pointed out to the legal department of the company involved,
stuff gets fixed fast, trying to 'circumvent' a license check is really
frowned apon by almost all legal juristictions :)

So, if you want to point that code out to me offline, I'm sure I could
have some fun...

thanks,

greg k-h
