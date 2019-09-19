From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH v3 3/3] HID: core: fix dmesg flooding if report field
 larger than 32bit
Date: Wed, 18 Sep 2019 23:28:35 -0400
Message-ID: <CAMB+bfL9RWzCs_FHrLRsQwsvBBSOBEiUq_ApniLpSUkiOtJvvQ@mail.gmail.com>
References: <20190812152022.27963-1-stillcompiling@gmail.com>
 <20190812152022.27963-4-stillcompiling@gmail.com> <CAMB+bfK9Oge1T96aJkuvpoAdUSsm+YxY1W70b62gUMMBKfD8vg@mail.gmail.com>
 <CAO-hwJLVS0G+TtShbBQ6j9_aCAKjb_AsvoN2HkR+zKpd98MKRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJLVS0G+TtShbBQ6j9_aCAKjb_AsvoN2HkR+zKpd98MKRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>
List-Id: linux-input@vger.kernel.org

Thanks!
It means a lot to have this accepted.
I actually started working on it, thinking "how hard can it be to
increase the size of a data structure"? It only has to be forward
compatible anyway.
My gut feeling is the existing code is working way too hard to do what
should be a memcpy, and the impulse to "fix" it is strong, despite my
absolute lack of usb-hid experience.

But the history of this little bit of code is already fraught with
complaints about big endian breakage.
I'm tempted to make it much simpler for size>32 bits (fix it only for
future users), or just way simpler for little endian,
But what do I know about usb and big endian? I sure don't have the
equipment to test it. And I worry a little I might be forgetting some
oddball non-byte-aligned data structure, which the spec would
theoretically allow.
Perhaps I'll have to time and courage to take another stab.

~Joshua

On Wed, Sep 18, 2019 at 11:35 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Thu, Aug 29, 2019 at 1:26 AM Joshua Clayton <stillcompiling@gmail.com> wrote:
> >
> > ping?
> > I'd love to see this get in.
> > with distro kernel I have effectively no dmesg due to this issue
>
> Apologies for the delay.
>
> I really thought we should find a better way of fixing this, until I
> got a laptop affected by it. This series is a must have.
>
> Applied to for-5.4/core
>
> Cheers,
> Benjamin
>
> >
> > On Mon, Aug 12, 2019 at 9:20 AM <stillcompiling@gmail.com> wrote:
> > >
> > > From: Joshua Clayton <stillcompiling@gmail.com>
> > >
> > > Only warn once of oversize hid report value field
> > >
> > > On HP spectre x360 convertible the message:
> > > hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
> > > is continually printed many times per second, crowding out all else.
> > > Protect dmesg by printing the warning only one time.
> > >
> > > The size of the hid report field data structure should probably be increased.
> > > The data structure is treated as a u32 in Linux, but an unlimited number
> > > of bits in the USB hid spec, so there is some rearchitecture needed now that
> > > devices are sending more than 32 bits.
> > >
> > > Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> > >
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 210b81a56e1a..3eaee2c37931 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -1311,8 +1311,8 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
> > >                         unsigned offset, unsigned n)
> > >  {
> > >         if (n > 32) {
> > > -               hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> > > -                        n, current->comm);
> > > +               hid_warn_once(hid, "%s() called with n (%d) > 32! (%s)\n",
> > > +                             __func__, n, current->comm);
> > >                 n = 32;
> > >         }
> > >
> > > --
> > > 2.21.0
> > >
>
