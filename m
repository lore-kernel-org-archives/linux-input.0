From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Sat, 07 Mar 2009 16:38:35 +0200
Message-ID: <49B286EB.8000300@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <78f5d6bf0902170416j39cced63i23a712c754fd4445@mail.gmail.com>	 <499C2D22.8020005@gmail.com>	 <78f5d6bf0902182254v191cc485x62eb211baaddd36@mail.gmail.com>	 <499D7C66.6090000@gmail.com>	 <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>	 <49A813CB.3080805@gmail.com>	 <78f5d6bf0903021041o24155b7dg89a5fb975e60c320@mail.gmail.com>	 <49AC4300.5090002@gmail.com>	 <78f5d6bf0903022228l30c53db1k5d51ed7aeeb76e51@mail.gmail.com> <78f5d6bf0903031035r44a9c655n2cb0408ddf10d7d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:38269 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983AbZCGOij (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Mar 2009 09:38:39 -0500
In-Reply-To: <78f5d6bf0903031035r44a9c655n2cb0408ddf10d7d1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitriy Geels wrote:
> 2009/3/3 Dmitriy Geels <dmitriy.geels@gmail.com>:
>>> What about running fftest two times in succession, or just ffmvforce two
>>> times in succession, does it trigger the problem?
>> Tried already. No problem. Same with ffmvforce.
> I was wrong: running ffmvforce twice leads to stuck device. There
> should be some initialization/deinitialization problem in it.
> 
>>> Also, try removing some effects from fftest one-by-one, and see if the
>>> problem is still triggered.
>> Will try this later, this evening.
> ffmvforce gets stuck after any effect played in fftest.

Does this mean it does not get stuck if you start fftest but do not play
any effects?

> Here is it's source, may be you'll see the problem:
> http://paste.org.ru/index.pl?s8x9x5

Provide the kernel log again, this time with debug=2 set for hid module
and having run "fftest" with only one effect and then "ffmvforce".

-- 
Anssi Hannula
