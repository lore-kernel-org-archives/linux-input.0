From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 3/3] Input: pcips2 - use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 13:32:31 +0900
Message-ID: <005001ceebf2$da2da300$8e88e900$%han@samsung.com>
References: <001901ceebe0$46c96b10$d45c4130$%han@samsung.com>
 <001b01ceebe0$82141940$863c4bc0$%han@samsung.com>
 <20131128035637.GA11139@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52087 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758816Ab3K1EdF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Nov 2013 23:33:05 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY002JJHY8SO90@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Thu, 28 Nov 2013 13:32:32 +0900 (KST)
In-reply-to: <20131128035637.GA11139@core.coreip.homeip.net>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, November 28, 2013 12:57 PM, Dmitry Torokhov wrote:
> On Thu, Nov 28, 2013 at 11:21:12AM +0900, Jingoo Han wrote:
> > This macro is used to create a struct pci_device_id array.
> 
> Applied all 3, thank you.

Please, drop these patches.
According to the Greg Kroah-Hartman, 

"Yeah, and it's a horrid macro that deserves to be removed, please don't
use it in more places.

Actually, if you could just remove it, that would be best, sorry, I'm
not going to take these patches."

So, I will send the patch to remove 'DEFINE_PCI_DEVICE_TABLE' instead.
Sorry for annoying. :-)

Best regards,
Jingoo Han

> 
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/input/serio/pcips2.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
> > index 13062f6..2fff5d4 100644
> > --- a/drivers/input/serio/pcips2.c
> > +++ b/drivers/input/serio/pcips2.c
> > @@ -186,7 +186,7 @@ static void pcips2_remove(struct pci_dev *dev)
> >  	pci_disable_device(dev);
> >  }
> >
> > -static const struct pci_device_id pcips2_ids[] = {
> > +static DEFINE_PCI_DEVICE_TABLE(pcips2_ids) = {
> >  	{
> >  		.vendor		= 0x14f2,	/* MOBILITY */
> >  		.device		= 0x0123,	/* Keyboard */
> > --
> > 1.7.10.4
> >
> >
> 
> --
> Dmitry

