From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Tue, 17 Feb 2009 15:16:52 +0300
Message-ID: <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>
	 <4992FC79.80106@gmail.com>
	 <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>
	 <49946D7A.408@gmail.com>
	 <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>
	 <4995CD44.5000808@gmail.com>
	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>
	 <49972478.3060207@gmail.com>
	 <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:15077 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZBQMQy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2009 07:16:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so393763fgg.17
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2009 04:16:52 -0800 (PST)
In-Reply-To: <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

>>>> Notice the difference in length of report 22 on windows and linux. Try
>>>> this in pidff_init():
>>>> pidff->reports[PID_BLOCK_LOAD]->size += 8;
>>> That's it!
>>> I didn't pay attention to length value. Looks like a missing usage in
>>> report descriptor!
>>> So, quirk with report fix is needed for this device.
I'm trying to understand better way to make this descriptor fix. Can
you give me an advice on this?
Or it's better to wait for patch discussed in "Allow drivers to
replace report descriptors" topic?

>> Hmm, this says problems start with "fftest".
>> [10054.751832] HID: implement() called with too large value 47113! (fftest)
>>
>> Could you print all the values set in pidff_set_effect_report() just
>> before the usbhid_submit_report() call, and try to reproduce the WARNING
>> with fftest.
Problem in fftest is simple: using uninitialized structures. That also
was causing slow path warning.
But running ffmvforce after fftest brings device to unconsistent
state, causing messages "usb 1-1: ctrl urb status -62 received".
