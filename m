From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/3] input: mt: Move tracking and pointer emulation to
 input-mt (rev2)
Date: Wed, 1 Dec 2010 17:25:43 -0800
Message-ID: <AANLkTin3h7k0p6v_5xg9tKb=MgG-KC=dkcitt16NQt0s@mail.gmail.com>
References: <1291224069-11770-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49020 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab0LBB0P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Dec 2010 20:26:15 -0500
In-Reply-To: <1291224069-11770-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 1, 2010 at 9:21 AM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> The drivers using the type B protocol all report tracking information
> the same way. The contact id is semantically equivalent to
> ABS_MT_SLOT, and the handling of ABS_MT_TRACKING_ID only complicates
> the driver. The situation can be improved upon by providing a common
> pointer emulation code, thereby removing the need for the tracking id
> in the driver. =A0This patch moves all tracking event handling over t=
o
> the input core, simplifying both the existing drivers and the ones
> currently in preparation.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Acked-by: Ping Cheng <pingc@wacom.com>

The changes that are related to Wacom driver look sane to me.

Dmitry,

Please ignore "[PATCH v2] Input: wacom - allow both MT and pen data to
be reported". I'll make a new one based on Henrik's patch.

Ping

> ---
> Hi Dmitry,
>
> This is revision two of this patch, fixing the compilation problem an=
d
> adding the pointer emulation comment. In addition, the fourth patch
> has been folded into this one, and touchpad finger count emulation ha=
s
> been added. The original idea was to add this later, but since the
> wacom driver is already touched in this patch, it makes sense to
> switch to pointer emulation here and now.
>
> Cheers,
> Henrik
>
> =A0drivers/hid/hid-3m-pct.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 30 +=
----------
> =A0drivers/input/input-mt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 91 +=
++++++++++++++++++++++++++++--
> =A0drivers/input/tablet/wacom_wac.c =A0 =A0 =A0 =A0| =A0 19 +------
> =A0drivers/input/tablet/wacom_wac.h =A0 =A0 =A0 =A0| =A0 =A04 --
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 13 +----
> =A0include/linux/input-mt.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +=
+++
> =A0include/linux/input.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> =A07 files changed, 105 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/hid/hid-3m-pct.c b/drivers/hid/hid-3m-pct.c
> index e3711c5..a9fc2c1 100644
> --- a/drivers/hid/hid-3m-pct.c
> +++ b/drivers/hid/hid-3m-pct.c
> @@ -28,7 +28,6 @@ MODULE_LICENSE("GPL");
> =A0#include "hid-ids.h"
>
> =A0#define MAX_SLOTS =A0 =A0 =A0 =A0 =A0 =A0 =A060
> -#define MAX_TRKID =A0 =A0 =A0 =A0 =A0 =A0 =A0USHRT_MAX
>
> =A0/* estimated signal-to-noise ratios */
> =A0#define SN_MOVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0204=
8
> @@ -36,14 +35,11 @@ MODULE_LICENSE("GPL");etter t
>
> =A0struct mmm_finger {
> =A0 =A0 =A0 =A0__s32 x, y, w, h;
> - =A0 =A0 =A0 __u16 id;
> - =A0 =A0 =A0 bool prev_touch;
> =A0 =A0 =A0 =A0bool touch, valid;
> =A0};
>
> =A0struct mmm_data {
> =A0 =A0 =A0 =A0struct mmm_finger f[MAX_SLOTS];
> - =A0 =A0 =A0 __u16 id;
> =A0 =A0 =A0 =A0__u8 curid;
> =A0 =A0 =A0 =A0__u8 nexp, nreal;
> =A0 =A0 =A0 =A0bool touch, valid;
> @@ -117,11 +113,6 @@ static int mmm_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00, 1, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_CONTACTID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 field->logical_maximum =
=3D MAX_TRKID;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage=
, bit, max,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EV_ABS, ABS_MT_TRACKING_ID);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(hi=
->input, ABS_MT_TRACKING_ID,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00, MAX_TRKID, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_init_slots(hi=
->input, MAX_SLOTS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -152,7 +143,6 @@ static int mmm_input_mapped(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0*/
> =A0static void mmm_filter_event(struct mmm_data *md, struct input_dev=
 *input)
> =A0{
> - =A0 =A0 =A0 struct mmm_finger *oldest =3D 0;
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0for (i =3D 0; i < MAX_SLOTS; ++i) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmm_finger *f =3D &md->f[i];
> @@ -161,6 +151,7 @@ static void mmm_filter_event(struct mmm_data *md,=
 struct input_dev *input)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_slot(input, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, f->to=
uch);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (f->touch) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* this finger is on t=
he screen */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int wide =3D (f->w > f=
->h);
> @@ -168,33 +159,16 @@ static void mmm_filter_event(struct mmm_data *m=
d, struct input_dev *input)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int major =3D max(f->w=
, f->h) >> 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int minor =3D min(f->w=
, f->h) >> 1;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!f->prev_touch)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f->id =3D=
 md->id++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_A=
BS, ABS_MT_TRACKING_ID, f->id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input, EV_=
ABS, ABS_MT_POSITION_X, f->x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input, EV_=
ABS, ABS_MT_POSITION_Y, f->y);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input, EV_=
ABS, ABS_MT_ORIENTATION, wide);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input, EV_=
ABS, ABS_MT_TOUCH_MAJOR, major);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input, EV_=
ABS, ABS_MT_TOUCH_MINOR, minor);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* touchscreen emulatio=
n: pick the oldest contact */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oldest || ((f->id =
- oldest->id) & (SHRT_MAX + 1)))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldest =
=3D f;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this finger took off=
 the screen */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_A=
BS, ABS_MT_TRACKING_ID, -1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 f->prev_touch =3D f->touch;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f->valid =3D 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* touchscreen emulation */
> - =A0 =A0 =A0 if (oldest) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_KEY, BTN_TOUCH, 1=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_X, oldes=
t->x);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_ABS, ABS_Y, oldes=
t->y);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_KEY, BTN_TOUCH, 0=
);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_mt_report_pointer_emulation(input);
> =A0 =A0 =A0 =A0input_sync(input);
> =A0}
>
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index c4a9784..be7264d 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -11,17 +11,18 @@
> =A0#include <linux/input-mt.h>
> =A0#include <linux/slab.h>
>
> +#define TRKID_SGN =A0 =A0 =A0((TRKID_MAX + 1) >> 1)
> +
> =A0/**
> =A0* input_mt_init_slots() - initialize MT input slots
> =A0* @dev: input device supporting MT events and finger tracking
> =A0* @num_slots: number of slots used by the device
> =A0*
> =A0* This function allocates all necessary memory for MT slot handlin=
g
> - * in the input device, adds ABS_MT_SLOT to the device capabilities
> - * and sets up appropriate event buffers. All slots are initially
> - * marked as unused by setting ABS_MT_TRACKING_ID to -1. May be call=
ed
> - * repeatedly. Returns -EINVAL if attempting to reinitialize with a
> - * different number of slots.
> + * in the input device, prepares the ABS_MT_SLOT and
> + * ABS_MT_TRACKING_ID events for use and sets up appropriate buffers=
=2E
> + * May be called repeatedly. Returns -EINVAL if attempting to
> + * reinitialize with a different number of slots.
> =A0*/
> =A0int input_mt_init_slots(struct input_dev *dev, unsigned int num_sl=
ots)
> =A0{
> @@ -38,6 +39,7 @@ int input_mt_init_slots(struct input_dev *dev, unsi=
gned int num_slots)
>
> =A0 =A0 =A0 =A0dev->mtsize =3D num_slots;
> =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_MT_SLOT, 0, num_slots - =
1, 0, 0);
> + =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_TRACKING_ID, 0, TRKID_=
MAX, 0, 0);
> =A0 =A0 =A0 =A0input_set_events_per_packet(dev, 6 * num_slots);
>
> =A0 =A0 =A0 =A0/* Mark slots as 'unused' */
> @@ -61,5 +63,84 @@ void input_mt_destroy_slots(struct input_dev *dev)
> =A0 =A0 =A0 =A0dev->mt =3D NULL;
> =A0 =A0 =A0 =A0dev->mtsize =3D 0;
> =A0 =A0 =A0 =A0dev->slot =3D 0;
> + =A0 =A0 =A0 dev->trkid =3D 0;
> =A0}
> =A0EXPORT_SYMBOL(input_mt_destroy_slots);
> +
> +/**
> + * input_mt_report_state() - report contact state
> + * @dev: input device with allocated MT slots
> + * @active: true if contact is active, false otherwise
> + *
> + * Reports an active touch via ABS_MT_TRACKING_ID. If active is
> + * true and the slot is currently inactive, a new tracking id is
> + * assigned to the slot.
> + */
> +void input_mt_report_slot_state(struct input_dev *dev, bool active)
> +{
> + =A0 =A0 =A0 struct input_mt_slot *mt =3D dev->mt;
> + =A0 =A0 =A0 int id;
> +
> + =A0 =A0 =A0 if (!mt || !active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(dev, EV_ABS, ABS_MT_TRACKIN=
G_ID, -1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 id =3D input_mt_get_value(&mt[dev->slot], ABS_MT_TRACKI=
NG_ID);
> + =A0 =A0 =A0 if (id < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 id =3D input_mt_new_trkid(dev);
> + =A0 =A0 =A0 input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, id);
> +}
> +EXPORT_SYMBOL(input_mt_report_slot_state);
> +
> +/**
> + * input_mt_report_pointer_emulation() - common pointer emulation
> + * @dev: input device with allocated MT slots
> + *
> + * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y and
> + * ABS_PRESSURE. Touchpad finger count is emulated using
> + * BTN_TOOL_FINGER, BTN_TOOL_DOUBLETAP, BTN_TOOL_TRIPLETAP and
> + * BTN_TOOL_QUADTAP.
> + *
> + * The input core ensures only the KEY and ABS axes already setup fo=
r
> + * this device will produce output.
> + */
> +void input_mt_report_pointer_emulation(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct input_mt_slot *oldest =3D 0;
> + =A0 =A0 =A0 int oldid =3D dev->trkid;
> + =A0 =A0 =A0 int count =3D 0;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < dev->mtsize; ++i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct input_mt_slot *ps =3D &dev->mt[i=
];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int id =3D input_mt_get_value(ps, ABS_M=
T_TRACKING_ID);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (id < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((id - oldid) & TRKID_SGN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldest =3D ps;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oldid =3D id;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
> + =A0 =A0 =A0 input_event(dev, EV_KEY, BTN_TOOL_FINGER, count =3D=3D =
1);
> + =A0 =A0 =A0 input_event(dev, EV_KEY, BTN_TOOL_DOUBLETAP, count =3D=3D=
 2);
> + =A0 =A0 =A0 input_event(dev, EV_KEY, BTN_TOOL_TRIPLETAP, count =3D=3D=
 3);
> + =A0 =A0 =A0 input_event(dev, EV_KEY, BTN_TOOL_QUADTAP, count =3D=3D=
 4);
> +
> + =A0 =A0 =A0 if (oldest) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D input_mt_get_value(oldest, AB=
S_MT_POSITION_X);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D input_mt_get_value(oldest, AB=
S_MT_POSITION_Y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int p =3D input_mt_get_value(oldest, AB=
S_MT_PRESSURE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(dev, EV_ABS, ABS_X, x);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(dev, EV_ABS, ABS_Y, y);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(dev, EV_ABS, ABS_PRESSURE, =
p);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(dev, EV_ABS, ABS_PRESSURE, =
0);
> + =A0 =A0 =A0 }
> +}
> +EXPORT_SYMBOL(input_mt_report_pointer_emulation);
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 3f9e280..86d0be3 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -863,7 +863,6 @@ static int wacom_bpt_touch(struct wacom_wac *waco=
m)
> =A0 =A0 =A0 =A0struct wacom_features *features =3D &wacom->features;
> =A0 =A0 =A0 =A0struct input_dev *input =3D wacom->input;
> =A0 =A0 =A0 =A0unsigned char *data =3D wacom->data;
> - =A0 =A0 =A0 int sp =3D 0, sx =3D 0, sy =3D 0, count =3D 0;
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < 2; i++) {
> @@ -885,23 +884,13 @@ static int wacom_bpt_touch(struct wacom_wac *wa=
com)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input=
, ABS_MT_PRESSURE, p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input=
, ABS_MT_POSITION_X, x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input=
, ABS_MT_POSITION_Y, y);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->id[i] < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->=
id[i] =3D wacom->trk_id++ & MAX_TRACKING_ID;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!count++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sp =3D =
p, sx =3D x, sy =3D y;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_st=
ate(input, true);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[i] =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_st=
ate(input, false);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_TRACKING=
_ID, wacom->id[i]);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, count > 0);
> - =A0 =A0 =A0 input_report_key(input, BTN_TOOL_FINGER, count =3D=3D 1=
);
> - =A0 =A0 =A0 input_report_key(input, BTN_TOOL_DOUBLETAP, count =3D=3D=
 2);
> -
> - =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, sp);
> - =A0 =A0 =A0 input_report_abs(input, ABS_X, sx);
> - =A0 =A0 =A0 input_report_abs(input, ABS_Y, sy);
> + =A0 =A0 =A0 input_mt_report_pointer_emulation(input);
>
> =A0 =A0 =A0 =A0input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D=
 0);
> =A0 =A0 =A0 =A0input_report_key(input, BTN_FORWARD, (data[1] & 0x04) =
!=3D 0);
> @@ -1283,8 +1272,6 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput_dev, ABS_MT_PRESSURE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 0, features->pressure_max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 features->pressure_fuzz, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ABS_MT_TRACKING_ID, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0MAX_TRACKING_ID, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (features->device_type =3D=3D=
 BTN_TOOL_PEN) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_RUB=
BER, input_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_PEN=
, input_dev->keybit);
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/=
wacom_wac.h
> index 00ca015..b1310ec 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -42,9 +42,6 @@
> =A0#define WACOM_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
001
> =A0#define WACOM_QUIRK_BBTOUCH_LOWRES =A0 =A0 0x0002
>
> -/* largest reported tracking id */
> -#define MAX_TRACKING_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00xfff
> -
> =A0enum {
> =A0 =A0 =A0 =A0PENPARTNER =3D 0,
> =A0 =A0 =A0 =A0GRAPHIRE,
> @@ -100,7 +97,6 @@ struct wacom_wac {
> =A0 =A0 =A0 =A0int id[3];
> =A0 =A0 =A0 =A0__u32 serial[2];
> =A0 =A0 =A0 =A0int last_finger;
> - =A0 =A0 =A0 int trk_id;
> =A0 =A0 =A0 =A0struct wacom_features features;
> =A0 =A0 =A0 =A0struct wacom_shared *shared;
> =A0 =A0 =A0 =A0struct input_dev *input;
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index b706cd5..abf4c6e 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -48,8 +48,6 @@ MODULE_LICENSE("GPL");
> =A0#define W8001_PKTLEN_TPCCTL =A0 =A011 =A0 =A0 =A0/* control packet=
 */
> =A0#define W8001_PKTLEN_TOUCH2FG =A013
>
> -#define MAX_TRACKING_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xFF =A0 =A0/=
* arbitrarily chosen */
> -
> =A0struct w8001_coord {
> =A0 =A0 =A0 =A0u8 rdy;
> =A0 =A0 =A0 =A0u8 tsw;
> @@ -87,7 +85,6 @@ struct w8001 {
> =A0 =A0 =A0 =A0char phys[32];
> =A0 =A0 =A0 =A0int type;
> =A0 =A0 =A0 =A0unsigned int pktlen;
> - =A0 =A0 =A0 int trkid[2];
> =A0};
>
> =A0static void parse_data(u8 *data, struct w8001_coord *coord)
> @@ -116,7 +113,6 @@ static void parse_data(u8 *data, struct w8001_coo=
rd *coord)
>
> =A0static void parse_touch(struct w8001 *w8001)
> =A0{
> - =A0 =A0 =A0 static int trkid;
> =A0 =A0 =A0 =A0struct input_dev *dev =3D w8001->dev;
> =A0 =A0 =A0 =A0unsigned char *data =3D w8001->data;
> =A0 =A0 =A0 =A0int i;
> @@ -132,12 +128,10 @@ static void parse_touch(struct w8001 *w8001)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev, =
ABS_MT_POSITION_X, x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev, =
ABS_MT_POSITION_Y, y);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(dev, =
ABS_MT_TOOL_TYPE, MT_TOOL_FINGER);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (w8001->trkid[i] < 0=
)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->=
trkid[i] =3D trkid++ & MAX_TRACKING_ID;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_st=
ate(dev, true);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 w8001->trkid[i] =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_st=
ate(dev, false);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(dev, ABS_MT_TRACKING_I=
D, w8001->trkid[i]);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0input_sync(dev);
> @@ -319,8 +313,6 @@ static int w8001_setup(struct w8001 *w8001)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w8001->pktlen =3D W800=
1_PKTLEN_TOUCH2FG;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_init_slots(de=
v, 2);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(de=
v, ABS_MT_TRACKING_ID,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 0, MAX_TRACKING_ID, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(d=
ev, ABS_MT_POSITION_X,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A00, touch.x, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(d=
ev, ABS_MT_POSITION_Y,
> @@ -372,7 +364,6 @@ static int w8001_connect(struct serio *serio, str=
uct serio_driver *drv)
> =A0 =A0 =A0 =A0w8001->serio =3D serio;
> =A0 =A0 =A0 =A0w8001->id =3D serio->id.id;
> =A0 =A0 =A0 =A0w8001->dev =3D input_dev;
> - =A0 =A0 =A0 w8001->trkid[0] =3D w8001->trkid[1] =3D -1;
> =A0 =A0 =A0 =A0init_completion(&w8001->cmd_done);
> =A0 =A0 =A0 =A0snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0"=
, serio->phys);
>
> diff --git a/include/linux/input-mt.h b/include/linux/input-mt.h
> index d7f6518..1a44567 100644
> --- a/include/linux/input-mt.h
> +++ b/include/linux/input-mt.h
> @@ -13,6 +13,8 @@
>
> =A0#include <linux/input.h>
>
> +#define TRKID_MAX =A0 =A0 =A00xffff
> +
> =A0/**
> =A0* struct input_mt_slot - represents the state of an input MT slot
> =A0* @abs: holds current values of ABS_MT axes for this slot
> @@ -36,9 +38,18 @@ static inline int input_mt_get_value(const struct =
input_mt_slot *slot,
> =A0int input_mt_init_slots(struct input_dev *dev, unsigned int num_sl=
ots);
> =A0void input_mt_destroy_slots(struct input_dev *dev);
>
> +static inline int input_mt_new_trkid(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 return dev->trkid++ & TRKID_MAX;
> +}
> +
> =A0static inline void input_mt_slot(struct input_dev *dev, int slot)
> =A0{
> =A0 =A0 =A0 =A0input_event(dev, EV_ABS, ABS_MT_SLOT, slot);
> =A0}
>
> +void input_mt_report_slot_state(struct input_dev *dev, bool active);
> +
> +void input_mt_report_pointer_emulation(struct input_dev *dev);
> +
> =A0#endif
> diff --git a/include/linux/input.h b/include/linux/input.h
> index dd7c0fc..3b856d6 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -1206,6 +1206,7 @@ struct input_dev {
> =A0 =A0 =A0 =A0struct input_mt_slot *mt;
> =A0 =A0 =A0 =A0int mtsize;
> =A0 =A0 =A0 =A0int slot;
> + =A0 =A0 =A0 int trkid;
>
> =A0 =A0 =A0 =A0struct input_absinfo *absinfo;
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
