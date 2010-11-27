From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 18:04:57 +0100
Message-ID: <4CF13A39.2080709@euromail.se>
References: <4CEE6D2A.9040408@euromail.se> <20101127081515.GD28667@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:58792 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752944Ab0K0RFS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 12:05:18 -0500
In-Reply-To: <20101127081515.GD28667@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On 11/27/2010 09:15 AM, Dmitry Torokhov wrote:

> On Thu, Nov 25, 2010 at 03:05:30PM +0100, Henrik Rydberg wrote:
>> Hi,
>>
>> Reading through this thread, I think Dmitry's EVIOCGDEVTYPE is a great way to
>> resolve this. We should expect some changes in userland to correctly interpret
>> direct/indirect devices, and this seems a good way to go. The physical size of
>> the surface would also be great to retrieve this way. The recent resolution
>> addition is semantically odd, since we have only one physical surface, not one
>> per axes.
> 
> 1 for each of 2 major axes, at least. We might need resolution for
> pressure/distance as well, although it certainly won't be unit/mm ;)


Alright, neither abstraction is perfect, but I agree the resolution has its
virtues. :-)

>>
>> In short, my suggestion is to build a struct for device properties, like this:
>>
>> struct input_devinfo {
>> 	__u32	type;			/* bitmask of possible dev types */
>> 	__u32	capabilities;		/* bitmask of special device caps */
>> 	__u32	phys_abs_width;		/* physical width of surface (mm) */
>> 	__u32	phys_abs_height;	/* physical height of surface (mm) */
>> };
>>
>> Adding more stuff here seems plausible. For instance, special devices like
>> clickpads or integrated buttons would fit nicely in capabilities. The call would
>> be very similar, like
>>
>> 	ioctl(fd, EVIOCGDEVINFO, &info);
>>
> 
> Yep, should work, although the dimensions could be retrieved from
> absinfo.
> 


I'll see if I can fit that (minus physical dimensions) into the upcoming patch sets.

Cheers,
Henrik
