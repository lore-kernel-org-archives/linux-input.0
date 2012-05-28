From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [-next regression] USB keyboard stops working occasionally
Date: Mon, 28 May 2012 17:41:47 +0200
Message-ID: <4FC39CBB.3040204@suse.cz>
References: <4FB81BF9.7040705@suse.cz> <20120519223903.GA12572@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50234 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab2E1Plw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 May 2012 11:41:52 -0400
In-Reply-To: <20120519223903.GA12572@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On 05/20/2012 12:39 AM, Greg Kroah-Hartman wrote:
> On Sun, May 20, 2012 at 12:17:29AM +0200, Jiri Slaby wrote:
>> Hi,
>>
>> sometimes, in the middle of writing, my USB HID keyboard stops sending
>> interrupts (no changes in /proc/interrupts). I have to hit a key on
>> another USB interface of that keyboard to resurrect the other. It
>> happens once or twice a day. It happens with -next since around Friday 4th.
>>
>> I tried to bisect it a bit (three or four times because of fuzz) in the
>> past 3 weeks and my suspect number one is currently:
>> commit 3d9545cc375d117554a9b35dfddadf9189c62775
>> Author: Alan Stern <stern@rowland.harvard.edu>
>> Date:   Mon Apr 23 13:54:36 2012 -0400
>>
>>     EHCI: maintain the ehci->command value properly
>>
>> ===
>>
>> I'm currently running on -next 20120518 with that commit reverted for
>> one whole day and the issue seems to be gone.
>>
>> Could you take a look and double-check that commit? (Or do you have any
>> other ideas where to take a look?)
> 
> Yes, we realized this a few days ago, and I committed a fix for this a
> few hours ago to the usb-next tree, and should show up in the next -next
> release.
> 
> I've included the patch below that should fix this problem, please let
> me know if it doesn't for you.

FWIW after running the kernel a couple of days without a glitch I can
conclude that it is fixed now.

thanks,
-- 
js
suse labs

