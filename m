From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH/RFC]  Resolve 2 year old issue with different demands
	on EVIOCGRAB
Date: Thu, 14 Aug 2008 22:24:53 -0400
Message-ID: <20080815022453.GA9438@anvil.corenet.prv>
References: <18596.58273.713075.332009@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:35125 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYHOCY5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Aug 2008 22:24:57 -0400
Received: by gxk9 with SMTP id 9so3071978gxk.13
        for <linux-input@vger.kernel.org>; Thu, 14 Aug 2008 19:24:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <18596.58273.713075.332009@notabene.brown>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Neil Brown <neilb@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Aug 15, 2008 at 12:02:09PM +1000, Neil Brown wrote:
> 
> I'll let the comments in the patch below to most of the talking.
> This came up because I wanted to use EVIOCGRAB in some code on an
> Openmoko Freerunner, and found that EVIOCGRAG does different things on
> that kernel to elsewhere.  I looked into why, and found that there was
> a good reason but that the issues hadn't been completely resolved.  I
> hope to help resolve the issues so that EVIOCGRAB can behave the same
> everywhere, and still meet everybody's needs.
> 
> I would have Cc:ed to Magnus Vigerlof who wrote the original patch on
> which this is based, but his Email address doesn't appear in lkml.org.
> 

I don't think this is a viable solution - there are other "good"
handlers beisdes evdev, such as rfkill-input, which will still get
disabled by the "lightweight" grabs.

Overall I think it is application's responsibility to not use
multiplexing devices if they use evdev, bit I can consider adding a new
interface (maybe another ioctl) that would disable event delivery though
certain interfaces for a device.

-- 
Dmitry
