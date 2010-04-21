From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Add support of Synaptics Clickpad device
Date: Tue, 20 Apr 2010 22:44:55 -0700
Message-ID: <20100421054455.GD4364@core.coreip.homeip.net>
References: <1271257823-23566-1-git-send-email-tiwai@suse.de>
 <1271257823-23566-2-git-send-email-tiwai@suse.de>
 <20100419083221.GB26102@core.coreip.homeip.net>
 <s5hochfpwf6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:40628 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab0DUFpA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 01:45:00 -0400
Content-Disposition: inline
In-Reply-To: <s5hochfpwf6.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 19, 2010 at 12:29:49PM +0200, Takashi Iwai wrote:
> Hi Dmitry,
> 
> At Mon, 19 Apr 2010 01:32:22 -0700,
> Dmitry Torokhov wrote:
> > 
> > Hi Takashi,
> > 
> > On Wed, Apr 14, 2010 at 05:10:22PM +0200, Takashi Iwai wrote:
> > > Add the detection of Synaptics Clickpad device.
> > > The device can be detected a new query command 0x0c.  The clickpad
> > > flags are in cap[0]:4 and cap[1]:0 bits.  But, the driver checks
> > > first the product id bits in the ext capabilities to be sure, so
> > > that it skips the new check on older devices.
> > > 
> > 
> > Instead of looking at the product id, can we check the number of
> > supported extended capabilities queries and act accordingly, like the
> > patch below?
> 
> Yes, it worked.  (Though, I've tested only new machines.)
> 


Seems to be working on older (at least one ;) ) as well.

> 
> > @@ -162,6 +163,16 @@ static int synaptics_capability(struct psmouse *psmouse)
> >  				priv->ext_cap &= 0xff0fff;
> >  		}
> >  	}
> > +
> > +	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 4) {
> > +		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB_0C, cap)) {
> > +			printk(KERN_ERR "Synaptics claims to have extended capability 0x0c,"
> > +			       " but I'm not able to read it.");
> 
> Here missing a newline, BTW.
> 

Fixed. Thank you for testing. I have that patch in 'for-linus' for .34.
Please push your synaptics X changes upstream as well.

-- 
Dmitry
