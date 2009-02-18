From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Wed, 18 Feb 2009 17:45:38 +0200
Message-ID: <499C2D22.8020005@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>	 <4992FC79.80106@gmail.com>	 <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>	 <49946D7A.408@gmail.com>	 <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>	 <4995CD44.5000808@gmail.com>	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>	 <49972478.3060207@gmail.com>	 <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com> <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:47082 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbZBRPps (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2009 10:45:48 -0500
In-Reply-To: <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Dmitriy Geels wrote:
>>>>> Notice the difference in length of report 22 on windows and linux. Try
>>>>> this in pidff_init():
>>>>> pidff->reports[PID_BLOCK_LOAD]->size += 8;
>>>> That's it!
>>>> I didn't pay attention to length value. Looks like a missing usage in
>>>> report descriptor!
>>>> So, quirk with report fix is needed for this device.
> I'm trying to understand better way to make this descriptor fix. Can
> you give me an advice on this?
> Or it's better to wait for patch discussed in "Allow drivers to
> replace report descriptors" topic?

I see there are two options:
a) Add a device-specific quirk in pidff_init(), or
b) Add hid-saitek.c that does the adjustment.

Jiri (CCd, HID maintainer), WDYT?

>>> Hmm, this says problems start with "fftest".
>>> [10054.751832] HID: implement() called with too large value 47113! (fftest)
>>>
>>> Could you print all the values set in pidff_set_effect_report() just
>>> before the usbhid_submit_report() call, and try to reproduce the WARNING
>>> with fftest.
> Problem in fftest is simple: using uninitialized structures. That also
> was causing slow path warning.
> But running ffmvforce after fftest brings device to unconsistent
> state, causing messages "usb 1-1: ctrl urb status -62 received".

Does this happen also with fixed fftest?

Of course hid-pidff should also check the values provided, I'll fix this 
as well.

I'll try to provide the discussed patch(es) next weekend.

-- 
Anssi Hannula

