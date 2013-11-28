From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: pcips2 - use DEFINE_PCI_DEVICE_TABLE macro
Date: Wed, 27 Nov 2013 23:35:50 -0800
Message-ID: <20131128073550.GA25692@core.coreip.homeip.net>
References: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
 <001b01ceebe0$82141940$863c4bc0$%han@samsung.com>
 <20131128035637.GA11139@core.coreip.homeip.net>
 <005001ceebf2$da2da300$8e88e900$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:55850 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab3K1Hfy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 02:35:54 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so11536343pde.35
        for <linux-input@vger.kernel.org>; Wed, 27 Nov 2013 23:35:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <005001ceebf2$da2da300$8e88e900$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-input@vger.kernel.org

On Thu, Nov 28, 2013 at 01:32:31PM +0900, Jingoo Han wrote:
> On Thursday, November 28, 2013 12:57 PM, Dmitry Torokhov wrote:
> > On Thu, Nov 28, 2013 at 11:21:12AM +0900, Jingoo Han wrote:
> > > This macro is used to create a struct pci_device_id array.
> > 
> > Applied all 3, thank you.
> 
> Please, drop these patches.
> According to the Greg Kroah-Hartman, 
> 
> "Yeah, and it's a horrid macro that deserves to be removed, please don't
> use it in more places.
> 
> Actually, if you could just remove it, that would be best, sorry, I'm
> not going to take these patches."
> 
> So, I will send the patch to remove 'DEFINE_PCI_DEVICE_TABLE' instead.
> Sorry for annoying. :-)

No worries, I dropped them.

Thanks.

-- 
Dmitry
