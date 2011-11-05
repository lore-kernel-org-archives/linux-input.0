From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] usbtouchscreen: add elo intellitouch 2700 support
Date: Fri, 4 Nov 2011 23:56:31 -0700
Message-ID: <20111105065631.GB31111@core.coreip.homeip.net>
References: <1320315318-15998-1-git-send-email-michael@mgeb.org>
 <1320315318-15998-2-git-send-email-michael@mgeb.org>
 <4EB335A1.7010809@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63232 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1KEG4g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Nov 2011 02:56:36 -0400
Received: by iage36 with SMTP id e36so3464304iag.19
        for <linux-input@vger.kernel.org>; Fri, 04 Nov 2011 23:56:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4EB335A1.7010809@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Michael Gebetsroither <michael@mgeb.org>, linux-input@vger.kernel.org

On Fri, Nov 04, 2011 at 08:45:21AM +0800, Wanlong Gao wrote:
> >  
> >  static struct usbtouch_device_info usbtouch_dev_info[] = {
> > +#ifdef CONFIG_TOUCHSCREEN_USB_ELO
> > +	[DEVTYPE_ELO] = {
> > +		.min_xc		= 0x0,
> > +		.max_xc		= 0x0fff,
> > +		.min_yc		= 0x0,
> > +		.max_yc		= 0x0fff,
> > +		.max_press	= 0xff,
> > +		.rept_size	= 8,
> > +		.read_data	= elo_read_data,
> > +	},
> > +#endif
> 
> 
> Maybe you can move this *dev_info* to end to be consistent with the order of *enum*?
> 

I did that locally and applied to my 3.3 queue; thanks everyone.

-- 
Dmitry
