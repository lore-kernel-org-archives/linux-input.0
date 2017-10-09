From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/misc/ims-pcu: slab-out-of-bounds in ims_pcu_parse_cdc_data
Date: Mon, 9 Oct 2017 13:14:49 +0200
Message-ID: <CAAeHK+zYCt1bgrK8FHEbWffgqf-ickFXaqZQBcdK1tdkNSbAHA@mail.gmail.com>
References: <CAAeHK+w_9oFs4=2PLY++EKgVme7KJ07F8AkOgwePdX+p2tK1qQ@mail.gmail.com>
 <20171007181433.GA14355@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171007181433.GA14355@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 7, 2017 at 8:14 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Sep 28, 2017 at 01:35:51PM +0200, Andrey Konovalov wrote:
>> Hi!
>>
>> I've got the following report while fuzzing the kernel with syzkaller.
>>
>> On commit dc972a67cc54585bd83ad811c4e9b6ab3dcd427e (4.14-rc2+).
>>
>> There's no check that the length of intf->altsetting->extra is big
>> enough to hold usb_cdc_union_desc struct.
>
> Can you please tell me if the following works for you?
>
> Thanks!

Hi Dmitry,

I don't have a reproducer for this issue, but the fix looks good to
me. I'll apply and keep testing.

Thanks!

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

>
> --
> Dmitry
>
> Input: ims-psu - check if CDC union descriptor is sane
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Before trying to use CDC union descriptor, try to validate whether that it
> is sane by checking that intf->altsetting->extra is big enough and that
> descriptor bLength is not too big and not too small.
>
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/ims-pcu.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 6bf82ea8c918..ae473123583b 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1635,13 +1635,25 @@ ims_pcu_get_cdc_union_desc(struct usb_interface *intf)
>                 return NULL;
>         }
>
> -       while (buflen > 0) {
> +       while (buflen >= sizeof(*union_desc)) {
>                 union_desc = (struct usb_cdc_union_desc *)buf;
>
> +               if (union_desc->bLength > buflen) {
> +                       dev_err(&intf->dev, "Too large descriptor\n");
> +                       return NULL;
> +               }
> +
>                 if (union_desc->bDescriptorType == USB_DT_CS_INTERFACE &&
>                     union_desc->bDescriptorSubType == USB_CDC_UNION_TYPE) {
>                         dev_dbg(&intf->dev, "Found union header\n");
> -                       return union_desc;
> +
> +                       if (union_desc->bLength >= sizeof(*union_desc))
> +                               return union_desc;
> +
> +                       dev_err(&intf->dev,
> +                               "Union descriptor to short (%d vs %zd\n)",
> +                               union_desc->bLength, sizeof(*union_desc));
> +                       return NULL;
>                 }
>
>                 buflen -= union_desc->bLength;
