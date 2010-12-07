From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Tue, 7 Dec 2010 13:18:41 -0600
Message-ID: <AANLkTi=JcekxsbUXXUmxkUug_+hwiYkDxbCEKEe-DWDg@mail.gmail.com>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291706726-8835-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 7, 2010 at 1:25 AM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Today, userspace sets up an input device based on the data it emits.
> This is not always enough; a tablet and a touchscreen may emit exactl=
y
> the same data, for instance, but the former should be set up with a
> pointer whereas the latter does not need to. Recently, a new type of
> touchpad has emerged where the buttons are under the pad, which chang=
es
> handling logic without changing the emitted data. This patch introduc=
es
> a new ioctl, EVIOCGDEVINFO, which allows userspace to extract informa=
tion
> about the device resulting in proper setup.
>
> Suggested-by: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> Cc: Ping Cheng <pingc@wacom.com>
> Cc: Chris Bagwell <chris@cnpbagwell.com>
> ---
> Hi all,
>
> Here is a patch attempting to formulate Dmitry's device type idea. It
> compiles, but further testing awaits a general consesus on the device
> types and capabilities to start out with. Are the ones listed here ap=
t
> for the job?
>
> Cheers,
> Henrik
>
> =A0drivers/input/evdev.c | =A0 =A06 ++++++
> =A0include/linux/input.h | =A0 34 ++++++++++++++++++++++++++++++++++
> =A02 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e3f7fc6..db78592 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -632,6 +632,12 @@ static long evdev_do_ioctl(struct file *file, un=
signed int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EFAULT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> + =A0 =A0 =A0 case EVIOCGDEVINFO:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_to_user(p, &dev->devinfo,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size=
of(struct input_devinfo)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0case EVIOCGREP:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!test_bit(EV_REP, dev->evbit))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOSYS;
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 6ef4446..8c58d2a 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -57,6 +57,21 @@ struct input_absinfo {
> =A0};
>
> =A0/**
> + * struct input_devinfo - device information via EVIOCGDEVINFO ioctl
> + * @types: bitmask of types (DEVTYPE_*) matching this device
> + * @capabilities: bitmask of capabilities (DEVCAPS_*) of this device
> + *
> + * This struct provides information about the device needed for
> + * automatic setup in userspace, such as if the device is direct
> + * (touchscreen) or indirect (touchpad), and if there are other
> + * special considerations, such as the touchpad also being a button.
> + */
> +struct input_devinfo {
> + =A0 =A0 =A0 __u32 types;
> + =A0 =A0 =A0 __u32 capabilities;
> +};
> +

"types" sounds like it can support being more then one thing at a time
but I don't think that is intent from below names.  Should rename to
"type"?

As example, I think combo devices that support fingers and pens will
be either TOUCHSCREEN or TABLET and declare combo part with
BTN_TOOL_PEN+BTN_TOOL_FINGER.

> +/**
> =A0* struct input_keymap_entry - used by EVIOCGKEYCODE/EVIOCSKEYCODE =
ioctls
> =A0* @scancode: scancode represented in machine-endian form.
> =A0* @len: length of the scancode that resides in @scancode buffer.
> @@ -91,6 +106,7 @@ struct input_keymap_entry {
> =A0#define EVIOCGNAME(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x06, len) =A0 =A0 =A0 =A0 /* get device name */
> =A0#define EVIOCGPHYS(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x07, len) =A0 =A0 =A0 =A0 /* get physical location */
> =A0#define EVIOCGUNIQ(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x08, len) =A0 =A0 =A0 =A0 /* get unique identifier */
> +#define EVIOCGDEVINFO =A0 =A0 =A0 =A0 =A0_IOR('E', 0x09, struct inpu=
t_devinfo) =A0 /* get device information */
>
> =A0#define EVIOCGKEY(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x18, =
len) =A0 =A0 =A0 =A0 /* get global key state */
> =A0#define EVIOCGLED(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x19, =
len) =A0 =A0 =A0 =A0 /* get all LEDs */
> @@ -108,6 +124,23 @@ struct input_keymap_entry {
> =A0#define EVIOCGRAB =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOW('E', 0x90, int) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Grab/Release device */
>
> =A0/*
> + * Device types
> + */
> +
> +#define DEVTYPE_KEYBOARD =A0 =A0 =A0 0
> +#define DEVTYPE_MOUSE =A0 =A0 =A0 =A0 =A01
> +#define DEVTYPE_JOYSTICK =A0 =A0 =A0 2
> +#define DEVTYPE_TOUCHPAD =A0 =A0 =A0 3
> +#define DEVTYPE_TABLET =A0 =A0 =A0 =A0 4
> +#define DEVTYPE_TOUCHSCREEN =A0 =A05
> +
> +/*
> + * Device capabilities
> + */
> +
> +#define DEVCAPS_PAD_IS_BUTTON =A01
> +

DEVCAPS_BUTTONPAD or DEVCAPS_CLICKPAD may be good choice if you want
to save some characters.

Once user knows this capability, they will want to know area of pad
that is reserved for buttons.  Today it seems universally fixed to
lower 20% of pad so doesn't need to be queried... but someday it may
need a query.  I don't guess there is a generic way to query more
details about specific capabilities.

Thanks for prototype... Looking forward to using it once finalized.

Chris

> +/*
> =A0* Event types
> =A0*/
>
> @@ -1177,6 +1210,7 @@ struct input_dev {
> =A0 =A0 =A0 =A0const char *phys;
> =A0 =A0 =A0 =A0const char *uniq;
> =A0 =A0 =A0 =A0struct input_id id;
> + =A0 =A0 =A0 struct input_devinfo devinfo;
>
> =A0 =A0 =A0 =A0unsigned long evbit[BITS_TO_LONGS(EV_CNT)];
> =A0 =A0 =A0 =A0unsigned long keybit[BITS_TO_LONGS(KEY_CNT)];
> --
> 1.7.1
>
>
