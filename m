From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/1] USBHID: correct start/stop cycle
Date: Sun, 02 Nov 2008 11:43:51 +0100
Message-ID: <490D8467.5090206@gmx.de>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com> <alpine.LNX.1.10.0811020000360.29633@jikos.suse.cz> <490CE128.3020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:57980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753378AbYKBKny (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Nov 2008 05:43:54 -0500
In-Reply-To: <490CE128.3020007@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jeroen Roovers <jer@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> On 11/02/2008 12:02 AM, Jiri Kosina wrote:
>> On Sat, 1 Nov 2008, Jiri Slaby wrote:
>>
>>> `stop' left out usbhid->urb* pointers and so the next `start' thought
>>> it needs to allocate nothing and used the memory pointers previously
>>> pointed to. This led to memory corruption and device malfunction.
> [...]
>> could you please verify whether this patch fixes the corruption you were 
>> experiencing?
> 
> btw. this is not expected to fix that, but if it does, the better ;).

I tried the patch and sadly it didn't fixed the parisc bug.

Helge

> This fixes
> echo DEVICE > /sys/bus/hid/drivers/DRIVER/unbind
> echo DEVICE > /sys/bus/hid/drivers/DRIVER/bind
> failures.
> 
> But maybe parisc does something differently than x86 in bus handling so that it
> triggers...
