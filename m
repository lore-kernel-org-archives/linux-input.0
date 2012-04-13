From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Baantoo multi-touch screen trouble
Date: Fri, 13 Apr 2012 11:21:22 +0200
Message-ID: <CAN+gG=HBTO4UvEQ1SVMS1sicHbBDaTP83E9cTUm1M3c9KSechA@mail.gmail.com>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk>
	<201204121547.29206.tvrtko.ursulin@onelan.co.uk>
	<CAN+gG=GzVSzQpEV0bFMTn0H_vj+yKHHSZpyL4dBCFTE7To0=-A@mail.gmail.com>
	<201204130902.51885.tvrtko.ursulin@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46023 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132Ab2DMJVX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 05:21:23 -0400
Received: by iagz16 with SMTP id z16so4004887iag.19
        for <linux-input@vger.kernel.org>; Fri, 13 Apr 2012 02:21:22 -0700 (PDT)
In-Reply-To: <201204130902.51885.tvrtko.ursulin@onelan.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi,

Oops, I think I assumed that the features that will come in 3.4 are
already in 3.3... sorry.

Once hid-multitouch is loaded, you have to manually tell him to handle
your device:
# echo 3 2453 0100 0 >
/sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id

That should do the trick.

If it's not working, then we may need the full report descriptors
(without the ** UNAVAILABLE **). You can do that by using the script
there: http://lii-enac.fr/en/architecture/linux-input/multitouch-howto.html#report

Cheers,
Benjamin

On Fri, Apr 13, 2012 at 10:02, Tvrtko Ursulin
<tvrtko.ursulin@onelan.co.uk> wrote:
> On Thursday 12 Apr 2012 17:05:34 Benjamin Tissoires wrote:
>> Hi Tvrtko,
>>
>> I misread your first mail, sorry for that. I did not saw that your
>> device was a Hid one detected as a multitouch one. Under 3.3, just do:
>> $ sudo modprobe hid-multitouch
>>
>> And the device should be handled by hid-multitouch.
>>
>> The 3.3 kernel, detects that your device should be handled by
>> hid-multitouch, but it does not load it automatically. You may add
>> this module in the configuration file.
>
> Unfortunately nothing interesting happened with hid-multitouch loaded. Nonew
> kernel messages, no devices claimed/created.
>
> Are there any tools (couldn't find any) which can probe/analyze this device
> from userspace? Or something that would explain why it works better with
> earlier kernels?
>
> Tvrtko
