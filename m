From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] USBHID: correct start/stop cycle
Date: Sun, 02 Nov 2008 11:55:57 +0100
Message-ID: <490D873D.9010005@gmail.com>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com> <alpine.LNX.1.10.0811020000360.29633@jikos.suse.cz> <490CE128.3020007@gmail.com> <490D8467.5090206@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753961AbYKBK4W@vger.kernel.org>
In-Reply-To: <490D8467.5090206@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Jeroen Roovers <jer@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Helge Deller napsal(a):
> Jiri Slaby wrote:
>> On 11/02/2008 12:02 AM, Jiri Kosina wrote:
>>> On Sat, 1 Nov 2008, Jiri Slaby wrote:
>>>
>>>> `stop' left out usbhid->urb* pointers and so the next `start' thought
>>>> it needs to allocate nothing and used the memory pointers previously
>>>> pointed to. This led to memory corruption and device malfunction.
>> [...]
>>> could you please verify whether this patch fixes the corruption you
>>> were experiencing?
>>
>> btw. this is not expected to fix that, but if it does, the better ;).
> 
> I tried the patch and sadly it didn't fixed the parisc bug.

Could you bisect it?
