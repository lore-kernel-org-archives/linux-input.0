From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH RFC] input: Add evdev mute ioctl
Date: Sun, 21 Apr 2013 15:04:20 +0200
Message-ID: <CANq1E4T_HCg11n4GOOT9jiv2ppfM3c2xVX1zvm-AeG=GJRotpQ@mail.gmail.com>
References: <1366120697-25841-1-git-send-email-krh@bitplanet.net>
	<CANq1E4SUg+oaoWhBNE2+HrrF0FLHbf+gc2CvD7KZWQWybeaiag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:37227 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3DUNEV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Apr 2013 09:04:21 -0400
Received: by mail-ia0-f172.google.com with SMTP id i20so514607ian.17
        for <linux-input@vger.kernel.org>; Sun, 21 Apr 2013 06:04:21 -0700 (PDT)
In-Reply-To: <CANq1E4SUg+oaoWhBNE2+HrrF0FLHbf+gc2CvD7KZWQWybeaiag@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, robert@sixbynine.org

Hi Kristian

On Wed, Apr 17, 2013 at 7:55 PM, David Herrmann <dh.herrmann@gmail.com>=
 wrote:
> Hi Kristian
>
> On Tue, Apr 16, 2013 at 3:58 PM, Kristian H=F8gsberg <krh@bitplanet.n=
et> wrote:
>> This commit adds a new ioctl to the evdev device: EVIOCMUTE.  The
>> purpose of this ioctl it to temporarily block event delivery to a
>> specific evdev client and prevent access to most of the ioctls.
>>
>> The use case is a setuid helper process for a display server, which
>> opens input devices and passes the fds to the display server.  On VT
>> switch away from the server, it should stop reading events from its
>> evdev input devices.  However, if the display server runs as the use=
r
>> it can be ptraced or if the server loads user defined modules, the
>> display server can no longer be trusted to not snoop on the evdev
>> devices.
>>
>> The mute ioctl allows the setuid helper to mute evdev devices when
>> switching away from the VT the server is running on.  The idea is th=
at
>> the helper listens for the VT switching signals and when VT switch h=
appens
>> it notifies the display server, waits for the server to clean up and=
 then
>> the helper drops drm master (which also requires root), mutes evdev
>> devices and the acks the VT switch.
>>
>> Why don't we just use revoke?  The revoke syscall (when it's done) w=
ill
>> work on filenames and shut down all fds open to the device.  This wi=
ll
>> break all other processes that listen on evdev devices for legitimat=
e
>> reasons.  It's the same reason we don't use the EVIOCGRAB ioctl for =
input
>> devices.  EVIOCMUTE lets the helper mute just the fd it gave to the
>> display server without affecting anything else potentially using the=
 device.
>
> Other use-cases include SAK, forced VT switches and
> system-compositors. I'd really like seeing this feature.
>
>> Signed-off-by: Kristian H=F8gsberg <krh@bitplanet.net>
>> ---
>>  drivers/input/evdev.c      | 37 ++++++++++++++++++++++++++++++++++-=
--
>>  include/uapi/linux/input.h |  1 +
>>  2 files changed, 35 insertions(+), 3 deletions(-)
>>
>> This idea comes from work on Wayland and Weston [1], but the setuid =
helper
>> should work and is required for a non-root X server to function corr=
ectly
>> as well (ie, do proper vt switching).
>>
>> Kristian
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index f0f8928..cea6c35 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -48,6 +48,7 @@ struct evdev_client {
>>         struct evdev *evdev;
>>         struct list_head node;
>>         int clkid;
>> +       int muted;
>
> Use "bool" instead.
>
>>         unsigned int bufsize;
>>         struct input_event buffer[];
>>  };
>> @@ -130,8 +131,9 @@ static void evdev_events(struct input_handle *ha=
ndle,
>>                 evdev_pass_values(client, vals, count, time_mono, ti=
me_real);
>>         else
>>                 list_for_each_entry_rcu(client, &evdev->client_list,=
 node)
>> -                       evdev_pass_values(client, vals, count,
>> -                                         time_mono, time_real);
>> +                       if (!client->muted)
>> +                               evdev_pass_values(client, vals, coun=
t,
>> +                                                 time_mono, time_re=
al);
>
> Personally, I'd do this in evdev_pass_values(), but that's a matter o=
f
> taste.. And this would also allow muting grabbed devices. Because
> currently input-grabs overwrite the mute flag which I think is odd. A=
t
> least mention this in the commit message so people know how it works
> regarding input grabs.
>
>>
>>         rcu_read_unlock();
>>  }
>> @@ -674,6 +676,20 @@ static int evdev_handle_mt_request(struct input=
_dev *dev,
>>         return 0;
>>  }
>>
>> +static int evdev_mute(struct evdev *evdev, struct evdev_client *cli=
ent)
>> +{
>> +       client->muted =3D 1;
>> +
>> +       return 0;
>> +}
>> +
>> +static int evdev_unmute(struct evdev *evdev, struct evdev_client *c=
lient)
>> +{
>> +       client->muted =3D 0;
>> +
>> +       return 0;
>> +}
>> +
>
> As I guess we want this feature to be atomic, we definitely need a
> lock here. We also want, after EVIOCMUTE returns, that no other ioctl
> will be allowed. Hence, we need a mutex that protects
> evdev_do_ioctl(). A spinlock around "muted" won't help..
> As we currently have no suitable lock in evdev_client I guess we need
> to add one. In this case you can also remove these helpers and do:
>   client->muted =3D !!p;
> in evdev_do_ioctl().
>
> Note that a reader-writer lock would allow parallel ioctl execution i=
f
> only the EVIOCMUTE command takes the write-lock and the other ioctls
> take a read lock.

As discussed on IRC, the evdev-mutex is definitely enough. I missed
that.. sorry.

Apart from that, I found another thing that we need to discuss:
Stopping force-feedback effects. If we mute a client, we should stop
all FF effects of that client that are currently ongoing. The kernel
already tracks them so this is quite easy to achieve.
On the other hand, clients need write access for FF. With write access
they can do all other kinds of stuff like grabbing the device or
calling EVIOCMUTE(0). Hence, it seems a bit stupid to allow clients
write access in scenarios where EVIOCMUTE is used. Same is true for
write()ing input_events to the device..

So is EVIOCMUTE intended for read-access only? Apart from FF it is
probably fine to tunnel all write-access through the compositor as
they are pretty rare. But for FF effects, clients need write access.
Of course, we can tunnel these through the compositor, too, but how
does that affect performance?
I think we should at least discuss this so we don't end up with
EVIOCMUTE but grant write access for gamepad/joystick devices and
basically render EVIOCMUTE uneffective..

I'm currently looking into a wl_keyboard/wl_mouse extension that
passes FDs optionally to clients so they can use this while being
fullscreen. I will post this here so we have a good example for this
feature.

Regards
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
