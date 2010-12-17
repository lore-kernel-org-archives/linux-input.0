From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: introduce device information ioctl
Date: Fri, 17 Dec 2010 11:24:44 -0800
Message-ID: <AANLkTimj3h_oVSj_QA5V=qB7WXXifbWcFtEgA6+6zPZc@mail.gmail.com>
References: <1292531413-28924-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41685 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab0LQTYp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 14:24:45 -0500
In-Reply-To: <1292531413-28924-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Chris Bagwell <chris@cnpbagwell.com>, Chase Douglas <chase.douglas@canonical.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 16, 2010 at 12:30 PM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> Today, userspace sets up an input device based on the data it emits.
> This is not always enough; a tablet and a touchscreen may emit exactl=
y
> the same data, for instance, but the former should be set up with a
> pointer whereas the latter does not need to. Recently, a new type of
> touchpad has emerged where the buttons are under the pad, which
> changes handling logic without changing the emitted data. This patch
> introduces a new ioctl, EVIOCGPROP, which enables user access to a se=
t
> of device properties useful during setup. The properties are given as
> a bitmap in the same fashion as the event types, and are also made
> available via sysfs.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Reviewed-by: Ping Cheng <pingc@wacom.com>

I wonder if we need to mention this new ioctl somewhere under
Documentation/input or not. INPUT_PROP_SEMI_MT could add useful
information for multi-touch-protocol.txt. The others could play a role
in Chase's new Documentation/input/evdev-codes.txt.

Ping

> ---
> =A0drivers/input/evdev.c =A0 =A0 =A0 | =A0 =A04 ++++
> =A0drivers/input/input.c =A0 =A0 =A0 | =A0 15 +++++++++++++++
> =A0drivers/input/misc/uinput.c | =A0 =A04 ++++
> =A0include/linux/input.h =A0 =A0 =A0 | =A0 16 ++++++++++++++++
> =A0include/linux/uinput.h =A0 =A0 =A0| =A0 =A01 +
> =A05 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e3f7fc6..0cd97e8 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -677,6 +677,10 @@ static long evdev_do_ioctl(struct file *file, un=
signed int cmd,
> =A0#define EVIOC_MASK_SIZE(nr) =A0 =A0((nr) & ~(_IOC_SIZEMASK << _IOC=
_SIZESHIFT))
> =A0 =A0 =A0 =A0switch (EVIOC_MASK_SIZE(cmd)) {
>
> + =A0 =A0 =A0 case EVIOCGPROP(0):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return bits_to_user(dev->propbit, INPUT=
_PROP_MAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 size, p, compat_mode);
> +
> =A0 =A0 =A0 =A0case EVIOCGKEY(0):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return bits_to_user(dev->key, KEY_MAX,=
 size, p, compat_mode);
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 37708d1..c3e5fc7 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1318,11 +1318,26 @@ static ssize_t input_dev_show_modalias(struct=
 device *dev,
> =A0}
> =A0static DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NUL=
L);
>
> +static int input_print_bitmap(char *buf, int buf_size, unsigned long=
 *bitmap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int max, in=
t add_cr);
> +
> +static ssize_t input_dev_show_properties(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0struct device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0char *buf)
> +{
> + =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
> + =A0 =A0 =A0 int len =3D input_print_bitmap(buf, PAGE_SIZE, input_de=
v->propbit,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0INPUT_PROP_MAX, true);
> + =A0 =A0 =A0 return min_t(int, len, PAGE_SIZE);
> +}
> +static DEVICE_ATTR(properties, S_IRUGO, input_dev_show_properties, N=
ULL);
> +
> =A0static struct attribute *input_dev_attrs[] =3D {
> =A0 =A0 =A0 =A0&dev_attr_name.attr,
> =A0 =A0 =A0 =A0&dev_attr_phys.attr,
> =A0 =A0 =A0 =A0&dev_attr_uniq.attr,
> =A0 =A0 =A0 =A0&dev_attr_modalias.attr,
> + =A0 =A0 =A0 &dev_attr_properties.attr,
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.=
c
> index bea8972..82542a1 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -680,6 +680,10 @@ static long uinput_ioctl_handler(struct file *fi=
le, unsigned int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D uinput_set_=
bit(arg, swbit, SW_MAX);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case UI_SET_PROPBIT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D uinput_set_b=
it(arg, propbit, INPUT_PROP_MAX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case UI_SET_PHYS:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (udev->state =3D=3D=
 UIST_CREATED) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval=
 =3D -EINVAL;
> diff --git a/include/linux/input.h b/include/linux/input.h
> index b3a1e02..8d9c76c 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -91,6 +91,7 @@ struct input_keymap_entry {
> =A0#define EVIOCGNAME(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x06, len) =A0 =A0 =A0 =A0 /* get device name */
> =A0#define EVIOCGPHYS(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x07, len) =A0 =A0 =A0 =A0 /* get physical location */
> =A0#define EVIOCGUNIQ(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x08, len) =A0 =A0 =A0 =A0 /* get unique identifier */
> +#define EVIOCGPROP(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_REA=
D, 'E', 0x09, len) =A0 =A0 =A0 =A0 /* get device properties */
>
> =A0#define EVIOCGKEY(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x18, =
len) =A0 =A0 =A0 =A0 /* get global key state */
> =A0#define EVIOCGLED(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x19, =
len) =A0 =A0 =A0 =A0 /* get all LEDs */
> @@ -108,6 +109,18 @@ struct input_keymap_entry {
> =A0#define EVIOCGRAB =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOW('E', 0x90, int) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Grab/Release device */
>
> =A0/*
> + * Device properties and quirks
> + */
> +
> +#define INPUT_PROP_POINTER =A0 =A0 =A0 =A0 =A0 =A0 0x00 =A0 =A0/* ne=
eds a pointer */
> +#define INPUT_PROP_DIRECT =A0 =A0 =A0 =A0 =A0 =A0 =A00x01 =A0 =A0/* =
direct input devices */
> +#define INPUT_PROP_BUTTONPAD =A0 =A0 =A0 =A0 =A0 0x02 =A0 =A0/* has =
button(s) under pad */
> +#define INPUT_PROP_SEMI_MT =A0 =A0 =A0 =A0 =A0 =A0 0x03 =A0 =A0/* to=
uch rectangle only */
> +
> +#define INPUT_PROP_MAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1f
> +#define INPUT_PROP_CNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (INPUT_PROP_M=
AX + 1)
> +
> +/*
> =A0* Event types
> =A0*/
>
> @@ -1090,6 +1103,7 @@ struct ff_effect {
> =A0* @phys: physical path to the device in the system hierarchy
> =A0* @uniq: unique identification code for the device (if device has =
it)
> =A0* @id: id of the device (struct input_id)
> + * @propbit: bitmap of device properties and quirks
> =A0* @evbit: bitmap of types of events supported by the device (EV_KE=
Y,
> =A0* =A0 =A0 EV_REL, etc.)
> =A0* @keybit: bitmap of keys/buttons this device has
> @@ -1173,6 +1187,8 @@ struct input_dev {
> =A0 =A0 =A0 =A0const char *uniq;
> =A0 =A0 =A0 =A0struct input_id id;
>
> + =A0 =A0 =A0 unsigned long propbit[BITS_TO_LONGS(INPUT_PROP_CNT)];
> +
> =A0 =A0 =A0 =A0unsigned long evbit[BITS_TO_LONGS(EV_CNT)];
> =A0 =A0 =A0 =A0unsigned long keybit[BITS_TO_LONGS(KEY_CNT)];
> =A0 =A0 =A0 =A0unsigned long relbit[BITS_TO_LONGS(REL_CNT)];
> diff --git a/include/linux/uinput.h b/include/linux/uinput.h
> index 05f7fed2..d28c726 100644
> --- a/include/linux/uinput.h
> +++ b/include/linux/uinput.h
> @@ -104,6 +104,7 @@ struct uinput_ff_erase {
> =A0#define UI_SET_FFBIT =A0 =A0 =A0 =A0 =A0 _IOW(UINPUT_IOCTL_BASE, 1=
07, int)
> =A0#define UI_SET_PHYS =A0 =A0 =A0 =A0 =A0 =A0_IOW(UINPUT_IOCTL_BASE,=
 108, char*)
> =A0#define UI_SET_SWBIT =A0 =A0 =A0 =A0 =A0 _IOW(UINPUT_IOCTL_BASE, 1=
09, int)
> +#define UI_SET_PROPBIT =A0 =A0 =A0 =A0 _IOW(UINPUT_IOCTL_BASE, 110, =
int)
>
> =A0#define UI_BEGIN_FF_UPLOAD =A0 =A0 _IOWR(UINPUT_IOCTL_BASE, 200, s=
truct uinput_ff_upload)
> =A0#define UI_END_FF_UPLOAD =A0 =A0 =A0 _IOW(UINPUT_IOCTL_BASE, 201, =
struct uinput_ff_upload)
> --
> 1.7.2.3
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
