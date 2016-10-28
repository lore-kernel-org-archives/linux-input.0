From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Fri, 28 Oct 2016 14:44:31 +0200
Message-ID: <2186645.hbFdEOdHp0@wuerfel>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com> <CABeXuvookKiZOHQUAPpajBvAGMSqOqJZYP843s=Do+eYxmiGZA@mail.gmail.com> <20161028044642.GA28017@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028044642.GA28017@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>
List-Id: linux-input@vger.kernel.org

On Friday, October 28, 2016 2:46:42 PM CEST Peter Hutterer wrote:
> On Thu, Oct 27, 2016 at 03:24:55PM -0700, Deepa Dinamani wrote:
> > On Wed, Oct 26, 2016 at 7:56 PM, Peter Hutterer
> > <peter.hutterer@who-t.net> wrote:
> > > On Mon, Oct 17, 2016 at 08:27:32PM -0700, Deepa Dinamani wrote:
> > > general comment here - please don't name it "raw_input_event".
> > > First, when you grep for input_event you want the new ones to show up too,
> > > so a struct input_event_raw would be better here. That also has better
> > > namespacing in general. Second though: the event isn't any more "raw" than
> > > the previous we had.
> > >
> > > I can't think of anything better than struct input_event_v2 though.
> > 
> > The general idea was to leave the original struct input_event as a
> > common interface for userspace (as it cannot be deleted).
> > So reading raw data unformatted by the userspace will have the new
> > struct raw_input_event format.
> > This was the reason for the "raw" in the name.
> > 
> > struct input_event_v2 is fine too, if this is more preferred.

I think input_event_v2 would be more confusing. An alternative
to raw_input_event might be __kernel_input_event, which parallels
things like __kernel_off_t that is also independent from the user
space off_t in the same way that the user space input_event
structure will get redefined in a way that is incompatible with
the kernel ABI.

> > >> This replaces timeval with struct input_timeval. This structure
> > >> maintains time in __kernel_ulong_t or compat_ulong_t to allow
> > >> for architectures to override types as in the case of x32.
> > >>
> > >> The change requires any userspace utilities reading or writing
> > >> from event nodes to update their reading format to match
> > >> raw_input_event. The changes to the popular libraries will be
> > >> posted along with the kernel changes.
> > >> The driver version is also updated to reflect the change in
> > >> event format.
> > >
> > > Doesn't this break *all* of userspace then? I don't see anything to
> > > negotiate the type of input event the kernel gives me. And nothing right now
> > > checks for EVDEV_VERSION, so they all just assume it's a struct
> > > input_event. Best case, if the available events aren't a multiple of
> > > sizeof(struct input_event) userspace will bomb out, but unless that happens,
> > > everyone will just happily read old-style events.
> > >
> > > So we need some negotiation what is acceptable. Which also needs to address
> > > the race conditions we're going to get when events start coming in before
> > > the client has announced that it supports the new-style events.
> > 
> > No, this does not break any userspace right now.
> > Both struct input_event and struct raw_input_event are exactly the same today.
> 
> oh, right, the ABI is the same. I see that now, thanks.

One minor difference is that the seconds in raw_input_event are
'unsigned', so even with the 'real' time domain, we can represent
times from 1970 to 2106, whereas 'timeval' represents times between
1902 and 2038.

Once user space has a 64-bit time_t and the conversion function
in libinput that Deepa suggested, the raw_input_event is only
used on the kernel ABI and the normal timestamps will work fine.

> > And, hence any library that results in a call to libevdev_set_fd()
> > will fail if it is not this updated driver.
> 
> without having seen the libevdev patch - that sounds like a bad idea . there
> are plenty of usecases where libevdev_set_fd() is called but timestamps in
> events just don't matter. So we may need need some more negotiation between
> the library user, libevdev and the kernel.

I also don't see any strict dependency at all: the binary data format
has not changed, and I agree we absolutely should not break running
a newly built library on old kernels.

We can also safely assume that any user space that is actually built
for 64-bit time_t is also running on a recent enough kernel,
as today's kernels do not support 64-bit time_t yet.

	Arnd
