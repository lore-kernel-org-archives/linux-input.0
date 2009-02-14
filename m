From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Sun, 15 Feb 2009 01:33:27 +0300
Message-ID: <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <4991A622.7020101@gmail.com>
	 <78f5d6bf0902110112o434d43d3ycd473c7b803e8297@mail.gmail.com>
	 <4992FC79.80106@gmail.com>
	 <78f5d6bf0902121006r460ba8d6m61126af161358c19@mail.gmail.com>
	 <49946D7A.408@gmail.com>
	 <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>
	 <4995CD44.5000808@gmail.com>
	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>
	 <49972478.3060207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:22314 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZBNWd3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2009 17:33:29 -0500
Received: by fg-out-1718.google.com with SMTP id 16so82589fgg.17
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2009 14:33:27 -0800 (PST)
In-Reply-To: <49972478.3060207@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

2009/2/14 Anssi Hannula <anssi.hannula@gmail.com>:
>>>> For periodic effects it controls every period, as I understood.
>>> That is not supposed to be the case and seems very strange. Can you
>>> confirm this (maybe after we get it working on linux)?
>> I just admitted that.
> How did you test it?
I didn't. I just supposed, that it should be so.

>>>>> 2) Reports 21+22 are transmitted as control transfers in the dump. I'll have
>>>>> to check whether we are doing the same.
>>>> We do: http://paste.org.ru/index.pl?iyvkmg
>>>> Got this log with patch: http://paste.org.ru/index.pl?m4wauv
>>> Notice the difference in length of report 22 on windows and linux. Try
>>> this in pidff_init():
>>> pidff->reports[PID_BLOCK_LOAD]->size += 8;
>> That's it!
>> I didn't pay attention to length value. Looks like a missing usage in
>> report descriptor!
>> So, quirk with report fix is needed for this device.
>>
>> Also i found one strange thing: ffmvforce utility brings driver to
>> inconsistent state. http://paste.org.ru/index.pl?1ajtxt
>>
>
> Hmm, this says problems start with "fftest".
> [10054.751832] HID: implement() called with too large value 47113! (fftest)
>
> Could you print all the values set in pidff_set_effect_report() just
> before the usbhid_submit_report() call, and try to reproduce the WARNING
> with fftest.
Got it: http://paste.org.ru/index.pl?fv7wss
Then after launching ffmvforce: http://paste.org.ru/index.pl?3pdotg
