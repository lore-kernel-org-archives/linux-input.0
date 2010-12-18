From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 4/4] Input: synaptics - emit multitouch data
Date: Sat, 18 Dec 2010 11:11:11 -0600
Message-ID: <AANLkTi=YVxs07E3LqMZuKP-sHQbFdQbLpox7iypq=8jN@mail.gmail.com>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
	<1292683981-6908-5-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292683981-6908-5-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

I haven't tested this one but it looks like only 2 lines different
from one I did (report as FINGER again and new cap).  So you still
have my:

Acked-by: Chris Bagwell <chris@cnpbagwell.com>

On Sat, Dec 18, 2010 at 8:53 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> In multitouch mode, two data packets are sent from the device. =A0Due=
 to
> limitations in the hardware detection mechanism, individual contacts
> cannot be reliably extracted. However, the bounding rectangle of the
> individual contacts can be accurately reproduced. This patch emits th=
e
> MT data as rectangle corners, allowing userspace to track and produce
> appropriate gestures. The number of fingers are still reported as bef=
ore.
> The INPUT_PROP_SEMI_MT quirk is set to signal this special behavior.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/input/mouse/synaptics.c | =A0 42 +++++++++++++++++++++++++=
+++++++++++++-
> =A01 files changed, 41 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> index 01302db..1ae5c29 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -25,7 +25,7 @@
>
> =A0#include <linux/module.h>
> =A0#include <linux/dmi.h>
> -#include <linux/input.h>
> +#include <linux/input/mt.h>
> =A0#include <linux/serio.h>
> =A0#include <linux/libps2.h>
> =A0#include <linux/slab.h>
> @@ -489,6 +489,34 @@ static int synaptics_parse_hw_state(unsigned cha=
r buf[], struct synaptics_data *
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static void set_slot(struct input_dev *dev, int slot, bool active, i=
nt x, int y)
> +{
> + =A0 =A0 =A0 input_mt_slot(dev, slot);
> + =A0 =A0 =A0 input_mt_report_slot_state(dev, MT_TOOL_FINGER, active)=
;
> + =A0 =A0 =A0 if (active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_X=
, x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_POSITION_Y=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0YMAX=
_NOMINAL + YMIN_NOMINAL - y);
> + =A0 =A0 =A0 }
> +}
> +
> +static void synaptics_report_mt_data(struct input_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const struct synaptics_hw_state *a,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const struct synaptics_hw_state *b,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0int num_fingers)
> +{
> + =A0 =A0 =A0 if (num_fingers >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_slot(dev, 0, true, min(a->x, b->x),=
 min(a->y, b->y));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_slot(dev, 1, true, max(a->x, b->x),=
 max(a->y, b->y));
> + =A0 =A0 =A0 } else if (num_fingers =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_slot(dev, 0, true, a->x, a->y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_slot(dev, 1, false, 0, 0);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_slot(dev, 0, false, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_slot(dev, 1, false, 0, 0);
> + =A0 =A0 =A0 }
> +}
> +
> =A0/*
> =A0* =A0called for each full received packet from the touchpad
> =A0*/
> @@ -551,6 +579,9 @@ static void synaptics_process_packet(struct psmou=
se *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0finger_width =3D 0;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (priv->multitouch)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_report_mt_data(dev, &hw, &pri=
v->mt, num_fingers);
> +
> =A0 =A0 =A0 =A0/* Post events
> =A0 =A0 =A0 =A0 * BTN_TOUCH has to be first as mousedev relies on it =
when doing
> =A0 =A0 =A0 =A0 * absolute -> relative conversion
> @@ -662,6 +693,7 @@ static void set_input_params(struct input_dev *de=
v, struct synaptics_data *priv)
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0__set_bit(INPUT_PROP_POINTER, dev->propbit);
> + =A0 =A0 =A0 __set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
>
> =A0 =A0 =A0 =A0__set_bit(EV_ABS, dev->evbit);
> =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_X,
> @@ -670,6 +702,14 @@ static void set_input_params(struct input_dev *d=
ev, struct synaptics_data *priv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 YMIN_NOMINAL,=
 priv->y_max ?: YMAX_NOMINAL, 0, 0);
> =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
>
> + =A0 =A0 =A0 if (priv->multitouch) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(dev, 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_POSITI=
ON_X, XMIN_NOMINAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0priv->x_max ?: XMAX_NOMINAL, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_POSITI=
ON_Y, YMIN_NOMINAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0priv->y_max ?: YMAX_NOMINAL, 0, 0);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (SYN_CAP_PALMDETECT(priv->capabilities))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_TOOL_WID=
TH, 0, 15, 0, 0);
>
> --
> 1.7.2.3
>
>
