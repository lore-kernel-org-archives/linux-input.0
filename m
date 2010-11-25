From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Thu, 25 Nov 2010 15:05:30 +0100
Message-ID: <4CEE6D2A.9040408@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:59939 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092Ab0KYOFo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Nov 2010 09:05:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

Hi,

Reading through this thread, I think Dmitry's EVIOCGDEVTYPE is a great way to
resolve this. We should expect some changes in userland to correctly interpret
direct/indirect devices, and this seems a good way to go. The physical size of
the surface would also be great to retrieve this way. The recent resolution
addition is semantically odd, since we have only one physical surface, not one
per axes.

In short, my suggestion is to build a struct for device properties, like this:

struct input_devinfo {
	__u32	type;			/* bitmask of possible dev types */
	__u32	capabilities;		/* bitmask of special device caps */
	__u32	phys_abs_width;		/* physical width of surface (mm) */
	__u32	phys_abs_height;	/* physical height of surface (mm) */
};

Adding more stuff here seems plausible. For instance, special devices like
clickpads or integrated buttons would fit nicely in capabilities. The call would
be very similar, like

	ioctl(fd, EVIOCGDEVINFO, &info);

What do you think?

Cheers,
Henrik
