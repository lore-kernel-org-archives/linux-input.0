From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Fri, 28 Oct 2016 14:46:42 +1000
Message-ID: <20161028044642.GA28017@jelly>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
 <1476761253-13450-4-git-send-email-deepa.kernel@gmail.com>
 <20161027025616.GC14832@jelly>
 <CABeXuvookKiZOHQUAPpajBvAGMSqOqJZYP843s=Do+eYxmiGZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:54602 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755777AbcJ1Eqv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 00:46:51 -0400
Content-Disposition: inline
In-Reply-To: <CABeXuvookKiZOHQUAPpajBvAGMSqOqJZYP843s=Do+eYxmiGZA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>

On Thu, Oct 27, 2016 at 03:24:55PM -0700, Deepa Dinamani wrote:
> On Wed, Oct 26, 2016 at 7:56 PM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > On Mon, Oct 17, 2016 at 08:27:32PM -0700, Deepa Dinamani wrote:
> >> struct timeval is not y2038 safe.
> >> All usage of timeval in the kernel will be replaced by
> >> y2038 safe structures.
> >>
> >> struct input_event maintains time for each input event.
> >> Real time timestamps are not ideal for input as this
> >> time can go backwards as noted in the patch a80b83b7b8
> >> by John Stultz. Hence, having the input_event.time fields
> >> only big enough for monotonic and boot times are
> >> sufficient.
> >>
> >> Leave the original input_event as is. This is to maintain
> >> backward compatibility with existing userspace interfaces
> >> that use input_event.
> >> Introduce a new replacement struct raw_input_event.
> >
> > general comment here - please don't name it "raw_input_event".
> > First, when you grep for input_event you want the new ones to show up too,
> > so a struct input_event_raw would be better here. That also has better
> > namespacing in general. Second though: the event isn't any more "raw" than
> > the previous we had.
> >
> > I can't think of anything better than struct input_event_v2 though.
> 
> The general idea was to leave the original struct input_event as a
> common interface for userspace (as it cannot be deleted).
> So reading raw data unformatted by the userspace will have the new
> struct raw_input_event format.
> This was the reason for the "raw" in the name.
> 
> struct input_event_v2 is fine too, if this is more preferred.
> 
> >> This replaces timeval with struct input_timeval. This structure
> >> maintains time in __kernel_ulong_t or compat_ulong_t to allow
> >> for architectures to override types as in the case of x32.
> >>
> >> The change requires any userspace utilities reading or writing
> >> from event nodes to update their reading format to match
> >> raw_input_event. The changes to the popular libraries will be
> >> posted along with the kernel changes.
> >> The driver version is also updated to reflect the change in
> >> event format.
> >
> > Doesn't this break *all* of userspace then? I don't see anything to
> > negotiate the type of input event the kernel gives me. And nothing right now
> > checks for EVDEV_VERSION, so they all just assume it's a struct
> > input_event. Best case, if the available events aren't a multiple of
> > sizeof(struct input_event) userspace will bomb out, but unless that happens,
> > everyone will just happily read old-style events.
> >
> > So we need some negotiation what is acceptable. Which also needs to address
> > the race conditions we're going to get when events start coming in before
> > the client has announced that it supports the new-style events.
> 
> No, this does not break any userspace right now.
> Both struct input_event and struct raw_input_event are exactly the same today.

oh, right, the ABI is the same. I see that now, thanks.

> This will be the case until a 2038-safe glibc is used with a 64 bit time_t flag.
> 
> So these are the scenarios:
> 1. old kernel driver + new userspace
>   -- should still be ok until 2038. Version checks could help discover these
> 2. new kernel driver + old userspace (without recompiled with new 2038 gblic)
>   -- works because the format is really the same.
> 
> The patch I posted to libevdev checks this driver version.

btw, where did you post the libevdev patch? I haven't seen it anywhere I'm
subscribed to.

> And, hence any library that results in a call to libevdev_set_fd()
> will fail if it is not this updated driver.

without having seen the libevdev patch - that sounds like a bad idea . there
are plenty of usecases where libevdev_set_fd() is called but timestamps in
events just don't matter. So we may need need some more negotiation between
the library user, libevdev and the kernel.

Cheers,
   Peter

> We could just do a similar check in every library also.
> I think the latter would be better.
> 
> So, the kernel patches can go in as a no-op right now and then I can
> add version checks to respective user space libraries.

