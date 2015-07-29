From: Bogdan George Stefan <bogdan.george.stefan@gmail.com>
Subject: Re: [PATCH v2] Input: Add generic driver for Zeitec touchscreens
Date: Wed, 29 Jul 2015 14:55:45 +0300
Message-ID: <CAEm+DGWBS=F==8CEq6YheyudJ4C5SEmuh68Gq5Ycj2szGKGA_g@mail.gmail.com>
References: <1432815722-31120-1-git-send-email-bogdan.g.stefan@intel.com>
	<20150530001414.GD7429@dtor-ws>
	<CAEm+DGVPNqWQOP_Tu4ae=pua6N5nC0Q+TkUCDB8tKzaX43iYNw@mail.gmail.com>
	<20150612004518.GE20581@dtor-pixel>
	<CAEm+DGXAM_Rq7wSk3hEFivxAcv6efDv248VkrnOWhy8qnqhnwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33290 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbbG2Lzr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 07:55:47 -0400
In-Reply-To: <CAEm+DGXAM_Rq7wSk3hEFivxAcv6efDv248VkrnOWhy8qnqhnwA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bogdan George Stefan <bogdan.g.stefan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Purdila Octavian <octavian.purdila@intel.com>

Dimitry,

Please let me know if there is anything I can provide for this driver.

Thank you,
Bogdan

On Thu, Jun 18, 2015 at 11:39 AM, Bogdan George Stefan
<bogdan.george.stefan@gmail.com> wrote:
> Dimitry,
>
> You can control how many fingers work on a device via the firmware
> that you load. I've asked the Zeitec guys to confirm. So, to answer
> your question, if you want to build a system with a touch that
> supports only 7 fingers, you can pick any part from Zeitec and give
> the supplier the right firmware.
>
> Thank you,
> Bogdan Stefan
>
> On Fri, Jun 12, 2015 at 3:45 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> Hi Bogdan,
>>
>> On Tue, Jun 02, 2015 at 10:43:01AM +0300, Bogdan George Stefan wrote:
>> > Dimitry,
>> >
>> > I know 0xB2 should provide that information according to the
>> > datasheet, however here is what Zeitec guys had to say when I asked
>> > them why it does not work:
>> >
>> > "0xB2 is deprecated.
>> > It only supports in Zet6221/31 serious but zet9172/zet6273."
>> >
>> > If you like, I can attach my conversation with them.
>> >
>>
>> Not really, but I would like to understand how the part selection works.
>> Are they the same parts or different parts? Let's say you want to build
>> a system and you want part that reports up to 7 contacts. How do you
>> communicate this to the supplier? The number of contacts - is it
>> controller by the config file you load into the controller, or they have
>> separate parts for different contact count or what?
>>
>> Thanks.
>>
>> --
>> Dmitry
