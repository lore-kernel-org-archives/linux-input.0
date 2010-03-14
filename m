From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [patch 1/1] input: bcm5974: retract efi-broken suspend_resume
Date: Sun, 14 Mar 2010 10:51:14 +0100
Message-ID: <4B9CB192.8070702@euromail.se>
References: <201003112204.o2BM4wYm013275@imap1.linux-foundation.org> <20100313083544.GC22494@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:55689 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756419Ab0CNJvq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Mar 2010 05:51:46 -0400
In-Reply-To: <20100313083544.GC22494@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Henrik,
> 
> On Thu, Mar 11, 2010 at 02:04:58PM -0800, akpm@linux-foundation.org wrote:
>> From: "Henrik Rydberg" <rydberg@euromail.se>
>>
>> With the recent system-wide improvements on suspend/resume and EFI booting
>> the suspend_resume method of the bcm5974 has broken.  When waking up from
>> the S3 state on the MacBookAir, the trackpad is found in a yet unknown
>> state, unable to switch to the proper multitouch mode.  The result is a
>> frozen touchpad, and a flood of errors of the kind
>>
>> bcm5974: bad trackpad package, length: 8.
>>
>> This patch retracts the reset_resume method altogether, falling back on
>> the generic unbind/rebind functionality of the usb layer until further
>> investigations can be made as how to reset the device when booting from
>> efi.
> 
> Is the driver still broken on EFI without this patch? I was hoping if I
> ignore the patch long enough EFI will get fixed ;)
> 
> Thanks.
> 

The problem persists in all grub-efi flavors of version 1.97. I have not been
able to test later versions.

Henrik





