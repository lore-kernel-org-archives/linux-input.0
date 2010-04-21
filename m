From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Add Sony Vaio VPCZ1 series to the nopnp table
Date: Wed, 21 Apr 2010 00:01:58 -0700
Message-ID: <20100421070158.GM4364@core.coreip.homeip.net>
References: <20100329233257.GA85504@jhz.name>
 <20100329233901.GF5864@core.coreip.homeip.net>
 <20100330203911.GA89560@jhz.name>
 <20100414233401.GA12414@core.coreip.homeip.net>
 <20100419094614.GA27749@jhz.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57042 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab0DUHCG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 03:02:06 -0400
Received: by gwj19 with SMTP id 19so1267233gwj.19
        for <linux-input@vger.kernel.org>; Wed, 21 Apr 2010 00:02:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100419094614.GA27749@jhz.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan-Hendrik Zab <jan@jhz.name>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: torvalds@linux-foundation.org, linux-input@vger.kernel.org

On Mon, Apr 19, 2010 at 11:46:14AM +0200, Jan-Hendrik Zab wrote:
> On 14/04/10 16:34 -0700, Dmitry Torokhov wrote:
> > Sorry for the delay. I wonder if we simply do not recognize PNP ID for
> > the touchpad. Coudl you give me output of:
> > 
> > for i in /sys/bus/pnp/devices/*; do echo $i; cat $i/id; done
> > 
> > and also your dsdt.
> 
> Hey,
> I attached the DSDT and uploaded it to [0] for everyone on the
> mailing list.
> 

*sigh*


                Device (PS2M)
                {
                    Name (_HID, "SNYSYN0003")
                    Name (_CID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()

PNP ID should be 7 characters...

Bjorn, do you think we could substitute CID for HID in case HID is
invalid PNP device ID but CID is valid?

-- 
Dmitry
