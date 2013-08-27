From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] Input: evdev - add EVIOCREVOKE ioctl
Date: Wed, 28 Aug 2013 00:35:06 +0200
Message-ID: <CANq1E4T5B98wbOD3XQinGS6P4jvf9zMy5gYeQvi3rZF44SzagQ@mail.gmail.com>
References: <1377602704-23301-1-git-send-email-dh.herrmann@gmail.com>
	<1377603589-25501-1-git-send-email-dh.herrmann@gmail.com>
	<20130827221733.GA20726@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60774 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3H0WfH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Aug 2013 18:35:07 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so5897327obc.27
        for <linux-input@vger.kernel.org>; Tue, 27 Aug 2013 15:35:06 -0700 (PDT)
In-Reply-To: <20130827221733.GA20726@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Wed, Aug 28, 2013 at 12:17 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Tue, Aug 27, 2013 at 01:39:49PM +0200, David Herrmann wrote:
>> If we have multiple sessions on a system, we normally don't want
>> background sessions to read input events. Otherwise, it could capture
>> passwords and more entered by the user on the foreground session. This is
>> a real world problem as the recent XMir development showed:
>>   http://mjg59.dreamwidth.org/27327.html
>>
>> We currently rely on sessions to release input devices when being
>> deactivated. This relies on trust across sessions. But that's not given on
>> usual systems. We therefore need a way to control which processes have
>> access to input devices.
>>
>> With VTs the kernel simply routed them through the active /dev/ttyX. This
>> is not possible with evdev devices, though. Moreover, we want to avoid
>> routing input-devices through some dispatcher-daemon in userspace (which
>> would add some latency).
>>
>> This patch introduces EVIOCREVOKE. If called on an evdev fd, this revokes
>> device-access irrecoverably for that *single* open-file. Hence, once you
>> call EVIOCREVOKE on any dup()ed fd, all fds for that open-file will be
>> rather useless now (but still valid compared to close()!). This allows us
>> to pass fds directly to session-processes from a trusted source. The
>> source keeps a dup()ed fd and revokes access once the session-process is
>> no longer active.
>> Compared to the EVIOCMUTE proposal, we can avoid the CAP_SYS_ADMIN
>> restriction now as there is no way to revive the fd again. Hence, a user
>> is free to call EVIOCREVOKE themself to kill the fd.
>>
>> Additionally, this ioctl allows multi-layer access-control (again compared
>> to EVIOCMUTE which was limited to one layer via CAP_SYS_ADMIN). A middle
>> layer can simply request a new open-file from the layer above and pass it
>> to the layer below. Now each layer can call EVIOCREVOKE on the fds to
>> revoke access for all layers below, at the expense of one fd per layer.
>>
>> There's already ongoing experimental user-space work which demonstrates
>> how it can be used:
>>   http://lists.freedesktop.org/archives/systemd-devel/2013-August/012897.html
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>> v2:
>>  - ungrab device during revoke
>>  - wake-up blocking read()s of the client
>>  - return -EACCES from write() for revoked clients
>>  - signal POLLHUP | POLLERR for revoked clients
>>  - don't signal POLLOUT for revoked clients
>>
>>  drivers/input/evdev.c      | 43 ++++++++++++++++++++++++++++++++++++++++---
>>  include/uapi/linux/input.h |  1 +
>>  2 files changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index d2b34fb..f2abd76 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -48,6 +48,7 @@ struct evdev_client {
>>       struct evdev *evdev;
>>       struct list_head node;
>>       int clkid;
>> +     bool revoked;
>>       unsigned int bufsize;
>>       struct input_event buffer[];
>>  };
>> @@ -164,6 +165,9 @@ static void evdev_pass_values(struct evdev_client *client,
>>       struct input_event event;
>>       bool wakeup = false;
>>
>> +     if (client->revoked)
>> +             return;
>> +
>>       event.time = ktime_to_timeval(client->clkid == CLOCK_MONOTONIC ?
>>                                     mono : real);
>>
>> @@ -432,6 +436,9 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>>       if (!evdev->exist) {
>>               retval = -ENODEV;
>>               goto out;
>> +     } else if (client->revoked) {
>> +             retval = -EACCES;
>> +             goto out;
>
> Why do we treat revoke differently form device going away? I'd return
> -ENODEV in both cases.

My plan was to allow applications to react to revoke. So if someone
remotely revokes their fd, they notice it via EACCES, not via ENODEV.
They could just close the fd but keep contexts around (they may get a
new fd soon). If they receive ENODEV (or some other error), they could
drop all their contexts and just remove the device.

However, I just noticed that it is very unlikely that they're revoked
during write(). It's more likely during poll() (which returns POLLHUP
for both). So I guess you're right. Will rethink it again, but if I
don't come up with some idea I'll just drop it for v3.

Thanks!
David

>>       }
>>
>>       while (retval + input_event_size() <= count) {
>> @@ -511,7 +518,7 @@ static ssize_t evdev_read(struct file *file, char __user *buffer,
>>               if (!(file->f_flags & O_NONBLOCK)) {
>>                       error = wait_event_interruptible(evdev->wait,
>>                                       client->packet_head != client->tail ||
>> -                                     !evdev->exist);
>> +                                     !evdev->exist || client->revoked);
>>                       if (error)
>>                               return error;
>>               }
>> @@ -529,7 +536,11 @@ static unsigned int evdev_poll(struct file *file, poll_table *wait)
>>
>>       poll_wait(file, &evdev->wait, wait);
>>
>> -     mask = evdev->exist ? POLLOUT | POLLWRNORM : POLLHUP | POLLERR;
>> +     if (evdev->exist && !client->revoked)
>> +             mask = POLLOUT | POLLWRNORM;
>> +     else
>> +             mask = POLLHUP | POLLERR;
>> +
>>       if (client->packet_head != client->tail)
>>               mask |= POLLIN | POLLRDNORM;
>>
>> @@ -795,6 +806,17 @@ static int evdev_handle_mt_request(struct input_dev *dev,
>>       return 0;
>>  }
>>
>> +static int evdev_revoke(struct evdev *evdev, struct evdev_client *client,
>> +                     struct file *file)
>> +{
>> +     client->revoked = true;
>> +     evdev_ungrab(evdev, client);
>> +     input_flush_device(&evdev->handle, file);
>> +     wake_up_interruptible(&evdev->wait);
>> +
>> +     return 0;
>> +}
>> +
>>  static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>>                          void __user *p, int compat_mode)
>>  {
>> @@ -808,12 +830,27 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>>       unsigned int size;
>>       int error;
>>
>> -     /* First we check for fixed-length commands */
>> +     /* First check for ioctls allowed while revoked */
>>       switch (cmd) {
>>
>>       case EVIOCGVERSION:
>>               return put_user(EV_VERSION, ip);
>>
>> +     case EVIOCREVOKE:
>> +             if (p)
>> +                     return -EINVAL;
>> +             else
>> +                     return evdev_revoke(evdev, client, file);
>> +
>> +     default:
>> +             if (client->revoked)
>> +                     return -EACCES;
>> +             break;
>> +     }
>
> Here as well, I'd check revoked in the same place where we check exist
> and bail if device gone away or our access was revoked.
>
>> +
>> +     /* Then check for fixed-length commands */
>> +     switch (cmd) {
>> +
>>       case EVIOCGID:
>>               if (copy_to_user(p, &dev->id, sizeof(struct input_id)))
>>                       return -EFAULT;
>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>> index 2fb6fae..d61c61c 100644
>> --- a/include/uapi/linux/input.h
>> +++ b/include/uapi/linux/input.h
>> @@ -152,6 +152,7 @@ struct input_keymap_entry {
>>  #define EVIOCGEFFECTS                _IOR('E', 0x84, int)                    /* Report number of effects playable at the same time */
>>
>>  #define EVIOCGRAB            _IOW('E', 0x90, int)                    /* Grab/Release device */
>> +#define EVIOCREVOKE          _IOW('E', 0x91, int)                    /* Revoke device access */
>>
>>  #define EVIOCSCLOCKID                _IOW('E', 0xa0, int)                    /* Set clockid to be used for timestamps */
>>
>> --
>> 1.8.4
>>
>
> Thanks.
>
> --
> Dmitry
