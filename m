From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 9/9 v2] Input: synaptics - process finger (<=5) transitions
Date: Sat, 23 Jul 2011 12:11:18 +0800
Message-ID: <CAGS+omABdrRjZ0nsajAB3WRj2WASUYKMfAaPeaOWuhUfLUFMeQ@mail.gmail.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
 <1311169146-20066-10-git-send-email-djkurtz@chromium.org> <4E2A1D9A.2090704@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E2A1D9A.2090704@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org
List-Id: linux-input@vger.kernel.org

Hi Chase,

Thanks for all of your reviews!

On Sat, Jul 23, 2011 at 9:02 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
>
> On 07/20/2011 06:39 AM, djkurtz@chromium.org wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> >
> > Synaptics image sensor touchpads track up to 5 fingers, but only re=
port 2.
> > They use a special "TYPE=3D2" (AGM-CONTACT) packet type that report=
s
> > the number of tracked fingers and which finger is reported in the S=
GM
> > and AGM packets.
> >
> > With this new packet type, it is possible to tell userspace when 4 =
or 5
> > fingers are touching.
>
> Maybe I'm blind, but I don't see where the QUADTAP and QUINTAP values
> are set in the events. I see where the bits are set during
> initialization, but not during use.

It's subtle.
The firmware actually report 4/5 in the AGM-CONTACT packet, which the
agm packet parser sets directly in mt_state->count.
This is then reported to userspace when synaptics_report_mt() calls
input_mt_report_finger_count(dev, mt_state->count), which now supports
QUINTTAP (see patch #8).

-Daniel

>
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> > =A0drivers/input/mouse/synaptics.c | =A0 44 +++++++++++++++++++++++=
+++++++++++++++-
> > =A01 files changed, 43 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/=
synaptics.c
> > index 893e567..2a1e05f 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -729,6 +729,10 @@ static void synaptics_image_sensor_1f(struct s=
ynaptics_data *priv,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt_state, 0, -1,=
 -1);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt_state_lost =3D true;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 case 4:
> > + =A0 =A0 case 5:
> > + =A0 =A0 =A0 =A0 =A0 =A0 /* mt_state was updated by AGM-CONTACT pa=
cket */
> > + =A0 =A0 =A0 =A0 =A0 =A0 break;
> > =A0 =A0 =A0 }
> > =A0}
> >
> > @@ -775,6 +779,10 @@ static void synaptics_image_sensor_2f(struct s=
ynaptics_data *priv,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt_state, 0, -1,=
 -1);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt_state_lost =3D true;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 case 4:
> > + =A0 =A0 case 5:
> > + =A0 =A0 =A0 =A0 =A0 =A0 /* mt_state was updated by AGM-CONTACT pa=
cket */
> > + =A0 =A0 =A0 =A0 =A0 =A0 break;
> > =A0 =A0 =A0 }
> > =A0}
> >
> > @@ -803,6 +811,22 @@ static void synaptics_image_sensor_3f(struct s=
ynaptics_data *priv,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > =A0 =A0 =A0 case 2:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the AGM previously contained slot=
 3 or higher, then the
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0* newly touching finger is in the lowe=
st available slot.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If SGM was previously 1 or higher, t=
hen the new SGM is
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0* now slot 0 (with a new finger), othe=
rwise, the new finger
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0* is now in a hidden slot between 0 an=
d AGM's slot.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0* In all such cases, the SGM now conta=
ins slot 0, and the AGM
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0* continues to contain the same slot a=
s before.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (old->agm >=3D 3) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt=
_state, 3, 0, old->agm);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 /*
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* After some 3->1 and all 3->2 trans=
itions, we lose track
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of which slot is reported by sgm a=
nd agm.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> > @@ -836,9 +860,22 @@ static void synaptics_image_sensor_3f(struct s=
ynaptics_data *priv,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* received AGM-CONTACT packet.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +
> > + =A0 =A0 case 4:
> > + =A0 =A0 case 5:
> > + =A0 =A0 =A0 =A0 =A0 =A0 /* mt_state was updated by AGM-CONTACT pa=
cket */
> > + =A0 =A0 =A0 =A0 =A0 =A0 break;
> > =A0 =A0 =A0 }
> > =A0}
> >
> > +/* Handle case where mt_state->count =3D 4, or =3D 5 */
> > +static void synaptics_image_sensor_45f(struct synaptics_data *priv=
,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct synaptics_mt_state *mt_state)
> > +{
> > + =A0 =A0 /* mt_state was updated correctly by AGM-CONTACT packet *=
/
> > + =A0 =A0 priv->mt_state_lost =3D false;
> > +}
> > +
> > =A0static void synaptics_image_sensor_process(struct psmouse *psmou=
se,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0struct synaptics_hw_state *sgm)
> > =A0{
> > @@ -858,8 +895,10 @@ static void synaptics_image_sensor_process(str=
uct psmouse *psmouse,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_image_sensor_1f(priv, &mt_sta=
te);
> > =A0 =A0 =A0 else if (sgm->w =3D=3D 0)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_image_sensor_2f(priv, &mt_sta=
te);
> > - =A0 =A0 else if (sgm->w =3D=3D 1)
> > + =A0 =A0 else if (sgm->w =3D=3D 1 && mt_state.count <=3D 3)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_image_sensor_3f(priv, &mt_sta=
te);
> > + =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 synaptics_image_sensor_45f(priv, &mt_stat=
e);
> >
> > =A0 =A0 =A0 /* Send resulting input events to user space */
> > =A0 =A0 =A0 synaptics_report_mt(psmouse, &mt_state, sgm);
> > @@ -1078,6 +1117,9 @@ static void set_input_params(struct input_dev=
 *dev, struct synaptics_data *priv)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_PRESSU=
RE, 0, 255, 0, 0);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Image sensors can sometimes report p=
er-contact width */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_TOUCH_=
MAJOR, 4, 15, 0, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 /* Image sensors can signal 4 and 5 finge=
r clicks */
> > + =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_QUADTAP, dev->keybit);
> > + =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_QUINTTAP, dev->keybit)=
;
> > =A0 =A0 =A0 } else if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Non-image sensors with AGM use semi-=
mt */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_SEMI_MT, dev->prop=
bit);
>
