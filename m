From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Fri, 12 Jun 2009 00:11:35 +0400
Message-ID: <78f5d6bf0906111311p37620e53scc5ed8a695b5be94@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	<49B39B15.6060609@gmail.com> <78f5d6bf0903091208i71aadc0od7b89ab9a4037b4d@mail.gmail.com>
	<4A037290.60602@gmail.com> <4A03756C.6020703@gmail.com> <78f5d6bf0906041227w3a58bde0u554a3d3336e17fa6@mail.gmail.com>
	<4A2A5D8E.1050309@gmail.com> <78f5d6bf0906082202g359afbcwd8bd58a451f9d034@mail.gmail.com>
	<20090609140949.78d4448a@dxy.sh.intel.com> <78f5d6bf0906110238w6f90331ex3cf8c0fdd44f3354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55637 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbZFKULy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2009 16:11:54 -0400
Received: by bwz9 with SMTP id 9so1699414bwz.37
        for <linux-input@vger.kernel.org>; Thu, 11 Jun 2009 13:11:55 -0700 (PDT)
In-Reply-To: <78f5d6bf0906110238w6f90331ex3cf8c0fdd44f3354@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

2009/6/11 Dmitriy Geels <dmitriy.geels@gmail.com>:
> 2009/6/9 Alek Du <alek.du@intel.com>:
>> Seems your module was not compiled against your running kernel. Are you using the right tree and config?
>
> Just found solution:
> make -C /lib/modules/`uname -r`/build M=drivers/hid/usbhid/
> instead of just make drivers/hid/usbhid/usbhid.ko
>
> Will post test results later.
>

Hmm... first try failed. After running fftest, then ffmvforce got
system hang in virtual machine. X is completely unresponsive. May be
kernel is still alive, have to find out, how to press ctrl-alt-fx in
virtualbox.
