From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/3] HID: logitech-hidpp: use devres to manage FF private data
Date: Sat, 12 Oct 2019 00:34:30 +0200
Message-ID: <CAO-hwJJjiMdKMGoAEyxXN0+Kc0mBPC_KZn-YoHBx8gWfD=RM3g@mail.gmail.com>
References: <20191007051240.4410-1-andrew.smirnov@gmail.com>
 <20191007051240.4410-2-andrew.smirnov@gmail.com> <CAO-hwJ+jPGa5Z7=Lopsc23m8UOqGWB0=tN+DcotykseAPM7_7w@mail.gmail.com>
 <20191011182617.GE229325@dtor-ws> <CAO-hwJLH6SMkLb1kZGj1E+BUHJ+ZsE1n+d=xeJgsvTCjHH1Wzw@mail.gmail.com>
 <20191011203303.GF229325@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191011203303.GF229325@dtor-ws>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Sam Bazely <sambazley@fastmail.com>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 11, 2019 at 10:33 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Oct 11, 2019 at 09:25:52PM +0200, Benjamin Tissoires wrote:
> > On Fri, Oct 11, 2019 at 8:26 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Oct 11, 2019 at 04:52:04PM +0200, Benjamin Tissoires wrote:
> > > > Hi Andrey,
> > > >
> > > > On Mon, Oct 7, 2019 at 7:13 AM Andrey Smirnov <andrew.smirnov@gmail=
.com> wrote:
> > > > >
> > > > > To simplify resource management in commit that follows as well as=
 to
> > > > > save a couple of extra kfree()s and simplify hidpp_ff_deinit() sw=
itch
> > > > > driver code to use devres to manage the life-cycle of FF private =
data.
> > > > >
> > > > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > > > Cc: Jiri Kosina <jikos@kernel.org>
> > > > > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > > Cc: Henrik Rydberg <rydberg@bitmath.org>
> > > > > Cc: Sam Bazely <sambazley@fastmail.com>
> > > > > Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> > > > > Cc: Austin Palmer <austinp@valvesoftware.com>
> > > > > Cc: linux-input@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: stable@vger.kernel.org
> > > >
> > > > This patch doesn't seem to fix any error, is there a reason to send=
 it
> > > > to stable? (besides as a dependency of the rest of the series).
> > > >
> > > > > ---
> > > > >  drivers/hid/hid-logitech-hidpp.c | 53 +++++++++++++++++---------=
------
> > > > >  1 file changed, 29 insertions(+), 24 deletions(-)
> > > > >
> > > > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-l=
ogitech-hidpp.c
> > > > > index 0179f7ed77e5..58eb928224e5 100644
> > > > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > > > @@ -2079,6 +2079,11 @@ static void hidpp_ff_destroy(struct ff_dev=
ice *ff)
> > > > >         struct hidpp_ff_private_data *data =3D ff->private;
> > > > >
> > > > >         kfree(data->effect_ids);
> > > >
> > > > Is there any reasons we can not also devm alloc data->effect_ids?
> > > >
> > > > > +       /*
> > > > > +        * Set private to NULL to prevent input_ff_destroy() from
> > > > > +        * freeing our devres allocated memory
> > > >
> > > > Ouch. There is something wrong here: input_ff_destroy() calls
> > > > kfree(ff->private), when the data has not been allocated by
> > > > input_ff_create(). This seems to lack a little bit of symmetry.
> > >
> > > Yeah, ff and ff-memless essentially take over the private data assign=
ed
> > > to them. They were done before devm and the lifetime of the "private"
> > > data pieces was tied to the lifetime of the input device to simplify
> > > error handling and teardown.
> >
> > Yeah, that stealing of the pointer is not good :)
> > But OTOH, it helps
> >
> > >
> > > Maybe we should clean it up a bit... I'm open to suggestions.
> >
> > The problem I had when doing the review was that there is no easy way
> > to have a "devm_input_ff_create_()", because the way it's built is
> > already "devres-compatible": the destroy gets called by input core.
>
> I do not think we want devm_input_ff_create() explicitly, I think the
> fact that you can "build up" an input device by allocating it, then
> adding slots, poller, ff support, etc, and input core cleans it up is
> all good. It is just the ownership if the driver-private data block is
> not very obvious and is not compatible with allocating via devm.

Yep, that's what I meant: input_ff_create() already handles its
cleanup, so there is no point in devm_input_ff_create() as the input
core should clean it up for us.

Cheers,
Benjamin

>
> >
> > So I don't have a good answer to simplify in a transparent manner
> > without breaking the API.
> >
> > >
> > > In this case maybe best way is to get rid of hidpp_ff_destroy() and n=
ot
> > > set ff->private and rely on devm to free the buffers. One can get to
> > > device private data from ff methods via input_get_drvdata() since the=
y
> > > all (except destroy) are passed input device pointer.
> >
> > Sounds like a good idea. However, it seems there might be a race when
> > removing the workqueue:
> > the workqueue gets deleted in hidpp_remove, when the input node will
> > be freed by devres, so after the call of hidpp_remove.
>
> Yeah, well, that is a common issue with mixing devm and normal resources
> (and workqueue here is that "normal" resource), and we should either:
>
> - not use devm
> - use devm_add_action_or_reset() to work in custom actions that work
>   freeing of non-managed resources into devm flow.
>
> Thanks.
>
> --
> Dmitry
