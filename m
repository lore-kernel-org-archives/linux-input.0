From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] HID: logitech-hidpp: use devres to manage FF private
 data
Date: Fri, 11 Oct 2019 14:11:08 -0700
Message-ID: <20191011211108.GI229325@dtor-ws>
References: <20191007051240.4410-1-andrew.smirnov@gmail.com>
 <20191007051240.4410-2-andrew.smirnov@gmail.com>
 <CAO-hwJ+jPGa5Z7=Lopsc23m8UOqGWB0=tN+DcotykseAPM7_7w@mail.gmail.com>
 <20191011182617.GE229325@dtor-ws>
 <CAO-hwJLH6SMkLb1kZGj1E+BUHJ+ZsE1n+d=xeJgsvTCjHH1Wzw@mail.gmail.com>
 <20191011203303.GF229325@dtor-ws>
 <CAHQ1cqFc-7BpgZuinLakHAjT=6XNzcsQE=RFHOw2xu4Gqdpeog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHQ1cqFc-7BpgZuinLakHAjT=6XNzcsQE=RFHOw2xu4Gqdpeog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Sam Bazely <sambazley@fastmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 02:02:30PM -0700, Andrey Smirnov wrote:
> On Fri, Oct 11, 2019 at 1:33 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Oct 11, 2019 at 09:25:52PM +0200, Benjamin Tissoires wrote:
> > > On Fri, Oct 11, 2019 at 8:26 PM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > On Fri, Oct 11, 2019 at 04:52:04PM +0200, Benjamin Tissoires wrote:
> > > > > Hi Andrey,
> > > > >
> > > > > On Mon, Oct 7, 2019 at 7:13 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> > > > > >
> > > > > > To simplify resource management in commit that follows as well as to
> > > > > > save a couple of extra kfree()s and simplify hidpp_ff_deinit() switch
> > > > > > driver code to use devres to manage the life-cycle of FF private data.
> > > > > >
> > > > > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > > > > Cc: Jiri Kosina <jikos@kernel.org>
> > > > > > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > > > Cc: Henrik Rydberg <rydberg@bitmath.org>
> > > > > > Cc: Sam Bazely <sambazley@fastmail.com>
> > > > > > Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> > > > > > Cc: Austin Palmer <austinp@valvesoftware.com>
> > > > > > Cc: linux-input@vger.kernel.org
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: stable@vger.kernel.org
> > > > >
> > > > > This patch doesn't seem to fix any error, is there a reason to send it
> > > > > to stable? (besides as a dependency of the rest of the series).
> > > > >
> > > > > > ---
> > > > > >  drivers/hid/hid-logitech-hidpp.c | 53 +++++++++++++++++---------------
> > > > > >  1 file changed, 29 insertions(+), 24 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > > > > > index 0179f7ed77e5..58eb928224e5 100644
> > > > > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > > > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > > > > @@ -2079,6 +2079,11 @@ static void hidpp_ff_destroy(struct ff_device *ff)
> > > > > >         struct hidpp_ff_private_data *data = ff->private;
> > > > > >
> > > > > >         kfree(data->effect_ids);
> > > > >
> > > > > Is there any reasons we can not also devm alloc data->effect_ids?
> > > > >
> > > > > > +       /*
> > > > > > +        * Set private to NULL to prevent input_ff_destroy() from
> > > > > > +        * freeing our devres allocated memory
> > > > >
> > > > > Ouch. There is something wrong here: input_ff_destroy() calls
> > > > > kfree(ff->private), when the data has not been allocated by
> > > > > input_ff_create(). This seems to lack a little bit of symmetry.
> > > >
> > > > Yeah, ff and ff-memless essentially take over the private data assigned
> > > > to them. They were done before devm and the lifetime of the "private"
> > > > data pieces was tied to the lifetime of the input device to simplify
> > > > error handling and teardown.
> > >
> > > Yeah, that stealing of the pointer is not good :)
> > > But OTOH, it helps
> > >
> > > >
> > > > Maybe we should clean it up a bit... I'm open to suggestions.
> > >
> > > The problem I had when doing the review was that there is no easy way
> > > to have a "devm_input_ff_create_()", because the way it's built is
> > > already "devres-compatible": the destroy gets called by input core.
> >
> > I do not think we want devm_input_ff_create() explicitly, I think the
> > fact that you can "build up" an input device by allocating it, then
> > adding slots, poller, ff support, etc, and input core cleans it up is
> > all good. It is just the ownership if the driver-private data block is
> > not very obvious and is not compatible with allocating via devm.
> >
> 
> What do you think of creating input_ff_create_with_private() which
> would take a pointer to private memory and set a new
> "borrowed_private" flag in struct ff_device which input_ff_destroy()
> can check to determine if it needs to free ->private or not?

>From my quick check we only have 3 users of ff->private in the tree:

dtor@dtor-ws:~/kernel/master (next)$ git grep -l "[^a-z]ff\->private" -- drivers/
drivers/hid/hid-logitech-hidpp.c
drivers/hid/usbhid/hid-pidff.c
drivers/input/ff-core.c
drivers/input/ff-memless.c

and I really wonder if we actually need to have this pointer and
maintain it, given that logitech driver appears to not needing it that
much...

Thanks.

-- 
Dmitry
