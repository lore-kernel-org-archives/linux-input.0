From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Tue, 3 Mar 2009 21:35:12 +0300
Message-ID: <78f5d6bf0903031035r44a9c655n2cb0408ddf10d7d1@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>
	 <499C2D22.8020005@gmail.com>
	 <78f5d6bf0902182254v191cc485x62eb211baaddd36@mail.gmail.com>
	 <499D7C66.6090000@gmail.com>
	 <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>
	 <49A813CB.3080805@gmail.com>
	 <78f5d6bf0903021041o24155b7dg89a5fb975e60c320@mail.gmail.com>
	 <49AC4300.5090002@gmail.com>
	 <78f5d6bf0903022228l30c53db1k5d51ed7aeeb76e51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:32833 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbZCCSfP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 13:35:15 -0500
Received: by fxm24 with SMTP id 24so2564454fxm.37
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2009 10:35:12 -0800 (PST)
In-Reply-To: <78f5d6bf0903022228l30c53db1k5d51ed7aeeb76e51@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

2009/3/3 Dmitriy Geels <dmitriy.geels@gmail.com>:
>> What about running fftest two times in succession, or just ffmvforce two
>> times in succession, does it trigger the problem?
> Tried already. No problem. Same with ffmvforce.
I was wrong: running ffmvforce twice leads to stuck device. There
should be some initialization/deinitialization problem in it.

>> Also, try removing some effects from fftest one-by-one, and see if the
>> problem is still triggered.
> Will try this later, this evening.
ffmvforce gets stuck after any effect played in fftest.

Here is it's source, may be you'll see the problem:
http://paste.org.ru/index.pl?s8x9x5
