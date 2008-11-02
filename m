From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 1/1] USBHID: correct start/stop cycle
Date: Sun, 02 Nov 2008 17:50:49 +0100
Message-ID: <490DDA69.4000404@gmx.de>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com> <alpine.LNX.1.10.0811020000360.29633@jikos.suse.cz> <490CE128.3020007@gmail.com> <490D8467.5090206@gmx.de> <490D873D.9010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:52918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753688AbYKBQux (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Nov 2008 11:50:53 -0500
In-Reply-To: <490D873D.9010005@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, Denys Vlasenko <vda.linux@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Jeroen Roovers <jer@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Helge Deller napsal(a):
>> Jiri Slaby wrote:
>>> On 11/02/2008 12:02 AM, Jiri Kosina wrote:
>>>> On Sat, 1 Nov 2008, Jiri Slaby wrote:
>>>>
>>>>> `stop' left out usbhid->urb* pointers and so the next `start' thought
>>>>> it needs to allocate nothing and used the memory pointers previously
>>>>> pointed to. This led to memory corruption and device malfunction.
>>> [...]
>>>> could you please verify whether this patch fixes the corruption you
>>>> were experiencing?
>>> btw. this is not expected to fix that, but if it does, the better ;).
>> I tried the patch and sadly it didn't fixed the parisc bug.
> 
> Could you bisect it?

I fully bisected it, and the final "buggy" patch seems to have been 
Denys Vlasenko's patch: cb8f488c33539f096580e202f5438a809195008f
(see 
http://github.com/jonsmirl/digispeaker/commit/cb8f488c33539f096580e202f5438a809195008f)
Denys: Any reason you removed "!prev" in front of "expand_stack" ? It 
seems wrong to remove the prev-check, else it would crash in 
expand_upwards(in the CONFIG_STACK_GROWSUP case).
This is parisc architecture (stack grows up, big-endian).

Sadly reverting just this patch, didn't fixed the bugzilla bug either: 
http://bugzilla.kernel.org/show_bug.cgi?id=11913
I think I need to redo all of my bisecting again... sigh...

Helge
