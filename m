From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] usb: Remove Vernier devices from lsusb and
 hid_ignore_list
Date: Fri, 29 May 2015 11:30:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505291129520.26271@pobox.suse.cz>
References: <555DEEFB.50604@eqware.net> <alpine.LNX.2.00.1505281657330.13817@pobox.suse.cz> <20150528162427.GB23837@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150528162427.GB23837@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dennis O'Brien <dennis.obrien@eqware.net>, jminor@vernier.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 28 May 2015, Greg KH wrote:

> On Thu, May 28, 2015 at 04:58:54PM +0200, Jiri Kosina wrote:
> > On Thu, 21 May 2015, Dennis O'Brien wrote:
> > 
> > > From: Dennis O'Brien <dennis.obrien@eqware.net>
> > > 
> > > Removes Vernier Software & Technology devices from the ldusb
> > > driver and the hid_ignore_list table of the usbhid driver in the
> > > Linux tree.  These devices will now be supported via the hidraw
> > > driver.
> > > 
> > > A user space driver for these devices will be found in the
> > > Go! Software Development Kit from Vernier at
> > > http://www.vernier.com/downloads/software-development-kits/go-sdk/.
> > > These devices are also be supported by the LabQuest2 standalone
> > > interface shown at http://www.vernier.com/products/interfaces/labq2/
> > > and the LoggerPro for Linux software shown at
> > > http://www.vernier.com/downloads/logger-pro-linux/.
> > 
> > Given that the only thing this patch is in principle doing is dropping 
> > device support from ldusb driver, I am not applying it before getting Ack 
> > from Greg (or even seeing Greg merging it himself through his tree).
> > 
> > Greg ... ?
> 
> No objection from me:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> But if you want me to take it in my tree, I can do that too, just
> provide an ack and I will do so.

Thanks. That's fine, I'll take it.

However, Dennis, the patch has been damaged by your mail client (it's 
line-wrapped). Could you please fix that and resend? I'll then take it 
through my tree.

-- 
Jiri Kosina
SUSE Labs
