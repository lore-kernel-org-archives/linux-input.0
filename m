From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [PATCH] synaptics: add support for Relative mode
Date: Sun, 9 Oct 2011 13:04:45 +0800
Message-ID: <CAGS+omCNwR9Sm64zJqV_h-2dmTYHxGkbofGaMMx2WgafYhrqhw@mail.gmail.com>
References: <20111008182047.40BD19D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:28599 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab1JIFFM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Oct 2011 01:05:12 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p99557YP023974
	for <linux-input@vger.kernel.org>; Sat, 8 Oct 2011 22:05:07 -0700
Received: from iaen33 (iaen33.prod.google.com [10.12.165.33])
	by wpaz13.hot.corp.google.com with ESMTP id p9953mg3007356
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sat, 8 Oct 2011 22:05:06 -0700
Received: by iaen33 with SMTP id n33so7884559iae.2
        for <linux-input@vger.kernel.org>; Sat, 08 Oct 2011 22:05:06 -0700 (PDT)
In-Reply-To: <20111008182047.40BD19D401E@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, pgf@laptop.org

Hi Daniel,

On Sun, Oct 9, 2011 at 2:20 AM, Daniel Drake <dsd@laptop.org> wrote:
> Currently, the synaptics driver puts the device into Absolute mode.
> As explained in the synaptics documentation section 3.2, in this mode=
,
> the device sends a continuous stream of packets at the maximum rate
> to the host when the user's fingers are near or on the pad or
> pressing buttons, and continues streaming for 1 second afterwards.
> These packets are even sent when there is no new information to repor=
t,
> even when they are duplicates of the previous packet.
>
> For embedded systems this is a bit much - it results in a huge
> and uninterrupted stream of interrupts at high rate.
>

This patch seems reasonable, but I don't think your explanation is
quite right.  It is quite common for a user to move their finger
around on a trackpad for several seconds continuously.  This generates
exactly the same "huge and uninterrupted stream of interrupts at a
high rate" as fingers near the pad, idle on the pad, or after the pad
is lifted.  In other words, the peak *packet rate* is the same in
absolute or relative mode.

What changes is the *packet size*.  Relative Mode uses a single 3-byte
PS/2 packet, while Absolute Mode uses 2 3-byte PS/2 packets, resulting
in double the number of bytes.  The packets themselves are by default
sent at 80 Hz (12.5ms/packet).   Therefore, since the serio raw
interrupts are per byte, Relative Mode has ~240 serio irq/s, whereas
Absolute Mode has 480 irq/s.

However, according to the "Synaptics TouchPad Interfacing Guide"
(http://www.synaptics.com/sites/default/files/511-000275-01rA.pdf),
you can achieve the same halving of the peak irq rate by changing the
report rate from 80 to 40 Hz with the "Rate" bit of the "Mode Byte":

4.3 Mode Byte
=2E..
Rate  (bit 6)
The TouchPad typically generates 40 or 80 packets per second:
=95 80 packets per second, also known as full speed, is the default. Th=
e
higher packet rate
is preferable because it leads to the smoothest cursor motion.
=95 40 packets per second, also known as half speed, is used for slower
hosts that cannot
keep up with 80 packets per second. Also, the low packet rate mode
does more internal
data filtering and so may perform better in environments of extreme
electrical noise.
 This bit is 0 to select half speed, or 1 to select full speed. The
default setting for this bit in
most TouchPad devices is 1. This bit is valid in both Relative and
Absolute mode, although
it may not be supported in all Synaptics products.


Thus, you can keep the trackpad in Absolute mode, but reduce the
report rate to 40Hz, resulting in the same 240 irq/s.  This lets you
handle tap-to-click and other gesture recognition up in userspace, for
example, in xf86-input-synaptics X input driver, which is where many
people argue that they belong.

Have you ever experimented with this approach?

There are a couple of possible downsides:
 (1) 40Hz is less than the typical 60Hz screen refresh rate, thus the
cursor will not move as smoothly on the screen.  This can actually be
handled, however, with some pointer motion interpolation in user
space.
 (2) At some point in time, xf86-input-synaptics had inter-packet
timing hardcoded as "13ms", I don't remember the current status, but
this clearly wouldn't be true anymore.

-Daniel


> This patch adds support for Relative mode, which can be selected thro=
ugh
> a sysfs attribute. In this mode, the device does not send duplicate
> packets and acts like a standard PS/2 mouse. However, synaptics-speci=
fic
> functionality is still available, such as the ability to set the pack=
et
> rate, and rather than disabling gestures and taps at the hardware lev=
el
> unconditionally, a 'synaptics_disable_gesture' sysfs attribute has
> been added to allow control of this functionality.
>
> This solves a long standing OLPC issue: synaptics hardware enables
> tap to click by default (even in the default relative mode), but we
> have found this to be inappropriate for young children and first
> time computer users. Enabling the synaptics driver disables tap-to-cl=
ick,
> but we have previously been unable to use this because it also enable=
s
> Absolute mode, which is too "spammy" for our desires and actually
> overloads our EC with its continuous stream of packets. Now we can en=
able
> the synaptics driver, disabling tap to click while retaining the less
> noisy Relative mode.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
> =A0drivers/input/mouse/psmouse-base.c | =A0 =A02 +-
> =A0drivers/input/mouse/psmouse.h =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/input/mouse/synaptics.c =A0 =A0| =A0239 ++++++++++++++++++=
+++++++++++-------
> =A0drivers/input/mouse/synaptics.h =A0 =A0| =A0 =A04 +
> =A04 files changed, 200 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse=
/psmouse-base.c
> index 2246843..651dd4b 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -124,7 +124,7 @@ struct psmouse_protocol {
> =A0* relevant events to the input module once full packet has arrived=
=2E
> =A0*/
>
> -static psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
> +psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *dev =3D psmouse->dev;
> =A0 =A0 =A0 =A0unsigned char *packet =3D psmouse->packet;
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmo=
use.h
> index 593e910..7ceb3ea 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -102,6 +102,7 @@ int psmouse_sliced_command(struct psmouse *psmous=
e, unsigned char command);
> =A0int psmouse_reset(struct psmouse *psmouse);
> =A0void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state=
 new_state);
> =A0void psmouse_set_resolution(struct psmouse *psmouse, unsigned int =
resolution);
> +psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse);
>
> =A0struct psmouse_attribute {
> =A0 =A0 =A0 =A0struct device_attribute dattr;
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/sy=
naptics.c
> index 5538fc6..8b8bb8c 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -32,6 +32,8 @@
> =A0#include "psmouse.h"
> =A0#include "synaptics.h"
>
> +static int synaptics_reconnect(struct psmouse *psmouse);
> +
> =A0/*
> =A0* The x/y limits are taken from the Synaptics TouchPad interfacing=
 Guide,
> =A0* section 2.3.2, which says that they should be valid regardless o=
f the
> @@ -258,19 +260,48 @@ static int synaptics_query_hardware(struct psmo=
use *psmouse)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int synaptics_set_absolute_mode(struct psmouse *psmouse)
> +static int synaptics_set_advanced_gesture_mode(struct psmouse *psmou=
se)
> +{
> + =A0 =A0 =A0 static unsigned char param =3D 0xc8;
> + =A0 =A0 =A0 struct synaptics_data *priv =3D psmouse->private;
> +
> + =A0 =A0 =A0 if (!SYN_CAP_ADV_GESTURE(priv->ext_cap_0c))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (psmouse_sliced_command(psmouse, SYN_QUE_MODEL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 if (ps2_command(&psmouse->ps2dev, &param, PSMOUSE_CMD_S=
ETRATE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 /* Advanced gesture mode also sends multi finger data *=
/
> + =A0 =A0 =A0 priv->capabilities |=3D BIT(1);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int synaptics_set_mode(struct psmouse *psmouse)
> =A0{
> =A0 =A0 =A0 =A0struct synaptics_data *priv =3D psmouse->private;
>
> - =A0 =A0 =A0 priv->mode =3D SYN_BIT_ABSOLUTE_MODE;
> - =A0 =A0 =A0 if (SYN_ID_MAJOR(priv->identity) >=3D 4)
> + =A0 =A0 =A0 priv->mode =3D 0;
> + =A0 =A0 =A0 if (priv->absolute_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mode |=3D SYN_BIT_ABSOLUTE_MODE;
> + =A0 =A0 =A0 if (priv->disable_gesture)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->mode |=3D SYN_BIT_DISABLE_GESTUR=
E;
> + =A0 =A0 =A0 if (psmouse->rate >=3D 80)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mode |=3D SYN_BIT_HIGH_RATE;
> =A0 =A0 =A0 =A0if (SYN_CAP_EXTENDED(priv->capabilities))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->mode |=3D SYN_BIT_W_MODE;
>
> =A0 =A0 =A0 =A0if (synaptics_mode_cmd(psmouse, priv->mode))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> + =A0 =A0 =A0 if (priv->absolute_mode &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_set_advanced_=
gesture_mode(psmouse)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Advanced gesture mode =
init failed.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -289,25 +320,6 @@ static void synaptics_set_rate(struct psmouse *p=
smouse, unsigned int rate)
> =A0 =A0 =A0 =A0synaptics_mode_cmd(psmouse, priv->mode);
> =A0}
>
> -static int synaptics_set_advanced_gesture_mode(struct psmouse *psmou=
se)
> -{
> - =A0 =A0 =A0 static unsigned char param =3D 0xc8;
> - =A0 =A0 =A0 struct synaptics_data *priv =3D psmouse->private;
> -
> - =A0 =A0 =A0 if (!SYN_CAP_ADV_GESTURE(priv->ext_cap_0c))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (psmouse_sliced_command(psmouse, SYN_QUE_MODEL))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> - =A0 =A0 =A0 if (ps2_command(&psmouse->ps2dev, &param, PSMOUSE_CMD_S=
ETRATE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> -
> - =A0 =A0 =A0 /* Advanced gesture mode also sends multi finger data *=
/
> - =A0 =A0 =A0 priv->capabilities |=3D BIT(1);
> -
> - =A0 =A0 =A0 return 0;
> -}
> -
> =A0/*****************************************************************=
************
> =A0* =A0 =A0 Synaptics pass-through PS/2 port support
> =A0******************************************************************=
**********/
> @@ -694,13 +706,45 @@ static psmouse_ret_t synaptics_process_byte(str=
uct psmouse *psmouse)
> =A0/*****************************************************************=
************
> =A0* =A0 =A0 Driver initialization/cleanup functions
> =A0******************************************************************=
**********/
> -static void set_input_params(struct input_dev *dev, struct synaptics=
_data *priv)
> +static void set_input_params(struct psmouse *psmouse, struct input_d=
ev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct input=
_dev *old_dev)
> =A0{
> + =A0 =A0 =A0 struct synaptics_data *priv =3D psmouse->private;
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0int fuzz =3D SYN_CAP_REDUCED_FILTERING(priv->ext_cap_0=
c) ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYN_REDUCED_FILTER_FUZ=
Z : 0;
>
> + =A0 =A0 =A0 if (old_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->name =3D old_dev->name;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->phys =3D old_dev->phys;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->id =3D old_dev->id;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dev.parent =3D old_dev->dev.parent=
;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Things that apply to both modes */
> =A0 =A0 =A0 =A0__set_bit(INPUT_PROP_POINTER, dev->propbit);
> + =A0 =A0 =A0 __set_bit(EV_KEY, dev->evbit);
> + =A0 =A0 =A0 __set_bit(BTN_LEFT, dev->keybit);
> + =A0 =A0 =A0 __set_bit(BTN_RIGHT, dev->keybit);
> +
> + =A0 =A0 =A0 if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_MIDDLE, dev->keybit);
> +
> + =A0 =A0 =A0 if (!priv->absolute_mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Relative mode */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(EV_REL, dev->evbit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(REL_X, dev->relbit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(REL_Y, dev->relbit);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Relative mode follows standard PS/2 =
mouse protocol */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->protocol_handler =3D psmouse_p=
rocess_byte;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->pktsize =3D 3;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Absolute mode */
> + =A0 =A0 =A0 psmouse->protocol_handler =3D synaptics_process_byte;
> + =A0 =A0 =A0 psmouse->pktsize =3D 6;
>
> =A0 =A0 =A0 =A0__set_bit(EV_ABS, dev->evbit);
> =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_X,
> @@ -732,20 +776,14 @@ static void set_input_params(struct input_dev *=
dev, struct synaptics_data *priv)
> =A0 =A0 =A0 =A0if (SYN_CAP_PALMDETECT(priv->capabilities))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(dev, ABS_TOOL_WID=
TH, 0, 15, 0, 0);
>
> - =A0 =A0 =A0 __set_bit(EV_KEY, dev->evbit);
> =A0 =A0 =A0 =A0__set_bit(BTN_TOUCH, dev->keybit);
> =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_FINGER, dev->keybit);
> - =A0 =A0 =A0 __set_bit(BTN_LEFT, dev->keybit);
> - =A0 =A0 =A0 __set_bit(BTN_RIGHT, dev->keybit);
>
> =A0 =A0 =A0 =A0if (SYN_CAP_MULTIFINGER(priv->capabilities)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_DOUBLETAP, dev->key=
bit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_TRIPLETAP, dev->key=
bit);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_MIDDLE, dev->keybit);
> -
> =A0 =A0 =A0 =A0if (SYN_CAP_FOUR_BUTTON(priv->capabilities) ||
> =A0 =A0 =A0 =A0 =A0 =A0SYN_CAP_MIDDLE_BUTTON(priv->capabilities)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_FORWARD, dev->keybit);
> @@ -770,8 +808,117 @@ static void set_input_params(struct input_dev *=
dev, struct synaptics_data *priv)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static ssize_t attr_show_absolute(struct psmouse *psmouse, void *dat=
a,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cha=
r *buf)
> +{
> + =A0 =A0 =A0 struct synaptics_data *priv =3D psmouse->private;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%c\n", priv->absolute_mode ? '1' :=
 '0');
> +}
> +
> +static ssize_t attr_set_absolute(struct psmouse *psmouse, void *data=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cons=
t char *buf, size_t len)
> +{
> + =A0 =A0 =A0 struct synaptics_data *priv =3D psmouse->private;
> + =A0 =A0 =A0 struct input_dev *old_dev =3D psmouse->dev;
> + =A0 =A0 =A0 struct input_dev *new_dev;
> + =A0 =A0 =A0 unsigned long value;
> + =A0 =A0 =A0 int err =3D -1;
> +
> + =A0 =A0 =A0 if (strict_strtoul(buf, 10, &value))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (value =3D=3D priv->absolute_mode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return len;
> +
> + =A0 =A0 =A0 new_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (!new_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
> +
> + =A0 =A0 =A0 priv->absolute_mode =3D !!value;
> + =A0 =A0 =A0 if (synaptics_set_mode(psmouse)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to initialize S=
ynaptics hardware.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_try_restore;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 set_input_params(psmouse, new_dev, psmouse->dev);
> +
> + =A0 =A0 =A0 psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> +
> + =A0 =A0 =A0 err =3D input_register_device(new_dev);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_try_restore;
> +
> + =A0 =A0 =A0 psmouse->dev =3D new_dev;
> + =A0 =A0 =A0 input_unregister_device(old_dev);
> +
> + =A0 =A0 =A0 return len;
> +
> +err_try_restore:
> + =A0 =A0 =A0 input_free_device(new_dev);
> + =A0 =A0 =A0 priv->absolute_mode =3D !value;
> + =A0 =A0 =A0 synaptics_reconnect(psmouse);
> + =A0 =A0 =A0 return err;
> +}
> +
> +PSMOUSE_DEFINE_ATTR(synaptics_absolute_mode, S_IWUSR | S_IRUGO, NULL=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attr_show_absolute, attr_set_ab=
solute);
> +
> +static ssize_t attr_show_disable_gesture(struct psmouse *psmouse, vo=
id *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0char *buf)
> +{
> + =A0 =A0 =A0 struct synaptics_data *priv =3D psmouse->private;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%c\n", priv->disable_gesture ? '1'=
 : '0');
> +}
> +
> +static ssize_t attr_set_disable_gesture(struct psmouse *psmouse, voi=
d *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 const char *buf, size_t len)
> +{
> + =A0 =A0 =A0 struct synaptics_data *priv =3D psmouse->private;
> + =A0 =A0 =A0 unsigned long value;
> +
> + =A0 =A0 =A0 if (strict_strtoul(buf, 10, &value))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (!SYN_ID_DISGEST_SUPPORTED(priv->identity))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
> +
> + =A0 =A0 =A0 if (value =3D=3D priv->disable_gesture)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return len;
> +
> + =A0 =A0 =A0 priv->disable_gesture =3D !!value;
> + =A0 =A0 =A0 if (value)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mode |=3D SYN_BIT_DISABLE_GESTURE=
;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mode &=3D ~SYN_BIT_DISABLE_GESTUR=
E;
> +
> + =A0 =A0 =A0 if (synaptics_mode_cmd(psmouse, priv->mode))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> +
> + =A0 =A0 =A0 return len;
> +}
> +
> +PSMOUSE_DEFINE_ATTR(synaptics_disable_gesture, S_IWUSR | S_IRUGO, NU=
LL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 attr_show_disable_gesture, attr=
_set_disable_gesture);
> +
> +static struct attribute *syn_attributes[] =3D {
> + =A0 =A0 =A0 &psmouse_attr_synaptics_absolute_mode.dattr.attr,
> + =A0 =A0 =A0 &psmouse_attr_synaptics_disable_gesture.dattr.attr,
> + =A0 =A0 =A0 NULL
> +};
> +
> +static struct attribute_group syn_attribute_group =3D {
> + =A0 =A0 =A0 .attrs =3D syn_attributes,
> +};
> +
> =A0static void synaptics_disconnect(struct psmouse *psmouse)
> =A0{
> + =A0 =A0 =A0 sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&syn_attribute_g=
roup);
> +
> =A0 =A0 =A0 =A0synaptics_reset(psmouse);
> =A0 =A0 =A0 =A0kfree(psmouse->private);
> =A0 =A0 =A0 =A0psmouse->private =3D NULL;
> @@ -801,16 +948,11 @@ static int synaptics_reconnect(struct psmouse *=
psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (synaptics_set_absolute_mode(psmouse)) {
> + =A0 =A0 =A0 if (synaptics_set_mode(psmouse)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Unable to initialize =
Synaptics hardware.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (synaptics_set_advanced_gesture_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Advanced gesture mode =
reconnect failed.\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0if (old_priv.identity !=3D priv->identity ||
> =A0 =A0 =A0 =A0 =A0 =A0old_priv.model_id !=3D priv->model_id ||
> =A0 =A0 =A0 =A0 =A0 =A0old_priv.capabilities !=3D priv->capabilities =
||
> @@ -890,6 +1032,7 @@ void __init synaptics_module_init(void)
> =A0int synaptics_init(struct psmouse *psmouse)
> =A0{
> =A0 =A0 =A0 =A0struct synaptics_data *priv;
> + =A0 =A0 =A0 int err =3D -1;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The OLPC XO has issues with Synaptics' absolute mod=
e; similarly to
> @@ -916,13 +1059,13 @@ int synaptics_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (synaptics_set_absolute_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to initialize S=
ynaptics hardware.\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_fail;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* defaults */
> + =A0 =A0 =A0 priv->absolute_mode =3D 1;
> + =A0 =A0 =A0 if (SYN_ID_DISGEST_SUPPORTED(priv->identity))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->disable_gesture =3D 1;
>
> - =A0 =A0 =A0 if (synaptics_set_advanced_gesture_mode(psmouse)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Advanced gesture mode =
init failed.\n");
> + =A0 =A0 =A0 if (synaptics_set_mode(psmouse)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to initialize S=
ynaptics hardware.\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto init_fail;
> =A0 =A0 =A0 =A0}
>
> @@ -933,7 +1076,7 @@ int synaptics_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYN_ID_MAJOR(priv->identity), SYN_ID_M=
INOR(priv->identity),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priv->model_id, priv->capabilities, pr=
iv->ext_cap, priv->ext_cap_0c);
>
> - =A0 =A0 =A0 set_input_params(psmouse->dev, priv);
> + =A0 =A0 =A0 set_input_params(psmouse, psmouse->dev, NULL);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Encode touchpad model so that it can be used to set
> @@ -945,12 +1088,10 @@ int synaptics_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0psmouse->model =3D ((priv->model_id & 0x00ff0000) >> 8=
) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(priv->model_id & =
0x000000ff);
>
> - =A0 =A0 =A0 psmouse->protocol_handler =3D synaptics_process_byte;
> =A0 =A0 =A0 =A0psmouse->set_rate =3D synaptics_set_rate;
> =A0 =A0 =A0 =A0psmouse->disconnect =3D synaptics_disconnect;
> =A0 =A0 =A0 =A0psmouse->reconnect =3D synaptics_reconnect;
> =A0 =A0 =A0 =A0psmouse->cleanup =3D synaptics_reset;
> - =A0 =A0 =A0 psmouse->pktsize =3D 6;
> =A0 =A0 =A0 =A0/* Synaptics can usually stay in sync without extra he=
lp */
> =A0 =A0 =A0 =A0psmouse->resync_time =3D 0;
>
> @@ -968,11 +1109,19 @@ int synaptics_init(struct psmouse *psmouse)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0psmouse->rate =3D 40;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 err =3D sysfs_create_group(&psmouse->ps2dev.serio->dev.=
kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
&syn_attribute_group);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&psmouse->ps2dev.serio->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed to create sysfs=
 attributes (%d)", err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto init_fail;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
>
> =A0init_fail:
> =A0 =A0 =A0 =A0kfree(priv);
> - =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 return err;
> =A0}
>
> =A0bool synaptics_supported(void)
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/sy=
naptics.h
> index ca040aa..c6e01fa 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -97,6 +97,7 @@
> =A0#define SYN_ID_MINOR(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(((i) >> 16) & 0xff)
> =A0#define SYN_ID_FULL(i) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((SYN_ID_MA=
JOR(i) << 8) | SYN_ID_MINOR(i))
> =A0#define SYN_ID_IS_SYNAPTICS(i) =A0 =A0 =A0 =A0 ((((i) >> 8) & 0xff=
) =3D=3D 0x47)
> +#define SYN_ID_DISGEST_SUPPORTED(i) =A0 =A0(SYN_ID_MAJOR(i) >=3D 4)
>
> =A0/* synaptics special commands */
> =A0#define SYN_PS_SET_MODE2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x14
> @@ -144,6 +145,9 @@ struct synaptics_data {
> =A0 =A0 =A0 =A0unsigned char mode; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* current mode byte */
> =A0 =A0 =A0 =A0int scroll;
>
> + =A0 =A0 =A0 unsigned int absolute_mode:1; =A0 =A0 =A0 =A0 =A0 /* ru=
n in Absolute mode */
> + =A0 =A0 =A0 unsigned int disable_gesture:1; =A0 =A0 =A0 =A0 /* disa=
ble gestures */
> +
> =A0 =A0 =A0 =A0struct serio *pt_port; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* Pass-through serio port */
>
> =A0 =A0 =A0 =A0struct synaptics_hw_state mt; =A0 =A0 =A0 =A0 =A0 /* c=
urrent gesture packet */
> --
> 1.7.6.4
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
