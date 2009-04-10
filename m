From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 2/3] Matrix keypad
Date: Fri, 10 Apr 2009 12:19:09 +0800
Message-ID: <f17812d70904092119g34e4bafaqf67466f603ff3656@mail.gmail.com>
References: <200807090341.20397.marek.vasut@gmail.com>
	 <5d5443650904070641w49ff0a3fo4826833d21032a02@mail.gmail.com>
	 <200904071559.59668.marek.vasut@gmail.com>
	 <200904091857.27054.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:18003 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbZDJETL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2009 00:19:11 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1125248qwh.37
        for <linux-input@vger.kernel.org>; Thu, 09 Apr 2009 21:19:09 -0700 (PDT)
In-Reply-To: <200904091857.27054.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-input@vger.kernel.org

On Fri, Apr 10, 2009 at 12:57 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Tuesday 07 of April 2009 15:59:59 Marek Vasut wrote:
>> On Tuesday 07 of April 2009 15:41:05 Trilok Soni wrote:
>> > Hi Marek,
>> >
>> > On Tue, Apr 7, 2009 at 6:46 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> > > On Tuesday 07 of April 2009 13:37:50 Trilok Soni wrote:
>> > >> Hi Marek Vasut,
>> > >>
>> > >> On Wed, Jul 9, 2008 at 7:11 AM, Marek Vasut <marek.vasut@gmail.com>
>>
>> wrote:
>> > >> > Hi,
>> > >> > this is the gpio driven matrix keypad. Final version.
>> > >> > I also CCed it to linux-input since it might interest them.
>> > >>
>> > >> Is there any interest for this patch to get mainlined through input
>> > >> subsystem ?
>> > >
>> > > Yes, I'd like to see it mainlined as I need it on some devices. I
>> > > haven't gotten to rewriting it as Dmitry Torokhov requested me to (see
>> > > his reply in linux-input) though.
>> >
>> > I found only this thread where Dmitry Baryshkov had given some comments.
>> >
>> > http://marc.info/?t=121732956800006&r=1&w=2
>> >
>> > AFAIK, there is no need to give irqf_sample_random for input drivers
>> > interrupts, as it is already done by input subsystem. Could you please
>> > point to the exact thread where Dmitry Torokhov commented?
>>
>> http://article.gmane.org/gmane.linux.kernel.input/5551 try here
>
> just wondering ... do you need that driver or something ? or are you willing
> to do the final fixes ? :)

I'll take a look into this. I need this driver to deprecate the original
corgi/poodle keyboard driver, which causes a lot of ugly warnings.
