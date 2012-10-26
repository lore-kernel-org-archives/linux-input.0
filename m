From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] hid: put the case in the right switch statement
Date: Fri, 26 Oct 2012 10:39:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210261038230.19184@pobox.suse.cz>
References: <20121025143512.17155.56181.stgit@localhost.localdomain> <CAN+gG=GX8XSnURKpG4HCMU6tL_tVpPBVOwdr3ksyXrzkrsKL_g@mail.gmail.com> <CAN+gG=EsrqM745WOoNmU1ai4omEwRUjmUJBkLYG5UOgAFcaKYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN+gG=EsrqM745WOoNmU1ai4omEwRUjmUJBkLYG5UOgAFcaKYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 26 Oct 2012, Benjamin Tissoires wrote:

> Adding Jiri to the recipient list of the patch, otherwise, the thread
> may fall in the depth of his mailbox :)
> 
> Cheers,
> Benjamin
> 
> On Thu, Oct 25, 2012 at 7:08 PM, Benjamin Tissoires
> <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi Alan,
> >
> > Yes, I saw that too.
> >
> > Acked-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > On Thu, Oct 25, 2012 at 4:35 PM, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
> >> From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >>
> >> Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >> ---
> >>
> >>  drivers/hid/hid-multitouch.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> >> index 3eb02b9..c97011c 100644
> >> --- a/drivers/hid/hid-multitouch.c
> >> +++ b/drivers/hid/hid-multitouch.c
> >> @@ -421,11 +421,11 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
> >>                          * contact max are global to the report */
> >>                         td->last_field_index = field->index;
> >>                         return -1;
> >> -               }
> >>                 case HID_DG_TOUCH:
> >>                         /* Legacy devices use TIPSWITCH and not TOUCH.
> >>                          * Let's just ignore this field. */
> >>                         return -1;
> >> +               }
> >>                 /* let hid-input decide for the others */
> >>                 return 0;
> >>
> >>

Good catch, thanks. Applying.

Alan, please don't forget to CC proper maintainers on such patches. 
Patches tend to often get lost when sent only to mailinglists 
unfortunately.

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
