From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/2] HID: huion: enable button mode reporting
Date: Wed, 18 Feb 2015 12:11:59 +0200
Message-ID: <54E4656F.4070708@gmail.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com> <1424213653-5970-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424213653-5970-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 02/18/2015 12:54 AM, Benjamin Tissoires wrote:
> diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
> index 61b68ca..50fbda4 100644
> --- a/drivers/hid/hid-huion.c
> +++ b/drivers/hid/hid-huion.c
> @@ -34,6 +34,9 @@ enum huion_ph_id {
>   	HUION_PH_ID_NUM
>   };
>
> +/* header of a button report sent through the Pen report */
> +static const u8 button_report[]  =3D {0x07, 0xa0, 0x01, 0x01};

Hmm, I see the second byte being 0xe0 on Huion H610, the rest is the sa=
me.
Considering this, the fact that bit 7 is always 1 and bit 6 is pen prox=
imity,
I think we can assume that bit 5 in byte 2 indicates button reports and=
 get
away with just a "data[1] & 0x20" test.

>   /* Report descriptor template placeholder */
>   #define HUION_PH(_ID) HUION_PH_HEAD, HUION_PH_ID_##_ID
>
> @@ -81,6 +84,31 @@ static const __u8 huion_tablet_rdesc_template[] =3D=
 {
>   	HUION_PH(PRESSURE_LM),  /*          Logical Maximum (PLACEHOLDER),=
  */
>   	0x81, 0x02,             /*          Input (Variable),             =
  */
>   	0xC0,                   /*      End Collection,                   =
  */
> +	0x05, 0x01,             /*      Usage Page (Desktop)               =
 */
> +	0x09, 0x07,             /*      Usage (Keypad)                     =
 */
> +	0xa1, 0x01,             /*      Collection (Application)           =
 */
> +	0x85, 0x08,             /*          Report ID (8)                  =
 */
> +	0x05, 0x0d,             /*          Usage Page (Digitizers)        =
 */
> +	0x09, 0x22,             /*          Usage (Finger)                 =
 */

I'd say "Finger" usage is wrong here. The spec says:

     Finger

         CL =96 Any human appendage used as a transducer, such as a fin=
ger
         touching a touch screen to set the location of the screen curs=
or.  A
         digitizer typically reports the coordinates of center of the f=
inger.
         In the Finger collection a Pointer physical collection will co=
ntain
         the axes reported by the finger.

I.e. the buttons are not a pointing device. The specification contains =
another
collection usage which seems more suitable:

     Tablet Function Keys

         CL =96 These controls are located on the surface of a digitizi=
ng tablet,
         and may be implemented as actual switches, or as soft keys act=
uated by
         the digitizing transducer. These are often used to trigger
         location-independent macros or other events.

However the kernel doesn't seem to know anything about it (but we can f=
ix
that). In my version of this I simply used a keyboard with buttons:

     0x05, 0x01,             /*  Usage Page (Desktop),                 =
  */
     0x09, 0x06,             /*  Usage (Keyboard),                     =
  */
     0xA1, 0x01,             /*  Collection (Application),             =
  */
     0x85, 0xF7,             /*      Report ID (247),                  =
  */
     0x05, 0x09,             /*      Usage Page (Button),              =
  */
     0x75, 0x01,             /*      Report Size (1),                  =
  */
     0x95, 0x18,             /*      Report Count (24),                =
  */
     0x81, 0x03,             /*      Input (Constant, Variable),       =
  */
     0x19, 0x01,             /*      Usage Minimum (01h),              =
  */
     0x29, 0x08,             /*      Usage Maximum (08h),              =
  */
     0x95, 0x08,             /*      Report Count (8),                 =
  */
     0x81, 0x02,             /*      Input (Variable),                 =
  */
     0xC0                    /*  End Collection                        =
  */

Although it might not be entirely correct either.

> +	0xa0,                   /*          Collection (Physical)          =
 */
> +	0x14,                   /*              Logical Minimum (0)        =
 */
> +	0x25, 0x01,             /*              Logical Maximum (1)        =
 */
> +	0x75, 0x08,             /*              Report Size (8)            =
 */
> +	0x95, 0x03,             /*              Report Count (3)           =
 */
> +	0x81, 0x03,             /*              Input (Cnst,Var,Abs)       =
 */
> +	0x05, 0x09,             /*              Usage Page (Button)        =
 */
> +	0x19, 0x01,             /*              Usage Minimum (1)          =
 */
> +	0x29, 0x08,             /*              Usage Maximum (8)          =
 */
> +	0x14,                   /*              Logical Minimum (0)        =
 */
> +	0x25, 0x01,             /*              Logical Maximum (1)        =
 */
> +	0x75, 0x01,             /*              Report Size (1)            =
 */
> +	0x95, 0x08,             /*              Report Count (8)           =
 */
> +	0x81, 0x02,             /*              Input (Data,Var,Abs)       =
 */
> +	0x75, 0x08,             /*              Report Size (8)            =
 */
> +	0x95, 0x03,             /*              Report Count (3)           =
 */
> +	0x81, 0x03,             /*              Input (Cnst,Var,Abs)       =
 */
> +	0xc0,                   /*          End Collection                 =
 */
> +	0xc0,                   /*      End Collection                     =
 */

Which tool did you use to generate this?

>   	0xC0                    /*  End Collection                        =
  */
>   };
>
> @@ -205,6 +233,25 @@ static int huion_tablet_enable(struct hid_device=
 *hdev)
>   		}
>   	}
>
> +	/* switch to the button mode reporting */
> +	rc =3D usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
> +				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> +				(USB_DT_STRING << 8) + 0x7b,
> +				0x0409, buf, len,
> +				USB_CTRL_GET_TIMEOUT);

I'm a bit uncomfortable about reusing a buffer which was sized specific=
ally
for another task, as it's confusing. But it will work as is, so it's OK=
=2E

> +	if (rc =3D=3D -EPIPE) {
> +		hid_err(hdev, "button mode switch not found\n");
> +		rc =3D -ENODEV;
> +		goto cleanup;
> +	} else if (rc < 0) {
> +		hid_err(hdev, "failed to switch to button mode: %d\n", rc);
> +		rc =3D -ENODEV;
> +		goto cleanup;
> +	} else if (rc !=3D len) {
> +		hid_err(hdev, "invalid button mode switch\n");
> +		rc =3D -ENODEV;
> +		goto cleanup;
> +	}
>   	rc =3D 0;
>
>   cleanup:
> @@ -262,10 +309,16 @@ static int huion_raw_event(struct hid_device *h=
dev, struct hid_report *report,
>   	/* If this is a pen input report */
>   	if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 0 &&
>   	    report->type =3D=3D HID_INPUT_REPORT &&
> -	    report->id =3D=3D 0x07 && size >=3D 2)
> +	    report->id =3D=3D 0x07 && size >=3D 2) {
>   		/* Invert the in-range bit */
>   		data[1] ^=3D 0x40;
>
> +		/* check for buttons events and change the report ID */
> +		if (size >=3D sizeof(button_report) &&
> +		    !memcmp(data, button_report, sizeof(button_report)))

So, yes, I think it's better to have a "data[1] & 0x20" test here inste=
ad.

> +			data[0] =3D 0x08;
> +	}
> +
>   	return 0;
>   }
>
>

Nick
