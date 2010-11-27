From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 00:15:16 -0800
Message-ID: <20101127081515.GD28667@core.coreip.homeip.net>
References: <4CEE6D2A.9040408@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48540 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0K0IPW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 03:15:22 -0500
Received: by iwn35 with SMTP id 35so338638iwn.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 00:15:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CEE6D2A.9040408@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Thu, Nov 25, 2010 at 03:05:30PM +0100, Henrik Rydberg wrote:
> Hi,
> 
> Reading through this thread, I think Dmitry's EVIOCGDEVTYPE is a great way to
> resolve this. We should expect some changes in userland to correctly interpret
> direct/indirect devices, and this seems a good way to go. The physical size of
> the surface would also be great to retrieve this way. The recent resolution
> addition is semantically odd, since we have only one physical surface, not one
> per axes.

1 for each of 2 major axes, at least. We might need resolution for
pressure/distance as well, although it certainly won't be unit/mm ;)

> 
> In short, my suggestion is to build a struct for device properties, like this:
> 
> struct input_devinfo {
> 	__u32	type;			/* bitmask of possible dev types */
> 	__u32	capabilities;		/* bitmask of special device caps */
> 	__u32	phys_abs_width;		/* physical width of surface (mm) */
> 	__u32	phys_abs_height;	/* physical height of surface (mm) */
> };
> 
> Adding more stuff here seems plausible. For instance, special devices like
> clickpads or integrated buttons would fit nicely in capabilities. The call would
> be very similar, like
> 
> 	ioctl(fd, EVIOCGDEVINFO, &info);
> 

Yep, should work, although the dimensions could be retrieved from
absinfo.

-- 
Dmitry
