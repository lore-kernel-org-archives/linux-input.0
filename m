From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Sun, 8 Mar 2009 08:18:39 +0300
Message-ID: <78f5d6bf0903072118i19bc91a0taa4a5bda0fb19bf6@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <78f5d6bf0902182254v191cc485x62eb211baaddd36@mail.gmail.com>
	 <499D7C66.6090000@gmail.com>
	 <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>
	 <49A813CB.3080805@gmail.com>
	 <78f5d6bf0903021041o24155b7dg89a5fb975e60c320@mail.gmail.com>
	 <49AC4300.5090002@gmail.com>
	 <78f5d6bf0903022228l30c53db1k5d51ed7aeeb76e51@mail.gmail.com>
	 <78f5d6bf0903031035r44a9c655n2cb0408ddf10d7d1@mail.gmail.com>
	 <49B286EB.8000300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:58496 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZCHFSl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Mar 2009 00:18:41 -0500
Received: by fg-out-1718.google.com with SMTP id 16so688063fgg.17
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2009 21:18:39 -0800 (PST)
In-Reply-To: <49B286EB.8000300@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

2009/3/7 Anssi Hannula <anssi.hannula@gmail.com>:
> Dmitriy Geels wrote:
>> ffmvforce gets stuck after any effect played in fftest.
>
> Does this mean it does not get stuck if you start fftest but do not play
> any effects?
No problem is reproduced in this case also. Looks like, problem is
caused by effect loading in fftest.
this case: http://paste.org.ru/index.pl?cjl2b8

>> Here is it's source, may be you'll see the problem:
>> http://paste.org.ru/index.pl?s8x9x5
>
> Provide the kernel log again, this time with debug=2 set for hid module
> and having run "fftest" with only one effect and then "ffmvforce".
here is it: http://paste.org.ru/index.pl?4bwah8
