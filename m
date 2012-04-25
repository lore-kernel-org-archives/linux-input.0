From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Memory leak in drivers/hid/hidraw.c
Date: Wed, 25 Apr 2012 14:59:25 +0200
Message-ID: <201204251459.25180.oneukum@suse.de>
References: <AE90C24D6B3A694183C094C60CF0A2F602BB6E1D@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54348 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364Ab2DYND0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 09:03:26 -0400
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F602BB6E1D@saturn3.aculab.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James Woodcock <James.Woodcock@aculab.com>
Cc: linux-input@vger.kernel.org

Am Mittwoch, 25. April 2012, 11:56:57 schrieb James Woodcock:
> Hi,
> 
> I have got a USB HID device which I am talking to with ioctls
> HIDIOCSFEATURE and HIDIOCGFEATURE on Linux 3.3.3, and I think I have
> discovered a memory leak.
> 
> When I call ioctl(fd, HIDIOCGFEATURE...), a long series of things
> happens in the kernel that eventually causes hidraw_report_event() to be
> called to let the user space program know there is data to be retrieved
> by read().  hidraw_report_event() calls kmemdup() to create a copy of
> the data to be returned.  However, I'm never going to call read()
> because
> the data is returned by the ioctl() call.
> 
> So, I think that the main bug I have spotted is that if the user calls
> ioctl(fd, HIODCGFEATURE...), hidraw_report_event() should not be called.
> I'm not really familiar with the code, so I'm not sure what the best fix
> would be.

Please post the full call chain you see.

	Regards
		Oliver
