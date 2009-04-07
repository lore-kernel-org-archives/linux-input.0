From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/3] Matrix keypad
Date: Tue, 7 Apr 2009 19:11:05 +0530
Message-ID: <5d5443650904070641w49ff0a3fo4826833d21032a02@mail.gmail.com>
References: <200807090341.20397.marek.vasut@gmail.com>
	 <5d5443650904070437h3d651f70l7aaab428d0e28d6@mail.gmail.com>
	 <200904071516.51773.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:32915 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbZDGNlG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Apr 2009 09:41:06 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2767821wff.4
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2009 06:41:05 -0700 (PDT)
In-Reply-To: <200904071516.51773.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-input@vger.kernel.org

Hi Marek,

On Tue, Apr 7, 2009 at 6:46 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Tuesday 07 of April 2009 13:37:50 Trilok Soni wrote:
>> Hi Marek Vasut,
>>
>> On Wed, Jul 9, 2008 at 7:11 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> > Hi,
>> > this is the gpio driven matrix keypad. Final version.
>> > I also CCed it to linux-input since it might interest them.
>>
>> Is there any interest for this patch to get mainlined through input
>> subsystem ?
>
> Yes, I'd like to see it mainlined as I need it on some devices. I haven't
> gotten to rewriting it as Dmitry Torokhov requested me to (see his reply in
> linux-input) though.
>

I found only this thread where Dmitry Baryshkov had given some comments.

http://marc.info/?t=121732956800006&r=1&w=2

AFAIK, there is no need to give irqf_sample_random for input drivers
interrupts, as it is already done by input subsystem. Could you please
point to the exact thread where Dmitry Torokhov commented?


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
