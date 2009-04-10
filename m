From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/3] Matrix keypad
Date: Fri, 10 Apr 2009 15:05:52 +0800
Message-ID: <f17812d70904100005p6e6ab8f9n8fb07dfbe465802d@mail.gmail.com>
References: <200807090341.20397.marek.vasut@gmail.com>
	 <200904091857.27054.marek.vasut@gmail.com>
	 <f17812d70904092119g34e4bafaqf67466f603ff3656@mail.gmail.com>
	 <200904100752.24418.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:57907 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762935AbZDJHFy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2009 03:05:54 -0400
Received: by qyk16 with SMTP id 16so2075345qyk.33
        for <linux-input@vger.kernel.org>; Fri, 10 Apr 2009 00:05:52 -0700 (PDT)
In-Reply-To: <200904100752.24418.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-input@vger.kernel.org

On Fri, Apr 10, 2009 at 1:52 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Friday 10 of April 2009 06:19:09 Eric Miao wrote:
>> On Fri, Apr 10, 2009 at 12:57 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> > On Tuesday 07 of April 2009 15:59:59 Marek Vasut wrote:
>> >> On Tuesday 07 of April 2009 15:41:05 Trilok Soni wrote:
>> >> > Hi Marek,
>> >> >
>> >> > On Tue, Apr 7, 2009 at 6:46 PM, Marek Vasut <marek.vasut@gmail.com>
> wrote:
>> >> > > On Tuesday 07 of April 2009 13:37:50 Trilok Soni wrote:
>> >> > >> Hi Marek Vasut,
>> >> > >>
>> >> > >> On Wed, Jul 9, 2008 at 7:11 AM, Marek Vasut <marek.vasut@gmail.com>
>> >>
>> >> wrote:
>> >> > >> > Hi,
>> >> > >> > this is the gpio driven matrix keypad. Final version.
>> >> > >> > I also CCed it to linux-input since it might interest them.
>> >> > >>
>> >> > >> Is there any interest for this patch to get mainlined through input
>> >> > >> subsystem ?
>> >> > >
>> >> > > Yes, I'd like to see it mainlined as I need it on some devices. I
>> >> > > haven't gotten to rewriting it as Dmitry Torokhov requested me to
>> >> > > (see his reply in linux-input) though.
>> >> >
>> >> > I found only this thread where Dmitry Baryshkov had given some
>> >> > comments.
>> >> >
>> >> > http://marc.info/?t=121732956800006&r=1&w=2
>> >> >
>> >> > AFAIK, there is no need to give irqf_sample_random for input drivers
>> >> > interrupts, as it is already done by input subsystem. Could you please
>> >> > point to the exact thread where Dmitry Torokhov commented?
>> >>
>> >> http://article.gmane.org/gmane.linux.kernel.input/5551 try here
>> >
>> > just wondering ... do you need that driver or something ? or are you
>> > willing to do the final fixes ? :)
>>
>> I'll take a look into this. I need this driver to deprecate the original
>> corgi/poodle keyboard driver, which causes a lot of ugly warnings.
>
> That'd be great, I need it on two devices too. I'm a little frightened about
> it's speed though as it's iterating over all the GPIOs, but there is a
> possibility to read a whole bunch of GPIOs at one time now, right ?
>

I'm not sure if Jaya Kumar's batch gpio patches have been merged or
not. Performance should not be that sensitive for keypad :)

-- 
Cheers
- eric
