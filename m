From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Mon, 26 Nov 2012 19:34:18 +0100
Message-ID: <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
	<20121126185627.7bff1f84@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39384 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2KZSeU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 13:34:20 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so5957513lbb.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 10:34:18 -0800 (PST)
In-Reply-To: <20121126185627.7bff1f84@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Andrew de los Reyes <andrew-vger@gizmolabs.org>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>

Hi Bruno,

On Mon, Nov 26, 2012 at 6:56 PM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
> Hi Andrew,
>
> [CCing David Herrmann]
>
>
> On Sun, 25 November 2012 Andrew de los Reyes wrote:
>> Benjamin Tissoires and Nestor Lopez Casado have been helping me to a=
dd
>> Linux support for new Logitech Touch Mice (T620, T400). After runnin=
g
>> into a road-block in hid-core, and solving it with this patch, we
>> thought it was good to show the community and see if this is okay, o=
r
>> if there's a better solution that we've missed.
>>
>> Thanks for your comments,
>> -andrew
>>
>> This patch separates struct hid_device's driver_lock into two. The
>> goal is to allow hid device drivers to receive input during their
>> probe() function call. This is necessary because some drivers need t=
o
>> communicate with the device to determine parameters needed during
>> probe (e.g., size of a multi-touch surface).
>>
>> Historically, three functions used driver_lock:
>>
>> - hid_device_probe: blocks to acquire lock
>> - hid_device_remove: blocks to acquire lock
>> - hid_input_report: if locked returns -EBUSY, else acquires lock
>>
>> This patch adds another lock (driver_input_lock) which is used to
>> block input from occurring. The lock behavior is now:
>>
>> - hid_device_probe: blocks to acq. driver_lock, then driver_input_lo=
ck
>> - hid_device_remove: blocks to acq. driver_lock, then driver_input_l=
ock
>> - hid_input_report: if driver_input_lock locked returns -EBUSY, else
>>   acquires driver_input_lock
>>
>> This results in no behavior change for existing devices and
>> drivers. However, during a probe() function call in a driver, that
>> driver may now selectively unlock driver_input_lock to let input
>> events come through, then re-lock.
>
> That is more or less a new approach to release the restriction added =
in
> commit 4ea5454203d991ec85264f64f89ca8855fce69b0
> (HID: Fix race condition between driver core and ll-driver).
>
> From your suggested change the question could be if releasing the inp=
ut
> lock should be connected to hw_start() / hw_stop() calls...
>
> Though connecting those together would certainly require some review =
of
> existing drivers in order not to reopen the can of worms closed by ab=
ove
> mentioned commit.
>

It is clear that the goal is to make commit
4ea5454203d991ec85264f64f89ca8855fce69b0 less restrictive.
The problem is that this commit stops any communication with the
device, even configuration communication.

Logitech devices use their own protocol on top of the HID standard
protocol. For touch devices, this proprietary protocol requires to ask
the device for axis ranges, etc...

So here, the idea is not to open the can of worm for every hid devices
through hw_start() / hw_stop() calls, I think the idea of Andrew is
just to allow hid-logitech-dj to get rid of this restriction in some
particular circumstances.
Consider this as a controlled backdoor of the can of worms :)

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
