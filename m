From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Fri, 6 Nov 2009 12:06:41 +0300
Message-ID: <78f5d6bf0911060106q5aa3d309t8746fe59c73672c7@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	<4A03756C.6020703@gmail.com> <78f5d6bf0906041227w3a58bde0u554a3d3336e17fa6@mail.gmail.com>
	<4A2A5D8E.1050309@gmail.com> <78f5d6bf0906082202g359afbcwd8bd58a451f9d034@mail.gmail.com>
	<20090609140949.78d4448a@dxy.sh.intel.com> <78f5d6bf0906110238w6f90331ex3cf8c0fdd44f3354@mail.gmail.com>
	<78f5d6bf0906111311p37620e53scc5ed8a695b5be94@mail.gmail.com>
	<78f5d6bf0907091041o3f8b712cxdc674c9c553a9f4@mail.gmail.com>
	<4A562FC1.60809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34360 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbZKFJG4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Nov 2009 04:06:56 -0500
Received: by bwz27 with SMTP id 27so907573bwz.21
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2009 01:07:01 -0800 (PST)
In-Reply-To: <4A562FC1.60809@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello!

It took some time to get back to forcefeedback debugging for me.

2009/7/9 Anssi Hannula <anssi.hannula@gmail.com>:
> Dmitriy Geels wrote:
>> 2009/6/12 Dmitriy Geels <dmitriy.geels@gmail.com>:
>>> Hmm... first try failed. After running fftest, then ffmvforce got
>>> system hang in virtual machine. X is completely unresponsive. May be
>>> kernel is still alive, have to find out, how to press ctrl-alt-fx in
>>> virtualbox.
>
> You can run "chvt 1" to switch to a virtual console and test there, so
> you can see any kernel errors. IIRC "echo 9 > /proc/sysrq-trigger" makes
> all kernel messages visible on console.
>
>> Bad... Can't get something out of driver with last patch. Running
>> ffmvforce after fftest/ffcstresstest hangs VM after few seconds (looks
>> like some timeout) with 100% cpu load.
>
> That looks like there is some bug in the code, then.
> The last patch added a 8sec timeout after which the URB is canceled.
>
>> May be it's possible to get logs via serial cable, but will they
>> contain something useful?
>
> Possibly. Alternatively you can do as above with virtualbox.

Remember your last patches with hid_urb_timeout()?
I got kernel panic log after test: http://paste.org.ru/index.pl?fucaex
Looks like something bad happen inside usb_unlink_urb(hid_urb);
