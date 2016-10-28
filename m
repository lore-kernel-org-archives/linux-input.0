From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2 1/4] uinput: Add ioctl for using monotonic/ boot times
Date: Fri, 28 Oct 2016 14:32:57 +1000
Message-ID: <20161028043257.GA27182@jelly>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
 <1476761253-13450-2-git-send-email-deepa.kernel@gmail.com>
 <20161027014509.GB14832@jelly>
 <CABeXuvoKpW52kd3mR0bBcDSqyRJOZ8tP0oMS8p5UkzzOHtzPpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:53105 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbcJ1EdJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 00:33:09 -0400
Content-Disposition: inline
In-Reply-To: <CABeXuvoKpW52kd3mR0bBcDSqyRJOZ8tP0oMS8p5UkzzOHtzPpQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>

On Thu, Oct 27, 2016 at 01:39:30PM -0700, Deepa Dinamani wrote:
> > hmm, I'm a bit confused here. This is an in-kernel bit only (passing the
> > time through uinput events has no effect). So why do we need an ioctl here?
> > it's an in-kernel decision only anyway and the time in the events sent to
> > the evdev client should be dictated by what that client sets for the clock
> > type, right?
> 
> This is for input events queued by the uinput driver for the virtual
> input device.

oh, right. I thought this was in the path for uinput_write(). sorry about
that.

> This can be read through uinput_read() fops.
> I don't think anybody is doing a read on uinput nodes, so another
> option(Arnd and I considered this) could be not supporting reads on
> these nodes at all.
> 
> This is not related to evdev events in the kernel.
> Currently, this timestamp could be the same format as the evdev
> timestamps or not.

I can say I've never done the read from the uinput device, never even
occured to me. quick skim of the code looks like this only matters for
force_feedback stuff. can't really comment on that too much.

Cheers,
   Peter
