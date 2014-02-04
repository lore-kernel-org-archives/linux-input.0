From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: hidp: make sure input buffers are big enough
Date: Tue, 4 Feb 2014 08:39:18 -0800
Message-ID: <20573666-E2A0-4D6B-986A-09DAFC0FB64B@holtmann.org>
References: <1387451372-6881-1-git-send-email-dh.herrmann@gmail.com> <3109C2D8-E01C-4728-A593-1978BB3D202D@holtmann.org> <CANq1E4TOHvb3--H6SoRhB09sUwuYkrvSAXCNN2Y0PaVSOEte=w@mail.gmail.com> <alpine.LNX.2.00.1401071308020.4962@pobox.suse.cz> <CANq1E4SxrDnbOCsohZXYoYL-HQjEc-xcOnXfAm=npHG2QfMS9A@mail.gmail.com> <alpine.LNX.2.00.1401071811530.4962@pobox.suse.cz> <alpine.LNX.2.00.1401282152140.22492@pobox.suse.cz> <CANq1E4TW+GU=oaW0tXb=Tun9HMtr26u-PC3H6BsLot560ANgog@mail.gmail.com> <alpine.LNX.2.00.1402031107310.14066@pobox.suse.cz> <CANq1E4S++uqMzQue_0jC3N=Lm8Os5V-48Hw5M4vWvM+2Vx91yA@mail.gmail.com> <alpine.LNX.2.00.1402041446130.14066@pobox.suse.cz>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:54586 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbaBDQjY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 11:39:24 -0500
In-Reply-To: <alpine.LNX.2.00.1402041446130.14066@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>

Hi Jiri,

>>>>>> Due to various reasons I will not have access to any testing HW for the
>>>>>> upcoming 2-3 days, so if you can cook something up in that timeframe, it'd
>>>>>> be appreciated.
>>>>>> 
>>>>>> Otherwise I'll be working on it by the end of this week.
>>>>> 
>>>>> David,
>>>>> 
>>>>> just got back to this, finally ... did you have time to work on this at
>>>>> all, or should I just start from scratch?
>>>> 
>>>> Sorry, no. Fosdem is this weekend and I needed to get my code ready
>>>> for that. But I'll finally have time again next week.
>>> 
>>> Okay, thanks. I then guess we should proceed with this bandaid (double
>>> allocation) for 3.14
>> 
>> It would be really nice if we could get the HIDP patch into 3.14-rc2
>> and backported to stable. There have been quite a bunch of reports now
>> and I dislike adding a GFP_ATOMIC allocation in HID core. 
> 
> I agree with David; Gustavo, what is your take on this, please?

I leave this up to Gustavo to get this into wireless tree for 3.14-rc2.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

