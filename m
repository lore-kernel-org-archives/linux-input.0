From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Wed, 14 Apr 2010 16:34:02 -0700
Message-ID: <20100414233401.GA12414@core.coreip.homeip.net>
References: <20100329233257.GA85504@jhz.name>
 <20100329233901.GF5864@core.coreip.homeip.net>
 <20100330203911.GA89560@jhz.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62038 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab0DNXeI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 19:34:08 -0400
Received: by gyg13 with SMTP id 13so360971gyg.19
        for <linux-input@vger.kernel.org>; Wed, 14 Apr 2010 16:34:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100330203911.GA89560@jhz.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Hendrik Zab <jan@jhz.name>
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

On Tue, Mar 30, 2010 at 10:39:11PM +0200, Jan-Hendrik Zab wrote:
> On 29/03/10 16:39 -0700, Dmitry Torokhov wrote:
> > Hi Jan-Hendrik,
> > 
> > On Tue, Mar 30, 2010 at 01:32:57AM +0200, Jan-Hendrik Zab wrote:
> > > The entire Sony Vaio VPCZ1 series seems to need the nopnp option set to
> > > get the touchpad working. This patch adds the laptops to the nopnp table
> > > to automatically set it.
> > > 
> > > Signed-off-by: Jan-Hendrik Zab <jan@jhz.name>
> > > 
> > 
> > In what way the PNP data is messed up? Can we get a dmesg of the boot
> > without the patch?
> 
> Attached dmesg output below.
> 

Sorry for the delay. I wonder if we simply do not recognize PNP ID for
the touchpad. Coudl you give me output of:

for i in /sys/bus/pnp/devices/*; do echo $i; cat $i/id; done

and also your dsdt.

Thanks!

-- 
Dmitry
