From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: usbhid: fix out-of-bounds bug
Date: Tue, 26 Sep 2017 16:22:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709261621440.1465-100000@iolanthe.rowland.org>
References: <CAL6iAa+jRzU4bNJq=XvyfuqwS+vx7FG==im3EWYRiat-Em7EMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL6iAa+jRzU4bNJq=XvyfuqwS+vx7FG==im3EWYRiat-Em7EMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: linux-input@vger.kernel.org

On Wed, 27 Sep 2017, Jaejoong Kim wrote:

> Hi, Alan,
> 
> Thanks for the review.
> 
> 2017-09-26 23:18 GMT+09:00 Alan Stern <stern@rowland.harvard.edu>:
> > On Tue, 26 Sep 2017, Jaejoong Kim wrote:
> >
> >> The starting address of the hid descriptor is obtained via
> >> usb_get_extra_descriptor(). If the hid descriptor has the wrong size, it
> >> is possible to access the wrong address. So, before accessing the hid
> >> descriptor, we need to check the entire size through the bLength field.
> >>
> >> It also shows how many class descriptors it has through the bNumDescriptors
> >> of the hid descriptor. Assuming that the connected hid descriptor has two
> >> class descriptors(report and physical descriptors), the code below can
> >> cause OOB because hdesc->desc is an array of size 1.
> >>
> >> for (n = 0; n < hdesc->bNumDescriptors; n++)
> >>       if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
> >>               rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
> >>
> >> Since we know the starting address of the hid descriptor and the value of
> >> the bNumDescriptors is variable, we directly access the buffer containing
> >> the hid descriptor without usbing hdesc->desc to obtain the size of the
> >> report descriptor.
> >
> > I do not like this patch at all.
> >
> >> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> >> index 089bad8..7bad173 100644
> >> --- a/drivers/hid/usbhid/hid-core.c
> >> +++ b/drivers/hid/usbhid/hid-core.c
> >> @@ -970,12 +970,19 @@ static int usbhid_parse(struct hid_device *hid)
> >>       struct usb_interface *intf = to_usb_interface(hid->dev.parent);
> >>       struct usb_host_interface *interface = intf->cur_altsetting;
> >>       struct usb_device *dev = interface_to_usbdev (intf);
> >> -     struct hid_descriptor *hdesc;
> >> +     unsigned char *buffer = intf->altsetting->extra;
> >> +     int buflen = intf->altsetting->extralen;
> >> +     int length;
> >>       u32 quirks = 0;
> >>       unsigned int rsize = 0;
> >>       char *rdesc;
> >>       int ret, n;
> >>
> >> +     if (!buffer) {
> >> +             dbg_hid("class descriptor not present\n");
> >> +             return -ENODEV;
> >> +     }
> >> +
> >>       quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
> >>                       le16_to_cpu(dev->descriptor.idProduct));
> >>
> >> @@ -990,19 +997,27 @@ static int usbhid_parse(struct hid_device *hid)
> >>                               quirks |= HID_QUIRK_NOGET;
> >>       }
> >>
> >> -     if (usb_get_extra_descriptor(interface, HID_DT_HID, &hdesc) &&
> >> -         (!interface->desc.bNumEndpoints ||
> >> -          usb_get_extra_descriptor(&interface->endpoint[0], HID_DT_HID, &hdesc))) {
> >> -             dbg_hid("class descriptor not present\n");
> >> -             return -ENODEV;
> >> -     }
> >> +     while (buflen > 2) {
> >> +             length = buffer[0];
> >> +             if (!length || length < HID_DESCRIPTOR_MIN_SIZE)
> >> +                     goto next_desc;
> >
> > It's silly to duplicate the code that is already present in
> > usb_get_extra_descriptor().  There's no reason to avoid using that
> > function here.
> 
> To be honest, I was fooled. You are right. That is a duplicate code
> with usb_get_extra_descriptor().
> 
> >
> >> -     hid->version = le16_to_cpu(hdesc->bcdHID);
> >> -     hid->country = hdesc->bCountryCode;
> >> +             if (buffer[1] == HID_DT_HID) {
> >> +                     hid->version = get_unaligned_le16(&buffer[2]);
> >> +                     hid->country = buffer[4];
> >
> > It's also silly not to use the preformatted hid_descriptor structure and
> > instead put error-prone byte offsets directly into the code.
> 
> Right.
> 
> >
> >> -     for (n = 0; n < hdesc->bNumDescriptors; n++)
> >> -             if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
> >> -                     rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
> >> +                     for (n = 0; n < buffer[5]; n++) {
> >> +                             /* we are just interested in report descriptor */
> >> +                             if (buffer[6+3*n] != HID_DT_REPORT)
> >> +                                     continue;
> >> +                             rsize = get_unaligned_le16(&buffer[7+3*n]);
> >
> > Finally, this patch doesn't fix the actual problem!  You don't check
> > here whether 8+3*n >= length.
> >
> > This whole thing could be fixed with a much smaller change to the
> > original code.  Just do something like this:
> >
> >         num_descriptors = min_t(int, hdesc->bNumDescriptors,
> >                         (hdesc->bLength - 6) / 3);
> >         for (n = 0; n < num_descriptors; n++)
> 
> Right. Your change is better and clear.
> With your change, I think we need check the size of hdesc before
> accessing hdesc->desc[n] as Andrey Konovalov has already pointed out,
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 089bad8..0b41d44 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -975,6 +975,7 @@ static int usbhid_parse(struct hid_device *hid)
>         unsigned int rsize = 0;
>         char *rdesc;
>         int ret, n;
> +       int num_descriptors;
> 
>         quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
>                         le16_to_cpu(dev->descriptor.idProduct));
> @@ -997,10 +998,17 @@ static int usbhid_parse(struct hid_device *hid)
>                 return -ENODEV;
>         }
> 
> +       if (hdesc->bLength < sizeof(struct hid_descriptor)) {
> +               dbg_hid("hid descriptor is too short\n");
> +               return -EINVAL;
> +       }
> +
>         hid->version = le16_to_cpu(hdesc->bcdHID);
>         hid->country = hdesc->bCountryCode;
> 
> -       for (n = 0; n < hdesc->bNumDescriptors; n++)
> +       num_descriptors = min_t(int, hdesc->bNumDescriptors,
> +                               (hdesc->bLength - 6) / 3);
> +       for (n = 0; n < num_descriptors; n++)
>                 if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
>                         rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);

Yes, this is a lot better.

Alan Stern
