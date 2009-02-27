From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Fri, 27 Feb 2009 18:24:43 +0200
Message-ID: <49A813CB.3080805@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>	 <4995CD44.5000808@gmail.com>	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>	 <49972478.3060207@gmail.com>	 <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>	 <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>	 <499C2D22.8020005@gmail.com>	 <78f5d6bf0902182254v191cc485x62eb211baaddd36@mail.gmail.com>	 <499D7C66.6090000@gmail.com> <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:43555 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbZB0QYs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 11:24:48 -0500
In-Reply-To: <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> 2009/2/19 Anssi Hannula <anssi.hannula@gmail.com>
>> Dmitriy Geels wrote:
>>> Yes. That's the problem.
>>> Exactly this sequence: run fftest, play all effects, then run
>>> ffmvforce. ffmvforce itself is working well.
>> Could you provide the log with fixed fftest+ffmvforce?
> 
> Sorry for making you waiting so long, here is it:
> http://paste.org.ru/index.pl?p584s9
> 
> Nothing special -- running fftest, playing 0, 1, 2, 3, 4, 5 (2 and 3
> does nothing), then -1, then run ffmvforce, click somewhere inside
> it's window -- then first "pid_block_load requested" appears, after
> "pid_block_load failed 20 times" (I decreased retries counter)
> ffmvforce continues to work, but ioctl() call always return -1
> 
> That's all. Running fftest again repeats "pid_block_load requested"
> scenario. Device (or driver?) stuck.

These seem strange:
[ 5108.143241] usbhid:hid-pidff: create_new_effect sent, type: 4
[ 5108.161645] usbhid:hid-pidff: create_new_effect sent, type: 1
[ 5108.251905] usbhid:hid-pidff: create_new_effect sent, type: 4
[ 5108.338133] usbhid:hid-pidff: create_new_effect sent, type: 4

Type 4 means FF_SINE for your device. However, fftest does test only one
FF_SINE effect. Have you altered fftest? If not, could you post the
output of fftest?

-- 
Anssi Hannula
