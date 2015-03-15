From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCH] HID: uclogic: make input_mapping independent of usb
Date: Sun, 15 Mar 2015 13:09:27 -0400 (EDT)
Message-ID: <56663020.26988234.1426439367944.JavaMail.zimbra@redhat.com>
References: <1426261322-7451-1-git-send-email-benjamin.tissoires@redhat.com> <55048364.3000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55048364.3000204@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


----- Original Message -----
> From: "Nikolai Kondrashov" <spbnick@gmail.com>
> To: "Benjamin Tissoires" <benjamin.tissoires@redhat.com>, "Jiri Kosina" <jkosina@suse.cz>
> Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
> Sent: Saturday, March 14, 2015 2:52:20 PM
> Subject: Re: [PATCH] HID: uclogic: make input_mapping independent of usb
> 
> On 03/13/2015 05:42 PM, Benjamin Tissoires wrote:
> > No need to retrieve the USB handle in input_mapping() when we already
> > do that in probe. It also allows to use the quirk without having to
> > add the product ID matching.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >
> > Nick,
> >
> > no need to cc DIGImend-devel when replying on this one, I'll send the same
> > to DIGImend-devel as soon as I have a patchwork link.
> >
> > Cheers,
> > Benjamin
> >
> >   drivers/hid/hid-uclogic.c | 17 ++++++++---------
> >   1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> > index bdda9fd..6473e83 100644
> > --- a/drivers/hid/hid-uclogic.c
> > +++ b/drivers/hid/hid-uclogic.c
> > @@ -627,6 +627,7 @@ struct uclogic_drvdata {
> >   	__u8 *rdesc;
> >   	unsigned int rsize;
> >   	bool invert_pen_inrange;
> > +	bool ignore_pen_interface;
> >   };
> >
> >   static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> > @@ -719,16 +720,12 @@ static int uclogic_input_mapping(struct hid_device
> > *hdev, struct hid_input *hi,
> >   		struct hid_field *field, struct hid_usage *usage,
> >   		unsigned long **bit, int *max)
> >   {
> > -	struct usb_interface *intf;
> > -
> > -	if (hdev->product == USB_DEVICE_ID_HUION_TABLET) {
> > -		intf = to_usb_interface(hdev->dev.parent);
> > +	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
> >
> > -		/* discard the unused pen interface */
> > -		if ((intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
> > -		    (field->application == HID_DG_PEN))
> > -			return -1;
> > -	}
> > +	/* discard the unused pen interface */
> > +	if ((drvdata->ignore_pen_interface) &&
> > +	    (field->application == HID_DG_PEN))
> > +		return -1;
> >
> >   	/* let hid-core decide what to do */
> >   	return 0;
> > @@ -908,6 +905,8 @@ static int uclogic_probe(struct hid_device *hdev,
> >   				return rc;
> >   			}
> >   			drvdata->invert_pen_inrange = true;
> > +		} else {
> > +			drvdata->ignore_pen_interface = true;
> >   		}
> >   		break;
> >   	}
> 
> This looks fine to me logically, but the "ignore_pen_interface" name is a bit
> confusing.
> 
>  From the driver code and comments it follows that "pen interface" is the USB
> interface #0 and we're not ignoring it (uclogic_probe code becomes the worst
> here).  I think that it is better to call it in terms of what the
> "input_mapping" description says, i.e. "ignore_pen_usage".
> 

Sure, ignore_pen_usage is perfectly fine. Will do a v2 this afternoon hopefully.

Cheers,
Benjamin
