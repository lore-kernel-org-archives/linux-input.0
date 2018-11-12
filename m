From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: input: Ignore battery reported by Symbol DS4308
Date: Mon, 12 Nov 2018 12:12:57 +0100
Message-ID: <CAO-hwJJSn=dhoh_JuNhBDMz8w4w1xfcgxiHE_SbOXJucLUQ93g@mail.gmail.com>
References: <20181108235921.62193-1-bleung@chromium.org> <CAO-hwJ+FpX6evn-6J1TU6RmXq-3OhGGB21Qb4LdfNNcRuYkQEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+FpX6evn-6J1TU6RmXq-3OhGGB21Qb4LdfNNcRuYkQEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bleung@chromium.org
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 9, 2018 at 9:50 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Fri, Nov 9, 2018 at 12:59 AM Benson Leung <bleung@chromium.org> wrote:
> >
> > The Motorola/Zebra Symbol DS4308-HD is a handheld USB barcode scanner
> > which does not have a battery, but reports one anyway that always has
> > capacity 2.
> >
> > Let's apply the IGNORE quirk to prevent it from being treated like a
> > power supply so that userspaces don't get confused that this
> > accessory is almost out of power and warn the user that they need to charge
> > their wired barcode scanner.
> >
> > Reported here: https://bugs.chromium.org/p/chromium/issues/detail?id=804720
> >
> > Signed-off-by: Benson Leung <bleung@chromium.org>
> > ---
>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

And applied, thanks

>
> >  drivers/hid/hid-ids.h   | 1 +
> >  drivers/hid/hid-input.c | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index c0d668944dbe..07f6348b9f86 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -1043,6 +1043,7 @@
> >  #define USB_VENDOR_ID_SYMBOL           0x05e0
> >  #define USB_DEVICE_ID_SYMBOL_SCANNER_1 0x0800
> >  #define USB_DEVICE_ID_SYMBOL_SCANNER_2 0x1300
> > +#define USB_DEVICE_ID_SYMBOL_SCANNER_3 0x1200
> >
> >  #define USB_VENDOR_ID_SYNAPTICS                0x06cb
> >  #define USB_DEVICE_ID_SYNAPTICS_TP     0x0001
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index a2f74e6adc70..44ea8e7c71a9 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -325,6 +325,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
> >         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
> >                 USB_DEVICE_ID_ELECOM_BM084),
> >           HID_BATTERY_QUIRK_IGNORE },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
> > +               USB_DEVICE_ID_SYMBOL_SCANNER_3),
> > +         HID_BATTERY_QUIRK_IGNORE },
> >         {}
> >  };
> >
> > --
> > 2.19.1.930.g4563a0d9d0-goog
> >
