From: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: [PATCH] HID: fix data access in implement()
Date: Tue, 9 Jul 2013 19:59:44 +0100
Message-ID: <20130709185944.GA14591@joana>
References: <alpine.LNX.2.00.1307092042190.26857@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:64962 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab3GIS7s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jul 2013 14:59:48 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so5143898wes.32
        for <linux-input@vger.kernel.org>; Tue, 09 Jul 2013 11:59:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1307092042190.26857@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Adam Kropelin <akropel1@rochester.rr.com>, Grant Grundler <grundler@parisc-linux.org>, linux-input@vger.kernel.org

Hi Jiri,

* Jiri Kosina <jkosina@suse.cz> [2013-07-09 20:44:27 +0200]:

> implement() is setting bytes in LE data stream. In case the data
> is not aligned to 64bits, it reads past the allocated buffer. It
> doesn't really change any value there (it's properly bitmasked), but
> in case that this read past the boundary hits a page boundary, pagefault
> happens when accessing 64bits of 'x' in implement(), and kernel oopses.
> 
> This happens much more often when numbered reports are in use, as the
> initial 8bit skip in the buffer makes the whole process work on values
> which are not aligned to 64bits.
> 
> This problem dates back to attempts in 2005 and 2006 to make implement()
> and extract() as generic as possible, and even back then the problem
> was realized by Adam Kroperlin, but falsely assumed to be impossible
> to cause any harm:
> 
>   http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg47690.html
> 
> I have made several attempts at fixing it "on the spot" directly in
> implement(), but the results were horrible; the special casing for processing
> last 64bit chunk and switching to different math makes it unreadable mess.
> 
> I therefore took a path to allocate a few bytes more which will never make
> it into final report, but are there as a cushion for all the 64bit math
> operations happening in implement() and extract().
> 
> All callers of hid_output_report() are converted at the same time to allocate
> the buffer by newly introduced hid_alloc_report_buf() helper.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/hid/hid-core.c            |   19 ++++++++++++++++++-
>  drivers/hid/hid-logitech-dj.c     |   12 ++++++++++--
>  drivers/hid/hid-picolcd_debugfs.c |   10 +++++++++-
>  drivers/hid/usbhid/hid-core.c     |    4 ++--
>  include/linux/hid.h               |    1 +
>  net/bluetooth/hidp/core.c         |   14 +++++++++-----
>  6 files changed, 49 insertions(+), 11 deletions(-)

For the bluetooth part:

Acked-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

	Gustavo
