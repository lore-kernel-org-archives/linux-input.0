From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Mon, 26 Nov 2012 12:50:29 -0800
Message-ID: <CAG_cf+eOFKAGP6NmAr24PMfk8ZHFEKh50FAvf_nPcLQ+Yq_BGQ@mail.gmail.com>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
 <20121126185627.7bff1f84@neptune.home> <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
 <CANq1E4Qc_GpRtghL5emCFTWOCh0-0TC1oJ6ZaAsQbOMixgS-5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57733 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563Ab2KZUuu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 15:50:50 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so7051125iea.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 12:50:49 -0800 (PST)
In-Reply-To: <CANq1E4Qc_GpRtghL5emCFTWOCh0-0TC1oJ6ZaAsQbOMixgS-5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mon, Nov 26, 2012 at 10:54 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi
>
> On Mon, Nov 26, 2012 at 7:34 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> Hi Bruno,
>>
>> On Mon, Nov 26, 2012 at 6:56 PM, Bruno Pr=E9mont
>> <bonbons@linux-vserver.org> wrote:
>>> Hi Andrew,
>>>
>>> [CCing David Herrmann]
>>>
>>>
>>> On Sun, 25 November 2012 Andrew de los Reyes wrote:
>>>> Benjamin Tissoires and Nestor Lopez Casado have been helping me to=
 add
>>>> Linux support for new Logitech Touch Mice (T620, T400). After runn=
ing
>>>> into a road-block in hid-core, and solving it with this patch, we
>>>> thought it was good to show the community and see if this is okay,=
 or
>>>> if there's a better solution that we've missed.
>>>>
>>>> Thanks for your comments,
>>>> -andrew
>>>>
>>>> This patch separates struct hid_device's driver_lock into two. The
>>>> goal is to allow hid device drivers to receive input during their
>>>> probe() function call. This is necessary because some drivers need=
 to
>>>> communicate with the device to determine parameters needed during
>>>> probe (e.g., size of a multi-touch surface).
>>>>
>>>> Historically, three functions used driver_lock:
>>>>
>>>> - hid_device_probe: blocks to acquire lock
>>>> - hid_device_remove: blocks to acquire lock
>>>> - hid_input_report: if locked returns -EBUSY, else acquires lock
>>>>
>>>> This patch adds another lock (driver_input_lock) which is used to
>>>> block input from occurring. The lock behavior is now:
>>>>
>>>> - hid_device_probe: blocks to acq. driver_lock, then driver_input_=
lock
>>>> - hid_device_remove: blocks to acq. driver_lock, then driver_input=
_lock
>>>> - hid_input_report: if driver_input_lock locked returns -EBUSY, el=
se
>>>>   acquires driver_input_lock
>>>>
>>>> This results in no behavior change for existing devices and
>>>> drivers. However, during a probe() function call in a driver, that
>>>> driver may now selectively unlock driver_input_lock to let input
>>>> events come through, then re-lock.
>>>
>>> That is more or less a new approach to release the restriction adde=
d in
>>> commit 4ea5454203d991ec85264f64f89ca8855fce69b0
>>> (HID: Fix race condition between driver core and ll-driver).
>>>
>>> From your suggested change the question could be if releasing the i=
nput
>>> lock should be connected to hw_start() / hw_stop() calls...
>>>
>>> Though connecting those together would certainly require some revie=
w of
>>> existing drivers in order not to reopen the can of worms closed by =
above
>>> mentioned commit.
>>>
>>
>> It is clear that the goal is to make commit
>> 4ea5454203d991ec85264f64f89ca8855fce69b0 less restrictive.
>> The problem is that this commit stops any communication with the
>> device, even configuration communication.
>>
>> Logitech devices use their own protocol on top of the HID standard
>> protocol. For touch devices, this proprietary protocol requires to a=
sk
>> the device for axis ranges, etc...
>>
>> So here, the idea is not to open the can of worm for every hid devic=
es
>> through hw_start() / hw_stop() calls, I think the idea of Andrew is
>> just to allow hid-logitech-dj to get rid of this restriction in some
>> particular circumstances.
>> Consider this as a controlled backdoor of the can of worms :)
>
> The problems I was facing back then when writing the patch was that a
> driver wasn't able to properly set itself up before input events migh=
t
> be received. Hence, I locked down the whole .probe function. We shoul=
d
> make sure that this is guaranteed for all drivers when fixing this as
> most of them silently depend on this behavior.
> Releasing the lock with hw_start() would actually be the most logical
> thing to do, but the implementation is ugly as we would release the
> lock inside of the callback that ought to be protected by the lock.
> Therefore, I didn't do this. Furthermore, it is unclear whether this
> fixes all the race-conditions of all hid-drivers.
>
> The fix you are proposing actually looks pretty nice, although it put=
s
> the burden of locking to the hid-driver instead of the hid-core. So
> every .probe function must go sure that the lock is held when
> returning. This means if you unlock the input-lock, you need to lock
> it before calling return so hid-core can unlock it again. This opens =
a
> small race-condition where the hid-core might drop important
> input-events as input-lock is held during "return". Any ideas here?

Good point. I hadn't considered that some drivers may want to do this.
In the case that probe() is going to fail and return error, it seems
okay to lock the lock within probe() and stop events from coming in,
as this driver will cease to be used anyway. So that leaves us with
the case that a driver's probe() is successful and wants to not
interrupt the flow of incoming events. In that case, the simplest
solution seems like a new return value. Existing code returns 0 on
success or -errno on failure, it seems. Perhaps a return value of 0x1
could signify that the lock has been already unlocked?

-andrew

>
> Regards
> David
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
