From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Wed, 5 May 2010 17:03:07 -0600
Message-ID: <201005051703.08109.bjorn.helgaas@hp.com>
References: <20100329233257.GA85504@jhz.name> <20100419094614.GA27749@jhz.name> <20100421070158.GM4364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:1400 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab0EEXDS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 19:03:18 -0400
In-Reply-To: <20100421070158.GM4364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jan-Hendrik Zab <jan@jhz.name>, torvalds@linux-foundation.org, linux-input@vger.kernel.org

On Wednesday, April 21, 2010 01:01:58 am Dmitry Torokhov wrote:
> On Mon, Apr 19, 2010 at 11:46:14AM +0200, Jan-Hendrik Zab wrote:
> > On 14/04/10 16:34 -0700, Dmitry Torokhov wrote:
> > > Sorry for the delay. I wonder if we simply do not recognize PNP ID for
> > > the touchpad. Coudl you give me output of:
> > > 
> > > for i in /sys/bus/pnp/devices/*; do echo $i; cat $i/id; done
> > > 
> > > and also your dsdt.
> > 
> > Hey,
> > I attached the DSDT and uploaded it to [0] for everyone on the
> > mailing list.
> > 
> 
> *sigh*
> 
> 
>                 Device (PS2M)
>                 {
>                     Name (_HID, "SNYSYN0003")
>                     Name (_CID, EisaId ("PNP0F13"))
>                     Name (_CRS, ResourceTemplate ()
> 
> PNP ID should be 7 characters...

It'd be nice to know how Windows handles this situation.  If we can
tell from the Device Manager that Windows actually exposes this
invalid _HID somehow, we might want to think about handling it
similarly in Linux.

If Linux completely ignores invalid _HIDs like this, we can only
use the _CID to bind a driver.  If a device doesn't supply a _CID,
we'd be unable to bind a driver at all.

Bjorn
