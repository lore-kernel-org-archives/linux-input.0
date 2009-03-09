From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Mon, 9 Mar 2009 22:08:00 +0300
Message-ID: <78f5d6bf0903091208i71aadc0od7b89ab9a4037b4d@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <78f5d6bf0902261321m62b423c6hed04c693e03f569e@mail.gmail.com>
	 <49A813CB.3080805@gmail.com>
	 <78f5d6bf0903021041o24155b7dg89a5fb975e60c320@mail.gmail.com>
	 <49AC4300.5090002@gmail.com>
	 <78f5d6bf0903022228l30c53db1k5d51ed7aeeb76e51@mail.gmail.com>
	 <78f5d6bf0903031035r44a9c655n2cb0408ddf10d7d1@mail.gmail.com>
	 <49B286EB.8000300@gmail.com>
	 <78f5d6bf0903072118i19bc91a0taa4a5bda0fb19bf6@mail.gmail.com>
	 <49B39B15.6060609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:55495 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZCITIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2009 15:08:04 -0400
Received: by fxm24 with SMTP id 24so1371239fxm.37
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2009 12:08:00 -0700 (PDT)
In-Reply-To: <49B39B15.6060609@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

2009/3/8 Anssi Hannula <anssi.hannula@gmail.com>:
> Dmitriy Geels wrote:
>> 2009/3/7 Anssi Hannula <anssi.hannula@gmail.com>:
>>> Provide the kernel log again, this time with debug=2 set for hid module
>>> and having run "fftest" with only one effect and then "ffmvforce".
>> here is it: http://paste.org.ru/index.pl?4bwah8
>
> Apply attached patch that adds more debug output and try this again.
Here is log: http://paste.org.ru/index.pl?0mtjuz
