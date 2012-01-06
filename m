From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] Input: evdev - Add EVIOC mechanism to extract the MT
 slot state
Date: Fri, 6 Jan 2012 19:00:22 +0100
Message-ID: <CAN+gG=FUEH851Um4Lco0avqdE2Eup3Jo79Ti4T7XhxT=PO6WeQ@mail.gmail.com>
References: <1325863019-2242-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42594 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758300Ab2AFSAX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2012 13:00:23 -0500
In-Reply-To: <1325863019-2242-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chase Douglas <chase.douglas@canonical.com>

Hi guys,
I read somewhere in the code of Android a comment in which they
complain about not being able to retrieve the slots states. So they
assume they are all at 0.
So this mechanism is good to have.
However, back in January 2011, Dmitry raised the problem that this
code was not thread safe.What happens if 2 applications ask for
different slots values (let say X.org and utouch-frame)?
One little comment in the patch:

On Fri, Jan 6, 2012 at 16:16, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
> This patch adds the ability to extract the MT slot state sequentially
> via EVIOCGABS. The slot parameter is first selected by calling
> EVIOCSABS with ABS_MT_SLOT as argument, followed by a set of EVIOCGAB=
S
> calls. The slot selection is local to the evdev client handler, and
> does not affect the actual input state.
>
> Cc: Chase Douglas <chase.douglas@canonical.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Dmitry,
>
> the first version of this patch was sent a long time ago (May 2010),
> but was put on hold due to a lack of usecases. Now, it seems such a
> case has arrived, in the X server (evdev). Some MT events may be much
> less frequent than others (ABS_MT_ORIENTATION, for example), resultin=
g
> in wrong touch values being assumed after, say, an X restart.
>
> I am not 100% in favor of this patch myself. Perhaps there should be =
a
> more explicit mechanism for selecting slots, for instance.
>
> The patch has been tested against both 3.2 and 3.1 stable.
>
> Cheers,
> Henrik
>
> =A0drivers/input/evdev.c | =A0 23 +++++++++++++++++++----
> =A01 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 4cf2534..4878e63 100644
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
> @@ -46,6 +46,7 @@ struct evdev_client {
> =A0 =A0 =A0 =A0struct fasync_struct *fasync;
> =A0 =A0 =A0 =A0struct evdev *evdev;
> =A0 =A0 =A0 =A0struct list_head node;
> + =A0 =A0 =A0 int mt_slot; =A0 =A0 =A0 =A0 =A0 =A0/* used to extract =
MT events via EVIOC */
> =A0 =A0 =A0 =A0unsigned int bufsize;
> =A0 =A0 =A0 =A0struct input_event buffer[];
> =A0};
> @@ -621,6 +622,16 @@ static int evdev_handle_set_keycode_v2(struct in=
put_dev *dev, void __user *p)
> =A0 =A0 =A0 =A0return input_set_keycode(dev, &ke);
> =A0}
>
> +static int evdev_get_abs_value(const struct evdev_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const st=
ruct input_dev *dev, unsigned int code)
> +{
> + =A0 =A0 =A0 if (code =3D=3D ABS_MT_SLOT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return client->mt_slot;

This is wrong.
Returning the current asked slot (by someone in the user-space) will
break the EVIOCGABS mechanism:
Asking for the current active slot (of the device) is allowed and
should be done by every application that starts to talk to evdev. As
the slot is state-full, it's not updated between touches and nothing
guarantees that it's to a null state, which often happens when X.org
or the app restarts.

Cheers,
Benjamin

> + =A0 =A0 =A0 if (dev->mt && input_is_mt_axis(code))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return input_mt_get_value(&dev->mt[clie=
nt->mt_slot], code);
> + =A0 =A0 =A0 return dev->absinfo[code].value;
> +}
> +
> =A0static long evdev_do_ioctl(struct file *file, unsigned int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __user *p, i=
nt compat_mode)
> =A0{
> @@ -757,6 +768,7 @@ static long evdev_do_ioctl(struct file *file, uns=
igned int cmd,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t =3D _IOC_NR(cmd) & A=
BS_MAX;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abs =3D dev->absinfo[t=
];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abs.value =3D evdev_get=
_abs_value(client, dev, t);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (copy_to_user(p, &a=
bs, min_t(size_t,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0size, sizeof(struct input_absinfo))))
> @@ -782,9 +794,12 @@ static long evdev_do_ioctl(struct file *file, un=
signed int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (size < sizeof(stru=
ct input_absinfo))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0abs.re=
solution =3D 0;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We can't change numb=
er of reserved MT slots */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t =3D=3D ABS_MT_SLO=
T)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the MT slot to r=
eturn through EVIOCGABS */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t =3D=3D ABS_MT_SLO=
T) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (abs=
=2Evalue >=3D 0 && abs.value < dev->mtsize)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 client->mt_slot =3D abs.value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Take event lock to =
ensure that we are not
> --
> 1.7.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
