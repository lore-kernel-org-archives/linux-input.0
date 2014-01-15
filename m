From: Dylan Thurston <dpthurst@indiana.edu>
Subject: Re: Fwd: [PATCH] add support for ALPS v7 protocol device
Date: Wed, 15 Jan 2014 00:16:50 -0500
Message-ID: <20140115051650.GA4620@bostoncoop.net>
References: <1389333218-31139-1-git-send-email-qiting.chen@cn.alps.com>
 <CAKvfdt+SSis1f23j8E6ij9pjbCbWeVkGWZQq5P8kaiSA75DmQQ@mail.gmail.com>
 <CA+F6ckM=K74LH4R_xRJaH6Er2DDyms8M8++qSynVJjfUQ=tnPg@mail.gmail.com>
 <20140114201736.GA4755@bostoncoop.net>
 <CAKvfdtLoQvfu-u51NCLTRU8020ZQGXksh1f6Cj84dzK=O1NCjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from whitehail.bostoncoop.net ([74.50.63.164]:51361 "EHLO
	bostoncoop.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbaAOFQ4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jan 2014 00:16:56 -0500
Content-Disposition: inline
In-Reply-To: <CAKvfdtLoQvfu-u51NCLTRU8020ZQGXksh1f6Cj84dzK=O1NCjQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elaine Chen <elaineee66@gmail.com>
Cc: Tommy Will <tommywill2011@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, Niels de Vos <ndevos@redhat.com>, Justin Clift <jclift@redhat.com>, Qiting Chen <qiting.chen@cn.alps.com>, linux-input@vger.kernel.org

This patch seems to work in the 3.13-rc8 kernel, at least on an
initial check. The problems with excess clicks while typing have
disappeared. I'll report back with any glitches I see.

Thank you!

--Dylan

On Wed, Jan 15, 2014 at 11:15:02AM +0800, Elaine Chen wrote:
> Hi Dylan,
>=20
> Thank you! This patch is againt Dmitry Torokhov's input tree, based o=
n
> the modification of:
> 2013-12-26    Input: ALPS - add support for "Dolphin" devices      Yu=
nkang Tang
> As linux-next-20140114 has already merged Dolphin support, the patch
> should be matched.
> As for the blank screen, I'll debug on my side. Sorry for that.
> What is the kernel version on your HP side? Is it 3.13-rc8?
>=20
> Yes, it is safe to copy both alps.c and alps.h from linux-next versio=
n
> to 3.13-rc8 kerenl.
>=20
>=20
>=20
> 2014/1/15 Dylan Thurston <dpthurst@indiana.edu>:
> > Thank you! Which versions does this apply against? It patched for m=
e
> > with no fuzz against linux-next-20140114, but unfortunately X seems=
 to
> > be broken for me on that version (blank screen). I get fuzz and
> > rejected patches when applying it to 3.13-rc8. Is it safe to just c=
opy
> > over alps.c from the linux-next version?
> >
> > (Of course, it's possible that the blank screen is a side effect of
> > the correct recognition of the touchpad.)
> >
> > Thanks,
> >         Dylan
> >
> > On Tue, Jan 14, 2014 at 02:11:59PM +0800, Tommy Will wrote:
> >> Hi Dylan,
> >>
> >> My colleague Elaine has prepared the patch for new ALPS touchpad t=
hat
> >> being used on your HP Revolve 810 G1 laptop.
> >> You can have a try~
> >>
> >> --
> >> Best Regards,
> >> Tommy
> >>
> >> ---------- Forwarded message ----------
> >> From: Elaine Chen <elaineee66@gmail.com>
> >> Date: 2014/1/14
> >> Subject: Re: [PATCH] add support for ALPS v7 protocol device
> >> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, cernekee@gmail.co=
m,
> >> david turvene <dturvene@dahetral.com>
> >> =E6=8A=84=E9=80=81=EF=BC=9A linux-input@vger.kernel.org, ndevos@re=
dhat.com, jclift@redhat.com,
> >> Qiting Chen <qiting.chen@cn.alps.com>
> >>
> >>
> >> As far as I know, the ALPS v7 protocol device is used on following=
 laptops:
> >>
> >> Lenovo S430/S435/S530, Lenovo Z410/Z510, HP Odie, HP Revolve 810 G=
1
> >>
> >> 2014/1/10 Qiting Chen <elaineee66@gmail.com>:
> >> > Here is the patch of supporting ALPS v7 protocol device.
> >> >
> >> > v7 device is a clickpad device.
> >> > Device info:
> >> >         Device ID =3D 0x73, 0x03, 0x0a
> >> >         Firmware ID =3D 0x88, 0xb*, 0x**
> >> >
> >> > Support function of v7 device:
> >> > - Cursor
> >> > - Tap, double tap, tap drag, 2finger tap
> >> > - Pan, pinch
> >> > - Button click: v7 device has one physical button under the touc=
hpad. A Button Area covers the bottom of touchpad. Clicking on Button A=
rea produces button acitivities.
> >> >   Click touchpad with all fingers outside right Button Area --> =
left click
> >> >   Click touchpad with at lease 1 finger inside right Button Area=
 --> right click
> >> > - Resting finger function: Cursor and gestures won't be influenc=
ed with one finger placed still on Button Area.
> >> >
> >> > The resting finger process is in alps.c as it seems the latest x=
server-xorg-input-synaptics(1.7.1) doesn't support that part.
> >> > We tried registering our device as a clickpad by:
> >> >         set_bit(INPUT_PROP_BUTTONPAD, dev1->propbit)
> >> > But only button click can be correctly recognized. Yet a finger =
at Button Area won't be ignored while doing cursroing.
> >> >
> >> >
> >> > Signed-off-by: Qiting Chen <qiting.chen@cn.alps.com>
> >> > ---
> >> >  drivers/input/mouse/alps.c | 478 ++++++++++++++++++++++++++++++=
++++++++++++---
> >> >  drivers/input/mouse/alps.h | 127 ++++++++++--
> >> >  2 files changed, 554 insertions(+), 51 deletions(-)
> >> >
> >> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/al=
ps.c
> >> > index fb15c64..3e8e8f7 100644
> >> > --- a/drivers/input/mouse/alps.c
> >> > +++ b/drivers/input/mouse/alps.c
> >> > @@ -32,6 +32,11 @@
> >> >  #define ALPS_REG_BASE_RUSHMORE 0xc2c0
> >> >  #define ALPS_REG_BASE_PINNACLE 0x0000
> >> >
> >> > +#define LEFT_BUTTON_BIT                        0x01
> >> > +#define RIGHT_BUTTON_BIT               0x02
> >> > +
> >> > +#define V7_LARGE_MOVEMENT              130
> >> > +
> >> >  static const struct alps_nibble_commands alps_v3_nibble_command=
s[] =3D {
> >> >         { PSMOUSE_CMD_SETPOLL,          0x00 }, /* 0 */
> >> >         { PSMOUSE_CMD_RESET_DIS,        0x00 }, /* 1 */
> >> > @@ -99,6 +104,7 @@ static const struct alps_nibble_commands alps=
_v6_nibble_commands[] =3D {
> >> >  #define ALPS_FOUR_BUTTONS      0x40    /* 4 direction button pr=
esent */
> >> >  #define ALPS_PS2_INTERLEAVED   0x80    /* 3-byte PS/2 packet in=
terleaved with
> >> >                                            6-byte ALPS packet */
> >> > +#define ALPS_BTNLESS                   0x100   /* ALPS ClickPad=
 flag */
> >> >
> >> >  static const struct alps_model_info alps_model_data[] =3D {
> >> >         { { 0x32, 0x02, 0x14 }, 0x00, ALPS_PROTO_V2, 0xf8, 0xf8,=
 ALPS_PASS | ALPS_DUALPOINT },  /* Toshiba Salellite Pro M10 */
> >> > @@ -140,6 +146,20 @@ static void alps_set_abs_params_mt(struct a=
lps_data *priv,
> >> >   * isn't valid per PS/2 spec.
> >> >   */
> >> >
> >> > +static unsigned int alps_pt_distance(struct alps_abs_data *pt0,
> >> > +                                   struct alps_abs_data *pt1)
> >> > +{
> >> > +       int vect_x, vect_y;
> >> > +
> >> > +       if (!pt0 || !pt1)
> >> > +               return 0;
> >> > +
> >> > +       vect_x =3D pt0->x - pt1->x;
> >> > +       vect_y =3D pt0->y - pt1->y;
> >> > +
> >> > +       return int_sqrt(vect_x * vect_x + vect_y * vect_y);
> >> > +}
> >> > +
> >> >  /* Packet formats are described in Documentation/input/alps.txt=
 */
> >> >
> >> >  static bool alps_is_valid_first_byte(struct alps_data *priv,
> >> > @@ -320,8 +340,8 @@ static void alps_process_bitmap_dolphin(stru=
ct alps_data *priv,
> >> >                 end_bit =3D y_msb - 1;
> >> >                 box_middle_y =3D (priv->y_max * (start_bit + end=
_bit)) /
> >> >                                 (2 * (priv->y_bits - 1));
> >> > -               *x1 =3D fields->x;
> >> > -               *y1 =3D fields->y;
> >> > +               *x1 =3D fields->pt.x;
> >> > +               *y1 =3D fields->pt.y;
> >> >                 *x2 =3D 2 * box_middle_x - *x1;
> >> >                 *y2 =3D 2 * box_middle_y - *y1;
> >> >         }
> >> > @@ -461,6 +481,38 @@ static void alps_report_semi_mt_data(struct=
 input_dev *dev, int num_fingers,
> >> >         alps_set_slot(dev, 1, num_fingers =3D=3D 2, x2, y2);
> >> >  }
> >> >
> >> > +static void alps_report_coord_and_btn(struct psmouse *psmouse,
> >> > +                                     struct alps_fields *f)
> >> > +{
> >> > +       struct input_dev *dev;
> >> > +
> >> > +       if (!psmouse || !f)
> >> > +               return;
> >> > +
> >> > +       dev =3D psmouse->dev;
> >> > +
> >> > +       if (f->fingers) {
> >> > +               input_report_key(dev, BTN_TOUCH, 1);
> >> > +               alps_report_semi_mt_data(dev, f->fingers,
> >> > +                       f->pt_img[0].x, f->pt_img[0].y,
> >> > +                       f->pt_img[1].x, f->pt_img[1].y);
> >> > +               input_mt_report_finger_count(dev, f->fingers);
> >> > +
> >> > +               input_report_abs(dev, ABS_X, f->pt_img[0].x);
> >> > +               input_report_abs(dev, ABS_Y, f->pt_img[0].y);
> >> > +               input_report_abs(dev, ABS_PRESSURE, f->pt_img[0]=
=2Ez);
> >> > +       } else {
> >> > +               input_report_key(dev, BTN_TOUCH, 0);
> >> > +               input_mt_report_finger_count(dev, 0);
> >> > +               input_report_abs(dev, ABS_PRESSURE, 0);
> >> > +       }
> >> > +
> >> > +       input_report_key(dev, BTN_LEFT, f->btn.left);
> >> > +       input_report_key(dev, BTN_RIGHT, f->btn.right);
> >> > +
> >> > +       input_sync(dev);
> >> > +}
> >> > +
> >> >  static void alps_process_trackstick_packet_v3(struct psmouse *p=
smouse)
> >> >  {
> >> >         struct alps_data *priv =3D psmouse->private;
> >> > @@ -523,13 +575,13 @@ static void alps_process_trackstick_packet=
_v3(struct psmouse *psmouse)
> >> >
> >> >  static void alps_decode_buttons_v3(struct alps_fields *f, unsig=
ned char *p)
> >> >  {
> >> > -       f->left =3D !!(p[3] & 0x01);
> >> > -       f->right =3D !!(p[3] & 0x02);
> >> > -       f->middle =3D !!(p[3] & 0x04);
> >> > +       f->btn.left =3D !!(p[3] & 0x01);
> >> > +       f->btn.right =3D !!(p[3] & 0x02);
> >> > +       f->btn.middle =3D !!(p[3] & 0x04);
> >> >
> >> > -       f->ts_left =3D !!(p[3] & 0x10);
> >> > -       f->ts_right =3D !!(p[3] & 0x20);
> >> > -       f->ts_middle =3D !!(p[3] & 0x40);
> >> > +       f->btn.ts_left =3D !!(p[3] & 0x10);
> >> > +       f->btn.ts_right =3D !!(p[3] & 0x20);
> >> > +       f->btn.ts_middle =3D !!(p[3] & 0x40);
> >> >  }
> >> >
> >> >  static void alps_decode_pinnacle(struct alps_fields *f, unsigne=
d char *p,
> >> > @@ -546,10 +598,10 @@ static void alps_decode_pinnacle(struct al=
ps_fields *f, unsigned char *p,
> >> >                    ((p[2] & 0x7f) << 1) |
> >> >                    (p[4] & 0x01);
> >> >
> >> > -       f->x =3D ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
> >> > +       f->pt.x =3D ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) =
|
> >> >                ((p[0] & 0x30) >> 4);
> >> > -       f->y =3D ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
> >> > -       f->z =3D p[5] & 0x7f;
> >> > +       f->pt.y =3D ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
> >> > +       f->pt.z =3D p[5] & 0x7f;
> >> >
> >> >         alps_decode_buttons_v3(f, p);
> >> >  }
> >> > @@ -573,9 +625,9 @@ static void alps_decode_dolphin(struct alps_=
fields *f, unsigned char *p,
> >> >         f->is_mp =3D !!(p[0] & 0x20);
> >> >
> >> >         if (!f->is_mp) {
> >> > -               f->x =3D ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> >> > -               f->y =3D ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> >> > -               f->z =3D (p[0] & 4) ? 0 : p[5] & 0x7f;
> >> > +               f->pt.x =3D ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7=
));
> >> > +               f->pt.y =3D ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3=
));
> >> > +               f->pt.z =3D (p[0] & 4) ? 0 : p[5] & 0x7f;
> >> >                 alps_decode_buttons_v3(f, p);
> >> >         } else {
> >> >                 f->fingers =3D ((p[0] & 0x6) >> 1 |
> >> > @@ -687,7 +739,7 @@ static void alps_process_touchpad_packet_v3_=
v5(struct psmouse *psmouse)
> >> >          * with x, y, and z all zero, so these seem to be flukes=
=2E
> >> >          * Ignore them.
> >> >          */
> >> > -       if (f.x && f.y && !f.z)
> >> > +       if (f.pt.x && f.pt.y && !f.pt.z)
> >> >                 return;
> >> >
> >> >         /*
> >> > @@ -695,12 +747,12 @@ static void alps_process_touchpad_packet_v=
3_v5(struct psmouse *psmouse)
> >> >          * to rely on ST data.
> >> >          */
> >> >         if (!fingers) {
> >> > -               x1 =3D f.x;
> >> > -               y1 =3D f.y;
> >> > -               fingers =3D f.z > 0 ? 1 : 0;
> >> > +               x1 =3D f.pt.x;
> >> > +               y1 =3D f.pt.y;
> >> > +               fingers =3D f.pt.z > 0 ? 1 : 0;
> >> >         }
> >> >
> >> > -       if (f.z >=3D 64)
> >> > +       if (f.pt.z >=3D 64)
> >> >                 input_report_key(dev, BTN_TOUCH, 1);
> >> >         else
> >> >                 input_report_key(dev, BTN_TOUCH, 0);
> >> > @@ -709,22 +761,22 @@ static void alps_process_touchpad_packet_v=
3_v5(struct psmouse *psmouse)
> >> >
> >> >         input_mt_report_finger_count(dev, fingers);
> >> >
> >> > -       input_report_key(dev, BTN_LEFT, f.left);
> >> > -       input_report_key(dev, BTN_RIGHT, f.right);
> >> > -       input_report_key(dev, BTN_MIDDLE, f.middle);
> >> > +       input_report_key(dev, BTN_LEFT, f.btn.left);
> >> > +       input_report_key(dev, BTN_RIGHT, f.btn.right);
> >> > +       input_report_key(dev, BTN_MIDDLE, f.btn.middle);
> >> >
> >> > -       if (f.z > 0) {
> >> > -               input_report_abs(dev, ABS_X, f.x);
> >> > -               input_report_abs(dev, ABS_Y, f.y);
> >> > +       if (f.pt.z > 0) {
> >> > +               input_report_abs(dev, ABS_X, f.pt.x);
> >> > +               input_report_abs(dev, ABS_Y, f.pt.y);
> >> >         }
> >> > -       input_report_abs(dev, ABS_PRESSURE, f.z);
> >> > +       input_report_abs(dev, ABS_PRESSURE, f.pt.z);
> >> >
> >> >         input_sync(dev);
> >> >
> >> >         if (!(priv->quirks & ALPS_QUIRK_TRACKSTICK_BUTTONS)) {
> >> > -               input_report_key(dev2, BTN_LEFT, f.ts_left);
> >> > -               input_report_key(dev2, BTN_RIGHT, f.ts_right);
> >> > -               input_report_key(dev2, BTN_MIDDLE, f.ts_middle);
> >> > +               input_report_key(dev2, BTN_LEFT, f.btn.ts_left);
> >> > +               input_report_key(dev2, BTN_RIGHT, f.btn.ts_right=
);
> >> > +               input_report_key(dev2, BTN_MIDDLE, f.btn.ts_midd=
le);
> >> >                 input_sync(dev2);
> >> >         }
> >> >  }
> >> > @@ -916,6 +968,294 @@ static void alps_process_packet_v4(struct =
psmouse *psmouse)
> >> >         input_sync(dev);
> >> >  }
> >> >
> >> > +static bool alps_is_valid_package_v7(struct psmouse *psmouse)
> >> > +{
> >> > +       if ((psmouse->pktcnt =3D=3D 3) && ((psmouse->packet[2] &=
 0x40) !=3D 0x40))
> >> > +               return false;
> >> > +       if ((psmouse->pktcnt =3D=3D 4) && ((psmouse->packet[3] &=
 0x48) !=3D 0x48))
> >> > +               return false;
> >> > +       if ((psmouse->pktcnt =3D=3D 6) && ((psmouse->packet[5] &=
 0x40) !=3D 0x0))
> >> > +               return false;
> >> > +       return true;
> >> > +}
> >> > +
> >> > +static int alps_drop_unsupported_packet_v7(struct psmouse *psmo=
use)
> >> > +{
> >> > +       struct alps_data *priv =3D psmouse->private;
> >> > +       int drop =3D 1;
> >> > +
> >> > +       if (priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_NEW ||
> >> > +           priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_TWO ||
> >> > +           priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_MULTI ||
> >> > +           priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_IDLE)
> >> > +               drop =3D 0;
> >> > +
> >> > +       return drop;
> >> > +}
> >> > +
> >> > +static unsigned char alps_get_packet_id_v7(char *byte)
> >> > +{
> >> > +       unsigned char packet_id;
> >> > +
> >> > +       if (byte[4] & 0x40)
> >> > +               packet_id =3D V7_PACKET_ID_TWO;
> >> > +       else if (byte[4] & 0x01)
> >> > +               packet_id =3D V7_PACKET_ID_MULTI;
> >> > +       else if ((byte[0] & 0x10) && !(byte[4] & 0x43))
> >> > +               packet_id =3D V7_PACKET_ID_NEW;
> >> > +       else
> >> > +               packet_id =3D V7_PACKET_ID_IDLE;
> >> > +
> >> > +       return packet_id;
> >> > +}
> >> > +
> >> > +static void alps_get_finger_coordinate_v7(struct alps_abs_data =
*pt,
> >> > +                                         unsigned char *pkt,
> >> > +                                         unsigned char pkt_id)
> >> > +{
> >> > +       if ((pkt_id =3D=3D V7_PACKET_ID_TWO) ||
> >> > +          (pkt_id =3D=3D V7_PACKET_ID_MULTI) ||
> >> > +          (pkt_id =3D=3D V7_PACKET_ID_NEW)) {
> >> > +               pt[0].x =3D ((pkt[2] & 0x80) << 4);
> >> > +               pt[0].x |=3D ((pkt[2] & 0x3F) << 5);
> >> > +               pt[0].x |=3D ((pkt[3] & 0x30) >> 1);
> >> > +               pt[0].x |=3D (pkt[3] & 0x07);
> >> > +               pt[0].y =3D (pkt[1] << 3) | (pkt[0] & 0x07);
> >> > +
> >> > +               pt[1].x =3D ((pkt[3] & 0x80) << 4);
> >> > +               pt[1].x |=3D ((pkt[4] & 0x80) << 3);
> >> > +               pt[1].x |=3D ((pkt[4] & 0x3F) << 4);
> >> > +               pt[1].y =3D ((pkt[5] & 0x80) << 3);
> >> > +               pt[1].y |=3D ((pkt[5] & 0x3F) << 4);
> >> > +
> >> > +               if (pkt_id =3D=3D V7_PACKET_ID_TWO) {
> >> > +                       pt[1].x &=3D ~0x000F;
> >> > +                       pt[1].y |=3D 0x000F;
> >> > +               } else if (pkt_id =3D=3D V7_PACKET_ID_MULTI) {
> >> > +                       pt[1].x &=3D ~0x003F;
> >> > +                       pt[1].y &=3D ~0x0020;
> >> > +                       pt[1].y |=3D ((pkt[4] & 0x02) << 4);
> >> > +                       pt[1].y |=3D 0x001F;
> >> > +               } else if (pkt_id =3D=3D V7_PACKET_ID_NEW) {
> >> > +                       pt[1].x &=3D ~0x003F;
> >> > +                       pt[1].x |=3D (pkt[0] & 0x20);
> >> > +                       pt[1].y |=3D 0x000F;
> >> > +               }
> >> > +
> >> > +               pt[0].y =3D 0x7FF - pt[0].y;
> >> > +               pt[1].y =3D 0x7FF - pt[1].y;
> >> > +
> >> > +               pt[0].z =3D (pt[0].x && pt[0].y) ? 62 : 0;
> >> > +               pt[1].z =3D (pt[1].x && pt[1].y) ? 62 : 0;
> >> > +       }
> >> > +}
> >> > +
> >> > +static void alps_decode_packet_v7(struct alps_fields *f,
> >> > +                                 unsigned char *p,
> >> > +                                 struct psmouse *psmouse)
> >> > +{
> >> > +       struct alps_data *priv =3D psmouse->private;
> >> > +
> >> > +       priv->r.v7.pkt_id =3D alps_get_packet_id_v7(p);
> >> > +
> >> > +       alps_get_finger_coordinate_v7(f->pt_img, p, priv->r.v7.p=
kt_id);
> >> > +
> >> > +       priv->r.v7.rest_left =3D 0;
> >> > +       priv->r.v7.rest_right =3D 0;
> >> > +       priv->r.v7.additional_fingers =3D 0;
> >> > +       priv->phy_btn =3D 0;
> >> > +
> >> > +       if (priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_TWO ||
> >> > +           priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_MULTI) {
> >> > +               priv->r.v7.rest_left =3D (p[0] & 0x10) >> 4;
> >> > +               priv->r.v7.rest_right =3D (p[0] & 0x20) >> 5;
> >> > +       }
> >> > +
> >> > +       if (priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_MULTI)
> >> > +               priv->r.v7.additional_fingers =3D p[5] & 0x03;
> >> > +
> >> > +       priv->phy_btn =3D (p[0] & 0x80) >> 7;
> >> > +}
> >> > +
> >> > +static void alps_set_each_pt_attr_v7(struct psmouse *psmouse,
> >> > +                                    struct alps_abs_data *pt,
> >> > +                                    struct alps_bl_pt_attr *pt_=
attr)
> >> > +{
> >> > +       struct alps_data *priv =3D psmouse->private;
> >> > +       unsigned int dist;
> >> > +
> >> > +       if (!pt_attr->is_init_pt_got && pt->z !=3D 0) {
> >> > +               pt_attr->is_init_pt_got =3D 1;
> >> > +               pt_attr->is_counted =3D 0;
> >> > +               memcpy(&pt_attr->init_pt, pt, sizeof(pt_attr->in=
it_pt));
> >> > +       }
> >> > +
> >> > +       if (pt->z !=3D 0) {
> >> > +               if (pt->y < priv->resting_zone_y_min) {
> >> > +                       /* A finger is recognized as a non-resti=
ng finger
> >> > +                       if it's position is outside the resting =
finger zone.*/
> >> > +                       pt_attr->zone =3D ZONE_NORMAL;
> >> > +                       pt_attr->is_counted =3D 1;
> >> > +               } else {
> >> > +                       /* A finger is recognized as a resting f=
inger if it's
> >> > +                       position is inside the resting finger zo=
ne and there's
> >> > +                       no large movement from it's touch down p=
osition.*/
> >> > +                       pt_attr->zone =3D ZONE_RESTING;
> >> > +
> >> > +                       if (pt->x > priv->x_max / 2)
> >> > +                               pt_attr->zone |=3D ZONE_RIGHT_BT=
N;
> >> > +                       else
> >> > +                               pt_attr->zone |=3D ZONE_LEFT_BTN=
;
> >> > +
> >> > +                       /* A resting finger will turn to be a no=
n-resting
> >> > +                       finger if it has made large movement fro=
m it's touch
> >> > +                       down position. A non-resting finger will=
 never turn
> >> > +                       to a resting finger before it leaves the=
 touchpad
> >> > +                       surface.*/
> >> > +                       if (pt_attr->is_init_pt_got) {
> >> > +                               dist =3D alps_pt_distance(pt, &p=
t_attr->init_pt);
> >> > +
> >> > +                               if (dist > V7_LARGE_MOVEMENT)
> >> > +                                       pt_attr->is_counted =3D =
1;
> >> > +                       }
> >> > +               }
> >> > +       }
> >> > +}
> >> > +
> >> > +static void alps_set_pt_attr_v7(struct psmouse *psmouse,
> >> > +                                      struct alps_fields *f)
> >> > +{
> >> > +       struct alps_data *priv =3D psmouse->private;
> >> > +       int i;
> >> > +
> >> > +       switch (priv->r.v7.pkt_id) {
> >> > +       case  V7_PACKET_ID_TWO:
> >> > +       case  V7_PACKET_ID_MULTI:
> >> > +               for (i =3D 0; i < V7_IMG_PT_NUM; i++)
> >> > +                       alps_set_each_pt_attr_v7(psmouse,
> >> > +                                                &f->pt_img[i],
> >> > +                                                &priv->pt_attr[=
i]);
> >> > +               break;
> >> > +       default:
> >> > +               /*All finger attributes are cleared when packet =
ID is
> >> > +               'IDLE', 'New'or other unknown IDs. An 'IDLE' pac=
ket
> >> > +               indicates that there's no finger and no button a=
ctivity.
> >> > +               A 'NEW' packet indicates the finger position in =
packet
> >> > +               is not continues from previous packet. Such as t=
he
> >> > +               condition there's finger placed or lifted. In th=
ese cases,
> >> > +               finger attributes will be reset.*/
> >> > +               memset(priv->pt_attr, 0, sizeof(priv->pt_attr[0]=
) * 2);
> >> > +               break;
> >> > +       }
> >> > +}
> >> > +
> >> > +static void alps_cal_output_finger_num_v7(struct psmouse *psmou=
se,
> >> > +                                       struct alps_fields *f)
> >> > +{
> >> > +       struct alps_data *priv =3D psmouse->private;
> >> > +       unsigned int fn =3D 0;
> >> > +       int i;
> >> > +
> >> > +       switch (priv->r.v7.pkt_id) {
> >> > +       case V7_PACKET_ID_IDLE:
> >> > +       case V7_PACKET_ID_NEW:
> >> > +               /*No finger is reported when packet ID is 'IDLE'=
 or 'New'.
> >> > +               An 'IDLE' packet indicates that there's no finge=
r on touchpad.
> >> > +               A 'NEW' packet indicates there's finger placed o=
r lifted.
> >> > +               Finger position of 'New' packet is not continues=
 from the
> >> > +               previous packet.*/
> >> > +               fn =3D 0;
> >> > +               break;
> >> > +       case V7_PACKET_ID_TWO:
> >> > +               if (f->pt_img[0].z =3D=3D 0) {
> >> > +                       /*The first finger slot is zero when a n=
on-resting
> >> > +                       finger lifted and remaining only one res=
ting finger
> >> > +                       on touchpad. Hardware report the remaini=
ng resting
> >> > +                       finger in second slot. This resting is i=
gnored*/
> >> > +                       fn =3D 0;
> >> > +               } else if (f->pt_img[1].z =3D=3D 0) {
> >> > +                       /* The second finger slot is zero if the=
re's
> >> > +                       only one finger*/
> >> > +                       fn =3D 1;
> >> > +               } else {
> >> > +                       /*All non-resting fingers will be counte=
d to report*/
> >> > +                       fn =3D 0;
> >> > +                       for (i =3D 0; i < V7_IMG_PT_NUM; i++) {
> >> > +                               if (priv->pt_attr[i].is_counted)
> >> > +                                       fn++;
> >> > +                       }
> >> > +
> >> > +                       /*In the case that both fingers are
> >> > +                       resting fingers, report the first one*/
> >> > +                       if (!priv->pt_attr[0].is_counted &&
> >> > +                           !priv->pt_attr[1].is_counted) {
> >> > +                               fn =3D 1;
> >> > +                       }
> >> > +               }
> >> > +               break;
> >> > +       case V7_PACKET_ID_MULTI:
> >> > +               /*A packet ID 'MULTI' indicats that at least 3 n=
on-resting
> >> > +               finger exist.*/
> >> > +               fn =3D 3 + priv->r.v7.additional_fingers;
> >> > +               break;
> >> > +       }
> >> > +
> >> > +       f->fingers =3D fn;
> >> > +}
> >> > +
> >> > +static void alps_assign_buttons_v7(struct psmouse *psmouse,
> >> > +                                  struct alps_fields *f)
> >> > +{
> >> > +       struct alps_data *priv =3D psmouse->private;
> >> > +
> >> > +       if (priv->phy_btn) {
> >> > +               if (!priv->prev_phy_btn) {
> >> > +                       /* Report a right click as long as there=
's finger on
> >> > +                       right button zone. Othrewise, report a l=
eft click.*/
> >> > +                       if (priv->r.v7.rest_right ||
> >> > +                           priv->pt_attr[0].zone & ZONE_RIGHT_B=
TN ||
> >> > +                           priv->pt_attr[1].zone & ZONE_RIGHT_B=
TN) {
> >> > +                               f->btn.right =3D 1;
> >> > +                               priv->pressed_btn_bits |=3D RIGH=
T_BUTTON_BIT;
> >> > +                       } else {
> >> > +                               f->btn.left =3D 1;
> >> > +                               priv->pressed_btn_bits |=3D LEFT=
_BUTTON_BIT;
> >> > +                       }
> >> > +               } else {
> >> > +                       if (priv->pressed_btn_bits & RIGHT_BUTTO=
N_BIT)
> >> > +                               f->btn.right =3D 1;
> >> > +                       if (priv->pressed_btn_bits & LEFT_BUTTON=
_BIT)
> >> > +                               f->btn.left =3D 1;
> >> > +               }
> >> > +       } else {
> >> > +               priv->pressed_btn_bits =3D 0;
> >> > +               f->btn.right =3D 0;
> >> > +               f->btn.left =3D 0;
> >> > +       }
> >> > +
> >> > +       priv->prev_phy_btn =3D priv->phy_btn;
> >> > +}
> >> > +
> >> > +static void alps_process_packet_v7(struct psmouse *psmouse)
> >> > +{
> >> > +       struct alps_data *priv =3D psmouse->private;
> >> > +       struct alps_fields f =3D {0};
> >> > +       unsigned char *packet =3D psmouse->packet;
> >> > +
> >> > +       priv->decode_fields(&f, packet, psmouse);
> >> > +
> >> > +       if (alps_drop_unsupported_packet_v7(psmouse))
> >> > +               return;
> >> > +
> >> > +       alps_set_pt_attr_v7(psmouse, &f);
> >> > +
> >> > +       alps_cal_output_finger_num_v7(psmouse, &f);
> >> > +
> >> > +       alps_assign_buttons_v7(psmouse, &f);
> >> > +
> >> > +       alps_report_coord_and_btn(psmouse, &f);
> >> > +}
> >> > +
> >> >  static void alps_report_bare_ps2_packet(struct psmouse *psmouse=
,
> >> >                                         unsigned char packet[],
> >> >                                         bool report_buttons)
> >> > @@ -1080,6 +1420,14 @@ static psmouse_ret_t alps_process_byte(st=
ruct psmouse *psmouse)
> >> >                 return PSMOUSE_BAD_DATA;
> >> >         }
> >> >
> >> > +       if ((priv->proto_version =3D=3D ALPS_PROTO_V7 &&
> >> > +           !alps_is_valid_package_v7(psmouse))) {
> >> > +               psmouse_dbg(psmouse, "refusing packet[%i] =3D %x=
\n",
> >> > +                           psmouse->pktcnt - 1,
> >> > +                           psmouse->packet[psmouse->pktcnt - 1]=
);
> >> > +               return PSMOUSE_BAD_DATA;
> >> > +       }
> >> > +
> >> >         if (psmouse->pktcnt =3D=3D psmouse->pktsize) {
> >> >                 priv->process_packet(psmouse);
> >> >                 return PSMOUSE_FULL_PACKET;
> >> > @@ -1192,6 +1540,22 @@ static int alps_rpt_cmd(struct psmouse *p=
smouse, int init_command,
> >> >         return 0;
> >> >  }
> >> >
> >> > +static int alps_check_valid_firmware_id(unsigned char id[])
> >> > +{
> >> > +       int valid =3D 1;
> >> > +
> >> > +       if (id[0] =3D=3D 0x73)
> >> > +               valid =3D 1;
> >> > +       else if (id[0] =3D=3D 0x88) {
> >> > +               if ((id[1] =3D=3D 0x07) ||
> >> > +                   (id[1] =3D=3D 0x08) ||
> >> > +                   ((id[1] & 0xf0) =3D=3D 0xB0))
> >> > +                       valid =3D 1;
> >> > +       }
> >> > +
> >> > +       return valid;
> >> > +}
> >> > +
> >> >  static int alps_enter_command_mode(struct psmouse *psmouse)
> >> >  {
> >> >         unsigned char param[4];
> >> > @@ -1201,8 +1565,7 @@ static int alps_enter_command_mode(struct =
psmouse *psmouse)
> >> >                 return -1;
> >> >         }
> >> >
> >> > -       if ((param[0] !=3D 0x88 || (param[1] !=3D 0x07 && param[=
1] !=3D 0x08)) &&
> >> > -           param[0] !=3D 0x73) {
> >> > +       if (!alps_check_valid_firmware_id(param)) {
> >> >                 psmouse_dbg(psmouse,
> >> >                             "unknown response while entering com=
mand mode\n");
> >> >                 return -1;
> >> > @@ -1704,6 +2067,32 @@ error:
> >> >         return ret;
> >> >  }
> >> >
> >> > +static int alps_hw_init_v7(struct psmouse *psmouse)
> >> > +{
> >> > +       struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> >> > +       int reg_val, ret =3D -1;
> >> > +
> >> > +       if (alps_enter_command_mode(psmouse) ||
> >> > +           alps_command_mode_read_reg(psmouse, 0xc2d9) =3D=3D -=
1)
> >> > +               goto error;
> >> > +
> >> > +       if (alps_command_mode_write_reg(psmouse, 0xc2c9, 0x64))
> >> > +               goto error;
> >> > +
> >> > +       reg_val =3D alps_command_mode_read_reg(psmouse, 0xc2c4);
> >> > +       if (reg_val =3D=3D -1)
> >> > +               goto error;
> >> > +       if (__alps_command_mode_write_reg(psmouse, reg_val | 0x0=
2))
> >> > +               goto error;
> >> > +
> >> > +       alps_exit_command_mode(psmouse);
> >> > +       return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> >> > +
> >> > +error:
> >> > +       alps_exit_command_mode(psmouse);
> >> > +       return ret;
> >> > +}
> >> > +
> >> >  /* Must be in command mode when calling this function */
> >> >  static int alps_absolute_mode_v4(struct psmouse *psmouse)
> >> >  {
> >> > @@ -1875,6 +2264,7 @@ static void alps_set_defaults(struct alps_=
data *priv)
> >> >                 priv->set_abs_params =3D alps_set_abs_params_st;
> >> >                 priv->x_max =3D 1023;
> >> >                 priv->y_max =3D 767;
> >> > +               priv->slot_number =3D 1;
> >> >                 break;
> >> >         case ALPS_PROTO_V3:
> >> >                 priv->hw_init =3D alps_hw_init_v3;
> >> > @@ -1883,6 +2273,7 @@ static void alps_set_defaults(struct alps_=
data *priv)
> >> >                 priv->decode_fields =3D alps_decode_pinnacle;
> >> >                 priv->nibble_commands =3D alps_v3_nibble_command=
s;
> >> >                 priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> >> > +               priv->slot_number =3D 2;
> >> >                 break;
> >> >         case ALPS_PROTO_V4:
> >> >                 priv->hw_init =3D alps_hw_init_v4;
> >> > @@ -1890,6 +2281,7 @@ static void alps_set_defaults(struct alps_=
data *priv)
> >> >                 priv->set_abs_params =3D alps_set_abs_params_mt;
> >> >                 priv->nibble_commands =3D alps_v4_nibble_command=
s;
> >> >                 priv->addr_command =3D PSMOUSE_CMD_DISABLE;
> >> > +               priv->slot_number =3D 2;
> >> >                 break;
> >> >         case ALPS_PROTO_V5:
> >> >                 priv->hw_init =3D alps_hw_init_dolphin_v1;
> >> > @@ -1905,6 +2297,7 @@ static void alps_set_defaults(struct alps_=
data *priv)
> >> >                 priv->y_max =3D 660;
> >> >                 priv->x_bits =3D 23;
> >> >                 priv->y_bits =3D 12;
> >> > +               priv->slot_number =3D 2;
> >> >                 break;
> >> >         case ALPS_PROTO_V6:
> >> >                 priv->hw_init =3D alps_hw_init_v6;
> >> > @@ -1913,6 +2306,22 @@ static void alps_set_defaults(struct alps=
_data *priv)
> >> >                 priv->nibble_commands =3D alps_v6_nibble_command=
s;
> >> >                 priv->x_max =3D 2047;
> >> >                 priv->y_max =3D 1535;
> >> > +               priv->slot_number =3D 2;
> >> > +               break;
> >> > +       case ALPS_PROTO_V7:
> >> > +               priv->hw_init =3D alps_hw_init_v7;
> >> > +               priv->process_packet =3D alps_process_packet_v7;
> >> > +               priv->decode_fields =3D alps_decode_packet_v7;
> >> > +               priv->set_abs_params =3D alps_set_abs_params_mt;
> >> > +               priv->nibble_commands =3D alps_v3_nibble_command=
s;
> >> > +               priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> >> > +               priv->x_max =3D 0xfff;
> >> > +               priv->y_max =3D 0x7ff;
> >> > +               priv->resting_zone_y_min =3D 0x654;
> >> > +               priv->byte0 =3D 0x48;
> >> > +               priv->mask0 =3D 0x48;
> >> > +               priv->flags =3D 0;
> >> > +               priv->slot_number =3D 2;
> >> >                 break;
> >> >         }
> >> >  }
> >> > @@ -1982,6 +2391,11 @@ static int alps_identify(struct psmouse *=
psmouse, struct alps_data *priv)
> >> >                         return -EIO;
> >> >                 else
> >> >                         return 0;
> >> > +       } else if (ec[0] =3D=3D 0x88 && (ec[1] & 0xf0) =3D=3D 0x=
B0) {
> >> > +               priv->proto_version =3D ALPS_PROTO_V7;
> >> > +               alps_set_defaults(priv);
> >> > +
> >> > +               return 0;
> >> >         } else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x08) {
> >> >                 priv->proto_version =3D ALPS_PROTO_V3;
> >> >                 alps_set_defaults(priv);
> >> > @@ -2045,7 +2459,7 @@ static void alps_set_abs_params_mt(struct =
alps_data *priv,
> >> >                                    struct input_dev *dev1)
> >> >  {
> >> >         set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
> >> > -       input_mt_init_slots(dev1, 2, 0);
> >> > +       input_mt_init_slots(dev1, priv->slot_number, 0);
> >> >         input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x=
_max, 0, 0);
> >> >         input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y=
_max, 0, 0);
> >> >
> >> > diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/al=
ps.h
> >> > index 03f88b6..5d2f9ea 100644
> >> > --- a/drivers/input/mouse/alps.h
> >> > +++ b/drivers/input/mouse/alps.h
> >> > @@ -18,11 +18,36 @@
> >> >  #define ALPS_PROTO_V4  4
> >> >  #define ALPS_PROTO_V5  5
> >> >  #define ALPS_PROTO_V6  6
> >> > +#define ALPS_PROTO_V7  7
> >> > +
> >> > +#define MAX_IMG_PT_NUM         5
> >> > +#define V7_IMG_PT_NUM          2
> >> > +
> >> > +#define ZONE_NORMAL                            0x01
> >> > +#define ZONE_RESTING                   0x02
> >> > +#define ZONE_LEFT_BTN                  0x04
> >> > +#define ZONE_RIGHT_BTN                 0x08
> >> >
> >> >  #define DOLPHIN_COUNT_PER_ELECTRODE    64
> >> >  #define DOLPHIN_PROFILE_XOFFSET                8       /* x-ele=
ctrode offset */
> >> >  #define DOLPHIN_PROFILE_YOFFSET                1       /* y-ele=
ctrode offset */
> >> >
> >> > +/*
> >> > + * enum V7_PACKET_ID - defines the packet type for V7
> >> > + * V7_PACKET_ID_IDLE: There's no finger and no button activity.
> >> > + * V7_PACKET_ID_TWO: There's one or two non-resting fingers on =
touchpad
> >> > + *  or there's button activities.
> >> > + * V7_PACKET_ID_MULTI: There are at least three non-resting fin=
gers.
> >> > + * V7_PACKET_ID_NEW: The finger position in slot is not continu=
es from
> >> > + *  previous packet.
> >> > +*/
> >> > +enum V7_PACKET_ID {
> >> > +        V7_PACKET_ID_IDLE,
> >> > +        V7_PACKET_ID_TWO,
> >> > +        V7_PACKET_ID_MULTI,
> >> > +        V7_PACKET_ID_NEW,
> >> > +};
> >> > +
> >> >  /**
> >> >   * struct alps_model_info - touchpad ID table
> >> >   * @signature: E7 response string to match.
> >> > @@ -66,15 +91,7 @@ struct alps_nibble_commands {
> >> >  };
> >> >
> >> >  /**
> >> > - * struct alps_fields - decoded version of the report packet
> >> > - * @x_map: Bitmap of active X positions for MT.
> >> > - * @y_map: Bitmap of active Y positions for MT.
> >> > - * @fingers: Number of fingers for MT.
> >> > - * @x: X position for ST.
> >> > - * @y: Y position for ST.
> >> > - * @z: Z position for ST.
> >> > - * @first_mp: Packet is the first of a multi-packet report.
> >> > - * @is_mp: Packet is part of a multi-packet report.
> >> > + * struct alps_btn - decoded version of the button status
> >> >   * @left: Left touchpad button is active.
> >> >   * @right: Right touchpad button is active.
> >> >   * @middle: Middle touchpad button is active.
> >> > @@ -82,16 +99,7 @@ struct alps_nibble_commands {
> >> >   * @ts_right: Right trackstick button is active.
> >> >   * @ts_middle: Middle trackstick button is active.
> >> >   */
> >> > -struct alps_fields {
> >> > -       unsigned int x_map;
> >> > -       unsigned int y_map;
> >> > -       unsigned int fingers;
> >> > -       unsigned int x;
> >> > -       unsigned int y;
> >> > -       unsigned int z;
> >> > -       unsigned int first_mp:1;
> >> > -       unsigned int is_mp:1;
> >> > -
> >> > +struct alps_btn {
> >> >         unsigned int left:1;
> >> >         unsigned int right:1;
> >> >         unsigned int middle:1;
> >> > @@ -102,6 +110,69 @@ struct alps_fields {
> >> >  };
> >> >
> >> >  /**
> >> > + * struct alps_btn - decoded version of the X Y Z postion for S=
T.
> >> > + * @x: X position for ST.
> >> > + * @y: Y position for ST.
> >> > + * @z: Z position for ST.
> >> > + */
> >> > +struct alps_abs_data {
> >> > +       unsigned int x;
> >> > +       unsigned int y;
> >> > +       unsigned int z;
> >> > +};
> >> > +
> >> > +/**
> >> > + * struct alps_fields - decoded version of the report packet
> >> > + * @fingers: Number of fingers for MT.
> >> > + * @pt: X Y Z postion for ST.
> >> > + * @pt: X Y Z postion for image MT.
> >> > + * @x_map: Bitmap of active X positions for MT.
> >> > + * @y_map: Bitmap of active Y positions for MT.
> >> > + * @first_mp: Packet is the first of a multi-packet report.
> >> > + * @is_mp: Packet is part of a multi-packet report.
> >> > + * @btn: Button activity status
> >> > + */
> >> > +struct alps_fields {
> >> > +       unsigned int fingers;
> >> > +       struct alps_abs_data pt;
> >> > +       struct alps_abs_data pt_img[MAX_IMG_PT_NUM];
> >> > +       unsigned int x_map;
> >> > +       unsigned int y_map;
> >> > +       unsigned int first_mp:1;
> >> > +       unsigned int is_mp:1;
> >> > +       struct alps_btn btn;
> >> > +};
> >> > +
> >> > +/**
> >> > + * struct v7_raw - data decoded from raw packet for V7.
> >> > + * @pkt_id: An id that specifies the type of packet.
> >> > + * @additional_fingers: Number of additional finger that is nei=
ghter included
> >> > + *  in pt slot nor reflected in rest_left and rest_right flag o=
f data packet.
> >> > + * @rest_left: There are fingers on left resting zone.
> >> > + * @rest_right: There are fingers on right resting zone.
> >> > + */
> >> > +struct v7_raw {
> >> > +       unsigned char pkt_id;
> >> > +       unsigned int additional_fingers;
> >> > +       unsigned char rest_left;
> >> > +       unsigned char rest_right;
> >> > +};
> >> > +
> >> > +/**
> >> > + * struct alps_bl_pt_attr - generic attributes of touch points =
for buttonless device
> >> > + * @zone: The part of touchpad that the touch point locates
> >> > + * @is_counted: The touch point is not a resting finger.
> >> > + * @is_init_pt_got: The touch down point is got.
> >> > + * @init_pt: The X Y Z position of the touch down point.
> >> > + */
> >> > +struct alps_bl_pt_attr {
> >> > +       unsigned char zone;
> >> > +       unsigned char is_counted;
> >> > +       unsigned char is_init_pt_got;
> >> > +       struct alps_abs_data init_pt;
> >> > +};
> >> > +
> >> > +/**
> >> >   * struct alps_data - private data structure for the ALPS drive=
r
> >> >   * @dev2: "Relative" device used to report trackstick or mouse =
activity.
> >> >   * @phys: Physical path for the relative device.
> >> > @@ -116,8 +187,10 @@ struct alps_fields {
> >> >   * @flags: Additional device capabilities (passthrough port, tr=
ackstick, etc.).
> >> >   * @x_max: Largest possible X position value.
> >> >   * @y_max: Largest possible Y position value.
> >> > + * @resting_zone_y_min: Smallest Y postion value of the bottom =
resting zone.
> >> >   * @x_bits: Number of X bits in the MT bitmap.
> >> >   * @y_bits: Number of Y bits in the MT bitmap.
> >> > + * @img_fingers: Number of image fingers.
> >> >   * @hw_init: Protocol-specific hardware init function.
> >> >   * @process_packet: Protocol-specific function to process a rep=
ort packet.
> >> >   * @decode_fields: Protocol-specific function to read packet bi=
tfields.
> >> > @@ -132,6 +205,11 @@ struct alps_fields {
> >> >   * @fingers: Number of fingers from last MT report.
> >> >   * @quirks: Bitmap of ALPS_QUIRK_*.
> >> >   * @timer: Timer for flushing out the final report packet in th=
e stream.
> >> > + * @v7: Data decoded from raw packet for V7
> >> > + * @phy_btn: Physical button is active.
> >> > + * @prev_phy_btn: Physical button of previous packet is active.
> >> > + * @pressed_btn_bits: Pressed positon of button zone
> >> > + * @pt_attr: Generic attributes of touch points for buttonless =
device.
> >> >   */
> >> >  struct alps_data {
> >> >         struct input_dev *dev2;
> >> > @@ -145,8 +223,10 @@ struct alps_data {
> >> >         unsigned char flags;
> >> >         int x_max;
> >> >         int y_max;
> >> > +       int resting_zone_y_min;
> >> >         int x_bits;
> >> >         int y_bits;
> >> > +       unsigned char slot_number;
> >> >
> >> >         int (*hw_init)(struct psmouse *psmouse);
> >> >         void (*process_packet)(struct psmouse *psmouse);
> >> > @@ -161,6 +241,15 @@ struct alps_data {
> >> >         int fingers;
> >> >         u8 quirks;
> >> >         struct timer_list timer;
> >> > +
> >> > +       /* these are used for buttonless touchpad*/
> >> > +       union {
> >> > +               struct v7_raw v7;
> >> > +       } r;
> >> > +       unsigned char phy_btn;
> >> > +       unsigned char prev_phy_btn;
> >> > +       unsigned char pressed_btn_bits;
> >> > +       struct alps_bl_pt_attr pt_attr[MAX_IMG_PT_NUM];
> >> >  };
> >> >
> >> >  #define ALPS_QUIRK_TRACKSTICK_BUTTONS  1 /* trakcstick buttons =
in trackstick packet */
> >> > --
> >> > 1.8.3.2
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-in=
put" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
