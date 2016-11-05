From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [PATCH] Input: ALPS - Fix TrackStick support for SS5 hardware
Date: Sat, 5 Nov 2016 12:30:47 -0400
Message-ID: <20161105163047.GE2927@TopQuark.net>
References: <20161024210122.GA2919@TopQuark.net>
 <20161101093507.GE3081@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:52669 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754881AbcKEQau (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 5 Nov 2016 12:30:50 -0400
Content-Disposition: inline
In-Reply-To: <20161101093507.GE3081@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Tue, Nov 01, 2016 at 10:35:07AM +0100, Pali Roh=E1r wrote:
> On Monday 24 October 2016 17:01:22 Paul Donohue wrote:
> > The current Alps SS5 (SS4 v2) code generates bogus TouchPad events wh=
en=20
> > TrackStick packets are processed.
> >=20
> > This causes the xorg synaptics driver to print=20
> > "unable to find touch point 0" and=20
> > "BUG: triggered 'if (priv->num_active_touches > priv->num_slots)'"=20
> > messages.  It also causes unexpected TouchPad button release and recl=
ick=20
> > event sequences if the TrackStick is moved while holding a TouchPad=20
> > button.
> >=20
> > This commit corrects the problem by setting a flag for the relevant=20
> > packet type in alps_decode_ss4_v2(), then using that flag in=20
> > alps_process_packet_ss4_v2() to send only TrackStick reports when=20
> > processing TrackStick packets.
> >=20
> > Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>
> >=20
> > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > index 6d7de9b..2c2e55b 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -1279,6 +1279,8 @@ static int alps_decode_ss4_v2(struct alps_field=
s *f,
> >                         input_report_rel(priv->dev2, REL_Y, -y);
> >                         input_report_abs(priv->dev2, ABS_PRESSURE, pr=
essure);
> >                 }
> > +               f->first_mp =3D 0;
> > +               f->is_mp =3D 0;
> >                 break;
> > =20
> >         case SS4_PACKET_ID_IDLE:
> > @@ -1289,12 +1291,14 @@ static int alps_decode_ss4_v2(struct alps_fie=
lds *f,
> > =20
> >         /* handle buttons */
> >         if (pkt_id =3D=3D SS4_PACKET_ID_STICK) {
> > +               f->is_ts =3D 1;
> >                 f->ts_left =3D !!(SS4_BTN_V2(p) & 0x01);
> >                 if (!(priv->flags & ALPS_BUTTONPAD)) {
> >                         f->ts_right =3D !!(SS4_BTN_V2(p) & 0x02);
> >                         f->ts_middle =3D !!(SS4_BTN_V2(p) & 0x04);
> >                 }
> >         } else {
> > +               f->is_ts =3D 0;
> >                 f->left =3D !!(SS4_BTN_V2(p) & 0x01);
> >                 if (!(priv->flags & ALPS_BUTTONPAD)) {
> >                         f->right =3D !!(SS4_BTN_V2(p) & 0x02);
> > @@ -1346,18 +1350,18 @@ static void alps_process_packet_ss4_v2(struct=
 psmouse *psmouse)
> > =20
> >         priv->multi_packet =3D 0;
> > =20
> > -       alps_report_mt_data(psmouse, (f->fingers <=3D 4) ? f->fingers=
 : 4);
> > -
> > -       input_mt_report_finger_count(dev, f->fingers);
> > +       if (!f->is_ts) {
> > +               alps_report_mt_data(psmouse, (f->fingers <=3D 4) ? f-=
>fingers : 4);
> > =20
> > -       input_report_key(dev, BTN_LEFT, f->left);
> > -       input_report_key(dev, BTN_RIGHT, f->right);
> > -       input_report_key(dev, BTN_MIDDLE, f->middle);
> > +               input_mt_report_finger_count(dev, f->fingers);
> > =20
> > -       input_report_abs(dev, ABS_PRESSURE, f->pressure);
> > -       input_sync(dev);
> > +               input_report_key(dev, BTN_LEFT, f->left);
> > +               input_report_key(dev, BTN_RIGHT, f->right);
> > +               input_report_key(dev, BTN_MIDDLE, f->middle);
> > =20
> > -       if (priv->flags & ALPS_DUALPOINT) {
> > +               input_report_abs(dev, ABS_PRESSURE, f->pressure);
> > +               input_sync(dev);
> > +       } else {
> >                 input_report_key(dev2, BTN_LEFT, f->ts_left);
> >                 input_report_key(dev2, BTN_RIGHT, f->ts_right);
> >                 input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
> > diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> > index b9417e2..1dc09b5 100644
> > --- a/drivers/input/mouse/alps.h
> > +++ b/drivers/input/mouse/alps.h
> > @@ -192,6 +192,7 @@ struct alps_bitmap_point {
> >   * @left: Left touchpad button is active.
> >   * @right: Right touchpad button is active.
> >   * @middle: Middle touchpad button is active.
> > + * @is_ts: Packet is for the trackstick, not the touchpad.
> >   * @ts_left: Left trackstick button is active.
> >   * @ts_right: Right trackstick button is active.
> >   * @ts_middle: Middle trackstick button is active.
> > @@ -212,6 +213,7 @@ struct alps_fields {
> >         unsigned int right:1;
> >         unsigned int middle:1;
> > =20
> > +       unsigned int is_ts:1;
> >         unsigned int ts_left:1;
> >         unsigned int ts_right:1;
> >         unsigned int ts_middle:1;
> >=20
>=20
> Hi! What looks suspicious on this patch is that you need to extend
> structure in alps.h for marking packet as it comes from trackstick...
> and only for sse_v2 devices. It is not possible to do detection in
> process code similarly like for other devices?

I was trying to avoid duplicating the detection logic (that is already
implemented in alps_get_pkt_id_ss4_v2(), but yes, it is possible to
implement the detection the same way as the other devices.
