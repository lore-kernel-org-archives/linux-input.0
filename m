From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: quirks: fix support for Apple Magic Keyboards
Date: Wed, 17 Oct 2018 18:49:16 +0200
Message-ID: <CAO-hwJ+6Ksm6ZC85yUg86WEvfCvrBQ61OELepydx7ELYKGaqyQ@mail.gmail.com>
References: <20181017145201.7105-1-ncopa@alpinelinux.org> <CAO-hwJK4T5b0N5yc6wzeTioy-+PaoFgR7_Pq0y3MMi1=NXU2WA@mail.gmail.com>
 <20181017175515.798b2316@ncopa-desktop.copa.dup.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181017175515.798b2316@ncopa-desktop.copa.dup.pw>
Sender: stable-owner@vger.kernel.org
To: ncopa@alpinelinux.org, linux stable <stable@vger.kernel.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, seobrien@chromium.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 17, 2018 at 5:55 PM Natanael Copa <ncopa@alpinelinux.org> wrote:
>
> On Wed, 17 Oct 2018 16:59:15 +0200
> Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>
> > Hi Natanael,
> >
> > On Wed, Oct 17, 2018 at 4:52 PM Natanael Copa <ncopa@alpinelinux.org> wrote:
> > >
> > > Commit ee3454924370 ("HID: add support for Apple Magic Keyboards") added
> > > support for the Magic Keyboard over Bluetooth, but did not add the
> > > BT_VENDOR_ID_APPLE to hid-quirks. Fix this so hid-apple driver is used
> > > over hid-generic.
> > >
> > > This fixes the Fn key, which does not work at all with hid-generic.
> > >
> > > Fixes: ee3454924370 ("HID: add support for Apple Magic Keyboards")
> > > Bugzilla-id: https://bugzilla.kernel.org/show_bug.cgi?id=99881
> > > Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> > > ---
> > > This should be backported to stable too.
> > >
> > >  drivers/hid/hid-quirks.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > > index 249d49b6b16c..a3b3aecf8628 100644
> > > --- a/drivers/hid/hid-quirks.c
> > > +++ b/drivers/hid/hid-quirks.c
> > > @@ -270,6 +270,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
> > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO) },
> > >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
> > >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> > > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
> > > +       { HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
> > > +       { HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
> >
> > NACK, this should not be required with kernels v4.17+ IIRC.
> >
> > If it doesn't work on a recent kernel, please raise the issue, but I
> > am actually chasing down the new inclusions of these when we add new
> > device support.
>
> Fair enough. I think it may be needed for 4.14.y kernels though, to fix
> commit b6cc0ba2cbf4 (HID: add support for Apple Magic Keyboards).
>
> Fn key did not work without this patch on 4.14.76 for me.

Right, b6cc0ba2cbf4 has been added to 4.14.75 and is not working
because tweaking hid_have_special_driver[] is not required in current
kernels anymore.

@stable folks, would it be possible to take this patch in the v4.9 and
v4.14 trees? It can't go into Linus' tree, but I'd be glad to give my
Acked-by for a stable backport.

>
> > There is even a high chance that we remove the list entirely as this
> > would tremendously help the distributions to just have to ship
> > hid-generic in the initramfs instead of a bunch of random hid drivers.
>
> I doubt that distros will want Bluetooth keyboards there though. (which
> this is about)

I was talking more generally, killing this list of devices, as some
are keyboard and useful, and some are not needed as you say. But the
point is that distro folks won't have to decide which module to ship:
only hid-generic will be sufficient.

Cheers,
Benjamin

>
> > By the way, if the driver is not autoloaded by udev, it is a problem
> > in udev likely.
> >
> > Cheers,
> > Benjamin
> >
> > >         { HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
> > >     USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
> > >     { HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
> > >     USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) }, #endif --
> > > 2.19.1
> > >
>
