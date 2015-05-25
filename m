From: "Hn Chen" <hn.chen@weidahitech.com>
Subject: RE: [PATCH v3] Fix endian issues and remove the board specific codes
Date: Mon, 25 May 2015 21:23:11 +0800
Message-ID: <1A63A1423E772B419A9D2E882CBCF6C401FD4D0F@mail>
References: <1431277899-28948-1-git-send-email-hn.chen@weidahitech.com> <20150521063316.GA30576@dtor-ws> <1A63A1423E772B419A9D2E882CBCF6C401FD49D8@mail> <20150522233729.GC20687@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2600 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbEYNXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 09:23:23 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Dmitry,

Just send the v4 and please feel free to prompt me a message 
if there is anything wrong.

Remove the fw_id checking redundant codes in this version 
since it has no meaning. I just want to make sure that values are all correct originally.

Best Regard,
Hn.chen

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Saturday, May 23, 2015 7:37 AM
To: Hn Chen
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Fix endian issues and remove the board specific codes

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
> The chip_id and the the firmware are different for them, so we have to 
> check if The firmware is suitable for this controller.

What I meant is as far as I understand dev_wdt87xx->sys_param.fw_id is what we've read from the controller when we probed the device. What is the point in trying to re-read it with wdt87xx_get_sysparam()? Do we expect it to somehow change?

> 
> > +
> > +	return (unsigned short) y;
> 
> >I think I might have asked this before, by anyway: are we sure that we don't already have this checksum implementation in lib/? And if we don't maybe we should?
> The MISR is a checksum function which the full name is "Multiple Input Signature Register". 
> I checked the kernel library and not found any algorithm like this.
> You mean I have to submit the checksum function into kernel/lib ?

No, you do not have to. I just wanted to make sure we are not duplicating something that already exists.

> 
> > Can you tell me a bit more about the way device sends touch data? Does it always send all 10 contacts regardless of data in raw_buf[TOUCH_PK_OFFSET_FNGR_NUM]?
> Yes, it always send all 10 contacts data.

I see.

--
Dmitry
