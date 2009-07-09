From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Thu, 09 Jul 2009 20:58:25 +0300
Message-ID: <4A562FC1.60809@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com> 	<78f5d6bf0903091208i71aadc0od7b89ab9a4037b4d@mail.gmail.com> 	<4A037290.60602@gmail.com> <4A03756C.6020703@gmail.com> <78f5d6bf0906041227w3a58bde0u554a3d3336e17fa6@mail.gmail.com> 	<4A2A5D8E.1050309@gmail.com> <78f5d6bf0906082202g359afbcwd8bd58a451f9d034@mail.gmail.com> 	<20090609140949.78d4448a@dxy.sh.intel.com> <78f5d6bf0906110238w6f90331ex3cf8c0fdd44f3354@mail.gmail.com> 	<78f5d6bf0906111311p37620e53scc5ed8a695b5be94@mail.gmail.com> <78f5d6bf0907091041o3f8b712cxdc674c9c553a9f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:37873 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbZGIR63 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jul 2009 13:58:29 -0400
In-Reply-To: <78f5d6bf0907091041o3f8b712cxdc674c9c553a9f4@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitriy Geels wrote:
> 2009/6/12 Dmitriy Geels <dmitriy.geels@gmail.com>:
>> Hmm... first try failed. After running fftest, then ffmvforce got
>> system hang in virtual machine. X is completely unresponsive. May be
>> kernel is still alive, have to find out, how to press ctrl-alt-fx in
>> virtualbox.

You can run "chvt 1" to switch to a virtual console and test there, so
you can see any kernel errors. IIRC "echo 9 > /proc/sysrq-trigger" makes
all kernel messages visible on console.

> Bad... Can't get something out of driver with last patch. Running
> ffmvforce after fftest/ffcstresstest hangs VM after few seconds (looks
> like some timeout) with 100% cpu load.

That looks like there is some bug in the code, then.
The last patch added a 8sec timeout after which the URB is canceled.

> May be it's possible to get logs via serial cable, but will they
> contain something useful?

Possibly. Alternatively you can do as above with virtualbox.

-- 
Anssi Hannula
