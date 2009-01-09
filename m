From: Parag Warudkar <parag.lkml@gmail.com>
Subject: Re: 2.6.28-rc9: USB Mouse unhappy
Date: Fri, 9 Jan 2009 18:18:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091816200.21215@localhost.localdomain>
References: <f7848160812201911k7988221asd095ce873fd8105f@mail.gmail.com> <alpine.LRH.1.10.0812211824350.11630@twin.jikos.cz> <alpine.LRH.1.10.0812211939170.11630@twin.jikos.cz> <200901100011.35332.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:43422 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400AbZAIXS4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2009 18:18:56 -0500
In-Reply-To: <200901100011.35332.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, Parag Warudkar <parag.lkml@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org



On Sat, 10 Jan 2009, Rafael J. Wysocki wrote:

> Hi,
>
> On Sunday 21 December 2008, Jiri Kosina wrote:
>> On Sun, 21 Dec 2008, Jiri Kosina wrote:
>>
>>>   usbmouse on 2.6.28-rc with the exact same mouse? (either check
>>>   /sys/bus/usb/devices or even lsusb shouldn't ideally show usbmouse
>>>   loaded at all)
>>
>> Sorry for the above typo, 'lsusb' should of course be 'lsmod' here.
>
> Can you tell me what the status of this issue is, please?
>

Wasn't a regression - for some reason USB Boot Protocol drivers for 
mouse and kbd were compiled and loaded - I sent a patch to Jiri making 
those depend on EMBEDDED - so no more an issue.

Thanks
Parag
