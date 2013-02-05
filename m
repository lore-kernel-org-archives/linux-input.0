From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Tue, 5 Feb 2013 17:19:37 +0100
Message-ID: <CAE7qMroHOK2TJnUK6wdf7YCK6FTQPmxTKJ=SM_gz0b3fuzf2TA@mail.gmail.com>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
 <20121126185627.7bff1f84@neptune.home> <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
 <alpine.LNX.2.00.1212031416010.27624@pobox.suse.cz> <CAE7qMrrpe+o3-DmRsgxEjc3e5kUUhNZ8ZkkrDrc4fzHJX2T53Q@mail.gmail.com>
 <alpine.LNX.2.00.1302051607130.2260@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54694 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756381Ab3BEQVk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Feb 2013 11:21:40 -0500
Received: by mail-oa0-f72.google.com with SMTP id j6so1553296oag.7
        for <linux-input@vger.kernel.org>; Tue, 05 Feb 2013 08:20:07 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1302051607130.2260@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, Linux Input <linux-input@vger.kernel.org>, David Herrmann <dh.herrmann@googlemail.com>

Hi Jiri,

Andrew has been progressing on a patchset that he will soon post.

for info: https://github.com/adlr/linux/commits/logitech6

I've been following his updates to hid-logitech-dj as well as
hid-logitech-wtp. We will soon get back to you.

Thanks for asking!

Cheers,
Nestor

On Tue, Feb 5, 2013 at 4:07 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 3 Dec 2012, Nestor Lopez Casado wrote:
>
>> >> It is clear that the goal is to make commit
>> >> 4ea5454203d991ec85264f64f89ca8855fce69b0 less restrictive.
>> >> The problem is that this commit stops any communication with the
>> >> device, even configuration communication.
>> >>
>> >> Logitech devices use their own protocol on top of the HID standard
>> >> protocol. For touch devices, this proprietary protocol requires to ask
>> >> the device for axis ranges, etc...
>> >>
>> >> So here, the idea is not to open the can of worm for every hid devices
>> >> through hw_start() / hw_stop() calls, I think the idea of Andrew is
>> >> just to allow hid-logitech-dj to get rid of this restriction in some
>> >> particular circumstances.
>> >> Consider this as a controlled backdoor of the can of worms :)
>> >
>> > I have been thinking for this for a while, and I wasn't able to come up
>> > with anything I'd personally consider substantially better aproach than
>> > splitting the lock. So I don't have strong objections at the very moment.
>> >
>> > This will also allow us to get rid of what commit 596264082f introduced in
>> > unifying driver, right? (adding Nestor to CC).
>>
>> That is correct. Moreover, we are planning additional changes to
>> hid-logitech-dj that will somehow revert that commit. As Andrew
>> mentioned earlier, the drivers for Unifying devices need to query
>> several parameters during their probe() execution, and besides this
>> lock issue, there is still another problem with the current
>> hid-logitech-dj strategy.  Unifying devices can only be queried when
>> the radio link is active, and as such, we are planning to postpone
>> calling hid_add_device() until we are sure that the device has an
>> active radio link.
>>
>> With both issues resolved, the path will be clear to add native
>> multitouch support for several Unifying devices like t650, t620 and
>> t400.
>
> Nestor,
>
> is there anything happening in this area, please?
>
> --
> Jiri Kosina
> SUSE Labs
