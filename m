From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Fri, 27 Feb 2009 00:21:22 +0300
Message-ID: <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <78f5d6bf0902130033k7d0089cfo857bb48a19da1630@mail.gmail.com>
	 <4995CD44.5000808@gmail.com>
	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>
	 <49972478.3060207@gmail.com>
	 <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>
	 <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>
	 <499C2D22.8020005@gmail.com>
	 <78f5d6bf0902182254v191cc485x62eb211baaddd36@mail.gmail.com>
	 <499D7C66.6090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:61381 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbZBZVVZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2009 16:21:25 -0500
Received: by bwz26 with SMTP id 26so724826bwz.37
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2009 13:21:22 -0800 (PST)
In-Reply-To: <499D7C66.6090000@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

2009/2/19 Anssi Hannula <anssi.hannula@gmail.com>
>
> Dmitriy Geels wrote:
>>
>> Yes. That's the problem.
>> Exactly this sequence: run fftest, play all effects, then run
>> ffmvforce. ffmvforce itself is working well.
>
> Could you provide the log with fixed fftest+ffmvforce?

Sorry for making you waiting so long, here is it:
http://paste.org.ru/index.pl?p584s9

Nothing special -- running fftest, playing 0, 1, 2, 3, 4, 5 (2 and 3
does nothing), then -1, then run ffmvforce, click somewhere inside
it's window -- then first "pid_block_load requested" appears, after
"pid_block_load failed 20 times" (I decreased retries counter)
ffmvforce continues to work, but ioctl() call always return -1

That's all. Running fftest again repeats "pid_block_load requested"
scenario. Device (or driver?) stuck.
