From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Wed, 6 Feb 2013 16:21:46 +0100
Message-ID: <CANq1E4SumX_3P2mfiD9SO4HkpaxH-DM2_Z7w2+Ksbh=iw_k1Hw@mail.gmail.com>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
	<20121126185627.7bff1f84@neptune.home>
	<CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
	<alpine.LNX.2.00.1212031416010.27624@pobox.suse.cz>
	<CAE7qMrrpe+o3-DmRsgxEjc3e5kUUhNZ8ZkkrDrc4fzHJX2T53Q@mail.gmail.com>
	<alpine.LNX.2.00.1302051607130.2260@pobox.suse.cz>
	<CAE7qMroHOK2TJnUK6wdf7YCK6FTQPmxTKJ=SM_gz0b3fuzf2TA@mail.gmail.com>
	<CAG_cf+ev2y1MHNJFYZycbjQfNgk4hYYRaEoFsKkZyhzAzMgc1A@mail.gmail.com>
	<CANq1E4QGhN2+nB1MN=LO0yDAe1q6Khq6+PhWyB51K6PGg3Fgdw@mail.gmail.com>
	<alpine.LNX.2.00.1302061608470.16860@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:62359 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab3BFPVs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Feb 2013 10:21:48 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so861944eei.21
        for <linux-input@vger.kernel.org>; Wed, 06 Feb 2013 07:21:47 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1302061608470.16860@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew de los Reyes <andrew-vger@gizmolabs.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Linux Input <linux-input@vger.kernel.org>

Hi Jiri

On Wed, Feb 6, 2013 at 4:10 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 5 Feb 2013, David Herrmann wrote:
>
>> > Yes, I'm hoping to upstream soon as part of a patch series to get WTP
>> > support in. The current version of the commit you are asking about is
>> > specifically here:
>> > https://github.com/adlr/linux/commit/2a4fae572bd88462c4a558a77dc53d9eb3f9e91c
>> >
>> > The main difference from before is that there is a new return value (1)
>> > which signifies that the event lock has been been up()ed, so the hid-core
>> > doesn't need to call up() itself. This way during probe(), a driver can
>> > allow incoming events continuously from midway through probe() indefinitely.
>>
>> The patch looks nice. Some comments:
>>
>> 1) I would prefer constants HID_IS_LOCKED and HID_IS_UNLOCKED or
>> similar instead of 1. This makes the code much more readable than
>> returning 0 or 1. Maybe you can find better names than my suggestions?
>>
>> 2) in hid_device_probe() you can use "ret = -EINTR; goto unlock;"
>> instead of "up(input_lock); return -EINTR;". I think this is more
>> consistent.
>>
>> 3) in hid_device_probe() maybe check that hid_hw_start() doesn't
>> return "1" accidentally? The current code deadlocks if hid_hw_start()
>> would be changed to return 1 (which would be bad as is, but maybe be
>> rather safe than sorry?).
>>
>> 4) Maybe we can add a similar logic to hid_device_remove? That is,
>> hid_device_remove() shouldn't lock input_lock if the driver wants to
>> perform I/O during remove, too. Because this may cause the driver to
>> drop input events while the lock is held.
>> At least the hid-wiimote driver could make use of this feature during removal.
>
> David,
>
> what use-case exactly are you thinking of here, please?

If you unbind a driver via sysfs, hid-wiimote could suspend several
peripherals of a Wii Remote to safe energy. I don't know whether
that's a use-case that we actively support, but I thought it would be
nice to have if we are on it, anyway.

I know that during normal device removal no I/O is possible
(obviously), but during manual probe/remove this might happen.

Regards
David
