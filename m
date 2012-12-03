From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Mon, 3 Dec 2012 09:53:56 -0800
Message-ID: <CAE7qMrrpe+o3-DmRsgxEjc3e5kUUhNZ8ZkkrDrc4fzHJX2T53Q@mail.gmail.com>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com>
 <20121126185627.7bff1f84@neptune.home> <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
 <alpine.LNX.2.00.1212031416010.27624@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:41401 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111Ab2LCRyc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Dec 2012 12:54:32 -0500
Received: by mail-oa0-f70.google.com with SMTP id k14so14186248oag.1
        for <linux-input@vger.kernel.org>; Mon, 03 Dec 2012 09:54:27 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1212031416010.27624@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, Linux Input <linux-input@vger.kernel.org>, David Herrmann <dh.herrmann@googlemail.com>

No html now ...
Cheers,
Nestor

On Mon, Dec 3, 2012 at 5:17 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 26 Nov 2012, Benjamin Tissoires wrote:
>
>> It is clear that the goal is to make commit
>> 4ea5454203d991ec85264f64f89ca8855fce69b0 less restrictive.
>> The problem is that this commit stops any communication with the
>> device, even configuration communication.
>>
>> Logitech devices use their own protocol on top of the HID standard
>> protocol. For touch devices, this proprietary protocol requires to ask
>> the device for axis ranges, etc...
>>
>> So here, the idea is not to open the can of worm for every hid devices
>> through hw_start() / hw_stop() calls, I think the idea of Andrew is
>> just to allow hid-logitech-dj to get rid of this restriction in some
>> particular circumstances.
>> Consider this as a controlled backdoor of the can of worms :)
>
> I have been thinking for this for a while, and I wasn't able to come up
> with anything I'd personally consider substantially better aproach than
> splitting the lock. So I don't have strong objections at the very moment.
>
> This will also allow us to get rid of what commit 596264082f introduced in
> unifying driver, right? (adding Nestor to CC).

That is correct. Moreover, we are planning additional changes to
hid-logitech-dj that will somehow revert that commit. As Andrew
mentioned earlier, the drivers for Unifying devices need to query
several parameters during their probe() execution, and besides this
lock issue, there is still another problem with the current
hid-logitech-dj strategy.  Unifying devices can only be queried when
the radio link is active, and as such, we are planning to postpone
calling hid_add_device() until we are sure that the device has an
active radio link.

With both issues resolved, the path will be clear to add native
multitouch support for several Unifying devices like t650, t620 and
t400.

> --
> Jiri Kosina
> SUSE Labs
