From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hid-input: allow input_configured callback return
 errors
Date: Sun, 27 Sep 2015 17:23:28 -0700
Message-ID: <20150928002328.GB17818@dtor-ws>
References: <20150925231451.GA40951@dtor-ws>
 <CANq1E4SjLUWinuNzBN7MNSgEQTLsfFK-t-OqGXmnkN1X1bJ0Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34937 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbbI1AXc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Sep 2015 20:23:32 -0400
Content-Disposition: inline
In-Reply-To: <CANq1E4SjLUWinuNzBN7MNSgEQTLsfFK-t-OqGXmnkN1X1bJ0Vg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Jaikumar Ganesh <jaikumarg@android.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, James C Boyd <jcboyd.dev@gmail.com>, Karl Relton <karllinuxtest.relton@ntlworld.com>, Olivier Gay <ogay@logitech.com>, Ross Skaliotis <rskaliotis@gmail.com>, Jamie Lentin <jm@lentin.co.uk>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andreas Fleig <andreasfleig@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Peter Wu <peter@lekensteyn.nl>, Goffredo Baroncelli <kreijack@inwind.it>, Mathieu Magnaudet <mathieu.magnaudet@gmail.com>, Brent Adam <brentadamdev@gmail.com>, Yang Bo <linuxsea@163.com>, Seth Forshee <seth.forshee@canonical.com>, Andrew Duggan <aduggan@synaptics.com>, Dan Carpenter <dan.carpenter@oracle.com>, Frank Praznik <frank.prazni>

Hi David,

On Sat, Sep 26, 2015 at 05:16:12PM +0200, David Herrmann wrote:
> Hi
>=20
> On Sat, Sep 26, 2015 at 1:14 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > When configuring input device via input_configured callback we may
> > encounter errors (for example input_mt_init_slots() may fail). Inst=
ead
> > of continuing with half-initialized input device let's allow driver
> > indicate failures.
> >
> > Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
> > Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/hid/hid-appleir.c        |  4 +++-
> >  drivers/hid/hid-elo.c            |  4 +++-
> >  drivers/hid/hid-input.c          | 10 ++++++----
> >  drivers/hid/hid-lenovo.c         |  4 +++-
> >  drivers/hid/hid-logitech-hidpp.c |  4 +++-
> >  drivers/hid/hid-magicmouse.c     |  8 ++++++--
> >  drivers/hid/hid-multitouch.c     | 19 ++++++++++++++-----
> >  drivers/hid/hid-ntrig.c          |  6 ++++--
> >  drivers/hid/hid-rmi.c            | 11 +++++++----
> >  drivers/hid/hid-sony.c           | 13 ++++++++++---
> >  drivers/hid/hid-uclogic.c        |  6 ++++--
> >  include/linux/hid.h              |  4 ++--
> >  12 files changed, 65 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 53aeaf6..2ba6bf6 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1510,8 +1510,9 @@ int hidinput_connect(struct hid_device *hid, =
unsigned int force)
> >                                  * UGCI) cram a lot of unrelated in=
puts into the
> >                                  * same interface. */
> >                                 hidinput->report =3D report;
> > -                               if (drv->input_configured)
> > -                                       drv->input_configured(hid, =
hidinput);
> > +                               if (drv->input_configured &&
> > +                                   drv->input_configured(hid, hidi=
nput))
> > +                                       goto out_cleanup;
> >                                 if (input_register_device(hidinput-=
>input))
> >                                         goto out_cleanup;
> >                                 hidinput =3D NULL;
> > @@ -1532,8 +1533,9 @@ int hidinput_connect(struct hid_device *hid, =
unsigned int force)
> >         }
> >
> >         if (hidinput) {
> > -               if (drv->input_configured)
> > -                       drv->input_configured(hid, hidinput);
> > +               if (drv->input_configured &&
> > +                   drv->input_configured(hid, hidinput))
> > +                       goto out_cleanup;
> >                 if (input_register_device(hidinput->input))
> >                         goto out_cleanup;
> >         }
>=20
> [snip]
>=20
> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multito=
uch.c
> > index 426b2f1..73d7d59 100644
> > --- a/drivers/hid/hid-multitouch.c
> > +++ b/drivers/hid/hid-multitouch.c
> > @@ -725,12 +725,13 @@ static void mt_touch_report(struct hid_device=
 *hid, struct hid_report *report)
> >                 mt_sync_frame(td, report->field[0]->hidinput->input=
);
> >  }
> >
> > -static void mt_touch_input_configured(struct hid_device *hdev,
> > +static int mt_touch_input_configured(struct hid_device *hdev,
> >                                         struct hid_input *hi)
> >  {
> >         struct mt_device *td =3D hid_get_drvdata(hdev);
> >         struct mt_class *cls =3D &td->mtclass;
> >         struct input_dev *input =3D hi->input;
> > +       int ret;
> >
> >         if (!td->maxcontacts)
> >                 td->maxcontacts =3D MT_DEFAULT_MAXCONTACT;
> > @@ -752,9 +753,12 @@ static void mt_touch_input_configured(struct h=
id_device *hdev,
> >         if (td->is_buttonpad)
> >                 __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> >
> > -       input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
> > +       ret =3D input_mt_init_slots(input, td->maxcontacts, td->mt_=
flags);
> > +       if (ret)
> > +               return ret;
> >
> >         td->mt_flags =3D 0;
> > +       return 0;
> >  }
> >
> >  static int mt_input_mapping(struct hid_device *hdev, struct hid_in=
put *hi,
> > @@ -930,15 +934,19 @@ static void mt_post_parse(struct mt_device *t=
d)
> >                 cls->quirks &=3D ~MT_QUIRK_CONTACT_CNT_ACCURATE;
> >  }
> >
> > -static void mt_input_configured(struct hid_device *hdev, struct hi=
d_input *hi)
> > +static int mt_input_configured(struct hid_device *hdev, struct hid=
_input *hi)
> >  {
> >         struct mt_device *td =3D hid_get_drvdata(hdev);
> >         char *name;
> >         const char *suffix =3D NULL;
> >         struct hid_field *field =3D hi->report->field[0];
> > +       int ret =3D 0;
>=20
> int ret;

Right.

>=20
> >
> > -       if (hi->report->id =3D=3D td->mt_report_id)
> > -               mt_touch_input_configured(hdev, hi);
> > +       if (hi->report->id =3D=3D td->mt_report_id) {
> > +               ret =3D mt_touch_input_configured(hdev, hi);
> > +               if (ret)
> > +                       return ret;
> > +       }
> >
> >         /*
> >          * some egalax touchscreens have "application =3D=3D HID_DG=
_TOUCHSCREEN"
> > @@ -989,6 +997,7 @@ static void mt_input_configured(struct hid_devi=
ce *hdev, struct hid_input *hi)
> >                         hi->input->name =3D name;
> >                 }
> >         }
> > +       return ret;
>=20
> return 0;
>=20
> And maybe add an empty line before the final return, just like you di=
d
> with all the other callbacks.

OK.

>=20
> >  }
> >
> >  static int mt_probe(struct hid_device *hdev, const struct hid_devi=
ce_id *id)
>=20
> [snip]
>=20
> > diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> > index 2c14812..33280f3 100644
> > --- a/drivers/hid/hid-rmi.c
> > +++ b/drivers/hid/hid-rmi.c
> > @@ -1173,7 +1173,7 @@ static int rmi_populate(struct hid_device *hd=
ev)
> >         return 0;
> >  }
> >
> > -static void rmi_input_configured(struct hid_device *hdev, struct h=
id_input *hi)
> > +static int rmi_input_configured(struct hid_device *hdev, struct hi=
d_input *hi)
> >  {
> >         struct rmi_data *data =3D hid_get_drvdata(hdev);
> >         struct input_dev *input =3D hi->input;
> > @@ -1185,10 +1185,10 @@ static void rmi_input_configured(struct hid=
_device *hdev, struct hid_input *hi)
> >         hid_dbg(hdev, "Opening low level driver\n");
> >         ret =3D hid_hw_open(hdev);
> >         if (ret)
> > -               return;
> > +               return ret;
> >
> >         if (!(data->device_flags & RMI_DEVICE))
> > -               return;
> > +               return -ENXIO;
> >
> >         /* Allow incoming hid reports */
> >         hid_device_io_start(hdev);
> > @@ -1228,7 +1228,9 @@ static void rmi_input_configured(struct hid_d=
evice *hdev, struct hid_input *hi)
> >         input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 0x0f, 0,=
 0);
> >         input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 0x0f, 0,=
 0);
> >
> > -       input_mt_init_slots(input, data->max_fingers, INPUT_MT_POIN=
TER);
> > +       ret =3D input_mt_init_slots(input, data->max_fingers, INPUT=
_MT_POINTER);
> > +       if (ret < 0)
> > +               goto exit;
> >
> >         if (data->button_count) {
> >                 __set_bit(EV_KEY, input->evbit);
> > @@ -1244,6 +1246,7 @@ static void rmi_input_configured(struct hid_d=
evice *hdev, struct hid_input *hi)
> >  exit:
> >         hid_device_io_stop(hdev);
> >         hid_hw_close(hdev);
> > +       return ret;
>=20
> rmi_probe() has an explicit comment that it *wants* hid_probe() to
> continue on failure, to make sure hidraw is loaded. Not sure what to
> make with that, but please either remove the comment in rmi_probe() o=
r
> make sure to always return 0 from rmi_input_configured().

I think that comment is erroneous since the fact that we could not
attach hidinput interface should not affect hidraw in any shape or form=
=2E

Andrew, can you double check?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
