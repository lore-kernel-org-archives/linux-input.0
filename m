From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Fix endian issues and remove the board specific codes
Date: Fri, 22 May 2015 16:37:29 -0700
Message-ID: <20150522233729.GC20687@dtor-ws>
References: <1431277899-28948-1-git-send-email-hn.chen@weidahitech.com>
 <20150521063316.GA30576@dtor-ws>
 <1A63A1423E772B419A9D2E882CBCF6C401FD49D8@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33686 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbbEVXhd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 19:37:33 -0400
Content-Disposition: inline
In-Reply-To: <1A63A1423E772B419A9D2E882CBCF6C401FD49D8@mail>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Hn,

On Thu, May 21, 2015 at 03:43:08PM +0800, Hn Chen wrote:
> Hi, Dmitry,
> 
> Thanks for your comments. 
> Here are my replies for some comments.
> 
> > +	fw_id = ((fw_chunk_info.chunk_info.version_number >> 12) & 0xF);
> > +	chip_id = (((dev_wdt87xx->sys_param.fw_id) >> 12) & 0xF);
> > +
> > +	if (fw_id != chip_id) {
> > +		wdt87xx_get_sysparam(client, dev_wdt87xx);
> 
> >Why would it be different now?
> This driver is intend to support two controllers, WDT8753 & WDT8756. 
> The chip_id and the the firmware are different for them, so we have to check if 
> The firmware is suitable for this controller.

What I meant is as far as I understand dev_wdt87xx->sys_param.fw_id is
what we've read from the controller when we probed the device. What is
the point in trying to re-read it with wdt87xx_get_sysparam()? Do we
expect it to somehow change?

> 
> > +
> > +	return (unsigned short) y;
> 
> >I think I might have asked this before, by anyway: are we sure that we don't already have this checksum implementation in lib/? And if we don't maybe we should?
> The MISR is a checksum function which the full name is "Multiple Input Signature Register". 
> I checked the kernel library and not found any algorithm like this.
> You mean I have to submit the checksum function into kernel/lib ?

No, you do not have to. I just wanted to make sure we are not
duplicating something that already exists.

> 
> > Can you tell me a bit more about the way device sends touch data? Does it always send all 10 contacts regardless of data in raw_buf[TOUCH_PK_OFFSET_FNGR_NUM]?
> Yes, it always send all 10 contacts data.

I see.

-- 
Dmitry
