From: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <hoegsberg@gmail.com>
Subject: Re: [PATCH v3] Input: evdev - add EVIOCREVOKE ioctl
Date: Fri, 6 Sep 2013 11:04:05 -0700
Message-ID: <CAOeoa-e4d6Qi7Fr0Q3ETbJc5yTXfp6yzCCJY-VyAQgt-_LRM8A@mail.gmail.com>
References: <1377603589-25501-1-git-send-email-dh.herrmann@gmail.com>
	<1378044450-8327-1-git-send-email-dh.herrmann@gmail.com>
	<CANq1E4S9WJaFTqru0-UtcLi-Aij2v43b3VT5jkPRUp6n5VHrzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:38887 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab3IFSEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Sep 2013 14:04:08 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3041802lab.19
        for <linux-input@vger.kernel.org>; Fri, 06 Sep 2013 11:04:05 -0700 (PDT)
In-Reply-To: <CANq1E4S9WJaFTqru0-UtcLi-Aij2v43b3VT5jkPRUp6n5VHrzw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, Sep 6, 2013 at 10:12 AM, David Herrmann <dh.herrmann@gmail.com>=
 wrote:
> Hi Dmitry
>
> On Sun, Sep 1, 2013 at 4:07 PM, David Herrmann <dh.herrmann@gmail.com=
> wrote:
>> If we have multiple sessions on a system, we normally don't want
>> background sessions to read input events. Otherwise, it could captur=
e
>> passwords and more entered by the user on the foreground session. Th=
is is
>> a real world problem as the recent XMir development showed:
>>   http://mjg59.dreamwidth.org/27327.html
>>
>> We currently rely on sessions to release input devices when being
>> deactivated. This relies on trust across sessions. But that's not gi=
ven on
>> usual systems. We therefore need a way to control which processes ha=
ve
>> access to input devices.
>>
>> With VTs the kernel simply routed them through the active /dev/ttyX.=
 This
>> is not possible with evdev devices, though. Moreover, we want to avo=
id
>> routing input-devices through some dispatcher-daemon in userspace (w=
hich
>> would add some latency).
>>
>> This patch introduces EVIOCREVOKE. If called on an evdev fd, this re=
vokes
>> device-access irrecoverably for that *single* open-file. Hence, once=
 you
>> call EVIOCREVOKE on any dup()ed fd, all fds for that open-file will =
be
>> rather useless now (but still valid compared to close()!). This allo=
ws us
>> to pass fds directly to session-processes from a trusted source. The
>> source keeps a dup()ed fd and revokes access once the session-proces=
s is
>> no longer active.
>> Compared to the EVIOCMUTE proposal, we can avoid the CAP_SYS_ADMIN
>> restriction now as there is no way to revive the fd again. Hence, a =
user
>> is free to call EVIOCREVOKE themself to kill the fd.
>>
>> Additionally, this ioctl allows multi-layer access-control (again co=
mpared
>> to EVIOCMUTE which was limited to one layer via CAP_SYS_ADMIN). A mi=
ddle
>> layer can simply request a new open-file from the layer above and pa=
ss it
>> to the layer below. Now each layer can call EVIOCREVOKE on the fds t=
o
>> revoke access for all layers below, at the expense of one fd per lay=
er.
>>
>> There's already ongoing experimental user-space work which demonstra=
tes
>> how it can be used:
>>   http://lists.freedesktop.org/archives/systemd-devel/2013-August/01=
2897.html
>
> I've been running this logind-feature for some time on my machine now=
=2E
> I haven't seen any problems. Could you let us know what your plans ar=
e
> for this patch?
> 3.12 would be very nice so we could continue pushing the user-space p=
arts.
> There are even existing programs (like weston-launch) which could
> already make great use of that with just a <10 line patch.

I think we have good use cases for this - with revoke we can give
input fds to a non-trusted, non-root display-severs and standalone
KMS+evdev applications and reliably revoke them when their session is
deactivated (vt switched away typically).  EVIOCREVOKE is usable in
logind and standalone setuid helpers such as weston-launch,.
Everything other priviledge operation a display server needs can be
done in logind or weston-launch, this ioctl is the final piece that
lets us run X without root priviledges.

Reviewed-by: Kristian H=C3=B8gsberg <krh@bitplanet.net>

>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>> Changes from v2:
>>  - Handle client->revoked like evdev->exist to avoid special-casing =
"revoked"
>>
>>  drivers/input/evdev.c      | 33 +++++++++++++++++++++++++++++----
>>  include/uapi/linux/input.h |  1 +
>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index d2b34fb..cf6bdff 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -48,6 +48,7 @@ struct evdev_client {
>>         struct evdev *evdev;
>>         struct list_head node;
>>         int clkid;
>> +       bool revoked;
>>         unsigned int bufsize;
>>         struct input_event buffer[];
>>  };
>> @@ -164,6 +165,9 @@ static void evdev_pass_values(struct evdev_clien=
t *client,
>>         struct input_event event;
>>         bool wakeup =3D false;
>>
>> +       if (client->revoked)
>> +               return;
>> +
>>         event.time =3D ktime_to_timeval(client->clkid =3D=3D CLOCK_M=
ONOTONIC ?
>>                                       mono : real);
>>
>> @@ -429,7 +433,7 @@ static ssize_t evdev_write(struct file *file, co=
nst char __user *buffer,
>>         if (retval)
>>                 return retval;
>>
>> -       if (!evdev->exist) {
>> +       if (!evdev->exist || client->revoked) {
>>                 retval =3D -ENODEV;
>>                 goto out;
>>         }
>> @@ -511,7 +515,7 @@ static ssize_t evdev_read(struct file *file, cha=
r __user *buffer,
>>                 if (!(file->f_flags & O_NONBLOCK)) {
>>                         error =3D wait_event_interruptible(evdev->wa=
it,
>>                                         client->packet_head !=3D cli=
ent->tail ||
>> -                                       !evdev->exist);
>> +                                       !evdev->exist || client->rev=
oked);
>>                         if (error)
>>                                 return error;
>>                 }
>> @@ -529,7 +533,11 @@ static unsigned int evdev_poll(struct file *fil=
e, poll_table *wait)
>>
>>         poll_wait(file, &evdev->wait, wait);
>>
>> -       mask =3D evdev->exist ? POLLOUT | POLLWRNORM : POLLHUP | POL=
LERR;
>> +       if (evdev->exist && !client->revoked)
>> +               mask =3D POLLOUT | POLLWRNORM;
>> +       else
>> +               mask =3D POLLHUP | POLLERR;
>> +
>>         if (client->packet_head !=3D client->tail)
>>                 mask |=3D POLLIN | POLLRDNORM;
>>
>> @@ -795,6 +803,17 @@ static int evdev_handle_mt_request(struct input=
_dev *dev,
>>         return 0;
>>  }
>>
>> +static int evdev_revoke(struct evdev *evdev, struct evdev_client *c=
lient,
>> +                       struct file *file)
>> +{
>> +       client->revoked =3D true;
>> +       evdev_ungrab(evdev, client);
>> +       input_flush_device(&evdev->handle, file);
>> +       wake_up_interruptible(&evdev->wait);
>> +
>> +       return 0;
>> +}
>> +
>>  static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>>                            void __user *p, int compat_mode)
>>  {
>> @@ -857,6 +876,12 @@ static long evdev_do_ioctl(struct file *file, u=
nsigned int cmd,
>>                 else
>>                         return evdev_ungrab(evdev, client);
>>
>> +       case EVIOCREVOKE:
>> +               if (p)
>> +                       return -EINVAL;
>> +               else
>> +                       return evdev_revoke(evdev, client, file);
>> +
>>         case EVIOCSCLOCKID:
>>                 if (copy_from_user(&i, p, sizeof(unsigned int)))
>>                         return -EFAULT;
>> @@ -1002,7 +1027,7 @@ static long evdev_ioctl_handler(struct file *f=
ile, unsigned int cmd,
>>         if (retval)
>>                 return retval;
>>
>> -       if (!evdev->exist) {
>> +       if (!evdev->exist || client->revoked) {
>>                 retval =3D -ENODEV;
>>                 goto out;
>>         }
>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>> index 2fb6fae..d61c61c 100644
>> --- a/include/uapi/linux/input.h
>> +++ b/include/uapi/linux/input.h
>> @@ -152,6 +152,7 @@ struct input_keymap_entry {
>>  #define EVIOCGEFFECTS          _IOR('E', 0x84, int)                =
    /* Report number of effects playable at the same time */
>>
>>  #define EVIOCGRAB              _IOW('E', 0x90, int)                =
    /* Grab/Release device */
>> +#define EVIOCREVOKE            _IOW('E', 0x91, int)                =
    /* Revoke device access */
>>
>>  #define EVIOCSCLOCKID          _IOW('E', 0xa0, int)                =
    /* Set clockid to be used for timestamps */
>>
>> --
>> 1.8.4
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
