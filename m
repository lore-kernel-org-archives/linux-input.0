From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Question: Drivers/input/evdev.c] How to get instance of struct
 evdev in some driver ?
Date: Sat, 2 Aug 2014 23:42:38 -0700
Message-ID: <20140803064238.GA897@core.coreip.homeip.net>
References: <CADYu30-RSdvCmtyn0NmZ4weDsgqhcieV86s9+7OTVJOQEQiSpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:46504 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaHCGmk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Aug 2014 02:42:40 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so8098712pad.8
        for <linux-input@vger.kernel.org>; Sat, 02 Aug 2014 23:42:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADYu30-RSdvCmtyn0NmZ4weDsgqhcieV86s9+7OTVJOQEQiSpA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Aniroop,

On Sun, Aug 03, 2014 at 12:05:11PM +0530, Aniroop Mathur wrote:
> Dear Mr. Torokhov and Linux-Input Community,
> Greetings of the day !! :)
> 
> I am stuck at one point and could not find the solution over internet.
> Can you please help in answering my query below:
> 
> As you know, struct evdev is defined in evdev.c and not in some header file.
> So, Is it possible to get instance of struct evdev in some input
> peripheral driver ?
> If possible, then how can we get it ?
> 
> In the input peripheral driver,
> we can get instance struct input_dev by including input.h file
> and then calling input_allocate_device().
> struct input_dev = input_allocate_device();
> 
> May be evdev is embedded somewhere in input_dev.
> So, can we get the instance of evdev using input_dev ?

Not really. Technically speaking the evdev cam be compiled as a module and it
will not be bound to the input device until later.

Input devices should be ignorant of the input handlers bound to them, they
should just supply event stream and not care about anything else. Also evdev
internal structure is exactly that - internal - and the rest of the kernel
should not try to poke into it.

Thanks.

-- 
Dmitry
