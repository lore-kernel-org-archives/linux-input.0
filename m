From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for selecting clockid for
 event time stamps.
Date: Fri, 6 Jan 2012 17:20:26 +0800
Message-ID: <CAGS+omCB7L7w1NXiaNdBPWPjx4+5soeg8Qq9TLQtmn=b13cSAg@mail.gmail.com>
References: <1325818212-24752-1-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:64077 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758144Ab2AFJUs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Jan 2012 04:20:48 -0500
Received: by obcwo16 with SMTP id wo16so1620342obc.19
        for <linux-input@vger.kernel.org>; Fri, 06 Jan 2012 01:20:47 -0800 (PST)
In-Reply-To: <1325818212-24752-1-git-send-email-john.stultz@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>

On Fri, Jan 6, 2012 at 10:50 AM, John Stultz <john.stultz@linaro.org> w=
rote:
> Here's another revision, incorperating Dmitry's suggestion.
>
> As noted by Arve and others, since wall time can jump backwards, it
> is difficult to use for input because one cannot determine if one
> event occured before another or for how long a key was pressed.
>
> However, the timestamp field is part of the kernel ABI, and cannot
> be changed without possibly breaking existing users.
>
> This patch adds a new IOCTL that allows a clockid to be set in
> the evdev_client struct that will specify which time base to
> use for event timestamps (ie: CLOCK_MONOTONIC instead
> of CLOCK_REALTIME).
>
> For now we only support CLOCK_MONOTONIC and CLOCK_REALTIME, but
> in the future we could support other clockids if appropriate.

What about CLOCK_MONOTONIC_RAW?

Last time we discussed, I thought this clock was the most useful for
use with input devices.  But, you wrote this:
> So rawmonotonic isn't frequency corrected via NTP, while the monotoni=
c
> clock is. So if you're calculating intervals, you will get more accur=
ate
> times (where a second is a second) w/ ktime_get_ts().

Does this frequency correction involve timestamp jumps?
If so, of what magnitude?
In my experience, input event timestamp intervals are usually on the
order of a few milliseconds (5-25 ms).  If CLOCK_MONOTONIC experiences
frequent adjustments near this order of magnitude, I still think
CLOCK_MONOTONIC_RAW might be a better choice for event timestamps.

>
> The default remains CLOCK_REALTIME, so we don't change the ABI.
>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Daniel Kurtz <djkurtz@google.com>
> CC: linux-input@vger.kernel.org
> CC: Arve Hj=F8nnev=E5g <arve@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> =A0drivers/input/evdev.c | =A0 33 +++++++++++++++++++++++++++++----
> =A0include/linux/input.h | =A0 =A02 ++
> =A02 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 4cf2534..4b71484 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -46,6 +46,7 @@ struct evdev_client {
> =A0 =A0 =A0 =A0struct fasync_struct *fasync;
> =A0 =A0 =A0 =A0struct evdev *evdev;
> =A0 =A0 =A0 =A0struct list_head node;
> + =A0 =A0 =A0 bool timestamp_clkid;

This isn't bool anymore.

> =A0 =A0 =A0 =A0unsigned int bufsize;
> =A0 =A0 =A0 =A0struct input_event buffer[];
> =A0};
> @@ -54,8 +55,19 @@ static struct evdev *evdev_table[EVDEV_MINORS];
> =A0static DEFINE_MUTEX(evdev_table_mutex);
>
> =A0static void evdev_pass_event(struct evdev_client *client,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct input=
_event *event)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct input=
_event *event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ktime_t mono=
, ktime_t real)
> =A0{
> + =A0 =A0 =A0 struct timespec ts;
> +
> + =A0 =A0 =A0 if (client->timestamp_clkid =3D=3D CLOCK_MONOTONIC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts =3D ktime_to_timespec(mono);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts =3D ktime_to_timespec(real);
> + =A0 =A0 =A0 event->time.tv_sec =3D ts.tv_sec;
> + =A0 =A0 =A0 event->time.tv_usec =3D ts.tv_nsec / NSEC_PER_USEC;
> +
> +
> =A0 =A0 =A0 =A0/* Interrupts are disabled, just acquire the lock. */
> =A0 =A0 =A0 =A0spin_lock(&client->buffer_lock);
>
> @@ -94,8 +106,11 @@ static void evdev_event(struct input_handle *hand=
le,
> =A0 =A0 =A0 =A0struct evdev *evdev =3D handle->private;
> =A0 =A0 =A0 =A0struct evdev_client *client;
> =A0 =A0 =A0 =A0struct input_event event;
> + =A0 =A0 =A0 ktime_t time_mono, time_real;
> +
> + =A0 =A0 =A0 time_mono =3D ktime_get();
> + =A0 =A0 =A0 time_real =3D ktime_sub(time_mono, ktime_get_monotonic_=
offset());
>
> - =A0 =A0 =A0 do_gettimeofday(&event.time);
> =A0 =A0 =A0 =A0event.type =3D type;
> =A0 =A0 =A0 =A0event.code =3D code;
> =A0 =A0 =A0 =A0event.value =3D value;
> @@ -103,11 +118,12 @@ static void evdev_event(struct input_handle *ha=
ndle,
> =A0 =A0 =A0 =A0rcu_read_lock();
>
> =A0 =A0 =A0 =A0client =3D rcu_dereference(evdev->grab);
> +
> =A0 =A0 =A0 =A0if (client)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 evdev_pass_event(client, &event);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 evdev_pass_event(client, &event, time_m=
ono, time_real);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_for_each_entry_rcu(client, &evdev=
->client_list, node)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 evdev_pass_event(client=
, &event);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 evdev_pass_event(client=
, &event, time_mono, time_real);
>
> =A0 =A0 =A0 =A0rcu_read_unlock();
>
> @@ -683,6 +699,15 @@ static long evdev_do_ioctl(struct file *file, un=
signed int cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return evdev_ungrab(ev=
dev, client);
>
> + =A0 =A0 =A0 case EVIOCCLOCKID:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(&i, p, sizeof(unsign=
ed int)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i =3D=3D CLOCK_MONOTONIC) || (i =3D=
=3D CLOCK_REALTIME)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->timestamp_clkid=
 =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> =A0 =A0 =A0 =A0case EVIOCGKEYCODE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return evdev_handle_get_keycode(dev, p=
);
>
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 3862e32..9618e14 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -129,6 +129,8 @@ struct input_keymap_entry {
>
> =A0#define EVIOCGRAB =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOW('E', 0x90, int) =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Grab/Release device */
>
> +#define EVIOCCLOCKID =A0 =A0 =A0 =A0 =A0 _IOW('E', 0xA0, int) =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Set clockid to be used for timestamp=
s */
> +
> =A0/*
> =A0* Device properties and quirks
> =A0*/
> --
> 1.7.3.2.146.gca209
>

Thanks,
-Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
