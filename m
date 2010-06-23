From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/5] input: Use driver hint to compute the evdev buffer
	size (rev3)
Date: Wed, 23 Jun 2010 09:54:19 -0700
Message-ID: <AANLkTilWSe-rdy1johctU6CXdV11Iiw8GkTTQOrsE2aO@mail.gmail.com>
References: <1277291686-7153-1-git-send-email-rydberg@euromail.se>
	<1277291686-7153-2-git-send-email-rydberg@euromail.se>
	<1277291686-7153-3-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34592 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab0FWQyU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 12:54:20 -0400
In-Reply-To: <1277291686-7153-3-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Benjamin Tissoires <tissoire@cena.fr>, Chase Douglas <chase.douglas@canonical.com>, Rafi Rubin <rafi@seas.upenn.edu>

Hi Henrik,

I like this patchset. Along with the mtdev patchset submitted to x.org
by Chase, I see a great collaboration for the MT support.  Keep up the
good work.

I have a minor comment inline.

Thank you.

Ping

On Wed, Jun 23, 2010 at 4:14 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Some devices, in particular MT devices, produce a lot of data. =A0Thi=
s
> leads to a high frequency of lost packets in evdev, which by default
> uses a fairly small event buffer. Let the drivers hint the average
> number of events per packet for the device by calling the
> input_set_events_per_packet(), and use that information when computin=
g
> the evdev buffer size.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/input/evdev.c | =A0 =A05 ++++-
> =A0include/linux/input.h | =A0 17 +++++++++++++++++
> =A02 files changed, 21 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 5d84e59..728802f 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -11,6 +11,7 @@
> =A0#define EVDEV_MINOR_BASE =A0 =A0 =A0 64
> =A0#define EVDEV_MINORS =A0 =A0 =A0 =A0 =A0 32
> =A0#define EVDEV_MIN_BUFFER_SIZE =A064
> +#define EVDEV_BUF_PACKETS =A0 =A0 =A08
>
> =A0#include <linux/poll.h>
> =A0#include <linux/sched.h>
> @@ -51,7 +52,9 @@ static DEFINE_MUTEX(evdev_table_mutex);
>
> =A0static int evdev_compute_buffer_size(struct input_dev *dev)
> =A0{
> - =A0 =A0 =A0 return EVDEV_MIN_BUFFER_SIZE;
> + =A0 =A0 =A0 int nev =3D dev->hint_events_per_packet * EVDEV_BUF_PAC=
KETS;
> + =A0 =A0 =A0 nev =3D max(nev, EVDEV_MIN_BUFFER_SIZE);
> + =A0 =A0 =A0 return roundup_pow_of_two(nev);

I think we have a backward compatibility issue here. This routine will
return 7 when nev falls to the default value
(EVDEV_MIN_BUFFER_SIZE/64).  This could happen to those drivers that
don't report MT events or forget/don't feel the need to set
hint_events_per_packet since the old BUFFER_SIZE worked perfectly for
them.  We need to keep the return value for those drivers as 64 so we
could allocate the same space as it was in [PATCH 1/5].

> =A0}
>
> =A0static void evdev_pass_event(struct evdev_client *client,
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 20e4eac..9e024b6 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -1162,6 +1162,8 @@ struct input_dev {
> =A0 =A0 =A0 =A0unsigned long ffbit[BITS_TO_LONGS(FF_CNT)];
> =A0 =A0 =A0 =A0unsigned long swbit[BITS_TO_LONGS(SW_CNT)];
>
> + =A0 =A0 =A0 unsigned int hint_events_per_packet;
> +
> =A0 =A0 =A0 =A0unsigned int keycodemax;
> =A0 =A0 =A0 =A0unsigned int keycodesize;
> =A0 =A0 =A0 =A0void *keycode;
> @@ -1439,6 +1441,21 @@ static inline void input_mt_slot(struct input_=
dev *dev, int slot)
>
> =A0void input_set_capability(struct input_dev *dev, unsigned int type=
, unsigned int code);
>
> +/**
> + * input_set_events_per_packet - tell handlers about the driver even=
t rate
> + * @dev: the input device used by the driver
> + * @nev: the average number of events between calls to input_sync()
> + *
> + * If the event rate sent from a device is unusually large, use this
> + * function to set the expected event rate. This will allow handlers
> + * to set up an approriate buffer size for the event stream, in orde=
r
> + * to minimize information loss.
> + */
> +static inline void input_set_events_per_packet(struct input_dev *dev=
, int nev)
> +{
> + =A0 =A0 =A0 dev->hint_events_per_packet =3D nev;
> +}
> +
> =A0static inline void input_set_abs_params(struct input_dev *dev, int=
 axis, int min, int max, int fuzz, int flat)
> =A0{
> =A0 =A0 =A0 =A0dev->absmin[axis] =3D min;
> --
> 1.6.3.3
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
