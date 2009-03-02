From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Mon, 02 Mar 2009 22:35:12 +0200
Message-ID: <49AC4300.5090002@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <78f5d6bf0902141125m1bf9ac00xb2b414e81d81b869@mail.gmail.com>	 <49972478.3060207@gmail.com>	 <78f5d6bf0902141433hca696fdo87140907cc358fbf@mail.gmail.com>	 <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>	 <499C2D22.8020005@gmail.com>	 <78f5d6bf0902182254v191cc485x62eb211baaddd36@mail.gmail.com>	 <499D7C66.6090000@gmail.com>	 <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>	 <49A813CB.3080805@gmail.com> <78f5d6bf0903021041o24155b7dg89a5fb975e60c320@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:52936 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537AbZCBUfQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 15:35:16 -0500
In-Reply-To: <78f5d6bf0903021041o24155b7dg89a5fb975e60c320@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> 2009/2/27 Anssi Hannula <anssi.hannula@gmail.com>:
>> These seem strange:
>> [ 5108.143241] usbhid:hid-pidff: create_new_effect sent, type: 4
>> [ 5108.161645] usbhid:hid-pidff: create_new_effect sent, type: 1
>> [ 5108.251905] usbhid:hid-pidff: create_new_effect sent, type: 4
>> [ 5108.338133] usbhid:hid-pidff: create_new_effect sent, type: 4
>>
>> Type 4 means FF_SINE for your device. However, fftest does test only one
>> FF_SINE effect. Have you altered fftest? If not, could you post the
>> output of fftest?
> No i didn't, fftest plays 4 different effect types, of which only 2
> are supported,
> Here is output: http://paste.org.ru/index.pl?jc3999
> Here is source of this fftest: http://paste.org.ru/index.pl?jjkw01

Oh, right, FF_RUMBLE is mapped to FF_PERIODIC by default. I have a local
patch for your device that maps it to FF_CONSTANT, that's why I was
confused.

So that wasn't the issue.

What about running fftest two times in succession, or just ffmvforce two
times in succession, does it trigger the problem?

Also, try removing some effects from fftest one-by-one, and see if the
problem is still triggered.

-- 
Anssi Hannula
