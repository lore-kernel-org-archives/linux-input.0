From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/hid: slab-out-of-bounds read in usbhid_parse
Date: Wed, 20 Sep 2017 12:49:28 +0200
Message-ID: <CAAeHK+yELqVWqUrk+y0Mm9ZwKc=ScSt886Y6hQ144O_-HKWYLQ@mail.gmail.com>
References: <CAAeHK+zcrxkjP2=8rhzc-nV8WGb0mM9hJ5XVjW9Xexvmb91srQ@mail.gmail.com>
 <CAL6iAaKJBVVAP81JL3Cs7Yy5np3=FpAN18L3_NQy18wRnRZpYw@mail.gmail.com>
 <CAAeHK+y4FuBqMKEzaeKDyqbuSHGDKhmRJ2QQmH4LUG1iSDdrqQ@mail.gmail.com> <CAL6iAa+Pd83Z0zA-26cvEbMxmH7r0QbUzi9XZowoEiZ8emZv+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL6iAa+Pd83Z0zA-26cvEbMxmH7r0QbUzi9XZowoEiZ8emZv+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Jaejoong <climbbb.kim@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 20, 2017 at 6:57 AM, Kim Jaejoong <climbbb.kim@gmail.com> wrote:
> Hi Andrey
>
> 2017-09-19 21:38 GMT+09:00 Andrey Konovalov <andreyknvl@google.com>:
>> Hi Kim,
>>
>> I'm not sure. Is there a check on the bLength field of a
>> hid_descriptor struct? Can it be less than sizeof(struct
>> hid_descriptor)? If so, we still do an out-of-bounds access to
>> hdesc->desc[0] (or some other fields).
>
> You are right. I add hid descriptr size from HID device with bLength field.
>
> Could you test and review below patch?

It seems that this patch fixes the issue. I'll keep fuzzing to make sure.

Tested-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

>
> To. usb & input guys.
>
> While dig this report, i was wondering about bNumDescriptors in HID descriptor.
> HID document from usb.org said, 'this number must be at least one (1)
> as a Report descriptor will always be present.'
>
> There is no mention of the order of class descriptors. Suppose you
> have a HID device with a report descriptor and a physical descriptor.
>
> If you have the following hid descriptor in this case,
> HID descriptor
>    bLength: 12
>    bDescriptor Type: HID
>    .. skip
>    bNumDescriptors: 2
>    bDescriptorType: physical
>    bDescriptorLength: any
>    bDescriptorType: Report
>    bDescriptorLength: any
>
> If the order of the report descriptor is the second as above,
> usbhid_parse () will fail because my patch is only check the first
> bDescriptor Type.
> But If the order of the report descriptor is always first, there is no
> problem. How do you think this?
>
> Thanks, jaejoong
>
> -----------------
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 089bad8..94c3805 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -974,7 +974,7 @@ static int usbhid_parse(struct hid_device *hid)
>         u32 quirks = 0;
>         unsigned int rsize = 0;
>         char *rdesc;
> -       int ret, n;
> +       int ret;
>
>         quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
>                         le16_to_cpu(dev->descriptor.idProduct));
> @@ -997,12 +997,16 @@ static int usbhid_parse(struct hid_device *hid)
>                 return -ENODEV;
>         }
>
> +       if (hdesc->bLength < sizeof(*hdesc)) {
> +               dbg_hid("hid descriptor is too short\n");
> +               return -EINVAL;
> +       }
> +
>         hid->version = le16_to_cpu(hdesc->bcdHID);
>         hid->country = hdesc->bCountryCode;
>
> -       for (n = 0; n < hdesc->bNumDescriptors; n++)
> -               if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
> -                       rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
> +       if (hdesc->desc[0].bDescriptorType == HID_DT_REPORT)
> +               rsize = le16_to_cpu(hdesc->desc[0].wDescriptorLength);
>
>         if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
>                 dbg_hid("weird size of report descriptor (%u)\n", rsize);
> -----------
>
