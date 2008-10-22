From: "Phil Endecott" <phil_dubhl_endecott@chezphil.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Thu, 23 Oct 2008 00:07:07 +0100
Message-ID: <1224716827443@dmwebmail.dmwebmail.chezphil.org>
References: <1224062368151@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:5313 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbYJVXHJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Oct 2008 19:07:09 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_dubhl_endecott@chezphil.org>)
	id 1KsmnE-0007yj-95
	for linux-input@vger.kernel.org; Thu, 23 Oct 2008 00:07:08 +0100
In-Reply-To: <1224062368151@dmwebmail.dmwebmail.chezphil.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Phil Endecott wrote:
> Arjan van de Ven wrote:
>> On Wed, 15 Oct 2008 00:17:29 +0100
>> "Phil Endecott" <phil_dubhl_endecott@chezphil.org> wrote:
>>
>>> 
>>> It looks to me as if uhci holds some lock that 8250 needs before it
>>> can complete.  Now those are both PCI drivers in the same way that
>>> the last two that seemed to contend were both input drivers (touchpad
>>> and speaker) [hmm, except that as Dmitry pointed out there's a
>>> distinction between the platform bus and the serio bus].  Anyway, my
>>> ignorant suspicion is that there's some lock related to the bus or
>>> subsystem that they both need.  Maybe something in sysfs?
>>
>> it does do this. And I know which lock... and I fixed it ;)
>> Just the patch for this is in Gregkh's tree since it's a change to the
>> device/sysfs layer and he wanted to carry it via that way.
>>
>> I can dig that patch out if you want
>
> Yes please!

Google eventually found this for me:
   http://thread.gmane.org/gmane.linux.usb.general/9923

I presume that this is what Arjan was referring to.  It causes the 
device-to-driver matching loop to not take the device lock unless the 
match function succeeds.  In my case, the need to take this look was 
preventing the pcspkr initialisation from terminating until the mouse 
initialisation was done, even though the mouse initialisation is in a 
different thread, because the pcspkr init wanted to lock the mouse to 
check if it was actually a speaker.

Fixing it has halved my boot time.


Phil.



