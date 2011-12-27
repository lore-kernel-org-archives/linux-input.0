From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Input: mpu3050: add of_match table for device-tree probing
Date: Tue, 27 Dec 2011 09:14:31 -0800
Message-ID: <CAOesGMjDUYqP3iFzBz06sxyhjMGD4Znxvps4JxCxky56Hxy-PQ@mail.gmail.com>
References: <1324607992-2919-1-git-send-email-olof@lixom.net>
	<20111223092246.GA7120@core.coreip.homeip.net>
	<CAOesGMiGJmc6FhsDcsmROUgoLD4eDFKK=LE7yYjkJn1O7oiL8Q@mail.gmail.com>
	<4EF9ED4E.6000408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36501 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1L0ROb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Dec 2011 12:14:31 -0500
Received: by ggdk6 with SMTP id k6so7891515ggd.19
        for <linux-input@vger.kernel.org>; Tue, 27 Dec 2011 09:14:31 -0800 (PST)
In-Reply-To: <4EF9ED4E.6000408@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Tue, Dec 27, 2011 at 8:07 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 12/23/2011 09:58 AM, Olof Johansson wrote:
>> Hi,
>>
>> On Fri, Dec 23, 2011 at 1:22 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> Hi Olof,
>>>
>>> On Thu, Dec 22, 2011 at 06:39:52PM -0800, Olof Johansson wrote:
>>>> Adding invn,mpu3050 as the initial id.
>>>>
>>>
>>> I believe you also need to add this to
>>> Documentation/devicetree/bindings/input/
>>
>> For simple i2c devices that only have a name, address and possibly an
>> interrupt, there's no need to document a binding (it hasn't been done
>> in the past for the vast majority of those devices).
>
> But then how do you find out if there is a existing binding for a device
> without searching in the kernel source tree?

That's a silly question, since today that is exactly what you do to
find out, since the Documentation/devicetree isn't the canonical
location for _all_ bindings anyway -- some are in ePAPR, some are in
the old IEEE1275 docs, and some are based on whatever the vendor that
first introduced the device chose (Apple, and some other vendors,
mostly PowerPC ones).

> The binding docs are
> planned to be moved out as they are not Linux specific. There needs to
> be 1 location to find binding information.

Sure. That has nothing to do with this i2c patch though. There has
been some talk in the past about creating one location, in part based
on what is now at devicetree.org.

> I do wonder if we should have a more structured registry or database of
> bindings than free form text files...

I don't think anyone considers the current text files to be a
permanent solution, and something more structured would be a good
idea.

As far as i2c devices go, for now a simple text table of trivial i2c
devices and their known names could be a good idea -- I'll go through
current drivers (including my three recently posted patches) and
create such a list for starter. But I'll do that separately from this
patch, Dmitry -- please apply it as it is.


-Olof
