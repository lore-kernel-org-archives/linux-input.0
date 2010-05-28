From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc6
Date: Thu, 27 May 2010 18:03:00 -0700
Message-ID: <4B59D6F4-825C-4851-929F-DCA28A343B23@gmail.com>
References: <20100513075728.GF30110@core.coreip.homeip.net> <alpine.LFD.2.00.1005130724280.3711@i5.linux-foundation.org> <20100513160117.GB22238@core.coreip.homeip.net> <alpine.LFD.2.00.1005130943460.3711@i5.linux-foundation.org> <4BFE0FAB.9040009@gmail.com> <alpine.LFD.2.00.1005270956380.3689@i5.linux-foundation.org> <AANLkTimkI2rLOO2vaPFBQUbzr5t0pAQGQ5R5noTOBp4K@mail.gmail.com> <alpine.LFD.2.00.1005271744410.11382@i5.linux-foundation.org>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52643 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab0E1BDP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 May 2010 21:03:15 -0400
In-Reply-To: <alpine.LFD.2.00.1005271744410.11382@i5.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>

On May 27, 2010, at 5:46 PM, Linus Torvalds <torvalds@linux-foundation.org 
 > wrote:

>
>
> On Thu, 27 May 2010, Robert Hancock wrote:
>>
>> It's highly unlikely that they are incomplete in this respect, as
>> since I mentioned, Windows would fail to recognize the PS/2  
>> controller
>> that people would expect to work, which would most likely get
>> noticed..
>
> Did you miss the part where I actually quoted my own modern Core i5
> machine that _does_ have a keyboard controller, and _does_ have a  
> keyboard
> port, and that does _not_ mention them in the PnP tables?

Except that it _does_. But _our_ ACPI implementation drops all  
inactive devices so our PNP layer does not see your mouse and keyboard  
ports.


>
>> I think this is a case where it has to be trusted, because that's  
>> what
>> Windows does.
>
> The thing is, Windows isn't used for things like headless machines.  
> Which
> we went over extensively in the thread. There's a _reason_ why Linux
> probes the dang thing.


-- 
Dmitry


