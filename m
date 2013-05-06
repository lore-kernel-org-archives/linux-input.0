From: majianpeng <majianpeng@gmail.com>
Subject: Re: [BUG] suspicious RCU usage
Date: Mon, 06 May 2013 09:10:31 +0800
Message-ID: <51870307.2020107@gmail.com>
References: <51835EFD.2070403@gmail.com> <CAN+gG=F5O_EAr8P2Zgy7w39JcBJwWVzUSUaj0s6U0C6SRP6tYA@mail.gmail.com> <alpine.LNX.2.00.1305031022260.11002@pobox.suse.cz> <518392FE.4000302@gmail.com> <alpine.LNX.2.00.1305031324590.11002@pobox.suse.cz> <20130503155113.GB5567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:44372 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3EFBKk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 21:10:40 -0400
Received: by mail-pd0-f176.google.com with SMTP id x10so1723310pdj.7
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 18:10:39 -0700 (PDT)
In-Reply-To: <20130503155113.GB5567@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On 05/03/2013 11:51 PM, Dmitry Torokhov wrote:
> On Fri, May 03, 2013 at 01:28:25PM +0200, Jiri Kosina wrote:
>> On Fri, 3 May 2013, majianpeng wrote:
>>
>>>>> Jiri, we had a similar bug in the RH bugzilla:
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=958935
>>>>>
>>>>> Are these two reports potentially fixed by your patch "HID: protect
>>>>> hid_debug_list" (https://patchwork.kernel.org/patch/2453931/)
>>>>> If so, maybe we should send it to stable as well...
>>>> I actually believe this bug is *introduced* by that patch :) All the 
>>>> reports were with the kernel containing it, right?
>>>>
>>>> Does the patch below fix it, please?
>> [ ... snip ... ]
>>> Add your patch.Found the following message:
>>> [  150.908051] ======================================================
>>> [  150.908053] [ INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected ]
>>> [  150.908056] 3.9.0+ #102 Not tainted
>> Right, oh well, I missed that scenario.
> This looks good to me.
>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
It's  all good for me.

Thanks!
Jianpeng Ma
