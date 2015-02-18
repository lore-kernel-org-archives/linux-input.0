From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: huion: enable button mode reporting
Date: Wed, 18 Feb 2015 15:24:47 -0500
Message-ID: <20150218202447.GD5928@mail.corp.redhat.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
 <1424213653-5970-2-git-send-email-benjamin.tissoires@redhat.com>
 <54E4656F.4070708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E4656F.4070708@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Feb 18 2015 or thereabouts, Nikolai Kondrashov wrote:
> On 02/18/2015 12:54 AM, Benjamin Tissoires wrote:
> >diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
> >index 61b68ca..50fbda4 100644
> >--- a/drivers/hid/hid-huion.c
> >+++ b/drivers/hid/hid-huion.c
> >@@ -34,6 +34,9 @@ enum huion_ph_id {
> >  	HUION_PH_ID_NUM
> >  };
> >
> >+/* header of a button report sent through the Pen report */
> >+static const u8 button_report[]  =3D {0x07, 0xa0, 0x01, 0x01};
>=20
> Hmm, I see the second byte being 0xe0 on Huion H610, the rest is the =
same.
> Considering this, the fact that bit 7 is always 1 and bit 6 is pen pr=
oximity,
> I think we can assume that bit 5 in byte 2 indicates button reports a=
nd get
> away with just a "data[1] & 0x20" test.

that would be a nicer approach. Thanks for the analysis.
Actually, I understood the difference. I tested the bits _after_ the
driver reverts the in-range bit :)

The raw data is {0x07, 0xe0, 0x01, 0x01} on the H610 Pro too.

>=20
> >  /* Report descriptor template placeholder */
> >  #define HUION_PH(_ID) HUION_PH_HEAD, HUION_PH_ID_##_ID
> >
> >@@ -81,6 +84,31 @@ static const __u8 huion_tablet_rdesc_template[] =3D=
 {
> >  	HUION_PH(PRESSURE_LM),  /*          Logical Maximum (PLACEHOLDER)=
,  */
> >  	0x81, 0x02,             /*          Input (Variable),            =
   */
> >  	0xC0,                   /*      End Collection,                  =
   */
> >+	0x05, 0x01,             /*      Usage Page (Desktop)              =
  */
> >+	0x09, 0x07,             /*      Usage (Keypad)                    =
  */
> >+	0xa1, 0x01,             /*      Collection (Application)          =
  */
> >+	0x85, 0x08,             /*          Report ID (8)                 =
  */
> >+	0x05, 0x0d,             /*          Usage Page (Digitizers)       =
  */
> >+	0x09, 0x22,             /*          Usage (Finger)                =
  */
>=20
> I'd say "Finger" usage is wrong here. The spec says:
>=20
>     Finger
>=20
>         CL =E2=80=93 Any human appendage used as a transducer, such a=
s a finger
>         touching a touch screen to set the location of the screen cur=
sor.  A
>         digitizer typically reports the coordinates of center of the =
finger.
>         In the Finger collection a Pointer physical collection will c=
ontain
>         the axes reported by the finger.
>=20
> I.e. the buttons are not a pointing device. The specification contain=
s another
> collection usage which seems more suitable:
>=20
>     Tablet Function Keys
>=20
>         CL =E2=80=93 These controls are located on the surface of a d=
igitizing tablet,
>         and may be implemented as actual switches, or as soft keys ac=
tuated by
>         the digitizing transducer. These are often used to trigger
>         location-independent macros or other events.

Actually, the kernel knows about it: HID_DG_TABLETFUNCTIONKEY.
I don't think it should influence to have it set. The hid processing
would work on the BTN usages, not on the physical.

[5 min later]

yep, just works :)

>=20
> However the kernel doesn't seem to know anything about it (but we can=
 fix
> that). In my version of this I simply used a keyboard with buttons:
>=20
>     0x05, 0x01,             /*  Usage Page (Desktop),                =
   */
>     0x09, 0x06,             /*  Usage (Keyboard),                    =
   */
>     0xA1, 0x01,             /*  Collection (Application),            =
   */
>     0x85, 0xF7,             /*      Report ID (247),                 =
   */
>     0x05, 0x09,             /*      Usage Page (Button),             =
   */
>     0x75, 0x01,             /*      Report Size (1),                 =
   */
>     0x95, 0x18,             /*      Report Count (24),               =
   */
>     0x81, 0x03,             /*      Input (Constant, Variable),      =
   */
>     0x19, 0x01,             /*      Usage Minimum (01h),             =
   */
>     0x29, 0x08,             /*      Usage Maximum (08h),             =
   */
>     0x95, 0x08,             /*      Report Count (8),                =
   */
>     0x81, 0x02,             /*      Input (Variable),                =
   */
>     0xC0                    /*  End Collection                       =
   */
>=20
> Although it might not be entirely correct either.

Even if no-one but hid-core uses the report descriptor, I would rather
not declare ourself as a keyboard. It's shooting on our own foot if
someone decides to actually merge a keyboard and a tablet.

>=20
> >+	0xa0,                   /*          Collection (Physical)         =
  */
> >+	0x14,                   /*              Logical Minimum (0)       =
  */
> >+	0x25, 0x01,             /*              Logical Maximum (1)       =
  */
> >+	0x75, 0x08,             /*              Report Size (8)           =
  */
> >+	0x95, 0x03,             /*              Report Count (3)          =
  */
> >+	0x81, 0x03,             /*              Input (Cnst,Var,Abs)      =
  */
> >+	0x05, 0x09,             /*              Usage Page (Button)       =
  */
> >+	0x19, 0x01,             /*              Usage Minimum (1)         =
  */
> >+	0x29, 0x08,             /*              Usage Maximum (8)         =
  */
> >+	0x14,                   /*              Logical Minimum (0)       =
  */
> >+	0x25, 0x01,             /*              Logical Maximum (1)       =
  */
> >+	0x75, 0x01,             /*              Report Size (1)           =
  */
> >+	0x95, 0x08,             /*              Report Count (8)          =
  */
> >+	0x81, 0x02,             /*              Input (Data,Var,Abs)      =
  */
> >+	0x75, 0x08,             /*              Report Size (8)           =
  */
> >+	0x95, 0x03,             /*              Report Count (3)          =
  */
> >+	0x81, 0x03,             /*              Input (Cnst,Var,Abs)      =
  */
> >+	0xc0,                   /*          End Collection                =
  */
> >+	0xc0,                   /*      End Collection                    =
  */
>=20
> Which tool did you use to generate this?

My own custom-made:
https://github.com/bentiss/hid-replay/blob/master/tools/editor.py

not 100% implemented, but it works for me :)

>=20
> >  	0xC0                    /*  End Collection                       =
   */
> >  };
> >
> >@@ -205,6 +233,25 @@ static int huion_tablet_enable(struct hid_devic=
e *hdev)
> >  		}
> >  	}
> >
> >+	/* switch to the button mode reporting */
> >+	rc =3D usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
> >+				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> >+				(USB_DT_STRING << 8) + 0x7b,
> >+				0x0409, buf, len,
> >+				USB_CTRL_GET_TIMEOUT);
>=20
> I'm a bit uncomfortable about reusing a buffer which was sized specif=
ically
> for another task, as it's confusing. But it will work as is, so it's =
OK.

Yes, and no :)

Actually, I would prefer that we stick to what the Windows driver do.
But it requests 32 bytes in each requests, and we receive 14 and 22
IIRC. The trick I exploited here is that the ctrl message answers back
at most len data, so we are find in both cases because 12 is less than
14 and 22. I am not sure we should check at all the length of the
returning buffer (though for the first command, we have to be sure that
we received enough to get the values in the buffer).

Side note: the huion-abstract-keyboard branch uses usb_string() instead
of a plain usb_control_msg(). I like this much better and I think we
should change the first call with that. This way, it will be clear that
the tablet is not fully HID compatible and that we need to keep the usb
access.

>=20
> >+	if (rc =3D=3D -EPIPE) {
> >+		hid_err(hdev, "button mode switch not found\n");
> >+		rc =3D -ENODEV;
> >+		goto cleanup;
> >+	} else if (rc < 0) {
> >+		hid_err(hdev, "failed to switch to button mode: %d\n", rc);
> >+		rc =3D -ENODEV;
> >+		goto cleanup;
> >+	} else if (rc !=3D len) {
> >+		hid_err(hdev, "invalid button mode switch\n");
> >+		rc =3D -ENODEV;
> >+		goto cleanup;
> >+	}
> >  	rc =3D 0;
> >
> >  cleanup:
> >@@ -262,10 +309,16 @@ static int huion_raw_event(struct hid_device *=
hdev, struct hid_report *report,
> >  	/* If this is a pen input report */
> >  	if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 0 &&
> >  	    report->type =3D=3D HID_INPUT_REPORT &&
> >-	    report->id =3D=3D 0x07 && size >=3D 2)
> >+	    report->id =3D=3D 0x07 && size >=3D 2) {
> >  		/* Invert the in-range bit */
> >  		data[1] ^=3D 0x40;
> >
> >+		/* check for buttons events and change the report ID */
> >+		if (size >=3D sizeof(button_report) &&
> >+		    !memcmp(data, button_report, sizeof(button_report)))
>=20
> So, yes, I think it's better to have a "data[1] & 0x20" test here ins=
tead.

Yep, works just fine.

Cheers,
Benjamin

>=20
> >+			data[0] =3D 0x08;
> >+	}
> >+
> >  	return 0;
> >  }
> >
> >
>=20
> Nick
