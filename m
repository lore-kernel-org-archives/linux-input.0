From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Tue, 5 Feb 2013 18:50:10 +0100
Message-ID: <CAE7qMrosRbNg+LfVs53NNMx89BSivAxx4MFmQPYPs3o8vnyGew@mail.gmail.com>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
 <20121126185627.7bff1f84@neptune.home> <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
 <alpine.LNX.2.00.1212031416010.27624@pobox.suse.cz> <CAE7qMrrpe+o3-DmRsgxEjc3e5kUUhNZ8ZkkrDrc4fzHJX2T53Q@mail.gmail.com>
 <alpine.LNX.2.00.1302051607130.2260@pobox.suse.cz> <CAE7qMroHOK2TJnUK6wdf7YCK6FTQPmxTKJ=SM_gz0b3fuzf2TA@mail.gmail.com>
 <CAG_cf+ev2y1MHNJFYZycbjQfNgk4hYYRaEoFsKkZyhzAzMgc1A@mail.gmail.com> <CANq1E4QGhN2+nB1MN=LO0yDAe1q6Khq6+PhWyB51K6PGg3Fgdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54506 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755023Ab3BERum (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Feb 2013 12:50:42 -0500
Received: by mail-ie0-f199.google.com with SMTP id c13so1500153ieb.6
        for <linux-input@vger.kernel.org>; Tue, 05 Feb 2013 09:50:42 -0800 (PST)
In-Reply-To: <CANq1E4QGhN2+nB1MN=LO0yDAe1q6Khq6+PhWyB51K6PGg3Fgdw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Andrew de los Reyes <andrew-vger@gizmolabs.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Linux Input <linux-input@vger.kernel.org>

Hi David,

I agree with your suggestions.

Nestor

On Tue, Feb 5, 2013 at 6:22 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Nestor
>
> On Tue, Feb 5, 2013 at 5:38 PM, Andrew de los Reyes
> <andrew-vger@gizmolabs.org> wrote:
>> Yes, I'm hoping to upstream soon as part of a patch series to get WTP
>> support in. The current version of the commit you are asking about is
>> specifically here:
>> https://github.com/adlr/linux/commit/2a4fae572bd88462c4a558a77dc53d9eb3f9e91c
>>
>> The main difference from before is that there is a new return value (1)
>> which signifies that the event lock has been been up()ed, so the hid-core
>> doesn't need to call up() itself. This way during probe(), a driver can
>> allow incoming events continuously from midway through probe() indefinitely.
>
> The patch looks nice. Some comments:
>
> 1) I would prefer constants HID_IS_LOCKED and HID_IS_UNLOCKED or
> similar instead of 1. This makes the code much more readable than
> returning 0 or 1. Maybe you can find better names than my suggestions?
>
> 2) in hid_device_probe() you can use "ret = -EINTR; goto unlock;"
> instead of "up(input_lock); return -EINTR;". I think this is more
> consistent.
>
> 3) in hid_device_probe() maybe check that hid_hw_start() doesn't
> return "1" accidentally? The current code deadlocks if hid_hw_start()
> would be changed to return 1 (which would be bad as is, but maybe be
> rather safe than sorry?).
>
> 4) Maybe we can add a similar logic to hid_device_remove? That is,
> hid_device_remove() shouldn't lock input_lock if the driver wants to
> perform I/O during remove, too. Because this may cause the driver to
> drop input events while the lock is held.
> At least the hid-wiimote driver could make use of this feature during removal.
>
> 5) In current code, if a driver unlocks input_lock but still fails, it
> needs to re-lock input_lock and then return the appropriate error
> code. Is that the intended behavior?
>
> 6) Documentation! At least add some comments to
> hid_driver_probe/remove so others can make use of this feature without
> looking at other drivers.
>
>> If you are interested, I can send just that one commit to the linux-input
>> list now, instead of waiting on WTP to be ready for posting to linux-input
>> (which may be a couple weeks).
>
> I would prefer if you send an RFC patch to the list so we can all comment on it.
>
> btw. how about two helpers:
>
> static inline void hid_device_io_start(struct hid_device *d)
> {
>     up(&d->driver_input_lock);
> }
>
> static inline void hid_device_io_stop(struct hid_device *d)
> {
>     down(&d->driver_input_lock);
> }
>
> This would guarantee that drivers don't use down_interruptible()
> (which would be wrong in error-paths in ->probe()) and it would be
> more readable. The return-value could then be called something like
> HID_START_IO & HID_IO_RUNNING.. Or we can even set a flag on
> hid_device in io_start/io_stop so the return-value isn't needed at
> all.
>
> Thanks for the patch!
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


On Tue, Feb 5, 2013 at 6:22 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Nestor
>
> On Tue, Feb 5, 2013 at 5:38 PM, Andrew de los Reyes
> <andrew-vger@gizmolabs.org> wrote:
>> Yes, I'm hoping to upstream soon as part of a patch series to get WTP
>> support in. The current version of the commit you are asking about is
>> specifically here:
>> https://github.com/adlr/linux/commit/2a4fae572bd88462c4a558a77dc53d9eb3f9e91c
>>
>> The main difference from before is that there is a new return value (1)
>> which signifies that the event lock has been been up()ed, so the hid-core
>> doesn't need to call up() itself. This way during probe(), a driver can
>> allow incoming events continuously from midway through probe() indefinitely.
>
> The patch looks nice. Some comments:
>
> 1) I would prefer constants HID_IS_LOCKED and HID_IS_UNLOCKED or
> similar instead of 1. This makes the code much more readable than
> returning 0 or 1. Maybe you can find better names than my suggestions?
>
> 2) in hid_device_probe() you can use "ret = -EINTR; goto unlock;"
> instead of "up(input_lock); return -EINTR;". I think this is more
> consistent.
>
> 3) in hid_device_probe() maybe check that hid_hw_start() doesn't
> return "1" accidentally? The current code deadlocks if hid_hw_start()
> would be changed to return 1 (which would be bad as is, but maybe be
> rather safe than sorry?).
>
> 4) Maybe we can add a similar logic to hid_device_remove? That is,
> hid_device_remove() shouldn't lock input_lock if the driver wants to
> perform I/O during remove, too. Because this may cause the driver to
> drop input events while the lock is held.
> At least the hid-wiimote driver could make use of this feature during removal.
>
> 5) In current code, if a driver unlocks input_lock but still fails, it
> needs to re-lock input_lock and then return the appropriate error
> code. Is that the intended behavior?
>
> 6) Documentation! At least add some comments to
> hid_driver_probe/remove so others can make use of this feature without
> looking at other drivers.
>
>> If you are interested, I can send just that one commit to the linux-input
>> list now, instead of waiting on WTP to be ready for posting to linux-input
>> (which may be a couple weeks).
>
> I would prefer if you send an RFC patch to the list so we can all comment on it.
>
> btw. how about two helpers:
>
> static inline void hid_device_io_start(struct hid_device *d)
> {
>     up(&d->driver_input_lock);
> }
>
> static inline void hid_device_io_stop(struct hid_device *d)
> {
>     down(&d->driver_input_lock);
> }
>
> This would guarantee that drivers don't use down_interruptible()
> (which would be wrong in error-paths in ->probe()) and it would be
> more readable. The return-value could then be called something like
> HID_START_IO & HID_IO_RUNNING.. Or we can even set a flag on
> hid_device in io_start/io_stop so the return-value isn't needed at
> all.
>
> Thanks for the patch!
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
