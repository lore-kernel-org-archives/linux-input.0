From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [PATCH v4] Input: Add EVIOC mechanism for MT slots
Date: Mon, 6 Feb 2012 16:31:36 +0800
Message-ID: <CAGS+omD9aVcLKZnTi=8FfpUxeERHxxrWr4NM2GX+1LL1716awQ@mail.gmail.com>
References: <1328515542-3779-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33883 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab2BFIb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2012 03:31:56 -0500
Received: by iacb35 with SMTP id b35so8191103iac.19
        for <linux-input@vger.kernel.org>; Mon, 06 Feb 2012 00:31:56 -0800 (PST)
In-Reply-To: <1328515542-3779-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, chasedouglas@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 6, 2012 at 4:05 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> This patch adds the ability to extract MT slot data via a new ioctl,
> EVIOCGMTSLOTS. The function returns an array of slot values for the
> specified ABS_MT event type.

Henrik,

Instead of returning the values of just one event type, can you please
return values for all defined MT event types for all slots?  Userspace
can already know how big such an array would be required, since it can
probe to determine how many ABS_MT types have been defined.

It seems like the most common use case for this API is to fetch the
complete "initial state" when a userspace program first attaches to a
(stateful) evdev device.  Fetching all at once would be slightly more
efficient, and would resolve (or at worst minimize) race conditions
that could occur if input events are arriving while userspace is still
slowly ioctl'ing out the event type initial states, one at a time.

If there are strong use cases for 'just probe one event type', perhaps
you can keep the proposed API, but allow a special event type value,
like "ABS_MT_*", to fetch all?

BTW, I am very happy that you are finally plugging this particular
issue since it has been bugging me for many months.  We sometimes use
a userspace tools to record evdev events for a touch device while a
user is performing a multitouch gesture.  If the userspace tool starts
while there are already contacts on the device, there is currently no
unambiguous way to determine what that initial state should have been.
 Thus, some information is always lost.  This patch would allow us to
address this in the tools.  I've just been to busy/lazy to propose a
fix of my own :).

-Daniel

>
> Example of user space usage:
>
> struct { unsigned code; int values[64]; } req;
> req.code =3D ABS_MT_POSITION_X;
> if (ioctl(fd, EVIOCGMTSLOTS(sizeof(req)), &req) < 0)
> =A0 =A0 =A0 =A0return -1;
> for (i =3D 0; i < 64; i++)
> =A0 =A0 =A0 =A0printf("slot %d: %d\n", i, req.values[i]);
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Here is the fourth version of the patch.
>
> Rather than over-specifying the ioctl binary format by introducing a
> struct object that does not fit everyone, this version simply leaves
> all object definitions to userland.
>
> Thanks,
> Henrik
>
> =A0drivers/input/evdev.c | =A0 27 ++++++++++++++++++++++++++-
> =A0include/linux/input.h | =A0 25 +++++++++++++++++++++++++
> =A02 files changed, 51 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 76457d5..e4cad16 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -20,7 +20,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/module.h>
> =A0#include <linux/init.h>
> -#include <linux/input.h>
> +#include <linux/input/mt.h>
> =A0#include <linux/major.h>
> =A0#include <linux/device.h>
> =A0#include "input-compat.h"
> @@ -623,6 +623,28 @@ static int evdev_handle_set_keycode_v2(struct in=
put_dev *dev, void __user *p)
> =A0 =A0 =A0 =A0return input_set_keycode(dev, &ke);
> =A0}
>
> +static int evdev_handle_mt_request(struct input_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned int size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
int __user *ip)
> +{
> + =A0 =A0 =A0 const struct input_mt_slot *mt =3D dev->mt;
> + =A0 =A0 =A0 unsigned int code;
> + =A0 =A0 =A0 int max_slots;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (get_user(code, &ip[0]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 if (!input_is_mt_value(code))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 max_slots =3D (size - sizeof(__u32)) / sizeof(__s32);
> + =A0 =A0 =A0 for (i =3D 0; i < dev->mtsize && i < max_slots; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (put_user(input_mt_get_value(&mt[i],=
 code), &ip[1 + i]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static long evdev_do_ioctl(struct file *file, unsigned int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __user *p, i=
nt compat_mode)
> =A0{
> @@ -708,6 +730,9 @@ static long evdev_do_ioctl(struct file *file, uns=
igned int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return bits_to_user(dev->propbit, INPU=
T_PROP_MAX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
size, p, compat_mode);
>
> + =A0 =A0 =A0 case EVIOCGMTSLOTS(0):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return evdev_handle_mt_request(dev, siz=
e, ip);
> +
> =A0 =A0 =A0 =A0case EVIOCGKEY(0):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return bits_to_user(dev->key, KEY_MAX,=
 size, p, compat_mode);
>
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 3862e32..af26443 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -114,6 +114,31 @@ struct input_keymap_entry {
> =A0#define EVIOCGUNIQ(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x08, len) =A0 =A0 =A0 =A0 /* get unique identifier */
> =A0#define EVIOCGPROP(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC_R=
EAD, 'E', 0x09, len) =A0 =A0 =A0 =A0 /* get device properties */
>
> +/**
> + * EVIOCGMTSLOTS(len) - get MT slot values
> + *
> + * The ioctl buffer argument should be binary equivalent to
> + *
> + * struct input_mt_request_layout {
> + * =A0 =A0 __u32 code;
> + * =A0 =A0 __s32 values[num_slots];
> + * };
> + *
> + * where num_slots is the (arbitrary) number of MT slots to extract.
> + *
> + * The ioctl size argument (len) is the size of the buffer, which
> + * should satisfy len =3D (num_slots + 1) * sizeof(__s32). =A0If len=
 is
> + * too small to fit all available slots, the first num_slots are
> + * returned.
> + *
> + * Before the call, code is set to the wanted ABS_MT event type. On
> + * return, values[] is filled with the slot values for the specified
> + * ABS_MT code.
> + *
> + * If the request code is not an ABS_MT value, -EINVAL is returned.
> + */
> +#define EVIOCGMTSLOTS(len) =A0 =A0 _IOC(_IOC_READ, 'E', 0x0a, len)
> +
> =A0#define EVIOCGKEY(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x18, =
len) =A0 =A0 =A0 =A0 /* get global key state */
> =A0#define EVIOCGLED(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x19, =
len) =A0 =A0 =A0 =A0 /* get all LEDs */
> =A0#define EVIOCGSND(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x1a, =
len) =A0 =A0 =A0 =A0 /* get all sounds status */
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Daniel Kurtz=A0|=A0Software Engineer=A0|=A0djkurtz@google.com=A0|=A0650=
=2E204.0722
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
