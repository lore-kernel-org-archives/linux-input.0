From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH RFC] input: Add evdev mute ioctl
Date: Wed, 17 Apr 2013 19:55:44 +0200
Message-ID: <CANq1E4SUg+oaoWhBNE2+HrrF0FLHbf+gc2CvD7KZWQWybeaiag@mail.gmail.com>
References: <1366120697-25841-1-git-send-email-krh@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:35483 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab3DQRzp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Apr 2013 13:55:45 -0400
Received: by mail-ia0-f180.google.com with SMTP id p22so615684iad.25
        for <linux-input@vger.kernel.org>; Wed, 17 Apr 2013 10:55:44 -0700 (PDT)
In-Reply-To: <1366120697-25841-1-git-send-email-krh@bitplanet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, robert@sixbynine.org

Hi Kristian

On Tue, Apr 16, 2013 at 3:58 PM, Kristian H=F8gsberg <krh@bitplanet.net=
> wrote:
> This commit adds a new ioctl to the evdev device: EVIOCMUTE.  The
> purpose of this ioctl it to temporarily block event delivery to a
> specific evdev client and prevent access to most of the ioctls.
>
> The use case is a setuid helper process for a display server, which
> opens input devices and passes the fds to the display server.  On VT
> switch away from the server, it should stop reading events from its
> evdev input devices.  However, if the display server runs as the user
> it can be ptraced or if the server loads user defined modules, the
> display server can no longer be trusted to not snoop on the evdev
> devices.
>
> The mute ioctl allows the setuid helper to mute evdev devices when
> switching away from the VT the server is running on.  The idea is tha=
t
> the helper listens for the VT switching signals and when VT switch ha=
ppens
> it notifies the display server, waits for the server to clean up and =
then
> the helper drops drm master (which also requires root), mutes evdev
> devices and the acks the VT switch.
>
> Why don't we just use revoke?  The revoke syscall (when it's done) wi=
ll
> work on filenames and shut down all fds open to the device.  This wil=
l
> break all other processes that listen on evdev devices for legitimate
> reasons.  It's the same reason we don't use the EVIOCGRAB ioctl for i=
nput
> devices.  EVIOCMUTE lets the helper mute just the fd it gave to the
> display server without affecting anything else potentially using the =
device.

Other use-cases include SAK, forced VT switches and
system-compositors. I'd really like seeing this feature.

> Signed-off-by: Kristian H=F8gsberg <krh@bitplanet.net>
> ---
>  drivers/input/evdev.c      | 37 ++++++++++++++++++++++++++++++++++--=
-
>  include/uapi/linux/input.h |  1 +
>  2 files changed, 35 insertions(+), 3 deletions(-)
>
> This idea comes from work on Wayland and Weston [1], but the setuid h=
elper
> should work and is required for a non-root X server to function corre=
ctly
> as well (ie, do proper vt switching).
>
> Kristian
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index f0f8928..cea6c35 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -48,6 +48,7 @@ struct evdev_client {
>         struct evdev *evdev;
>         struct list_head node;
>         int clkid;
> +       int muted;

Use "bool" instead.

>         unsigned int bufsize;
>         struct input_event buffer[];
>  };
> @@ -130,8 +131,9 @@ static void evdev_events(struct input_handle *han=
dle,
>                 evdev_pass_values(client, vals, count, time_mono, tim=
e_real);
>         else
>                 list_for_each_entry_rcu(client, &evdev->client_list, =
node)
> -                       evdev_pass_values(client, vals, count,
> -                                         time_mono, time_real);
> +                       if (!client->muted)
> +                               evdev_pass_values(client, vals, count=
,
> +                                                 time_mono, time_rea=
l);

Personally, I'd do this in evdev_pass_values(), but that's a matter of
taste.. And this would also allow muting grabbed devices. Because
currently input-grabs overwrite the mute flag which I think is odd. At
least mention this in the commit message so people know how it works
regarding input grabs.

>
>         rcu_read_unlock();
>  }
> @@ -674,6 +676,20 @@ static int evdev_handle_mt_request(struct input_=
dev *dev,
>         return 0;
>  }
>
> +static int evdev_mute(struct evdev *evdev, struct evdev_client *clie=
nt)
> +{
> +       client->muted =3D 1;
> +
> +       return 0;
> +}
> +
> +static int evdev_unmute(struct evdev *evdev, struct evdev_client *cl=
ient)
> +{
> +       client->muted =3D 0;
> +
> +       return 0;
> +}
> +

As I guess we want this feature to be atomic, we definitely need a
lock here. We also want, after EVIOCMUTE returns, that no other ioctl
will be allowed. Hence, we need a mutex that protects
evdev_do_ioctl(). A spinlock around "muted" won't help..
As we currently have no suitable lock in evdev_client I guess we need
to add one. In this case you can also remove these helpers and do:
  client->muted =3D !!p;
in evdev_do_ioctl().

Note that a reader-writer lock would allow parallel ioctl execution if
only the EVIOCMUTE command takes the write-lock and the other ioctls
take a read lock.

Regards
David

>  static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>                            void __user *p, int compat_mode)
>  {
> @@ -687,12 +703,27 @@ static long evdev_do_ioctl(struct file *file, u=
nsigned int cmd,
>         unsigned int size;
>         int error;
>
> -       /* First we check for fixed-length commands */
> +       /* Handle ioctls allowed in muted mode first */
>         switch (cmd) {
> +       case EVIOCMUTE:
> +               if (!capable(CAP_SYS_ADMIN))
> +                   return -EACCES;
> +
> +               if (p)
> +                       return evdev_mute(evdev, client);
> +               else
> +                       return evdev_unmute(evdev, client);
>
>         case EVIOCGVERSION:
>                 return put_user(EV_VERSION, ip);
>
> +       default:
> +               if (client->muted)
> +                       return -EACCES;
> +       }
> +
> +       /* Now check for fixed-length commands */
> +       switch (cmd) {
>         case EVIOCGID:
>                 if (copy_to_user(p, &dev->id, sizeof(struct input_id)=
))
>                         return -EFAULT;
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 935119c..75eda72 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -154,6 +154,7 @@ struct input_keymap_entry {
>  #define EVIOCGRAB              _IOW('E', 0x90, int)                 =
   /* Grab/Release device */
>
>  #define EVIOCSCLOCKID          _IOW('E', 0xa0, int)                 =
   /* Set clockid to be used for timestamps */
> +#define EVIOCMUTE              _IOW('E', 0xb0, int)                 =
   /* Mute event delivery */
>
>  /*
>   * Device properties and quirks
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
